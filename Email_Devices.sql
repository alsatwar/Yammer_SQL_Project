WITH email_table AS (SELECT emails.user_id, events1.occurred_at,
       emails.action, events1.device  
FROM yammer_project.yammer_emails emails
JOIN yammer_project.yammer_events events1
ON emails.occurred_at =  events1.occurred_at
AND emails.user_id = events1.user_id 
ORDER BY emails.user_id),

user_table_before AS (SELECT action, 
					     device, 
					     COUNT(*) AS 'Count'  
						 FROM email_table
WHERE date(occurred_at) BETWEEN '2014-07-06' AND '2014-08-03'
GROUP BY device, action
ORDER BY action),

user_table_after AS (SELECT action, 
					         device, 
					         COUNT(*) AS 'Count'  
							 FROM email_table
WHERE date(occurred_at) > '2014-08-03'
GROUP BY device, action
ORDER BY action)


SELECT b.action, b.device,
       b.Count AS 'Before 3rd August', a.Count AS 'After 3rd August',
       ((a.Count - b.Count)/b.Count)*100 AS 'Change in %'
FROM user_table_before b
INNER JOIN user_table_after a
ON b.action = a.action AND
   b.device = a.device
WHERE b.Count > 10 AND 
      ((a.Count - b.Count)/b.Count)*100 < -10
ORDER BY 5 ASC;