$port = 8080
$path = Get-Location
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Start()

Write-Host "Server started at http://localhost:$port/"
Write-Host "Press Ctrl+C to stop."

while ($true) {
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response

    $filename = $request.Url.LocalPath.Substring(1)
    if ($filename -eq "") { $filename = "index.html" }
    
    # Handle directory requests (URLs ending with /)
    if ($filename.EndsWith("/")) {
        $filename = $filename + "index.html"
    }
    
    $filepath = Join-Path $path $filename

    # Check if it's a directory and serve index.html
    if (Test-Path $filepath -PathType Container) {
        $filepath = Join-Path $filepath "index.html"
    }

    if (Test-Path $filepath -PathType Leaf) {
        $content = [System.IO.File]::ReadAllBytes($filepath)
        $response.ContentLength64 = $content.Length
        
        # Extended MIME types
        switch -Wildcard ($filename) {
            "*.html" { $response.ContentType = "text/html" }
            "*.css" { $response.ContentType = "text/css" }
            "*.js" { $response.ContentType = "application/javascript" }
            "*.png" { $response.ContentType = "image/png" }
            "*.jpg" { $response.ContentType = "image/jpeg" }
            "*.jpeg" { $response.ContentType = "image/jpeg" }
            "*.gif" { $response.ContentType = "image/gif" }
            "*.svg" { $response.ContentType = "image/svg+xml" }
            "*.ico" { $response.ContentType = "image/x-icon" }
            "*.woff" { $response.ContentType = "font/woff" }
            "*.woff2" { $response.ContentType = "font/woff2" }
            "*.ttf" { $response.ContentType = "font/ttf" }
            "*.eot" { $response.ContentType = "application/vnd.ms-fontobject" }
            "*.json" { $response.ContentType = "application/json" }
            "*.xml" { $response.ContentType = "application/xml" }
            "*.pdf" { $response.ContentType = "application/pdf" }
            Default { $response.ContentType = "application/octet-stream" }
        }
        
        $response.OutputStream.Write($content, 0, $content.Length)
        $response.StatusCode = 200
    }
    else {
        $response.StatusCode = 404
    }
    
    $response.Close()
}
