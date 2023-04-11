from django.shortcuts import render
import mysql.connector as con

db = con.connect(
    host ="localhost",
    user ="root",
    passwd ="laptop",
    database = "bloodbank"
)
c = db.cursor()

# Create your views here.
def donor(request):
    if request.method == 'GET':
        c.execute("SELECT * FROM `bms_donor`")
        donors = c.fetchall()
        context = {
            'donors' : []
        }
        for (id, first_name, last_name, age, gender, medical_history, A, B, Rh) in donors:
            c.execute(f"SELECT GROUP_CONCAT(`contact`) FROM `bms_donorcontact` WHERE `donor_id` = {id}")
            contact = c.fetchone()[0]
            c.execute(f"SELECT date_donated, quantity_donated FROM `bms_sample` WHERE `donor_id` = {id}")
            donation_history = '\n'.join([f'{a}: {b}' for (a,b) in c.fetchall()])
            context['donors'].append({
                'id' : id,
                'name': first_name + ' ' + last_name,
                'age': age,
                'gender': gender,
                'medical_history': medical_history,
                'donation_history': donation_history,
                'blood_group': f"{'O' if not A and not B else ''}{['','A'][A]}{['','B'][B]}{'-+'[Rh]}",
                'contact': contact if contact else ''
            })
        return render(request, 'bloodManagement/donor.html', context=context)
    
def sample(request):
    if request.method == 'GET':
        c.execute("""SELECT
            `date_donated`,
            `location`,
            `quantity_donated`,
            `quantity_available`,
            CASE
                WHEN DATEDIFF(CURDATE(), `date_donated`) <= 42 THEN 'available'
                ELSE 'expired'
            END AS `status`
            FROM `bms_sample`;""")
        samples = c.fetchall()
        context = {
            'samples' : []
        }
        for (date_donated, location, quantity_donated, quantity_available, status) in samples:
            context['samples'].append({
                'date_donated':date_donated,
                'quantity_donated':quantity_donated,
                'quantity_available':quantity_available,
                'status':status,
                'location':location
            })
        return render(request, 'bloodManagement/sample.html', context=context)
    
def patient(request):
    if request.method == 'GET':
        c.execute("SELECT * FROM `bms_patient`")
        patients = c.fetchall()
        context = {
            'patients' : []
        }
        for (id, first_name, last_name, age, gender, medical_history, A, B, Rh) in patients:
            c.execute(f"SELECT GROUP_CONCAT(`contact`) FROM `bms_patientcontact` WHERE `patient_id` = {id}")
            contact = c.fetchone()[0]
            context['patients'].append({
                'id' : id,
                'name': first_name + ' ' + last_name,
                'age': age,
                'gender': gender,
                'medical_history': medical_history,
                'blood_group': f"{'O' if not A and not B else ''}{['','A'][A]}{['','B'][B]}{'-+'[Rh]}",
                'contact': contact if contact else ''
            })
        return render(request, 'bloodManagement/patient.html', context=context)
    
def transfusion(request):
    if request.method == 'GET':
        c.execute("SELECT * FROM `bms_donation`")
        transfusions = c.fetchall()
        context = {
            'transfusions' : []
        }
        for (id, date_used, quantity_used, sample_id, patient_id) in transfusions:
            c.execute(f"SELECT first_name, last_name FROM `bms_patient` WHERE `id` = {patient_id}")
            pname = c.fetchone()
            c.execute(f"""
                SELECT 
                    first_name,
                    last_name
                FROM 
                    `bms_donor` 
                WHERE `id` = (
                    SELECT 
                        donor_id 
                    FROM 
                        `bms_sample`
                    WHERE 
                        `id` = {sample_id}
                )""")
            dname = c.fetchone()
            context['transfusions'].append({
                'patient_name': pname[0]+' '+pname[1],
                'date_used': date_used,
                'quantity_used': quantity_used,
                'donor_name': dname[0]+' '+dname[1],
            })
        return render(request, 'bloodManagement/transfusion.html', context=context)