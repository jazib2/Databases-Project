---------------------------------------------------------------------------Part 1----------------------------------------------------------------------------------------
--Database creation command

Create Database Hospital 

--Patients Entity

Create Table Patients ( Insurance_Number nvarchar(9) not null Primary Key
check (Insurance_Number like '[A-Z]______[A-Z]'),
FullName nvarchar (50) not null , Address nvarchar (50) not null, 
Date_of_Birth date not null, Telephone_Number nvarchar(20) null,
Email nvarchar(100) unique null check (Email like '%_@_%._%'), 
Date_Left date null check (Date_Left <= cast(getdate() as date)))


--Doctors Entity

Create Table Doctors (Doctor_ID int identity not null primary key, 
Full_Name nvarchar(50) not null, Speciality nvarchar(50) not null, 
availability nvarchar(30) not null, Department_ID int not null Foreign Key
(Department_ID) REFERENCES Department (Department_ID))


--Department Entity

Create Table Department(Department_ID int identity not null primary key,
Department_Name nvarchar(50) not null);


--Medical Records Entity

Create	Table Medical_Records (Medical_Records_ID int not null,
Diagnoses nvarchar(50) not null, Medicines nvarchar(50) not null, Allergies nvarchar(50) not null,
Insurance_Number nvarchar(9) not null Foreign Key (Insurance_Number )
REFERENCES Patients (Insurance_Number), Past_Appointment_ID int not null Foreign Key (Past_Appointment_ID) 
REFERENCES Appointments.Past_Appointments (Past_Appointment_ID), 
CONSTRAINT  Med_Past Primary Key (Medical_Records_ID, Past_Appointment_ID))


--Appointments Entity

Create Table Appointments (Appointment_ID int not null Primary Key, Appointment_Date date not null,
Appointment_Time time not null, status nvarchar(20) not null, Doctor_ID int not null Foreign Key
(Doctor_ID) REFERENCES Doctors (Doctor_ID), Insurance_Number nvarchar(9) not null Foreign Key 
(Insurance_Number ) REFERENCES Patients (Insurance_Number), Department_ID int not null
Foreign Key (Department_ID) REFERENCES Department (Department_ID), 
Review nvarchar(250) null, 
CONSTRAINT UC_DateTime UNIQUE (Appointment_Date, Appointment_Time))


--Past_Appointments Entity

Create Table Past_Appointments (Past_Appointment_ID int identity not null Primary Key, 
Appointment_Date date not null,Appointment_Time time not null, status nvarchar(20) not null,
Doctor_ID int not null Foreign Key(Doctor_ID) REFERENCES Doctors (Doctor_ID), 
Insurance_Number nvarchar(9) not null Foreign Key (Insurance_Number ) 
REFERENCES Patients (Insurance_Number), Department_ID int not null Foreign Key
(Department_ID) REFERENCES Department (Department_ID), Review nvarchar(250) null);

--PatientsDoctors Entity

Create Table PatientsDoctors (Insurance_Number nvarchar(9) not null Foreign Key 
(Insurance_Number ) REFERENCES Patients (Insurance_Number), Doctor_ID int not null Foreign Key
(Doctor_ID) REFERENCES Doctors (Doctor_ID), 
CONSTRAINT  Pat_Doc Primary Key (Insurance_Number,Doctor_ID));



--Constraint added for Past Appointments Entity to ensure Appointment Date is in the past

Alter Table Appointments.Past_Appointments
Add constraint Check_Past_Date Check (Appointment_Date < Cast(GetDate() As Date))


--Insertion of records into the tables

