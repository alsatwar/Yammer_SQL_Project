WITH after1 AS (SELECT action, 
       COUNT(DISTINCT user_id) AS 'AFTER 3rd Aug' 
FROM yammer_project.yammer_emails
WHERE DATE(occurred_at) > '2014-08-03'
GROUP BY 1
ORDER BY 2 DESC),
before1 AS (
       SELECT action, 
       COUNT(DISTINCT user_id) AS '7th July - 3rd August' 
       FROM yammer_project.yammer_emails
       WHERE DATE(occurred_at) BETWEEN '2014-07-06' AND '2014-08-03'
       GROUP BY 1
       ORDER BY 2 DESC
)

SELECT a.action,
       b.BEFORE,
              a.AFTER
FROM after1 a
INNER JOIN before1 b
ON a.action = b.action;