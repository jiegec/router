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
    printf("Sending data to port %d of length %ld\n", port, length);
    while (!XLlFifo_iTxVacancy(&fifoInstance));
    XLlFifo_TxPutWord(&fifoInstance, (u32)port);
    for (u32 i = 0;i < length;i++) {
        printf("%02x", data[i]);
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

struct Icmp {
    u8 type;
    u8 code;
    u16 checksum;
    u8 data[0];
};

struct Ip {
    struct EthernetFrame ethernet;
    u8 versionIHL;
    u8 dfs;
    u16 totalLength;
    u16 identification;
    u16 flags;
    u8 ttl;
    u8 protocol;
    u16 headerChecksum;
    u8 sourceIP[4];
    u8 destIP[4];
    union {
        u8 bytes[0];
        struct Icmp icmp;
    } payload;
};


u8 portMAC[6] = {2, 2, 3, 3, 0, 0};

u16 checksumAdd(u16 orig, u16 add) {
    u32 ans = orig;
    ans += add;
    ans = (ans >> 16) + (ans & 0xFFFF);
    ans = (ans >> 16) + (ans & 0xFFFF);
    return (u16)ans;
}

void fillIpChecksum(struct Ip *ip) {
    // skip ethernet
    u16 *data = ((u16 *)ip) + 7;
    ip->headerChecksum = 0;
    u16 checksum = 0;
    for (int i = 0;i < 10;i++) {
        checksum = checksumAdd(checksum, data[i]);
    }
    ip->headerChecksum = ~checksum;
}

void handleEthernetFrame(u8 port, u8 *data) {
    u8 portIP[4] = {10, 0, port, 1};

    struct EthernetFrame *ether = (struct EthernetFrame *)data;
    struct ArpResponse *arp = (struct ArpResponse *)data;
    u8 buffer[2048];
    u16 etherType = bswap16(ether->etherType);
    if (etherType == 0x0806) {
        // ARP
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
    } else if (etherType == 0x0800) {
        // IP
        struct Ip *ip = (struct Ip *)data;
        struct Ip *ipResp = (struct Ip *)buffer;
        if (ip->protocol == 1) {
            // ICMP
            if (ip->payload.icmp.type == 8) {
                printf("Got ICMP echo request\n");
                memcpy(ipResp->ethernet.dstMAC, ip->ethernet.srcMAC, 6);
                memcpy(ipResp->ethernet.srcMAC, portMAC, 6);
                ipResp->ethernet.etherType = bswap16(0x0800);
                ipResp->versionIHL = 0x45;
                ipResp->dfs = 0;
                u16 totalLength = bswap16(ip->totalLength);
                ipResp->totalLength = ip->totalLength;
                ipResp->identification = 0;
                ipResp->flags = 0;
                ipResp->ttl = 64;
                ipResp->protocol = 1;
                ipResp->headerChecksum = 0;
                memcpy(ipResp->sourceIP, portIP, 4);
                memcpy(ipResp->destIP, ip->sourceIP, 4);
                ipResp->payload.icmp.type = 0;
                ipResp->payload.icmp.code = 0;
                // type: 8 -> 0
                ipResp->payload.icmp.checksum = checksumAdd(ip->payload.icmp.checksum, 8);
                // assuming IHL=5
                memcpy(ipResp->payload.icmp.data, ip->payload.icmp.data, totalLength - 20 - 4);

                fillIpChecksum(ipResp);
                sendToFifo(port, buffer, totalLength + 14);
            }
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
