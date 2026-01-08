$port = 8080
$root = $PSScriptRoot
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Start()
Write-Host "Listening at http://localhost:$port/"
Write-Host "Press Ctrl+C to stop."

try {
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response
        
        # Clean path to prevent traversal
        $localPath = $request.Url.LocalPath.TrimStart('/')
        $path = Join-Path $root $localPath
        
        # Default to index.html for directories
        if (Test-Path $path -PathType Container) {
            $path = Join-Path $path "index.html"
        }
        
        if (Test-Path $path -PathType Leaf) {
            $content = [System.IO.File]::ReadAllBytes($path)
            $extension = [System.IO.Path]::GetExtension($path).ToLower()
            $mime = switch ($extension) {
                ".html" { "text/html; charset=utf-8" }
                ".css"  { "text/css" }
                ".js"   { "application/javascript" }
                ".svg"  { "image/svg+xml" }
                ".jpg"  { "image/jpeg" }
                ".png"  { "image/png" }
                ".pdf"  { "application/pdf" }
                Default { "application/octet-stream" }
            }
            $response.ContentType = $mime
            $response.ContentLength64 = $content.Length
            $response.OutputStream.Write($content, 0, $content.Length)
            $response.StatusCode = 200
        } else {
            $response.StatusCode = 404
        }
        $response.Close()
    }
} finally {
    $listener.Stop()
}
