-----------------------------------------------------------------------------
-- Name        : Thomas Lambert
--
-- UserName    : lambertth
--
-- Date        : 4/24/2019
--
-- Course      : CS 3630 
--               Section 1
--
-- Assignment 9: 15+5 points
--
-- Due Date    : Friday, April 26, by 11 PM
--               Upload your script file to Canvas. The file name must be
--               UserName_A9.sql, where UserName is your UWP username.
-----------------------------------------------------------------------------

Column RType format a9 heading 'Room Type'
Column hotelNum format a7 heading 'Hotel #'
Column hotelNm format a10  heading 'Hotel Name'
Column rNum format a6  heading 'Room #'
Column numBook format a13 heading '# of Bookings'
Column numCBook format a21 heading '# of Current Bookings'
Column gNm format a15 heading 'Guest Name'
Column gNum format a7 heading 'Guest #' 
Column fNum format a22 heading '# Fam rooms below $180'
Column CNum format a30 heading 'Most commonly booked room type'
Column P format $999.99 heading 'Price'

prompt
prompt 1. List all rooms (all details) of hotel Glasgow,
prompt sorted by hotel number and then price. 
prompt

Select r.room_no rmNum, r.rtype RType, r.price P
From     Hotel H
Join     Room R  
    on     H.Hotel_no = R.Hotel_no
where H.Hotel_name = 'Glasgow'
order by h.hotel_no, price;

pause;

prompt
prompt 2. List all double or family rooms (all details)  
prompt of hotel Glasgow with a price below 50 per night sorted in ascending order of price.
prompt

Select h.hotel_name hotelNm, r.room_no rmNum, r.rtype RType, r.price P
From Hotel H 
Join Room R
    on   H.Hotel_no = R.Hotel_no
where H.Hotel_name = 'Glasgow' and (Rtype = 'Double' or Rtype = 'Family') and price < 50
order by price asc;

pause;

prompt
prompt 3. For each hotel that has at least 6 bookings, list the hotel name,
prompt hotel number and the number of bookings, sorted by the number of bookings in ascending order. 
prompt

select h.hotel_name hotelNm, h.hotel_no hotelNum, count(b.hotel_no) numBook
from Hotel h
join booking b
    on h.hotel_no = b.hotel_no
group by h.hotel_name, h.hotel_no
having count(b.hotel_no) > 6 
order by count(b.hotel_no) asc;

pause;

prompt
prompt 4. For each hotel, list the hotel name, hotel number and the number of bookings 
prompt during the current month of the current year (bookings that covers at least one 
prompt day of the current month of the current year). A zero should be displayed for hotels 
prompt that don't have any bookings during the current month, and the query should work for any month of any year. 
prompt

Select hotel_name hotelNm, H.Hotel_No hotelNum, count(B.Hotel_no) numCBook
From Hotel H
left join Booking B       
    on H.Hotel_no = B.Hotel_no      
    --and (To_Char(Date_From, 'Month yyyy') <= To_Char(sysDate, 'Month yyyy')           
    --or To_Char(Date_To, 'Month yyyy') >= To_Char(sysDate, 'Month yyyy'))
    and date_from <= last_day(sysDate)
    and date_to > last_day(add_months(sysdate, -1))
Group  by H.Hotel_No, hotel_name
Order by H.Hotel_No;

pause;

prompt
prompt 5. List all guests (all details) currently staying at hotel Grosvenor in London, 
prompt sorted on Guest_no. The query should work for any day. 
prompt

select unique g.guest_no gNum, g.guest_name gNm, g.address 
from guest g
join (select * from booking b join hotel h on h.hotel_no = b.hotel_no 
        where hotel_name = 'Grosvenor' and address like '%London%') T
    on g.guest_no = T.guest_no
    and date_from <= (SysDate)
    and date_to >= (SysDate)
order by g.guest_no;



pause;

