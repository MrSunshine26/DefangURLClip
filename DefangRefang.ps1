$clipboardContent = Get-Clipboard

function Defang-Url($url) {
    $defangedUrl = $url -replace 'https?://', 'hxxps://'
    $defangedUrl = $defangedUrl -replace '@', '[at]'
    $defangedUrl = $defangedUrl -replace '\.', '[.]'
    return $defangedUrl
}

function Refang-Url($url) {
    $refangedUrl = $url -replace 'hxxps://', 'https://'
    $refangedUrl = $refangedUrl -replace '\[at\]', '@'
    $refangedUrl = $refangedUrl -replace '\[\.\]', '.'
    return $refangedUrl
}

function Process-Url($url) {
    if ($url -match 'hxxps://|\[at\]|\[\.\]') {
        return Refang-Url $url
    } else {
        return Defang-Url $url
    }
}

$processedContent = Process-Url $clipboardContent

Set-Clipboard -Value $processedContent

Write-Host "Processed URL copied to clipboard: $processedContent"
