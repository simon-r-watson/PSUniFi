function Unprotect-UniFiBackup {
    <#
    .SYNOPSIS
        Decrypt a UniFi Network Controller backup
    .DESCRIPTION
        Decrypt a UniFi Network Controller backup
        
        Original Script: https://github.com/justingist/POSH-Ubiquiti

        Many thanks to this git repo for the key and basic logic! https://github.com/zhangyoufu/unifi-backup-decrypt
        Also AES credit: https://gist.github.com/ctigeek/2a56648b923d198a6e60

        Output will be a tar.gz in same directory as your initial file. Use your favorite archive tool to open, such as 7-zip.
    .PARAMETER FilePath
        File path to the UniFi Backup. This must be the absolute file path.
    .EXAMPLE
        Unprotect-UniFiBackup -FilePath C:\Temp\pathtomybackup.unf
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
    Param(
        [Parameter(Mandatory = $true,
            HelpMessage = 'Filepath to Unifi Backup File')]
        [ValidateScript( {
                if ( -Not ($_.FullName | Test-Path) ) {
                    throw 'File or folder does not exist. Must include the full file path'
                }
                if (-Not ($_ | Test-Path -PathType Leaf) ) {
                    throw 'The Path argument must be a file. Folder paths are not allowed.'
                }
                if ($_.Extension -ne '.unf') {
                    throw 'Not a UniFi Backup File'
                }
                return $true
            })]
        [System.IO.FileInfo]$FilePath,

        [Switch]$Force
    )
    $outFile = $FilePath.FullName.Replace('.unf', '.tar.gz')
    if (Test-Path -Path $outFile) {
        if ($Force -eq $false) {
            Write-Warning "$outFile already exists."
        }  
    }

    $encryptedString = [System.IO.File]::ReadAllBytes($FilePath.FullName)
    $key = [System.Text.Encoding]::UTF8.GetBytes('bcyangkmluohmars')
    $iv = [System.Text.Encoding]::UTF8.GetBytes('ubntenterpriseap')
    $aesManaged = New-AesManagedObject -Key $Key -IV $iv
    $decryptor = $aesManaged.CreateDecryptor();
    $unencryptedData = $decryptor.TransformFinalBlock($encryptedString, 16, $encryptedString.Length - 16)
    $aesManaged.Dispose()

    if ($Force -or $PSCmdlet.ShouldProcess($outFile, 'Save')) {
        Save-UniFiDecryptedBackup -FilePath $outFile -Data $unencryptedData -Force:$Force
    }
}