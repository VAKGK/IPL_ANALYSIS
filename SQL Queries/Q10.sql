-- .Top 2 teams with the highest number of wins achieved by chasing targets over the past 3 years.
WITH chasing_wins AS (
    SELECT 
        winner AS Team,
        COUNT(match_id) AS Chasing_Wins
    FROM dim_match_summary
    WHERE margin LIKE '%wickets' 
    GROUP BY winner
)
SELECT 
    Team,
    Chasing_Wins
FROM chasing_wins
ORDER BY Chasing_Wins DESC 
LIMIT 2; 
