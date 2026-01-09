USE world_layoff

-- Exploratory Data analysis begins here!!
CREATE TABLE layoffs_cleaned as  -- Final cleaned table extracted
SELECT * FROM layoffs_staging2;

SELECT * FROM layoffs_cleaned;

-- Populated missing industries 
UPDATE  layoffs_cleaned t1
JOIN layoffs_cleaned t2
ON t1.company = t2.company 
SET t1.industry = t2.industry 
WHERE t1.industry is null and t2.industry is not null;


-- 1. Find total layoffs by country 
SELECT country,SUM(total_laid_off) AS total_layoff
FROM layoffs_cleaned
GROUP BY country
HAVING SUM(total_laid_off) is not null
ORDER BY total_layoff desc;

-- According to the data United states has the highest layoffs While poland has the least layoffs

-- 2.Layoffs by industry 
SELECT industry,SUM(total_laid_off) AS total_layoffs
FROM layoffs_cleaned 
WHERE industry is not null
GROUP BY industry 
HAVING SUM(total_laid_off) IS NOT NULL 
ORDER BY total_layoffs desc

-- Consumer industry has most layoffs and Manufacturing has the least layoffs

-- 3 Top Companies by layoffs
SELECT company,SUM(total_laid_off) AS total_layoffs
FROM layoffs_cleaned 
GROUP BY company
HAVING SUM(total_laid_off) is not null
ORDER BY total_layoffs desc
LIMIT 10;

-- 4 Layoffs trend by year
SELECT YEAR(`date`) AS `Year` , SUM(total_laid_off) AS total_layoffs
FROM layoffs_cleaned 
WHERE `date` is not null
group by YEAR(`date`)
ORDER BY YEAR(`date`) desc;

-- 5 Monthly rolling layoffs
SELECT SUBSTRING(`date`,1,7) AS month ,SUM(total_laid_off) AS total_layoffs,
SUM(SUM(total_laid_off)) OVER(order by SUBSTRING(`date`,1,7) ) AS rolling_layoffs
FROM layoffs_cleaned
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY SUBSTRING(`date`,1,7)
order by SUBSTRING(`date`,1,7)

