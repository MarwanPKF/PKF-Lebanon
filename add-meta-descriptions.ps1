# Meta descriptions for each page
$metaDescriptions = @{
    "about\index.html"                         = "Learn about PKF Chartouni - a member of PKF International providing professional accounting, tax, and advisory services in Lebanon."
    "about\legal.html"                         = "Legal disclaimer for PKF Chartouni. Member of PKF Global network of independent legal entities."
    "about\philosophies.html"                  = "Our core values: Making a Difference, Personalization, and Innovation. Learn about PKF Chartouni's guiding principles."
    "about\team.html"                          = "Meet the experienced team of partners and professionals at PKF Chartouni providing expert accounting and advisory services."
    "join-our-team\index.html"                 = "Explore career opportunities at PKF Chartouni. Join a dynamic professional team with international exposure."
    "publications\index.html"                  = "Access the PKF Worldwide Tax Guide and other professional publications from PKF Chartouni."
    "services\index.html"                      = "Professional auditing, tax consulting, and advisory services from PKF Chartouni in Lebanon."
    "services\assurance.html"                  = "Independent assurance and audit services from PKF Chartouni. Statutory audits, review engagements, and internal control assessments."
    "services\business-risk-solutions.html"    = "Business risk solutions including internal audit, risk management, and compliance services from PKF Chartouni."
    "services\corporate-finance-advisory.html" = "Corporate finance advisory services including M&A, valuations, and due diligence from PKF Chartouni."
    "services\forensic-accounting.html"        = "Forensic accounting and investigation services from PKF Chartouni. Fraud investigation and litigation support."
    "services\insolvency.html"                 = "Insolvency and restructuring advisory services from PKF Chartouni. Expert guidance through financial challenges."
    "services\management-consultancy.html"     = "Management consultancy services from PKF Chartouni. Strategic planning and operational improvement."
    "services\taxation.html"                   = "Tax consulting services from PKF Chartouni. Corporate tax, VAT, and international tax advisory."
    "services\technology-advisory.html"        = "Technology advisory services from PKF Chartouni. IT strategy, digital transformation, and cybersecurity."
    "contact\thank-you.html"                   = "Thank you for contacting PKF Chartouni. We will respond to your enquiry shortly."
}

$basePath = "c:\Users\PKF\Documents\PKF- Website"

foreach ($file in $metaDescriptions.Keys) {
    $filePath = Join-Path $basePath $file
    if (Test-Path $filePath) {
        $content = Get-Content $filePath -Raw
        
        # Check if meta description already exists
        if ($content -notmatch '<meta name="description"') {
            # Add meta description after viewport meta tag
            $metaDesc = "`n    <meta name=`"description`" content=`"$($metaDescriptions[$file])`" />"
            $content = $content -replace '(<meta name="viewport"[^>]+>)', "`$1$metaDesc"
            
            Set-Content $filePath $content -NoNewline
            Write-Host "Added meta description to: $file"
        }
        else {
            Write-Host "Meta description exists: $file"
        }
    }
    else {
        Write-Host "File not found: $file"
    }
}

Write-Host "`nMeta descriptions added to all pages"
