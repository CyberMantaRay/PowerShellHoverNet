# PS Fundamentals
**Related:** [Home](/README.md) [Regex](/0-Regex.md)

## Cmdlets
- `Get-Help <cmd> -ShowWindow` [??] ∙∙∙∙∙∙∙ Get-Command
  - Get-Process (gps) ∙∙∙∙∙∙∙ Get-Service (gsv) ∙∙∙∙∙∙∙ Get-Member (gm)
  - `Get-Alias -Definition <cmd>` (gal)
  - `New-Alias <name> <val>` (nal) ∙∙∙∙∙∙∙ Set-Alias (sal)
  - `Set-Location Alias:` ∙∙∙∙∙∙∙ Get-Item
- Write-Output (echo) ∙∙∙∙∙∙∙ Write-Host [print] ∙∙∙∙∙∙∙ Out-File
- Get-ChildItem (gci/ls) ∙∙∙∙∙∙∙ Get-Content (type)
- `Where-Object <prop> -eq <val>` (?) ∙∙∙∙∙∙∙ `Select-Object <prop1,prop2>` (select)
- ConvertTo-Json
- Format-List (fl) ∙∙∙∙∙∙∙ `Format-Table  <prop1,prop2>` (ft)
- `Out-Host -Paging` (oh) ∙∙∙∙∙∙∙ More
- Get-Date ∙∙∙∙∙∙∙ Start-Sleep
- Get-ExecutionPolicy ∙∙∙∙∙∙∙ `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`

## Examples ‣
```powershell
gps | gm | ? Membertype -eq Method
gci ~/Downloads | ? {$_.Name -like "*.jpg"}
gsv | ? StartType -eq Automatic | select Name | Out-String
gsv | ? {$_.Status -eq 'Running'} | ft Name,StartType,Status
```
