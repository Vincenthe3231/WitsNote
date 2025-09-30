# firebase_integration/views.py
from rest_framework.views import APIView                    # type: ignore
from rest_framework.permissions import IsAuthenticated      # type: ignore
from rest_framework.response import Response                # type: ignore
from WitsNote.models import Post
from WitsNote.serializers import PostSerializer             # type: ignore

class PublishNoteView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        data = request.data
        data['author'] = request.user.id
        serializer = PostSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return Response({'status': 'Note published'})
        return Response(serializer.errors, status=400)
