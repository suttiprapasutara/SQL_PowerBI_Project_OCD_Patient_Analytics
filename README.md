# OCD Patient Analytics

The OCD Patient Analytics project aims to provide comprehensive insights into the demographic and clinical profiles of individuals diagnosed with Obsessive-Compulsive Disorder (OCD). By leveraging SQL and PowerBI, this project analyzes a dataset of 1500 individuals, exploring various aspects such as demographics, clinical information, and symptom severity.

🔍 SQL queries? Check them out here: https://github.com/suttiprapasutara/SQL_PowerBI_Project_OCD_Patient_Analytics/blob/main/ocd_patients.sql

📊 PowerBI Dashboard? Check it out here:

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

**1. Balanced Gender Distribution:** 
- The dataset shows a nearly equal distribution of OCD patients by gender, with 747 females (49.8%) and 753 males (50.2%). This indicates that OCD affects males and females almost equally in this sample population.

**2. Slight Male Prevalence:**
- There is a slightly higher percentage of male patients (50.2%) compared to female patients (49.8%). However, the difference is minimal, suggesting that gender is not a significant factor in the prevalence of OCD.

**3. Implications for Treatment:**
- The balanced gender distribution implies that treatment approaches and resources should be equally accessible and tailored to both males and females. Understanding any subtle differences in symptom manifestation or treatment response between genders may be beneficial for clinicians.

### Summary
The analysis reveals a nearly equal distribution of OCD patients between females and males, with 49.8% females and 50.2% males. This suggests that OCD does not significantly favor one gender over the other in terms of prevalence. The slight male predominance is minimal, indicating that both genders are similarly affected by OCD in this dataset. This balanced distribution highlights the importance of ensuring that treatment and support services are equally available to all patients, regardless of gender. Further analysis could explore if there are any differences in the severity or types of OCD symptoms between genders to provide more nuanced insights.

<img width="535" alt="Gender" src="https://github.com/suttiprapasutara/SQL_PowerBI_Project_OCD_Patient_Analytics/assets/173167594/f614ab67-50a0-40fd-92b9-58277bb45425">

*Donut chart visualizing the distribution of OCD patients by gender; Power BI was utilized to create this chart from my SQL query results*


### 2. Count of Patients by Ethnicity and their respective Average Obsession Score
Explores the distribution of OCD patients across different ethnic groups. By counting the number of patients by ethnicity and calculating their average obsession scores, we can assess how OCD affects various ethnic populations.

```sql
SELECT 
    Ethnicity,
    COUNT(Patient_ID) AS patient_count,
    AVG(Y_BOCS_Score_Obsessions) AS avg_obs_score

FROM PortfolioProject..ocd_patient_dataset

GROUP BY Ethnicity

ORDER BY patient_count;
```

### Key Trends

**1. Ethnic Distribution:** 
- The dataset shows a diverse ethnic distribution of OCD patients, with Caucasians having the highest patient count (398), followed by Hispanics (392), Asians (386), and Africans (324). This indicates that OCD affects individuals across various ethnicities.

**2. Similar Obsession Scores:**
- The average obsession scores are relatively similar across different ethnic groups, with Asians and Hispanics having an average score of 20, while Africans and Caucasians have an average score of 19. This suggests that the severity of obsession symptoms does not vary significantly between these ethnicities.

**3. Diverse Sample Population:**
- The diverse representation of ethnicities in the dataset highlights the importance of considering cultural and ethnic factors when studying OCD and developing treatment plans. The similarities in average obsession scores across ethnicities suggest that OCD's impact on obsession severity is consistent regardless of ethnic background.

### Summary
The analysis indicates a diverse ethnic representation among OCD patients, with Caucasians (398), Hispanics (392), Asians (386), and Africans (324) making up the sample population. The average obsession scores are relatively uniform across these ethnic groups, ranging from 19 to 20. This uniformity in obsession scores suggests that the severity of obsession symptoms is consistent across different ethnicities, emphasizing the universal nature of OCD. The findings underscore the need for culturally sensitive approaches in OCD research and treatment, ensuring that all ethnic groups receive equitable care and support.

