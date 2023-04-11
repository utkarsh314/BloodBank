from django.urls import path
from . import views

app_name = 'bloodManagement'
urlpatterns=[
    path('donor/', views.donor, name='donor'),
    path('inventory/', views.sample, name='sample'),
    path('patient/', views.patient, name='patient'),
    path('transfusion/', views.transfusion, name='transfusion'),
]