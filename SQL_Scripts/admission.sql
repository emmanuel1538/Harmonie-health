-- =========================================== SECTION B: ADMISSION AND READMISSION ===================================================

-- B1: 30-Day Readmission RatE
WITH DischargeAdmissions AS (
    SELECT 
        patient_id,
        admission_date,
        discharge_date,
        -- Use LEAD to find the date of the patient's next admission
        LEAD(admission_date) OVER (
            PARTITION BY patient_id 
            ORDER BY admission_date
        ) AS next_admission_date
    FROM Admissions
    WHERE discharge_date IS NOT NULL -- Only look at completed stays
)
SELECT
    COUNT(*) AS total_discharges,
    SUM(CASE 
            WHEN DATEDIFF(DAY, discharge_date, next_admission_date) <= 30 
            THEN 1 
            ELSE 0 
        END) AS readmissions_within_30d,
    ROUND(
        SUM(CASE 
                WHEN DATEDIFF(DAY, discharge_date, next_admission_date) <= 30 
                THEN 1 
                ELSE 0 
            END) * 100.0 / COUNT(*),
        2
    ) AS readmission_rate_percentage
FROM DischargeAdmissions;





-- B2: Readmission Rate by Department
WITH DischargeAdmissions AS (
    SELECT 
        patient_id,
        department, -- We need this for the final grouping!
        admission_date,
        discharge_date,
        -- Use LEAD to find the date of the patient's next admission
        LEAD(admission_date) OVER (
            PARTITION BY patient_id 
            ORDER BY admission_date
        ) AS next_admission_date
    FROM Admissions
    WHERE discharge_date IS NOT NULL
)
SELECT
    department,
    COUNT(*) AS total_discharges,
    SUM(CASE 
            WHEN DATEDIFF(DAY, discharge_date, next_admission_date) <= 30 
            THEN 1 
            ELSE 0 
        END) AS readmissions_within_30d,
    ROUND(
        SUM(CASE 
                WHEN DATEDIFF(DAY, discharge_date, next_admission_date) <= 30 
                THEN 1 
                ELSE 0 
            END) * 100.0 / COUNT(*),
        2
    ) AS readmission_rate_percentage
FROM DischargeAdmissions
GROUP BY department
ORDER BY readmission_rate_percentage DESC;
