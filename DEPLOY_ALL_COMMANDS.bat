@echo off
REM ========================================
REM FIREBASE DEPLOYMENT - ALL COMMANDS
REM ========================================
REM Copy-paste lang ang commands na kailangan mo!

echo.
echo ========================================
echo FIREBASE DEPLOYMENT GUIDE
echo ========================================
echo.
echo STEP 1: Install Node.js
echo   - Go to: https://nodejs.org/
echo   - Download LTS version
echo   - Install (next, next, finish)
echo.
echo STEP 2: Install Firebase CLI
echo   Command: npm install -g firebase-tools
echo.
echo STEP 3: Login to Firebase
echo   Command: firebase login
echo.
echo STEP 4: Go to project folder
echo   Command: cd c:\Users\pcuser\CascadeProjects\logbook-system
echo.
echo STEP 5: Initialize Firebase
echo   Command: firebase init
echo   - Select: Functions, Hosting
echo   - Language: Python
echo   - Install dependencies: Yes
echo.
echo STEP 6: Set environment variables
echo   Command: firebase functions:config:set secret.key="your-secret-key"
echo   Command: firebase functions:config:set admin.username="admin"
echo   Command: firebase functions:config:set admin.password="your-password"
echo.
echo STEP 7: Deploy
echo   Command: firebase deploy --only functions
echo.
echo ========================================
echo.
echo Press any key to open Command Prompt...
pause >nul

REM Open new command prompt window
start cmd /k "cd /d c:\Users\pcuser\CascadeProjects\logbook-system && echo Firebase Deployment Ready! && echo. && echo Run these commands one by one: && echo. && echo 1. npm install -g firebase-tools && echo 2. firebase login && echo 3. firebase init && echo 4. firebase functions:config:set admin.password=your-password && echo 5. firebase deploy --only functions"
