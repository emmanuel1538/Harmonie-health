--============================================= SECTION E: PATIENT OUTCOMES ================================================================
-- E1: PATIENTS RECORDED WITH ICU STATUS, WHICH SUBSEQUENT ADMISSION RESULTS IN DEATH
WITH ICUAdmissions AS (
    SELECT
        patient_id,
        admission_date AS icu_admit_date,
        discharge_date AS icu_discharge_date
    FROM Admissions
    WHERE outcome = 'ICU'
      AND discharge_date IS NOT NULL -- total patients with ICU stay and their discharge date
),
SubsequentDeaths AS (
    -- Finding death admissions that occurred after ICU discharge
    SELECT
        i.patient_id,
        MIN(d.admission_date) AS death_admission_date
    FROM ICUAdmissions i
    INNER JOIN Admissions d
        ON i.patient_id = d.patient_id
    WHERE d.outcome = 'Deceased'
      AND d.admission_date > i.icu_discharge_date
    GROUP BY i.patient_id
)
-- Step 3: Count of patients that died after their ICU discharge
SELECT COUNT(DISTINCT patient_id) AS ICU_deaths
FROM SubsequentDeaths;

-- E2: DISTRIBUTION OF PATIENTS OUTCOME BY DEPARTMENTS
SELECT
    department,
    outcome,
    COUNT(*) AS patient_count
FROM Admissions
GROUP BY department, outcome
ORDER BY department, outcome;
