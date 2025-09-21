# Harmonie Health: Detailed Analysis

## Executive Summary
This document provides a comprehensive breakdown of the data analysis conducted to address operational challenges at Harmonie Medical Center. For each business question, we outline the objective, approach, key findings, and actionable recommendations derived from the SQL analysis of EHR data.

---

## A. Patient Risk & Vitals

### *A1. Patients with Abnormal Vital Signs in the Last 48 Hours*

-   *Objective:* To proactively identify patients at immediate risk of clinical deterioration for urgent intervention.
-   *Approach:* Queried the Vitals table for records from the last 48 hours. Joined with the Patients table for identification. Applied clinical thresholds to define abnormality (Heart_rate < 60 or > 100, oxygen_saturation < 95, body_Temp > 38°C, BP outside 140/90 range).
-   *Key Finding:* The analysis identified a critically high number of patients at risk: *111 unique patients* with abnormal readings within the last 48 hours. The severity of risk is starkly revealed when grouped by the number of concurrent abnormalities:
    *   *4 patients* with *4* abnormal vitals *(Highest Acuity)*
    *   *22 patients* with *3* abnormal vitals *(Very High Acuity)*
    *   *41 patients* with *2* abnormal vitals *(High Acuity)*
    *   *44 patients* with *1* abnormal vital *(Elevated Risk)*
-   *Insight:* This list acts as a real-time patient safety dashboard, highlighting individuals requiring immediate clinical review to prevent adverse events like code blues or ICU transfers.
  The large number of patients with multiple abnormalities (67 patients with 2 or more) indicates widespread clinical instability. These patients, especially the 26 with 3 or 4 abnormalities, are on the verge of severe deterioration and require immediate intervention. This suggests possible gaps in routine monitoring, early warning protocols, or staffing levels.
-   *Recommendation:*
    -   *Immediate Action:* Implement this query as a live dashboard for the Rapid Response Team and charge nurses, prioritized by the number of abnormal vitals.
    -   *Automation:* Schedule this query to run every 30 minutes, with automated alerts for new high-risk patients.
    -   *Protocol Development:* Establish a clear clinical protocol mandating vitals re-assessment and physician notification within 15 minutes for any patient on this list.

### *A2. Top 10 Patients with Frequent Abnormalities over the current month*

