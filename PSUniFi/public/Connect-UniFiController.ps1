function Connect-UniFiController {
    <#

.EXAMPLE
    Connect-UniFiController -UniFiUri 'https://localhost:8443' -Username 'admin' -Password (Read-Host -AsSecureString -Prompt 'Password') -SkipCertificateCheck
#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            ParameterSetName = 'StdAuth')]
        [String]$UniFiUri,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'StdAuth')]
        [String]$Username,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'StdAuth')]
        [SecureString]$Password,

        [Switch]$SkipCertificateCheck
    )

    $body = @{
        strict   = $true
        password = Unprotect-Secret -Secret $Password
        remember = $false
        username = $Username
    } | ConvertTo-Json

    if ($UniFiUri[-1] -eq '/') {
        $UniFiUri = $UniFiUri.Substring(0, ($UniFiUri.length - 1))
    }
    $loginUri = [System.Uri]::New($UniFiUri + '/api/login')

    $loginParam = @{
        Uri                  = $loginUri
        Method               = 'Post'
        Body                 = $body
        SessionVariable      = 'UniFiSession'
        SkipCertificateCheck = $SkipCertificateCheck
        ContentType          = 'application/json'
    }
    $loginResult = Invoke-RestMethod @loginParam
    if ($loginResult.meta.rc -eq 'ok') {
        $GLOBAL:UniFiAuth = [PSCustomObject]@{
            SessionName          = 'UniFiSession'
            Session              = $UniFiSession
            UriBase              = $UniFiUri
            SkipCertificateCheck = $SkipCertificateCheck
        }
    } else {
        Write-Error 'Error connecting to the UniFi Controller'
    }
}