from rest_framework.authentication import BaseAuthentication # type: ignore
from rest_framework.exceptions import AuthenticationFailed   # pyright: ignore
from firebase_admin import auth                              # type: ignore
from django.contrib.auth.models import User

class FirebaseAuthentication(BaseAuthentication):
    def authenticate(self, request):
        id_token = request.META.get('HTTP_AUTHORIZATION')
        if not id_token:
            return None

        if id_token.startswith("Bearer "):
            id_token = id_token[7:]

        try:
            decoded_token = auth.verify_id_token(id_token)
            uid = decoded_token['uid']
        except Exception:
            raise AuthenticationFailed('Invalid Firebase token')

        # Map Firebase UID → Django User
        user, _ = User.objects.get_or_create(username=uid)
        user.email = decoded_token.get('email', user.email)  # sync email if available
        user.save()

        return (user, None)
