# PS Fundamentals

**Explore:** [Home](/README.md) [Regex](/0-Regex.md) [.NET Types](/1-.NetTypes.md)


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
- `Select-Object <prop1,prop2>` (select)
  - Calculated Property @{...}: `select Attr, @{n='ColName';e={calculate($_.prop)}}`
- `Where-Object <prop> -eq <val>` (?) ∙∙∙∙∙∙∙∙∙∙∙ 
- Measure-Object (measure) ∙∙∙∙∙∙∙∙∙∙∙ Sort-Object (sort)
- ForEach-Object (%/foreach)
- `Get-Help <cmd> -ShowWindow` [??] ∙∙∙∙∙∙∙∙∙∙∙ `Get-Command -Type Cmdlet` (gcm)
  - `Get-Alias -Definition <cmd>` (gal)
  - `New-Alias <name> <val>` (nal) ∙∙∙∙∙∙∙∙∙∙∙ Set-Alias (sal) ∙∙∙∙∙∙∙∙∙∙∙ `Set-Location Alias:`
- Compare-Object (diff)
- ConvertTo-Json
- `Format-Table  <prop1,prop2>` (ft)
  - `ft @{label='Username';expression={$_.SamAccountName}; width=25; alignment='left'}` - Abbr. each comp. w/ 1st letter, e.g. w=width
- Format-List (fl)
- Out-File ∙∙∙∙∙∙∙∙∙∙∙ Write-Host [print]
- Start-Sleep
- More ∙∙∙∙∙∙∙∙∙∙∙ `Out-Host -Paging` (oh)

#### Examples ‣
```pwsh
scp -r C:\Users\<localuser>\SysinternalsSuite <remoteuser>@ip.addr:\Users\Public\Downloads

gps | gm | ? Membertype -eq Method
gps | gm | ? {$_.MemberType -cmatch "Method"}
gps | gm -MemberType property | measure
Get-FileHash ".\file.txt" -Algo MD5                 # Def. SHA256
Get-PSReadLineOption | % HistorySavePath | gi                         # Find history file (prev. commands)

Get-ADUser -Filter * -Property accountExpires | select Name, @{name='Expiration'; expression={[datetime]::FromFileTime($_.accountExpires)}}
```


### Get
- Get-Item (gi) ∙∙∙∙∙∙∙∙∙∙∙ Set-Item (si) ∙∙∙∙∙∙∙∙∙∙∙ Get-Acl #permissions
- Get-History (h/ghy/history)
- Get-Variable (gv) ∙∙∙∙∙∙∙∙∙∙∙ Get-Verb
- Get-ScheduledTask
- Get-Date ∙∙∙∙∙∙∙∙∙∙∙ Get-ExecutionPolicy ∙∙∙∙∙∙∙∙∙∙∙ Get-PSDrive

```pwsh
(Get-Acl .\file).Access
```

## CIM[^1][^2]
- Get-CimInstance ∙∙∙∙∙∙∙∙∙∙∙ Get-WmiObject (gwmi)
- [1-Processes & Services.md](/1-Processes.md)

```pwsh
gwmi Win32_Processor
gwmi Win32_Service | ? {$_.Name -like 'Lego' }
Get-CimInstance win32_service | select name,processid,pathname | sort processid | ft -wrap
Get-CimInstance win32_process | select name,processid,parentprocessid,path | sort processid
```

```cmd
wmic process list brief
wmic nteventlog list brief
wmic nicconfig list brief
wmic useraccount list brief
```

## Alt. Data Streams
- Default Stream = :$DATA
- `dir /r`
- Get-Item (gi) ∙∙∙∙∙∙∙∙∙∙∙ Set-Content (sc) ∙∙∙∙∙∙∙∙∙∙∙ Add-Content (ac)

```pwsh
echo "Hisui?" > pkmn-regions.txt
Set-Content .\pkmn-regions.txt -Value "Jhoto/Kanto" -Stream secret.crystal
Set-Content .\pkmn-regions.txt -Value "Hoenn" -Stream secret.emerald
Add-Content .\pkmn-regions.txt 'To protect the world from devastation.' -Stream 'secret.teamrocket'
Get-Item pkmn-regions.txt -Stream * | select fileName,stream,length

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
Receive-Job <job_num>
```

## Tidbits
- `C:\Windows\System32\drivers\etc\hosts` - maps hostnames to ip addresses
___

## Command Prompt
```cmd
type file.txt
dir /s /b /a:d /o:-d /t:[cwa]        # Abbr. switches, e.g. /a:d = /ad
netstat -anob | findstr :6666        # (or Get-NetTCPConnection)
tasklist /fi /m "PID eq XXXX"

net start
sc query
set
dir /ah
dir /S *searchstr*
net user

net use S: \\live.sysinternals.com@80\tools                # vs. 'net use * https://live.sysinternals.com' ?
net use Z: /delete
```

- [dir | MSLearn](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/dir)

[^1]: CIM - Common Information Model (Modern)
[^2]: WMI - Windows Mgmt Instrumentation (Legacy)
