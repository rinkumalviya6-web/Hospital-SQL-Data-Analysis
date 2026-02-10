Create Table Hospital(
	Hospital_Name VARCHAR(100),
    Location VARCHAR (100),
	Department VARCHAR (100),
	Doctors_Count INT,
	Patients_Count INT,
	Admission DATE,
	Discharge DATE,
	Medical_Expenses NUMERIC(10,2)
)


-- Update the CSV file path as per your local system before running COPY command
Copy Hospital(Hospital_name,Location,Department,Doctors_Count,Patients_Count,Admission,Discharge,Medical_Expenses)
From 'C:\Rinku\SQL\Assigment sql\Hospital_Data.csv'
CSV header;

SELECT * FROM HOSPITAL;
--1)find the total number of patients across all hospitals. 

Select sum(patients_count) As Total_Patients
From Hospital;

--2)Retrieve the average count of doctors available in each hospital.
Select hospital_name, Avg(doctors_count) As Avg_Doctors
From hospital 
Group by hospital_name;

--3)Find the top 3 hospital departments that have the highest number of patients. 
Select department, patients_count from hospital
group by department, patients_count
order by patients_count DESC
limit 3 ;

--4)Identify the hospital that recorded the highest medical expenses.
select hospital_name ,medical_expenses
from hospital
group by hospital_name, medical_expenses
order by medical_expenses Desc
LIMIt 1;

--5)Calculate the average medical expenses per day for each hospital
select 
    hospital_name,
    AVG(daily_expenses) AS avg_exp_per_day
from (
    select 
        hospital_name, Admission,
        SUM(medical_expenses) AS daily_expenses
    from hospital
    grouP by hospital_name, Admission
)
GROUP BY hospital_name;

--6)Find the patient with the longest stay by calculating the difference between Discharge Date and Admission Date. 
Select hospital_name, 
	   admission, 
	   discharge,
	   (discharge-admission) as Stay_days
from hospital
order by stay_days DESC
LIMIT 1;

--7)Count the total number of patients treated in each city. 
select Distinct location, sum(patients_count) As total_patients
from hospital
group by location;

--8)Calculate the average number of days patients spend in each department. 
Select department, 
	   AVG(discharge-admission) as avg_day_spend
from hospital
group by department
order by avg_day_spend DESC;

--9)Find the department with the least number of patients.
select department, sum(patients_count) as total_patients
from hospital
group by department
order by Total_Patients
Limit 1;

--10)Group the data by month and calculate the total medical expenses for each month.
Select
	To_Char(admission,'yyyy-mm')As Month,
	Sum(medical_expenses) As Total_expenses
from Hospital
group by month
order by month;






