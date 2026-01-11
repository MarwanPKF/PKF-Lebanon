# Test all navigation links on the website
Write-Host "Testing PKF Website Navigation Links..." -ForegroundColor Cyan
Write-Host ""

$baseUrl = "http://localhost:8000"
$testResults = @()

# Define all links to test
$links = @(
    @{Name = "Home"; Url = "/" },
    @{Name = "About"; Url = "/about/" },
    @{Name = "Services"; Url = "/services/" },
    @{Name = "Publications"; Url = "/publications/" },
    @{Name = "Join Our Team"; Url = "/join-our-team/" },
    @{Name = "Contact"; Url = "/contact/" },
    @{Name = "About - Team"; Url = "/about/team.html" },
    @{Name = "About - Philosophies"; Url = "/about/philosophies.html" },
    @{Name = "About - Legal"; Url = "/about/legal.html" },
    @{Name = "Services - Assurance"; Url = "/services/assurance.html" },
    @{Name = "Services - Taxation"; Url = "/services/taxation.html" },
    @{Name = "Services - Corporate Finance"; Url = "/services/corporate-finance-advisory.html" },
    @{Name = "Services - Business Risk"; Url = "/services/business-risk-solutions.html" },
    @{Name = "Services - Forensic Accounting"; Url = "/services/forensic-accounting.html" },
    @{Name = "Services - Insolvency"; Url = "/services/insolvency.html" },
    @{Name = "Services - Management Consultancy"; Url = "/services/management-consultancy.html" },
    @{Name = "Services - Technology Advisory"; Url = "/services/technology-advisory.html" },
    @{Name = "Contact - Thank You"; Url = "/contact/thank-you.html" }
)

foreach ($link in $links) {
    $fullUrl = $baseUrl + $link.Url
    try {
        $response = Invoke-WebRequest -Uri $fullUrl -UseBasicParsing -ErrorAction Stop
        if ($response.StatusCode -eq 200) {
            Write-Host "[OK] $($link.Name) - $($link.Url)" -ForegroundColor Green
            $testResults += @{Name = $link.Name; Url = $link.Url; Status = "OK" }
        }
    }
    catch {
        Write-Host "[FAIL] $($link.Name) - $($link.Url) - Error: $($_.Exception.Message)" -ForegroundColor Red
        $testResults += @{Name = $link.Name; Url = $link.Url; Status = "FAIL"; Error = $_.Exception.Message }
    }
}

Write-Host ""
Write-Host "Test Summary:" -ForegroundColor Cyan
$okCount = ($testResults | Where-Object { $_.Status -eq "OK" }).Count
$failCount = ($testResults | Where-Object { $_.Status -eq "FAIL" }).Count
Write-Host "Passed: $okCount" -ForegroundColor Green
Write-Host "Failed: $failCount" -ForegroundColor Red
