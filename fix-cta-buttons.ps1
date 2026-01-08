$files = Get-ChildItem -Path "c:\Users\PKF\Documents\PKF- Website" -Recurse -Include "*.html"

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # Replace inline style buttons with proper classes
    $oldStyle = 'style="background-color: #0f3780; background-image: url(''/assets/images/starburst.webp''); background-position: calc(50% - 320px) 50%; background-repeat: no-repeat;"'
    $newClass = 'class="inline-flex items-center justify-center rounded-xl bg-pkf-blue px-8 py-3 text-white font-medium hover:bg-pkf-blue/90 transition-colors focus:outline-none focus:ring-2 focus:ring-pkf-blue focus:ring-offset-2 animate-pulse-ring"'
    
    $content = $content -replace [regex]::Escape($oldStyle), $newClass
    
    Set-Content $file.FullName $content -NoNewline
    Write-Host "Updated: $($file.FullName)"
}

Write-Host "`nFixed CTA button styling in all HTML files"
