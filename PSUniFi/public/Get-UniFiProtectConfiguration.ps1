function Get-UniFiProtectConfiguration {
    $bootstrap = Get-UniFiCKBootStrap
    if ($bootstrap.nvr) {
        $bootstrap.nvr
    }
}