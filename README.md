# Hackintoshing Catalina on ASUS ROG GL552VW

See [detailed guide](https://github.com/fidele007/Asus-ROG-GL552VW-Hackintosh/wiki/Install-macOS-Moajve).

### What works

* Intel HD 530 full acceleration
* HDMI with kext patches (not reliable)
* All USB ports
* Keyboard and keyboard backlight
* Ethernet
* Wi-Fi by replacing the original with `BCM94352Z`
* Battery status
* UVC HD Webcam
* Speaker and Internal microphone
* TouchPad with [VoodooI2C](https://www.tonymacx86.com/threads/voodooi2c-help-and-support.243378/)

### Temporarily not working

* FN keys (Adjust keyboard backlight and brightness)

Note: if anyone can fix this, please create a pull request. Best regards.

### What doesn't work

* NVIDIA optimus (no way to get it working at the moment)

### Untested

* SD card reader

---

### Alternative install guide

Reference to [CremBluRay guide](https://www.tonymacx86.com/threads/guide-asus-rog-gl552vw-laptop-macos-mojave.280413/)<br/>
Make sure your EFI partition size is greater or equal 200MB, else you can extend it, please Google how to do
1. Download the Clover folder from this [catalina](https://github.com/baobaoit/Asus-ROG-GL552VW-Hackintosh/tree/catalina) branch
2. Install MacOS Catalina according to [Olarila instructions](https://olarila.com/forum/viewtopic.php?f=50&t=8685)
    - You may need to plug in a usb mouse to be able to progress through the setup
    - During the installation process, at the first reboot, you need to select Boot install from PreBoot
    - At the second boot, select Boot from X (the partition name you set to install)
3. Once finished with the setup, use clover configurator (Open the USB installer > open the FILES folder, you will see it and other tools there) to mount the EFI of the hard drive
4. In the EFI partition, you'll see a folder called EFI. (If you don't see this, make one and drag the folder labelled Apple into it as well). Open it and place the BOOT and CLOVER folders from the usb install drive into the folder (next to the folder labelled Apple). This will install clover onto the partition and you can now safely eject the usb install drive
5. Open terminal and type 'sudo trimforce disable' (this will make boot time much faster)
6. Done!

---

### Makes the Internal speaker working

1. Using `KextBeast` to install the `CodecCommand.kext` into `/Library/Extensions`
2. Using `Kext Utility` to rebuild `kextcache`
3. Reboot

---

### Alternative makes funtion keys working

1. Download the software [Karabiner-Elements](https://pqrs.org/osx/karabiner/)
2. Open and install the package
3. Grants the access permission in the Settings app
4. Open the `Karabiner-Elements` app (with the KEY icon)

---

### Kexts in /Library/Extensions

* AirportBrcmFixup.kext
* AsusNBFnKeys.kext
* CodecCommander.kext

---

### Thanks

* [RehabMan](https://www.tonymacx86.com/members/rehabman.429483/) for all the amazing guides and kexts
* [toleda](https://www.tonymacx86.com/members/toleda.2393/) for his [Broadcom WiFi/Bluetooth [Guide]](https://www.tonymacx86.com/threads/broadcom-wifi-bluetooth-guide.242423/)
* [u/corpnewt](https://www.reddit.com/user/corpnewt) for the [vanilla guide](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/) which walks you through the steps in making a Hackintosh happen for each CPU architecture
* [alexandred](https://github.com/alexandred) and other contributors to the project [VoodooI2C](https://github.com/alexandred/VoodooI2C) who made the support for ASUS's ELAN touchpad possible
* [acidanthera](https://github.com/acidanthera) for their work on [AppleALC](https://github.com/acidanthera/AppleALC) and [Lilu](https://github.com/acidanthera/Lilu)
* All the other Hackintoshers who have helped solve my various problems
