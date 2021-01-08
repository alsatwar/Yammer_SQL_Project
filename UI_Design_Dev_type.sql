WITH ui_table AS (SELECT user_id,
       occurred_at,
       event_type,
       device,
       CASE 
       WHEN  device  IN ('ipad air' , 'nexus 7' , 'ipad mini' , 
					   'nexus 10' , 'kindle fire' , 'samsumg galaxy tablet')
			THEN 'tablet'
	   WHEN device IN ('iphone 5' , 'samsung galaxy s4' , 'nexus 5' , 
                     'iphone 5s' , 'iphone 4s' , 'nokia lumia 635' , 
					 'htc one' , 'amazon fire phone' , 'samsung galaxy note')
			THEN 'mobile'
	   WHEN device IN ('macbook pro' , 'lenovo thinkpad' , 'macbook air',
                     'dell inspiron notebook' , 'acer aspire notebook' , 'asus chromebook' ,
                     'dell inspiron desktop' , 'hp pavilion desktop' , 'acer aspire desktop' ,
					 'mac mini' , 'windows surface')
			THEN 'desktop'
		ELSE 'Others'
        END AS 'device_type'
FROM yammer_project.yammer_events)

SELECT device_type, COUNT(DISTINCT user_id) AS 'Between Jun 29 to July 27' 
FROM ui_table
WHERE event_type = 'engagement' AND
      date(occurred_at) BETWEEN '2014-06-08' AND '2014-07-06'
GROUP BY device_type
ORDER BY 2 DESC;
