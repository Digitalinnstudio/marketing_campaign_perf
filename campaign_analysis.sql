select * from `marketing.marketing`

-- Baseline Campaign Performance, aggregates performance metrics for each Campaign_Name and Platform and orders by ROI to easily show highest performing campaign
SELECT
  Campaign_Name,
  Platform,
  SUM(Impressions) AS Total_Impressions,
  SUM(Clicks) AS Total_Clicks,
  SAFE_DIVIDE(SUM(Clicks), SUM(Impressions)) AS CTR,
  SUM(Conversions) AS Total_Conversions,
  SAFE_DIVIDE(SUM(Conversions), SUM(Clicks)) AS Conversion_Rate,
  SUM(Cost_INR) AS Total_Cost,
  SUM(Revenue_INR) AS Total_Revenue,
  SAFE_DIVIDE((SUM(Revenue_INR) - SUM(Cost_INR)), SUM(Cost_INR)) AS ROI
FROM `marketing.marketing`
GROUP BY Campaign_Name, Platform
ORDER BY ROI DESC;

-- marketing performance by platform
SELECT
  Platform,
  SUM(Impressions) AS Impressions,
  SUM(Clicks) AS Clicks,
  SAFE_DIVIDE(SUM(Clicks), SUM(Impressions)) AS CTR,
  SUM(Cost_INR) AS Cost,
  SUM(Revenue_INR) AS Revenue,
  SAFE_DIVIDE((SUM(Revenue_INR) - SUM(Cost_INR)), SUM(Cost_INR)) AS ROI
FROM `marketing.marketing`
GROUP BY Platform
ORDER BY ROI DESC;


--categorise campaigns into segments, high or low based on CTR
SELECT
  Campaign_Name,
  CASE
    WHEN SAFE_DIVIDE(SUM(Clicks), SUM(Impressions)) >= 0.05 THEN 'High CTR'
    WHEN SAFE_DIVIDE(SUM(Clicks), SUM(Impressions)) BETWEEN 0.02 AND 0.05 THEN 'Medium CTR'
    ELSE 'Low CTR'
  END AS CTR_Segment,
  SUM(Impressions) AS Impressions,
  SUM(Clicks) AS Clicks
FROM `marketing.marketing`
GROUP BY Campaign_Name;


--time series of campaign engagement 
SELECT
  Campaign_Name,
  DATE(Date) AS Campaign_Date,
  SUM(Impressions) AS Impressions,
  SUM(Clicks) AS Clicks,
  SAFE_DIVIDE(SUM(Clicks), SUM(Impressions)) AS CTR
FROM `marketing.marketing`
WHERE Date BETWEEN DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND CURRENT_DATE()
GROUP BY Campaign_Name, Campaign_Date
ORDER BY Campaign_Date DESC;


-- campaigns ranked by ROI
SELECT
  Campaign_Name,
  SAFE_DIVIDE((SUM(Revenue_INR) - SUM(Cost_INR)), SUM(Cost_INR)) AS ROI,
  RANK() OVER (ORDER BY SAFE_DIVIDE((SUM(Revenue_INR) - SUM(Cost_INR)), SUM(Cost_INR)) DESC) AS ROI_Rank
FROM `marketing.marketing`
GROUP BY Campaign_Name;
