from django.db import models

# Create your models here.
class Donor(models.Model):
    first_name = models.CharField(max_length=20, null=False)
    last_name = models.CharField(max_length=20)
    age = models.PositiveIntegerField(null=False)
    Gender = models.CharField(max_length=1, null=False)
    medical_history = models.TextField()
    A = models.BooleanField(null=False)
    B = models.BooleanField(null=False)
    Rh = models.BooleanField(null=False)

class Sample(models.Model):
    donor = models.ForeignKey(Donor, on_delete=models.CASCADE)
    date_of_collection = models.DateField(null=False)
    location = models.CharField(max_length=50)
    quantity = models.PositiveIntegerField()
    quantity_used = models.PositiveIntegerField() 
