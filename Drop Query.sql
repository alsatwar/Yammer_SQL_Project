SELECT week(occurred_at, 1) AS 'Week', 
	   makedate(2014, week(occurred_at, 1) * 7) AS 'Date', 
       COUNT(DISTINCT user_id) AS 'Number of Users' 
FROM yammer_project.yammer_events
WHERE event_type = 'engagement'
GROUP BY 1;