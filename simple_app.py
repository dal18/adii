from flask import Flask
import os

app = Flask(__name__)

# Configure for production
app.config['SECRET_KEY'] = os.environ.get('SECRET_KEY', 'dev-secret-key')

@app.route('/')
def hello():
    return """
    <h1>Flask App is Working!</h1>
    <p>This is a test to verify Railway deployment.</p>
    <p>Environment variables loaded: {}</p>
    <a href="/health">Health Check</a>
    """.format(bool(os.environ.get('SECRET_KEY')))

@app.route('/health')
def health():
    return {"status": "healthy", "service": "flask-app"}

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0', port=5000)
