--Total players who won a medal
SELECT *
FROM PLAYERS;

-- this is a countinous list of countries with their respective Gold, bronze, silver and total medal counts
WITH countrymedal AS (SELECT DISTINCT team, sport, event, medal, continent
FROM PLAYERS)

SELECT DISTINCT team, COUNT(medal) AS Bronze
FROM countrymedal
WHERE medal = 'G'
GROUP BY team
ORDER BY BRONZE DESC;


SELECT DISTINCT team, COUNT(medal) AS Silver
FROM countrymedal
WHERE medal = 'S'
GROUP BY team
ORDER BY Silver DESC;

SELECT DISTINCT team, COUNT(medal) AS Gold
FROM countrymedal
WHERE medal = 'G'
GROUP BY team
ORDER BY Gold DESC;


SELECT DISTINCT team, COUNT(medal) AS totalmedals
FROM countrymedal
GROUP BY team
ORDER BY totalmedals DESC

--medals won based on continent
WITH countrymedal AS (SELECT DISTINCT team, sport, event, medal, continent
FROM PLAYERS)
SELECT continent, COUNT(medal) AS total
FROM countrymedal
GROUP BY Continent
ORDER BY total DESC

WITH countrymedal AS (SELECT DISTINCT team, sport, event, medal, continent
FROM PLAYERS)
SELECT team, sport, event,
 medal, continent, ROW_NUMBER() OVER(PARTITION BY sport, event ORDER BY medal ASC) AS row_num
FROM countrymedal
ORDER BY sport ASC, event ASC, medal ASC;


SELECT sport, COALESCE(event, 'total') AS event, COUNT(medal) as awards
FROM players
WHERE team = 'Nigeria'
GROUP BY sport,ROLLUP (event)
ORDER BY sport ASC, event ASC;

SELECT sport,event, awards, RANK() OVER(ORDER BY awards DESC) AS rank
FROM (SELECT sport, COALESCE(event, 'total') AS event, COUNT(medal) as awards
FROM players
WHERE team = 'Nigeria'
GROUP BY sport,ROLLUP (event)) AS t
WHERE event = 'total'
order by awards DESC;

--ratio of participants
SELECT male_participant
FROM (SELECT DISTINCT Sport, COUNT(gender) AS male_participant
FROM PARTICIPANTS
WHERE gender = 'Male'
GROUP BY sport
ORDER BY male_participant

SELECT DISTINCT Sport, COUNT(gender) AS Female_participant
FROM PARTICIPANTS
WHERE gender = 'Female'
GROUP BY sport
ORDER BY female_participant

SELECT DISTINCT sport,  