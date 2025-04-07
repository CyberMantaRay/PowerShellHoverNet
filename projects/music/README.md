# Music-Related PowerShell Projects

## Scripts
- Fretboard Trainer !DONE
- Ear Training Quiz !IP
- NOTE: Developed using PS v5.1.22621.4391.

## APIs
- `[System.Console]::ReadKey($true)`
- `[console]::beep(frequency, duration)`
- `[System.Media.SystemSounds]::Exclamation.Play()`
- `[System.Media.SystemSounds] | Get-Member -Static -MemberType Property | Select-Object -ExpandProperty Name`
- System.Media.SoundPlayer, e.g. WAV
- System.Media.SystemSounds, e.g. Asterisk, Beep, Exclamation, Hand, Question

## Resources
- [Note Frequencies | AuditoryNeuroscience](https://auditoryneuroscience.com/pitch/fundamental-frequencies-notes-western-music)
- [Western Notes Frequency Chart | Mixbutton](https://mixbutton.com/music-tools/frequency-and-pitch/music-note-to-frequency-chart)
- [Functions | PoSh Docs](http://learn.microsoft.com/en-us/powershell/scripting/learn/ps101/09-functions?view=powershell-5.1)
- [Switch Statements](https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-switch?view=powershell-5.1)

## Challenges Encountered
1. "Exception calling "ReadKey" with "1" argument(s): "Cannot read keys when either application does not have a console or when 
console input has been redirected from a file. Try Console.Read."
    - <_Solution: Use PowerShell (Console) for running interactive scripts, i.e. not PowerShell ISE_>
2. Issues with emoji display in powershell terminal (v5.1.26100.2161) - [UTF-8 Encoding in PowerShell](https://stackoverflow.com/questions/57131654/using-utf-8-encoding-chcp-65001-in-command-prompt-windows-powershell-window)
    - <_Solution: Upgrade to PowerShell 7+ (pwsh.exe)_> [See POCs. #encoding](/poc/)