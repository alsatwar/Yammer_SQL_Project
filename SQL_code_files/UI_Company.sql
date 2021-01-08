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
        END AS 'device_type',
        CASE 
       WHEN  device  IN ('acer aspire desktop','acer aspire notebook')
			THEN 'acer'
	   WHEN device IN ('amazon fire phone' ,'kindle fire')
			THEN 'amazon'
	   WHEN device IN ('ipad air','ipad mini','iphone 4s','iphone 5','iphone 5s',
                       'mac mini','macbook air','macbook pro','nexus 7')
			THEN 'apple'
	   WHEN device = 'asus chromebook' 
			THEN 'asus'
	   WHEN device IN ('dell inspiron desktop', 'dell inspiron notebook')
			THEN 'dell'
	   WHEN device = 'hp pavilion desktop'
			THEN 'hp'
	   WHEN device = 'htc one'
			THEN 'htc'
	   WHEN device = 'lenovo thinkpad'
			THEN 'lenovo'
	   WHEN device = 'windows surface'
			THEN 'microsoft'
	   WHEN device IN ('nexus 5', 'nexus 10')
			THEN 'nexus'
		WHEN device = 'nokia lumia 635'
			THEN 'nokia'
		WHEN device IN ('samsumg galaxy tablet','samsung galaxy note','samsung galaxy s4')
			THEN 'samsung'
        ELSE 'Others'
        END AS 'device_company'
        
FROM yammer_project.yammer_events)

SELECT device_company, COUNT(DISTINCT user_id) AS 'After 3rd Aug' FROM ui_table
WHERE event_type = 'engagement' AND
      date(occurred_at) > '2014-08-03'
GROUP BY device_company
ORDER BY 2 DESC;