Insert into Patients (Insurance_Number, FullName, Address, Date_of_Birth, Telephone_Number,Email)
Values
('AC543325D', 'John Williams' , '32 Bronington Close Manchester M22 4ZQ ', '1990-06-13', '+44 7435 714106','Johnny123@gmail.com'),
('AD278649S', 'George Cooper' , '13 Quay St Manchester M3 3HN', '2004-08-19', '+44 6342 812764','Shelly456@gmail.com'),
('AF567836E', 'Mark Richardson' , '16 Bronington Close Manchester M22 4ZQ ', '1960-11-28', '+44 9435 604116','MRichard_5@gmail.com'),
('AR657195Z', 'Mark Taylor', '119 Manchester Rd Audenshaw Manchester M34 5PY', '1979-07-20', '+44 5438 872091', 'Mark.Taylor20@gmail.com'),
('BA649375Z','Maggie Williamson',' 392 Third Ave Trafford Park Manchester M17 1JE ','1999-08-01','+44 8435 693106','Maggie_Cool@gmail.com'),
('BC760923H', 'Amy Wareham' , '1 Piccadilly, Manchester M1 1RG', '1993-05-09', '+44 6299 450112','Wareham.Amy32@gmail.com'),
('BH831945K', 'Rohit Sharma' , '25 Wilmslow Rd, Rusholme, Manchester M14 5TB ', '1983-10-17', '+44 7943 385109','Rohit_S2@gmail.com'),
('BM453927N', 'Leonard Hofstader', '57 Portland St Manchester M1 3HP', '2001-01-31', '+44 7939 347468', ' LeoBoy_09@gmail.com'),
('FA376485G', 'Martha Walker' , '50 Spring Gardens Manchester M2 1EN', '1961-12-30', '+44 7634 923851','Martha_Walker@gmail.com'),
('TH363741F','Debbie Parker','65 Great Stone Rd Old Trafford Manchester M32 8GR','1973-04-23','+44 7932 614506','Debbie_08@gmail.com')



insert into Department
values
('Cardiology'), ('General Surgery'), ('Gynaecology'), ('Oncology'), ('Neurology'), 
('Gastroenterology'),('ENT'),('Orthopaedics'),('Rheumatology'),('Radiology')


insert into Doctors
values
('Dr Anam Haque', 'Oncologist', 'Available', '4'),('Dr Ishaq Chandio', 'ENT', 'Available','7'),
('Dr Hafiz Mahmood', 'Rheumatologist','Available','9'),('Dr Ma Zhao', 'Gastroenterologist', 'Not Available', '6'),
('Dr Sarah Taylor', 'Gynaecologist','Available','3'), ('Dr Alan Wilkins', 'Radiation Oncologist', 'Available', '4'),
('Dr Jack Shepherd', 'Orthopedic Surgeon', 'Available','8'), ('Dr John Murray', 'Vascular Surgeon', 'Not Available','2'),
('Dr Naveen Mujahid', 'Cardiologist', 'Available', '1')



select * from Appointments.Appointments
insert into Appointments.Appointments (Appointment_ID, Appointment_Date, Appointment_Time, status, Doctor_ID,Insurance_Number,Department_ID)
values
('1', '2024-04-26', '11:30:00','Pending','1','BH831945K', '4'),
('2', '2024-05-01', '10:00:00','Pending','7','BC760923H', '8'),
('3', '2024-04-23', '14:30:00','Pending','9','AC543325D', '1'),
('4', '2024-04-30','10:00:00','Pending','1','AD278649S','4'),
('5', '2024-05-11','12:00:00','Pending','1','FA376485G','4'),
('6','2024-05-15','17:00:00','Pending','5','TH363741F','3'),
('7','2024-05-26','16:00:00','Pending','7','AC543325D','8'),
('8','2024-05-15','18:00:00','Pending','5','AF567836E','3')




insert into Past_Appointments
values
( '2024-01-19', '13:00:00', 'Completed', '1', 'FA376485G', '4', 'Satisfactory Consultation'),
( '2024-01-10','10:00:00','Completed','5','TH363741F','3','Satisfactory Examination by the doctor'),
('2023-12-20','15:00:00', 'Completed','1','AD278649S','4','Not Satisfactory'),
('2023-12-05', '11:00:00', 'Completed', '4', 'AR657195Z','6','Too much waiting'),
('2023-12-03','14:30:00','Completed','4','BA649375Z','6', 'Satisfactory'),
('2023-11-29','17:00:00','Completed','1','BM453927N','4','Satisified'),
('2023-11-20','13:30:00','Completed','9','AC543325D','1','Good Check up but too much waiting'),
('2024-02-20','13:00:00','Completed','3','BM453927N','9','Good Examination. Satisfied')


