$filePath = "c:\Users\PKF\Documents\PKF- Website\about\team.html"
$content = Get-Content $filePath -Raw

# Fix the broken div tags - replace the pattern where <div is on a newline with just 2 spaces
$content = $content -replace '(\r\n) {2}<div\r\n', '$1                        <div '

Set-Content $filePath $content -NoNewline
Write-Host "Fixed div tag formatting"
