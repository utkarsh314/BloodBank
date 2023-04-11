from django.urls import path
from . import views

app_name = 'bloodManagement'
urlpatterns=[
    path('donor/', views.donor, name='donor')
]