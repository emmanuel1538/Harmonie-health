# 🏥 Harmonie Health: Operational Efficiency Analysis

## 📖 Project Overview
This project presents a comprehensive *SQL data analysis* for Harmonie Medical Center, a leading healthcare institution. Facing operational pressures, Harmonie needed data-driven insights to improve patient care, reduce readmissions, and optimize staff responsiveness. This analysis transforms raw Electronic Health Record (EHR) data into actionable business intelligence, providing a framework for proactive intervention and strategic decision-making.



## 🎯 Business Challenge
Harmonie Health identified five critical areas for improvement:
1.  *Emergency Room Overload* with no real-time bottleneck insights.
2.  *Rising 30-day readmission rates* with unclear causes.
3.  *Delayed doctor-patient engagement* during peak hours.
4.  *Variable recovery outcomes* across departments.
5.  *Absence of real-time alerts* for at-risk patients.

## 🚀 Key Insights & Impact
-   *🚑 Critical Patient Safety Dashboard:* Identified *111 patients* with abnormal vitals in 48 hours, including *26 with 3+ co-occurring issues*, enabling immediate clinical intervention to prevent code blues and ICU transfers.
-   *📉 Readmission Crisis Uncovered:* Calculated the 30-day readmission rate at 56.8%, a catastrophic figure indicating that 1 in 2 patients returns within a month. Pinpointed *General Practice (59.22%)* and *Cardiology (58.59%)* as the highest-risk departments, providing a clear target for initiatives that could improve care.
-   *⏱ Operational Bottlenecks Identified:* While departmental response times were strong (7-8 min), analysis revealed *133 doctors* (18% of staff) with slow response times, uncovering a training and workflow opportunity. Further analysis showed peak demand at *6:00 AM*, revealing a significant misalignment between shift schedules and clinical need.
-   *📊 Strategic Resource Allocation:* Quantified departmental admission volumes, revealing *General Practice* and *Emergency* handle the highest patient load, directly linking high workload to poor outcomes and justifying requests for increased staffing.
-   *✅ Positive Outcome Validation:* Analysis of post-ICU mortality revealed *0 patients* were discharged and later readmitted as deceased, validating the effectiveness of the ICU's end-of-life care and discharge planning protocols.
## 🛠 Tech Stack & Tools
- *Database:* Microsoft SQL Server
- *Tools:* SQL Server Management Studio (SSMS)
- *Key SQL Techniques:*
    -   **Window Functions (LEAD())** for accurate time-between-readmission calculation.
    -   *Common Table Expressions (CTEs)* for complex, multi-step data preparation.
    -   **Conditional Aggregation (CASE statements with SUM/COUNT)** for clinical KPI calculation.
    -   *HAVING Clauses* to filter for statistically significant performance data.
    -   *Date/Time Functions* for trend analysis over time and by hour of day.
- *Methodology:* Exploratory Data Analysis (EDA)



## 🔍 How to Navigate This Project
1.  *For a Quick Summary:* Read the *Key Insights* above and the [Detailed Analysis](./Analysis/detailed_analysis.md).
2.  *For the Technical Deep Dive:* Explore the [SQL Scripts](./SQL_Scripts/) to see how each query was built.


## 💡 Conclusion
This project demonstrates the power of SQL to solve real-world business problems. By moving from reactive reporting to proactive analytics, Harmonie Health can now prioritize patient safety, optimize resource allocation, and ultimately deliver higher quality, more efficient care. The solutions provided are not just queries but a foundational framework for a data-informed clinical operation.
