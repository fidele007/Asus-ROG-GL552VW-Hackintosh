# README

# Notes

* Slightly better CPU temperature after disabling the discrete graphic cards in ``DSDT`` (temperature goes down to 45/46).

* All saved ``DSDT.dsl`` files are stacked upon each other, meaning the file in ``2.with_battery_patch`` is modified upon the one in ``1.brightness_kbBacklight``, and so on.

* Rename _DSM + Skylake LPC fix => enable AppleLPC loading, but no noticeable change in CPU temperature.

* DropOEM needs to be disabled, otherwise the system won’t boot with a “waiting for root device…”  + prohibited sign error

* AppleLPC (for proper power management) is not loaded with common patched DSDT without LPC fix (CPU temperature from 47/48 to 50 degrees)

## Problems

* System hangs on first successful boot with commonly patched DSDT and unmatched SSDTs, but starts fine(?) on second boot.

* Booting from USB sometimes gives WindowServer error which rejects invalid pages.

* Garbled graphics (reproducible in Mission Control mode) with Path Finder app.

## ssdtPRGen.sh log

``
Scope (_PR_) {222 bytes} with ACPI Processor declarations found in DSDT (ACPI 1.0 compliant)
Generating ssdt.dsl for a 'MacBook9,1' with board-id [Mac-9AE82516C7C6B903]
Skylake Core i7-6700HQ processor [0x506E3] setup [0x0705]
With a maximum TDP of 45 Watt, as specified by Intel
Number logical CPU's: 8 (Core Frequency: 2600 MHz)
Number of Turbo States: 9 (2700-3500 MHz)
Number of P-States: 31 (500-3500 MHz)
Adjusting C-States for detected (mobile) processor
Injected C-States for CPU0 (C1,C3,C6,C7)
Injected C-States for CPU1 (C1,C2,C3,C6,C7)
Warning: Model identifier (MacBook9,1) not found in..: /S*/L*/CoreServices/PlatformSupport.plist

Warning: 'cpu-type' may be set improperly (0x0705 instead of 0x0905)
- Clover users should read https://clover-wiki.zetam.org/Configuration/CPU#cpu_type
Compiling: ssdt_pr.dsl
Intel ACPI Component Architecture
ASL+ Optimizing Compiler version 20161210-64(RM)
Copyright (c) 2000 - 2016 Intel Corporation

ASL Input:     /Users/fidele007/Library/ssdtPRGen/ssdt.dsl - 360 lines, 12234 bytes, 73 keywords
AML Output:    /Users/fidele007/Library/ssdtPRGen/ssdt.aml - 2402 bytes, 28 named objects, 45 executable opcodes
``
