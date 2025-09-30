import os
import fireabse_admin   
from firebase_admin import credentials  # pyright: ignore

# BASE_DIR = os.path.dirname(os.path.abspath(__file__))
# SERVICE_ACCOUNT_KEY = os.path.join(BASE_DIR, 'serviceAccountKey.json')

if not firebase_admin.apps: # type: ignore
    cred = credentials.Certificate("serviceAccountKey.json")
    firebase_admin.initialize_app(cred) # pyright: ignore