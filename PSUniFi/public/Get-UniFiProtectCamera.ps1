function Get-UniFiProtectCamera {
    <#
    .SYNOPSIS
        Get UniFi Cameras from a UniFi Protect instance stored on a Cloud Key
    .DESCRIPTION
        Get UniFi Cameras from a UniFi Protect instance stored on a Cloud Key
    .EXAMPLE
        Get-UniFiProtectCamera
    #>
    $bootstrap = Get-UniFiCKBootStrap
    if ($bootstrap.cameras) {
        $bootstrap.cameras
    }
}