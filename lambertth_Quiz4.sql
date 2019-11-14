--------------------------------------------------------------------------------- 
-- Name    : Thomas Lambert
--
-- UserName: lambertth
--
-- Course  : CS 3630
--           Quiz 4
--
-- Date    : 25-April-2019
--
-- Note    : If you use views, 
--           then at the end you must remove all views you have created.
--------------------------------------------------------------------------------- 

prompt
prompt 1. 
prompt Set column format 
Prompt 
-- pno should be displayed as a string of size 12 with heading "Property No"
-- rno should be displayed as a string of size 10 with heading "Renter No"
-- Start_Date should be displayed as a string of size 12 with heading "Start Date"
-- End_Date should be displayed as a string of size 12 with heading "End Date"
-- name should be displayed as a string of size 9
-- rent should be displayed in currency format such as $9,500.00
-- All counts should have the same heading "Number of leases"

Column pNum format a12 heading 'Property No'
Column rNum format a10 heading 'Renter No'
Column SDate format a12 heading 'Start Date'
Column EDate format a12 heading 'End Date'
Column Nm format a9 heading 'Name'
Column rnt format $9,999.99 heading 'Rent'
Column leaseNum format a16 heading 'Number of leases'

prompt
prompt 2.  For each lease, list property number, renter number and renter name,
prompt     the start date and the end date, sorted on the property number in 
prompt     ascending order, then on the start date in descending order.
prompt     End_Date must be displayed in format such as 12/31/2016.
prompt

select l.pno pNum, r.rno rNum, name Nm, to_char(Start_date, 'MM/DD/YYYY') SDate, 
    to_char(end_date, 'MM/DD/YYYY') EDate
from alllease l
join allrenter r
    on l.rno = r.rno
order by pno asc, start_date;

prompt
prompt 3.  For each renter, list the renter number, renter name and the 
prompt     total number of leases the renter has, sorted by renter no. 
prompt     A zero should be displayed as the total number of leases
prompt     for those renters without any lease.
prompt

select r.rno rNum, name Nm, count(l.rno) leaseNum
from allrenter r
left join alllease l
    on r.rno = l.rno 
group by r.rno, name;

prompt
prompt 4.  For each property that has at least 2 leases, list the 
prompt     property number, city and the total number of leases,
prompt     sorted by property number in descending order.
prompt

select p.pno pNum, city, count(l.pno) leaseNum
from allproperty p
join alllease l
    on l.pno = p.pno 
group by p.pno, city
having count(l.pno) >= 2
order by p.pno;

prompt
prompt 5.  For each property that is currently not rented out, list 
prompt     the property number, city, rent and the total number of leases 
prompt     the property has, sorted by the property number.
prompt     A zero should be displayed as the total number of leases
prompt     for those properties without any lease.
prompt     The same query should work at any date.
prompt     

select p.pno pNum, city, rent rnt, count(l.pno) leaseNum
from allproperty p
left join (select * from alllease where sysdate not between start_date and end_date) l
    on p.pno = l.pno 
group by p.pno, city, rent
order by p.pno;

prompt
prompt 6.  For each property in Platteville, list the property number,
prompt     rent and the total number of leases, sorted by the property number.
prompt     A zero should be displayed as the total number of leases
prompt     for those properties without any lease.

select p.pno pNum, rent rnt, count(l.pno) leaseNum
from (select * from allproperty where city = 'Platteville') p
left join alllease l
    on p.pno = l.pno 
group by p.pno, rent
order by p.pno;


prompt
prompt 7.
prompt Remove all column format
prompt 

CLEAR COLUMNS