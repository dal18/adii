# 🔥 Firebase Deployment Guide (FREE!)

Firebase Functions ay libre para sa unang 2 million invocations/month. Perfect para sa logbook app!

## 📋 Prerequisites

1. **Node.js** (para sa Firebase CLI)
   - Download: https://nodejs.org/
   - Or: `choco install nodejs` (Windows)

2. **Firebase Account**
   - Sign up: https://firebase.google.com (FREE!)

## 🚀 Step-by-Step Deployment

### Step 1: Install Firebase CLI

```bash
npm install -g firebase-tools
```

### Step 2: Login to Firebase

```bash
firebase login
```

### Step 3: Initialize Firebase Project

```bash
cd c:\Users\pcuser\CascadeProjects\logbook-system
firebase init
```

**Select:**
- ✅ Functions: Configure a Cloud Functions directory
- ✅ Hosting: Configure files for Firebase Hosting

**When prompted:**
- **Functions language:** Python
- **Python version:** Python 3.11
- **Install dependencies:** Yes
- **Hosting public directory:** `public` (create empty folder)
- **Single-page app:** No
- **Set up automatic builds:** No

### Step 4: Create Public Directory (for hosting)

```bash
mkdir public
echo "Firebase Hosting placeholder" > public\index.html
```

### Step 5: Set Environment Variables

```bash
firebase functions:config:set secret.key="your-secret-key-here"
firebase functions:config:set admin.username="admin"
firebase functions:config:set admin.password="your-password-here"
```

**Or create `.env` file sa functions folder:**
```bash
# functions/.env
SECRET_KEY=your-secret-key-here
ADMIN_USERNAME=admin
ADMIN_PASSWORD=your-password-here
```

### Step 6: Deploy!

```bash
firebase deploy --only functions,hosting
```

### Step 7: Get Your URL

After deployment, makikita mo:
```
✔  Deploy complete!

Function URL: https://us-central1-YOUR_PROJECT.cloudfunctions.net/logbook
Hosting URL: https://YOUR_PROJECT.web.app
```

---

## 🔧 Alternative: Direct Firebase Functions (Mas Simple)

Kung ayaw mo ng hosting, functions lang:

```bash
firebase deploy --only functions
```

Tapos access mo:
```
https://us-central1-YOUR_PROJECT.cloudfunctions.net/logbook
```

---

## 📝 Important Notes

### Database Storage
⚠️ **SQLite files ay hindi persistent sa Firebase Functions**

**Solutions:**
1. **Firestore** (FREE tier: 50K reads/day, 20K writes/day)
2. **Cloud SQL** (may bayad pero mura)
3. **External database** (Railway, Supabase - FREE)

### Update Database to Firestore (Optional)

Kung gusto mo ng persistent storage, pwede nating i-convert sa Firestore. Sabihin mo lang!

---

## 🆓 Firebase Free Tier Limits

- **Functions:** 2 million invocations/month ✅
- **Hosting:** 10GB storage, 360MB/day transfer ✅
- **Firestore:** 50K reads/day, 20K writes/day ✅

**Perfect para sa logbook app!**

---

## 🐛 Troubleshooting

### Error: "functions directory not found"
```bash
mkdir functions
# Copy main.py and requirements.txt to functions/
```

### Error: "Python not found"
- Make sure Python 3.11 installed
- Check: `python --version`

### Error: "Module not found"
```bash
cd functions
pip install -r requirements.txt
```

### Database resets
- Normal sa Firebase Functions (ephemeral storage)
- Use Firestore para sa persistent storage

---

## ✅ Quick Commands

```bash
# Deploy functions only
firebase deploy --only functions

# Deploy hosting only  
firebase deploy --only hosting

# Deploy everything
firebase deploy

# View logs
firebase functions:log

# Delete function
firebase functions:delete logbook
```

---

## 🎯 Next Steps

1. ✅ Install Firebase CLI
2. ✅ Run `firebase login`
3. ✅ Run `firebase init`
4. ✅ Set environment variables
5. ✅ Run `firebase deploy --only functions`
6. ✅ Access your app!

**Libre at ready na!** 🚀
