WITH session1 AS (SELECT ROW_NUMBER() OVER(
              ORDER BY session_start     
) AS "row_num1",
session_start, session_end 
FROM yammer_project.session_periods),

table_1 AS (SELECT row_num1, ev.user_id, ev.occurred_at, 
       sess.session_start, sess.session_end	
FROM yammer_project.yammer_events2 ev
JOIN session1 sess
ON CONCAT(DATE(ev.occurred_at),' ',HOUR(ev.occurred_at)) = CONCAT(DATE(sess.session_start),' ',HOUR(sess.session_start)) 
WHERE event_name = 'search_run'
ORDER BY user_id,occurred_at),

table2 AS (SELECT row_num1, occurred_at, session_start, session_end,
       CASE 
       WHEN occurred_at BETWEEN session_start AND session_end
       THEN 1
       ELSE 0
       END AS 'search_run_value'
       FROM table_1
       ORDER BY row_num1),

table3 AS (
   SELECT row_num1, SUM(search_run_value) AS 'search_runs'
   FROM table2
   GROUP BY 1
   ORDER BY 2 DESC)

SELECT search_runs,COUNT(*) FROM 
table3
GROUP BY 1
ORDER BY 1 ASC;
 