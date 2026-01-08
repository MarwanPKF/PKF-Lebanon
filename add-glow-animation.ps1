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
        
        # Replace the inline style with proper classes including animate-pulse-ring
        $content = $content -replace 'style="background-color: #0f3780; background-image: url\(''/assets/images/starburst\.webp''\); background-position: calc\(50% - 320px\) 50%; background-repeat: no-repeat;""\s+href="/contact/">Get in touch', 'class="rounded-xl bg-pkf-blue px-5 py-2.5 text-white hover:bg-pkf-blue/90 transition-colors focus:outline-none focus:ring-2 focus:ring-pkf-blue focus:ring-offset-2 animate-pulse-ring" href="/contact/">Get in touch'
        
        Set-Content $fullPath $content -NoNewline
        Write-Host "Updated: $file"
    }
}

Write-Host "All files updated with glow animation!"
