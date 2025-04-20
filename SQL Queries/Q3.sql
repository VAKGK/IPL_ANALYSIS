-- Top 10 batsmen based on past 3 years strike rate (min 60 balls faced in each season)
WITH strikerate AS (  
    SELECT  
        b.batsmanname,
        SUM(b.runs) AS total_runs,  
        SUM(b.balls) AS total_balls  
    FROM fact_bating_summary b  
    JOIN dim_match_summary m ON b.match_id = m.match_id  
    WHERE m.Year IN (2021, 2022, 2023)  
    GROUP BY b.batsmanname  
    having 
            SUM(CASE WHEN m.Year = 2021 THEN b.balls ELSE 0 END)>=60  
       and  SUM(CASE WHEN m.Year = 2022 THEN b.balls ELSE 0 END)>=60  
       and  SUM(CASE WHEN m.Year = 2023 THEN b.balls ELSE 0 END)>=60     
)  
SELECT  
    s.batsmanname,  
    ROUND((SUM(s.total_runs) / SUM(s.total_balls)) * 100, 2) AS Strike_Rate  
FROM strikerate s 
Group by s.batsmanname 
ORDER BY Strike_Rate DESC  
LIMIT 10;
