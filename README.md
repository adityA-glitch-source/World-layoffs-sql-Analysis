# 🌍 World Layoffs SQL Analysis

## 📌 Objective
To perform **end-to-end data cleaning and exploratory data analysis (EDA)** on a real-world global layoffs dataset using **SQL**, with the goal of extracting meaningful **business and industry insights**.

---

## 🧹 Data Cleaning
The dataset was cleaned and prepared for analysis using SQL by performing the following steps:

- Removed duplicate records using `ROW_NUMBER()` and window functions  
- Standardized country and industry names for consistency  
- Converted string-based dates using `STR_TO_DATE()`  
- Handled missing and NULL values appropriately  
- Populated blank `industry` values using self-joins  
- Created a finalized cleaned table for reliable analysis  

---

## 🔍 Exploratory Data Analysis (EDA)
The following analyses were conducted to uncover trends and patterns:

- Country-wise total layoffs  
- Industry-wise total layoffs  
- Top companies by number of layoffs  
- Yearly and monthly layoffs trends  
- Cumulative layoffs over time using window functions  

---

## 🛠 Tools & SQL Concepts Used
- MySQL  
- Common Table Expressions (CTEs)  
- Window Functions  
- Aggregate Functions  
- Date & Time Functions  

---

## 📈 Key Insights
- The **Consumer industry** experienced the highest number of layoffs, totaling **47,082**  
- The **Manufacturing industry** recorded the lowest layoffs, with only **20**  
- Layoffs peaked during **2022–2023**, indicating a global economic slowdown  
- The **United States** had the highest total layoffs at **258,159**  
- **Poland** recorded the lowest layoffs, with **25**  
- Companies with the highest layoffs include:  
  - Amazon (**18,150**)  
  - Google (**12,000**)  
  - Meta (**11,000**)  
  - Salesforce (**10,090**)  
  - Microsoft (**10,000**)  

---

## 📎 Dataset
World layoffs dataset (publicly available)

---

## 🎯 Why This Project Matters
This project demonstrates:
- Real-world **SQL data cleaning skills**
- Strong understanding of **EDA and business insights**
- Practical use of **window functions and CTEs**
- Ability to handle **messy, real-world datasets**
