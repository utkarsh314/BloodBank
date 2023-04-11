# Generated by Django 4.2 on 2023-04-11 11:27

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('bms', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='PatientContact',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('contact', models.CharField(max_length=50)),
                ('patient', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='bms.patient')),
            ],
        ),
        migrations.CreateModel(
            name='DonorContact',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('contact', models.CharField(max_length=50)),
                ('donor', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='bms.donor')),
            ],
        ),
    ]