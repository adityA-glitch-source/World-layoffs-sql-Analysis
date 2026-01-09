USE world_layoff;
SET SQL_Safe_updateS = 0
-- Let's create a copy of the dataset
CREATE TABLE layoffs_staging LIKE layoffs; 

INSERT INTO layoffs_staging 
SELECT * FROM layoffs;

-- Data cleaning
SELECT COUNT(*) FROM layoffs_staging; -- checking total rowa

SELECT COUNT(*) FROM layoffs_staging -- checking total non-important rows which won't be contribute in finding insights 
WHERE  total_laid_off IS NULL AND 
percentage_laid_off IS NULL;

-- 1. DROP DUPLICATES 
CREATE TABLE `layoffs_staging2` ( -- Created a staging2 table to delete duplicate rows using row_number() Window function
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  ranking INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_staging2  
SELECT *,
       ROW_NUMBER() OVER(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) AS ranking
       FROM layoffs_staging;

DELETE FROM layoffs_staging2 -- Deletes all the duplicate rows from the table
WHERE ranking>2;

-- 2. Standardize text

SELECT * FROM layoffs_staging2;

UPDATE layoffs_staging   -- Trimmed extra spaces from company,locatio,indusry,stage,country
SET company = TRIM(company),
    location  = TRIM(location),
    industry = TRIM(industry),
    stage = TRIM(stage),
    country = TRIM(country);

UPDATE layoffs_staging2 -- Fixed united states row which have extra trailing spaces
SET country = 'United States'
WHERE country LIKE 'United States%'

UPDATE layoffs_staging2 -- standardized the format of date column
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y')

ALTER TABLE layoffs_staging2 -- change the column `date` column to data data-type from text data-type
MODIFY COLUMN `date` date;

-- 3. Handling Null values or blank values
DELETE  FROM  layoffs_staging2 -- Delete all the rows which have both total_laid_off and percentage_laid_off is null
WHERE total_laid_off is null 
and percentage_laid_off is null;

-- 4 DROP  Unnescessary  columns
ALTER TABLE layoffs_staging2
DROP COLUMN ranking;