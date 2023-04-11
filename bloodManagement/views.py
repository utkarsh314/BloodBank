from django.shortcuts import render

# Create your views here.
def donor(request):
    if request.method == 'GET':
        return render(request, 'bloodManagement/donor.html')