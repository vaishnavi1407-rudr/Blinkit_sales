CREATE TABLE Blink_Grocery_Data
(
Item_Fat_Content varchar(50),
Item_Identifier varchar(50),
Item_Type	varchar(50),
Outlet_Establishment_Year int,
Outlet_Identifier varchar(50),
Outlet_Location_Type varchar(50),
Outlet_Size	varchar(50),
Outlet_Type	varchar(50),
Item_Visibility float,
Item_Weight float,
Sales float,
Rating float
)

SELECT *
FROM  Blink_Grocery_Data

SELECT COUNT(*)
FROM  Blink_Grocery_Data

UPDATE  Blink_Grocery_Data
SET item_fat_content = 
CASE 
WHEN item_fat_content IN ('LF','low fat')
then 'Low Fat'
WHEN item_fat_content = 'reg' then 'Regular'
else item_fat_content
end

Select distinct item_fat_content
from Blink_Grocery_Data

Select cast(Sum(sales)/1000000 as decimal(10,2)) as Total_sales_millions
From Blink_Grocery_Data

Select cast(avg(sales) as decimal(10,2)) as Avg_sales
From Blink_Grocery_Data

Select  count(*) as No_of_items
from Blink_Grocery_Data

Select cast(avg(rating) as decimal(10,2)) as Avg_rating
From Blink_Grocery_Data

Select item_fat_content,
cast(sum(sales) as decimal(10,2)) as Total_sales,
cast(avg(sales) as decimal(10,2)) as Avg_sales,
count(*) as No_of_items,
cast(avg(rating) as decimal(10,2)) as Avg_rating
from Blink_Grocery_Data
group by 1
order by 1 desc

Select item_type,
cast(sum(sales) as decimal(10,2)) as Total_sales,
cast(avg(sales) as decimal(10,2)) as Avg_sales,
count(*) as No_of_items,
cast(avg(rating) as decimal(10,2)) as Avg_rating
from Blink_Grocery_Data
group by 1
order by 2 desc

Select outlet_location_type,
isnull([low fat],0) as Low_Fat
ISNULL([Regular],0) as Regular
From 
(Select outlet_location_type,
item_fat_content
cast(sum(sales) as decimal(10,2)) as Total_sales,
from Blink_Grocery_Data
group by 1,2) as table1
PIVOT
(sUM(Total_sales)
for item_fat_content in ([Low Fat],[Regular])
) as pivottable
order by outlet_location_type
