# Deployment Guide - Google Cloud Run / Firebase

This guide will help you deploy the Logbook Flask application to Google Cloud Run (recommended) or Firebase Functions.

## 🚀 Option 1: Google Cloud Run (Recommended - Easiest)

Google Cloud Run is perfect for Flask applications and is part of Google Cloud Platform.

### Prerequisites

1. **Install Google Cloud SDK**
   - Download from: https://cloud.google.com/sdk/docs/install
   - Or use: `choco install gcloudsdk` (Windows) or `brew install google-cloud-sdk` (Mac)

2. **Create Google Cloud Project**
   ```bash
   gcloud projects create logbook-app --name="Logbook Application"
   gcloud config set project logbook-app
   ```

3. **Enable Required APIs**
   ```bash
   gcloud services enable cloudbuild.googleapis.com
   gcloud services enable run.googleapis.com
   gcloud services enable containerregistry.googleapis.com
   ```

### Deploy to Cloud Run

#### Method 1: Using Cloud Build (Recommended)

1. **Build and deploy:**
   ```bash
   gcloud builds submit --config cloudbuild.yaml
   ```

2. **Set environment variables:**
   ```bash
   gcloud run services update logbook-app \
     --set-env-vars="SECRET_KEY=your-secret-key-here,ADMIN_USERNAME=admin,ADMIN_PASSWORD=your-password" \
     --region=us-central1
   ```

#### Method 2: Using Docker directly

1. **Build Docker image:**
   ```bash
   docker build -t gcr.io/logbook-app/logbook-app .
   ```

2. **Push to Google Container Registry:**
   ```bash
   docker push gcr.io/logbook-app/logbook-app
   ```

3. **Deploy to Cloud Run:**
   ```bash
   gcloud run deploy logbook-app \
     --image gcr.io/logbook-app/logbook-app \
     --platform managed \
     --region us-central1 \
     --allow-unauthenticated \
     --set-env-vars="SECRET_KEY=your-secret-key,ADMIN_USERNAME=admin,ADMIN_PASSWORD=your-password"
   ```

### Access Your App

After deployment, you'll get a URL like:
```
https://logbook-app-xxxxx-uc.a.run.app
```

---

## 🔥 Option 2: Firebase Functions (Advanced)

Firebase Functions supports Python runtime, but requires more setup.

### Prerequisites

1. **Install Firebase CLI:**
   ```bash
   npm install -g firebase-tools
   ```

2. **Login to Firebase:**
   ```bash
   firebase login
   ```

3. **Initialize Firebase project:**
   ```bash
   firebase init functions
   ```

### Setup Firebase Functions

1. **Create `firebase.json`:**
   ```json
   {
     "functions": {
       "source": ".",
       "runtime": "python311"
     }
   }
   ```

2. **Create `functions/main.py`:**
   ```python
   from flask import Flask
   import functions_framework
   from app import app

   @functions_framework.http
   def logbook(request):
       return app(request.environ, lambda status, headers: None)
   ```

3. **Update `functions/requirements.txt`:**
   ```
   Flask==2.3.3
   python-dotenv==1.0.0
   functions-framework==3.5.0
   ```

4. **Deploy:**
   ```bash
   firebase deploy --only functions
   ```

---

## 🌐 Option 3: Railway (Easiest Alternative)

Railway is simpler and doesn't require Google Cloud setup.

1. **Sign up at:** https://railway.app
2. **Connect GitHub repository**
3. **Add environment variables:**
   - `SECRET_KEY`
   - `ADMIN_USERNAME`
   - `ADMIN_PASSWORD`
4. **Deploy!** Railway auto-detects Flask apps.

---

## 🌐 Option 4: Render (Free Tier Available)

1. **Sign up at:** https://render.com
2. **Create new Web Service**
3. **Connect repository**
4. **Set build command:** `pip install -r requirements.txt`
5. **Set start command:** `gunicorn app:app`
6. **Add environment variables**
7. **Deploy!**

---

## 📝 Environment Variables

Set these in your deployment platform:

```bash
SECRET_KEY=your-strong-random-secret-key-here
ADMIN_USERNAME=admin
ADMIN_PASSWORD=your-secure-password-here
```

**Generate SECRET_KEY:**
```python
import secrets
print(secrets.token_hex(32))
```

---

## 🔧 Post-Deployment Checklist

- [ ] Update `SECRET_KEY` to a strong random value
- [ ] Change `ADMIN_PASSWORD` from default
- [ ] Test login functionality
- [ ] Test form submission
- [ ] Verify database persistence
- [ ] Set up custom domain (optional)
- [ ] Enable HTTPS (automatic on Cloud Run)

---

## 🐛 Troubleshooting

### Database Issues
- Cloud Run uses ephemeral storage - database resets on restart
- **Solution:** Use Cloud SQL or Cloud Firestore for persistent storage

### Port Issues
- Cloud Run uses `PORT` environment variable
- The Dockerfile already handles this

### Static Files
- Flask serves templates automatically
- No additional configuration needed

---

## 📚 Recommended: Cloud Run

**Why Cloud Run?**
- ✅ Free tier: 2 million requests/month
- ✅ Auto-scaling
- ✅ HTTPS by default
- ✅ Easy deployment
- ✅ Pay only for what you use

**Next Steps:**
1. Follow Option 1 (Cloud Run) above
2. Your app will be live in minutes!

---

**Need help?** Check Google Cloud Run documentation: https://cloud.google.com/run/docs
