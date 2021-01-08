WITH table1 AS (SELECT ex.user_id, ex.occurred_at, ex.experiment_group,
       u.activated_at, COUNT(DISTINCT DATE(e.occurred_at)) metric
       FROM yammer_project.yammer_experiments2 ex
JOIN yammer_project.yammer_users u
ON ex.user_id = u.user_id
JOIN yammer_project.yammer_events2 e
ON e.user_id = ex.user_id
WHERE event_name = 'login' AND
e.occurred_at >= ex.occurred_at AND
DATE(e.occurred_at) < '2014-07-01'
GROUP BY 1,2,3,4
ORDER BY user_id),

table2 AS (SELECT experiment_group,
       COUNT(DISTINCT user_id) AS 'Users',
       AVG(metric) AS 'Avg_logins',
       SUM(metric) AS 'Total_logins',
       STDDEV(metric) AS 'StdDev1',
       VARIANCE(metric) AS 'Var'
       FROM table1
GROUP BY 1),

table3 AS (SELECT *,
       MAX(CASE WHEN experiment_group = 'control_group' THEN Users ELSE NULL END) OVER() AS 'Control_Users',
       MIN(CASE WHEN experiment_group = 'control_group' THEN Avg_logins ELSE NULL END) OVER() AS 'Avg_Control_Logins',
       MAX(CASE WHEN experiment_group = 'control_group' THEN Total_logins ELSE NULL END) OVER() AS 'Total_Control_Logins',
       MAX(CASE WHEN experiment_group = 'control_group' THEN StdDev1 ELSE NULL END) OVER() AS 'Control_Std_Dev',
       MAX(CASE WHEN experiment_group = 'control_group' THEN Var ELSE NULL END) OVER() AS 'Control_Variance'
FROM table2)

SELECT experiment_group,
       Users,
       SUM(Users) OVER() AS 'Total_Users',
       Total_logins,
       Avg_logins,
       ROUND(Avg_logins - Avg_Control_Logins,4) AS 'Rate_Difference',
       ROUND(((Avg_logins - Avg_Control_Logins)/Avg_Control_Logins),4) AS 'Rate_Lift',
       ROUND(StdDev1,4) AS 'stdev',
       ROUND((Avg_logins - Avg_Control_Logins)/SQRT(Var/Users),4) AS 't2_stat',
       (1 - COALESCE(nd.value,1))*2 AS p_value
FROM table3
LEFT JOIN yammer_project.z_p_values nd
ON nd.score =ABS(ROUND((Avg_logins - Avg_Control_Logins)/SQRT((Var/Users)),3)) 