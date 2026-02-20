# 🚀 Step-by-Step Deployment Guide (SUPER SIMPLE!)

Sundin mo lang step by step, guaranteed working!

## 📋 STEP 1: Install Node.js (Para sa Firebase CLI)

1. **Download Node.js:**
   - Pumunta: https://nodejs.org/
   - Download "LTS" version (recommended)
   - Install (next, next, finish)

2. **Verify installation:**
   - Open Command Prompt o PowerShell
   - Type: `node --version`
   - Dapat may lumabas na version number

---

## 📋 STEP 2: Install Firebase CLI

1. **Open Command Prompt o PowerShell**

2. **Run this command:**
   ```bash
   npm install -g firebase-tools
   ```

3. **Wait for installation** (may take 1-2 minutes)

---

## 📋 STEP 3: Login to Firebase

1. **Run:**
   ```bash
   firebase login
   ```

2. **May mag-o-open na browser**
   - Login using your Gmail account
   - Allow permissions
   - Balik sa terminal, dapat may "Success!"

---

## 📋 STEP 4: Create Firebase Project

1. **Pumunta sa:** https://console.firebase.google.com

2. **Click "Add project" o "Create a project"**

3. **Project name:** `logbook-app` (o kahit anong name)

4. **Disable Google Analytics** (optional, pwede i-enable)

5. **Click "Create project"**

6. **Wait for creation** (30 seconds)

---

## 📋 STEP 5: Initialize Firebase sa Project Mo

1. **Open Command Prompt/PowerShell**

2. **Pumunta sa project folder:**
   ```bash
   cd c:\Users\pcuser\CascadeProjects\logbook-system
   ```

3. **Run:**
   ```bash
   firebase init
   ```

4. **Sagutin ang prompts:**

   **Q: Which Firebase features?**
   - ✅ **Functions** (press Space to select, then Enter)
   - ✅ **Hosting** (optional, pero recommended)
   - Press Enter

   **Q: Please select an option:**
   - Select: **Use an existing project**
   - Select: **logbook-app** (yung ginawa mo sa Step 4)

   **Q: What language?**
   - Select: **Python**

   **Q: Do you want to use a Python virtual environment?**
   - Type: **N** (No)

   **Q: Do you want to install dependencies now?**
   - Type: **Y** (Yes)

   **Q: What do you want to use as your public directory?**
   - Type: **public** (then Enter)

   **Q: Configure as a single-page app?**
   - Type: **N** (No)

   **Q: Set up automatic builds?**
   - Type: **N** (No)

---

## 📋 STEP 6: Set Environment Variables

1. **Run these commands** (palitan ang values):

   ```bash
   firebase functions:config:set secret.key="your-secret-key-change-this-12345"
   firebase functions:config:set admin.username="admin"
   firebase functions:config:set admin.password="your-password-here"
   ```

   **Example:**
   ```bash
   firebase functions:config:set secret.key="my-super-secret-key-2026"
   firebase functions:config:set admin.username="admin"
   firebase functions:config:set admin.password="mypassword123"
   ```

---

## 📋 STEP 7: Deploy!

1. **Run:**
   ```bash
   firebase deploy --only functions
   ```

2. **Wait** (5-10 minutes sa first deployment)

3. **Makikita mo ang URL:**
   ```
   Function URL: https://us-central1-YOUR_PROJECT.cloudfunctions.net/logbook
   ```

---

## ✅ DONE!

**Access mo ang app sa URL na binigay!**

---

## 🐛 Kung May Error

### Error: "firebase: command not found"
- **Solution:** Close and reopen Command Prompt, then try again

### Error: "Python not found"
- **Solution:** Install Python 3.11 from python.org

### Error: "Module not found"
- **Solution:** 
  ```bash
  cd functions
  pip install -r requirements.txt
  cd ..
  firebase deploy --only functions
  ```

### Error: "Permission denied"
- **Solution:** Run Command Prompt as Administrator

---

## 📞 Need Help?

Kung may error, i-copy ang buong error message at sabihin mo sa akin!

---

## 🎯 Quick Checklist

- [ ] Node.js installed
- [ ] Firebase CLI installed (`npm install -g firebase-tools`)
- [ ] Logged in (`firebase login`)
- [ ] Created Firebase project sa console
- [ ] Initialized (`firebase init`)
- [ ] Set environment variables
- [ ] Deployed (`firebase deploy --only functions`)
- [ ] Got URL!

**Good luck!** 🚀
