# POSH-Ubiquiti
Powershell tools for Ubiquiti Unifi

From https://github.com/justingist/POSH-Ubiquiti

Easy decryption of the .unf Unifi backup file!

Usage:

```
Set-ExecutionPolicy Unrestricted -Scope Process
Import-Module .\PoshUBNT.psm1
Invoke-UniFiBackupDecryption -FilePath C:\Temp\pathtomybackup.unf
```

An unencrypted .tar.gz will appear next to your backup. Please ensure you have write access to this directory!
