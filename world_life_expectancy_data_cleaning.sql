SELECT *
FROM world_life_expectancy;

SELECT country ,year, CONCAT(country,year) , count(CONCAT(country,year))
FROM world_life_expectancy
GROUP BY country ,year, CONCAT(country,year) ;

SELECT *
FROM (
SELECT Row_id ,CONCAT(country,year),
ROW_NUMBER() OVER(PARTITION BY CONCAT(country,year) ORDER BY CONCAT(country,year)) AS row_num
FROM world_life_expectancy) AS row_table
WHERE row_num >1 ;

DELETE FROM world_life_expectancy
WHERE row_id IN (SELECT row_id
				FROM (
						SELECT Row_id ,CONCAT(country,year),
						ROW_NUMBER() OVER(PARTITION BY CONCAT(country,year) ORDER BY CONCAT(country,year)) AS row_num
						FROM world_life_expectancy) AS row_table
						WHERE row_num >1);
                        
SELECT *
FROM world_life_expectancy
WHERE Status = '';

SELECT DISTINCT (status)
FROM world_life_expectancy
WHERE status != '';

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
SET t1.status = 'Developing'
WHERE t1.status = ''
AND t2.status != ''
AND t2.status = 'Developing';

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
SET t1.status = 'Developed'
WHERE t1.status = ''
AND t2.status != ''
AND t2.status = 'Developed';

SELECT country , year , `life expectancy`
FROM world_life_expectancy
WHERE `life expectancy` = '';

SELECT t1.country , t1.year , t1.`life expectancy`,
t2.country , t2.year , t2.`life expectancy`,
t3.country , t3.year , t3.`life expectancy`,
ROUND((t2.`life expectancy`+ t3.`life expectancy`)/2,1)
FROM world_life_expectancy AS t1
JOIN world_life_expectancy AS t2
ON t1.country = t2.country
AND t1.year = t2.year - 1
JOIN world_life_expectancy AS t3
ON t1.country = t3.country
AND t1.year = t3.year + 1 
WHERE t1.`life expectancy` = ''; 

UPDATE world_life_expectancy AS t1
JOIN world_life_expectancy AS t2
	ON t1.country = t2.country
	AND t1.year = t2.year - 1
JOIN world_life_expectancy AS t3
	ON t1.country = t3.country
	AND t1.year = t3.year + 1 
SET t1.`life expectancy` = ROUND((t2.`life expectancy`+ t3.`life expectancy`)/2,1)
WHERE t1.`life expectancy` = '';


