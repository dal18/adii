#!/bin/bash
# Quick deployment script for Google Cloud Run

echo "🚀 Deploying Logbook App to Google Cloud Run..."

# Set your project ID
PROJECT_ID="logbook-app"
REGION="us-central1"
SERVICE_NAME="logbook-app"

# Set environment variables (change these!)
SECRET_KEY="your-secret-key-change-this"
ADMIN_USERNAME="admin"
ADMIN_PASSWORD="change-this-password"

# Build and deploy
echo "📦 Building Docker image..."
gcloud builds submit --tag gcr.io/$PROJECT_ID/$SERVICE_NAME

echo "🚀 Deploying to Cloud Run..."
gcloud run deploy $SERVICE_NAME \
  --image gcr.io/$PROJECT_ID/$SERVICE_NAME \
  --platform managed \
  --region $REGION \
  --allow-unauthenticated \
  --set-env-vars="SECRET_KEY=$SECRET_KEY,ADMIN_USERNAME=$ADMIN_USERNAME,ADMIN_PASSWORD=$ADMIN_PASSWORD" \
  --memory=512Mi \
  --cpu=1

echo "✅ Deployment complete!"
echo "Your app URL will be displayed above."
