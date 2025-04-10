# Windows Registries

**Explore:** [Home](/README.md) [Basics](/0-Basics.md)

## Registry Hives
- HKEY_USERS
  - HKEY_CURRENT_USER
- HKEY_LOCAL_MACHINE
  - HKEY_CURRENT_CONFIG
  - HKEY_CLASSES_ROOTS

#### PowerShell
- Get-ItemProperty (gp) ∙∙∙∙∙∙∙∙∙∙∙ Get-LocalUser (glu)

```pwsh
regedit.exe
glu | select name, sid
gci HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion
gi HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Run

cd Registry::            # Alt. registry nav method via cd; access subkeys/props:   'gci .'  'gi .'
```

#### Command Prompt
```cmd
reg /?
reg query hklm/software
```

_____

### HKEY_LOCAL_MACHINE (HKLM)
- HARDWARE
- SAM
- SECURITY (accessed by lsass.exe)
- SOFTWARE
  - `HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run` (Runs every system reboot)
  - `HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce` (Runs then deletes val every system reboot)
- SYSTEM
  - `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USBSTOR` - connected USB storage dvcs

### HKEY_USERS (HKU)
- <span title="Security Identifier">SID</span>, e.g. S-1-5-<48 bit number>
  - S (SID) ∙∙∙∙∙∙∙∙∙∙∙ 1 (Revision Level) ∙∙∙∙∙∙∙∙∙∙∙ <span title="5 means Active Directory">5 (Identifier Authority)</span>
  - 48 bit domain identifier (can hint at account types)
    - `S-1-5`-**18** - LocalSystem account
    - `S-1-5`-**19** - LocalService account
    - `S-1-5`-**20** - NetworkService account
    - `S-1-5`-**21-\<domain>-500** - local admin account

### HKEY_CURRENT_USER (HKCU)
- Dynamic Link to HKU SID of logged in user
- `HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run` (Runs every user login)
- `HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce` (Runs then deletes val every user login)

### HKEY_CURRENT_CONFIG (HKCC)
- Dynamic Link to `HKLM/SYSTEM/CurrentControlSet/Hardware Profiles/Current`

### HKEY_CLASSES_ROOT (HKCR)
- Dynamic link to `HKLM/Software/Classes`
