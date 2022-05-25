# Introduction

SQL stands for <b>Structured Query Language</b>. It is the standard language to interact with databases. SQL is the most important tool, a data analyst uses to manipulate and gain insights from the data. In this project, we will try to clean, process, and analyze the data, for this purpose we will use this [automobile data](https://archive.ics.uci.edu/ml/datasets/automobile) from ***UCI Machine Learning Repository***.

For this project, I will be using MySQL Workbench. MySQL is an open-source relational database management system. So that now we have our software setup, then let’s import the dataset into our database.
<br />
<div align='center'>
<img src="https://user-images.githubusercontent.com/96247747/170234750-2b374033-7c94-4f16-9355-ad4c9e57b95a.jpg")></img>
</div>
<br />

***==========================================================================================***

# Importing Data

To import the data in MySQL workbench follow the given steps, as the dataset is in CSV format we have to import the data using the **Table Data Import Wizard menu.**

- Create a database named automobile.<br/>
- Right click on the automobile database in the Schemas and select the Table Data Import Wizard option from the menu.<br/>
- Now enter the path of the file, in the file selection window and click Next.<br/>
- In the Select Destination click on Create New Table and set the name of the table as automobile_data and click Next.<br/>
- In the settings window, keep the values as it is and click on Next.<br/>
- Finally, click on the Next button to execute the task, and the dataset is successfully imported!!!<br/>

***==========================================================================================***

# Objective

Let’s say you have started a used car dealership venture. You want to know which cars customers are mostly to purchase so that you know which cars to keep in stock. So that now our objective is clear let’s analyze the data!!!

***==========================================================================================***

# Data Cleaning

To view the structure of your Dataset press the "i" button corresponding to your Dataset in Navigator window under Schemas tab.

> We can see that the data set has 20 Columns and 203 Rows

<br />
<div align='center'>
<img src="https://user-images.githubusercontent.com/96247747/170242008-9f4cfe02-4f3c-40e7-a58f-9b3071b5a0f0.PNG")></img>
</div>
<br />

> Below query is to view the Rows and Col values of the entire Dataset

    SELECT *
    FROM automobile_data;


 ### Now, let’s inspect each column and check for missing values, outliers, or any spelling mistakes present in the data which can hinder the analysis.


> Let’s find out how many unique car manufacturers do we have
    
    -- Checking for NULL or Empty values in make col
    select *  
    from automobile_data
    where make is null or make =''; -- No NULL or Empty values found.
    
    select count(distinct make)
    from automobile_data; -- There are 21 Unique Car Manufacturers.
    
*There are <b>21 unique car manufacturers available</b>. And we have to find top 5 cars customers mostly purchase. While dealing with categorical data, the best way is to find the unique values which will help us to narrow down whether there are any errors in spelling or not. So here there are no errors and missing values present in this column.*

> Now, let's inspect column num_of_doors

    select *
    from automobile_Data
    where num_of_doors is null or num_of_doors = '';
 
*So there are two missing values in this column, one car of brand dodge and Mazda each have missing values in the num_of_doors column. We will try to substitute the missing values, by looking at cars of the same features.*

    select * 
    from automobile_data
    where make='dodge' and body_style='sedan' and drive_wheels='fwd' and engine_location='front';
    
*To find out the value to substitute, with this query we will find out the common number of doors, of brand dodge, of body style — sedan, fwd, and front engine location.
So three dodge cars are satisfying these conditions and as we can see that both of them have four doors so we can substitute this same value in the missing location. To substitute the value we will use the **UPDATE statement of SQL.***

    update automobile_data
    set num_of_doors = 'four'
    where make='dodge' and body_style='sedan' and drive_wheels='fwd' and engine_location='front';
 
*We have successfully filled the missing value with **‘four’**. Similarly, we can follow the same procedures to substitute the value for the Mazda car.*

    select * 
    from automobile_data
    where make='mazda' and body_style='sedan' and drive_wheels='fwd' and engine_location='front';
    -- So we will replace the missing value with 'four' as it is a sedan which usually has four doors.
    update automobile_data
    set num_of_doors='four'
    where make='mazda' and body_style='sedan' and drive_wheels='fwd' and engine_location='front';
   
