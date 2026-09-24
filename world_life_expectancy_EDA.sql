SELECT *
FROM world_life_expectancy;

SELECT country , 
MAX(`Life expectancy`),
MIN(`Life expectancy`),
ROUND(MAX(`Life expectancy`)-MIN(`Life expectancy`),1) AS Life_increase_15_years
FROM world_life_expectancy
GROUP BY country 
HAVING MAX(`Life expectancy`) != 0 AND
MIN(`Life expectancy`) != 0
ORDER BY Life_increase_15_years DESC;

SELECT year , ROUND(AVG(`Life expectancy`),2)
FROM world_life_expectancy
WHERE `Life expectancy` !=0
GROUP BY year
ORDER BY year;

SELECT country , ROUND(AVG(`Life expectancy`),2) AS life_exp, ROUND(AVG(GDP),2) AS avg_GDP
FROM world_life_expectancy
GROUP BY country
HAVING life_exp > 0
AND avg_GDP> 0
ORDER BY avg_GDP DESC;

SELECT 
SUM(CASE 
	WHEN GDP >= 1500 THEN 1 ELSE 0 END ) AS High_GDP_Count ,
ROUND(AVG(CASE 
	WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END ),2) AS High_GDP_Life_expectancy,
SUM(CASE 
	WHEN GDP <= 1500 THEN 1 ELSE 0 END ) AS Low_GDP_Count ,
ROUND(AVG(CASE 
	WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END ),2) AS Low_GDP_Life_expectancy
FROM world_life_expectancy;


SELECT status , ROUND(AVG(`Life expectancy`),2) AS avg_life
FROM world_life_expectancy
GROUP BY status;

SELECT status , COUNT(DISTINCT country),ROUND(AVG(`Life expectancy`),2) AS avg_life
FROM world_life_expectancy
GROUP BY status;

SELECT country , ROUND(AVG(`Life expectancy`),2) AS life_exp, ROUND(AVG(bmi),2) AS avg_bmi
FROM world_life_expectancy
GROUP BY country
HAVING life_exp > 0
AND avg_bmi > 0
ORDER BY avg_bmi ASC;


SELECT country , year , `Life expectancy`,`Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY country ORDER BY year) AS Rolling_Total
FROM world_life_expectancy;




