function Get-UniFiCKBootStrap {
    if ($GLOBAL:UniFiAuth.Type -eq 'CloudKey') {
        $api = '/proxy/protect/api/bootstrap'
    } else {
        throw 'not logged into a UniFi Cloud Key'
    }
    Invoke-UniFiControllerGetRequest -Api $api
}