<img width="913" alt="Ethnicity" src="https://github.com/suttiprapasutara/SQL_PowerBI_Project_OCD_Patient_Analytics/assets/173167594/3bda2c59-1ed7-4baa-9da9-e353afd29929">

*Donut chart visualizing the distribution of OCD patients by gender; Power BI was utilized to create this chart from my SQL query results*



### 3. Number of people diagnosed with OCD Month-over-Month (MoM)
Focuses on the temporal trends in OCD diagnoses. By examining the number of new OCD diagnoses on a month-over-month basis, we can identify any seasonal patterns or trends in the diagnosis rate.

```sql
-- ALTER TABLE PortfolioProject..ocd_patient_dataset
-- ALTER COLUMN OCD_Diagnosis_Date DATE;

SELECT 
    CONVERT(VARCHAR(7), [OCD_Diagnosis_Date], 120) + '-01 00:00:00' AS month, 
--    OCD_Diagnosis_Date,
    COUNT(Patient_ID) AS patient_count
FROM 
    PortfolioProject..ocd_patient_dataset
GROUP BY 
    CONVERT(VARCHAR(7), [OCD_Diagnosis_Date], 120) + '-01 00:00:00'
ORDER BY 
    month;
```

### Key Trends

**1. Initial Increase:** 
- The number of diagnosed cases shows a steady increase from November 2013 to March 2014, followed by some fluctuation.
  
**2. Seasonal Peaks:**
- There are noticeable peaks in diagnoses around October to January in multiple years, suggesting possible seasonal trends.

**3. Highest Peaks:**
- The highest patient counts are recorded in December 2015 (23 cases) and March 2018 (25 cases).

**4. Pandemic Effect:**
- During 2020, the numbers show a stable trend despite the COVID-19 pandemic, indicating no significant drop or rise compared to other years.

**5. Decline Post-2021:**
- There's a decline in the number of diagnosed cases starting from early 2021, with a noticeable drop in November 2022 (only 2 cases).

### Summary
The data shows a general upward trend in the number of OCD diagnoses from 2013 to 2015, with seasonal peaks suggesting an increase in diagnoses during the fall and winter months. The highest monthly counts were observed in late 2015 and early 2018. The impact of the COVID-19 pandemic on OCD diagnoses appears minimal, with numbers remaining relatively stable through 2020. However, a decline is noted from 2021 onwards, culminating in a significant drop in November 2022. This analysis could benefit from further investigation into the factors influencing these trends, such as seasonal variations, healthcare access, and broader societal impacts like the pandemic.

<img width="1440" alt="Month" src="https://github.com/suttiprapasutara/SQL_PowerBI_Project_OCD_Patient_Analytics/assets/173167594/02e2ea80-55d9-4760-a0e2-b4931681f2a7">

*Donut chart visualizing the distribution of OCD patients by gender; Power BI was utilized to create this chart from my SQL query results*


### 4. What is the most common Obsession Type (Count) & its respective Average Obsession Score
Identifies the most prevalent types of obsessions among OCD patients. By determining the count of each obsession type and their respective average obsession scores, we can understand which obsessions are most common and their severity levels.

### Key Trends

**1. Most Common Obsession:** 
- "Harm-related" is the most common obsession type, with 333 patients.

**2. Least Common Obsession:**
- "Hoarding" is the least common, with 278 patients.

**3. Average Obsession Scores:** The average obsession scores are fairly similar across all types, ranging from 19 to 21.
- "Hoarding" has the highest average obsession score of 21.
- All other types ("Symmetry," "Religious," "Contamination," and "Harm-related") have an average score of either 19 or 20.

**4. Patient Counts:** 
- The patient counts for the various obsession types are relatively close, with the smallest difference being between "Symmetry" (280) and "Hoarding" (278) and the largest between "Harm-related" (333) and "Hoarding" (278).

