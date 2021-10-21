function Connect-UniFiController {
    <#
    .SYNOPSIS
        Connect to a UniFi Network Controller
    .DESCRIPTION
        Connect to a UniFi Network Controller. This utilises the API used by the controllers web interface. The account used must be a local account on the controller
    .PARAMETER UniFiUri
        The Base URI of the UniFi Controller, such as "https://192.168.0.1"
    .PARAMETER Username
        Your username for the UniFi Controller
    .PARAMETER Password
        Your password for the UniFi Controller
    .PARAMETER SkipCertificateCheck
        Allow connections to instances using SSL/TLS certificates that are not trusted by the local machine this is running on. 
        On Windows PowerShell 5, this will apply to all web connections in the PowerShell window.
        On PowerShell 7+, this will only apply to commands run by this module.
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
        [Diagnostics.CodeAnalysis.SuppressMessageAttribute('UseDeclaredVarsMoreThanAssignments', 'Variable is not local scope')]
        $GLOBAL:UniFiAuth = [PSCustomObject]@{
            SessionName          = 'UniFiSession'
            Session              = $UniFiSession
            UriBase              = $UniFiUri
            SkipCertificateCheck = $SkipCertificateCheck
            Type                 = 'Network'
        }
    } else {
        Write-Error 'Error connecting to the UniFi Controller'
    }
}