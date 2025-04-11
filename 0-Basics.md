# PS Fundamentals

**Explore:** [Home](/README.md) [Regex](/0-Regex.md)


## File System Navigation
- Get-Location (pwd/gl) ∙∙∙∙∙∙∙∙∙∙∙ Set-Location (cd/sl) ∙∙∙∙∙∙∙∙∙∙∙ Get-ChildItem (ls/gci)
- New-Item (ni/mkdir) ∙∙∙∙∙∙∙∙∙∙∙ Get-Content (gc/cat/type) ∙∙∙∙∙∙∙∙∙∙∙ Write-Output (echo)
- Move-Item (mv/mi/move) ∙∙∙∙∙∙∙∙∙∙∙ Copy-Item (cp/cpi/copy) ∙∙∙∙∙∙∙∙∙∙∙ Remove-Item (rm/ri/del)
- `gc -TotalCount x` (≈head) ∙∙∙∙∙∙∙∙∙∙∙ `gc -Tail x` ∙∙∙∙∙∙∙∙∙∙∙ `... | select -First x`

```pwsh
gci -Filter "*<partial_name>*" -Recurse
gci ~/Downloads | ? {$_.Name -like "*.jpg"}
gci -File -Hidden | ? { $_.Length -ne 0 }
gci -File -Recurse | % { Write-Host $_.FullName; gc $_.FullName }
```

## Cmdlets
-  Get-Member (gm) ∙∙∙∙∙∙∙∙∙∙∙ Get-Item (gi)
- `Where-Object <prop> -eq <val>` (?) ∙∙∙∙∙∙∙∙∙∙∙ `Select-Object <prop1,prop2>` (select)
- Measure-Object (measure) ∙∙∙∙∙∙∙∙∙∙∙ Sort-Object (sort)
- ForEach-Object (%/foreach)
- `Get-Help <cmd> -ShowWindow` [??] ∙∙∙∙∙∙∙∙∙∙∙ `Get-Command -Type Cmdlet` (gcm)
  - `Get-Alias -Definition <cmd>` (gal)
  - `New-Alias <name> <val>` (nal) ∙∙∙∙∙∙∙∙∙∙∙ Set-Alias (sal) ∙∙∙∙∙∙∙∙∙∙∙ `Set-Location Alias:`
- Compare-Object (diff)
- ConvertTo-Json
- `Format-Table  <prop1,prop2>` (ft) ∙∙∙∙∙∙∙∙∙∙∙ Format-List (fl)
- Out-File ∙∙∙∙∙∙∙∙∙∙∙ Write-Host [print]
- Start-Sleep
- More ∙∙∙∙∙∙∙∙∙∙∙ `Out-Host -Paging` (oh)

#### Examples ‣
```pwsh
Get-LocalUser | select name, sid
gps | gm | ? Membertype -eq Method
gps | gm | ? {$_.MemberType -cmatch "Method"}
gps | gm -MemberType property | measure
Get-FileHash ".\file.txt" -Algo SHA512
Get-PSReadLineOption | % HistorySavePath | gi                         # Find history file (prev. commands)
```


### Get
- Get-Item (gi) ∙∙∙∙∙∙∙∙∙∙∙ Set-Item (si) ∙∙∙∙∙∙∙∙∙∙∙ Get-Acl #permissions
- Get-History (h/ghy/history)
- Get-Variable (gv) ∙∙∙∙∙∙∙∙∙∙∙ Get-Verb
- Get-Date ∙∙∙∙∙∙∙∙∙∙∙ Get-ExecutionPolicy ∙∙∙∙∙∙∙∙∙∙∙ Get-PSDrive

```pwsh
(Get-Acl .\file).Access
```


## Processes
- `Get-Process (gps/ps) [-Id]` ∙∙∙∙∙∙∙∙∙∙∙ Stop-Process (kill)

#### Examples ‣
```pwsh
(Get-Process).Name
```


## Services
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

```cmd
wmic process list brief
wmic nteventlog list brief
wmic nicconfig list brief
wmic useraccount list brief
```

## Alt. Data Streams
- Default Stream = :$DATA
- Get-Item (gi) ∙∙∙∙∙∙∙∙∙∙∙ Set-Content (sc) ∙∙∙∙∙∙∙∙∙∙∙ Add-Content (ac)

```pwsh
echo "Hisui?" > pkmn-regions.txt
Set-Content .\pkmn-regions.txt -Value "Jhoto/Kanto" -Stream secret.crystal
Set-Content .\pkmn-regions.txt -Value "Hoenn" -Stream secret.emerald
Add-Content -Path .\pkmn-regions.txt -Value 'To protect the world from devastation.' -Stream 'secret.teamrocket'
Get-Item pkmn-regions.txt -Stream * | FileName, Stream, Length

Get-Content '.\pkmn-regions.txt:secret.crystal'          # Equiv. to below
Get-Content pkmn-regions.txt -Stream secret.crystal

Get-ChildItem -File -Recurse | gi -Stream * | ? { $_.Stream -ne ':$DATA'}      # Single quotes important; double quotes will interpret vars
```


## Remoting

```pwsh
ssh <username>@<ip/host>
gi WSMan:\localhost\client\TrustedHosts
si WSMan:\localhost\client\TrustedHosts "Server0,127.0.0.1"    # Unsafe operation; '-Concatenate' appends
Enter-PSSession <computerName>
Invoke-Command <compName/connUri> <scriptfilepath>
Invoke-Command -ComputerName File-Server {Get-Service}
Invoke-Command -ComputerName File-Server,comp-x,... {Get-Service} -asjob
Receive-Job <job #>
```

## Tidbits
- `C:\Windows\System32\drivers\etc\hosts` - maps hostnames to ip addresses
___

## Command Prompt
```cmd
set
dir /ah
net use
net user
```


[^1]: CIM - Common Information Model
[^2]: WMI - Windows Mgmt Instrumentation Command Line
