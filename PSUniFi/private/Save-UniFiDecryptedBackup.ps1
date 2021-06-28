function Save-UniFiDecryptedBackup {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    Param(
        [Parameter(Mandatory = $true,
            HelpMessage = 'Filepath to Unifi Backup File')]
        [System.IO.FileInfo]$FilePath,

        [Byte[]]$Data,

        [Switch]$Force
    )

    $save = $false
    if (Test-Path -Path $outFile) {
        if ($Force -or $PSCmdlet.ShouldProcess($outFile, 'Overwrite')) {
            $save = $true
        }
    } else {
        $save = $true
    }

    if ($save -eq $true) {
        [IO.File]::WriteAllBytes($outFile, $unencryptedData)
    }
}
