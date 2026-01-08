$gitPath = "C:\Program Files\Git\cmd\git.exe"
$repoUrl = "https://github.com/MarwanPKF/PKF-Lebanon.git"
$email = "marwannassarpkf@gmail.com"
$name = "Marwan Nassar"

# Define a helper function to run git commands
function Run-Git {
    param([string]$args)
    & $gitPath $args.Split(" ")
}

Write-Host "Configuring Git Global Identity..."
& $gitPath config --global user.email $email
& $gitPath config --global user.name $name

Write-Host "`nEnsuring Git repository is initialized..."
& $gitPath init

Write-Host "`nAdding files..."
& $gitPath add .

Write-Host "`nCommitting files..."
& $gitPath commit -m "Initial launch of PKF Chartouni website"

Write-Host "`nRenaming branch to main..."
& $gitPath branch -M main

Write-Host "`nConfiguring remote..."
# Check if remote exists, if so set url, otherwise add
$remotes = & $gitPath remote
if ($remotes -contains "origin") {
    & $gitPath remote set-url origin $repoUrl
}
else {
    & $gitPath remote add origin $repoUrl
}

Write-Host "`nPushing to GitHub..."
& $gitPath push -u origin main

Write-Host "`nDone!"
