$filePath = "c:\Users\PKF\Documents\PKF- Website\about\team.html"
$content = Get-Content $filePath -Raw

# Remove all placeholder bio paragraphs
$content = $content -replace '\s*<p class="mt-3 text-sm text-gray-600 leading-relaxed">\s*Placeholder bio for [^<]+\.\s*</p>', ''

# Fix the backtick-n issue (replace `n with proper newline)
$content = $content -replace '`n', "`r`n"

Set-Content $filePath $content -NoNewline
Write-Host "Removed all placeholder bios and fixed formatting issues"
