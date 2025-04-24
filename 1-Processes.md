# Windows Processes & Services

**Explore:** [Home](/README.md) [Basics](/0-Basics.md)

## Processes
- `Get-Process (gps/ps) [-Id]` ∙∙∙∙∙∙∙∙∙∙∙ Stop-Process (kill)

```pwsh
(Get-Process).Name
gps services,winit                                  # Exact matches only
gps | findstr /i service                            # Search for str in process names
gps | select name,id,path | sort id
gps | select name,id,path | ? {$_.path -notlike 'C:\Win*'}
gps chrome | % {$_.Modules} | sort -Desc size
```

#### Command Prompt

```cmd
tasklist /svc
tasklist /fo:table | more      # /fo:{table|list|csv} (formatting types)
tasklist /fi "IMAGENAME eq lsass.exe"          # Filter for specific process
tasklist /m                    # /m - displays modules/dll to processes
tasklist /m /fi "IMAGENAME eq chrome.exe" | more
```


## Services
- Get-Service (gsv)
- `HKLM:\SYSTEM\CurrentControlSet\Services`
- `HKLM:\SYSTEM\CurrentControlSet\Services\<service_name>\Parameters` - [subkey::ServiceDLL]

```pwsh
gsv *net*                    # Search svc NAME field for match
gsv <svc_name_displayname>   # Exact match only

gsv | ? DisplayName -like '*Defender*'
gsv | ? StartType -eq Automatic | select Name | Out-String
gsv | ? {$_.Status -eq 'Running'} | ft Name,StartType,Status
```

#### Command Prompt
- sc (PS v7) ∙∙∙∙∙∙∙∙∙∙∙ sc.exe (PS v5.1) ∙∙∙∙∙∙∙∙∙∙∙ services.msc (gui)

```cmd
net start
sc query state= all
sc query <svc_name>
sc qc <svc_name>                         &:: Svc config
sc qdescription <svc_name>
sc showsid <svc_name_displayname>        &:: Get SID, security identifier
```

