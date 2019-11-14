---------------------------------------------------------------------------------------------------
-- Name  : Thomas Lambert
--
-- Date  : May-16-2019
--         
-- Course: CS 3630
--         Final Exam 
--         Part II - 50 points 
---------------------------------------------------------------------------------------------------

prompt
prompt CS 3630 Final Exam - Part II
Prompt 

set pagesize 20
set echo off
set feedback off
 
Prompt
prompt 1. Formatting columns
Prompt

Column Gender format a8 heading 'Gender'
Column Tel_no format a12 heading 'Phone Number'
Column State format a6 heading 'State'
Column Pno format a16 heading 'Property Number'
Column Rno format a15 heading 'Renter Number'
Column Rent format $9,999.99 heading 'Rent'
Column Highest format $9,999.99 heading 'Highest Rent'
Column Lowest format $9,999.99 heading 'Lowest Rent'
Column Latest format a18 heading 'Latest Start Date'
Column NumLease format 99999999999999 heading 'No. of Leases'
Column NmLease format a16 heading 'Number of Leases'

-- Gender: string of length 8 with heading "Gender"
-- Tel_no: string of length 12 with heading "Phone Number"
-- State: string of length 6 with heading "State"
-- Pno  : string of length 16 with heading "Property Number"
-- Rno  : string of length 15 with heading "Renter Number"
-- Rent: in currency format with two decimal digits and thousand comma such as $1,050.00 
--        with heading "Rent"
-- Highest: in currency format with two decimal digits and thousand comma such as $1,050.00 
--        with heading "Highest Rent" 
-- Lowest : in currency format with two decimal digits and thousand comma such as $1,050.00 
--        with heading "Lowest Rent"
-- Latest : string of length 18
-- "No. of Leases": digits of length 14

Prompt
Prompt 2.  Retrieve all male renters whose Tel_no begins with 342 or
Prompt     currently not available, sorted by Rno in descending order.
Prompt

/*
Sample output 

Renter Number   NAME            Gender   Phone Number                           
--------------- --------------- -------- ------------                           
R204            Mike            M        342-1600                                       
R203            Jason           M                                       
*/

select RNO Rno, NAME, GENDER, TEL_NO
from uwp_renter
where (tel_no like '342%' or tel_no is null) and gender = 'M'
order by rno;

Prompt
Prompt 3. For each city that has at least a property, list city, state, the count of properties in the
Prompt    city, and the highest rent and lowest rent of all properties in the city, 
Prompt    sorted by city in ascending order then by the highest rent in descending order.
Prompt    Use "Number of Properties" for the count,
Prompt    Highest and Lowest as the headings for the highest/lowest rents.
Prompt

/*
Sample output 

CITY         State  Number of Properties Highest Rent Lowest Rent
------------ ------ -------------------- ------------ -----------
Cuba City    WI                        5  $1,500.00    $400.00
Cuba City    IA                        8    $750.00    $650.00
*/

select city, state State, count(state) "Number of Properties", max(rent) Highest, min(rent) Lowest
from uwp_property
group by state, city
having count(city) > 0
order by city asc, max(rent);


Prompt
Prompt 4. Retrieve Pno, Rooms and Rent for all properties in Platteville, WI, that 
Prompt    are currently NOT leased out, sorted by rent in ascending order. 
Prompt    The same query should work at any time.

/*
Sample output 

Property Number       ROOMS       Rent                                          
---------------- ---------- ----------                                          
P800                      4    $400.00                                          
P500                      3  $1,000.00                                          
*/

select p.pno Pno, rooms, rent Rent
from uwp_property p
join uwp_lease l
    on p.pno = l.pno
where sysdate not between start_date and end_date and city = 'Platteville' and state = 'WI'
order by rent asc;

Prompt
Prompt 5. For each renter who has at least two leases, list Rno, name and
Prompt    the total count of leases the renter has at all times, and the 
Prompt    latest lease start date, sorted by Rno in descending order.
Prompt    Use "No. of Leases" as the heading for the total count of leases and
Prompt    Latest for the latest lease start date.
Prompt    Date should be in the format as 05-16-2013.
Prompt

/*
Sample output 

Renter Number   NAME              No. of Leases Latest Start Date               
--------------- --------------- --------------- ------------------              
R007            Tom                           3 05-20-2018                     
R003            Joe                           3 08-06-2017                      
*/

select r.rno, name, count(start_date) NumLease, to_char(max(start_date), 'MM-dd-yyyy') Latest 
from uwp_renter r
join uwp_lease l
    on r.rno = l.rno
group by r.rno, name
having count(start_date) > 1
order by rno;

Prompt
Prompt 6. For each female renter who does not have any leases during December 2012, 
Prompt    list the renter number, name and the total count of leases the renter has
Prompt    at all times, sorted by the count. 
Prompt    For a female renter who has no leases, a zero should be displayed. 
Prompt    Use "Number of Leases" for the heading of count.
Prompt

/*
Sample output 

Renter Number   NAME            Number of Leases
--------------- --------------- ----------------
R100            Mary                           0
R200            Lisa                           5
*/

select r.rno, name, count(start_date) NmLease
from uwp_renter r 
left join uwp_lease l
    on r.rno = l.rno
where r.rno not in (select r.rno from uwp_renter r join uwp_lease l on r.rno = l.rno 
                  where start_date between '30-Nov-2012' and '1-Jan-2013' or end_date between '30-Nov-2012' and '1-Jan-2013') 
      and gender = 'F'
group by r.rno, name
order by count(start_date);

Prompt
Prompt 7. Clear the column formatting
Prompt     

CLEAR COLUMNS