### Summary
The data indicates that "Harm-related" obsessions are the most prevalent among patients, while "Hoarding" is the least common. Despite the differences in patient counts, the average obsession scores are relatively uniform, with "Hoarding" slightly higher than the others. This suggests that while the prevalence of different types of obsessions varies, the severity (as measured by the average obsession score) is consistent across different types.


<img width="748" alt="obsession_type" src="https://github.com/suttiprapasutara/SQL_PowerBI_Project_OCD_Patient_Analytics/assets/173167594/ab352b90-ac5a-490e-b3a1-b62977a58c95">

*Donut chart visualizing the distribution of OCD patients by gender; Power BI was utilized to create this chart from my SQL query results*


### 5. What is the most common Compulsion Type (Count) & its respective Average Compulsion Score
Examines the most frequent types of compulsions in OCD patients. By calculating the count of each compulsion type and their respective average compulsion scores, we can gain insights into common compulsive behaviors and their severity.

```sql
SELECT
    Compulsion_Type,
    COUNT(Patient_ID) AS patient_count,
    AVG(Y_BOCS_Score_Obsessions) AS avg_obs_score

FROM 
    PortfolioProject..ocd_patient_dataset

GROUP BY Compulsion_Type

ORDER BY patient_count;
```

### Key Trends

**1. Most Common Compulsion:** 
- "Washing" is the most common compulsion type, with 321 patients.

**2. Least Common Compulsion:**
- "Ordering" is the least common, with 285 patients.

**3. Average Compulsion Scores:** The average compulsion scores are fairly consistent across different types, ranging from 19 to 20.
- "Checking" and "Washing" have an average compulsion score of 19.
- "Ordering," "Praying," and "Counting" have an average compulsion score of 20.

**4. Patient Counts:** 
- The patient counts for compulsion types vary, with "Washing" having the highest count and "Ordering" the lowest, indicating different prevalence rates among these behaviors.

### Summary
The data reveals that "Washing" is the most common compulsion among OCD patients, while "Ordering" is the least common. Despite variations in patient counts, the average compulsion scores remain relatively stable across different types. This suggests that while the frequency of specific compulsions may differ, their average severity (as measured by the average compulsion score) shows consistency. Understanding these patterns can assist clinicians in tailoring treatment strategies to address the diverse manifestations of OCD.

<img width="693" alt="compulsion_type" src="https://github.com/suttiprapasutara/SQL_PowerBI_Project_OCD_Patient_Analytics/assets/173167594/86741fff-07f0-40e0-8524-2c79c6868a70">

*Donut chart visualizing the distribution of OCD patients by gender; Power BI was utilized to create this chart from my SQL query results*


# What I Learned
Through analyzing the OCD Patient Dataset using SQL and PowerBI, several key insights were gained:
- **Demographic Insights:** Understanding the distribution of OCD across genders and ethnicities provided insights into potential demographic factors influencing OCD prevalence and symptom severity.
- **Symptom Analysis:** Examining the types of obsessions and compulsions prevalent among patients highlighted common behavioral patterns and their associated severity scores.
- **Temporal Trends:** Observing the trends in diagnosis over time uncovered seasonal variations and possible external factors influencing OCD incidence.

# Conclusion
This project provided valuable insights into the demographic and clinical profiles of OCD patients, highlighting several key findings:
- **Prevalence and Severity:** "Harm-related" obsessions and "Washing" compulsions were among the most prevalent types, indicating areas where clinical interventions may be focused.
- **Temporal Patterns:** Seasonal fluctuations in OCD diagnoses and stable average scores across different types of symptoms suggest consistent patterns in symptom manifestation.
- **Implications for Treatment:** Understanding these patterns can aid in developing targeted treatment strategies that address specific symptom profiles and demographic disparities among OCD patients.

By leveraging SQL for data manipulation and PowerBI for visualization, this project not only provided actionable insights for healthcare professionals but also underscored the importance of data-driven approaches in understanding and managing complex psychiatric conditions like OCD. Future directions may involve deeper dives into sub-group analyses and integrating additional datasets to further enrich our understanding of OCD's multifaceted nature.














