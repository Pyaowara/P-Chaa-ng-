# Start P-Chaa-ng Backend and Frontend in separate terminals (Windows)
$PROJECT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "Getting dependencies for pchaa_client..."
Set-Location "$PROJECT_DIR\pchaa_client"
dart pub get

Write-Host "Getting dependencies for pchaa_server..."
Set-Location "$PROJECT_DIR\pchaa_server"
dart pub get

Write-Host "Getting dependencies for pchaa_flutter..."
Set-Location "$PROJECT_DIR\pchaa_flutter"
flutter pub get

Write-Host "Generating Serverpod code..."
Set-Location "$PROJECT_DIR\pchaa_server"
serverpod generate

Write-Host "Starting P-Chaa-ng Docker Compose..."
Start-Process powershell -ArgumentList "-NoExit -Command cd '$PROJECT_DIR\pchaa_server'; docker compose up; exit"

Write-Host "Waiting for Docker services to initialize..."
Start-Sleep -Seconds 5

Write-Host "Starting P-Chaa-ng Backend and Frontend in separate terminals..."

# Start backend server in new PowerShell window
Write-Host "Opening backend terminal..."
Start-Process powershell -ArgumentList "-NoExit -Command cd '$PROJECT_DIR\pchaa_server'; Write-Host 'Applying migrations...'; dart bin/main.dart --apply-migrations; Write-Host 'Starting backend server...'; dart bin/main.dart; exit"

# Wait a moment for backend to initialize
Start-Sleep -Seconds 3

# Start frontend in new PowerShell window
Write-Host "Opening frontend terminal..."
Start-Process powershell -ArgumentList "-NoExit -Command cd '$PROJECT_DIR\pchaa_flutter'; Write-Host 'Starting Flutter app...'; flutter run; exit"

Write-Host ""
Write-Host "Backend and Frontend terminals opened!"
Write-Host "Use 'r' for hot reload and 'R' for hot restart in the Flutter terminal"
Write-Host "Close the terminal windows or press Ctrl+C in them to stop"
