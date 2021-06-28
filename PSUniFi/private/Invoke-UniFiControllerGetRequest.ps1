function Invoke-UniFiControllerGetRequest {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]$API
    )

    if (-not($GLOBAL:UniFiAuth.Session)) {
        throw "Not connected to the UniFi Controller. Use 'Connect-UniFiController' to connect"
    }
    
    $request = @{
        Uri                  = [System.Uri]::New($GLOBAL:UniFiAuth.UriBase + $API)
        WebSession           = $GLOBAL:UniFiAuth.Session
        SkipCertificateCheck = $GLOBAL:UniFiAuth.SkipCertificateCheck
        Method               = 'Get'
    }
    $response = Invoke-RestMethod @request
    if ($response.meta.rc -eq 'ok') {
        $response.data
    } else {
        Write-Error 'Error looking up API'
    }
}