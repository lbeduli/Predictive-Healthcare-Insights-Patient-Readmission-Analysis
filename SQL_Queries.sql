CREATE DATABASE healthcare;
USE healthcare;
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10)
);


CREATE TABLE admissions (
    admission_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    admit_date DATE,
    discharge_date DATE,
    length_of_stay INT,
    num_lab_tests INT,
    total_cost DECIMAL(10,2),
    readmitted BOOLEAN,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);



INSERT INTO patients (name, age, gender) VALUES
('Amit Sharma', 45, 'Male'),
('Priya Verma', 60, 'Female'),
('Ravi Kumar', 38, 'Male'),
('Neha Singh', 72, 'Female'),
('Arjun Mehta', 50, 'Male');

INSERT INTO admissions (patient_id, admit_date, discharge_date, length_of_stay, num_lab_tests, total_cost, readmitted)
VALUES
(1, '2024-05-01', '2024-05-07', 6, 15, 50000, TRUE),
(2, '2024-05-03', '2024-05-10', 7, 20, 65000, FALSE),
(3, '2024-05-05', '2024-05-08', 3, 10, 30000, TRUE),
(4, '2024-05-06', '2024-05-14', 8, 18, 72000, FALSE),
(5, '2024-05-07', '2024-05-09', 2, 5, 20000, TRUE);


--  Queries 
-- Average Length of Stay per Patient

Select patient_id as Patients, Round(Avg(length_of_stay),2) as Avg_stay
from admissions
Group by patients
Order by Avg_stay;


-- Readmission Rate
SELECT 
    COUNT(*) AS total_patients,
    SUM(readmitted) AS total_readmitted,
    ROUND(SUM(readmitted) * 100.0 / COUNT(*), 2) AS Readmission_Rate
FROM admissions;


-- Cost Analysis
SELECT length_of_stay AS no_of_days_stayed,
       ROUND(SUM(total_cost), 2) AS total_cost_analysis
FROM admissions
GROUP BY length_of_stay
ORDER BY total_cost_analysis DESC;



-- Gender-wise Readmission Rate
SELECT p.gender,
       COUNT(*) AS total_patients,
       SUM(a.readmitted) AS total_readmissions,
       ROUND(SUM(a.readmitted) * 100.0 / COUNT(*), 2) AS readmission_rate
FROM patients p
JOIN admissions a ON a.patient_id = p.patient_id
GROUP BY p.gender
ORDER BY total_readmissions DESC;




-- Top 5 Expensive Diagnoses
SELECT a.patient_id,
       p.name,
       ROUND(SUM(a.total_cost), 2) AS total_cost
FROM admissions a
JOIN patients p ON a.patient_id = p.patient_id
GROUP BY a.patient_id, p.name
ORDER BY total_cost DESC
LIMIT 5;



-- Patients with High Readmission Risk (Window Function)
WITH readmission_stats AS (
    SELECT a.patient_id,
           COUNT(*) AS total_admissions,
           SUM(a.readmitted) AS total_readmissions,
           ROUND(SUM(a.readmitted) * 100.0 / COUNT(*), 2) AS readmission_rate
    FROM admissions a
    GROUP BY a.patient_id
)
SELECT r.patient_id,
       p.name,
       r.total_admissions,
       r.total_readmissions,
       r.readmission_rate,
       RANK() OVER (ORDER BY r.readmission_rate DESC) AS risk_rank
FROM readmission_stats r
JOIN patients p ON r.patient_id = p.patient_id
ORDER BY r.risk_rank
LIMIT 10;



-- Monthly Admissions Trend
SELECT YEAR(admit_date) AS year,
       MONTH(admit_date) AS month,
       COUNT(*) AS total_admissions,
       ROUND(SUM(total_cost), 2) AS total_cost
FROM admissions
GROUP BY YEAR(admit_date), MONTH(admit_date)
ORDER BY year, month;

-- Age Group vs Average Length of Stay
SELECT CASE 
           WHEN p.age BETWEEN 0 AND 18 THEN '0-18'
           WHEN p.age BETWEEN 19 AND 35 THEN '19-35'
           WHEN p.age BETWEEN 36 AND 50 THEN '36-50'
           WHEN p.age BETWEEN 51 AND 65 THEN '51-65'
           ELSE '65+'
       END AS age_group,
       ROUND(AVG(a.length_of_stay), 2) AS avg_stay
FROM admissions a
JOIN patients p ON a.patient_id = p.patient_id
GROUP BY age_group
ORDER BY avg_stay DESC;
