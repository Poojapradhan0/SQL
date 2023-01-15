==================================
==========================
==================

use Assignment
go
--------------------------------------------------
----------------------------------

select * from CovidDeaths
where continent is not null
order by 3,4

select * from CovidVaccinations
order by 3,4

select location, date, total_cases, new_cases, total_deaths, population
from CovidDeaths
order by 1,2


--Looking total cases vs total deaths
  
 select location, date, total_cases, total_deaths, (total_cases/total_deaths)* 100 as DeathPercentage
from CovidDeaths
order by 1,2


-- united states deathpercentage (you can return any country result )

 select location, date, total_cases, total_deaths, (total_cases/total_deaths)* 100 as DeathPercentage
from CovidDeaths
where location like '%states%'
and continent is not null
order by 1,2


--:ooking at total cases vs population
 --show what percentage of population got covid

 select location, date,population, total_cases, (total_cases/population)* 100 as Percentofpopulationinfected
from CovidDeaths
where continent is NOT NULL
order by 1,2


--looking at countries with HIGHEST INFECTION RATE compared to population

 select location,population, MAX(total_cases) as highestinfectioncount, MAX((total_cases/population))* 100 as Percentofpopulationinfected
from CovidDeaths
Where continent is not null    ------common in every query line
Group by location,population
order by Percentofpopulationinfected desc


 --showing countries with highest death count per populatoin
 
select location, max(cast(total_deaths as int))  as TotalDeathCount
 from CovidDeaths
 Where continent is not null    ------common in every query line
Group by location
order by TotalDeathCount desc


select location, max(cast(total_deaths as int))  as TotalDeathCount
 from CovidDeaths
 Where continent is null    ------same as above query but the difference is 'IS NULL'
Group by location
order by TotalDeathCount desc


--let's break things down by continent (NoT NULL)

select continent, max(cast(total_deaths as int))  as TotalDeathCount
 from CovidDeaths
 Where continent is not null    
Group by continent
order by TotalDeathCount desc


--let's break things down by continent ( NULL)

select continent, max(cast(total_deaths as int))  as TotalDeathCount
 from CovidDeaths
 Where continent is null    
Group by continent
order by TotalDeathCount desc


--Showing continents with the highest death count per population

select continent, max(cast(total_deaths as int))  as TotalDeathCount
 from CovidDeaths
 Where continent is  not null    
Group by continent
order by TotalDeathCount desc


----Global Nnumbers

select Sum(new_cases) as total_cases, SUM(cast(new_deaths as int )) as total_deaths,
sum(cast(new_deaths as int )) / Sum(new_cases) * 100 as deathpercentage
from CovidDeaths
--where location like '%states%'
Where continent is not null
order by 1,2


--looking at total polulation vs total vaccination

select A.continent, A.location, A.date, A.population, A.new_vaccinations
, SUM(cast(A.new_vaccinations as int)) over (partition by A.location order by A.location, A.date) as rollingpeoplevaccinated
, (rollingpeoplevaccinated/population) *100
from CovidDeaths as A
join
 CovidVaccinations As B
 on  A.location = B.location
 and A.date = B.date    
 Where A.continent is not null
order by 2,3


---USE CTE


with PopulationVSvaccination (continent, location, date,population,new_vaccinations , rollingpeoplevaccinated)
as
(
select A.continent, A.location, A.date, A.population, A.new_vaccinations
, SUM(cast(A.new_vaccinations as int)) over (partition by A.location order by A.location, A.date) as rollingpeoplevaccinated
--- (rollingpeoplevaccinated/population) *100
from CovidDeaths as A
join
 CovidVaccinations As B
 on  A.location = B.location
 and A.date = B.date
 Where A.continent is not null
 )
 select * , (rollingpeoplevaccinated/population)
 from PopulationVSvaccination


 --Temp table

	create table #percentpopulationVaccinated
 (
 continent varchar(500),
 location varchar(500),
 date datetime,
 population numeric,
 New_population numeric,
 rollingpeoplevaccinated numeric
 )


 insert into #percentpopulationVaccinated
 

select A.continent, A.location, A.date, A.population, A.new_vaccinations
, SUM(cast(A.new_vaccinations as int)) over (partition by A.location order by A.location, A.date) as rollingpeoplevaccinated
--- (rollingpeoplevaccinated/population) *100
from CovidDeaths as A
join
 CovidVaccinations As B
 on  A.location = B.location
 and A.date = B.date
 --Where A.continent is not null
 
 select * , (rollingpeoplevaccinated/population)
 from #percentpopulationVaccinated


 --creating view to store data for later visualizaion

 create View  percentpopulationVaccinated as

 select A.continent, A.location, A.date, A.population, A.new_vaccinations
, SUM(cast(A.new_vaccinations as int)) over (partition by A.location order by A.location, A.date) as rollingpeoplevaccinated
--- (rollingpeoplevaccinated/population) *100
from CovidDeaths as A
join
 CovidVaccinations As B
 on  A.location = B.location
 and A.date = B.date
 Where A.continent is not null

 select *
 from percentpopulationVaccinated

 ==============================================================
 =========================================
 ===============
