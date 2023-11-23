Select * 
from [Portfolio Project]..Deaths$
where continent is not NULL
order by 2,3


Select * 
from [Portfolio Project]..Vaccinations$
where continent is not NULL
order by 2,3

-- Select data that we are going to be using

Select Location, date, total_cases, total_deaths, population
from [Portfolio Project] ..Deaths$
where continent is not NULL
order by 1,2

-- Looking at Total Cases vs Total Deaths
-- The likelihood of dying if you catch Covid

Select location, date, total_cases,total_deaths,(CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0)) * 100 AS Deathpercentage
from [Portfolio Project]..Deaths$
where continent is not NULL
and location like '%kingdom'
order by 1,2

-- Looking at the total cases vs population

Select location, date, total_cases,(CONVERT(float, total_cases) / population) * 100 AS cases_percentage
from [Portfolio Project]..Deaths$
where continent is not NULL
and location like '%kingdom'
order by 1,2

-- Looking at countries with the highest infection rate

Select location, population, MAX(total_cases) as highest_infection_count, (MAX(total_cases)/population) * 100 as highest_infection_rate
from [Portfolio Project]..Deaths$
where continent is not NULL
-- and location like '%kingdom'
Group by population, location
order by highest_infection_rate DESC

-- Looking at countries with the lowest infection rate

Select location, population, MIN(total_cases) as lowest_infection_count, (MIN(total_cases)/population) * 100 as lowest_infection_rate
from [Portfolio Project]..Deaths$
where continent is not NULL
-- and location like '%kingdom'
Group by location, population
order by lowest_infection_rate ASC

--Looking at countries with the highest death count per populaiton

Select location, MAX(cast(total_deaths as int)) as total_death_count
from [Portfolio Project]..Deaths$
where continent is not NULL
Group by location
order by total_death_count DESC

-- Broken down by continent

Select location, MAX(cast(total_deaths as int)) as total_death_count
from [Portfolio Project]..Deaths$
where continent is NULL
Group by location
order by total_death_count DESC

-- death Percentage by continent

Select location, MAX(cast(total_deaths as int)) as total_death_count, population, (MAX(cast(total_deaths as int))/population)*100 as death_percentage_by_continent
from [Portfolio Project]..Deaths$
where continent is NULL
and location like 'Europe' OR location like 'Asia' OR location like 'Africa' OR location like 'North America' OR location like 'South America' OR location like 'Oceania'
Group by location, population
order by total_death_count DESC

-- death Percentage by income status

Select location, MAX(cast(total_deaths as int)) as total_death_count, population, (MAX(cast(total_deaths as int))/population)*100 as death_percentage_by_income_status
from [Portfolio Project]..Deaths$
where continent is NULL
and location like 'Upper middle income' OR location like 'Lower middle income' OR location like 'Low income' OR location like 'High income'
Group by location, population
order by total_death_count DESC

-- Global numbers

Select date, SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, (CONVERT(float, SUM(new_deaths)) / NULLIF(CONVERT(float, SUM(new_cases)), 0))*100 as Death_percentage--  total_cases,total_deaths,(CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0)) * 100 AS Deathpercentage
from [Portfolio Project]..Deaths$
where continent is not NULL
 -- and location like '%kingdom'
group by date
order by 1,4

-- Global total cases vs deaths

insert into #global_cases_vs_deaths
Select SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, (CONVERT(float, SUM(new_deaths)) / NULLIF(CONVERT(float, SUM(new_cases)), 0))*100 as Death_percentage--  total_cases,total_deaths,(CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0)) * 100 AS Deathpercentage
from [Portfolio Project]..Deaths$
where continent is not NULL
-- and location like '%kingdom'
-- group by date
order by 1

--Join of tables - Deaths and Vaccinations
--Looking at total population vs vaccinations

-- Use CTE

With PopulationVsVaccination (continent, location, date, population, new_vaccinations, total_vaccinations_cumulative)
as
(
Select death.continent, death.location, death.date, death.population, vac.new_vaccinations, SUM(CONVERT(float,vac.new_vaccinations)) OVER (Partition by death.location order by death.location, death.date) as total_vaccinations_cumulative
-- , (percentage_vaccinated / population)*100
From [Portfolio Project]..Deaths$ death
Join [Portfolio Project]..Vaccinations$ vac
  On death.date = vac.date
  and death.location = vac.location
where death.continent is not NULL
-- Order by 2,3
)
Select * , total_vaccinations_cumulative/population*100 as percentage_vaccinated
From PopulationVsVaccination





Select death.continent, death.location, death.date, death.population, vac.new_vaccinations, SUM(CONVERT(float,vac.new_vaccinations)) OVER (Partition by death.location order by death.location, death.date) as total_vaccinations_cumulative
From [Portfolio Project]..Deaths$ death
Join [Portfolio Project]..Vaccinations$ vac
  On death.date = vac.date
  and death.location = vac.location
where death.continent is not NULL
Order by 2,3


-- TEMP TABLE

DROP TABLE if exists #PercentagePopulationVaccinated
Create Table #PercentagePopulationVaccinated
(
Continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
total_vaccinations_cumulative numeric,
)

Insert into #PercentagePopulationVaccinated
Select death.continent, death.location, death.date, death.population, vac.new_vaccinations, SUM(CONVERT(float,vac.new_vaccinations)) OVER (Partition by death.location order by death.location, death.date) as total_vaccinations_cumulative
-- , (percentage_vaccinated / population)*100
From [Portfolio Project]..Deaths$ death
Join [Portfolio Project]..Vaccinations$ vac
  On death.date = vac.date
  and death.location = vac.location
where death.continent is not NULL

Select * , total_vaccinations_cumulative/population*100 as percentage_vaccinated
From #PercentagePopulationVaccinated


-- creating view to store for later visualisations

Create view PercentagePopulationVaccinated as
Select death.continent, death.location, death.date, death.population, vac.new_vaccinations, SUM(CONVERT(float,vac.new_vaccinations)) OVER (Partition by death.location order by death.location, death.date) as total_vaccinations_cumulative
-- , (percentage_vaccinated / population)*100
From [Portfolio Project]..Deaths$ death
Join [Portfolio Project]..Vaccinations$ vac
  On death.date = vac.date
  and death.location = vac.location
where death.continent is not NULL