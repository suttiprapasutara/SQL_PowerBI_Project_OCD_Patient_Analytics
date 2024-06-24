-- 1. Count & Percent of F vs M that have OCD & -- Average Obsession Score by Gender

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



-- 2. Count of Patients by Ethnicity and their respective Average Obsession Score

SELECT 
    Ethnicity,
    COUNT(Patient_ID) AS patient_count,
    AVG(Y_BOCS_Score_Obsessions) AS avg_obs_score

FROM PortfolioProject..ocd_patient_dataset

GROUP BY Ethnicity

ORDER BY patient_count;




-- 3. Number of people diagnosed with OCD month over month

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




-- 4. What is the most common Obsession Type (Count) & it's respective Average Obsession Score

SELECT
    Obsession_Type,
    COUNT(Patient_ID) AS patient_count,
    AVG(Y_BOCS_Score_Obsessions) AS avg_obs_score

FROM 
    PortfolioProject..ocd_patient_dataset

GROUP BY Obsession_Type

ORDER BY patient_count;



-- 5. What is the most common Compulsion Type (Count) & it's respective Average Obsession Score

SELECT
    Compulsion_Type,
    COUNT(Patient_ID) AS patient_count,
    AVG(Y_BOCS_Score_Obsessions) AS avg_obs_score

FROM 
    PortfolioProject..ocd_patient_dataset

GROUP BY Compulsion_Type

ORDER BY patient_count;