-   *Objective:* To identify patients with the most frequently unstable vital signs, indicating poorly managed chronic conditions that require urgent review of their long-term care plans.
-   *Approach:* Aggregated abnormal vital records from the last 30 days. Counted occurrences per patient and sorted to find the top 10.
-   *Key Finding:* Analysis reveals a core group of patients with persistently unstable vitals. *Pamela (ID: P7653)* leads with *13 abnormal readings* in the period, followed by *Victoria (P6992)* and *Mary (P9866)* with *10 each. The top 10 patients all have **8 or more* abnormal readings, indicating severe and ongoing health management issues.
-   *Insight:* These individuals are likely struggling with chronic conditions such as *COPD, Heart Failure, or uncontrolled diabetes*. The high frequency of abnormalities shows their current treatment plans are ineffective. They are caught in a cycle of clinical deterioration, consuming a disproportionate amount of hospital resources and are at extreme risk of adverse events and readmission.
-   *Recommendation:*
    -   *Chronic Care Management:* Flag these top 10 patients for a comprehensive review by a multidisciplinary team (primary physician, specialist, case manager) to optimize their treatment plans.
    -   *Preventive Investment:* Consider enrolling these high-cost, high-risk patients in a remote patient monitoring (RPM) program to better manage their conditions at home and prevent emergency visits.
    -    *Root Cause Analysis:* For each patient, determine the primary driver of their instability (e.g., is Pamela's 13 abnormalities primarily due to low SpO₂, suggesting a respiratory issue?).

---

## B. Admissions & Readmissions

### *B1. Overall 30-Day Readmission Rate*

-   *Objective:* To calculate the hospital-wide rate of patients readmitted within 30 days of discharge.
  
-   *Approach:* Utilized a LEAD() window function to find the next admission date for each discharged patient. Calculated the time between discharge and next admission, then computed the proportion where this was ≤ 30 days.
-   *Key Finding:* The calculated overall 30-day readmission rate is **56.8%. This figure is significantly higher than typical industry benchmarks (e.g., ~15% in the US), indicating a potential severe operational crisis or a unique characteristic of the provided dataset.
-   *Insight:* If validated, this rate would mean over half of all discharged patients return within a month. This signifies catastrophic failures in discharge processes, treatment effectiveness, and post-discharge support, leading to exorbitant costs and dangerously poor patient outcomes.
-   *Recommendation:*
    -   **Immediate Validation:** The first step must be to validate this metric against the hospital's internal reporting to confirm its accuracy.
    -   **Crisis Response:** If confirmed, this must be treated as the organization's top priority. Immediate actions should include a moratorium on non-standard discharge processes and a real-time audit of every discharge to identify the exact point of failure (e.g., missing prescriptions, lack of follow-up appointments).
    -   **Invest in Transitional Care:** Immediately allocate resources to build a robust transitional care program with nurses dedicated to calling patients within 24 and 72 hours of discharge to prevent crises.

### *B2. Readmission Rates by Department*

-   *Objective:* To identify which clinical departments have the highest readmission rates, enabling targeted interventions.
-   *Approach:* Applied the same logic as B1, but grouped the results by the department of the initial admission.
-   *Key Finding:* The readmission crisis is pervasive across all departments, but its severity varies. Critically, **General Practice (59.22%)** has the highest rate, followed by Endocrinology (58.73%) and Cardiology (58.59%).
-   *Insight:* The leading rate in General Practice is the most significant finding. It suggests fundamental failures in treating common conditions (e.g., infections, COPD exacerbations, diabetes management) are sending patients right back. This points to a breakdown in core medical competency, not just specialist care.
-   *Recommendation:*
    -   **Prioritize General Practice:** Launch an intensive "Common Conditions Task Force" to develop and enforce evidence-based treatment pathways for the top 5 reasons for readmission in this department.
    -   **Chronic Disease Specialization:** For Endocrinology and Cardiology, implement specialized discharge pathways (e.g., guaranteed educator consultation, 7-day follow-ups).
    -   **Enterprise-Wide Standardization:** Mandate a hard-stop, standardized discharge checklist (medication reconciliation, appointments, patient education) across all departments, with strict accountability.

---

## C. Doctor Responsiveness

### *C1. Average Response Time by Department*

-   *Objective:* To measure and compare doctor responsiveness across different departments to identify operational bottlenecks.
-   *Approach:* Joined Doctors_Visits with Admissions to associate each visit with a department. Filtered for the last 7 days and calculated the average response_time per department.
-   *Key Finding:* *Response times are consistently strong and uniform across all departments.* The average response time ranges from *7 to 8 minutes*, with no single department being a significant outlier. The Emergency Department's average of 8 minutes is particularly notable given the high-pressure environment.
-   *Insight:*This is a major *operational strength* for Harmonie Health. It indicates that the current staffing levels, triage systems, and workflow processes for physician deployment are effectively meeting patient needs across the facility. The data suggests that doctor responsiveness is *not a contributing factor* to the other critical issues identified, such as the high readmission rate.
-   *Recommendation:*
    *   *Maintain & Recognize:* This is a performance metric to be celebrated and maintained. Share these positive findings with clinical department heads and staff to reinforce effective practices.


### *C2. Doctors with Slow Response Times*

-   *Objective:* To identify individual clinicians with consistently slow response times.
-   *Approach:* Analyzed Doctors_Visits from the past 14 days (May 7-20, 2025). To ensure statistical significance and fairness, only included doctors with *more than 2 visits* in that period. Calculated the average response_time for each and filtered for averages greater than 10 minutes.
-   *Key Finding:* There are *5 doctors* with a consistent pattern of slow responsiveness. The slowest average response time was *12 minutes* (Dr. D914).
-   *Insight:*This is a highly manageable and actionable list. The performance of these 5 individuals is dragging down departmental averages. The reasons are now possible to diagnose:
    *   *Workflow Inefficiency:* These doctors may lack proficiency with the EHR system or have inefficient patient management habits.
    *   *Case Complexity:* They might be consistently assigned to more complex cases that inherently require more time.
    *   *Need for Support:* They may require better support from their teams or additional training.
-   *Recommendation:*
    -   *Supportive Review:* Department heads should confidentially review this data with the identified doctors to understand the challenges they face and offer solutions (e.g., additional support staff, workflow training).
    -   *Case Mix Review:* Analyze if slower doctors are consistently assigned more complex or time-consuming patients.

---

## E. Patient Outcomes

### *E1. ICU Patients Subsequently Deceased*

-   *Objective:* To understand the long-term outcomes of critically ill patients who required ICU care.
-   *Approach:* Identified patients with an ICU admission. Then checked for a subsequent admission after their ICU discharge where the outcome was 'Deceased'.
-   *Key Finding:* The analysis returned *0 patients* who were discharged from the ICU and later readmitted before passing away.
-   *Insight:*This finding suggests two possible scenarios:
    1.  *Positive Interpretation:* Patients discharged from ICU care at Harmonie Health are sufficiently stabilized and provided with adequate palliative or chronic care support, preventing readmission for terminal decline.
    2.  *Data Interpretation:* The result may be influenced by data structure. The 'Deceased' outcome likely marks the admission during which the patient passed away. Therefore, patients who die during their ICU stay are marked there, and those who are discharged to hospice or die at home may not be readmitted, thus not creating a separate 'Deceased' admission record in the database.
-   *Recommendation:*
    *   *Verify Data Logic:* Confirm with clinical teams how patient mortality is recorded in the EHR. Does a discharge to hospice generate a new admission? This will clarify if the query is measuring the intended outcome.
    *   *Alternative Metric:* To better assess end-of-life care, consider analyzing the *mortality rate *during ICU admissions** or the rate of *palliative care consultations for ICU patients* as more direct and reliably measured metrics.
    *   *Maintain Practices:* If the positive interpretation is accurate, ensure the current protocols for post-ICU discharge planning and palliative care integration are maintained and shared as best practices.

### *E2. Outcome Distribution by Department*

-   *Objective:* To provide a high-level overview of patient outcomes by department for quality assessment.
-   *Approach:* Grouped completed admissions by department and outcome, counting the occurrences and calculating percentages.
-   *Key Finding:*  The distribution reveals critical insights into departmental performance and patient populations:
    *   *Mortality:* The *Emergency Department* has the highest mortality rate (~29%), which is expected given its role in receiving critical, unstable patients. All other departments have a remarkably similar mortality rate (~24%).
    *   *ICU Admissions:* The *General Practice* department has the highest rate of ICU transfers (~29%), suggesting they are admitting patients who quickly deteriorate or are initially mis-triaged to a lower-acuity unit.
    *   *Readmissions:* The *General Practice* and *Cardiology* departments are tied for the highest readmission rate (~27%), confirming the severe chronic care and discharge planning gaps identified in analysis B2.
    *   *Recoveries:* The *Pulmonology* department has the highest rate of successful recoveries (~32%), indicating effective treatment protocols for their specific patient population.
-   *Insight:*  This data confirms that *General Practice is the most critical department requiring intervention.* It has a high rate of sending patients to the ICU and a high rate of readmissions, indicating failures at both the initial treatment and discharge planning stages. The high mortality rates across all departments are consistent with treating critically ill patients but should be monitored against national benchmarks.
-   *Recommendation:*
    1.  *Immediate General Practice Review:* Launch a top-to-bottom audit of the General Practice department's triage protocols, initial treatment plans, and discharge procedures. Their high ICU and readmission rates indicate systemic issues.
    2.  *Benchmarking:* Compare these mortality and readmission rates against national averages to determine if they are within an expected range for similar institutions.

    3.  *Share Best Practices:* Investigate the protocols used by the *Pulmonology* department that lead to its higher recovery rate and assess if they can be applied to other departments.
