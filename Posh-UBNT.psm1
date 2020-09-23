<#

.NOTES
    Original Script: https://github.com/justingist/POSH-Ubiquiti

    Many thanks to this git repo for the key and basic logic! https://github.com/zhangyoufu/unifi-backup-decrypt
    Also AES credit: https://gist.github.com/ctigeek/2a56648b923d198a6e60

    Output will be a tar.gz in same directory as your initial file. Use your favorite archive tool to open, such as 7-zip.

.EXAMPLE
    PS> Set-ExecutionPolicy Unrestricted -Scope Process
    PS> Import-Module .\PoshUBNT.psm1
    PS> Invoke-UniFiBackupDecryption -FilePath C:\Temp\pathtomybackup.unf

#>


Function Invoke-UniFiBackupDecryption
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true, 
            ValueFromPipeline = $false,
            ValueFromPipelineByPropertyName = $false, 
            ValueFromRemainingArguments = $false, 
            Position = 0,
            HelpMessage = "Filepath to Unifi Backup File")]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateScript( {
                if ( -Not ($_.FullName | Test-Path) )
                {
                    throw "File or folder does not exist. Must include the full file path"
                }
                if (-Not ($_ | Test-Path -PathType Leaf) )
                {
                    throw "The Path argument must be a file. Folder paths are not allowed."
                }
                if ($_.Extension -ne '.unf')
                {
                    throw "Not a UniFi Backup File"
                }
                return $true
            })]
        [System.IO.FileInfo]$FilePath
    )

    $encryptedstring = Get-Content $FilePath.FullName -Encoding Byte
    $outfile = $FilePath.FullName.Replace('.unf', '.tar.gz')
    $key = [system.text.encoding]::UTF8.GetBytes("bcyangkmluohmars")
    $iv = [system.text.encoding]::UTF8.GetBytes("ubntenterpriseap")
    $aesManaged = New-AesManagedObject -Key $Key -IV $iv
    $decryptor = $aesManaged.CreateDecryptor();
    $unencryptedData = $decryptor.TransformFinalBlock($encryptedstring, 16, $encryptedstring.Length - 16)
    $aesManaged.Dispose()

    [io.file]::WriteAllBytes($outfile, $unencryptedData)
}

function New-AesManagedObject($Key, $IV)
{
    # Credit for this function! https://gist.github.com/ctigeek/2a56648b923d198a6e60
    $aesManaged = New-Object "System.Security.Cryptography.AesManaged"
    $aesManaged.Mode = [System.Security.Cryptography.CipherMode]::CBC
    $aesManaged.Padding = [System.Security.Cryptography.PaddingMode]::Zeros
    $aesManaged.BlockSize = 128
    $aesManaged.KeySize = 256
    if ($IV)
    {
        if ($IV.getType().Name -eq "String")
        {
            $aesManaged.IV = [System.Convert]::FromBase64String($IV)
        }
        else
        {
            $aesManaged.IV = $IV
        }
    }
    if ($key)
    {
        if ($key.getType().Name -eq "String")
        {
            $aesManaged.Key = [System.Convert]::FromBase64String($key)
        }
        else
        {
            $aesManaged.Key = $key
        }
    }
    $aesManaged
}