prompt
prompt 6. For each hotel that does not have any bookings, 
prompt display the hotel details, sorted on Hotel_No. 
prompt

select h.hotel_no hotelNum, h.hotel_name hotelNm, h.address
from hotel h
where hotel_no in (
select distinct h.hotel_no
from hotel
left join booking b
on h.hotel_no = b.hotel_no
where b.guest_no is null)
order by h.hotel_no;

select * from hotel h 
left join booking b 
on h.hotel = b.hotel_no 
where b.hotel_no is null 
order by h.hotel_no;

select * from hotel 
where hotel_no not in (
select distinct hotel_no from booking);

pause;

prompt
prompt 7. List the rooms (all details) that are currently unoccupied 
prompt at hotel Grosvenor in London. The query should produce correct 
prompt results today and any day in the future. 
prompt

select r.room_no rNum, r.hotel_no hotelNum, r.rtype RTYPE, r.price P
from room r 
join booking b on 
r.room_no = b.room_no
join (select * from hotel where hotel_name = 'Grosvenor' and address like '%London%') T on
T.hotel_no = b.hotel_no
where date_from < (SysDate) and date_to < (SysDate) or  date_from > (SysDate) and date_to > (SysDate)
group by r.room_no, r.hotel_no, r.rtype, r.price
order by r.room_no;



pause;

prompt
prompt 8. For each hotel in London, list the hotel number, hotel name, 
prompt and number of Family rooms with a price below 180. Display a 
prompt zero for hotels in London that do not have specified rooms. 
prompt

Select h.hotel_no hotelNum, h.hotel_name hotelNm, count(r.hotel_no) fNum
from (select * from hotel where address like '%London%') h
left join room r
    on   H.Hotel_no = R.Hotel_no
    and rtype = 'Family'
    and price < 180 
    group by h.hotel_no, h.hotel_name
    order by h.hotel_no;

pause;

prompt
prompt 9. List the guest number, guest name and the number of bookings for 
prompt the current year, sorted by guest_no. Display a zero for guests who 
prompt don't have any bookings for the current year. Your query should work 
prompt for any year. Booking could be longer than one year. 
prompt

select g.guest_no gNum, g.guest_name gNm, count(b.guest_no) numCBook
from guest g
left join booking b
    on g.guest_no = b.guest_no 
    and (To_Char(Date_From, 'yyyy') = To_Char(sysDate, 'yyyy')
      or To_Char(Date_To, 'yyyy') = To_Char(sysDate, 'yyyy') 
      or (To_Char(Date_From, 'yyyy') < To_Char(sysDate, 'yyyy')
      and To_Char(Date_To, 'yyyy') > To_Char(sysDate, 'yyyy')))   
group by g.guest_no, g.guest_name
order by g.guest_no;

pause;

prompt
prompt 10. For each hotel that has at least one booking, list the Hotel number, Hotel name,
prompt and the most commonly booked room type for the hotel (the number of bookings is the largest) 
prompt with the count of bookings for that room type. Notice that multiple types may have the same 
prompt largest number of bookings, and all such types should be listed.
prompt

select h.hotel_no hotelNum, h.hotel_name hotelNm, count(r.rtype) CNum, b.room_no rNum
from hotel h
join booking b
    on h.hotel_no = b.hotel_no
join room r
    on r.hotel_no = h.hotel_no
group by h.hotel_no, h.hotel_name, b.room_no
order by h.hotel_no;


select H.hotel_no, h.hotel_name, r.rtype, count(*)
from hotel H
join room r
    on h.hotel_no = r.hotel_no
join booking b
    on h.hotel_no = b.hotel_no
    and b.room_no = r.room_no
group by h.hotel_no, h.hotel_name, r.rtype
having count(*) >= all
    (select count(*)
    from room r1
    join booking b1
        on r1.hotel_no = b1.hotel_no
        and h.hotel_no = r1.hotel_no
        group by r1.rtype);

pause;

CLEAR COLUMNS