WITH table1 AS (SELECT y.user_id,
       y.event_type,
       y.occurred_at,
	   y.event_name,
	   y.location,
       u.language,
       u.company_id
FROM yammer_project.yammer_events y
LEFT JOIN yammer_project.yammer_users u
ON y.user_id = u.user_id),

before1 AS (
	SELECT company_id, 
	COUNT(DISTINCT user_id) AS 'count_of_users_before'
FROM table1
WHERE DATE(occurred_at) BETWEEN '2014-07-06' AND '2014-08-03'
GROUP BY company_id
ORDER BY 2 DESC),

after1 AS (
               SELECT company_id, 
			   COUNT(DISTINCT user_id) AS 'count_of_users_after'
               FROM table1
WHERE DATE(occurred_at) > '2014-08-03'
GROUP BY company_id
ORDER BY 2 DESC)


SELECT b.company_id,
       b.count_of_users_before,
	   a.count_of_users_after,
       (b.count_of_users_before - a.count_of_users_after) AS 'change_in_users'
	   FROM before1 b
INNER JOIN after1 a
ON b.company_id = a.company_id 
ORDER BY 3 DESC