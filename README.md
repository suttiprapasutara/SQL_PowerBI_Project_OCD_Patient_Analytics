# OCD Patient Analytics

The OCD Patient Analytics project aims to provide comprehensive insights into the demographic and clinical profiles of individuals diagnosed with Obsessive-Compulsive Disorder (OCD). By leveraging SQL and PowerBI, this project analyzes a dataset of 1500 individuals, exploring various aspects such as demographics, clinical information, and symptom severity.

🔍 SQL queries? Check them out here: https://github.com/suttiprapasutara/SQL_PowerBI_Project_OCD_Patient_Analytics/blob/main/ocd_patients.sql

# Background
Motivated by the need to better understand OCD and its impact on different population groups, this project utilizes a rich dataset to answer critical questions about the disorder. The insights gained can help researchers, clinicians, and mental health professionals to improve treatment approaches and patient outcomes.

### The questions I wanted to answer through my SQL queries were:

1. Count & Percent of Female vs Male that have OCD & Average Obsession Score by Gender
2. Count of Patients by Ethnicity and their respective Average Obsession Score
3. Number of people diagnosed with OCD Month-over-Month (MoM)
4. What is the most common Obsession Type (Count) & its respective Average Obsession Score
5. What is the most common Compulsion Type (Count) & its respective Average Compulsion Score

# Tools I Used
- **SQL:** The backbone of my analysis, enabling me to query the database and extract critical insights.
- **PowerBI:** For data visualization and creating interactive dashboards.
- **Docker:** For containerizing the SQL database.
- **Azure Data Studio:** My preferred tool for database management and executing SQL queries.
- **GitHub:** Crucial for version control and sharing SQL scripts and analyses, ensuring collaboration and project tracking.

# The Analysis
### 1. Count & Percent of Female vs Male that have OCD & Average Obsession Score by Gender
Aims to determine the distribution of OCD patients by gender. By calculating the count and percentage of females versus males with OCD, along with the average obsession score for each gender, we can identify potential gender-based differences in OCD prevalence and symptom severity.

```sql
WITH data AS (
SELECT 
    Gender,
    COUNT(Patient_ID) AS patient_count,
    AVG(Y_BOCS_Score_Obsessions) AS avg_obs_score

FROM PortfolioProject..ocd_patient_dataset

GROUP BY 
    Gender

--ORDER BY patient_count
)

SELECT 
    SUM(CASE WHEN Gender = 'Female' THEN patient_count ELSE 0 END) AS female_count,
    SUM(CASE WHEN Gender = 'Male' THEN patient_count ELSE 0 END) AS male_count,
    
    ROUND(
    SUM(CASE WHEN Gender = 'Female' THEN patient_count ELSE 0 END) * 1.0 /
    (SUM(CASE WHEN Gender = 'Female' THEN patient_count ELSE 0 END) +
    SUM(CASE WHEN Gender = 'Male' THEN patient_count ELSE 0 END)) * 100, 2) AS percent_female,
    
    ROUND(
    SUM(CASE WHEN Gender = 'Male' THEN patient_count ELSE 0 END) * 1.0 /
    (SUM(CASE WHEN Gender = 'Female' THEN patient_count ELSE 0 END) +
    SUM(CASE WHEN Gender = 'Male' THEN patient_count ELSE 0 END)) * 100, 2) AS percent_male

FROM data;
```

### Key Trends

**Balanced Gender Distribution:** The dataset shows a nearly equal distribution of OCD patients by gender, with 747 females (49.8%) and 753 males (50.2%). This indicates that OCD affects males and females almost equally in this sample population.

### Summary
