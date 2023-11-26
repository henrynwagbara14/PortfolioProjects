-- Select all data to see what is available

Select *
From [College basketball]..['cbb 13-21$']

-- select data that we are using

-- most wins in a season

Select Team, G as Games, W as Wins, G - W as Losses, Year
From [College basketball]..['cbb 13-21$']
where G >30
Group by Year, Team, G, W
Order by 3 DESC

-- new table where I will get data for analysis on POWER BI
-- most wins between all years

USE [College basketball]
Select TOP 100 Team, G as Games, W as Wins, G - W as Losses, Year
INTO CBBMostWins
From [College basketball]..['cbb 13-21$']
Group by Year, Team, G, W

DROP Table CBBMostWins

SELECT * 
From CBBMostWins

-- greatest percentage wins in 2023, top 100 teams


Select TOP 100 Team, G as Games, W as Wins, G - W as Losses, W/G * 100 as Percentage_wins, Year
From [College basketball]..['cbb 13-21$']
where Year = 2023
Group by Year, Team, G, W
Order by 5 DESC, 3

-- new table where I will get data for analysis on POWER BI
-- greatest percentage wins in 2023, top 100 teams

USE [College basketball]
Select TOP 100 Team, G as Games, W as Wins, G - W as Losses, W/G * 100 as Percentage_wins, Year
Into CBBWinPercentage2023
From [College basketball]..['cbb 13-21$']
Where Year = 2023
Group by Year, Team, G, W
Order by 5 DESC, 3

Drop TABLE CBBWinPercentage2023

-- greatest win percentage in a season
-- using where games pleayed is greater than 30 to better validate the data

Select Team, G as Games, W as Wins, G - W as Losses, W/G * 100 as Percentage_wins, Year
From [College basketball]..['cbb 13-21$']
where G >30
Group by Year, Team, G, W
Order by 5 DESC

-- table for analysis

USE [College basketball]
Select Team, G as Games, W as Wins, G - W as Losses, W/G * 100 as Percentage_wins, Year
Into WinPercentageSingleSeason
From [College basketball]..['cbb 13-21$']
where G >30
Group by Year, Team, G, W
Order by 5 DESC

DROP Table WinPercentageSingleSeason

-- what are the main stats that contributed to the highest win percentage?

   -- turnovers and steals

Select Team, G as Games, W as Wins, G - W as Losses, W/G * 100 as Percentage_wins, TOR as turnovers, TORD as steals, Year
From [College basketball]..['cbb 13-21$']
where G >30
Group by Year, Team, G, W, TOR, TORD
Order by 5 DESC


Use [College basketball]
Select Team, G as Games, W as Wins, G - W as Losses, W/G * 100 as Percentage_wins, TOR as turnovers, TORD as steals, Year
Into CBBTurnoversSteals
From [College basketball]..['cbb 13-21$']
where G >30
Group by Year, Team, G, W, TOR, TORD
Order by 5 DESC

Drop Table CBBTurnoversSteals

   -- offensive rebound percentage vs offensive rebound rate percentage allowed 

Select Team, G as Games, W as Wins, G - W as Losses, W/G * 100 as Percentage_wins, ORB as OR_Percentage, DRB ORAllowed_Percentage , Year
From [College basketball]..['cbb 13-21$']
where G >30
Group by Year, Team, G, W, ORB, DRB
Order by 5 DESC 
 
Use [College basketball]
Select Team, G as Games, W as Wins, G - W as Losses, W/G * 100 as Percentage_wins, ORB as OR_Percentage, DRB ORAllowed_Percentage , Year
Into CBBRebounds
From [College basketball]..['cbb 13-21$']
where G >30
Group by Year, Team, G, W, ORB, DRB
Order by 5 DESC 

Drop Table CBBRebounds


   -- 2 point percentage vs 2 point percentage allowed
   -- used brackets as SQL had trouble picking up numeric digits

Select Team, G as Games, W as Wins, G - W as Losses, W/G * 100 as Percentage_wins, [2P_O] as TwoPoint_Percentage, [2P_D] as TwoPointAllowed_Percentage, Year
From [College basketball]..['cbb 13-21$']
where G >30
Group by Year, Team, G, W, [2P_O], [2P_D]
Order by 5 DESC 

-- 3 point percentage vs 3 point percentage allowed

Select Team, G as Games, W as Wins, G - W as Losses, W/G * 100 as Percentage_wins, [3P_O] as ThreePoint_Percentage, [3P_D] as ThreePointAllowed_Percentage, Year
From [College basketball]..['cbb 13-21$']
where G >30
Group by Year, Team, G, W, [3P_O], [3P_D]
Order by 5 DESC 

   -- free throw rate vs three throw rate allowed (how often each team shoots free throws)

Select Team, G as Games, W as Wins, G - W as Losses, W/G * 100 as Percentage_wins, FTR as FreeThrowRate, FTRD as FreeThrowRateAllowed, Year
From [College basketball]..['cbb 13-21$']
where G >30
Group by Year, Team, G, W, FTR, FTRD
Order by 5 DESC 

-- create view for visualisation on POWER BI

Drop view [CBB Free throws]

Create view [CBB Free throws] As
(
Select Team, G, W, G-W as L, W/G*100 as Percentage_wins, FTR, FTRD
From [College basketball]..['cbb 13-21$']
Where G >30
Group by Year, Team, G, W, FTR, FTRD
)

SELECT *
From [CBB Free throws]


-- the number of wins and win percentage can be a great indicator for prospective athletes looking or the best college they can go to for basketball.
-- teams with more rebounds and steals will have a greater win percentage, as these will mean they have more posessions in which they can make baskets.
-- would be better if this dataset included fouls, as this could be a good stat which impacts win percentage.
-- shot attempts (2 and 3 point) would help to explain win percentage too as the percentage isnt enough to make a judgement. teams which have more losses than wins could achieve a higher shooting percentage than winning teams.
-- college basketball may not be representative of all basketball, as there are differences in rules and abilities based on league/country.