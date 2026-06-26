CREATE DATABASE titanic;

USE titanic;

#1. How many passengers are in the dataset?
SELECT COUNT(*) AS totol_passengers 
FROM titanic;

#2. How many columns are available in the dataset?
SELECT COUNT(*) AS count_column
FROM Information_Schema.columns
WHERE table_name = "titanic";

#3. How many passengers survived?
SELECT COUNT(*) AS total_passengers, New_Survived
FROM titanic
WHERE survived = 1
GROUP BY New_Survived;

#4. How many passengers did not survive?
SELECT COUNT(*) AS total_passengers, New_Survived
FROM titanic
WHERE survived = 0
GROUP BY New_Survived;

#5. What is the survival percentage?
SELECT ROUND(AVG(survived) * 100, 2) AS survival_percentage
FROM titanic;

#6. How many male and female passengers are there?
SELECT COUNT(*) AS gender_passengers, Gender
FROM titanic
GROUP BY Gender;

#7. What is the average age of passengers?
SELECT AVG(age) AS avg_age, New_Survived
FROM titanic
GROUP BY New_Survived;

#8. What is the minimum and maximum age?
SELECT MIN(age) AS min_age,
MAX(age) AS max_age
FROM titanic;

#9. What is the average fare paid?
SELECT avg(fare) AS avg_fare
FROM titanic;

#10. What is the minimum and maximum fare?
SELECT min(fare) AS min_fare,
max(fare) AS max_fare
FROM titanic;

#11. How many passengers have missing age values?
SELECT COUNT(*) AS missing_age_count
FROM titanic
WHERE Age IS NULL;

#12. How many passengers have missing embark_town values?
SELECT COUNT(*) AS missing_embark_town
FROM titanic
WHERE embark_town IS NULL;

#13. What percentage of age values are missing?
SELECT (count(*) / (SELECT COUNT(*) FROM titanic AS missing_age_percentage )) * 100
FROM titanic
WHERE age IS NULL;

#14. Which column has the most missing values?
SELECT SUM(survived) is null AS missing_value_survived, 
SUM(pclass) is null AS missing_value_pclass,
SUM(fare) is null AS missing_value_fare
FROM titanic;

#15. Count complete records with no NULL values.
SELECT SUM(survived) is not null AS missing_value_survived, 
SUM(pclass) is not null AS missing_value_pclass,
SUM(fare) is not null AS missing_value_fare
FROM titanic;

#16. How many passengers belong to each passenger class (pclass)?
SELECT pclass, COUNT(*) AS count_pclass
FROM titanic
GROUP BY pclass;

#17. What is the survival rate by passenger class?
SELECT pclass, (SUM(survived) / (SELECT COUNT(*) AS survived_rate))* 100
FROM titanic
GROUP BY pclass;

#18. What is the average fare by passenger class?
SELECT pclass, (round(SUM(fare) / (SELECT COUNT(*) AS avg_fare))* 100)
FROM titanic
GROUP BY pclass;

#19. What is the average age by passenger class?
SELECT pclass, (AVG(age) / (SELECT COUNT(*) AS avg_age))* 100
FROM titanic
GROUP BY pclass;

#20. Which class has the highest survival rate?
SELECT pclass, ROUND(AVG(survived) * 100, 2) AS high_survival_rate 
FROM titanic
GROUP BY pclass;

#21. What is the survival rate for males and females?
SELECT Gender, ROUND(AVG(survived) * 100, 2)  AS SURVIVED_RATE  
FROM titanic
GROUP BY Gender;

#22. How many male passengers survived?
SELECT Gender, COUNT(*) AS MALE_SURVIVED
FROM titanic
WHERE Gender = "male" AND survived  = 1 
GROUP BY Gender;

# 23. How many female passengers survived?
SELECT Gender, COUNT(*) AS FEMALE_SURVIVED
FROM titanic
WHERE Gender = "female" AND survived  = 1 
GROUP BY Gender;

# 24. What is the average age of males and females?
SELECT Gender, AVG(age) AS AVG_AGE
FROM titanic
GROUP BY Gender;

#25. What is the average fare paid by males and females?
SELECT Gender, AVG(fare) AS AVG_FARE
FROM titanic
GROUP BY Gender;

#26. What is the survival rate for passengers under 18?
SELECT ROUND(AVG(survived) * 100, 2) AS survival_rate
FROM titanic
WHERE age > 18;


#27. What is the survival rate for passengers above 60?
SELECT ROUND(AVG(survived) * 100, 2) AS survival_rate
FROM titanic
WHERE age >= 60;

