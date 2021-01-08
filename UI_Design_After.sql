SELECT device, COUNT(DISTINCT user_id) AS 'Between 6th July and 3rd Aug' FROM yammer_project.yammer_events
WHERE event_type = 'engagement' AND
      date(occurred_at) BETWEEN '2014-07-06' AND '2014-08-03'
GROUP BY device
ORDER BY 2 DESC;