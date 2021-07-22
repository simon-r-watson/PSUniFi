function Get-UniFiProtectCamera {
    $bootstrap = Get-UniFiCKBootStrap
    if ($bootstrap.cameras) {
        $bootstrap.cameras
    }
}