-- The table was imported via the command line in the Terminal. However, an issue arises when attempting to import data using MySQL Workbench. 
-- The table in question was originally created through the execution of the following query:
    
		-- sqlite> .open fin_st.db
		-- sqlite> .mode csv
		-- sqlite> .import /Users/victola/Downloads/FinancialStatements.csv fin_st
	
-- Subsequently, I exported the database to an SQL file and proceeded to open it using MySQL Workbench. 
-- Following this, I made requisite syntactical modifications to ensure compatibility with MySQL.
-- Finally, I committed these changes to a schema.



-- Looking at the Companies with the Highest Gross Profit in 2022
select Company, GrossProfit, year from fin_st where year=2022 order by GrossProfit desc;


-- Looking at the Companies with the Highest Market Capital in 2022
select Company, MarketCap, year from fin_st where year=2022 order by MarketCap desc;


-- Looking at the number over the years. First the Cumulative Gross Profit of each company. What Sectors (category) are the Highest.

SELECT
  MAX(Grossprofit) AS Grossprofit,
  company,
  MAX(category) AS category,
  MAX(cumulative_grossprofit) AS cumulative_grossprofit
FROM (
  SELECT
    Grossprofit,
    company,
    category,
    SUM(Grossprofit) OVER (PARTITION BY company ORDER BY Grossprofit) AS cumulative_grossprofit
  FROM
    fin_st
) AS subquery
GROUP BY
  company;

-- For the investors, this gives an insight that is needed to see how each company has performed post Covid.
SELECT
  Year,
  Company,
  EarningPerShare
FROM
  fin_st
WHERE
  Year IN (2021, 2022, 2023)
ORDER BY
  company DESC;
  
  
  
-- looking at the companies based on cumulative net income over the year.


SELECT
   finalyear as YeartoDate, 
   max(cumulative_netincome) as cumulative_netincome, 
   company, 
   max(Category) as Category
From(
	Select 
		company, 
		category, 
		netincome, 
		sum(netincome) over (partition by company order by netincome) as cumulative_netincome, 
		max(year) over (partition by company) as finalyear
	from financialstatement.fin_st
)subquery
group by company,finalyear;



-- this shows the companies with the highest revenue in the year 2022. Should be 2023 but the dataset doesn't have 2023 data for some companies.
	-- this also shows the categories with the highest revenues in 2022
select 
	year, 
    Company,
    Revenue,
    Category
from fin_st
where year = 2022
order by Revenue desc;

    


-- altering the table to make the company name readable they were previously in formats like AMZN,INTC,PYPL which should be Amazon, Intel, PayPal.

Select Distinct company from fin_st;

	-- Update values in the company column

UPDATE fin_st
SET Company = 
    CASE
        WHEN Company = 'AAPL' THEN 'AppleINC'
        WHEN Company = 'MSFT' THEN 'MicrosoftCorp'
        WHEN Company = 'GOOG' THEN 'GoogleLLC'
        WHEN Company = 'PYPL' THEN 'PayPalHoldingSInc'
        WHEN Company = 'AIG' THEN 'AmericanInternationalGroup'
        WHEN Company = 'PCG' THEN 'PacificGasandElectric'
        WHEN Company = 'SHLDQ' THEN 'SearsHoldingCorp'
        WHEN Company = 'MCD' THEN 'McDonalds'
        WHEN Company = 'BCS' THEN 'BarclaysPLC'
        WHEN Company = 'NVDA' THEN 'NvidiaCorp'
        WHEN Company = 'INTC' THEN 'IntelCorp'
        WHEN Company = 'AMZN' THEN 'AmazonInc'
        ELSE Company  -- If no conditions are met, keep the current value
    END
WHERE Year BETWEEN 2009 and 2023;


select distinct company from fin_st; -- confirming that company names have been updated.alter



-- creating a column to add the physical Location of each comapny for later visualizations

ALTER TABLE fin_st
ADD Location TEXT;

-- Populating the Location column based on company
UPDATE fin_st
SET
    Location =
        CASE
            WHEN Company = 'AmazonInc' THEN 'Washington'
            WHEN Company = 'AmericanInternationalGroup' THEN 'New York'
            WHEN Company = 'AppleINC' THEN 'California'
            WHEN Company = 'BarclaysPLC' THEN 'Delaware' -- Although the actual HQ is in London, the US HQ is in Delaware and will be used for visualization.
            WHEN Company = 'GoogleLLC' THEN 'California'
            WHEN Company = 'IntelCorp' THEN 'California'
            WHEN Company = 'McDonalds' THEN 'Illinois'
            WHEN Company = 'NvidiaCorp' THEN 'California'
            WHEN Company = 'PacificGasandElectric' THEN 'California'
            WHEN Company = 'PayPalHoldingSInc' THEN 'California'
            WHEN Company = 'SearsHoldingCorp' THEN 'Illinois'
			WHEN Company = 'MicrosoftCorp' THEN 'Washington'
            ELSE Location  -- If no conditions are met, keep the current value
        END;


-- Creating Views for visualization on Tableau

-- Locations of the company HQs in the US
CREATE VIEW Company_HQ_Location AS
SELECT Company, Location, Year,Revenue
FROM fin_st
ORDER BY Revenue;

-- View for Highest cumulative net income
CREATE VIEW Cumulative_netincome AS
SELECT company, NetIncome
FROM fin_st 
WHERE Year = 2022
ORDER BY NetIncome desc;

-- View for Earning per share 

CREATE VIEW Earningpershare AS
SELECT company, EarningPerShare, year
FROM fin_st 
ORDER BY Company;


