Select *
From Portfolio..CovidDeaths
Where continent is NOT null
order by 3,4

--Select *
--From Portfolio..CovidVaccinations
--order by 3,4

--Select Data that we are going to be using 
Select location, date, population, total_cases, new_cases, total_deaths
From Portfolio..CovidDeaths
Where continent is NOT null
order by 1,2

-- Looking at Total cases VS total Deaths
-- Show likelihood of dying if you contract covid in your country
Select location, date, total_cases,  total_deaths, (total_deaths/total_cases)*100 as DeathsPercentage
From Portfolio..CovidDeaths
Where location like '%states%'
and Where continent is NOT null
order by 1,2


--Looking at Total Cases VS Population ****** CHANGE TO UKRAINE
-- Shows that percentage of population got Covid

Select location, date, population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From Portfolio..CovidDeaths
--Where location like '%states%'
order by 1,2 

-- Looking at Countries with Highest Infection rate compared to population

Select location, population, max(total_cases) as HighestInfectionCount,  max((total_cases/population))*100 as PercentPopulationInfected
From Portfolio..CovidDeaths
--Where location like '%states%'
Group by location, population
order by PercentPopulationInfected desc


--Showing Countries with Highest Death Count per population

Select location, max(cast(total_deaths as int)) as totaldeathCount 
From Portfolio..CovidDeaths
--Where location like '%states%'
Where continent is NOT null
Group by location
order by totaldeathCount desc


-- Let's break things down by continent

Select continent, max(cast(total_deaths as int)) as totaldeathCount 
From Portfolio..CovidDeaths
--Where location like '%states%'
Where continent is not null
Group by continent
order by totaldeathCount desc

-- Showing continents with the Highest Death Count per population

Select continent, max(cast(total_deaths as int)) as totaldeathCount 
From Portfolio..CovidDeaths
--Where location like '%states%'
Where continent is not null
Group by continent
order by totaldeathCount desc



-- GLOBAL NUMBERS

Select   SUM(new_cases) as TOTAL_cases, SUM(cast(new_deaths as int)) as TOTAL_deaths,  SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathsPercentage
From Portfolio..CovidDeaths
--Where location like '%states%'
where continent is NOT null
--Group by date
order by 1,2

--GO TO VACCINATIONS

-- Looking at Total Population VS Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
	SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location Order By dea.location, dea.date) as RollingPeopleVaccinated
--	, (RollingPeopleVaccinated/population)*100
From Portfolio..CovidDeaths as dea
Join Portfolio..CovidVaccinations as vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is NOT null
order by 2, 3


-- USE CTE

With PopVsVac (Continent, location, date, population, new_vaccinations, RollingPeopleVaccinated) 
as (
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
	SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location Order By dea.location, dea.date) as RollingPeopleVaccinated
--	, (RollingPeopleVaccinated/population)*100
From Portfolio..CovidDeaths as dea
Join Portfolio..CovidVaccinations as vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is NOT null
--order by 2, 3
)
Select *, (RollingPeopleVaccinated/population)*100
From PopVsVac


-- TEMP TABLE

DROP table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
dare datetime,
population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)
Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
	SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location Order By dea.location, dea.date) as RollingPeopleVaccinated
--	, (RollingPeopleVaccinated/population)*100
From Portfolio..CovidDeaths as dea
Join Portfolio..CovidVaccinations as vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is NOT null

Select *, (RollingPeopleVaccinated/population)*100
From #PercentPopulationVaccinated


-- Creating View to store data later visualizations

Create View PercentPopulationVaccinated as 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
	SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location Order By dea.location, dea.date) as RollingPeopleVaccinated
--	, (RollingPeopleVaccinated/population)*100
From Portfolio..CovidDeaths as dea
Join Portfolio..CovidVaccinations as vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is NOT null
--order by 2,3


Select *
From PercentPopulationVaccinated