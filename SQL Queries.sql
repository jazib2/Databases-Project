--------------------------------------------------------------------------Part 1--------------------------------------------------------------------------------------
--Creation of Database

create database FoodserviceDB

--Adding a constraint to the Ratings table

ALTER TABLE Ratings
add constraint check_it check (Overall_Rating in (0,1,2))

--Setting Primary Key for Ratings table

ALTER TABLE Ratings
add constraint PK_Ratings PRIMARY KEY (Consumer_ID,Restaurant_ID)

--Setting Primary Key for Restautant_Cuisines table

ALTER TABLE Restaurant_Cuisines
add constraint PK_Restaurant_Cuisines PRIMARY KEY (Restaurant_ID,Cuisine)

--Foreign Key referencing for Restaurant Table in Ratings Table

ALTER TABLE Ratings 
Add constraint Fk_Ratings_Restaurant
FOREIGN KEY (Restaurant_ID) REFERENCES Restaurant(Restaurant_ID)

--Foreign Key referencing for Consumers Table in Ratings Table

ALTER TABLE Ratings 
Add constraint FK_Ratings_Consumers
FOREIGN KEY (Consumer_ID) REFERENCES Consumers(Consumer_ID)

--Foreign Key referencing for Restaurant Table in Restaurant_Cuisines Table

ALTER TABLE Restaurant_Cuisines 
Add constraint FK_Restaurant_Cuisines_Restaurant
FOREIGN KEY (Restaurant_ID) REFERENCES Restaurant(Restaurant_ID)

-------------------------------------------------------------------------Part 2----------------------------------------------------------------------------------------

-- First Query

select  distinct * from Restaurant r inner join Restaurant_Cuisines c on r.Restaurant_ID = c.Restaurant_ID
where Price = 'Medium' and Area = 'Open' and Cuisine = 'Mexican'


-- Second Query

--Mexican 

select  count(distinct r.Restaurant_ID) as Total from Restaurant r inner join Restaurant_Cuisines c on r.Restaurant_ID = c.Restaurant_ID 
inner join Ratings b on r.Restaurant_ID = b.Restaurant_ID where Overall_Rating = 1 and 
Cuisine = 'Mexican'

--Italian

select count (distinct r.Restaurant_ID) as Total from Restaurant r inner join Restaurant_Cuisines c on r.Restaurant_ID = c.Restaurant_ID 
inner join Ratings b on r.Restaurant_ID = b.Restaurant_ID where Overall_Rating = 1 and 
Cuisine = 'Italian'


--select count( distinct r.Restaurant_ID )from Restaurant_Cuisines r inner join Ratings c on r.Restaurant_ID = c.Restaurant_ID where
--Cuisine = 'Mexican' and Overall_Rating = 1

--select * from Ratings where Restaurant_ID = 132594


-- Third Query 

select avg (Age) as Average_Age from Consumers where Consumer_ID in 
(select distinct Consumer_ID from Ratings where Service_Rating = 0)


-- Fourth Query (First Method) Using two joins and one nested query

select distinct( r.Name), a.Food_Rating from Restaurant r inner join Ratings a On r.Restaurant_ID = a.Restaurant_ID
inner join Consumers s On s.Consumer_ID = a.Consumer_ID
where s.Age in ( select min(Age) from Consumers) Order by Food_Rating desc


--Fourth Query (Second Method) Using one join and two nested queries

select r.Name, a.Food_Rating from Restaurant r inner join Ratings a On r.Restaurant_ID = a.Restaurant_ID
where a.Consumer_ID in ( select Consumer_ID from Consumers where Age in (select min (Age) from Consumers)) Order by Food_Rating asc

--Fifth Query (The below created Stored Procedure has not been executed)

Create Procedure Service_Rating_Update
AS
Update Ratings
Set Service_Rating = 2
Where Restaurant_ID in (select Restaurant_ID from Restaurant where Parking = 'Yes' or Parking = 'Public')
GO


--Sixth Query

--1

select count(distinct Restaurant_ID) as Total, Cuisine from Restaurant_Cuisines group by Cuisine
having Cuisine like 'C%' order by Total desc


--2

select   count(distinct  r.Restaurant_ID) as Total ,r. State, r.City from Restaurant r inner join Ratings rt on r.Restaurant_ID = rt.Restaurant_ID
where rt.Service_Rating = 2 and rt.Food_Rating =2 and rt.Overall_Rating = 2 group by State, City Order by Total desc


--3

select Name from Restaurant where  exists
(select Name  from Restaurant_Cuisines where Restaurant_Cuisines.Restaurant_ID =Restaurant.Restaurant_ID and Cuisine = 'Seafood')


--4

select Name from Restaurant where Restaurant_ID in (select distinct Restaurant_ID from Ratings where Food_Rating = 2 and 
Service_Rating = 2 and Overall_Rating = 2 and 
Restaurant_ID in (select  Restaurant_ID from Restaurant_Cuisines where Cuisine = 'Fast food') and 
Consumer_ID in (select Consumer_ID from Consumers where Occupation = 'Employed'))

