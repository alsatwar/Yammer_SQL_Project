SELECT device, COUNT(DISTINCT user_id) AS 'After 3rd Aug' FROM yammer_project.yammer_events
WHERE event_type = 'engagement' AND
      date(occurred_at) >= '2014-08-03'
GROUP BY device
ORDER BY 2 DESC;