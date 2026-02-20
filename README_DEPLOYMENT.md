# 🚀 Deployment Guide

## Quick Start - Google Cloud Run (Recommended)

### Prerequisites
1. Google Cloud account (free tier available)
2. Google Cloud SDK installed
3. Docker installed (optional, Cloud Build handles it)

### Deployment Steps

#### 1. Setup Google Cloud

```bash
# Login
gcloud auth login

# Create project
gcloud projects create logbook-app-$(date +%s) --name="Logbook App"

# Set project (replace with your project ID)
gcloud config set project YOUR_PROJECT_ID

# Enable APIs
gcloud services enable cloudbuild.googleapis.com
gcloud services enable run.googleapis.com
gcloud services enable containerregistry.googleapis.com
```

#### 2. Deploy

**Windows:**
```cmd
# Edit deploy-cloud-run.bat with your project ID and values
deploy-cloud-run.bat
```

**Mac/Linux:**
```bash
# Edit deploy-cloud-run.sh with your project ID and values
chmod +x deploy-cloud-run.sh
./deploy-cloud-run.sh
```

**Or manually:**
```bash
# Build
gcloud builds submit --tag gcr.io/YOUR_PROJECT_ID/logbook-app

# Deploy
gcloud run deploy logbook-app \
  --image gcr.io/YOUR_PROJECT_ID/logbook-app \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --set-env-vars="SECRET_KEY=your-secret-key,ADMIN_USERNAME=admin,ADMIN_PASSWORD=your-password" \
  --memory=512Mi
```

#### 3. Get Your URL

After deployment, you'll see:
```
Service URL: https://logbook-app-xxxxx-uc.a.run.app
```

---

## 🔥 Firebase Functions (Alternative)

See `firebase-functions-setup.md` for detailed instructions.

**Note:** Cloud Run is easier and more suitable for Flask apps.

---

## 🌐 Other Options

### Railway (Easiest - No Config Needed)
1. Sign up at https://railway.app
2. Connect GitHub repo
3. Add env variables
4. Deploy automatically!

### Render (Free Tier)
1. Sign up at https://render.com
2. New Web Service
3. Connect repo
4. Build: `pip install -r requirements.txt`
5. Start: `gunicorn app:app`
6. Add env variables
7. Deploy!

---

## 📝 Environment Variables

Set these in your deployment platform:

```
SECRET_KEY=<generate-random-key>
ADMIN_USERNAME=admin
ADMIN_PASSWORD=<strong-password>
```

Generate SECRET_KEY:
```python
import secrets
print(secrets.token_hex(32))
```

---

## ⚠️ Important Notes

1. **Database:** SQLite resets on Cloud Run restarts. For production, use:
   - Cloud SQL (PostgreSQL)
   - Cloud Firestore
   - Or Railway/Render (persistent storage)

2. **HTTPS:** Automatically enabled on Cloud Run

3. **Custom Domain:** Can be configured in Cloud Run settings

---

## ✅ Files Created

- `Dockerfile` - Container configuration
- `.dockerignore` - Files to exclude from Docker
- `cloudbuild.yaml` - Cloud Build configuration
- `deploy-cloud-run.bat` - Windows deployment script
- `deploy-cloud-run.sh` - Linux/Mac deployment script
- `DEPLOY.md` - Detailed deployment guide
- `QUICK_DEPLOY.md` - Quick start guide

---

**Ready to deploy!** Follow the steps above. 🚀
