-- Top 10 batsmen based on past 3 years total runs scored.
SELECT 
	BatsmanName AS Batsman_Name,
    SUM(Runs) AS Total_Runs 
FROM Fact_bating_summary 
GROUP BY batsmanname
ORDER BY Total_Runs DESC
LIMIT 10;