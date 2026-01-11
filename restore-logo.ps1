# Restore logo.svg from Logo.gif in all HTML files
$files = Get-ChildItem -Path . -Filter *.html -Recurse

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $updated = $content -replace '/assets/images/Logo\.gif', '/assets/images/logo.svg'
    
    if ($content -ne $updated) {
        Set-Content -Path $file.FullName -Value $updated -NoNewline
        Write-Host "Restored: $($file.FullName)"
    }
}

Write-Host "`nLogo restoration complete!"
