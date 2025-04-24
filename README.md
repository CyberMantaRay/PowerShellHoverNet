# PowerShellHoverNet

**Explore:** [Basics](/0-Basics.md) [Regex](/0-Regex.md) [Diagnostics](/1-Diagnostics.md)

PowerShell Hover Net – A playground for PowerShell scripts (projects, experiments, & POCs)

### Environment
- PowerShell v7.5.0 (Core)

## Tips —
- `pwsh` to enter PS v7+/`powershell` to enter PS v5.1
- PowerShell is generally case-insensitive. Can lead to unexpected behavior.
- Parameters can be abbreviated if no conflict, e.g. `Get-Help <cmd> -ShowWindow` abbr. `get-help <cmd> -s`.

## Commands —
- systeminfo ∙∙∙∙∙ ipconfig ∙∙∙∙∙ hostname ∙∙∙∙∙ help ∙∙∙∙∙ whoami ∙∙∙∙∙ gdr

## Variables —
- $PSVersionTable ∙∙∙∙∙∙∙ $env:PATH ∙∙∙∙∙∙∙ $PSHome ∙∙∙∙∙∙∙ $HOME ∙∙∙∙∙∙∙ $PROFILE
- `$_` = $PSItem (current obj. in pipeline)
- *Last command:*  `$?` (exec. status) ∙∙∙∙∙∙∙ `$^` (1st token) ∙∙∙∙∙∙∙ `$$` (last token)
- $NULL ∙∙∙∙∙∙∙ $TRUE ∙∙∙∙∙∙∙ $FALSE
- $ERROR ∙∙∙∙∙∙∙ $ForEach ∙∙∙∙∙∙∙ $MATCHES ∙∙∙∙∙∙∙ $ARGS

## Resources —
- [🔧 PS Unit Testing Framework | Pester](https://pester.dev/docs/quick-start)
- [PoSh Cheatsheet | ab14jain](https://github.com/ab14jain/PowerShell)
- [PoSH Cheatsheet | StationX](https://www.stationx.net/powershell-cheat-sheet/)

## Other Repos —
- [BashBalanceBeam | CyberMantaRay](https://github.com/CyberMantaRay/BashBalanceBeam)
- [leetcode_rust | CoffeelessProgrammer](https://github.com/CoffeelessProgrammer/leetcode_rust)
- [Data-Structures-and-Algorithms-TS | CoffeelessProgrammer](https://github.com/CoffeelessProgrammer/Data-Structures-and-Algorithms-TS)
