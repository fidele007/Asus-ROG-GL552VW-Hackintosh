# Asus ROG GL552VW Hackintosh macOS Monterey
This is a guide to hackintoshing the ASUS ROG GL552VW on macOS Ventura. For other versions of macOS:

* Guide for [macOS Ventura](https://github.com/fidele007/Asus-ROG-GL552VW-Hackintosh/tree/ventura)
* Guide for [macOS Catalina](https://github.com/fidele007/Asus-ROG-GL552VW-Hackintosh/tree/catalina)
* Guide for [macOS Mojave](https://github.com/fidele007/Asus-ROG-GL552VW-Hackintosh/tree/mojave)
* Guide for [macOS Sierra](https://github.com/fidele007/Asus-ROG-GL552VW-Hackintosh/tree/sierra)


> This version was made using OpenCore new hackintoshing, and isn't to reliable so if sudently your computer crashes don't blame on me.

**Note:** Make sure to generate a unique SMBIOS for your machine. For more information, please refer to https://dortania.github.io/OpenCore-Install-Guide/config.plist/skylake.html#platforminfo. The detailed guide is also available on the site: https://dortania.github.io/OpenCore-Install-Guide.

## Specs

//\\\ | Asus ROG GL552VW
------------ | -------------
Model | G552VW-DM475T
Motherboard chipset | Intel HM170
Processor |	Intel Skylake Core i7-6700HQ CPU, quad-core 2.6 GHz (3.5 GHz TBoost)
Screen |	15.6 inch, 1920 x 1080 px resolution, matte, IPS, non-touch
Video |	Integrated Intel HD 530 + Nvidia GTX 960M 2GB
Memory |	16 GB DDR4 2133Mhz (2xDIMMs)
Storage |	128 GB SSD (SanDisk SD8SNAT128G1002) + 1 TB 2.5″ HDD (HGST HTS721010A9E630)
Connectivity |	Wireless AC Intel 7265 , Gigabit Lan, Bluetooth 4.0
Ports | 1x USB 2.0,	2x USB 3.0, 1x USB 3.1, HDMI, mic, earphone, SD card reader, LAN
TouchPad | Elan Touchpad (ELAN1000)

# What works

* Intel HD 530
* HDMI (works by default)
* Bluetooth
* All USB ports
* Keyboard
~~* TouchPad with [VoodooI2C](https://www.tonymacx86.com/threads/wip-voodooi2c-i2c-trackpad-limited-support.204227/) (albeit janky)~~ (Have to patch it manually)
~~* Fn Keys~~ (Don't know if this will work in the future)
* Keyboard Backlighting
* Ethernet (LAN)
* Battery Status
* UVC HD Webcam
* Speaker + Internal Microphone
* Wifi
# What doesn't work

* NVIDIA Optimus (impossible to get working at the moment) Isn't compatible with newer mac os versions.
