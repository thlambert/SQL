-------------------------------------------------------------------------------
-- Name       : Thomas Lambert
--
-- UserName   : lambertth
--
-- Course     : CS 3630
--
-- Description: Quiz 3
--
-- Date       : April 10, 2019
-------------------------------------------------------------------------------


prompt
prompt 1. 
prompt Set column format 
Prompt 



set echo off
set feedback off

-- The column Pno must be displayed as string of length 15 
--     with a heading of "Patient No".
-- The column wardAllocated and wardreq must be displayed as string of length 12 
--     with a heading of "Ward No".
-- The column dateinward must be displayed as string of length 12
--     with a heading of "Date in Ward".

Column PatientNum format a15 heading 'Patient No'
Column WardNum format a12 heading 'Ward No'
Column WardDate format a12 heading 'Date in Ward'

Column StaffNum format a15 heading 'Number of Staff'
Column NumPatient format a18 heading 'Number of Patients'

prompt
prompt 2.
prompt List pNo, firstName, lastName and dateInWard of all 
prompt inpatients, sorted on last name in descending order,
prompt and then on dateInWard in ascending order.
prompt dateInWard must be in the format mm/dd/yyyy, e.g., 04/13/2009.

select pNo PatientNum, firstname, lastname, to_char(dateInWard, 'mm/dd/yyyy') WardDate
from inpatient
order by lastname desc, dateinward asc;



prompt
prompt 3.
prompt List pNo, firstName and lastName of different inpatients
prompt whose last name begins with a 'Y' or 'X'.
prompt 

select pNo patientnum, firstname, lastname
from inpatient
where lastname like 'Y%' or lastname like 'X%';

prompt
prompt 4.
prompt For each shift of each ward,
prompt list the ward number and the shift (Early, Night, or Late)
prompt with the number of staff allocated to the shift for the ward
prompt for the week starting on Monday, April 8, 2019, 
prompt sorted by ward number and then by the shift.
prompt The heading for the number of staff should be "Number of Staff"
prompt 

-- Sample output
-- Ward No   SHIFT Number of Staff
------------ ----- ----------
-- W01       Early     2
-- W01       Late      1
-- W01       Night     5
-- W02       Early     2
-- W02       Late      4

select wardallocated WardNum, shift, count(staffno) StaffNum
from weeklyrota
where startdate between '8-Apr-19' and '15-Apr-19' 
group by wardallocated, shift
order by wardallocated, shift;


prompt
prompt 5.
prompt For each ward, list the ward number and the number of
prompt inpatients who are currently on the waiting list, i.e., 
prompt dateInWard is unknown or dateInWard is tomorrow or after,
prompt sorted by the ward number.
prompt The heading of the count should be "Number of Patients".
prompt The same query should generate correct result on any date.

select wardreq wardNum, count(dateonwaitinglist) NumPatient
from inpatient
where (dateInward is null or dateinward > Sysdate)
group by wardreq
order by wardreq;

prompt
prompt 6.
prompt For each ward that has two or more inpatients whose 
prompt dateInWard is in the current month of the current year, 
prompt list the ward number and the number of such inpatients,
prompt sorted by the ward number.
prompt The heading of count should be "Number of Patients".
prompt The same query should work for any month of any year.
prompt 

select wardreq, count(dateinward) as NumPatient
from inpatient
where (dateInWard > Last_Day(Add_Months(SysDate, -1)) and dateInWard <= last_day(SysDate))
group by wardreq
order by wardreq;

prompt
prompt 7.
prompt Remove all column format
prompt 




set feedback off
set echo off
