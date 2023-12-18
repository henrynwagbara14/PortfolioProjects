-- page 2 visualisation
-- See what data is available

Select * 
From [Salary and HR]..['IBM HR Analytics$']

-- Environment satisfaction vs monthly income

Use [Salary and HR]
Select EnvironmentSatisfaction, AVG(MonthlyIncome) AS AvgMonthlyIncome
Into EnvironmentSatisfaction
From [Salary and HR]..['IBM HR Analytics$']
Group BY EnvironmentSatisfaction
Order by EnvironmentSatisfaction asc

Select EnvironmentSatisfaction, MonthlyIncome 
From [Salary and HR]..['IBM HR Analytics$']
Order by EnvironmentSatisfaction


-- Job involvement vs monthly income

Use [Salary and HR]
Select JobInvolvement, AVG(MonthlyIncome) AS AvgMonthlyIncome
Into JobInvolvement
From [Salary and HR]..['IBM HR Analytics$']
Group BY JobInvolvement
Order by JobInvolvement asc



-- Job satisfaction vs montlhy income

Use [Salary and HR]
Select JobSatisfaction, AVG(MonthlyIncome) AS AvgMonthlyIncome
Into JobSatisfaction
From [Salary and HR]..['IBM HR Analytics$']
Group BY JobSatisfaction
Order by JobSatisfaction asc


-- Relationship satisfaction vs montlhy income

Use [Salary and HR]
Select RelationshipSatisfaction, AVG(MonthlyIncome) AS AvgMonthlyIncome
Into RelationshipSatisfaction
From [Salary and HR]..['IBM HR Analytics$']
Group BY RelationshipSatisfaction
Order by RelationshipSatisfaction asc


-- Job level vs monthly income

Use [Salary and HR]
Select JobLevel, AVG(MonthlyIncome) AS AvgMonthlyIncome
Into JobLevel
From [Salary and HR]..['IBM HR Analytics$']
Group BY JobLevel
Order by JobLevel asc

-- Work life balance vs monthly income

Use [Salary and HR]
Select WorkLifeBalance, AVG(MonthlyIncome) AS AvgMonthlyIncome
Into WorkLifeBalance
From [Salary and HR]..['IBM HR Analytics$']
Group BY WorkLifeBalance
Order by WorkLifeBalance asc


-- Education vs montlhy income

Select Education, AVG(MonthlyIncome) AS AvgMonthlyIncome
From [Salary and HR]..['IBM HR Analytics$']
Group BY Education
Order by Education

-- Attrition vs all factors
-- linear regression

Select Attrition, Age, EnvironmentSatisfaction,JobInvolvement,JobSatisfaction,RelationshipSatisfaction,JobLevel,WorkLifeBalance,Education 
From [Salary and HR]..['IBM HR Analytics$']
Where Attrition = 'yes'

-- Adding a new column 'Attrition_Binary' with values 0 and 1 based on 'Attrition' values
ALTER TABLE [Salary and HR]..['IBM HR Analytics$']
ADD Attrition_Binary INT;

-- Update the 'Attrition_Binary' column to convert 'Yes' to 1 and 'No' to 0 so that it can be used for regression analysis

Update [Salary and HR]..['IBM HR Analytics$']
Set Attrition_Binary = Case 
When Attrition = 'Yes' Then 1
When Attrition = 'No' Then 0
Else NULL -- Handle other cases as needed
End

-- table for attriton

--Use [Salary and HR]
Select Attrition_Binary, Attrition, Age, EnvironmentSatisfaction,JobInvolvement,JobSatisfaction,RelationshipSatisfaction,JobLevel,WorkLifeBalance,Education 
--Into Attrition
From [Salary and HR]..['IBM HR Analytics$']
Where Attrition = 'Yes'

Use [Salary and HR]
Select Attrition_Binary, Attrition, Age, EnvironmentSatisfaction,JobInvolvement,JobSatisfaction,RelationshipSatisfaction,JobLevel,WorkLifeBalance,Education 
Into AttritionAll
From [Salary and HR]..['IBM HR Analytics$']


-- Average ages

Use [Salary and HR]
Select AVG(Age) AS [Average age]
Into [Average Age Survey]
From [Salary and HR]..['IBM HR Analytics$']

Use [Salary and HR]
Select AVG(Age) AS [Average age]
Into [Average Age Attrition]
From [Salary and HR]..['IBM HR Analytics$']
Where Attrition = 'yes'

