# PS Regex
**Related:** [Basics](/0-Basics.md)

## Cmdlets
- Select-String (sls): `sls <pattern> <path>`
- Measure-Object (measure)
- ForEach-Object (%)
- `Sort-Object -Unique` (sort) ∙∙∙∙∙∙∙ Get-Unique (gu)
- Out-String -Stream

## Examples
```powershell
$str -Match "<regex>"
$str | sls "<regex>"

sls -Path <./file.txt> -Pattern "<regex>" -CaseSensitive | Measure-Object
    # : Count occurences of <regex> (up to one per line)
sls "<regex>" <path/file> -AllMatches | % {$_.Matches.Value} | measure
    # : Count ALL <regex> in file using -AllMatches and foreach (%)
sls "\(\d{3}\)" ... | % {$_.Matches.Value} | sort -Unique | measure
    # : Count unique area codes in a list of phone numbers
```

## Tips
- Understand the raw output of each command in the pipeline. Does sls output only the matched text?

## Learn Regex
- [RegexOne](https://regexone.com/)
- [RegexLearn](https://regexlearn.com/)
- [HackerRank](https://www.hackerrank.com/domains/regex)
- [Regex101](https://regex101.com/)
- [RegexCrossword](https://regexcrossword.com/)
