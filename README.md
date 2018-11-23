# Hackintoshing Mojave on ASUS ROG GL552VW

See [detailed guide](https://github.com/fidele007/Asus-ROG-GL552VW-Hackintosh/wiki/Install-macOS-Moajve).

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
* TouchPad with [VoodooI2C](https://www.tonymacx86.com/threads/voodooi2c-help-and-support.243378/)

### What doesn't work

* NVIDIA optimus (no way to get it working at the moment)

### Untested

* SD card reader

---

Thanks:

* [RehabMan](https://www.tonymacx86.com/members/rehabman.429483/) for all the amazing guides and kexts
* [toleda](https://www.tonymacx86.com/members/toleda.2393/) for his [Broadcom WiFi/Bluetooth [Guide]](https://www.tonymacx86.com/threads/broadcom-wifi-bluetooth-guide.242423/)
* [u/corpnewt](https://www.reddit.com/user/corpnewt) for the [vanilla guide](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/) which walks you through the steps in making a Hackintosh happen for each CPU architecture
* [alexandred](https://github.com/alexandred) and other contributors to the project [VoodooI2C](https://github.com/alexandred/VoodooI2C) who made the support for ASUS's ELAN touchpad possible
* [acidanthera](https://github.com/acidanthera) for their work on [AppleALC](https://github.com/acidanthera/AppleALC) and [Lilu](https://github.com/acidanthera/Lilu)
* All the other Hackintoshers who have helped solve my various problems
