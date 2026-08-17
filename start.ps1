# Stock Analysis System Launcher
$host.UI.RawUI.WindowTitle = "Stock Analysis"
$url = "http://127.0.0.1:8000"
$python = "$PSScriptRoot\.venv\Scripts\python.exe"
$script = "$PSScriptRoot\main.py"

Write-Host "Checking service..." -ForegroundColor Cyan

$running = try {
    (Invoke-WebRequest -Uri $url -TimeoutSec 2 -UseBasicParsing).StatusCode -eq 200
} catch { $false }

if ($running) {
    Write-Host "Service is running. Opening browser..." -ForegroundColor Green
} else {
    Write-Host "Starting service, please wait..." -ForegroundColor Yellow
    Start-Process -FilePath $python `
        -ArgumentList $script, "--webui-only" `
        -WorkingDirectory $PSScriptRoot `
        -WindowStyle Hidden

    Write-Host "Waiting " -NoNewline -ForegroundColor Yellow
    $ready = $false
    for ($i = 0; $i -lt 30 -and -not $ready; $i++) {
        Start-Sleep 3
        Write-Host "." -NoNewline -ForegroundColor Yellow
        $ready = try {
            (Invoke-WebRequest -Uri $url -TimeoutSec 2 -UseBasicParsing).StatusCode -eq 200
        } catch { $false }
    }

    if ($ready) {
        Write-Host " Ready!" -ForegroundColor Green
    } else {
        Write-Host " Timeout. Please retry." -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }
}

Start-Process $url
Write-Host "Opened: $url" -ForegroundColor Cyan
Start-Sleep 2
