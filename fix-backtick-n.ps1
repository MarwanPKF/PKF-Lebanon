$files = Get-ChildItem -Path "c:\Users\PKF\Documents\PKF- Website" -Recurse -Include "*.html"

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # Replace literal `n with actual newlines
    $content = $content -replace '`n', "`r`n"
    
    Set-Content $file.FullName $content -NoNewline
    Write-Host "Fixed: $($file.FullName)"
}

Write-Host "`nFixed backtick-n issues in all HTML files"
</Parameter>
<parameter name="Complexity">1
