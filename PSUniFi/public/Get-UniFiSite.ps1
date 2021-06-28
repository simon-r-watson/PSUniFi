function Get-UniFiSite {
    $api = '/api/self/sites'
    Invoke-UniFiControllerGetRequest -Api $api
}