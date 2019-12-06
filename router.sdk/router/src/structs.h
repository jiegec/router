/*
 * structs.h
 *
 *  Created on: Jun 3, 2019
 *      Author: oslab
 */

#ifndef SRC_STRUCTS_H_
#define SRC_STRUCTS_H_

#include "xil_types.h"

struct EthernetFrame {
    u8 dstMAC[6];
    u8 srcMAC[6];
    u16 etherType;
} __attribute__ ((packed));

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
} __attribute__ ((packed));

struct Icmp {
    u8 type;
    u8 code;
    u16 checksum;
    u8 data[0];
} __attribute__ ((packed));

struct RipRoute {
    u16 family;
    u16 routeTag;
    u32 ip;
    u32 netmask;
    u32 nexthop;
    u32 metric;
} __attribute__ ((packed));

struct Rip {
    u8 command;
    u8 version;
    u16 zero;
    struct RipRoute routes[0];
} __attribute__ ((packed));

struct Udp {
    u16 srcPort;
    u16 dstPort;
    u16 length;
    u16 checksum;
    union {
        u8 bytes[0];
        struct Rip rip;
    } payload;
} __attribute__ ((packed));

struct Ip {
    struct EthernetFrame ethernet;
    u8 versionIHL;
    u8 dsf;
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
        struct Udp udp;
    } payload;
} __attribute__ ((packed));

struct Route {
    u32 ip;
    u32 netmask;
    u32 metric;
    u32 nexthop;
    u32 port;
    u32 updateTime;
    u32 origin;
};

#endif /* SRC_STRUCTS_H_ */
