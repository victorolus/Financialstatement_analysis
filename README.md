# Financial Data Analysis Project

## Overview

This project focuses on the analysis of financial data sourced from the "FinancialStatements.csv" dataset. The data importation and analysis were initially carried out using SQLite via the command line in the Terminal. However, challenges arose during attempts to import data using MySQL Workbench. To address this issue, the dataset was exported to an SQL file and modified for MySQL compatibility, with the changes subsequently committed to a schema.

## Data Analysis

### Companies with the Highest Gross Profit in 2022

The analysis includes identifying companies with the highest gross profit in the year 2022.

### Companies with the Highest Market Capital in 2022

The project identifies companies with the highest market capitalization in the year 2022.

### Cumulative Gross Profit and Highest Sectors

This query explores the cumulative gross profit of each company along with their respective highest sectors.

### Earnings Per Share Analysis

For investor insights, the project provides an analysis of how each company performed post-COVID, focusing on the years 2021, 2022, and 2023.

### Cumulative Net Income Over the Years

This analysis looks at the cumulative net income of companies over the years, providing insights into their financial performance.

### Companies with the Highest Revenue in 2022

The project identifies companies with the highest revenue in the year 2022 and the categories with the highest revenues in the same year.

## Data Modification

### Updating Company Names for Readability

Company names were updated for readability, transforming formats like AMZN, INTC, PYPL to more recognizable names such as Amazon, Intel, PayPal.

### Adding Location Information for Visualization

A location column was added to the dataset, populated based on each company's headquarters, for later visualizations.

## Views for Visualization in Tableau

The project concludes by creating views suitable for visualization in Tableau. These include a view showcasing the locations of company headquarters in the US and another view highlighting companies with the highest cumulative net income in 2022.

These queries and modifications offer valuable insights into various financial aspects and provide a foundation for further visualization and analysis.
