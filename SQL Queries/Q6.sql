-- Top 10 bowlers based on past 3 years economy rate. (min 60 balls bowled in each season)
WITH economy AS
(
SELECT
b.bowlername,
SUM(b.runs) AS Total_Runs,
SUM(b.total_balls)/6 AS Total_Over
FROM fact_bowling_summary b
JOIN dim_match_summary m 
ON b.match_id = m.match_id
WHERE  m.Year IN (2021,2022,2023)
GROUP BY b.bowlername
HAVING SUM(CASE WHEN m.Year = 2021 THEN b.total_balls ELSE 0 END)>=60
AND    SUM(CASE WHEN m.Year = 2022 THEN b.total_balls ELSE 0 END)>=60
AND    SUM(CASE WHEN m.Year = 2023 THEN b.total_balls ELSE 0 END)>=60
)
SELECT e.bowlername,ROUND(SUM(total_runs)/SUM(Total_Over),2) AS  Bowler_Economy FROM economy e
GROUP BY e.bowlername
ORDER BY Bowler_Economy ASC
LIMIT 10