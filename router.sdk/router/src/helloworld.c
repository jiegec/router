/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xllfifo.h"
#include "xstatus.h"

int main()
{
    XLlFifo fifoInstance;
    XLlFifo_Config *Config;
    int Status;
    u32 receiveLength;
    u32 i;
    u32 buffer[2048];

    init_platform();

    print("Lookup config\n\r");
    Config = XLlFfio_LookupConfig(XPAR_AXI_FIFO_0_DEVICE_ID);
    if (!Config) {
        print("No config found\n\r");
        goto fail;
    }

    Status = XLlFifo_CfgInitialize(&fifoInstance, Config, Config->BaseAddress);
    if (Status != XST_SUCCESS) {
        print("Init failed\n\r");
        goto fail;
    }

	XLlFifo_IntClear(&fifoInstance,0xffffffff);

    print("Waiting for data\n\r");
    for (;;) {
        if (XLlFifo_iRxOccupancy(&fifoInstance)) {
            receiveLength = XLlFifo_iRxGetLen(&fifoInstance) / 4;
            printf("Got length %ld\n\rData: ", receiveLength);
            for (i = 0;i < receiveLength;i++) {
                u32 word = XLlFifo_RxGetWord(&fifoInstance);
                printf("%02lx", word);

                while (!XLlFifo_iTxVacancy(&fifoInstance));
                XLlFifo_TxPutWord(&fifoInstance, word);
            }
            printf("\n\rSending\n\r");

            XLlFifo_iTxSetLen(&fifoInstance, receiveLength * 4);
            while(!XLlFifo_IsTxDone(&fifoInstance));
        }
    }

fail:
    print("Leaving\n\r");
    cleanup_platform();
    return 0;
}
