$files = Get-ChildItem -Path "c:\Users\PKF\Documents\PKF- Website" -Recurse -Include "*.html"

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # Fix double quotes issue: no-repeat;"" -> no-repeat;"
    $content = $content -replace 'no-repeat;""', 'no-repeat;"'
    
    Set-Content $file.FullName $content -NoNewline
    Write-Host "Fixed: $($file.FullName)"
}

Write-Host "`nFixed double quotes issue in all HTML files"
