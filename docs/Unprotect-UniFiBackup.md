---
external help file: PSUniFi-help.xml
Module Name: PSUniFi
online version:
schema: 2.0.0
---

# Unprotect-UniFiBackup

## SYNOPSIS
Decrypt a UniFi Network Controller backup

## SYNTAX

```
Unprotect-UniFiBackup [-FilePath] <FileInfo> [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Decrypt a UniFi Network Controller backup

Original Script: https://github.com/justingist/POSH-Ubiquiti

Many thanks to this git repo for the key and basic logic!
https://github.com/zhangyoufu/unifi-backup-decrypt
Also AES credit: https://gist.github.com/ctigeek/2a56648b923d198a6e60

Output will be a tar.gz in same directory as your initial file.
Use your favorite archive tool to open, such as 7-zip.

## EXAMPLES

### EXAMPLE 1
```
Unprotect-UniFiBackup -FilePath C:\Temp\pathtomybackup.unf
```

## PARAMETERS

### -FilePath
File path to the UniFi Backup.
This must be the absolute file path.

```yaml
Type: FileInfo
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
{{ Fill Force Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
