use code_basic

--1.Who prefers energy drink more? (male/female/non-binary)
WITH CTE AS (
    SELECT 
        CASE WHEN Gender = 'Male' THEN 1 ELSE 0 END AS Total_Male,
        CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END AS Total_Female,
        CASE WHEN Gender = 'Non-binary' THEN 1 ELSE 0 END AS Total_Non_binary
    FROM dim_repondents
)
SELECT 
    SUM(Total_Male) AS Total_Males,
    SUM(Total_Female) AS Total_Females,
    SUM(Total_Non_binary) AS Total_Non_binary
FROM CTE;

--2.Which age group prefers energy drinks more?
select Age, count(*) as Age_Prefrences
from dim_repondents
group by Age
order by Age_Prefrences desc;

--3.What are the preferred ingredients of energy drinks among respondents?
select Ingredients_expected as Ingredients, count(*) as Total_ingredients_preferred
from fact_survey_responses
group by Ingredients_expected
order by Total_ingredients_preferred desc;

--4.What packaging preferences do respondents have for energy drinks?
select packaging_preference,count(*) Total_preferred_package
from fact_survey_responses
group by packaging_preference
order by 2 desc

--5.Which type of marketing reaches the most Youth (15-30)?
select marketing_channels,count(d.respondent_id) cnt_most from fact_survey_responses f join dim_repondents d 
on f.respondent_id=d.respondent_id
where d.age in ('15-18','19-30')
group by marketing_channels
order by 2 desc

--6.Who are the current market leaders?
select Current_brands,count(*) market_leeader
from fact_survey_responses
group by Current_brands
order by 2 desc

--7.What are the primary reasons consumers prefer those brands over ours?
select reasons_for_choosing_brands,count(*) consumers_prefer
from fact_survey_responses
group by reasons_for_choosing_brands
order by 2 desc

--8.Which marketing channel can be used to reach more customers?
select marketing_channels,count(*) most_customers
from fact_survey_responses
group by marketing_channels
order by 2 desc  

--9.What do people think about our brand? (overall rating)
--OVERALL RATING OUT OF 5
select sum(rating*cnt)/sum(cnt) overall_rating from
(select brand_perception,case when brand_perception='Neutral' then 3 
when brand_perception='Positive' then 5
else 1 end as rating, count(respondent_id) cnt from fact_survey_responses
group by brand_perception ) a

--10.Which cities do we need to focus more on?
select city,count(*) Response_count from 
dim_cities c inner join dim_repondents d 
on c.city_id=d.City_ID
group by city
order by 2 desc

--11.Where do respondents prefer to purchase energy drinks?
select Purchase_location, count(*) as prefer_purchase_location
from fact_survey_responses
group by Purchase_location
order by prefer_purchase_location desc;

--12.What are the typical consumption situations for energy drinks among respondents?
select Typical_consumption_situations, count(*) as frequency
from fact_survey_responses
group by Typical_consumption_situations
order by frequency desc;

--13.What factors influence respondents' purchase decisions, such as price range and limited edition packaging?
select Limited_edition_packaging, count(*) as Survey_answer
from fact_survey_responses
group by Limited_edition_packaging
order by Survey_answer desc;

select Price_range, count(*) as desired_price
from fact_survey_responses
group by Price_range
order by desired_price desc;

--14.Which area of business should we focus more on our product development? (Branding/taste/availability)
select Reasons_for_choosing_brands, count(*) as reasons
from fact_survey_responses
group by Reasons_for_choosing_brands
order by reasons desc;

--15.What factors influence respondents' purchase decisions, such as price range and limited edition packaging?
--PRICE RANGE
SELECT price_range, COUNT(respondent_id) respondent_cnt FROM fact_survey_responses
    GROUP BY price_range
	ORDER BY 2 DESC

--LIMITED EDITION PACKAGING
SELECT limited_edition_packaging, COUNT(respondent_id) respondent_cnt FROM fact_survey_responses
    GROUP BY limited_edition_packaging
	ORDER BY 2 DESC
	
--HEALTH CONCERNS
SELECT health_concerns, COUNT(respondent_id) respondent_cnt FROM fact_survey_responses
    GROUP BY  health_concerns
	ORDER BY 2 DESC

--16. What are the top marketing ways we can market our CodeX energy drink?
select top 1 a.marketing_channels,b.Marketing_Sub_types as marketing_way,b.rating from fact_survey_responses a
join marketing_types b on b.marketing_channels=a.marketing_channels
where b.rating in (4,5)





