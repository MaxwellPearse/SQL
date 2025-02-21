-- Exploratory Data analysis

SELECT *
FROM layoffs_staging2;

SELECT MAX(total_laid_off),MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off=1
ORDER BY total_laid_off DESC;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off=1
ORDER BY funds_raised_millions DESC;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(date),MAX(date)
FROM layoffs_staging2;

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(`DATE`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`DATE`)
ORDER BY 1 DESC;

SELECT STAGE, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY STAGE
ORDER BY 1 DESC;

SELECT country, SUM(percentage_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT substring(`DATE`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE substring(`DATE`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

WITH ROLLING_TOTAL AS 
	(SELECT substring(`DATE`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
	FROM layoffs_staging2
	WHERE substring(`DATE`,1,7) IS NOT NULL
	GROUP BY `MONTH`
	ORDER BY 1 ASC)
SELECT `MONTH`,total_off, SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM ROLLING_TOTAL;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT company,YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company,YEAR(`date`)
ORDER BY 3 DESC;

WITH company_year(company, years, total_laid_off) AS 
	(SELECT company,YEAR(`date`), SUM(total_laid_off)
	FROM layoffs_staging2
	GROUP BY company,YEAR(`date`))
, Company_Year_Ranking as(
	SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking 
	FROM company_year
	ORDER BY Ranking ASC)
    SELECT *	
    FROM Company_Year_Ranking
    WHERE Ranking <= 5
    ORDER BY `years`