insert into Medical_Records
values
('1','Cancer','Anastrozole','None','AD278649S','3'),
('2','Pregnant','Aspirin','None','TH363741F','2'),
('3','Cancer','Atezolizumab','Dust Allergy','FA376485G','1'),
('4', 'Arrhythmia','Flecainide','None','AC543325D','7'),
('5','HSP','Deltacortril','Rash','BM453927N','6'),
('5', 'HSP' , 'Predinisolone', 'Itch','BM453927N', '8'),
('6','IBS','Dicyclomine','None','BA649375Z','5'),
('7','Lactose Intolerance','Lactaid','Peanut Allergy','AR657195Z','4')


insert into PatientsDoctors
values
('BH831945K',1),('BC760923H',7),('AF567836E',5),
('AC543325D',9),('AC543325D',7),('AD278649S',1),('AD278649S',2),('AR657195Z',4),
('BA649375Z',4),('BM453927N',1),('BM453927N',3),('FA376485G',1),('TH363741F',5)

----------------------------------------------------------------------------Part 2--------------------------------------------------------------------------------------------

-- 2nd Query

Alter Table Appointments.Appointments
Add constraint Check_Date Check (Appointment_Date > Cast(GetDate() As Date))


--3rd Query

select * from Patients p inner join Medical_Records m
on p.Insurance_Number = m.Insurance_Number where m.Diagnoses = 'Cancer' and 
datediff (year,p.Date_of_Birth,CAST (GETDATE() as Date)) > 40




--4th Query (part a)

Create Procedure MedicineName @MatchingString nvarchar(10)
AS
select p.Appointment_Date,p.Past_Appointment_ID,m.Medicines,m.Insurance_Number from
Appointments.Past_Appointments p inner join Medical_Records m on
p.Past_Appointment_ID = m.Past_Appointment_ID
where Medicines like @MatchingString + '%' or Medicines like '%' +@MatchingString
or Medicines like '%' + @MatchingString + '%'
order by Appointment_Date desc
Go

EXEC MedicineName @MatchingString = 'zol'




--4th Query (Part b) by Stored Prodedure

Create Procedure DiagnosesAllergies
AS
select  distinct m.Diagnoses, m.Allergies,m.Insurance_Number from 
Appointments.Appointments a inner join  Medical_Records m on a. Insurance_Number = m.Insurance_Number 
where Appointment_Date = CAST (GETDATE() AS DATE)
Go

EXEC DiagnosesAllergies;


--4th Query (part b) by User Defined Function

Create Function PatientDiagnosesAndAllergies (@Inumber as nvarchar(9))
Returns Table as 
Return
(select  distinct m.Diagnoses, m.Allergies from 
Appointments.Appointments a inner join  Medical_Records m on a. Insurance_Number = m.Insurance_Number 
where m.Insurance_Number = @Inumber and Appointment_Date = CAST (GETDATE() AS DATE));

select * from PatientDiagnosesAndAllergies('BM453927N')


--4th Query (part c)

Create Procedure UpdateDoctors  @Doc_ID int, @Serial int , @Update nvarchar(40)
AS
BEGIN TRANSACTION
BEGIN TRY
IF @Serial = 1
UPDATE Doctors 
SET  Speciality = @Update
where Doctor_ID = @Doc_ID

ELSE IF @Serial = 2
UPDATE Doctors
SET Availability = @Update
where Doctor_ID = @Doc_ID

ELSE IF @Serial = 3
Update Doctors
SET Department_ID = CAST( @Update as int)
where Doctor_ID = @Doc_ID

ELSE IF
@Serial not in(1,2,3)
print('ERROR ENTER CORRECT INPUT FOR @Serial')



COMMIT TRANSACTION
END TRY
BEGIN CATCH
       IF @@TRANCOUNT > 0
	   ROLLBACK TRANSACTION
	   DECLARE @ERRORMSG NVARCHAR (4000), @ERRORSEV INT
	   SELECT @ERRORMSG = ERROR_MESSAGE(),
	   @ERRORSEV = ERROR_SEVERITY()
       RAISERROR(@ERRORMSG, @ERRORSEV, 1)
