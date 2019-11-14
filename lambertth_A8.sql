-----------------------------------------------------------------------------
-- Name        : Thomas Lambert
--
-- UserName    : lambertth
--
-- Date        : 4/2/2019
--
-- Course      : CS 3630 
--               Section 1
--
-- Assignment 8: 10 points
--               Queries on single tables
--
-- Note        : A booking could be longer than a month, 
--               but not longer than a year.
--
-- Due Date    : Friday, April 5, by 11 PM
--               Drop your UserName_A8.sql to the DropBox on the K: drive.
-----------------------------------------------------------------------------
--Select Format(price, 'C')
--from room;

Column RType format a9 heading 'Room Type'
Column GuestNum format a7 heading 'Guest #'
Column NumGuestBookings format 999 heading '# of Bookings'
Column April2005Bookings format 99 heading 'April Bookings'
Column hotelNum format a7 heading 'Hotel #'

Column noOfBookings format 99 heading '# Bookings'
Column RoomNum format a6 heading 'Room #'
Column guestName format a10 heading 'Guest Name'
Column distGuest format a20 heading '# of distinct Guests'

Column theRoomPrice format $999.99 heading 'Room Price'
Column AvgPrice format $999.99 heading 'Average Price'
Column maxPrice format $999.99 heading 'MAX(Price)'
Column minPrice format $999.99 heading 'MIN(Price)'
Column recentBooking format a19 heading 'Latest Booking Date'

prompt
prompt 1. List the names and addresses of all guests from London 
prompt    (Address contains string "London"),
prompt    sorted by name in ascending order.
prompt

Select guest_name "Guest Name", address "Address"
From Guest
Where address like '%London%'
Order by guest_name;

pause;

prompt
prompt  2.  List all guests whose address is missing.
prompt

Select guest_no GuestNum, Guest_name "Guest Name", address addressT
From Guest
Where address is null;

pause;

prompt
prompt 3.  List all double or family rooms with a price below 40 per night,
prompt     sorted in ascending order of price.
prompt

Select room_no RoomNum, Hotel_no hotelNum, rtype RType, price theRoomPrice
From Room
Where (rtype = 'Family' or rtype = 'Double') and price < 40
order by price;

pause;

prompt 
prompt 4.  For all room types, list the type and the average price, 
prompt     sorted by the average price in descending order.
prompt

Select rtype RType, avg(price) AvgPrice
From Room
group by rtype
order by avg(Price) desc;

pause;

prompt
prompt 5.  Display the number of different guests (not Guest_No) 
prompt     who have bookings during April 2005
prompt     (bookings that contains at least one day of April 2005).
prompt

Select count(distinct guest_no) distGuest
from booking
where not Date_from > '30-Apr-05' and not Date_to < '1-Apr-05';

pause;

prompt
prompt 6.  For each guest who has made at least one booking, 
prompt     list the guest number and the total number of bookings 
prompt     the guest has made, sorted by guest number.
prompt

Select guest_no GuestNum, Count(*) NumGuestBookings
from booking
Group by guest_no
order by guest_no;

pause;

prompt
prompt 7.  For each hotel that has at least one booking during April 2005
prompt     (bookings that contains at least one day of April 2005),
prompt     list the hotel number, the total number of bookings the hotel 
prompt     has for April 2005 and the latest Date_from for such bookings, 
prompt     sorted by the total number of bookings.
prompt

Select hotel_no hotelNum, count(*) April2005Bookings, to_char(max(date_from), 'Month dd yyyy') recentBooking
from booking
where (Date_from between '1-Apr-05' and '30-Apr-05') or (Date_to between '1-Apr-05' and '30-Apr-05')
group by hotel_no
order by count(*);

pause;

prompt
prompt 8.  List all bookings that start in the current month of the current year.
prompt     The query should work for any month of any year without modification.
prompt

select hotel_no hotelNum, guest_no GuestNum, to_char(date_from, 'Month dd yyyy') "Start date", 
to_char(date_to, 'Month dd yyyy')"End Date", room_no
from booking
where date_from > Last_Day(Add_Months(SysDate, -1)) and date_from <= last_day(SysDate);

pause;

prompt
prompt 9.  For each room type of each hotel, list the hotel number, room type, 
prompt     the highest and the lowest room prices for the room type.
prompt     Sort the result by hotel number and then room type.
prompt

select hotel_no hotelNum, rtype RType, max(price) maxPrice, min(price) minPrice
from room
group by rtype, hotel_no
order by hotel_no, rtype;

pause;

prompt
prompt 10. For each room type of each hotel with the highest price at least 100 
prompt     or the lowest price at most 30, list the hotel number and room type 
prompt     with the highest and the lowest room prices,
prompt     sorted by hotel_no and the highest price.
prompt

select hotel_no hotelNum, rtype RType, max(price) maxPrice, min(price) minPrice
from room

group by hotel_no, rtype
having max(price) >= 100 or max(price) <= 30
order by hotel_no, max(price) desc;