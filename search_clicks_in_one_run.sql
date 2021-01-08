WITH table1 AS (SELECT user_id, occurred_at, 
       LEAD(occurred_at,1,'2015-08-31 20:00:00') OVER (
              partition by user_id
              ORDER BY occurred_at,user_id) AS 'next_run_time',  
	   event_name 
FROM yammer_project.yammer_events2
WHERE event_name = "search_run"
ORDER BY occurred_at, user_id),

 table2 AS (
     SELECT * FROM yammer_project.yammer_events2
     WHERE event_name LIKE "%search_click%"
     ORDER BY user_id, occurred_at
 ),
 
table3 AS (SELECT t1.user_id, t1.occurred_at AS 'Occ_At_run', t1.event_name AS 'Event_Name1',
	   t2.occurred_at AS 'Occ_At_Clicks', t2.event_name
FROM table1 t1
JOIN table2 t2
ON t1.user_id = t2.user_id
WHERE t2.occurred_at >= t1.occurred_at AND 
      t2.occurred_at < t1.next_run_time   
ORDER BY t1.occurred_at, t1.user_id),

table4 AS (SELECT Occ_At_run, COUNT(*) AS 'Number_Of_Clicks'
FROM table3
GROUP BY 1
ORDER BY 2 DESC)

SELECT Number_Of_Clicks, COUNT(*)
FROM table4
GROUP BY 1
ORDER BY 1 ASC;