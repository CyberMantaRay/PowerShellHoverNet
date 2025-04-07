# Proof of Concepts

- **#encoding** For printing emojis/complex utf8 characters from a script file, use PowerShell 7+. After much debugging, doesn't seem possible in PowerShell 5.1.26100. [./encoding.ps1](/poc/encoding.ps1)
    - `winget search Microsoft.PowerShell`
    - `winget install --id Microsoft.PowerShell --source winget`
    - [Install PowerShell using WinGet](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.5#install-powershell-using-winget-recommended)
    - [Differences between Windows PowerShell 5.1 and PowerShell 7.x](https://learn.microsoft.com/en-us/powershell/scripting/whats-new/differences-from-windows-powershell?view=powershell-7.5)