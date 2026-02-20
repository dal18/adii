# 🚀 Quick Deployment Guide

## Deploy to Google Cloud Run (Recommended)

### Step 1: Install Google Cloud SDK

**Windows:**
```powershell
# Download and install from:
# https://cloud.google.com/sdk/docs/install
# Or use Chocolatey:
choco install gcloudsdk
```

**Mac:**
```bash
brew install google-cloud-sdk
```

**Linux:**
```bash
curl https://sdk.cloud.google.com | bash
```

### Step 2: Login and Setup

```bash
# Login to Google Cloud
gcloud auth login

# Create a new project (or use existing)
gcloud projects create logbook-app-$(date +%s) --name="Logbook Application"

# Set the project
gcloud config set project YOUR_PROJECT_ID

# Enable required APIs
gcloud services enable cloudbuild.googleapis.com
gcloud services enable run.googleapis.com
gcloud services enable containerregistry.googleapis.com
```

### Step 3: Deploy

**Option A: Using the batch script (Windows)**
```cmd
# Edit deploy-cloud-run.bat and set your values, then:
deploy-cloud-run.bat
```

**Option B: Manual deployment**
```bash
# Build and deploy
gcloud builds submit --tag gcr.io/YOUR_PROJECT_ID/logbook-app

# Deploy to Cloud Run
gcloud run deploy logbook-app \
  --image gcr.io/YOUR_PROJECT_ID/logbook-app \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --set-env-vars="SECRET_KEY=your-secret-key-here,ADMIN_USERNAME=admin,ADMIN_PASSWORD=your-password" \
  --memory=512Mi
```

### Step 4: Get Your URL

After deployment, you'll see:
```
Service [logbook-app] revision [logbook-app-xxxxx] has been deployed
Service URL: https://logbook-app-xxxxx-uc.a.run.app
```

---

## 🔥 Alternative: Firebase Hosting + Cloud Functions

If you specifically want Firebase, you'll need to use Cloud Functions:

1. **Install Firebase CLI:**
   ```bash
   npm install -g firebase-tools
   firebase login
   ```

2. **Initialize Firebase:**
   ```bash
   firebase init functions
   # Select Python when prompted
   ```

3. **Create `firebase.json`:**
   ```json
   {
     "functions": {
       "source": ".",
       "runtime": "python311"
     }
   }
   ```

4. **Create wrapper function** (see DEPLOY.md for details)

5. **Deploy:**
   ```bash
   firebase deploy --only functions
   ```

---

## ⚡ Even Easier: Railway or Render

### Railway (Recommended for simplicity)

1. Go to https://railway.app
2. Sign up with GitHub
3. Click "New Project" → "Deploy from GitHub repo"
4. Select your repository
5. Add environment variables:
   - `SECRET_KEY`
   - `ADMIN_USERNAME`
   - `ADMIN_PASSWORD`
6. Deploy! (Automatic)

### Render

1. Go to https://render.com
2. Sign up
3. New → Web Service
4. Connect repository
5. Settings:
   - **Build Command:** `pip install -r requirements.txt`
   - **Start Command:** `gunicorn app:app`
6. Add environment variables
7. Deploy!

---

## 📝 Important Notes

1. **Database:** SQLite files reset on Cloud Run restarts. For production, consider:
   - Cloud SQL (PostgreSQL/MySQL)
   - Cloud Firestore
   - Or use Railway/Render which have persistent storage

2. **Environment Variables:** Always set these:
   ```
   SECRET_KEY=<generate-random-key>
   ADMIN_USERNAME=admin
   ADMIN_PASSWORD=<strong-password>
   ```

3. **Generate SECRET_KEY:**
   ```python
   import secrets
   print(secrets.token_hex(32))
   ```

---

## ✅ Quick Start (Cloud Run)

```bash
# 1. Install gcloud SDK
# 2. Login
gcloud auth login

# 3. Create project
gcloud projects create logbook-app-$(date +%s)

# 4. Set project
gcloud config set project YOUR_PROJECT_ID

# 5. Enable APIs
gcloud services enable cloudbuild.googleapis.com run.googleapis.com

# 6. Deploy
gcloud builds submit --tag gcr.io/YOUR_PROJECT_ID/logbook-app
gcloud run deploy logbook-app --image gcr.io/YOUR_PROJECT_ID/logbook-app --region us-central1 --allow-unauthenticated --set-env-vars="SECRET_KEY=your-key,ADMIN_USERNAME=admin,ADMIN_PASSWORD=your-pass"
```

**Done!** Your app will be live at the provided URL.
