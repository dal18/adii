# 🔥 Firebase Deployment - Quick Start (LIBRE!)

## ✅ Step 1: Install Firebase CLI

```bash
npm install -g firebase-tools
```

## ✅ Step 2: Login

```bash
firebase login
```

## ✅ Step 3: Initialize Project

```bash
cd c:\Users\pcuser\CascadeProjects\logbook-system
firebase init
```

**Select:**
- ✅ Functions
- ✅ Hosting (optional)

**When asked:**
- Language: **Python**
- Python version: **Python 3.11**
- Install dependencies: **Yes**

## ✅ Step 4: Set Environment Variables

```bash
firebase functions:config:set secret.key="your-secret-key-here"
firebase functions:config:set admin.username="admin"
firebase functions:config:set admin.password="your-password-here"
```

## ✅ Step 5: Deploy!

```bash
firebase deploy --only functions
```

## ✅ Step 6: Access Your App

After deployment, makikita mo ang URL:
```
https://us-central1-YOUR_PROJECT.cloudfunctions.net/logbook
```

---

## 🎯 O Mas Madali - Gamitin ang Script

```bash
firebase-deploy.bat
```

Sundin lang ang prompts!

---

## 📝 Important Notes

1. **Database:** SQLite ay reset sa Firebase Functions (ephemeral storage)
   - **Solution:** Use Firestore (FREE!) para sa persistent storage
   - Sabihin mo lang kung gusto mo i-convert sa Firestore!

2. **Free Tier:**
   - ✅ 2 million function invocations/month
   - ✅ 400K GB-seconds compute time
   - ✅ Perfect para sa logbook app!

---

## 🚀 Ready na!

Lahat ng files ay ready na:
- ✅ `functions/main.py` - Firebase Functions wrapper
- ✅ `functions/requirements.txt` - Dependencies
- ✅ `firebase.json` - Firebase config
- ✅ `firebase-deploy.bat` - Deployment script

**Run mo lang:** `firebase-deploy.bat` o `firebase deploy --only functions`

**Libre at working na!** 🔥
