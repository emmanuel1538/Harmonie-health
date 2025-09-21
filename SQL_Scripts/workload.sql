-- ========================================= SECTION D: WORKLOAD AND CAPACITY ==============================================================
-- D1: COUNT OF ADMISSIONS BY DEPARTMENT IN A MONTH
SELECT
    FORMAT(admission_date, 'yyyy-MM') AS admission_month,
    department,
    COUNT(*) AS total_admissions
FROM Admissions
WHERE admission_date >= '2025-03-01'  -- last 3 months (adjust based on dataset coverage)
  AND admission_date <  '2025-06-01'
GROUP BY FORMAT(admission_date, 'yyyy-MM'), department
ORDER BY admission_month, department;

-- D2: COMMON HOURS OF DOCTOR VISIT
SELECT
    DATEPART(HOUR, visit_time) AS visit_hour,
    COUNT(*) AS total_visits
FROM doctor_visits
GROUP BY DATEPART(HOUR, visit_time)
ORDER BY total_visits DESC;
