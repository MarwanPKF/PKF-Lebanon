# Replace logo.svg with Logo.gif in all HTML files
$files = Get-ChildItem -Path . -Filter *.html -Recurse

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $updated = $content -replace '/assets/images/logo\.svg', '/assets/images/Logo.gif'
    
    if ($content -ne $updated) {
        Set-Content -Path $file.FullName -Value $updated -NoNewline
        Write-Host "Updated: $($file.FullName)"
    }
}

Write-Host "`nLogo replacement complete!"
