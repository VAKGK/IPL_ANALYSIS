-- Top 10 batsmen based on past 3 years batting average. (min 60 balls faced in each season)

WITH BattingAverage AS (  
    SELECT  
        b.batsmanname,
        SUM(b.runs) AS total_runs,  
        SUM(b.O_N) AS total_Outs  
    FROM fact_bating_summary b  
    JOIN dim_match_summary m ON b.match_id = m.match_id  
    WHERE m.Year IN (2021, 2022, 2023)  
    GROUP BY b.batsmanname  
    HAVING 
            SUM(CASE WHEN m.Year = 2021 THEN b.balls ELSE 0 END)>=60  
       AND  SUM(CASE WHEN m.Year = 2022 THEN b.balls ELSE 0 END)>=60  
       AND  SUM(CASE WHEN m.Year = 2023 THEN b.balls ELSE 0 END)>=60     
)  
SELECT  
    a.batsmanname,  
    ROUND(SUM(a.total_runs) / NULLIF(SUM(a.total_Outs), 0), 2)AS Batting_Average  
FROM BattingAverage a
GROUP BY a.batsmanname 
ORDER BY Batting_Average DESC 
LIMIT 10;
