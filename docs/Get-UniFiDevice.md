---
external help file: PSUniFi-help.xml
Module Name: PSUniFi
online version:
schema: 2.0.0
---

# Get-UniFiDevice

## SYNOPSIS
Get UniFi Network devices.

## SYNTAX

### Site
```
Get-UniFiDevice -SiteName <String[]> [<CommonParameters>]
```

### All
```
Get-UniFiDevice [-All] [<CommonParameters>]
```

## DESCRIPTION
Get UniFi Network devices.
If only using the default site (such as when using a Cloud Key Gen 2), specify the site name as 'default'

When specifying a specific site, in a multi site setup, ensure to use the "name" returned from Get-UniFiSite, as this does not match
the display name you set in the controller.

## EXAMPLES

### EXAMPLE 1
```
Get-UniFiDevice -SiteName 'default'
```

Get devices in the default site

### EXAMPLE 2
```
Get-UniFiDevice -SiteName (Get-UniFiSite).Name
```

Get devices in all sites

### EXAMPLE 3
```
Get-UniFiDevice -All
```

Get devices in all sites

## PARAMETERS

### -SiteName
If only using the default site (such as when using a Cloud Key Gen 2), specify the site name as 'default'

When specifying a specific site, in a multi site setup, ensure to use the "name" returned from Get-UniFiSite, as this does not match
the display name you set in the controller.

```yaml
Type: String[]
Parameter Sets: Site
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -All
Return all devices regardless of what site it is in.
Equivalent to running "Get-UniFiDevice -SiteName (Get-UniFiSite).Name"

```yaml
Type: SwitchParameter
Parameter Sets: All
Aliases:

Required: True
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