END CATCH;

EXEC UpdateDoctors @Doc_ID = 8, @Serial = 2, @Update = 'Available'


--4th Query (part d)
GO
Create Trigger Deleted_Appointments
ON Appointments.Appointments
After Delete 
AS Begin
insert into Appointments.Past_Appointments(Appointment_Date,Appointment_Time,
status,Doctor_ID,Insurance_Number,Department_ID,Review)

select 
d.Appointment_Date,d.Appointment_Time,d.status,d.Doctor_ID,d.Insurance_Number,d.Department_ID,d.Review

from deleted d

End

Update Appointments.Appointments 
set status = 'Completed', Review = 'Satisfactory Consultation'
where Appointment_ID = 3
select * from Appointments.Appointments
Delete from Appointments.Appointments where status = 'Completed'
select * from Appointments.Past_Appointments


--5th Query

Create View [AppointmentDetails] AS
select d.Full_Name, d.Speciality,d.Doctor_ID,p.Appointment_Date, p.Appointment_Time, d.Department_ID, 
dp.Department_Name, p.Review from Appointments.Past_Appointments p  inner join Doctors d on p.Doctor_ID = d.Doctor_ID
inner join Department dp on dp.Department_ID = d.Doctor_ID
union 
select d.Full_Name,d.Speciality, d.Doctor_ID, a.Appointment_Date, a.Appointment_Time, d.Department_ID,
dp.Department_Name, a.Review from Appointments.Appointments a inner join Doctors d on a.Doctor_ID = d.Doctor_ID 
inner join Department dp on dp.Department_ID = d.Doctor_ID

select * from AppointmentDetails order by Doctor_ID asc, Appointment_Date asc

--6th Query

GO
Create Trigger Cancelled_Appointments
ON Appointments.Appointments
After Update 
AS Begin
Update Appointments.Appointments 
set status = 'Available'
where status = 'Cancelled'
print ('Inform the Patient Appointment need to be rebooked') 

End

update Appointments.Appointments
set status = 'Cancelled'
where Appointment_ID = 3


--7th Query

select count (*) as Completed from Appointments.Past_Appointments where Doctor_ID in
(select Doctor_ID from Doctors where Speciality = 'Gastroenterologist')


--Creating Schema for Database Security

Create Schema Appointments

GO

--Adding tables to the schema

ALTER SCHEMA Appointments Transfer dbo.Past_Appointments
ALTER SCHEMA  Appointments Transfer dbo.Appointments

--Creating Logins for Users 

CREATE LOGIN Senior_Hospital_Incharge
WITH PASSWORD = 'SALFORDUNI123'

CREATE LOGIN Junior_Hospital_Incharge
WITH PASSWORD = 'Hospital456'

--Creating Users 

CREATE USER Muhammad_Jazib
FOR LOGIN Senior_Hospital_Incharge
GO

CREATE USER Abdul_Manan
FOR LOGIN Junior_Hospital_Incharge
GO

--Creating Role for Users with similiar responsibilities

CREATE ROLE Incharges

--Adding Users to the Role created

ALTER ROLE Incharges ADD MEMBER Muhammad_Jazib
ALTER ROLE Incharges ADD MEMBER Abdul_Manan

--Granting Priveleges to the Role created

GRANT SELECT ON Patients to Incharges
GRANT INSERT ON Patients to Incharges
GRANT SELECT ON Schema :: Appointments to Incharges  


--Commands to switch to the Users created

Execute as User = 'Abdul_Manan'
Execute as User = 'Muhammad_Jazib'

--Revert command used to switch back from the User after testing

REVERT


-- Command to Backup Database to the location specified

Backup Database Hospital
To Disk = 'C:\Hospital_Backup\Hospital.bak'
WITH CHECKSUM

-- Command to check the backup can be restored

RESTORE  VERIFYONLY 
FROM DISK = 'C:\Hospital_Backup\Hospital.bak'
WITH CHECKSUM



select * from Patients
select * from Appointments.Past_Appointments
select * from Doctors
select * from Appointments.Appointments
select * from Medical_Records
select * from Department
select * from PatientsDoctors
