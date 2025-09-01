from enum import Enum
from django.http import HttpRequest


class ListOfSections(Enum):
    INTRO = "Introduction"
    MC = "Main Content"
    LR = "Literature Review"
    METH = "Methodology"
    RES = "Results"
    DISC = "Discussion"
    CONC = "Conclusion"
    
class HelperMethods:
    def get_user_authentication_status(self, request: HttpRequest) -> bool:
        return request.user.is_authenticated