#28. Which age had the highest number of passengers?
SELECT age, COUNT(*) AS high_passengers
FROM titanic
WHERE age IS NOT NULL
GROUP BY age
ORDER BY age DESC
LIMIT 1;

#29. What is the average fare for each age?
SELECT age, avg(fare) AS avg_fare
FROM titanic
GROUP BY age;

SELECT max(age), min(age)
FROM titanic;

#30. Divide passengers into age groups and count them.
SELECT 
CASE 
	WHEN age < 18 THEN "child"
    WHEN age   BETWEEN 18 AND 35 THEN "Young Adult"
    WHEN age  BETWEEN 30 AND 60 THEN " Adult"
    WHEN age > 60 THEN " Senior"
    ELSE "Unkowns"
    END AS age_group,
    COUNT(*) AS total_passenger
    FROM titanic
    GROUP BY age_group;
    
#31. What is the average family size?
SELECT round(avg( sibsp + parch + 1) , 2) AS avg_family_size
FROM titanic;
    
#32. How many passengers traveled alone?
SELECT count(*) AS total_passenger, alone
FROM titanic
GROUP BY alone;

#33. How many passengers traveled with family?
SELECT round(sibsp + parch + 1) AS family_passengers, COUNT(*) AS total_passenger
FROM titanic
GROUP BY family_passengers;

#34. What is the survival rate of passengers traveling alone?
SELECT ( AVG(survived) * 100 ) AS  survival_rate, alone
FROM titanic
GROUP BY alone;

#35. What is the survival rate of passengers traveling with family?
SELECT ( AVG(survived) * 100 ) AS  survival_rate, ROUND( sibsp + parch + 1) AS family_passenger
FROM titanic
GROUP BY family_passenger;

#36. What are the top 10 highest fares paid?
SELECT fare FROM titanic
ORDER BY fare DESC
LIMIT 10;

#37. What is the average fare among survivors?
SELECT COUNT(*) AS count_passengers, avg(fare) AS avg_fare
FROM titanic
WHERE survived = 1;

#38. What is the average fare among non-survivors?
SELECT count(*) AS count_passengers, avg(fare) AS avg_fare
FROM titanic
WHERE survived = 0;

SELECT Max(fare), min(fare)
FROM titanic;

#39. Which fare range contains the most passengers?
SELECT
    CASE
        WHEN fare <= 10 THEN '0-10'
        WHEN fare <= 20 THEN '11-20'
        WHEN fare <= 50 THEN '21-50'
        WHEN fare <= 100 THEN '51-100'
        ELSE '100+'
    END AS fare_range,
    COUNT(*) AS total_passengers
FROM titanic
GROUP BY fare_range
ORDER BY total_passengers DESC
LIMIT 1;

#40. Do passengers paying higher fares survive more often?
SELECT 
CASE 
	WHEN fare <= 10 THEN "1-10"
    WHEN fare <= 20 THEN "11-20"
    WHEN fare <= 50 THEN "21-50"
    WHEN fare <= 100  THEN "51-100"
    ELSE "100+"
    END AS range_fare
    FROM titanic
    GROUP BY range_fare
    ORDER BY range_fare DESC;
    
#41. How many passengers boarded from each embark_town?
SELECT COUNT(*) AS totol_passengers, embark_town
FROM titanic
GROUP BY embark_town;

#42. What is the survival rate by embark_town?
SELECT (AVG(survived) * 100) AS SURVIVAL_RATE, embark_town
FROM titanic
GROUP BY embark_town;

#43. What is the average fare by embark_town?
SELECT avg(fare) AS avg_fare, embark_town
FROM titanic
GROUP BY embark_town;

#44. What is the average age by embark_town?
SELECT AVG(age) AS avg_age, embark_town
FROM titanic
GROUP BY embark_town;

#45. Which embark_town had the most survivors?
SELECT COUNT(survived) AS total_passenger, embark_town
FROM titanic
GROUP BY embark_town 
ORDER BY embark_town DESC
LIMIT 1;

#46. What is the survival rate by gender and class?
SELECT (AVG(survived) * 100) AS survival_rate, Gender, pclass
FROM titanic
GROUP BY Gender, pclass;

#46. What is the survival rate by age group and gender?
SELECT (AVG(survived) * 100) AS survival_rate, age, Gender
FROM titanic
GROUP BY age, Gender;

#47. Which passenger group paid the highest average fare?

#48. Compare survival rates for adults and children.









 









