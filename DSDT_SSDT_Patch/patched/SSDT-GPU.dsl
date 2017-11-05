DefinitionBlock ("", "SSDT", 2, "hack", "disable", 0)
{
    External(_SB.PCI0.PEG0.PEGP._OFF, MethodObj)
    Method(_SB.PCI0.PEG0.PEGP._INI) { _OFF() }
}