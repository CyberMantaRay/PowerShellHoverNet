# PS Regex
**Related:** [Fundamentals](/Fundamentals/Readme.md)

## Cmdlets
- Select-String (sls): `sls <pattern> <path>`
- Measure-Object (measure)
- ForEach-Object (%)
- `Sort-Object -Unique` (sort) ∙∙∙∙∙ Get-Unique (gu)
- Out-String -Stream

## Examples
```powershell
sls -Path <./file.txt> -Pattern "<regex>" | Measure-Object
    # : Count occurences of <regex> (up to one per line)
sls ... -AllMatches "<regex>" | % {$_.Matches.Value} | measure
    # : Count ALL <regex> in file using -AllMatches and foreach (%)
```
