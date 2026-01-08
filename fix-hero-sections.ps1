$files = Get-ChildItem -Path "c:\Users\PKF\Documents\PKF- Website" -Recurse -Include "*.html"

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # Fix hero sections that got incorrectly styled like buttons
    # Replace the button class on section tags with just the style
    $pattern = '<section\s+class="inline-flex items-center justify-center rounded-xl px-8 py-3 text-white font-medium hover:opacity-90 transition-all focus:outline-none focus:ring-2 focus:ring-pkf-blue focus:ring-offset-2 animate-pulse-ring" style="background-color: #0f3780; background-image: url\(''/assets/images/starburst\.webp''\); background-position: calc\(50% - 320px\) 50%; background-repeat: no-repeat;">'
    $replacement = '<section style="background-color: #0f3780; background-image: url(''/assets/images/starburst.webp''); background-position: calc(50% - 320px) 50%; background-repeat: no-repeat;">'
    
    $content = $content -replace $pattern, $replacement
    
    Set-Content $file.FullName $content -NoNewline
    Write-Host "Fixed: $($file.FullName)"
}

Write-Host "`nFixed hero section styling"
