function Get-UniFiDevice {
    <#
    .SYNOPSIS
        Get UniFi Network devices.
    .DESCRIPTION
        Get UniFi Network devices. If only using the default site (such as when using a Cloud Key Gen 2), specify the site name as 'default'

        When specifying a specific site, in a multi site setup, ensure to use the "name" returned from Get-UniFiSite, as this does not match
        the display name you set in the controller.
    .PARAMETER SiteName
        If only using the default site (such as when using a Cloud Key Gen 2), specify the site name as 'default'

        When specifying a specific site, in a multi site setup, ensure to use the "name" returned from Get-UniFiSite, as this does not match
        the display name you set in the controller.
    .PARAMETER All
        Return all devices regardless of what site it is in. Equivalent to running "Get-UniFiDevice -SiteName (Get-UniFiSite).Name"
    .EXAMPLE
        Get-UniFiDevice -SiteName 'default'

        Get devices in the default site
    .EXAMPLE
        Get-UniFiDevice -SiteName (Get-UniFiSite).Name

        Get devices in all sites
    .EXAMPLE
        Get-UniFiDevice -All

        Get devices in all sites
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Site')]
        [String[]]$SiteName,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'All')]
        [Switch]$All
    )

    if ($All -eq $true) {
        $SiteName = (Get-UniFiSite).Name
    }

    foreach ($site in $SiteName) {
        if ($GLOBAL:UniFiAuth.Type -eq 'Network') {
            $api = '/api/s/' + $site + '/stat/device'
        } elseif ($GLOBAL:UniFiAuth.Type -eq 'CloudKey') {
            $api = '/proxy/network/api/s/' + $site + '/stat/device'
        }
        Invoke-UniFiControllerGetRequest -Api $api
    }   
}