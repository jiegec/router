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
#include "font8x8_basic.h"

XAxiVdma_Config *vdmaConfig;
XIicPs iicInstance;
XGpio gpioInstance;
DisplayCtrl dispCtrl;
XAxiVdma vdmaInstance;

#define BYTES_PER_PIXEL 3
#define FRAME_BYTES (1920*1080*BYTES_PER_PIXEL)
#define FRAME_STRIDE (1920*BYTES_PER_PIXEL)
#define ROUTE_SIZE 16

u8 frameBuf[DISPLAY_NUM_FRAMES][FRAME_BYTES] __attribute__ ((aligned(64)));
u8 *pFrames[DISPLAY_NUM_FRAMES]; //array of pointers to the frame buffers
u32 actualWidth, actualHeight, actualStride;
u8 *actualFrame;

void clearFrameBuffer() {
    // all white
    u32 offset = 0;
    for (int i = 0;i < actualHeight;i++) {
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

    clearFrameBuffer();
    Xil_DCacheFlushRange((u32) actualFrame, FRAME_BYTES);
}

void sprintIP(u32 ip, char *buffer) {
    int p1 = ip >> 24, p2 = (ip >> 16) & 0xFF, p3 = (ip >> 8) & 0xFF, p4 = ip & 0xFF;
    sprintf(buffer, "%d.%d.%d.%d", p1, p2, p3, p4);
}

void renderChar(int x, int y, int size, char ch) {
    for (int xx = 0;xx < size; xx++) {
        for (int yy = 0;yy < size;yy++) {
            int real_x = xx + x;
            int real_y = yy + y;
            if (font8x8_basic[ch][(yy * 8) / ROUTE_SIZE] & (1 << (xx * 8 / ROUTE_SIZE))) {
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

void renderText(int x, int y, int size, char *str) {
    int len = strlen(str);
    for (int i = 0;i < len;i++) {
        renderChar(x + i * size, y, size, str[i]);
    }
}

void renderData(struct Route *routingTable, u32 routingTableSize) {
    clearFrameBuffer();
    renderText(0, 0, ROUTE_SIZE, "Routing Table:");
    for (int i = 0;i < routingTableSize;i++) {
        int y = ROUTE_SIZE * (i + 1);
        char rowBuffer[128];
        char ipBuffer[64];
        char nexthopBuffer[64];
        sprintIP(routingTable[i].ip, ipBuffer);
        int prefix = 0;
        int netmask = routingTable[i].netmask;
        for (;netmask;netmask<<=1, prefix++);
        sprintIP(routingTable[i].nexthop, nexthopBuffer);
        sprintf(rowBuffer, "%d: %s/%d via %s metric %d dev port%d", i + 1, ipBuffer, prefix, nexthopBuffer, routingTable[i].metric, routingTable[i].port);

        for (int j = 0;j < strlen(rowBuffer);j++) {
            int x = ROUTE_SIZE * j;
            renderChar(x, y, ROUTE_SIZE, rowBuffer[j]);
        }
    }

    Xil_DCacheFlushRange((u32) actualFrame, FRAME_BYTES);
}
