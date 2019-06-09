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

void renderRJ45(int x, int y) {
    for (int xx = 0;xx < rj45Width; xx++) {
        for (int yy = 0;yy < rj45Height;yy++) {
            int real_x = xx + x;
            int real_y = yy + y;
            int index = xx / 8;
            int offset = xx % 8;
            if (rj45[yy * rj45Stride + index] & (1 << (7 - offset))) {
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

void renderTextCenter(int x, int y, char *str) {
    int len = strlen(str);
    renderText(x - len * fontWidth / 2, y - fontHeight / 2, str);
}

// Wu's algorithm
void plot(int x, int y, float c) {
    actualFrame[x * BYTES_PER_PIXEL + y * actualStride + 0] = 255 * c;
    actualFrame[x * BYTES_PER_PIXEL + y * actualStride + 1] = 255 * c;
    actualFrame[x * BYTES_PER_PIXEL + y * actualStride + 2] = 255 * c;
}

float ipart(float x) {
    return (float)((int)x);
}

float fpart(float x) {
    return x - ipart(x);
}

float rfpart(float x) {
    return 1 - fpart(x);
}

int abs(int x) {
    return x < 0 ? (-x) : x;
}

void renderLine(int x0, int y0, int x1, int y1) {
    int steep = abs(y1 - y0) > abs(x1 - x0);
    if (steep) {
        int temp = x0;
        x0 = y0;
        y0 = temp;

        temp = x1;
        x1 = y1;
        y1 = temp;
    }
    if (x0 > x1) {
        int temp = x0;
        x0 = x1;
        x1 = temp;

        temp = y0;
        y0 = y1;
        y1 = temp;
    }
    int dx = x1 - x0;
    int dy = y1 - y0;
    float gradient = dy / dx;
    if (dx == 0) {
        gradient = 1.0;
    }
    float xend = x0 + 1;
    float yend = y0 + gradient * (xend - x0);
    float xgap = rfpart(x0 + 0.5);
    float xpx11 = xend;
    float ypx11 = ipart(yend);
    if (steep) {
        plot(ypx11, xpx11, rfpart(yend) * xgap);
        plot(ypx11 + 1, xpx11, fpart(yend) * xgap);
    } else {
        plot(xpx11, ypx11, rfpart(yend) * xgap);
        plot(xpx11, ypx11 + 1, fpart(yend) * xgap);
    }
    float intery = yend + gradient;

    xend = x1 + 1;
    yend = y1 + gradient * (xend - x1);
    xgap = fpart(x1 + 0.5);
    float xpx12 = xend;
    float ypx12 = ipart(yend);
    if (steep) {
        plot(ypx12, xpx12, rfpart(yend) * xgap);
        plot(ypx12 + 1, xpx12, fpart(yend) * xgap);
    } else {
        plot(xpx12, ypx12, rfpart(yend) * xgap);
        plot(xpx12, ypx12 + 1, fpart(yend) * xgap);
    }

    if (steep) {
        for (int x = xpx11 + 1;x <= xpx12 - 1; x++) {
            plot(ipart(intery), x, rfpart(intery));
            plot(ipart(intery) + 1, x, fpart(intery));
            intery = intery + gradient;
        }
    } else {
        for (int x = xpx11 + 1;x <= xpx12 - 1; x++) {
            plot(x, ipart(intery), rfpart(intery));
            plot(x, ipart(intery) + 1, fpart(intery));
            intery = intery + gradient;
        }
    }
}


void renderRectangle(int x, int y, int width, int height) {
    renderLine(x, y, x + width, y);
    renderLine(x + width, y, x + width, y + height);
    renderLine(x + width, y + height, x, y + height);
    renderLine(x, y + height, x, y);
}

void renderCircle(int x, int y, int radius) {
    for (int xx = -radius;xx <= radius; xx++) {
        for (int yy = -radius;yy <= radius;yy++) {
            int real_x = xx + x;
            int real_y = yy + y;
            if (xx * xx + yy * yy <= radius * radius) {
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

char rowBuffer[256];
char ipBuffer[256];
char nexthopBuffer[256];
char routingTableBuffer[256];

// ring buffer
struct Points {
    int port;
    int rx;
    int y;
} points[256];
int pointCount = 256;
int pointBegin = 0;
int pointEnd = 0;

void renderData(struct Route *routingTable, u32 routingTableSize, char *stats, u32 time, int *flow) {
    for (int i = 0;i < 4;i++) {
        if(flow[i]) {
            // RX
            if (pointEnd + 1 != pointBegin) {
                points[pointEnd].port = i;
                points[pointEnd].rx = 1;
                points[pointEnd].y = 0;
                pointEnd = (pointEnd + 1) % pointCount;
            }
        }
    }


    clearFrameBuffer(0, 3 * fontHeight);
    renderText(0, 0, stats);

    static u32 window = 0;
    const int WINDOW_SIZE = 3;
    clearFrameBuffer(fontHeight * 3, fontHeight * (WINDOW_SIZE + 3));

    static u32 lastTime = 0;
    if ((time % 5) == 0 && time != lastTime) {
        window ++;
        if (window + WINDOW_SIZE > routingTableSize) {
            window = 0;
        }
    }
    lastTime = time;

    sprintf(routingTableBuffer, "Routing Table(%d-%d):", window + 1, window + WINDOW_SIZE);
    renderText(0, 2 * fontHeight, routingTableBuffer);

    for (int i = window;i < routingTableSize && i < window + WINDOW_SIZE;i++) {
        int y = fontHeight * (i - window + 3);
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

    int rectWidth = 670;
    int spacing = 20;
    int beginX = (actualWidth - 4 * rj45Width - (4 - 1) * spacing) / 2;
    int arrowSize = 10;
    int rj45Y = 400;
    int routerBot = 300;
    int pointRadius = 2;
    int pointOffset = 5;

    renderRectangle((actualWidth - rectWidth) / 2, 200, rectWidth, 100);
    renderTextCenter(actualWidth / 2, 250, "Router");

    for (int i = pointBegin;i != pointEnd;i = (i + 1) % pointCount) {
        if (points[i].y >= rj45Y - routerBot - arrowSize - pointOffset) {
            pointBegin = (i + 1) % pointCount;
        } else {
            points[i].y += 5;
        }
    }

    for (int i = 0;i < 4;i++) {
        int curX = beginX + (rj45Width + spacing) * i;
        int endX = curX + rj45Width;

        renderRJ45(curX, rj45Y);

        int rxX = (curX * 5 + endX * 4) / 9;
        int txX = (curX * 4 + endX * 5) / 9;

        for (int i = routerBot + pointOffset;i < rj45Y;i++) {
            for (int j = rxX - pointOffset - pointRadius;j <= rxX - pointOffset + pointRadius;j++) {
                actualFrame[j * BYTES_PER_PIXEL + i * actualStride + 0] = 255;
                actualFrame[j * BYTES_PER_PIXEL + i * actualStride + 1] = 255;
                actualFrame[j * BYTES_PER_PIXEL + i * actualStride + 2] = 255;
            }
        }
        renderLine(rxX, routerBot, rxX, rj45Y);
        renderLine(rxX, routerBot, rxX - arrowSize, routerBot + arrowSize);
        renderLine(txX, routerBot, txX, rj45Y);
        renderLine(txX, rj45Y, txX + arrowSize, rj45Y - arrowSize);

        for (int j = pointBegin;j != pointEnd;j = (j + 1) % pointCount) {
            if (points[j].port == i) {
                int x = points[j].rx ? (rxX - pointOffset) : (txX + pointOffset);
                int y = points[j].rx ? (rj45Y - points[j].y) : (routerBot + points[j].y);
                renderCircle(x, y, pointRadius);
            }
        }
    }

    Xil_DCacheFlushRange((u32) actualFrame, FRAME_BYTES);
}
