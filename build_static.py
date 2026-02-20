#!/usr/bin/env python3
"""
Build static version of Flask app for GitHub Pages deployment
"""
import os
import shutil
from app import app
from flask import url_for

def build_static():
    """Build static files for GitHub Pages"""
    
    # Create docs directory for GitHub Pages
    docs_dir = 'docs'
    if os.path.exists(docs_dir):
        shutil.rmtree(docs_dir)
    os.makedirs(docs_dir)
    
    # Copy static files
    if os.path.exists('static'):
        shutil.copytree('static', os.path.join(docs_dir, 'static'))
    
    # Create a simple HTML version
    with app.app_context():
        with app.test_client() as client:
            # Get the main page
            response = client.get('/')
            if response.status_code == 200:
                with open(os.path.join(docs_dir, 'index.html'), 'w', encoding='utf-8') as f:
                    f.write(response.get_data(as_text=True))
    
    print(f"Static site built in {docs_dir}/ directory")

if __name__ == '__main__':
    build_static()
