# Windows Memory Analysis

**Explore:** [Home](/README.md) [Basics](/0-Basics.md)

- [VirusTotal GUI Upload](https://www.virustotal.com/gui/)

## Volatility
- procdump ∙∙∙∙∙∙∙∙∙∙∙ memdump
- connections ∙∙∙∙∙∙∙∙∙∙∙ connscan
- pslist ∙∙∙∙∙∙∙∙∙∙∙ psscan ∙∙∙∙∙∙∙∙∙∙∙ pstree ∙∙∙∙∙∙∙∙∙∙∙ psxview
- cmdscan ∙∙∙∙∙∙∙∙∙∙∙ driverscan

```pwsh
.\volatility_2.6_win64_standalone.exe -h
.\volatility_2.6_win64_standalone.exe -f ".\cridex.vmem" imageinfo
.\volatility_2.6_win64_standalone.exe -f ".\cridex.vmem" --profile=WinXPSP2x86 -h                         # List plugins for profile
.\volatility_2.6_win64_standalone.exe -f ".\cridex.vmem" --profile=WinXPSP2x86 procdump -p 1640 -D .      # Turn process into executable

# Grab all areas of memory related to process
.\volatility_2.6_win64_standalone.exe -f ".\cridex.vmem" --profile=WinXPSP2x86 memdump -p 1640 -D .
Z:\strings.exe -accepteula "C:\path\to\target.dmp" > "C:\target\output.txt"

Set-MpPreference -ExclusionPath 'C:\Users\<user>\Desktop\Memory_Analysis\'               # Tell Windows Defender to ignore path

.\volatility_2.6_win64_standalone.exe -f <FILENAME> --profile=<PROFILE> <PLUGIN> [-h? for help/args]
```

- [Volatility Foundation](https://volatilityfoundation.org/)
