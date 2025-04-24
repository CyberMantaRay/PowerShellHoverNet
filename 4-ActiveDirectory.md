# Active Directory
**Explore:** [Home](/README.md) [Basics](/0-Basics.md)

```cmd
gpresult /?
gpresult /r                  &:: Display data about machine & logged on use
gpresult /user * /v          &:: Fetch group policy settings; /v for verbose, detailed
gpupdate /force              &:: Force group policy update w/o reboot
```

## Fields
- Def. 10
  - SID ∙∙∙∙∙∙∙∙∙∙∙ ObjectClass ∙∙∙∙∙∙∙∙∙∙∙ ObjectGUID ∙∙∙∙∙∙∙∙∙∙∙ Enabled (bool)
  - DistinguishedName : CN=Ash.Ketchum,OU=LEAGUECHALLENGERS,OU=PALLET,DC=kanto,DC=challengers
    - CN=CanonicalName ∙∙∙∙∙∙∙∙∙∙∙ OU=OrgUnit ∙∙∙∙∙∙∙∙∙∙∙ DC=DomainComponent
  - GivenName ∙∙∙∙∙∙∙∙∙∙∙ Name ∙∙∙∙∙∙∙∙∙∙∙ Surname ∙∙∙∙∙∙∙∙∙∙∙ SamAccountName ∙∙∙∙∙∙∙∙∙∙∙ UserPrincipalName
- #SID [Security Identifier](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-security-identifiers)
  - S-1-5-32-544
    - S-1 = SID v1
    - 5 = NT Authority
    - 32 = Domain id (32=builtin); S-1-5-_21-1004336348-1177238915-682003330_-512 domain id?
    - 544 = RID Relative Identifier (544=admins)
- #accountExpires
  - 0 = never expires
  - 9223372036854775807 = max val, also means never expires
- #userAccountControl (bitmask flags)
  - Bit 0x0080 (128)		PASSWORD_ENCRYPTED_TEXT_ALLOWED		Password stored w/ reversible encryption

## Commands
- `Get-Command -Module ActiveDirectory`
- Get-ADDomain ∙∙∙∙∙∙∙∙∙∙∙ Get-ADForest
- Get-ADUser ∙∙∙∙∙∙∙∙∙∙∙ New-ADUser
- Set-ADAccountPassword ∙∙∙∙∙∙∙∙∙∙∙ Get-ADDefaultDomainPasswordPolicy
- Enable-ADAccount ∙∙∙∙∙∙∙∙∙∙∙ Disable-ADAccount
- Get-ADGroup ∙∙∙∙∙∙∙∙∙∙∙ Add-ADGroupMember ∙∙∙∙∙∙∙∙∙∙∙ Remove-ADGroupMember
- Search-ADAccount
  - -AccountExpired ∙∙∙∙ -AccountDisabled ∙∙∙∙ -PasswordNeverExpires ∙∙∙∙ -LockedOut ∙∙∙∙ -PasswordExpired
- \--------------------------------------------------
- Invoke-Item (ii)

```pwsh
(Get-ADDomain).NetBIOSName
(Get-ADDomain).DNSRoot
Get-ADForest | select -ExpandProperty Domains | % { Get-ADDomain -Identity $_ | select Name, NetBIOSName }

Get-ADGroupMember -Identity "Domain Admins"              # For direct members only; use -Recursive for membership via sub-group
Get-ADGroupMember -Identity "Domain Admins" -Recursive | ? {$_.objectclass -eq "user"} | measure

# -------------------------------------------------

Get-ADUser <user>                           # Search for single user
Get-ADUser -Filter *                        # Search for multiple users/list of users (def. 10 fields)
Get-AdUser -Filter * -Properties *          # '-Properties *' displays all fields under user(s)

Get-ADUser -Filter {OfficePhone -like '706*'}                                        # Filter by field doesn't display it
Get-ADUser -Filter {Enabled -eq "false"} -Properties name,enabled                    # Find disabled users (-prop flag redundant)
Get-ADUser -Filter {Description -like '*searchfor*'} -Properties Description         # Filter by AND display field (11 total)
Get-ADUser -Filter {(accountExpires -eq 1) -and (Enabled -eq "true")}

Get-ADUser -Filter {Name -like '*admin*'} | select Name,SID,Description | fl         # Display specific fields from results
# NOTE: A field must be available via '-Properties' to be selected

Search-ADAccount -UsersOnly -AccountExpired | ? { $_.Enabled -eq $true }             # Be explicit when bool val not guaranteed, i.e. -eq $true
Search-ADAccount -UsersOnly -SearchBase "OU=CHALLENGERS,DC=league,DC=kanto" | ? { $_.Enabled }        # Safe when bool val guaranteed

Get-ADUser -Filter * -Properties accountExpires, Enabled | ? {
    $_.Enabled -eq $true -and $_.accountExpires -ne 0 -and
    $_.accountExpires -ne 9223372036854775807 -and
    [datetime]::FromFileTime($_.accountExpires) -lt (Get-Date)
} | select Name, Enabled, @{n="Expiration";e={[datetime]::FromFileTime($_.accountExpires)}}

Get-ADUser -Filter {(emailaddress -notlike "*@teamrocket.org")} -Properties emailaddress
Get-ADUser -Filter * -Properties EmailAddress | ? {($_.emailaddress -notlike "*@teamrocket.org")} | ft name,emailaddress
Get-ADUser -Filter {(officephone -like '*1234') -or (homephone -like '*1234')} -Properties officephone,homephone
Get-ADUser -Filter * -Properties userAccountControl | ? {($_.userAccountControl -band 128) -eq 128} | select Name, userAccountControl


# -------------------------------------------------

Set-ADAccountPassword -Identity guest
Set-AdAccountPassword -Identity guest -NewPassword (ConvertTo-SecureString -AsPlaintext -String "SecurePass12345!!" -Force)

Add-ADGroupMember -Identity "Domain Admins" -Members <user>          # Add to Domain Group

Enable-ADAccount -Identity guest

# --- Create user, set pass, enable, add to group ---------------------
Get-ADUser -Filter * | select distinguishedname,name              # Get naming convention samples
New-ADUser -Name "Ash.Ketchum" -PasswordNotRequired 1 -path "OU=LEAGUECHALLENGERS,OU=PALLET,DC=challengers,DC=kanto"

# OR Create User & Set Password
New-ADUser -Name "Ash.Ketchum" -AccountPassword (ConvertTo-SecureString -AsPlaintext -String "SecurePass12345!!" -Force) -path "OU=LEAGUECHALLENGERS,OU=PALLET,DC=challengers,DC=kanto"

Remove-ADUser -Identity "Ash.Ketchum"
Remove-ADGroupMember -Identity "Domain Admins" -Members Ash.Ketchum
Disable-AdAccount -Identity Ash.Ketchum

# --------------------------------------------------------------------------

Get-ADGroupMember -identity "Domain Admins" -Recursive | % {Get-ADUser -identity $_.DistinguishedName} | select name,enabled
```
