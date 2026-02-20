# Deploy Flask Project on Firebase for Free

This guide shows you how to deploy a Flask application on Firebase using their free tier (Spark Plan).

## Prerequisites

- Node.js and npm installed
- Python 3.7+ installed
- Firebase account (free)
- Existing Flask project

## Step 1: Install Firebase CLI

```bash
npm install -g firebase-tools
firebase login
```

## Step 2: Initialize Firebase in Your Project

```bash
firebase init
```

Select:
- ✅ Hosting
- ✅ Functions

When prompted:
- Choose Python as the functions language
- Use default settings for other options

## Step 3: Set Up Your Flask App

Create `functions/main.py`:

```python
from firebase_functions import https_fn
from flask import Flask, request, jsonify
import firebase_functions

app = Flask(__name__)

@app.route("/")
def index():
    return "Hello from Flask on Firebase!"

@app.route("/api/hello")
def hello():
    return jsonify({"message": "Hello from Flask API!"})

@https_fn.on_request()
def flask_app(req: https_fn.Request) -> https_fn.Response:
    """Main entry point for Firebase Cloud Functions"""
    with app.request_context(req.environ):
        return app.full_dispatch_request()
```

## Step 4: Add Dependencies

Create `functions/requirements.txt`:

```
flask==2.3.3
firebase-functions==0.2.0
```

## Step 5: Configure Firebase Hosting

Update `firebase.json`:

```json
{
  "hosting": {
    "public": "public",
    "rewrites": [
      {
        "source": "**",
        "function": "flask_app"
      }
    ],
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ]
  },
  "functions": {
    "source": "functions",
    "runtime": "python310"
  }
}
```

## Step 6: Deploy to Firebase

```bash
firebase deploy
```

## Option 2: Wrap Existing Flask App

If you already have a Flask app, create `functions/main.py`:

```python
from firebase_functions import https_fn
from your_app import app  # Import your existing Flask app

@https_fn.on_request()
def main(req: https_fn.Request) -> https_fn.Response:
    with app.request_context(req.environ):
        return app.full_dispatch_request()
```

## Free Tier Limits (Spark Plan)

| Resource | Free Limit |
|----------|------------|
| Invocations | 2M/month |
| GB-seconds | 400K/month |
| Outbound networking | 5GB/month |
| Hosting storage | 10GB |

## Important Tips

### Stateless Design
Cloud Functions are stateless. Don't rely on in-memory sessions. Use:
- Firestore for database
- Firebase Auth for authentication
- Cloud Storage for file storage

### Cold Starts
- First request after inactivity may be slow (2-5 seconds)
- Consider keeping functions warm with scheduled calls if needed

### Outbound Requests
- External HTTP calls require Blaze (pay-as-you-go) plan
- Even if you stay within free limits, outbound calls need paid plan
- Alternative: Use Render.com or Railway.app for external API calls

### Environment Variables
Set environment variables in `functions/.env`:

```
FLASK_ENV=production
SECRET_KEY=your-secret-key
```

## Testing Locally

```bash
firebase emulators:start
```

Access your app at `http://localhost:5000`

## Common Issues & Solutions

### 1. Import Errors
Ensure all dependencies are in `requirements.txt`

### 2. CORS Issues
Add CORS middleware to your Flask app:

```python
from flask_cors import CORS
CORS(app)
```

### 3. Large Response Times
- Optimize database queries
- Use caching where possible
- Consider breaking large functions into smaller ones

## Alternative Free Hosting Options

If you need outbound API calls without upgrading:

1. **Render.com** - Free tier with web services
2. **Railway.app** - $5 credit monthly
3. **Vercel** - Serverless functions (limited)
4. **PythonAnywhere** - Free tier (limited)

## Monitoring

View your function logs:
```bash
firebase functions:log
```

Check usage in Firebase Console under Functions tab.
