SELECT  
    bowlername AS BowlerName,  
    CONCAT(ROUND(SUM(`0s`) / SUM(total_balls) * 100, 2), '%') AS Dotballs_per  
FROM fact_bowling_summary  b
join dim_match_summary m
on b.match_id = m.match_id
GROUP BY bowlername
HAVING SUM(CASE WHEN m.Year = 2021 THEN b.total_balls ELSE 0 END)>=60
AND    SUM(CASE WHEN m.Year = 2022 THEN b.total_balls ELSE 0 END)>=60
AND    SUM(CASE WHEN m.Year = 2023 THEN b.total_balls ELSE 0 END)>=60
ORDER BY Dotballs_per DESC  
LIMIT 5;