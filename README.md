# Project 1: Global Layoffs Data Analysis

## Overview
Cleaned and analyzed global tech layoffs data to uncover patterns by company, industry, country, and year.

## Key Steps
- **Data Cleaning**:
  - Removed duplicates with `ROW_NUMBER()`.
  - Standardized text fields (industries, countries).
  - Converted string dates to proper `DATE` format.
  - Handled missing values and deleted unusable records.
- **Exploratory Analysis**:
  - Total layoffs by company, industry, country, and funding stage.
  - Trends of layoffs over months and years.
  - Identified companies with 100% workforce layoffs.
  - Created rolling total of layoffs over time.
- **SQL Techniques**:  
  CTEs, window functions (`ROW_NUMBER()`, `DENSE_RANK()`), aggregation, date functions.

## Outcomes
- Built a cleaned, analysis-ready database.
- Extracted insights about industries and countries most impacted by layoffs.

---

# Project 2: Walmart Sales Data Analysis

## Overview
Analyzed Walmart transactional sales data, performed feature engineering, and derived business insights.

## Key Steps
- **Feature Engineering**:
  - Added columns for `time_of_day`, `day_name`, and `month_name`.
- **Exploratory Analysis**:
  - Revenue and sales breakdown by product line, city, payment method, and customer type.
  - Customer behavior analysis by gender, weekday, and shopping time.
  - Analyzed product performance and rating patterns.
- **SQL Techniques**:  
  Grouping, aggregation, conditional logic (`CASE`), feature extraction from dates.

## Outcomes
- Identified top-selling products, best revenue months, and highest-spending customer types.
- Built a rich, business-focused sales dataset ready for reporting or dashboarding.
