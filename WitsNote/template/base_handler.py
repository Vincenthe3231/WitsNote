from abc import ABC, abstractmethod
from django.http import HttpRequest, HttpResponse

class BasePostHandler(ABC):
    def __init__(self, request: HttpRequest):   # Constructor to initialize the request where it maps HttpRequest to self.request
        self.request = request

    def handle(self) -> HttpResponse:   # "-> HttpResponse" is a type hint indicating the method is expected to return an HttpResponse
        if self.request.method != "POST":
            return HttpResponse(status=405)
        
        return self.process_post()
        
    def invalid_method(self) -> HttpResponse:
        return HttpResponse("Invalid request method", status=405)
    
    @abstractmethod
    def process_post(self) -> HttpResponse:
        pass