function Set-AllHtmlTitles {
    param (
        [Parameter(Mandatory=$true)]
        [string]$FolderPath,
        
        [Parameter(Mandatory=$true)]
        [string]$NewTitle
    )

    # 1. Find all HTML files in the folder AND all subfolders
    # -ErrorAction SilentlyContinue prevents it from spamming red errors if it hits a locked folder
    $htmlFiles = Get-ChildItem -Path $FolderPath -Filter "*.html" -Recurse -File -ErrorAction SilentlyContinue

    # 2. Check if we actually found anything
    if ($htmlFiles.Count -eq 0) {
        Write-Host "No HTML files found in $FolderPath or its subfolders." -ForegroundColor Yellow
        return
    }

    Write-Host "Found $($htmlFiles.Count) HTML files. Starting the upgrade..." -ForegroundColor Cyan

    # 3. Loop through every single file it found and change the title
    foreach ($file in $htmlFiles) {
        try {
            (Get-Content -Path $file.FullName) -replace '(?i)<title>.*?</title>', "<title>$NewTitle</title>" | Set-Content -Path $file.FullName
            Write-Host " [SUCCESS] Updated: $($file.FullName)" -ForegroundColor Green
        } catch {
            Write-Host " [ERROR] Could not update: $($file.FullName)" -ForegroundColor Red
        }
    }
    
    Write-Host "Finished updating all files!" -ForegroundColor Cyan
}
