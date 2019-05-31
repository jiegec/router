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

XLlFifo fifoInstance;

u16 bswap16(u16 i) {
    return (i >> 8) | ((i & 0xFF) << 8);
}

void sendToFifo(u8 port, u8 *data, u32 length) {
    printf("Sending data to port %d of length %d\n", port, length);
    while (!XLlFifo_iTxVacancy(&fifoInstance));
    XLlFifo_TxPutWord(&fifoInstance, (u32)port);
    for (u32 i = 0;i < length;i++) {
        printf("%02lx", data[i]);
        XLlFifo_TxPutWord(&fifoInstance, (u32)data[i]);
    }
    printf("\n");
    XLlFifo_iTxSetLen(&fifoInstance, (length + 1) * 4);
    while(!XLlFifo_IsTxDone(&fifoInstance));
}

struct EthernetFrame {
    u8 dstMAC[6];
    u8 srcMAC[6];
    u16 etherType;
};

struct ArpResponse {
    u8 dstMAC[6];
    u8 srcMAC[6];
    u16 etherType;
    u16 hardwareType;
    u16 protocolType;
    u8 hardwareSize;
    u8 protocolSize;
    u16 opcode;
    u8 senderMAC[6];
    u8 senderIP[4];
    u8 targetMAC[6];
    u8 targetIP[4];
};

void handleEthernetFrame(u8 port, u8 *data) {
    struct EthernetFrame *ether = (struct EthernetFrame *)data;
    struct ArpResponse *arp = (struct ArpResponse *)data;
    u8 buffer[2048];
    u16 etherType = bswap16(ether->etherType);
    if (etherType == 0x0806) {
        u16 opcode = bswap16(arp->opcode);
        if (opcode == 0x0001) {
            printf("Got ARP request\n");
            struct ArpResponse *arpResp = (struct ArpResponse *)buffer;
            memcpy(arpResp->dstMAC, arp->srcMAC, 6);
            memcpy(arpResp->srcMAC, arp->dstMAC, 6);
            arpResp->etherType = bswap16(0x0806);
            arpResp->hardwareType = bswap16(1);
            arpResp->protocolType = bswap16(0x0800);
            arpResp->hardwareSize = 6;
            arpResp->protocolSize = 4;
            arpResp->opcode = bswap16(2);
            memcpy(arpResp->targetMAC, arp->senderMAC, 6);
            memcpy(arpResp->targetIP, arp->senderIP, 4);
            // Filled by router in fact
            memcpy(arpResp->senderMAC, arp->dstMAC, 6);
            memcpy(arpResp->senderIP, arp->targetIP, 4);

            sendToFifo(port, buffer, sizeof(struct ArpResponse));
        }
    }
}

int main()
{
    XLlFifo_Config *Config;
    int Status;
    u32 receiveLength;
    u32 i;
    u8 buffer[2048];
    u32 count = 0;

    init_platform();

    print("Lookup config\n");
    Config = XLlFfio_LookupConfig(XPAR_AXI_FIFO_0_DEVICE_ID);
    if (!Config) {
        print("No config found\n");
        goto fail;
    }

    Status = XLlFifo_CfgInitialize(&fifoInstance, Config, Config->BaseAddress);
    if (Status != XST_SUCCESS) {
        print("Init failed\n");
        goto fail;
    }

	XLlFifo_IntClear(&fifoInstance,0xffffffff);

    print("Waiting for data\n");
    for (;;) {
        if (XLlFifo_iRxOccupancy(&fifoInstance)) {
            receiveLength = XLlFifo_iRxGetLen(&fifoInstance) / 4;
            printf("%d: Got length %ld\nData: ", ++count, receiveLength);
            for (i = 0;i < receiveLength;i++) {
                u32 word = XLlFifo_RxGetWord(&fifoInstance);
                buffer[i] = word;
                printf("%02lx", word);
            }
            printf("\n");
            handleEthernetFrame(buffer[0], &buffer[1]);
        }
    }

fail:
    print("Leaving\n");
    cleanup_platform();
    return 0;
}
