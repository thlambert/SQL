------------------------------------------------
-- Name    : Thomas Lambert
--
-- UserName: lambertth
--
-- Course  : CS 3630
--           Test 2 
--
-- Date    : May-8-2019
------------------------------------------------

Prompt
Prompt Test 2
Prompt

Prompt
Prompt 2 points on submission 
Prompt
Prompt 2 points on style 
Prompt

Column PNum format a10 heading 'Property #'
Column City format a15 heading 'City'
Column Rooms format a5 heading 'Rooms'
Column Rent format a4 heading 'Rent'
Column NumP format a15 heading '# of Properties'
Column AvgR format a12 heading 'Average Rent'
Column RNum format a8 heading 'Renter #'
Column RName format a11 heading 'Renter Name'
Column TNum format a11 heading 'Telephone #'

Prompt (2 points)
Prompt 1. Drop Table UWP_Viewing even the table may not exist.
prompt

Drop table UWP_Viewing;

Prompt (4 points)
Prompt 2. Create table UWP_Viewing.
Prompt
--   Rno          String of 4 chars
--   Pno          String of 4 chars
--   VDate        Date
--   TheComment   String up to 50 chars
--
--   Primary Key   Rno, Pno, VDate
--   Foreign Key   Rno References UWP_Renter
--   Foreign Key   Pno References UWP_Property
--

Create table UWP_Viewing (
    Rno     char(4),
    Pno     char(4),
    VDate   date,
    TheComment varchar(50),
    
    Primary Key (Rno, Pno, VDate),
    Foreign Key (Rno) references UWP_Renter(Rno),
    Foreign Key (Pno) references UWP_Property(Pno)
    );


Prompt
Prompt (2 points)
Prompt 3. Show table schema of UWP_Viewing.
Prompt

desc UWP_Viewing;

Prompt
Prompt (5 points)
Prompt 4. Insert records into table UWP_Viewing.
Prompt    You must make sure the records are saved back to the server.
Prompt
--   Rno    Pno        Vdate       TheComment
--   R001   P300      04-15-19     Trouble maker
--   R001   P300      04-16-19     

Insert into UWP_Viewing
    Values ('R001', 'P300', '15-Apr-19', 'Trouble maker');

Insert into UWP_Viewing
    Values ('R001', 'P300', '16-Apr-19', '');

Prompt (2 points)
Prompt 5. Select all records from table UWP_Viewing
Prompt

Select * from UWP_Viewing;


Prompt
Prompt (8 points)
Prompt 6.  List Pno, City, Rooms and Rent of all properties whose rent is in the 
Prompt     range of 750 - 1200, inclusive, sorted on rooms in ascending order and 
Prompt     then on pno in descending order
Prompt

Select Pno PNum, City City, Rooms Rooms, Rent Rent
from UWP_PROPERTY
where rent >= 750 and rent <= 1200
order by rooms asc, pno desc;

Prompt
Prompt (8 points)
Prompt 7.  Retrieve Pno, Rooms and Rent for all properties in
Prompt     Platteville that are currently NOT leased out, sorted on Pno.
Prompt     The same query should work at any time.
Prompt

Select l.Pno PNum, Rooms Rooms, Rent Rent
from (select * from UWP_PROPERTY where city = 'Platteville') p
join UWP_LEASE l
    on p.pno = l.pno
where sysdate not between start_date and end_date
order by l.pno;

Prompt
Prompt (8 points)
Prompt 8.  For each city that has at least three properties, list the city,
Prompt     the count of properties in the city, and the average rent 
Prompt     of all properties in the city, sorted by average. 
Prompt     Use "Average" as the heading for the average rent and 
Prompt     "Number of Properties" for the count.
Prompt     The average must be in the currency format 
Prompt     (exactly two decimal digits starting with a $).
Prompt

select city City, count(p.pno) NumP, avg(rent) AvgR
from UWP_PROPERTY p
group by city
having count(city) >= 3
order by avg(rent);


Prompt
Prompt (8 points)
Prompt 9. For each renter, list the renter number, renter name 
Prompt    and the count of leases the renter has on properties 
Prompt    in Platteville, sorted by renter name. 
Prompt    For a renter who has no such leases, a zero should be displayed. 
Prompt    Use "Number of Leases" for count.
Prompt

select l.rno RNum, name RName, count(p.pno) NumP
from  uwp_renter r 
left join uwp_lease l 
    on r.rno = l.rno
join uwp_property p
    on l.pno = p.pno
where city = 'Platteville'
group by l.rno, name
order by name;

Prompt
Prompt (8 points)
Prompt 10. List the details of all renters who do not have a lease on any
Prompt     propetry in Platteville during April 2006 and whose phone number 
Prompt     is not available, sorted by Rno.
Prompt

select r.rno RNum, name RName, tel_no TNum
from uwp_renter r join uwp_lease l on r.rno = l.rno 
where tel_no is null and start_date not between '1/Apr/2006' and '30/Apr/2006' and end_date not between '1/Apr/2006' and '30/Apr/2006'
group by r.rno, r.rno, name, tel_no
order by r.rno;

    
Prompt
Prompt (1 point)
Prompt 11. Clear all column formatting 
Prompt     

Clear Columns
