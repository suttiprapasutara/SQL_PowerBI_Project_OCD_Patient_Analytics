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


