WITH table1 AS (SELECT row_number() OVER ( PARTITION BY user_id 
						   ORDER BY user_id, occurred_at ) Row_Num1,  
       user_id, 
       occurred_at,
       LEAD(occurred_at,1,'2015-06-09 15:00:00') 
       OVER( PARTITION BY user_id ORDER BY occurred_at) next_search_run,
       event_name 
       FROM yammer_project.yammer_events2
WHERE event_name = 'search_run'
ORDER BY user_id),

table2 AS (SELECT * 
           FROM yammer_project.yammer_events2
           WHERE event_name = 'search_autocomplete'
           ORDER BY user_id, occurred_at),

table3 AS (SELECT t1.Row_Num1, t1.user_id, t1.occurred_at AS 'occurred_run', t1.event_name AS 'ev1_name', 
       t2.occurred_at AS 'occurred_autocomplete', t2.event_name AS 'ev2_name'
FROM table1 t1
JOIN table2 t2
ON t1.user_id = t2.user_id
WHERE t1.occurred_at <= t2.occurred_at AND
      t1.next_search_run >= t2.occurred_at
ORDER BY t1.user_id, t1.Row_Num1),

 table4 AS (SELECT Row_Num1, user_id, COUNT(*) AS 'Count'
 FROM table3
 GROUP BY 1,2
 ORDER BY Row_Num1, user_id)
 
 SELECT Row_Num1, COUNT(*) Number_Of_Users
 FROM table4
 GROUP BY 1;