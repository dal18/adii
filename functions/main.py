"""
Firebase Functions entry point for Flask app
"""
import os
import sys
from pathlib import Path
from io import BytesIO

# Add parent directory to Python path
parent_dir = Path(__file__).parent.parent
sys.path.insert(0, str(parent_dir))

# Set environment variables (Firebase Functions reads from os.environ)
# These can be set via: firebase functions:config:set secret.key="value"
# Firebase automatically converts config to environment variables
os.environ.setdefault('SECRET_KEY', os.environ.get('SECRET_KEY', 'your-secret-key-change-in-production'))
os.environ.setdefault('ADMIN_USERNAME', os.environ.get('ADMIN_USERNAME', 'admin'))
os.environ.setdefault('ADMIN_PASSWORD', os.environ.get('ADMIN_PASSWORD', 'admin123'))

# Import Flask app AFTER setting env vars
from app import app as flask_app

# Firebase Functions Framework
import functions_framework

@functions_framework.http
def logbook(request):
    """
    Firebase HTTP Function wrapper for Flask app
    
    Firebase Functions provides a Flask-like request object
    """
    # Build WSGI environ from Firebase request
    environ = {
        'REQUEST_METHOD': request.method,
        'SCRIPT_NAME': '',
        'PATH_INFO': request.path or '/',
        'QUERY_STRING': request.query_string.decode('utf-8') if hasattr(request, 'query_string') and request.query_string else '',
        'CONTENT_TYPE': request.headers.get('Content-Type', ''),
        'CONTENT_LENGTH': str(len(request.data)) if request.data else '0',
        'SERVER_NAME': 'localhost',
        'SERVER_PORT': '443',
        'wsgi.version': (1, 0),
        'wsgi.url_scheme': 'https',
        'wsgi.input': BytesIO(request.data) if request.data else BytesIO(),
        'wsgi.errors': sys.stderr,
        'wsgi.multithread': False,
        'wsgi.multiprocess': False,
        'wsgi.run_once': False,
    }
    
    # Add HTTP headers
    for key, value in request.headers.items():
        key = key.upper().replace('-', '_')
        if key not in ('CONTENT_TYPE', 'CONTENT_LENGTH'):
            environ[f'HTTP_{key}'] = value
    
    # Handle form data
    if request.method in ('POST', 'PUT', 'PATCH'):
        if 'application/x-www-form-urlencoded' in environ.get('CONTENT_TYPE', ''):
            environ['wsgi.input'] = BytesIO(request.data)
    
    # Response storage
    status = [200]
    headers = []
    
    def start_response(response_status, response_headers):
        status[0] = int(response_status.split()[0])
        headers[:] = response_headers
    
    # Call Flask app
    with flask_app.app_context():
        response = flask_app(environ, start_response)
        body = b''.join(response).decode('utf-8') if response else ''
        
        return (body, status[0], dict(headers))
