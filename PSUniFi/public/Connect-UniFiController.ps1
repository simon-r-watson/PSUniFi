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
    #enable TLS 1.2
    if ($PSVersionTable.PSVersion.Major -eq 5) {
        Set-PowerShell5TLS
    }
    #set login Parameters
    $body = @{
        strict   = $true
        password = Unprotect-Secret -Secret $Password
        remember = $false
        username = $Username
    } | ConvertTo-Json
    
    #construct login uri
    if ($UniFiUri[-1] -eq '/') {
        $UniFiUri = $UniFiUri.TrimEnd('/')
    }
    $loginUri = [System.Uri]::New($UniFiUri + '/api/login')

    #login
    $loginParam = @{
        Uri             = $loginUri
        Method          = 'Post'
        Body            = $body
        SessionVariable = 'UniFiSession'
        ContentType     = 'application/json'
    }
    if ($SkipCertificateCheck -eq $true) {
        #powershell 5 does not have inbuilt support for skipping the certificate check
        if ($PSVersionTable.PSVersion.Major -eq 5) {
            Write-Warning @'
Disabling certificate checking. This will remain persistent for the lifetime of the PowerShell session and affect will all .Net methods in the session.
'@            
            Set-PowerShell5SkipCertificateCheck
        } elseif ($PSVersionTable.PSVersion.Major -ge 6) {
            Write-Warning @'
Disabling certificate checking. This will only affect calls made by this module.
'@
            $loginParam.Add('SkipCertificateCheck', $SkipCertificateCheck)
        }
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