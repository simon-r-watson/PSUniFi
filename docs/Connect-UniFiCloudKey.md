---
external help file: PSUniFi-help.xml
Module Name: PSUniFi
online version:
schema: 2.0.0
---

# Connect-UniFiCloudKey

## SYNOPSIS
Connect to a UniFi CloudKey

## SYNTAX

```
Connect-UniFiCloudKey -UniFiUri <String> -Username <String> -Password <SecureString> [-SkipCertificateCheck]
 [<CommonParameters>]
```

## DESCRIPTION
Connect to a UniFi CloudKey.
This utilises the API used by the controllers web interface.
The account used must be a local account on the controller

## EXAMPLES

### EXAMPLE 1
```
Connect-UniFiCloudKey -UniFiUri 'https://localhost' -Username 'admin' -Password (Read-Host -AsSecureString -Prompt 'Password') -SkipCertificateCheck
```

## PARAMETERS

### -UniFiUri
The Base URI of the UniFi CloudKey, such as "https://192.168.0.1"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Username
Your username for the UniFi CloudKey

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password
Your password for the UniFi CloudKey

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipCertificateCheck
Allow connections to instances using SSL/TLS certificates that are not trusted by the local machine this is running on. 
On Windows PowerShell 5, this will apply to all web connections in the PowerShell window.
On PowerShell 7+, this will only apply to commands run by this module.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
