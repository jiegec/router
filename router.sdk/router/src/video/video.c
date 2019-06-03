/*
 * video.c
 *
 *  Created on: Jun 3, 2019
 *      Author: oslab
 */

#include <stdio.h>
#include "video.h"
#include "display_ctrl/display_ctrl.h"
#include "xil_types.h"
#include "xil_cache.h"
#include "xparameters.h"
#include "i2c/PS_i2c.h"
#include "xgpio.h"
#include "sleep.h"

#include "font.h"

XAxiVdma_Config *vdmaConfig;
XIicPs iicInstance;
XGpio gpioInstance;
DisplayCtrl dispCtrl;
XAxiVdma vdmaInstance;

#define BYTES_PER_PIXEL 3
#define FRAME_BYTES (1920*1080*BYTES_PER_PIXEL)
#define FRAME_STRIDE (1920*BYTES_PER_PIXEL)

u8 frameBuf[DISPLAY_NUM_FRAMES][FRAME_BYTES] __attribute__ ((aligned(64)));
u8 *pFrames[DISPLAY_NUM_FRAMES]; //array of pointers to the frame buffers
u32 actualWidth, actualHeight, actualStride;
u8 *actualFrame;

void clearFrameBuffer(int fromRow, int toRow) {
    // all white
    u32 offset = 0;
    if (fromRow < 0) {
        fromRow = 0;
    }
    if (toRow > actualHeight) {
        toRow = actualHeight;
    }
    for (int i = fromRow;i < toRow;i++) {
        for (int j = 0;j < actualWidth;j++) {
            actualFrame[j * BYTES_PER_PIXEL + i * actualStride + 0] = 255;
            actualFrame[j * BYTES_PER_PIXEL + i * actualStride + 1] = 255;
            actualFrame[j * BYTES_PER_PIXEL + i * actualStride + 2] = 255;
        }
    }
}

void initVideo() {
    for (int i = 0;i < DISPLAY_NUM_FRAMES;i++) {
        pFrames[i] = frameBuf[i];
    }

    i2c_init(&iicInstance, XPAR_XIICPS_0_DEVICE_ID, 100000);
	XGpio_Initialize(&gpioInstance, XPAR_AXI_GPIO_2_DEVICE_ID);   //initialize GPIO IP
	XGpio_SetDataDirection(&gpioInstance, 1, 0x0);            //set GPIO as output
	XGpio_DiscreteWrite(&gpioInstance, 1, 0x0);               //set GPIO output value to 0
	usleep(50000);
	XGpio_DiscreteWrite(&gpioInstance, 1, 0x1);
	i2c_reg8_write(&iicInstance,0x72>>1,0x08,0x35);
	i2c_reg8_write(&iicInstance,0x7a>>1,0x2f,0x00);

    printf("HDMI Output Enabled\n");

	vdmaConfig = XAxiVdma_LookupConfig(XPAR_AXIVDMA_0_DEVICE_ID);
    XAxiVdma_CfgInitialize(&vdmaInstance, vdmaConfig, vdmaConfig->BaseAddress);

    printf("VDMA Initialized\n");

    DisplayInitialize(&dispCtrl, &vdmaInstance, XPAR_VTC_0_DEVICE_ID, XPAR_AXI_DYNCLK_0_BASEADDR, pFrames, FRAME_STRIDE);
    DisplayStart(&dispCtrl);

    printf("Display Started (%ld x %ld)\n", dispCtrl.vMode.width, dispCtrl.vMode.height);

    actualHeight = dispCtrl.vMode.height;
    actualWidth = dispCtrl.vMode.width;
    actualStride = dispCtrl.stride;
    actualFrame = dispCtrl.framePtr[dispCtrl.curFrame];

    clearFrameBuffer(0, actualHeight);
    Xil_DCacheFlushRange((u32) actualFrame, FRAME_BYTES);
}

void sprintIP(u32 ip, char *buffer) {
    int p1 = ip >> 24, p2 = (ip >> 16) & 0xFF, p3 = (ip >> 8) & 0xFF, p4 = ip & 0xFF;
    sprintf(buffer, "%d.%d.%d.%d", p1, p2, p3, p4);
}

void renderChar(int x, int y, char ch) {
    for (int xx = 0;xx < fontWidth; xx++) {
        for (int yy = 0;yy < fontHeight;yy++) {
            int real_x = xx + x;
            int real_y = yy + y;
            int index = xx / 8;
            int offset = xx % 8;
            //int fontNum = 0;
            //for (int i = 0;i < fontSpan;i++) {
                //fontNum |= font[ch * fontHeight * fontSpan + yy * fontSpan + i] << (8 * i);
            //}
            if (font[ch * fontHeight * fontSpan + yy * fontSpan + index] & (1 << (7 - offset))) {
                actualFrame[real_x * BYTES_PER_PIXEL + real_y * actualStride + 0] = 0;
                actualFrame[real_x * BYTES_PER_PIXEL + real_y * actualStride + 1] = 0;
                actualFrame[real_x * BYTES_PER_PIXEL + real_y * actualStride + 2] = 0;
            } else {
                actualFrame[real_x * BYTES_PER_PIXEL + real_y * actualStride + 0] = 255;
                actualFrame[real_x * BYTES_PER_PIXEL + real_y * actualStride + 1] = 255;
                actualFrame[real_x * BYTES_PER_PIXEL + real_y * actualStride + 2] = 255;
            }
        }
    }
}

void renderText(int x, int y, char *str) {
    int len = strlen(str);
    for (int i = 0;i < len;i++) {
        renderChar(x + i * fontWidth, y, str[i]);
    }
}

char rowBuffer[256];
char ipBuffer[256];
char nexthopBuffer[256];
void renderData(struct Route *routingTable, u32 routingTableSize, char *stats, u32 time) {
    clearFrameBuffer(0, 3 * fontHeight);
    renderText(0, 0, stats);
    renderText(0, 2 * fontHeight, "Routing Table:");

    // lazy flush
    static u32 lastRoutingTableSize = 0;
    clearFrameBuffer(fontHeight * 3, fontHeight * (lastRoutingTableSize + 3));
    lastRoutingTableSize = routingTableSize;

    for (int i = 0;i < routingTableSize;i++) {
        int y = fontHeight * (i + 3);
        sprintIP(routingTable[i].ip, ipBuffer);
        int prefix = 0;
        int netmask = routingTable[i].netmask;
        for (;netmask;netmask<<=1, prefix++);
        sprintIP(routingTable[i].nexthop, nexthopBuffer);
        sprintf(rowBuffer, "%s/%d via %s metric %ld port %ld timer %ld", ipBuffer, prefix, nexthopBuffer, routingTable[i].metric, routingTable[i].port, time - routingTable[i].updateTime);

        for (int j = 0;j < strlen(rowBuffer);j++) {
            int x = fontWidth * j;
            renderChar(x, y, rowBuffer[j]);
        }
    }

    Xil_DCacheFlushRange((u32) actualFrame, FRAME_BYTES);
}
