function Get-UniFiDevice {
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
        $api = '/api/s/' + $site + '/stat/device'
        Invoke-UniFiControllerGetRequest -Api $api
    }   
}