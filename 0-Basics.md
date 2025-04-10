# PS Fundamentals

**Explore:** [Home](/README.md) [Regex](/0-Regex.md)


## File System Navigation
- Get-Location (pwd/gl) ∙∙∙∙∙∙∙∙∙∙∙ Set-Location (cd/sl)
- New-Item (ni/mkdir) ∙∙∙∙∙∙∙∙∙∙∙ Get-Content (gc/cat/type)
- Move-Item (mv/mi/move) ∙∙∙∙∙∙∙∙∙∙∙ Copy-Item (cp/cpi/copy) ∙∙∙∙∙∙∙∙∙∙∙ Remove-Item (rm/ri/del)

## Cmdlets
- Get-ChildItem (gci/ls) ∙∙∙∙∙∙∙∙∙∙∙ Get-Member (gm)
- `Where-Object <prop> -eq <val>` (?) ∙∙∙∙∙∙∙∙∙∙∙ `Select-Object <prop1,prop2>` (select)
- Measure-Object (measure) ∙∙∙∙∙∙∙∙∙∙∙ Sort-Object (sort)
- ForEach-Object (%/foreach)
- `Get-Help <cmd> -ShowWindow` [??] ∙∙∙∙∙∙∙∙∙∙∙ `Get-Command -Type Cmdlet` (gcm)
  - `Get-Alias -Definition <cmd>` (gal)
  - `New-Alias <name> <val>` (nal) ∙∙∙∙∙∙∙∙∙∙∙ Set-Alias (sal) ∙∙∙∙∙∙∙∙∙∙∙ `Set-Location Alias:`
- Compare-Object (diff)
- ConvertTo-Json
- `Format-Table  <prop1,prop2>` (ft) ∙∙∙∙∙∙∙∙∙∙∙ Format-List (fl)
- Out-File ∙∙∙∙∙∙∙∙∙∙∙ Write-Output (echo) ∙∙∙∙∙∙∙∙∙∙∙ Write-Host [print]
- Start-Sleep
- More ∙∙∙∙∙∙∙∙∙∙∙ `Out-Host -Paging` (oh)

#### Examples ‣
```pwsh
gci ~/Downloads | ? {$_.Name -like "*.jpg"}
gci -Recurse -File | % { Write-Host $_.FullName; gc $_.FullName }
Get-PSReadLineOption | % HistorySavePath | gi                         # Find history file (prev. commands)
```


### Get
- Get-Item (gi) ∙∙∙∙∙∙∙∙∙∙∙ Set-Item (si)
- Get-History (h/ghy/history)
- Get-Variable (gv) ∙∙∙∙∙∙∙∙∙∙∙ Get-Verb
- Get-Date ∙∙∙∙∙∙∙∙∙∙∙ Get-ExecutionPolicy


### Processes
- `Get-Process (gps/ps) [-Id]` ∙∙∙∙∙∙∙∙∙∙∙ Stop-Process (kill)

#### Examples ‣
```pwsh
gps | gm | ? Membertype -eq Method
gps | gm | ? {$_.MemberType -cmatch "Method"}
gps | gm -MemberType property | measure
```


### Services
- Get-Service (gsv)
- sc (PS v7) ∙∙∙∙∙∙∙∙∙∙∙ sc.exe (PS v5.1)

#### Examples

```pwsh
gsv | ? StartType -eq Automatic | select Name | Out-String
gsv | ? {$_.Status -eq 'Running'} | ft Name,StartType,Status
```


### CIM[^1][^2]
- Get-CimInstance ∙∙∙∙∙∙∙∙∙∙∙ Get-WmiObject (gwmi)

```pwsh
gwmi Win32_Processor
gwmi Win32_Service | ? {$_.Name -like 'Lego' }
```

```pwsh
wmic nteventlog list brief
```


### PS Profiles
```pwsh
Test-Path $PROFILE
New-Item -ItemType File -Path $PROFILE -Force    # If ^ false
notepad $PROFILE
# nal ?? Get-Help
Set-ExecutionPolicy RemoteSigned CurrentUser    # Re-open terminal or source w/ `. $PROFILE`
```


### Remoting

```pwsh
ssh <username>@<ip/host>
gi WSMan:\localhost\client\TrustedHosts
si WSMan:\localhost\client\TrustedHosts "Server0,127.0.0.1"    # Unsafe operation; '-Concatenate' appends
Enter-PSSession <computerName>
```
___

[^1]: CIM - Common Information Model
[^2]: WMI - Windows Mgmt Instrumentation Command Line
