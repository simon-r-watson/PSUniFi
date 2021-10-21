function Get-UniFiSite {
    <#
    .SYNOPSIS
        Get the sites configured in the UniFi Network Controller instance
    .DESCRIPTION
        Get the sites configured in the UniFi Network Controller instance
    .EXAMPLE
        Get-UniFiSite
    #>
    if ($GLOBAL:UniFiAuth.Type -eq 'Network') {
        $api = '/api/self/sites'
    } elseif ($GLOBAL:UniFiAuth.Type -eq 'CloudKey') {
        $api = '/proxy/network/api/api/self/sites'
    }
    
    Invoke-UniFiControllerGetRequest -Api $api
}