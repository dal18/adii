# Firebase Functions Setup (Advanced)

If you specifically want to use Firebase Functions instead of Cloud Run, follow these steps:

## Setup Steps

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

3. **Create `functions/main.py`:**
   ```python
   import functions_framework
   from flask import Flask
   import sys
   import os
   
   # Add parent directory to path
   sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
   
   from app import app as flask_app
   
   @functions_framework.http
   def logbook(request):
       with flask_app.app_context():
           return flask_app.full_dispatch_request()
   ```

4. **Update `functions/requirements.txt`:**
   ```
   Flask==2.3.3
   python-dotenv==1.0.0
   functions-framework==3.5.0
   gunicorn==21.2.0
   ```

5. **Deploy:**
   ```bash
   firebase deploy --only functions
   ```

**Note:** Firebase Functions has limitations and Cloud Run is recommended for Flask apps.
