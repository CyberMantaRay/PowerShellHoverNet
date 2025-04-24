# Windows Sysinternals Suite
**Explore:** [Home](/README.md) [Basics](/0-Basics.md)

- [Sysinternals Suite | Download](https://learn.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite)

```pwsh
net use * \\live.sysinternals.com\tools
Z:
```

### Autoruns
- Auto Runs → Scheduled Tasks → Jump to Entry → Task Scheduler Library
    - Name -> <TASK> Keep-Alive -> Actions -> Details

### ProcExp

```cmd
netstat -ano | findstr :6666
tasklist /fi /m "PID eq 7696"
```

### TcpView
- tcpview → Sort by State → Watch for Syn Sent msg...


### SigCheck

```cmd

```

### Misc.
- GUI
    - LoadOrd
- AccessChk
    - `accesschk.exe $(gcm spoolsv.exe | select -exp source)`
- ListDlls
    - `listdlls.exe winlogon.exe`
- SigCheck
    - `sigcheck.exe -m C:\Windows\System32\schtasks.exe`

#### Handle
- E.g. `C:\Windows\System32\en-US\spoolsv.exe.mui`

```cmd
handle -a $(gcm spoolsv.exe | select -ExpandProperty source)
gps spoolsv
handle -p <pid>
```