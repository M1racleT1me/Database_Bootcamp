Day 01 - Database boot camp
ANSI/SPARС architecture
Resume: Today you will find out the ANSI SPARC architecture principle of the database relational model with the help of using generic dictionary structure


Chapter IV
4.1. Exercise 00 - Generic Dictionary Table
Chapter V
5.1. Exercise 01 - Database View Lists
Chapter VI
6.1. Exercise 02 - To get not actual rows from chrono model

Chapter IV
Exercise 00 - Generic Dictionary Table
Exercise 00: Generic Dictionary Table	
Turn-in directory	ex00
Files to turn-in	V050__generic_dictionary_refactor_db.sql
Allowed	
Database types	TIMESTAMP, VARCHAR, NUMERIC, BIGINT, TIME, DATE, INTEGER
Operators	Standard DDL / DML operators to create / alter relations and to insert / update / delete / select data (CRUD operations)
Database tables	Original Heap Tables
Database Naming Convention	internal SQL Naming Convention rules
table naming and table structure
column pattern naming
primary key pattern naming
foreign key pattern naming
unique key pattern naming
Denied	
Database types	SERIAL
Database tables	Other types of database tables
Database objects	
sequences
user defined anonymous blocks, functions and procedures
Static ID	Don’t use a static ID (red font) for SQL statements in exercise.

INSERT INTO country (name, object_type_id) VALUES (‘Gibraltar’, 2);
SELECT * FROM country WHERE par_id = 2;
SELECT setval(seq_country, 2);

In these cases, 2 is a static (hard-coded) value, use SQL subquery to get a dynamic ID value.
The Aliens were puzzled to calculate the average population density per square meter of the state. To do this, you need to enter a new indicator into the model.

Area of the land (unit: square kilometer)
The problem is that there is a strict limitation on the values of the field “units of measurement” of the table indicator (at the moment as you remember these are values from the [human, percent] list). Having thought and acknowledged the fact that the indicators will only increase and, accordingly, new “units of measurement” will appear, they decided to write a general system dictionary table for such list states with the condition of the already used chronological model for other reference dictionaries in the database.

Please help Aliens to handle with the following system refactoring

Create a general table called dictionary that will store information on all kinds of list values with the following conditions below

chronological structure condition with information about time_start / time_end with necessary check constraints
condition for dividing list sub-dictionaries in the general table dictionary. Please use the dic_name column name for it and the value column to store a particular value from the list.
condition of the specified sorting of rows in case of receiving data on the frontend with default value 0. Please use the order_num column name for it. For this case, that’s OK if you use static values for the INSERT statement for column order_num.
For example, the column order_num in the front-end application can be used in combo boxes (or special components on user-interface).
D01_03

dictionary must has a primary key
composite unique constraint must be added for values of the columns dic_name and value
don’t forget about comments for new created table and each column
Fill in the dictionary with data on the “units of measure” of the indicator table. Specify the name of the list of values (~ sub-dictionary) as “unit” in the dictionary.

Fill in the dictionary with data on the “object types” of the country table. Set the name of the list of values (~ sub-dictionary) as “land” in the dictionary.

Add a new unit of measure “square kilometer” into the sub-dictionary “unit” of dictionary table.

Modify (without deleting) the field unit of the indicator table as a foreign key to the corresponding entry in the dictionary. The given refactoring of the structure seemed very difficult for Aliens and they decided to get a hint from Michael Stonebraker. Unfortunately the steps of the clue have been mixed up.

change field type to bigint for column unit
apply updating the field value based on new IDs from the dictionary
remove existing check constraint on the field unit
rename column from unit to unit_id in indicator table
create a foreign key to the dictionary table with the rules for limiting deletion (ON DELETE RESTRICT option) and updating when cascading update or delete of parent records (ON UPDATE RESTRICT option)
Add a new indicator “Area of the land” into the indicator table using knowledge about the unit of measure with name “square kilometer” from dictionary table. (Please use subquery to get value for your INSERT statement)

Modify (without deleting) the object_type field of the country table as a foreign key to the corresponding dictionary entry. Thanks Michael Stonebraker!

