# WitsNote — Setup Guide

Prereqs:
- Python 3.8+ (or your version)
- pip, virtualenv / pipenv
- MySQL (or follow Docker instructions)

1) Create a working environment
# Using venv (Linux/macOS)
```
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

# Using Windows PowerShell
```
python -m venv venv
.\venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

2) Database
# Option A: Import SQL dump
```mysql -u dbuser -p witsnote < witsnote.sql```

# Option B: Create DB and run Django migrations (recommended)
```
CREATE DATABASE witsnote;
python manage.py migrate
```

3) Environment variables
```
cp .env.example .env
```
# Edit .env and fill values

4) Static files
```
python manage.py collectstatic
```

5) Create an admin user (if needed)
```
python manage.py createsuperuser
```

6) Run
```
python manage.py runserver
```

7) Admin credentials (test)

Django superuser account:
- Username: admin
- Password: admin123

Note: Update .env with your MySQL username and password. Default local setup assumes USER=dbuser and PASSWORD=dbpassword.
