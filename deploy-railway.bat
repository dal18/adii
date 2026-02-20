@echo off
echo ========================================
echo Deploying Logbook System to Railway
echo ========================================

echo.
echo Step 1: Checking if Railway CLI is installed...
railway --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Railway CLI not found. Installing...
    npm install -g @railway/cli
    if %errorlevel% neq 0 (
        echo ERROR: Failed to install Railway CLI. Please install Node.js first.
        pause
        exit /b 1
    )
)

echo.
echo Step 2: Login to Railway...
railway whoami >nul 2>&1
if %errorlevel% neq 0 (
    echo Please login to Railway:
    railway login
)

echo.
echo Step 3: Initialize Railway project...
railway init

echo.
echo Step 4: Setting environment variables...
echo Setting default credentials (change these in Railway dashboard)...
railway variables set SECRET_KEY="logbook-secret-key-2024"
railway variables set ADMIN_USERNAME="admin"
railway variables set ADMIN_PASSWORD="admin123"

echo.
echo Step 5: Deploying to Railway...
railway up

echo.
echo ========================================
echo Deployment Complete!
echo ========================================
echo.
echo Your app will be available at:
echo https://your-app-name.up.railway.app
echo.
echo Check your Railway dashboard for the actual URL
echo https://railway.app
echo.
pause
