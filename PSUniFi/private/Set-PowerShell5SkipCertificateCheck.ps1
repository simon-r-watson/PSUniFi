function Set-PowerShell5SkipCertificateCheck {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        [switch]$Force
    )

    if (-not ([System.Management.Automation.PSTypeName]'ServerCertificateValidationCallback').Type) {
        if ($Force -or $PSCmdlet.ShouldProcess('PowerShell session', 'Disable TLS Certificate checking')) {
            $certCallback = @'
    using System;
    using System.Net;
    using System.Net.Security;
    using System.Security.Cryptography.X509Certificates;
    public class ServerCertificateValidationCallback
    {
        public static void Ignore()
        {
            if(ServicePointManager.ServerCertificateValidationCallback ==null)
            {
                ServicePointManager.ServerCertificateValidationCallback += 
                    delegate
                    (
                        Object obj, 
                        X509Certificate certificate, 
                        X509Chain chain, 
                        SslPolicyErrors errors
                    )
                    {
                        return true;
                    };
            }
        }
    }
'@
            Add-Type $certCallback
        }
    }
    [ServerCertificateValidationCallback]::Ignore()
}