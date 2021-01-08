WITH table1 AS (SELECT event_name,COUNT(*) AS 'Count' FROM yammer_project.yammer_events
WHERE event_name LIKE "%search_click%"
GROUP BY 1
ORDER BY 2 DESC),

table2 AS (SELECT event_name, Count,
      NTILE(3) OVER (
      ORDER BY Count DESC
      ) AS 'Result_Top_433'
FROM table1)

SELECT Result_Top_433, SUM(Count) 
FROM table2
GROUP BY 1;