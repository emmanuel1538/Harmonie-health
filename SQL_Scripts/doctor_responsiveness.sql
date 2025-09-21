-- ======================================== SECTION C: DOCTOR RESPONSIVENESS ===========================================================
-- C1: AVERAGE DOCTOR'S RESPONSE TIME ACROSS DEPARTMENTS OVER THE PAST SEVEN DAYS
SELECT
	a.department,
    COUNT(*) AS total_visits,
    ROUND(AVG(response_time), 2) AS avg_response_time_minutes
FROM doctor_visits dv
inner join admissions a on dv.patient_id = a.patient_id
WHERE visit_time >= '2025-05-13'
  AND visit_time <= '2025-05-20'
group by department;


-- C2:  Doctors with avg response time > 10 minutes in past 14 days
SELECT
    doctor_id,
    COUNT(*) AS total_visits,
    ROUND(AVG(response_time), 2) AS avg_response_time_minutes
FROM doctor_visits
WHERE visit_time >= '2025-05-07'
  AND visit_time <= '2025-05-20'
  AND response_time IS NOT NULL
GROUP BY doctor_id
HAVING AVG(response_time) > 10
and COUNT(*) >2
ORDER BY avg_response_time_minutes DESC;
