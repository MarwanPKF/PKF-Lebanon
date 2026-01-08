$files = Get-ChildItem -Path "c:\Users\PKF\Documents\PKF- Website" -Recurse -Include "*.html"

# Standard footer HTML
$standardFooter = @'
    <footer class="border-t border-gray-200 bg-pkf-gray py-12 mt-auto">
        <div class="mx-auto max-w-6xl px-4 text-center">
            <p class="text-sm text-gray-500">© <span id="year">2026</span> PKF Chartouni. <a href="/about/legal.html"
                    class="underline hover:text-gray-900">Legal Disclaimer</a>.</p>
        </div>
        <script>
            document.getElementById('year').textContent = new Date().getFullYear();
            document.getElementById('menuBtn').addEventListener('click', () => {
                document.getElementById('mobileMenu').classList.toggle('hidden');
            });
        </script>
    </footer>
'@

foreach ($file in $files) {
    # Skip index.html as it has special footer
    if ($file.Name -eq "index.html" -and $file.Directory.Name -eq "PKF- Website") {
        Write-Host "Skipping homepage: $($file.FullName)"
        continue
    }
    
    $content = Get-Content $file.FullName -Raw
    
    # Replace existing footer patterns
    # Pattern 1: Footer without Legal Disclaimer
    $pattern1 = '<footer class="border-t border-gray-200 bg-pkf-gray py-12 mt-auto">\s*<div class="mx-auto max-w-6xl px-4 text-center">\s*<p class="text-sm text-gray-500">© <span id="year">2026</span> PKF Chartouni\.</p>\s*</div>'
    
    if ($content -match $pattern1) {
        $content = $content -replace $pattern1, '<footer class="border-t border-gray-200 bg-pkf-gray py-12 mt-auto">`n        <div class="mx-auto max-w-6xl px-4 text-center">`n            <p class="text-sm text-gray-500">© <span id="year">2026</span> PKF Chartouni. <a href="/about/legal.html"`n                    class="underline hover:text-gray-900">Legal Disclaimer</a>.</p>`n        </div>'
        Set-Content $file.FullName $content -NoNewline
        Write-Host "Updated footer: $($file.FullName)"
    }
    else {
        Write-Host "Footer OK or different format: $($file.FullName)"
    }
}

Write-Host "`nFooters standardized"
