from functools import wraps
from flask import session, redirect, url_for, flash

def admin_required(f):
    """Decorator to protect admin routes"""
    @wraps(f)
    def decorated(*args, **kwargs):
        if not session.get('is_admin'):
            flash('Access denied. Admins only.', 'danger')
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated
