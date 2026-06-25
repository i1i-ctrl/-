function Set-HtmlTitle {
    param (
        [Parameter(Mandatory=$true)]
        [string]$FilePath,
        
        [Parameter(Mandatory=$true)]
        [string]$NewTitle
    )

    if (Test-Path $FilePath) {
        (Get-Content -Path $FilePath) -replace '(?i)<title>.*?</title>', "<title>$NewTitle</title>" | Set-Content -Path $FilePath
        Write-Host "Success! Title changed to '$NewTitle' in $FilePath" -ForegroundColor Green
    } else {
        Write-Host "Error: Could not find the file at $FilePath" -ForegroundColor Red
    }
}

Write-Host "The 'Set-HtmlTitle' tool is now loaded in memory!" -ForegroundColor Cyan
Write-Host "To use it, type: Set-HtmlTitle -FilePath 'C:\your\file.html' -NewTitle 'bobo'" -ForegroundColor Yellow
