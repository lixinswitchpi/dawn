# DAWN OPENSOURE FPGA PCIE TDM IP CORE
A fully open source FPGA PCIe TDM IP Core that it is designed for compatibility with Tiger320 chip, but Dawn FPGA TDM IP core also supports
- open source, therefore you can build your own Asterisk TDM card (2 Dahdi channels with one TDM bus open), also with a powerful DMA engine
-  fully compatible with Asterisk Dahdi channel
-  2 separated TDM bus, totally supports 64 Dahdi channels (commercial version only)
-  2 separated DMA engines built-in to support high-density channels without taking much CPU resource (commercial version only)

**For more information, please visit out our website at [www.switchpi.com](http://www.switchpi.com "www.switchpi.com")**
# Install manual
**Check out the dawn Dahdi driver**
`git clone https://github.com/lixinswitchpi/dawn`

**Compile the driver**

`cd dahdi-tools-2.11.1`

`make`

`make install`

`reboot`

**Verify the driver is loaded**

`dmesg`

[ 2720.912991] Dawn Version is 0x02

[ 2720.912998] Dawn Test register is 0xbabababa

[ 2720.967327] Created Span WCTDM/0/0 (SwitchPi DAWN TDM BUS 0)

[ 2720.967335] Created Span WCTDM/0/1 (SwitchPi DAWN TDM BUS 1)

[ 2721.167936] Module 0 TDM BUS 0: Installed -- AUTO FXO (FCC mode)

[ 2722.047676] Module 0 TDM BUS 1: Installed -- AUTO FXS

[ 2722.928888] Module 0 TDM BUS 1: Installed -- AUTO FXS

[ 2722.928917] Found a Wildcard TDM: SwitchPi DAWN (3 modules)

**Load Asterisk to run test**

`dahdi_genconf`

`dahdi_scan`

[1]
active=yes
alarms=OK
description=SwitchPi DAWN TDM BUS 0
name=WCTDM/0/0
manufacturer=SwitchPi
devicetype=DAWN TDM
location=PCI Bus 02 Slot 01
basechan=1
totchans=4
irq=0
type=analog
port=1,FXO
port=2,none
port=3,none
port=4,none
[2]
active=yes
alarms=OK
description=SwitchPi DAWN TDM BUS 1
name=WCTDM/0/1
manufacturer=SwitchPi
devicetype=DAWN TDM
location=PCI Bus 02 Slot 01
basechan=5
totchans=4
irq=0
type=analog
port=5,FXS
port=6,FXS
port=7,none
port=8,none

`dahdi_cfg -vvv`
DAHDI Tools Version - 2.11.1

DAHDI Version: 2.11.1
Echo Canceller(s): MG2
Configuration

Channel map:

Channel 01: FXS Kewlstart (Default) (Echo Canceler: mg2) (Slaves: 01)
Channel 05: FXO Kewlstart (Default) (Echo Canceler: mg2) (Slaves: 05)
Channel 06: FXO Kewlstart (Default) (Echo Canceler: mg2) (Slaves: 06)

3 channels to configure.

Setting echocan for channel 1 to mg2
Setting echocan for channel 5 to mg2
Setting echocan for channel 6 to mg2

`asterisk -f 2 > /dev/null &`
`asterisk -cvvvvvvvgr`
root@ast1:/usr/src# asterisk -cvvvvvvvvvvgr
Asterisk 13.15.0, Copyright (C) 1999 - 2014, Digium, Inc. and others.
Created by Mark Spencer <markster@digium.com>
Asterisk comes with ABSOLUTELY NO WARRANTY; type 'core show warranty' for details.
This is free software, with components licensed under the GNU General Public
License version 2 and other licenses; you are welcome to redistribute it under
certain conditions. Type 'core show license' for details.
Connected to Asterisk 13.15.0 currently running on ast1 (pid = 2051)
ast1*CLI> dahdi show ch
channels  channel   
ast1*CLI> dahdi show status 
Description                              Alarms  IRQ    bpviol CRC    Fra Codi Options  LBO
SwitchPi DAWN TDM BUS 0                  OK      0      0      0      CAS Unk           0 db (CSU)/0-133 feet (DSX-1)
SwitchPi DAWN TDM BUS 1                  OK      0      0      0      CAS Unk           0 db (CSU)/0-133 feet (DSX-1)
ast1*CLI> dahdi show chan
channels  channel   
ast1*CLI> dahdi show channels 
   Chan Extension       Context         Language   MOH Interpret        Blocked    In Service Description
 pseudo                 default                    default                         Yes                                        
      1                 from-pstn                  default                         Yes                                        
      5                 from-internal              default                         Yes                                        
      6                 from-internal              default                         Yes                                        
ast1*CLI> 
