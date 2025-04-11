# PS Profiles

**Explore:** [Home](/README.md) [Basics](/0-Basics.md)

| Precedence (↑ to ↓) | Path |
| --- | --- |
| All Users, All Hosts | $PsHome\Profile.ps1 |
| All Users, Current Host | $PsHome\Microsoft.PowerShell_profile.ps1|
| Current User, All Hosts | $Home\[My]Documents\Profile.ps1 |
| Current User, Current Host | $Home\[My ]Documents\WindowsPowerShell\Profile.ps1 |W

```pwsh
Get-Help about_Profiles

Test-Path -Path $profile.currentusercurrenthost
Test-Path -Path $profile.alluserscurrenthost
Test-Path -Path $profile.currentuserallhosts
Test-Path -Path $profile.allusersallhosts


Test-Path $PROFILE
New-Item -ItemType File -Path $PROFILE -Force    # If ^ false
notepad $PROFILE
# nal ?? Get-Help
Set-ExecutionPolicy RemoteSigned CurrentUser    # Re-open terminal or source w/ `. $PROFILE`
```
