# PS Fundamentals
**Related:** [Regex](/Regex/Readme.md)

## Common Variables ‣
- $PSVersionTable ∙∙∙∙∙ $PSHome ∙∙∙∙∙ $env:PATH ∙∙∙∙∙ $HOME ∙∙∙∙∙ $PROFILE
- `$_` = $PSItem (current obj. in pipeline)
- *Last command:*  `$?` (exec. status) ∙∙∙∙∙ `$^` (1st token) ∙∙∙∙∙ `$$` (last token)

## Common Commands
- systeminfo ∙∙∙∙∙ ipconfig ∙∙∙∙∙ help
- hostname ∙∙∙∙∙ whoami ∙∙∙∙∙ gdr

## Common Cmdlets
- `Get-Help <cmd> -ShowWindow` [??] ∙∙∙∙∙ Get-Command
  - Get-Service (gsv) ∙∙∙∙∙ Get-Process (gps) ∙∙∙∙∙ Get-Member (gm)
  - `Get-Alias -Definition <cmd>` (gal)
  - `New-Alias <name> <val>` (nal) ∙∙∙∙∙ Set-Alias (sal)
- Write-Output (echo) ∙∙∙∙∙ Write-Host [print]
- Get-ChildItem (gci/ls) ∙∙∙∙∙ Get-Content (type)
- `Where-Object <prop> -eq <val>` (?) ∙∙∙∙∙ `Select-Object <prop1,prop2>` (select)
- Format-List (fl) ∙∙∙∙∙ `Format-Table  <prop1,prop2>` (ft)
- `Out-Host -Paging` (oh) ∙∙∙∙∙ More
- Get-ExecutionPolicy ∙∙∙∙∙ `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`

