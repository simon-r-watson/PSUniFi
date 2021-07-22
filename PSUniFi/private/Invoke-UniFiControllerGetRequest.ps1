function Invoke-UniFiControllerGetRequest {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]$API
    )

    if (-not($GLOBAL:UniFiAuth.Session)) {
        throw "Not connected to the UniFi Controller. Use 'Connect-UniFiController' to connect"
    }
    #enable TLS 1.2
    if ($PSVersionTable.PSVersion.Major -eq 5) {
        Set-PowerShell5TLS
    }

    $request = @{
        Uri        = [System.Uri]::New($GLOBAL:UniFiAuth.UriBase + $API)
        WebSession = $GLOBAL:UniFiAuth.Session
        Method     = 'Get'
    }
    if ($GLOBAL:UniFiAuth.SkipCertificateCheck -eq $true) {
        #powershell 5 does not have inbuilt support for skipping the certificate check
        if ($PSVersionTable.PSVersion.Major -eq 5) {
            Set-PowerShell5SkipCertificateCheck
        } elseif ($PSVersionTable.PSVersion.Major -ge 6) {
            $request.Add('SkipCertificateCheck', $GLOBAL:UniFiAuth.SkipCertificateCheck)
        }
    }
    $response = Invoke-RestMethod @request
    if ($response.meta.rc -eq 'ok') {
        $response.data
    } elseif ($response.authUserId) {
        $response
    } else {
        Write-Error 'Error looking up API'
    }
}