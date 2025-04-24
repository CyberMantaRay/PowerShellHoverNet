# Windows Artifacts & Audit

**Explore:** [Home](/README.md) [Basics](/0-Basics.md)

```cmd
systeminfo
wmic useraccount get name,sid
```
```pwsh
glu | select Name,SID
gwmi win32_useraccount | select name,sid
Get-ComputerInfo | select osname,osversion,OsHardwareAbstractionLayer
```

## UserAssist
- [Rot13 | CyberChef](https://gchq.github.io/CyberChef/#recipe=ROT13(true,true,false,13))
```pwsh
# CEBFF5CD: Executable File Execution
gp "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist\{CEBFF5CD-ACE2-4F4F-9178-9926F41749EA}\Count"
# F4E57C4B: Shortcut File Execution
gp "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist\{F4E57C4B-2036-45F0-A9AB-443BCFE33D9F}\Count"
```

## BAM - Background Activity Monitor

```pwsh
gi HKLM:\SYSTEM\CurrentControlSet\Services\bam\state\UserSettings\*                # Every user
gi HKLM:\SYSTEM\CurrentControlSet\Services\bam\state\UserSettings\<SID>            # Single user
```

## Recycle Bin
- $I=metadata, $R=contents

```pwsh
gci 'C:\$RECYCLE.BIN' -Recurse -Verbose -Force | select FullName            # System Recycle Bin
gc 'C:\$Recycle.Bin\<sid>\$I*'
gc 'C:\$Recycle.Bin\<sid>\$R*'
gci -Recurse -Force -Filter '$R*' | % { $c=(gc $_.FullName) -replace "[^\w\.\:\\/ ]",""; if ($c -match "targetstr") { echo "`n---- $($_.Name) ----"; $c } }
```

## Prefetch

```pwsh
gci 'C:\Windows\Prefetch' -ErrorAction Continue | select -First 50
```

## Jumplists

```pwsh
# Programs/Items that were recently used
gci -Recurse C:\Users\*\AppData\Roaming\Microsoft\Windows\Recent -ErrorAction silentlyContinue | select FullName, LastAccessTime
gci -Recurse C:\Users\<user>\AppData\Roaming\Microsoft\Windows\Recent -ErrorAction SilentlyContinue | select CreationTime,FullName |ft -wrap
gci -Recurse C:\Users\<user>\AppData\Roaming\Microsoft\Windows\Recent -ErrorAction SilentlyContinue | select LastAccessTime,FullName |ft -wrap
#or
gci -Recurse $env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Recent -ErrorAction SilentlyContinue | select LastAccessTime,FullName | ft -wrap

$result = (gci -Recurse C:\Users\*\AppData\Roaming\Microsoft\Windows\Recent -ErrorAction SilentlyContinue | cat) -replace "[^\w\:\.\\]",""
$result | sls -Pattern "C:\\[\w\.\\]+\.[a-zA-Z]{3}" -AllMatches | % { $_.Matches.Groups[0].Value } | ft
```

## Recent Files
- Tracks last 150 files/directories opened
- Location: `HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs`

```pwsh
gci 'Registry::\HKEY_USERS\*\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs\.*'
gci 'Registry::\HKEY_USERS\*\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs\.txt'

# Converting a Single Value from Hex to Unicode
[System.Text.Encoding]::Unicode.GetString((gp "REGISTRY::HKEY_USERS\*\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs\.txt")."1")

# Convert All Files
gi "REGISTRY::HKEY_USERS\*\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs\.txt" | select -Expand property | % {
    [System.Text.Encoding]::Default.GetString((gp -Path "REGISTRY::HKEY_USERS\*\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs\.txt" -Name $_).$_)
}
```

## Browser Artifacts

```pwsh
strings.exe 'C:\users\<user>\AppData\Local\Google\Chrome\User Data\Default\History' -accepteula
strings.exe 'C:\users\<user>\AppData\Local\Google\Chrome\User Data\Default\Top Sites'                               # Most Visited
strings.exe  'C:\users\<user>\AppData\Local\Google\Chrome\User Data\Default\Login Data' | findstr -i "https*"       # User Names

# Find FQDNs in Sqlite Text files
$History = (gc 'C:\Users\*\AppData\Local\Google\Chrome\User Data\Default\History') -replace "[^\w\.\:\/]",""
$History | sls -Pattern "(https|http):\/\/[a-zA-Z_0-9]+\.\w+[\.]?\w+[\.]?\w+" -AllMatches | % {$_.Matches.Groups[0].Value} | ft
```

## Audit
```cmd
auditpol /get /category:*
auditpol /get /category:"Object Access"                          &:: View Subcategory
auditpol /set /subcategory:"File System"                         &:: Sets it
auditpol /set /subcategory:"File System" /success:disable        &:: Clears It
```

## Event Logs
- **Core:** Application ∙∙∙∙∙∙∙∙∙∙∙ System ∙∙∙∙∙∙∙∙∙∙∙ Security
- 100+ Windows logs and third-party apps can create their own
```cmd   
wevtutil el                              &:: Show all logs
wevtutil gli security                    &:: Get security log info
wevtutil qe security /c:3 /f:text        &:: Get last 3 events from security log
```

```pwsh
#Finding Log Type to Query
Get-WinEvent -Listlog * | sort -Descending RecordCount

#Last 10 entries in System Log
Get-EventLog -LogName System -Newest 10
Get-EventLog -LogName System -Newest 10 | ft -wrap
Get-EventLog -LogName System | ft -wrap

#Search the event logs and show the entire message
Get-Eventlog -LogName Security | ft -wrap

#Search for a String
Get-Eventlog -LogName Security | ft -wrap | findstr /i $tR1nG
Get-Eventlog -LogName Security | ft -wrap | findstr /i "An attempt was made to access an object."

#Checking If a User Logged on
Get-Winevent -FilterHashtable @{logname='Security';id='4624'} | ft -Wrap
Get-Winevent -FilterHashtable @{logname='Security';id='4624'} | ft -Wrap | findstr /i "generated"

#Checking Powershell Operational Logs
Get-WinEvent Microsoft-Windows-PowerShell/Operational | ? {$_.Message -ilike "*Out-Default*"} | fl

Get-WinEvent Microsoft-Windows-PowerShell/Operational | ? {$_.Message -ilike "*Pipeline ID = 4103"} | fl
```

## Script Block Logging

```pwsh
reg add HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging\ /v EnableScriptBlockLogging /t REG_DWORD /d 1 /f
```
