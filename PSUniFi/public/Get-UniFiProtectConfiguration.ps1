function Get-UniFiProtectConfiguration {
    <#
    .SYNOPSIS
        Get the UniFi Protect configuration from an instance stored on a Cloud Key
    .DESCRIPTION
        Get the UniFi Protect configuration from an instance stored on a Cloud Key
    .EXAMPLE
        Get-UniFiProtectConfiguration
    #>
    $bootstrap = Get-UniFiCKBootStrap
    if ($bootstrap.nvr) {
        $bootstrap.nvr
    }
}