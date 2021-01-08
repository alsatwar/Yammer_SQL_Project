WITH table1 AS (SELECT ex.occurred_at, ex.experiment_group, 
       u.activated_at, u.state,
       CASE 
       WHEN ex.occurred_at > (u.activated_at + INTERVAL 1 month)
       THEN 'old_user'
       WHEN ex.occurred_at <= (u.activated_at + INTERVAL 1 month)
       THEN 'new_user'
       ELSE 
       'None'
       END AS 'Age_Of_User'
       FROM yammer_project.yammer_experiments2 ex
JOIN yammer_project.yammer_users2 u
ON ex.user_id = u.user_id)

SELECT experiment_group, Age_Of_User, Count(*) 
FROM table1
GROUP BY 1,2
ORDER BY 2,1;