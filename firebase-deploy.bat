@echo off
REM Firebase Deployment Script (Windows)

echo ========================================
echo Firebase Deployment - Logbook App
echo ========================================
echo.

REM Check if Firebase CLI is installed
where firebase >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Firebase CLI not found!
    echo Please install: npm install -g firebase-tools
    pause
    exit /b 1
)

echo Step 1: Checking Firebase login...
firebase login --no-localhost

echo.
echo Step 2: Initializing Firebase (if not done)...
echo If prompted, select:
echo   - Functions: Yes
echo   - Hosting: Yes (optional)
echo   - Language: Python
echo   - Python version: 3.11
echo.
pause

firebase init

echo.
echo Step 3: Setting environment variables...
echo Enter your SECRET_KEY (or press Enter to skip):
set /p SECRET_KEY="SECRET_KEY: "
echo Enter ADMIN_USERNAME (default: admin):
set /p ADMIN_USERNAME="ADMIN_USERNAME: "
if "%ADMIN_USERNAME%"=="" set ADMIN_USERNAME=admin
echo Enter ADMIN_PASSWORD:
set /p ADMIN_PASSWORD="ADMIN_PASSWORD: "

if not "%SECRET_KEY%"=="" (
    firebase functions:config:set secret.key="%SECRET_KEY%"
)
if not "%ADMIN_USERNAME%"=="" (
    firebase functions:config:set admin.username="%ADMIN_USERNAME%"
)
if not "%ADMIN_PASSWORD%"=="" (
    firebase functions:config:set admin.password="%ADMIN_PASSWORD%"
)

echo.
echo Step 4: Installing Python dependencies...
cd functions
pip install -r requirements.txt
cd ..

echo.
echo Step 5: Deploying to Firebase...
firebase deploy --only functions

echo.
echo ========================================
echo Deployment Complete!
echo ========================================
echo.
echo Your app URL will be displayed above.
echo Format: https://us-central1-YOUR_PROJECT.cloudfunctions.net/logbook
echo.
pause
