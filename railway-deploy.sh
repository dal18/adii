#!/bin/bash

echo "========================================"
echo "Deploying Logbook System to Railway"
echo "========================================"

# Check if Railway CLI is installed
if ! command -v railway &> /dev/null; then
    echo "Railway CLI not found. Installing..."
    npm install -g @railway/cli
fi

# Login to Railway (if not already logged in)
echo "Checking Railway login status..."
railway whoami || {
    echo "Please login to Railway:"
    railway login
}

# Initialize Railway project
echo "Initializing Railway project..."
railway init

# Set environment variables
echo "Setting environment variables..."
railway variables set SECRET_KEY="your-secret-key-here"
railway variables set ADMIN_USERNAME="admin"
railway variables set ADMIN_PASSWORD="admin123"

# Deploy to Railway
echo "Deploying to Railway..."
railway up

echo ""
echo "========================================"
echo "Deployment Complete!"
echo "========================================"
echo ""
echo "Your app will be available at:"
echo "https://your-app-name.up.railway.app"
echo ""
echo "Check your Railway dashboard for the actual URL"
echo ""
