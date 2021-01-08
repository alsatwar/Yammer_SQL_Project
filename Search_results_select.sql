WITH table1 AS (SELECT ev1.user_id, ev1.event_name, ev2.event_name AS 'ev2_event_name'
       FROM yammer_project.yammer_events ev1
JOIN yammer_project.yammer_events ev2
ON ev1.user_id = ev2.user_id
AND ev1.occurred_at =  ev2.occurred_at
WHERE ev1.event_name LIKE "%search_run%" AND
ev2.event_name LIKE "%search_click_result%")

SELECT ev2_event_name, COUNT(*)
FROM table1
GROUP BY 1
ORDER BY 2 DESC;