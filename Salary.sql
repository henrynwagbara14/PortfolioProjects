-- Page 1 visualisation
-- Select all data to see what is available

Select * 
From [Salary and HR]..Salary_Data$

-- Age vs Salary

Use [Salary and HR]
Select Age, AVG(Salary) as AvgSalaryAge	
Into AgeVsSalary
From [Salary and HR]..Salary_Data$
Group by Age
Order by Age Asc


-- Male and Female Salary Comparison

Use [Salary and HR]
Select Age, Gender, AVG(Salary) as AvgSalaryAge	
Into GenderVsSalary
From [Salary and HR]..Salary_Data$
Group by Age, Gender
Order by Age Asc

Select Age, Gender, AVG(Salary) as AvgSalaryAge		
From [Salary and HR]..Salary_Data$
Where Gender = 'Male'
Group by Age, Gender
Order by Age Asc

Select Age, Gender, AVG(Salary) as AvgSalaryAge		
From [Salary and HR]..Salary_Data$
Where Gender = 'Female'
Group by Age, Gender
Order by Age Asc

-- Average Salary by gender 

Use [Salary and HR]
Select Gender, Avg(Salary) as AvgSalary
Into AvgSalary
From [Salary and HR]..Salary_Data$
Group by Gender

Use [Salary and HR]
Select Avg(Salary) as AvgSalaryMale
Into AvgSalaryMale
From [Salary and HR]..Salary_Data$
Where Gender = 'Male'

Use [Salary and HR]
Select Avg(Salary) as AvgSalaryFemale
Into AvgSalaryFemale
From [Salary and HR]..Salary_Data$
Where Gender = 'Female'

-- Salary vs years of experience 

Use [Salary and HR]
Select [Years of Experience], Avg(Salary) as AvgSalaryExp
Into SalaryVsExp
From [Salary and HR]..Salary_Data$
Group by [Years of Experience]
Order by [Years of Experience] Asc

-- Avergage Salary by country 

Use [Salary and HR]
Select Country, AVG(Salary) AS AvgSalaryCountry
Into SalaryVsCountry
From [Salary and HR]..Salary_Data$
Group BY Country
Order by AvgSalaryCountry


-- Salary vs Education level

Use [Salary and HR]
Select [Education Level], Avg(Salary) As AvgSalaryEducation
Into SalaryVsEducation
From [Salary and HR]..Salary_Data$
Group by [Education Level]
Order by [Education Level]

-- What are the top 50 highest paid jobs of this dataset?

Use [Salary and HR]
Select Top 50 [Job Title], MAX(Salary) AS MaxSalary
Into Top50
From [Salary and HR]..Salary_Data$
Group By [Job Title]
Order by MaxSalary Desc

-- Senior vs Non Senior

Use [Salary and HR]
Select Senior, AVG(Salary) AS AvgSalarySenior
Into SeniorVsNonSenior
From [Salary and HR]..Salary_Data$
Group BY Senior
Order by AvgSalarySenior Desc

-- Race vs Salary

Use [Salary and HR]
Select Race, AVG(Salary) AS AvgSalaryRace
Into SalaryVsRace
From [Salary and HR]..Salary_Data$
Group BY Race
Order by AvgSalaryRace Desc