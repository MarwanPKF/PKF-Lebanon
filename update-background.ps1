$files = @(
    "services\assurance.html",
    "services\business-risk-solutions.html",
    "services\corporate-finance-advisory.html",
    "services\forensic-accounting.html",
    "services\index.html",
    "services\insolvency.html",
    "services\management-consultancy.html",
    "services\taxation.html",
    "services\technology-advisory.html",
    "about\index.html",
    "about\legal.html",
    "about\philosophies.html",
    "about\team.html",
    "contact\index.html",
    "join-our-team\index.html",
    "publications\index.html"
)

$basePath = "c:\Users\PKF\Documents\PKF- Website"

foreach ($file in $files) {
    $fullPath = Join-Path $basePath $file
    if (Test-Path $fullPath) {
        $content = Get-Content $fullPath -Raw
        
        # Replace bg-pkf-blue class with inline style
        $content = $content -replace 'class="([^"]*\s)?bg-pkf-blue(\s[^"]*)?', 'style="background-color: #0f3780; background-image: url(''/assets/images/starburst.webp''); background-position: calc(50% - 320px) 50%; background-repeat: no-repeat;"'
        
        # Remove overlay divs (lines 66-70 in assurance.html)
        $content = $content -replace '(?s)\s*<div class="absolute inset-0 opacity-10">.*?</div>\s*</div>', ''
        
        Set-Content $fullPath $content -NoNewline
        Write-Host "Updated: $file"
    }
}

Write-Host "All files updated successfully!"
