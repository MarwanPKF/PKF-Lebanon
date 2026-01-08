$gitPath = "C:\Program Files\Git\cmd\git.exe"
$repoUrl = "https://github.com/MarwanPKF/PKF-Lebanon.git"

# Define a helper function to run git commands
function Run-Git {
    param([string]$args)
    & $gitPath $args.Split(" ")
}

Write-Host "Initializing Git repository..."
& $gitPath init

Write-Host "`nAdding files..."
& $gitPath add .

Write-Host "`nCommitting files..."
& $gitPath commit -m "Initial launch of PKF Chartouni website"

Write-Host "`nRenaming branch to main..."
& $gitPath branch -M main

Write-Host "`nAdding remote origin..."
& $gitPath remote add origin $repoUrl

Write-Host "`nPushing to GitHub..."
& $gitPath push -u origin main

Write-Host "`nDone!"
