with cte1 as
(SELECT b.batsmanname,sum(b.runs) as Total_Runs,(sum(b.4s)*4 + sum(b.6s)*6) as Boundries_runs FROM fact_bating_summary b
join dim_match_summary m
on b.match_id = m.match_id
group by b.batsmanname
HAVING SUM(CASE WHEN m.Year = 2021 THEN b.balls ELSE 0 END)>=60
AND    SUM(CASE WHEN m.Year = 2022 THEN b.balls ELSE 0 END)>=60
AND    SUM(CASE WHEN m.Year = 2023 THEN b.balls ELSE 0 END)>=60
)
select c.batsmanname,concat(round(c.boundries_runs/c.Total_runs*100,2),'%')as Boundary_per from cte1 c
group by c.batsmanname
order by Boundary_per desc
limit 5