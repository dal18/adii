@echo off
REM Quick deployment script for Google Cloud Run (Windows)

echo Deploying Logbook App to Google Cloud Run...

REM Set your project ID
set PROJECT_ID=logbook-app
set REGION=us-central1
set SERVICE_NAME=logbook-app

REM Set environment variables (change these!)
set SECRET_KEY=your-secret-key-change-this
set ADMIN_USERNAME=admin
set ADMIN_PASSWORD=change-this-password

REM Build and deploy
echo Building Docker image...
gcloud builds submit --tag gcr.io/%PROJECT_ID%/%SERVICE_NAME%

echo Deploying to Cloud Run...
gcloud run deploy %SERVICE_NAME% --image gcr.io/%PROJECT_ID%/%SERVICE_NAME% --platform managed --region %REGION% --allow-unauthenticated --set-env-vars="SECRET_KEY=%SECRET_KEY%,ADMIN_USERNAME=%ADMIN_USERNAME%,ADMIN_PASSWORD=%ADMIN_PASSWORD%" --memory=512Mi --cpu=1

echo Deployment complete!
echo Your app URL will be displayed above.
pause
