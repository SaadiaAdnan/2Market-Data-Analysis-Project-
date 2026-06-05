/* Create Table for marketing_data 
*/

CREATE TABLE marketing_data (
    ID INT,
    Year_Birth INT,
    Education VARCHAR(50),
    Marital_Status VARCHAR(50),
    Income INT,
    Kidhome INT,
    Teenhome INT,
    Dt_Customer DATE,
    Recency INT,
    AmtLiq INT,
    AmtVege INT,
    AmtNonVeg INT,
    AmtPes INT,
    AmtChocolates INT,
    AmtComm INT,
    NumDeals INT,
    NumWebBuy INT,
    NumWalkinPur INT,
    NumVisits INT,
    Response INT,
    Complain INT,
    Country VARCHAR(20),
    Count_success INT,
    Age INT
);

ALTER TABLE marketing_data
ADD PRIMARY KEY (ID);

DELETE FROM marketing_data WHERE ID IS NULL;
ALTER TABLE marketing_data ADD PRIMARY KEY (ID);

SELECT COUNT(*) FROM marketing_data;

SELECT * FROM marketing_data LIMIT 10;

/* Create table for ad_data*/

DROP TABLE IF EXISTS ad_data;

CREATE TABLE ad_data (
    ID INT,
    Bulkmail_ad INT,
    Twitter_ad INT,
    Instagram_ad INT,
    Facebook_ad INT,
    Brochure_ad INT
);

SELECT * FROM ad_data LIMIT 10;

/* Join the TWO Tables*/

DROP TABLE IF EXISTS marketing_full;

CREATE TABLE marketing_full AS
SELECT 
    m.*,
    a.Bulkmail_ad,
    a.Twitter_ad,
    a.Instagram_ad,
    a.Facebook_ad,
    a.Brochure_ad
FROM marketing_data m
LEFT JOIN ad_data a
ON m.ID = a.ID;

SELECT COUNT(*) FROM marketing_full;

/* Platform effectiveness per country
*/
SELECT
    Country,
    'Twitter' AS Platform,
    SUM(Twitter_ad) AS Total_Exposure
FROM marketing_full
GROUP BY Country
UNION ALL
SELECT 
    Country,
    'Instagram',
    SUM(Instagram_ad)
FROM marketing_full
GROUP BY Country
UNION ALL
SELECT 
    Country,
    'Facebook',
    SUM(Facebook_ad)
FROM marketing_full
GROUP BY Country
ORDER BY Country, Total_Exposure DESC;

/* Platform effectiveness per marital status */

SELECT
    Marital_Status,
    'Twitter' AS Platform,
    SUM(Twitter_ad) AS Total_Exposure
FROM marketing_full
GROUP BY Marital_Status

UNION ALL

SELECT 
    Marital_Status,
    'Instagram',
    SUM(Instagram_ad)
FROM marketing_full
GROUP BY Marital_Status
UNION ALL
SELECT 
    Marital_Status,
    'Facebook',
    SUM(Facebook_ad)
FROM marketing_full
GROUP BY Marital_Status
ORDER BY Marital_Status, Total_Exposure DESC;

/* Platform effectiveness vs spending per country
*/

SELECT
    Country,
    SUM(AmtLiq + AmtVege + AmtNonVeg + AmtPes + AmtChocolates + AmtComm) AS Total_Spent,
    SUM(Twitter_ad) AS Twitter_Total,
    SUM(Instagram_ad) AS Instagram_Total,
    SUM(Facebook_ad) AS Facebook_Total
FROM marketing_full
GROUP BY Country
ORDER BY Total_Spent DESC;

