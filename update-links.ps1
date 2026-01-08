$root = "c:\Users\PKF\Documents\PKF- Website"
$files = Get-ChildItem -Path $root -Filter *.html -Recurse

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $newContent = $content -replace 'href="/careers/"', 'href="/join-our-team/"'
    $newContent = $newContent -replace '>Careers<', '>Join Our Team<'
    
    if ($content -ne $newContent) {
        Set-Content -Path $file.FullName -Value $newContent -NoNewline
        Write-Host "Updated $($file.Name)"
    }
}
