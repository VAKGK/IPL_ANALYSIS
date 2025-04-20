-- Top 10 bowlers based on past 3 years total wickets taken
SELECT bowlername as Bowler_Name,sum(wickets) AS Total_wickets FROM fact_bowling_summary
	GROUP BY bowlername
	ORDER BY Total_wickets DESC
	LIMIT 10;