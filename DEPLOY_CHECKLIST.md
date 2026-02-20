# ✅ Firebase Deployment Checklist

## 📝 Pre-Deployment Checklist

- [ ] Node.js installed (https://nodejs.org/)
- [ ] Firebase CLI installed (`npm install -g firebase-tools`)
- [ ] Logged in to Firebase (`firebase login`)
- [ ] Created Firebase project sa console.firebase.google.com
- [ ] All files ready (functions/main.py, firebase.json, etc.)

## 🚀 Deployment Steps

### 1️⃣ Install Node.js
```
✅ Download from: https://nodejs.org/
✅ Install (next, next, finish)
✅ Verify: node --version
```

### 2️⃣ Install Firebase CLI
```bash
npm install -g firebase-tools
```

### 3️⃣ Login
```bash
firebase login
```
✅ Browser opens → Login with Gmail → Allow → Success!

### 4️⃣ Create Project (sa browser)
```
✅ Go to: https://console.firebase.google.com
✅ Click "Add project"
✅ Name: logbook-app
✅ Create project
```

### 5️⃣ Initialize
```bash
cd c:\Users\pcuser\CascadeProjects\logbook-system
firebase init
```
✅ Select: Functions, Hosting
✅ Select: Use existing project → logbook-app
✅ Language: Python
✅ Install dependencies: Yes

### 6️⃣ Set Password
```bash
firebase functions:config:set admin.password="your-password-here"
```

### 7️⃣ Deploy
```bash
firebase deploy --only functions
```

## ✅ After Deployment

- [ ] Got Function URL
- [ ] Tested app in browser
- [ ] Tested login
- [ ] Tested form submission

## 🎯 Your App URL Format

```
https://us-central1-YOUR_PROJECT_ID.cloudfunctions.net/logbook
```

---

**That's it!** 🎉
