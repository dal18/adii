# Logbook Web Application

A Flask + SQLite logbook system with two distinct user roles: **Viewer** (public) and **Admin** (authenticated).

## 🏗️ Architecture

### Two Actors:
1. **VIEWER** — Any person who visits the site (no login required)
2. **ADMIN** — Authenticated user who manages the logbook (login required)

## 📁 File Structure

```
logbook-system/
├── app.py                    # Main Flask application with all routes
├── database.py               # SQLite database functions
├── decorators.py            # Admin authentication decorator
├── requirements.txt         # Python dependencies
├── Procfile                 # For Railway/Render deployment
├── .env.example            # Environment variables template
└── templates/
    ├── home.html           # VIEWER: Public logbook form (no sidebar)
    ├── login.html          # Admin login (standalone)
    └── admin/
        ├── layout.html     # ADMIN: AdminLTE sidebar layout
        ├── dashboard.html  # Admin dashboard with stats
        └── logbook/
            ├── index.html  # All entries DataTable
            ├── show.html   # Single entry detail
            └── edit.html   # Edit entry form
```

## 🚀 Quick Start

### 1. Install Dependencies

```bash
pip install -r requirements.txt
```

### 2. Set Up Environment Variables

Copy `.env.example` to `.env` and configure:

```bash
cp .env.example .env
```

Edit `.env`:
```
SECRET_KEY=your-secret-key-change-in-production
ADMIN_USERNAME=admin
ADMIN_PASSWORD=admin123
```

### 3. Initialize Database

The database will be automatically created on first run. Or manually:

```bash
python database.py
```

### 4. Run the Application

```bash
python app.py
```

The app will run on `http://localhost:5000`

## 📍 Routes

### Public Routes (Viewer Access)
- `GET /` — Home page with logbook entry form
- `POST /` — Submit logbook entry

### Authentication Routes
- `GET /login` — Admin login page
- `POST /login` — Authenticate admin credentials
- `POST /logout` — Logout admin, redirect to home

### Admin Routes (Protected)
- `GET /admin` — Admin dashboard (stats, charts, recent entries)
- `GET /admin/logbook` — View all entries (DataTable)
- `GET /admin/logbook?filter=today` — View today's entries
- `GET /admin/logbook/<id>` — View single entry detail
- `GET /admin/logbook/<id>/edit` — Edit entry form
- `POST /admin/logbook/<id>/edit` — Save edited entry
- `POST /admin/logbook/<id>/delete` — Delete entry

## 🔐 Access Rules

- **Viewers** can only access `/` (home page with form)
- **Non-admin** users accessing `/admin/*` → redirected to `/login`
- **Admin** already logged in visiting `/login` → redirected to `/admin`
- After **logout** → redirected to `/` (home/viewer page)

## 📋 Logbook Form Fields

All fields are required:
- **date** — Auto-filled with today's date (read-only)
- **time** — Auto-filled with current time (read-only)
- **name** — Full name (text input)
- **gender** — Dropdown (Male, Female, Other)
- **age** — Number input
- **purpose** — Dropdown (Meeting, Inquiry, Delivery, Maintenance, Inspection, Interview, Official Business, Other)
- **position** — Position/Title (text input)
- **contact_number** — Contact number (tel input)
- **signature** — Electronic signature (canvas signature pad)

## 🗄️ Database Schema

**Table: `logbook`**
- `id` — INTEGER PRIMARY KEY AUTOINCREMENT
- `date` — TEXT NOT NULL
- `time` — TEXT NOT NULL
- `name` — TEXT NOT NULL
- `gender` — TEXT NOT NULL
- `age` — INTEGER NOT NULL
- `purpose` — TEXT NOT NULL
- `position` — TEXT NOT NULL
- `contact_number` — TEXT NOT NULL
- `signature` — TEXT (base64 PNG from canvas)
- `created_at` — TEXT DEFAULT (datetime('now','localtime'))

## 🎨 Design

### Home Page (Viewer)
- Clean, professional, full-page centered form
- No admin UI visible — no sidebar, no navbar links to admin
- Small "Admin Login" link at footer
- Green color theme (#2d6a4f, accent #52b788)
- Institution name/logo at top
- Success banner after submission, form resets

### Login Page
- Standalone centered card, no sidebar
- Username + Password fields
- Inline error flash messages
- Same green color theme
- "Back to Home" link

### Admin Layout
- AdminLTE 3.2 sidebar layout
- Sidebar links: Dashboard, All Entries, Today's Log
- Top navbar with admin name + logout button
- Logout via POST form (not GET link)

## 🚢 Deployment

### Railway / Render

1. Push code to Git repository
2. Connect repository to Railway/Render
3. Set environment variables:
   - `SECRET_KEY`
   - `ADMIN_USERNAME`
   - `ADMIN_PASSWORD`
4. Deploy!

The `Procfile` is already configured for Gunicorn.

## 📝 Notes

- Database file (`logbook.db`) is created automatically on first run
- Admin credentials are loaded from environment variables
- All admin routes are protected with `@admin_required` decorator
- Flash messages are shown on all pages
- Signature pad uses `signature_pad.js` library
- DataTables used for entry listing in admin panel

## 🔒 Security Recommendations

1. **Change default admin password** in production
2. **Use strong SECRET_KEY** in production
3. **Consider adding CSRF protection** for forms
4. **Add rate limiting** for login attempts
5. **Use HTTPS** in production
6. **Regular database backups**

---

**Version:** 1.0.0  
**License:** MIT
