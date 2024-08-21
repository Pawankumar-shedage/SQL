

--NOTES,  DATA as of 4 July 2024.

	--here we had to total_cases to integes to find Max, because it's original datatype is nvarchar as max is applied on numbers, 
SELECT MAX(CAST(total_cases as int)),population AS CountryPopulation, (MAX(CAST (total_cases as float))/population) * 100 AS Percentage
FROM PortfolioProject..CovidDeaths
where location = 'Cyprus'
GROUP BY population