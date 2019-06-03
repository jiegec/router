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

    printf("Display Started\n");
}

void renderData(struct Route *routingTable, u32 routingTableSize) {

}
