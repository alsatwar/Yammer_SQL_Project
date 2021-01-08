WITH before1 AS (SELECT location, COUNT(DISTINCT user_id) AS 'Count_before'
FROM yammer_project.yammer_events
WHERE DATE(occurred_at) BETWEEN '2014-07-06' AND '2014-08-03'
GROUP BY 1
ORDER BY 2 DESC),

after1 AS ( SELECT location, COUNT(DISTINCT user_id) AS 'Count_after'
FROM yammer_project.yammer_events
WHERE DATE(occurred_at) > '2014-08-03'
GROUP BY 1
ORDER BY 2 DESC
)

SELECT b.location,
       Count_before,
       Count_after,
       ROUND(((Count_after-Count_before)/Count_before)*100.0,3) AS 'Change_in_%' 
FROM before1 b
INNER JOIN after1 a
ON b.location = a.location
WHERE Count_before > 100 
ORDER BY 4 ASC;
       
