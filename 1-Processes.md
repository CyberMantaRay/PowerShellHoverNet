# Windows Processes & Services

**Explore:** [Home](/README.md) [Basics](/0-Basics.md)

## Processes
- `Get-Process (gps/ps) [-Id]` ∙∙∙∙∙∙∙∙∙∙∙ Stop-Process (kill)

#### Examples ‣
```pwsh
(Get-Process).Name
gps services,winit                                  # Exact matches only
gps | findstr /i service                            # Search for str in process names
gps | select name,id,path | sort id
gps | select name,id,path | ? {$_.path -notlike 'C:\Win*'}
gps chrome | % {$_.Modules} | sort -Desc size
```

```cmd
tasklist /svc
tasklist /fo:table | more      # /fo:{table|list|csv} (formatting types)
tasklist /fi "IMAGENAME eq lsass.exe"          # Filter for specific process
tasklist /m                    # /m - displays modules/dll to processes
tasklist /m /fi "IMAGENAME eq chrome.exe" | more
```


## Services
- Get-Service (gsv)
- sc (PS v7) ∙∙∙∙∙∙∙∙∙∙∙ sc.exe (PS v5.1) ∙∙∙∙∙∙∙∙∙∙∙ services.msc (gui)

#### Examples

```pwsh
gsv | ? {$_.DisplayName -like '*Defender*'}
gsv | ? StartType -eq Automatic | select Name | Out-String
gsv | ? {$_.Status -eq 'Running'} | ft Name,StartType,Status
```

