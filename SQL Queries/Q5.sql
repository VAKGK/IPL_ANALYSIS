-- Top 10 bowlers based on past 3 years bowling average. (min 60 balls bowled in each season) 
WITH BowlingAvg AS
(
SELECT
        b.bowlername   AS Bowler_Name,
        Sum(b.Wickets) AS Total_Wickets,
        Sum(b.runs)    AS Total_Runs
FROM fact_bowling_summary b 
JOIN dim_match_summary m
ON b.match_id = m.match_id
WHERE m.Year IN (2021,2022,2023)
GROUP BY bowlername
HAVING 
	   SUM(CASE when m.Year = 2021 THEN b.total_balls ELSE 0 END)>=60
AND    SUM(CASE when m.Year = 2022 THEN b.total_balls ELSE 0 END)>=60
AND    SUM(CASE when m.Year = 2023 THEN b.total_balls ELSE 0 END)>=60		
)
SELECT a.Bowler_Name,ROUND((SUM(a.total_runs) / SUM(a.total_wickets)), 2) AS Bowling_Average FROM BowlingAvg a
GROUP BY a.Bowler_Name
ORDER BY Bowling_Average ASC
LIMIT 10
