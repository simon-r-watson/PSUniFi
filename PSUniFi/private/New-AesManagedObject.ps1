function New-AesManagedObject($Key, $IV) {
    # Credit for this function! https://gist.github.com/ctigeek/2a56648b923d198a6e60
    $aesManaged = New-Object 'System.Security.Cryptography.AesManaged'
    $aesManaged.Mode = [System.Security.Cryptography.CipherMode]::CBC
    $aesManaged.Padding = [System.Security.Cryptography.PaddingMode]::Zeros
    $aesManaged.BlockSize = 128
    $aesManaged.KeySize = 256
    if ($IV) {
        if ($IV.getType().Name -eq 'String') {
            $aesManaged.IV = [System.Convert]::FromBase64String($IV)
        } else {
            $aesManaged.IV = $IV
        }
    }
    if ($key) {
        if ($key.getType().Name -eq 'String') {
            $aesManaged.Key = [System.Convert]::FromBase64String($key)
        } else {
            $aesManaged.Key = $key
        }
    }
    $aesManaged
}
