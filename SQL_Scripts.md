-- ========================= SECTION A: PATIENTS RISK AND VITALS =========================

-- A1: Patients with abnormal vital signs in the last 48 hours 



    SELECT
    p.patient_id,
    p.full_name,
    v.[timestamp] AS reading_time,
    v.heart_rate,
    v.systolic_bp,
    v.diastolic_bp,
    v.oxygen_saturation,
    v.body_temperature,
    
    TRIM(
        CONCAT(
            CASE WHEN v.heart_rate < 60 THEN 'Low Heart Rate; ' 
                 WHEN v.heart_rate > 100 THEN 'High Heart Rate; ' ELSE '' END,
            CASE WHEN v.systolic_bp > 140 THEN 'High Systolic BP; ' ELSE '' END,
            CASE WHEN v.diastolic_bp > 90 THEN 'High Diastolic BP; ' ELSE '' END,
            CASE WHEN v.oxygen_saturation < 95 THEN 'Low Oxygen Saturation; ' ELSE '' END,
            CASE WHEN v.body_temperature > 38.0 THEN 'Fever; ' ELSE '' END
        )
    ) AS AbnormaL_Vital,

    
    -- count of Abnormal vitals
    CASE WHEN (v.heart_rate < 60 OR v.heart_rate > 100) THEN 1 ELSE 0 END +
    CASE WHEN (v.systolic_bp > 140) THEN 1 ELSE 0 END +
    CASE WHEN (v.diastolic_bp > 90) THEN 1 ELSE 0 END +
    CASE WHEN (v.oxygen_saturation < 95) THEN 1 ELSE 0 END +
    CASE WHEN (v.body_temperature > 38.0) THEN 1 ELSE 0 END 
        AS number_of_abnormalities

    FROM Vitals v
    INNER JOIN Patients p ON v.patient_id = p.patient_id
    WHERE
    v.[timestamp] > DATEADD(HOUR, -48, '2025-05-20 23:59:59')
    AND (
        v.heart_rate < 60 OR v.heart_rate > 100
        OR v.systolic_bp > 140
        OR v.diastolic_bp > 90
        OR v.oxygen_saturation < 95
        OR v.body_temperature > 38.0
    )
    -- Show major crises first, then by number of abnormalities, then by most recent
    ORDER BY number_of_abnormalities DESC, v.[timestamp] DESC;


