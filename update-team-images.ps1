$filePath = "c:\Users\PKF\Documents\PKF- Website\about\team.html"
$content = Get-Content $filePath -Raw

# Replace all occurrences of the team member div structure
$content = $content -replace '<div class="group">\s*<div class="aspect-\[4/5\] w-full overflow-hidden', '<div class="group flex flex-col items-center">`n                        <div class="aspect-[4/5] w-1/2 overflow-hidden'

Set-Content $filePath $content -NoNewline
Write-Host "Updated all team member images to 50% size"
