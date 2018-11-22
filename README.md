# Mojave Hackintosh Guide for ASUS ROG GL552VW

## Required materials

* USB 2.0 flash drive of at least 8GB to create a bootable macOS installer
* Access to a real Mac or a hackintosh (or, as a last resort, a macOS VM) to download and write Mojave installer files to the USB

## Resources

* [IORegistryExplorer.app](https://github.com/toleda/audio_ALCInjection/blob/master/IORegistryExplorer_v2.1.zip): utility for browsing IO registory of your machine
* [Clover Configurator](https://mackie100projects.altervista.org/download-clover-configurator/): mount EFI partition, edit Clover config.plist and generate SMBIOS among other things
* [MaciASL](https://bitbucket.org/RehabMan/os-x-maciasl-patchmatic/downloads/): tool for editing and compiling ACPI files (DDST and SSDT)

## Write Mojave installer to USB

* Format the USB as a GTP partition with Disk Utility
* Copy the installer files:

```bash
sudo "/Applications/Install macOS Mojave.app/Contents/Resources/createinstallmedia" --volume  /Volumes/install_osx
```

where `intall_osx` is the name of your formatted USB flash drive.

This will take some time, so be patient. An alternative method is using [UniBeast 9.0.0](https://www.tonymacx86.com/resources/categories/tonymacx86-downloads.3/) to do all this automatically for you.

**NOTE:** In case the downloaded installer image is smaller than expected (normally it should be around 5-6GB), you're gonna need to open the installer app to download all the files (**DO NOT RESTART** when it asks you to).

## Install Clover EFI bootloader

* Get the latest version of [Clover EFI bootloader](https://sourceforge.net/projects/cloverefiboot/)
* Install the bootloader by choosing `Customize` with the following options:
  * Clover for UEFI booting only
  * Install Clover in the ESP
  * UEFI Drivers
    * DataHubDxe-64
    * FSInject-64
    * SMCHelper-64
    * ~~VBoxHfs-64~~: you're not gonna need this
    * ApfsDriverLoader-64
    * AptioMemoryFix-64
    * OsxAptioFix3Drv-64
    * OsxAptioFixDrv-64
    * OsxLowMemFixDrv-64
  * FileVault 2 UEFI Drivers
    * FirmwareVolume-64

You also need two other drivers in `CLOVER/drivers64UEFI`:

* [apfs.efi](https://www.tonymacx86.com/threads/how-to-update-current-and-past-apfs-efi-downloads.236103/)
* [HFSPlus.efi](https://raw.githubusercontent.com/JrCs/CloverGrowerPro/master/Files/HFSPlus/X64/HFSPlus.efi)

## Essential kexts

* [FakeSMC.kext](https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/): makes the OS thinks that the machine is a real Mac. Without it, you won't ever be able to reach the installer.
* [RealtekRTL8111.kext](https://bitbucket.org/RehabMan/os-x-realtek-network/downloads/): Ethernet kext
* [USBInjectAll.kext](https://bitbucket.org/RehabMan/os-x-usb-inject-all/downloads/): injects all USB ports to get them recognized
* [FakePCIID.kext + FakePCIID_XHCIMux.kext](https://github.com/RehabMan/OS-X-Fake-PCI-ID): increases USB port limit
* [Lilu.kext](https://github.com/acidanthera/Lilu/releases): dependency kext required by other kexts
* [WhateverGreen.kext](https://github.com/acidanthera/WhateverGreen/releases): most recommened graphics kext for newer macOS versions
* [VoodooPS2Controller.kext](https://bitbucket.org/RehabMan/os-x-voodoo-ps2-controller/downloads/): for mouse and keyboard

All the above kexts are to be put in `CLOVER/kexts/Other`. Do not put them in any other folders lest they won't be loaded. In case you do not see your SATA drive in the installer, you're also going to need SATA unsupported kexts of which there are:

* SATA-100-series-unsupported.kext
* SATA-200-series-unsupported.kext
* SATA-300-series-unsupported.kext
* SATA-RAID-unsupported.kext

All the necessary kexts are included in my Clover folder.

## Clover Config.plist for Mojave installation

The included `CLOVER/config_preinstall.plist` contains all the necessary configurations needed to make it to the installer. Make sure to rename it to `config.plist` since Clover chooses `config.plist` by default.

Some details for the `config` file:

### Boot arguments

* `dart=0`: bypass Vt-d
* `-liludbgall`: show all debugging info for Lilu kext (optional)
* `igfxdump`: dump your graphics info using `WhateverGreen.kext` (optional)
* `-v`: verbose mode to show everything happeneing under the hood. Enabling this is useful for debugging in case there is a problem.
* `keepsyms=1`: tells OS to print the symbols on a kernel panic
* `debug=0x100`: prevents a reboot on kernel panic
* `kext-dev-mode=1`: allows unsigned kernel extensions (kexts) to load
* `shikigva=40`: this flag is specific to the iGPU.  It enables a few Shiki settings that do the following (found here):
  * 8 - AddExecutableWhitelist - ensures that processes in the whitelist are patched
  * 32 - ReplaceBoardID - replaces board-id used by AppleGVA by a different board-id

### Patches

All the kernel and kext patches come with explanatory comments.

### SMBIOS

Choose a Mac model that's most compatible with your version of macOS. I use `iMac17,1`. Use [Clover Configuration](https://mackie100projects.altervista.org/download-clover-configurator/) for easy configuration of your SMBIOS.

### BIOS Settings

* Disable Fastboot
* Disable Secure Boot
* Disable VT-d
* Disable Intel Virtualization Technology

---

Will all these in place, you should be able to boot into the installer and install your macOS. Keep in mind that in Mojave, Apple has removed the possibility to install to a HFS partition and force install to an APFS partition instead.

**Rant:** APFS is **shitty** because so far it's not fully documented, so if you have any problem, which Hackintoshers are prone to have regularly after each OS update, and the superficial Disk Utility's first aid does not help, well you're fucked because you cannot rely on other more powerful third-party disk repair tools like `DiskWarrior` which currently does not support APFS repair thanks to Apple. I personally ran into this problem where after a system update, my file structure somehow gets corrupted and Disk Utility couldn't do shit. So, the takeaway from this is to prepare yourself for the consequences when you decide to do any system update on your Hackintosh. End rant.

---

## Post Installation

### ACPI patches

The included patches are in `CLOVER/ACPI/patched`:

* `DSDT.aml`:
  * \[bat\] ASUS G75VW
  * \[sys\] Fix _WAK Arg0 v2
  * \[sys\] HPET Fix
  * \[sys\] SMBUS Fix
  * \[sys\] IRQ Fix
  * \[sys\] RTC Fix
  * \[sys\] OS Check Fix Windows 8
  * \[sys\] Fix Mutex with non-zero SyncLevel
  * \[usb\] 7-series/8-series USB
  * \[usb\] USB3_PRW 0x6D Skylake (instant wake)
  * \[sys\] Skylake LPC
  * KeyboardBacklight16:

  ```txt
  # Patch by EMlyDinEsH (www.osxlatitude.com)
  # Enables 16 keyboard backlight levels control to work using my kexts AsusNBFnKeys and Smart Touchpad
  # This patch meant for the notebooks up to Ivy Bridge.

  # Insert backlight auto off control sync field for Smart Touchpad and Asus Fn Keys driver
  into device label ATKD code_regex Name\s\(BOFF,\sZero\) remove_matched;
  into device label ATKD insert begin Name (BOFF, Zero) end;

  # Insert method SKBL for setting keyboard backlight level
  into method label SKBL parent_label ATKD remove_entry;
  into Device label ATKD insert begin
  Method (SKBL, 1, NotSerialized)\n
              {\n
                  If (Or (LEqual (Arg0, 0xED), LEqual (Arg0, 0xFD)))\n
                  {\n
                      If (And (LEqual (Arg0, 0xED), LEqual (BOFF, 0xEA)))\n
                      {\n
                          Store (Zero, Local0)\n
                          Store (Arg0, BOFF)\n
                      }\n
                      Else\n
                      {\n
                          If (And (LEqual (Arg0, 0xFD), LEqual (BOFF, 0xFA)))\n
                          {\n
                              Store (Zero, Local0)\n
                              Store (Arg0, BOFF)\n
                          }\n
                          Else\n
                          {\n
                              Return (BOFF)\n
                          }\n
                      }\n
                  }\n
                  Else\n
                  {\n
                      If (Or (LEqual (Arg0, 0xEA), LEqual (Arg0, 0xFA)))\n
                      {\n
                          Store (KBLV, Local0)\n
                          Store (Arg0, BOFF)\n
                      }\n
                      Else\n
                      {\n
                          Store (Arg0, Local0)\n
                          Store (Arg0, KBLV)\n
                      }\n
                  }\n

                  Store (DerefOf (Index (KBPW, Local0)), Local1)\n
                  ^^PCI0.LPCB.EC0.WRAM (0x044B, Local1)\n
                  Return (Local0)\n
              }\n
  end;

  # Insert keyboard backlight 16 levels buffer
  into device label ATKD code_regex Name\s\(KBPW,\sBuffer\s\(0x10\)\s*\n\s*\{\s*\/\*\s0000\s\*\/\s*0x00,\s0x11,\s0x22,\s0x33,\s0x44,\s0x55,\s0x66,\s0x77,\s*\/\*\s0008\s\*\/\s*\s0x88,\s0x99,\s0xAA,\s0xBB,\s0xCC,\s0xDD,\s0xEE,\s0xFF\s*\}\) remove_matched;
  into device label ATKD insert begin
  Name (KBPW, Buffer (0x10)\n
    {\n
        0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF\n
    })
  end;

  #into device label ATKD code_regex Name\s\(PWKB,\sBuffer\s\(0x04\)\s*\n\s*\{\s*0x00,\s0x55,\s0xAA,\s0xFF\s*\}\) remove_matched
  #into device label ATKD insert begin
  #Name (PWKB, Buffer (0x10)\n
  #   {\n
  #      0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF\n
  #   })
  #end;

  # Insert method GKBL for reading keyboard backlight level
  into method label GKBL parent_label ATKD remove_entry;
  into Device label ATKD insert begin
  Method (GKBL, 1, NotSerialized)\n
              {\n
                If (LEqual (Arg0, 0xFF))\n
                  {\n
                      Return (BOFF)\n
                  }\n

                  Return (KBLV)\n
              }\n
  end;
  ```

  * Fn Backlit Brightness Keys Patch:

  ```txt
  # Patch by EMlyDinEsH (OSXLatitude)
  # Enables Fn brightness keys to work with my kext AsusNBFnKeys

  # Replacing method _Q0E with code for Brightness down key to work
  into Method label _Q0E replace_content begin
              If (ATKP)\n
                  {\n
                    ^^^^ATKD.IANE (0x20)\n
                  }
  end;

  # Replacing method _Q0F with code for Brightness up key to work
  into Method label _Q0F replace_content begin
              If (ATKP)\n
                  {\n
                    ^^^^ATKD.IANE (0x10)\n
                  }
  end;
  ```

  * \[Windows\] Windows 10 Patch (required for VooodooI2C):

  ```txt
  # Windows 10 DSDT Patch for VoodooI2C
  # Allows I2C controllers and devices to be discovered by OS X.
  # Based off patches written by RehabMan

  into_all method code_regex If\s+\([\\]?_OSI\s+\(\"Windows\s2015\"\)\) replace_matched begin If(LOr(_OSI("Darwin"),_OSI("Windows 2015"))) end;
  ```

  * Old I2C Touchpad patch *(not sure if this still works with the new VoodooI2C)*

  ```txt
  # INT3443 (I2C1) Controller Patch for VoodooI2C on Skylake
  # Written and maintained by Alexandre Daoud

  into_all scope label _SB.PCI0.I2C1 name_adr 0x00150001 remove_entry;
  into_all scope label _SB.PCI0.I2C1 name_hid INT3443 remove_entry;

  into device label I2C1 parent_label _SB.PCI0 insert
  begin
  Name (_HID, "INT3443")  // _HID: Hardware ID\n
              Method (_HRV, 0, NotSerialized)  // _HRV: Hardware Revision\n
              {\n
                  Return (LHRV (SB11))\n
              }\n
  \n
              Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings\n
              {\n
                  Return (LCRS (SMD1, SB01, SIR1))\n
              }\n
  \n
              Method (_PSC, 0, NotSerialized)  // _PSC: Power State Current\n
              {\n
                  GETD (SB11)\n
              }\n
  \n
              Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0\n
              {\n
                  LPD0 (SB11)\n
              }\n
  \n
              Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3\n
              {\n
                  LPD3 (SB11)\n
              }\n
  \n
              Method (_STA, 0, NotSerialized)  // _STA: Status\n
              {\n
                  Return (LSTA (SMD1))\n
              }\n
  \n
              Name (_ADR, 0x00150001)  // _ADR: Address\n
              Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method\n
              {\n
                  If (PCIC (Arg0))\n
                  {\n
                      Return (PCID (Arg0, Arg1, Arg2, Arg3))\n
                  }\n
  \n
                  Return (Zero)\n
              }\n
  end;
  ```

  * Disable discrete NVIDIA graphics thanks to [this guide](https://www.insanelymac.com/forum/topic/295584-disabling-nvidia-optimus-card-on-all-laptops/)
* `SSDT-PNLF.aml` for brightness patch thanks to [Rehabman's guide](https://www.tonymacx86.com/threads/guide-patching-dsdt-ssdt-for-laptop-backlight-control.152659/)
* `SSDT-USB.aml` for USB port patch thanks to [Rehabman's guide](https://www.tonymacx86.com/threads/guide-creating-a-custom-ssdt-for-usbinjectall-kext.211311/)
* ~~`SSDT-CX20752.aml`~~ has been removed since I could not get the internal microphone to work with this patch. Instead, I got it working by manually modifying the `Info.plist` file in `CodecCommander.kext` to include the custom commands (see below).

### Additional kexts

* **Audio:** since Mojave has removed a lot of layout IDs from its `AppleHDA.kext`, the currently most recommended way of patching `AppleHDA.kext` is `AppleALC.kext`. Get the latest version from [here](https://github.com/acidanthera/AppleALC/releases). Unfortunately, the internal microphone does not work out of the box even with this kext. You need a patch to get it working. I use `CodecCommander.kext` and add a profile for `CX20752` in `CodecCommander.kext/Contents/Info.plist` ([General guide](https://bitbucket.org/RehabMan/os-x-eapd-codec-commander/src/a1219d7dafeadfb9e9d881d47ac9a677168b3fa6/README.md)):

```plist
<key>14f1_510f</key>
<string>CX20752</string>
<key>CX20752</key>
<dict>
  <key>Custom Commands</key>
  <array>
    <dict>
      <key>Command</key>
      <string>0x01970724</string>
      <key>Comment</key>
      <string>0x19 SET_PIN_WIDGET_CONTROL 0x24</string>
      <key>On Init</key>
      <true/>
      <key>On Sleep</key>
      <false/>
      <key>On Wake</key>
      <true/>
    </dict>
    <dict>
      <key>Command</key>
      <string>0x01a70724</string>
      <key>Comment</key>
      <string>0x1a SET_PIN_WIDGET_CONTROL 0x24</string>
      <key>On Init</key>
      <true/>
      <key>On Sleep</key>
      <false/>
      <key>On Wake</key>
      <true/>
    </dict>
  </array>
  <key>Perform Reset</key>
  <false/>
  <key>Perform Reset on External Wake</key>
  <false/>
</dict>
```

* **Brightness:** `AppleBacklightFixup.kext` is required in combination with the `SSDT-PNLF.aml` above to get the brightness control working. Get it from [here](https://bitbucket.org/RehabMan/applebacklightfixup/downloads/).
* **AsusNBFnKeys.kext:** Enable FN key functions. Get it from [here](https://osxlatitude.com/forums/topic/1968-fn-hotkey-and-als-sensor-driver-for-asus-notebooks/).
* **ACPIBatteryManager.kext**: for battery status.
* **Wi-Fi + Bluetooth:** the Wi-Fi that came with ASUS ROG GL552VW won't work on macOS. I replaced mine with a `BCM94352Z` model. If you did the same, you need to follow [this guide](https://www.tonymacx86.com/threads/broadcom-wifi-bluetooth-guide.242423/) to get Wi-Fi + Bluetooth working:
  * [Lilu.kext](https://github.com/acidanthera/Lilu/releases)
  * [AirportBrcmFixup.kext](https://github.com/acidanthera/AirportBrcmFixup/releases)
  * [BrcmFirmwareRepo.kext & BrcmPatchRAM2.kext](https://bitbucket.org/RehabMan/os-x-brcmpatchram/downloads/)

**NOTE:** All working kexts should be moved from `CLOVER/kexts/Other` to `/Library/Extensions`. You can use tools like `Kext Wizard` or `Kext Utility` to easily install kexts and repair permissions for you.

### Kexts to patch

HDMI did not work out of the box for me after installing Mojave. I needed to include the following kext patches to get it working: (I don't have a chance to test HDMI audio)

```plist
<dict>
  <key>Comment</key>
  <string>Brumbaer's GDP Patch 1</string>
  <key>Disabled</key>
  <false/>
  <key>Find</key>
  <data>
  RURJRAA=
  </data>
  <key>InfoPlistPatch</key>
  <false/>
  <key>Name</key>
  <string>AppleGraphicsDevicePolicy</string>
  <key>Replace</key>
  <data>
  RURJSQA=
  </data>
</dict>
<dict>
  <key>Comment</key>
  <string>Brumbaer's GDP Patch 2</string>
  <key>Disabled</key>
  <false/>
  <key>Find</key>
  <data>
  dW5sb2FkAA==
  </data>
  <key>InfoPlistPatch</key>
  <false/>
  <key>Name</key>
  <string>AppleGraphicsDevicePolicy</string>
  <key>Replace</key>
  <data>
  dW5sb2FlAA==
  </data>
</dict>
<dict>
  <key>Comment</key>
  <string>Brumbaer's GDP Patch 3</string>
  <key>Disabled</key>
  <false/>
  <key>Find</key>
  <data>
  RGVmYXVsdAA=
  </data>
  <key>InfoPlistPatch</key>
  <false/>
  <key>Name</key>
  <string>AppleGraphicsDevicePolicy</string>
  <key>Replace</key>
  <data>
  bm9uZQAAAAA=
  </data>
</dict>
<dict>
  <key>Comment</key>
  <string>Brumbaer's GDP Patch 4</string>
  <key>Disabled</key>
  <false/>
  <key>Find</key>
  <data>
  Q29uZmlnTWFwAA==
  </data>
  <key>InfoPlistPatch</key>
  <false/>
  <key>Name</key>
  <string>AppleGraphicsDevicePolicy</string>
  <key>Replace</key>
  <data>
  Q29uZmlnTWFxAA==
  </data>
</dict>
<dict>
  <key>Comment</key>
  <string>Brumbaer's GDP Patch 5</string>
  <key>Disabled</key>
  <false/>
  <key>Find</key>
  <data>
  RmVhdHVyZUNvbnRyb2wA
  </data>
  <key>InfoPlistPatch</key>
  <false/>
  <key>Name</key>
  <string>AppleGraphicsDevicePolicy</string>
  <key>Replace</key>
  <data>
  RmVhdHVyZUNvbnRyb20A
  </data>
</dict>
```

However, this is not completely reliable as sometimes I need to unplug/re-plug the cable to get it working. *Feel free to let me know if you have a better solution.*

### Native power management (Proper sleep/wake)

This is a dumb down version of the [more extensive guide](https://www.tonymacx86.com/threads/guide-native-power-management-for-laptops.175801/) on native power management for laptops.

First of all, make sure that you have brightness working correctly.

Hibernation does not work on Hackintosh, so disable it:

```bash
sudo pmset -a hibernatemode 0
sudo rm /var/vm/sleepimage
sudo mkdir /var/vm/sleepimage
```

Disable other hibernation related options:

```bash
sudo pmset -a standby 0
sudo pmset -a autopoweroff 0
```

Enable `PluginType` in `config.plist`

```plist
<key>SSDT</key>
<dict>
  <key>DropOem</key>
  <false/>
  <key>Generate</key>
  <dict>
    <key>PluginType</key>
    <true/>
  </dict>
  <key>PluginType</key>
  <integer>1</integer>
</dict>
```

Disable/delete all other forms of CPU power management

* SSDT.aml
* SSDT-XCPM.aml
* SSDT-PluginType1.aml

as well as any related kexts:

* NullCPUPowerManagement.kext

Finally, you can check if power management is working correctly by:

* Checking visually with [Intel® Power Gadget](https://software.intel.com/en-us/articles/intel-power-gadget-20)
* Verify with IORegistryExplorer that `X86PlatformPlugin` is loading under the CPU0 node
* Using `AppleIntelInfo.kext` to check that CPU and IGPU P-States are correctly generated ([Reference](https://www.tonymacx86.com/threads/macos-native-cpu-igpu-power-management.222982/))

### Other stuff

TRIM does not work well with APFS; there has been reports that it will make your APFS slower (longer boot time, etc.), so you should disable it:

* Disable or remove all TRIM patches
* Run `sudo trimforce disable` and reboot

---

### What works

* Intel HD 530 full acceleration
* HDMI with kext patches (not reliable)
* All USB ports
* Keyboard and keyboard backlight
* FN keys
* Ethernet
* Wi-Fi by replacing the original with `BCM94352Z`
* Battery status
* UVC HD Webcam
* Speaker and Internal microphone

### What doesn't work

* NVIDIA optimus (no way to get it working at the moment)

### Untested

* TouchPad with [VoodooI2C](https://www.tonymacx86.com/threads/voodooi2c-help-and-support.243378/)
* SD card reader

---

Thanks:

* [RehabMan](https://www.tonymacx86.com/members/rehabman.429483/) for all the amazing guides and kexts
* [toleda](https://www.tonymacx86.com/members/toleda.2393/) for his [Broadcom WiFi/Bluetooth [Guide]](https://www.tonymacx86.com/threads/broadcom-wifi-bluetooth-guide.242423/)
* [u/corpnewt](https://www.reddit.com/user/corpnewt) for the [vanilla guide](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/) which walks you through the steps in making a Hackintosh happen for each CPU architecture
* [alexandred](https://github.com/alexandred) and other contributors to the project [VoodooI2C](https://github.com/alexandred/VoodooI2C) who made the support for ASUS's ELAN touchpad possible
* [acidanthera](https://github.com/acidanthera) for their work on [AppleALC](https://github.com/acidanthera/AppleALC) and [Lilu](https://github.com/acidanthera/Lilu)
* All the other Hackintoshers who have helped solve my various problems