change field type to bigint for column object_type
apply updating the field value based on new IDs from the dictionary
remove existing check constraint on the field object_type
rename column from object_type to object_type_id in country table
create a foreign key to the dictionary table with the rules for limiting deletion (ON DELETE RESTRICT option) and updating when cascading update or delete of parent records (ON UPDATE RESTRICT option)
remove default value for column object_type
Chapter V
Exercise 01 - Database View Lists
Exercise 01: Database View Lists	
Turn-in directory	ex01
Files to turn-in	V060__create_first_views.sql
Allowed	
Operators	Standard DDL / DML operators to create / alter relations and to insert / update / delete / select data (CRUD operations)
Database Objects	views
Database Naming Convention	internal SQL Naming Convention rules
pattern for view
Functions	now()
current_timestamp
Denied	
Database objects	materialized views
Aliens decided to use the separation of information and areas of responsibility for working with the database among themselves. To do this, they decided to turn to ANSI / SPARC architecture and create two database views named “v_dictionary_unit”, “v_dictionary_land” that return data {id, “value of the sub-dictionary”} of the corresponding list of the dictionary in the ordered order specified in the table (order_num column) and corresponding to the actual records (means actual records are in time interval [time_start, time_end] ) of the chronological model. Don’t forget about comments for new database views and columns!

Chapter VI
Exercise 02 - To get not actual rows from chrono model
Exercise 02: To get not actual rows from chrono model	
Turn-in directory	ex02
Files to turn-in	V070__get_outdated_chrono_rows.sql
Allowed	
Operators	Standard DDL / DML operators to create / alter relations and to insert / update / delete / select data (CRUD operations)
Database Objects	views
Database Naming Convention	internal SQL Naming Convention rules
pattern for view
Functions	now()
current_timestamp
random()
max(...)
round(...)
cast(... AS … )
SQL pattern construction	SQL subquery
Denied	
Database objects	materialized views
Static ID	Don’t use a static ID (red font) for SQL statements in exercise.

INSERT INTO country (name, object_type_id) VALUES (‘Gibraltar’, 2);
SELECT * FROM country WHERE par_id = 2;
SELECT setval(seq_country, 2);

In these cases, 2 is a static (hard-coded) value, use SQL subquery to get a dynamic ID value.
Aliens want to know all obsolete strings with a list of columns {id, name, time_start, time_end} of indicator, country tables and the list of the fields {id, dic_name, value, time_start, time_end} for dictionary table. To do this, they created the corresponding database views with the names “v_outdated_indicator”, “v_outdated_country”, “v_outdated_dictionary” with the results sorted in descending order of the id field. Please help them create the appropriate script for each database view. Don’t forget about comments for new database views and columns! ;-)

Aliens remembered about the new added indicator “Area of the land” in the indicator table. Let’s use it in our goal!

Please generate “Area of the land” values for the 1st of May 2020 for each country (except type continent or parent row of child rows ) (take a random value for this parameter from 10 000 to 10 010 000). Remember, there is a special database sequence seq_country_indicator like an iterator for the default value for the ID column of country_indicator table!

Add a new database view v_average_humans_per_country with the logic below.

database view should return 2 columns for each country from country table {country name, ratio between “Population of country” and “Area of the land” rounded to 3 signs}, sorted by country name in ascending mode.

the SQL pattern of the incoming database view must satisfy the form below

SELECT t1.name, 
        your_formula AS value 
FROM (SELECT name, 
            (SELECT value FROM country_indicator ...) AS area,  
            (SELECT value FROM country_indicator ...) AS population  
        FROM country 
      WHERE ... ) AS t1 
ORDER BY ...
use subqueries in the SELECT clause to get each indicator with explicitly actual_date values (the 1st of May 2020 for “Area of the land” and the 1st of May 2019 for “Population of country”)

the sample of the result (must contain 195 rows) from v_average_humans_per_country database view is presented below

please pay attention to your formula, don’t forget about explicit transformation INTEGER into NUMERIC type by using CAST function or by using the construction “value::NUMERIC”. Otherwise you are getting all 0 for the resulting column value.

name	value
...	...
Chile	0.532
Guyana	0.073
...	...
Venezuela	0.095
...	...