# Host Enumeration
**Explore:** [Home](/README.md) [Basics](/0-Basics.md) [HostEnum::Linux](https://github.com/CyberMantaRay/BashBalanceBeam/blob/trunk/4-HostEnum.md)

## General

- `date /t` ∙∙∙∙∙∙∙∙∙∙∙ `time /t`
- hostname ∙∙∙∙∙∙∙∙∙∙∙ whoami ∙∙∙∙∙∙∙∙∙∙∙ systeminfo

## User
- net user ∙∙∙∙∙∙∙∙∙∙∙ net use
- net localgroup \[administrators]


## Network
- ipconfig /all ∙∙∙∙∙∙∙∙∙∙∙ ipconfig /displaydns
- route print ∙∙∙∙∙∙∙∙∙∙∙ netstat -ant ∙∙∙∙∙∙∙∙∙∙∙ `netstat -anob`*


## Locations
- Explorer → view → hidden items
  - Check users documents,downloads,desktops
  - `%AppData%\Microsoft\Windows\Recent`
    - C:\Users\\\<usr>\AppData\Roaming\Microsoft\Windows\Recent
    - C:\Users\\\<usr>\Recent   (Alias?)
  - **Note:** \<usr> as shown in command prompt 
- `dir C:\Windows\prefetch`* = see executables ran
- dir /a:h
- dir /o:d /t:w c:\windows\temp
- dir /o:d /t:w c:\windows\system32
- dir /o:d /t:w c:\windows\system32\winevt\logs
- `reg query hklm\software\microsoft\windows\currentversion\run /s` and runonce (+ hkcu)
- reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\KnownDLLs"


## Process/Services
- tasklist /v
- tasklist /svc
- tasklist /svc | findstr /i "PID"
- Services.msc ( gui )
- `for /f "tokens=2 delims='='" %a in ('wmic service list full^|find /i "pathname"^|find /i /v "system32"') do @echo %a`
- sc query <service name>

## Schtasks
- task sch ( gui )
- schtasks /query 
- schtasks /query /fo LIST /v

```cmd
auditpol /get /category:* | findstr /i "success failure"
```
_____

- **\*** requires admin
