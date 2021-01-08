WITH table1 AS (SELECT * FROM yammer_project.yammer_events2
WHERE occurred_at BETWEEN '2014-06-01 00:00:00' AND '2014-06-30 23:59:59'
AND event_name = 'send_message'
ORDER BY user_id),

table2 AS (SELECT * FROM yammer_project.yammer_experiments2
ORDER BY user_id),

table3 AS (SELECT t1.user_id, t1.event_name, t1.occurred_at occurred_mess, 
                  t2.occurred_at occurred_time, t2.experiment_group
FROM table1 t1
JOIN table2 t2
ON t1.user_id = t2.user_id
WHERE t1.occurred_at >= t2.occurred_at
ORDER BY t1.user_id)

SELECT experiment_group, COUNT(*) FROM table3
GROUP BY 1;