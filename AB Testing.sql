WITH ex AS (SELECT user_id,
	   experiment,
	   experiment_group,
	   occurred_at
FROM yammer_project.yammer_experiments2
WHERE experiment = 'publisher_update'),

a AS (
SELECT ex.experiment,
       ex.experiment_group,
       ex.occurred_at AS treatment_start,
       u.user_id,
       u.activated_at,
       COUNT(CASE WHEN e.event_name = 'send_message' THEN e.user_id ELSE NULL END) AS metric
       FROM ex
JOIN yammer_project.yammer_users u
    ON u.user_id = ex.user_id
  JOIN yammer_project.yammer_events2 e
    ON e.user_id = ex.user_id
   AND e.occurred_at >= ex.occurred_at
   AND e.occurred_at < '2014-07-01'
   AND e.event_type = 'engagement'
   GROUP BY 1,2,3,4,5
),

b AS (
SELECT a.experiment,
       a.experiment_group,
       COUNT(a.user_id) AS users,
       AVG(a.metric) AS average,
       SUM(a.metric) AS total,
       STDDEV(a.metric) AS stdev,
       VARIANCE(a.metric) AS variance
       FROM a
GROUP BY 1,2
),

c AS (
SELECT *,
       MAX(CASE WHEN b.experiment_group = 'control_group' THEN b.users ELSE NULL END) OVER () AS control_users,
       MAX(CASE WHEN b.experiment_group = 'control_group' THEN b.average ELSE NULL END) OVER () AS control_average,
       MAX(CASE WHEN b.experiment_group = 'control_group' THEN b.total ELSE NULL END) OVER () AS control_total,
       MAX(CASE WHEN b.experiment_group = 'control_group' THEN b.variance ELSE NULL END) OVER () AS control_variance,
       MAX(CASE WHEN b.experiment_group = 'control_group' THEN b.stdev ELSE NULL END) OVER () AS control_stdev,
       SUM(b.users) OVER () AS total_treated_users
       FROM b
)

SELECT c.experiment,
       c.experiment_group,
       c.users,
       c.total_treated_users,
       ROUND(c.users/c.total_treated_users,4) AS treatment_percent,
       c.total,
       ROUND(c.average,4) AS average,
       ROUND(c.average - c.control_average,4) AS rate_difference,
       ROUND((c.average - c.control_average)/c.control_average,4) AS rate_lift,
       ROUND(c.stdev,4) AS stdev,
       ROUND((c.average - c.control_average) /
          SQRT((c.variance/c.users) + (c.control_variance/c.control_users))
        ,4) AS t_stat,
       (1 - COALESCE(nd.value,1))*2 AS p_value
  FROM c
  LEFT JOIN yammer_project.z_p_values nd
    ON nd.score = ABS(ROUND((c.average - c.control_average)/SQRT((c.variance/c.users) + (c.control_variance/c.control_users)),3))
  
