# Windows Boot Process
**Explore:** [Home](/README.md) [Profiles](/2-Profiles.md)

## bcdedit

```cmd
bcdedit /?
bcdedit /export C:\Lion_BCD                              # Backup
bcdedit /import C:\Lion_BCD                              # Restore BCD settings
bcdedit /set {<identifier>} description "Windows 7 - Lion Den"
bcdedit /deletevalue {current} safeboot

bcdedit /create {ntldr} /d "Windows XP Pro SP2 - Tiger Paw"
bcdedit /set {ntldr} device partition=C:
bcdedit /set {ntldr} path \ntldr
bcdedit /displayorder {ntldr} /addfirst
bcdedit /delete {ntldr} /f                                # Delete legacy system
```

## UEFI/BIOS
```cmd
msinfo32.exe                                        # Check BIOS Mode
gc C:\Windows\Panther\Setupact.log | sls "Callback_BootEnvironmentDetect"
bcdedit | findstr /i winload                        # winload.efi=UEFI; winload.exe=BIOS
```
