-- Exploratory Data Analysis using SQL on an automobile dataset from UCI Machine Learning Repository.

create database automobile; 

use automobile;

SELECT 
    *
FROM
    automobile_data;

-- Analyzing  columns for bad Data

select count(distinct make)
from automobile_data; -- There are 21 Unique Car Manufacturers
-- Checking for NULL or Empty values in make col
select *  
from automobile_data
where make is null or make =''; -- No NULL or Empty values found, make column is clean.

-- Now lets check the num_of_doors col for any NULL or Empty Values

select *
from automobile_Data
where num_of_doors is null or num_of_doors = '';
-- make dodge and mazda have empty values for num_of_doors, lets substitute the missing values, by looking at cars of the same features.
select * 
from automobile_data
where make='dodge' and body_style='sedan' and drive_wheels='fwd' and engine_location='front';
/* So three dodge cars are satisfying these conditions and as we can see that both of them have four doors so we can substitute this 
same value in the missing location. To substitute the value we will use the UPDATE statement of SQL.*/
update automobile_data
set num_of_doors = 'four'
where make='dodge' and body_style='sedan' and drive_wheels='fwd' and engine_location='front';

/*We have successfully filled the missing value with ‘four’. Similarly, we can follow the same procedures to substitute 
the value for the Mazda car.*/

select * 
from automobile_data
where make='mazda' and body_style='sedan' and drive_wheels='fwd' and engine_location='front';
-- So we will replace the missing value with 'four' as it is a sedan which usually has four doors.
update automobile_data
set num_of_doors='four'
where make='mazda' and body_style='sedan' and drive_wheels='fwd' and engine_location='front';

/*Now, moving on to the next column let’s inspect the drive_wheels column, as this is also a categorical column let’s 
find out the distinct values present.*/
select *
from automobile_data
where drive_wheels is null or drive_wheels=''; -- No NULL or Empty Values
select distinct drive_wheels
from automobile_data; -- We can see 4wd appears twice this is because of a white space in one of the values
-- lets finding out the incorect value using length and clear the white space by Trim
select drive_wheels,length( drive_wheels)
from automobile_data
group by drive_wheels;
update automobile_data
set drive_wheels=trim(drive_wheels)
where length(drive_wheels) > 3; -- Cool !! all clean now

-- Lets move to  next column, num_of_cylinders

select distinct num_of_cylinders
from automobile_data; -- 'two' is misspelled as 'tow' lets correct it
update automobile_data 
set num_of_cylinders = 'two'
where num_of_cylinders = 'tow';

-- lets inspect the length of the cars as length: continuous from 141.1 to 208.1.

select length
from automobile_data
where length not between 141.1 and 208.1 ; -- All Clean !!

select distinct body_style
from automobile_data; -- all  clean !!

select distinct engine_location
from automobile_data; -- all clean !!

select distinct engine_type
from automobile_data; -- all clean !!

-- Lets inspect for wheel_base thats not in range 86.6 to 120.9
select wheel_base
from automobile_data
where wheel_base not between 86.6 and 120.9; -- All Clean !!

-- Lets inspect compression-ratio: continuous from 7 to 23.

select compression_ratio
from automobile_data
where compression_ratio not between 7 and 23; -- Compression Ration 70 is an outlier and hence need to be deleted
delete from automobile_data
where compression_ratio =70; -- Looks good now.

-- Lets inspect the last column price

select price
from automobile_data
where price not between 5118 and 45400; -- We have 4 '0' values, lets deal  with this by replacing the '0' values by average price of cars
Select round(avg(price)) as AVG_PRICE
from automobile_data; -- AVG_PRICE = 12977
update automobile_data
set price = 12977
where price = 0; -- ALL clean now !!!

-- Now we cleaned the Data and ready for analysis.

/*
Let’s define our objective,

1) To find the top 5 cars customers bought based on make.
1) To find the top 5 cars based on body_style.*/


-- Top 5 Cars customer bought based on make
select make, count(make) as make_sold
from automobile_data
group by make
order by make_sold desc
limit 5;

/*This query basically retrieves the count 
of cars for brand and sorts the result by descending order of count. 
As we can see in the result set most customers prefer to buy cars of Toyota brand. */

-- top 5 cars based on body_style.

select body_style,count(body_style) as body_style_sold
from automobile_data
group by body_style
order by body_style_sold Desc
limit 5;
-- This result shows that the customers prefer buying sedans more than any other body style. 
-- Now lets dig depper to find which toyota car people prefer to buy

select make,body_style,count(body_style) as body_styles,fuel_type
from automobile_data
where make='toyota' 
group by body_style
order by body_styles desc;

/* So, the result of this query, tells us that the customers buy hatchback models of the Toyota brand, further drilling down the data we understood that the customers prefer buying Toyota cars in the hatchback segment and of gas type.

With this analysis of the data we are now aware of which type of car to keep in stock */


