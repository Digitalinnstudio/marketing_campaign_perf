#arketing Campaign Performance Analysis (BigQuery + SQL)

Project Overview
This project analyzes digital marketing campaign performance using BigQuery and advanced SQL techniques. It focuses on key metrics like CTR, CPC, and ROI, and provides insights into campaign effectiveness across platforms, regions, and time periods.

Schema
Campaign_Name (STRING)
Platform (STRING)
Date (DATE)
Impressions (INTEGER)
Clicks (INTEGER)
CTR (FLOAT)
Conversions (INTEGER)
Conversion_Rate (FLOAT)
Cost_INR (INTEGER)
Revenue_INR (INTEGER)
ROI (FLOAT)

Objectives

Calculate CTR, CPC, and ROI for each campaign.
Compare campaign performance by platform and region.
Segment campaigns based on performance using CASE statements.
Perform time-based analysis (e.g., last 30 days).
Rank campaigns by ROI using window functions.

Key SQL Features Demonstrated

Aggregations: SUM, AVG, SAFE_DIVIDE for accurate metrics.
Window Functions: RANK() for ROI ranking.
CASE Statements: Campaign segmentation by CTR.
Date Functions: Time-based filtering for trend analysis.
CTEs: For clean and modular query design.