> Now, moving on to the next column let’s inspect the drive_wheels column, as this is also a categorical column let’s find out the distinct values present.*

    select *
    from automobile_data
    where drive_wheels is null or drive_wheels=''; -- No NULL or Empty Values
    select distinct drive_wheels
    from automobile_data;

*In the result set, we can see **‘4wd’** appears twice, but there’s no spelling mistake then why does it appear twice?? This is because of white space present in one of the values, let’s confirm this by looking at the length of values. We use the length() function and to remove the extra space using Trim() function.*

    select drive_wheels,length( drive_wheels)
    from automobile_data
    group by drive_wheels;
    update automobile_data
    set drive_wheels=trim(drive_wheels)
    where length(drive_wheels) > 3; -- Cool !! all clean now

> In num_of_cylinders column, **‘two’** is misspelled as **‘tow’** so we need to correct this mistake and update the table with the correct value using the UPDATE statement.

    select distinct num_of_cylinders
    from automobile_data; -- 'two' is misspelled as 'tow' lets correct it
    update automobile_data 
    set num_of_cylinders = 'two'
    where num_of_cylinders = 'tow'; -- Looks Good :)
    
> So, there are two more columns, we need to check for — compression_ratio and price. Both columns have continuous values, so let’s check the range of values and try to see if any outlier is present or not. The below query will return the values for compression_ratio which outside for the range provided in attribute informaion of the dataset. **compression-ratio: 7 to 23.** Outliers will be deleted using **Delete statement**

    select compression_ratio
    from automobile_data
    where compression_ratio not between 7 and 23; -- Compression Ration 70 is an outlier and hence need to be deleted
    delete from automobile_data
    where compression_ratio =70; -- Looks good now.
   
> Let’s inspect the last column that is the price column.Price range should be **price: 5118 to 45400**

    select price
    from automobile_data
    where price not between 5118 and 45400;

*Okay, so we can see some of the cars have a **price ‘0'**, which is not correct, as the prices in the data description start from **‘5118’**. So to deal with this we will substitute the values with the average price of all cars using the average() function.*

    Select round(avg(price)) as AVG_PRICE
    from automobile_data; -- AVG_PRICE = 12977
    update automobile_data
    set price = 12977
    where price = 0; -- ALL clean now !!!
    
### We have now cleaned the data and are ready for the analysis!!!!

***==========================================================================================***

# Analyzing the data

### Let’s define our objective,

* To find the top 5 cars customers bought based on make.
* To find the top 5 cars based on body_style.

> Let’s start with the first question, to find the top 5 cars based on make we will execute the following query.

    select make, count(make) as make_sold
    from automobile_data
    group by make
    order by make_sold desc
    limit 5;
    
*This query basically retrieves the count of cars for brand and sorts the result by descending order of count. As we can see in the result set most customers prefer to buy cars from **Toyota**.

> Now let’s find out the top 5 cars based on body style.

    select body_style,count(body_style) as body_style_sold
    from automobile_data
    group by body_style
    order by body_style_sold Desc
    limit 5;
    
*This result shows that the customers prefer buying **sedans** more than any other body style. Here we have got some concrete results that the **customers prefer cars of Toyota brand and cars of sedan body style**. So let’s drill down further into the results and determine which body style is preferred by the customer who buys the Toyota cars?*

    select make,body_style,count(body_style) as body_styles,fuel_type
    from automobile_data
    where make='toyota' 
    group by body_style
    order by body_styles desc;
    
*So, the result of this query, tells us that the customers buy **hatchback models from Toyota**, further drilling down the data we understood that the customers prefer buying **Toyota cars in the hatchback segment and of gas type**.*

*With this analysis of the data we are now aware of which type of car to keep in stock*
