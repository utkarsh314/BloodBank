from django.db import models

# Create your models here.
class Donor(models.Model):
    first_name = models.CharField(max_length=20, null=False)
    last_name = models.CharField(max_length=20)
    age = models.PositiveIntegerField(null=False)
    gender = models.CharField(max_length=1, null=False)
    medical_history = models.TextField()
    A = models.BooleanField(null=False)
    B = models.BooleanField(null=False)
    Rh = models.BooleanField(null=False)

class DonorContact(models.Model):
    contact = models.CharField(max_length = 50, null=False)
    donor = models.ForeignKey(Donor, on_delete = models.CASCADE)

class Sample(models.Model):
    donor = models.ForeignKey(Donor, on_delete=models.CASCADE)
    date_donated = models.DateField(null=False)
    location = models.CharField(max_length=50, null=False)
    quantity_donated = models.PositiveIntegerField(null=False)
    quantity_available = models.PositiveIntegerField(null=False) 

class Patient(models.Model):
    first_name = models.CharField(max_length=20, null=False)
    last_name = models.CharField(max_length=20)
    age = models.PositiveIntegerField(null=False)
    gender = models.CharField(max_length=1, null=False)
    medical_history = models.TextField()
    A = models.BooleanField(null=False)
    B = models.BooleanField(null=False)
    Rh = models.BooleanField(null=False)

class PatientContact(models.Model):
    contact = models.CharField(max_length=50, null=False)
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE)

class Donation(models.Model):
    date_used = models.DateField(null=False)
    quantity_used = models.PositiveIntegerField(null=False)
    sample = models.ForeignKey(Sample, on_delete=models.CASCADE)
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE)
