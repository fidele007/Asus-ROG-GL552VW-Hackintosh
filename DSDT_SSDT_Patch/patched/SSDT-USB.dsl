DefinitionBlock ("SSDT-USB.aml", "SSDT", 1, "sample", "USBFix", 0x00003000)
{
    // "USBInjectAllConfiguration" : override settings for USBInjectAll.kext
    Device(UIAC)
    {
        Name(_HID, "UIA00000")
        // "RehabManConFiguration"
        Name(RMCF, Package()
        {
            // XHC overrides for 100-series boards
            "8086_a12f", Package()
            {
                "port-count", Buffer() { 0x15, 0, 0, 0}, // Highest port number is SS** at 0xNN
                "ports", Package()
                {   // TO COMPLETE THIS FILE, ADD ALL YOUR PORTS BELOW HERE, THEN SET port-count ABOVE
                    
                    "HS01", Package() // USB2 device on a USB3 port (left side - #1 from the USB-C port), port <01 00 00 00>
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x01, 0, 0, 0 },
                    },
                    
                    "HS04", Package() // USB 2.0 UVC HD Webcam, port <04 00 00 00>
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 0x04, 0, 0, 0 },
                    },
                    
                    "HS05", Package() // USB2 device on a USB3 port (left side - #2 from the USB-C port), port <05 00 00 00>
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x05, 0, 0, 0 },
                    },
                    
                    "HS06", Package() // USB2/USB3 device on a USB2 port (right side), port <06 00 00 00>
                    {
                        "UsbConnector", 0,
                        "port", Buffer() { 0x06, 0, 0, 0 },
                    },
                    
                    "HS09", Package() // Bluetooth
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 0x09, 0, 0, 0 },
                    },

                    "SS01", Package() // USB3 port (left side - #1 from the USB-C port), port <11 00 00 00>
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x11, 0, 0, 0 },
                    },
                    
                    "SS05", Package() // USB3 port (left side - #2 from the USB-C port), port <15 00 00 00>
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x15, 0, 0, 0 },
                    }
                },
            },
        })
    }
}