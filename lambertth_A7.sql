-----------------------------------------------------------------------------
-- Name        : Thomas Lambert
--
-- UserName    : lambertth
--
-- Date        : 3/29/2019
--
-- Course      : CS 3630
--               Section 1
--
-- Assignment 7: 5 points
--               Create tables with constraints
--               Need to drop tables first
--               Drop tables in the reserve order they were created.
--
-- Due Date    : Friday, March 29, at 11 PM
--               Upload your UserName_A7.sql to Canvas.
-----------------------------------------------------------------------------
Drop table booking;
Drop table Guest;
Drop table Room;
Drop table Hotel;

Create table Hotel (
    Hotel_No    char(3)  Primary Key,
    Hotel_Name  varchar2(15) Not Null,
    Address     varchar2(30) Not Null);

Create table Room (
    Room_No     char(4),
    Hotel_No    char(3),
    RType       char(6)   Check (RType IN('Single', 'Double', 'Family'))
                          Not Null,
    Price       number    Not Null Check (Price between 30 and 200),
                          
    Primary Key (Hotel_No, Room_No),
    Foreign Key (Hotel_No) references Hotel(Hotel_No)
    );
    
Create table Guest (
    Guest_No    char(6) Primary key,
    Guest_Name  varchar(30) Not Null,
    address     varchar(40)
    );
    
Create table Booking (
    Hotel_No    char(3),
    Guest_No    char(6) references Guest,
    Date_From   date,
    Date_To     date,
    Room_No     char(4),
    
    Primary Key (Hotel_No, Room_No, Date_From),
    Foreign Key (Hotel_No, Room_No) references Room
    );
                 


Insert into Hotel
    Values ('H01', 'Grosvenor', 'London');
Insert into Hotel
    Values ('H05', 'Glasgow', 'London');
Insert into Hotel
    Values ('H07', 'Aberdeen',  'London');
Insert into Hotel
    Values ('H12', 'London',    'Glasgow');
Insert into Hotel
    Values ('H16', 'Aberdeen',  'Glasgow');
Insert into Hotel
    Values ('H24', 'London',    'Aberdeen');
Insert into Hotel
    Values ('H28', 'Glasgow',   'Aberdeen');
    
Insert into Room
    Values ('R001', 'H01', 'Single', 30);
Insert into Room
    Values ('R002','H01', 'Single', 100);
Insert into Room
    Values ('R103', 'H01', 'Double', 30);
Insert into Room
    Values ('R105', 'H01', 'Double', 119);
Insert into Room
    Values ('R209', 'H01', 'Family', 150);
Insert into Room
    Values ('R219', 'H01', 'Family', 190);
Insert into Room
    Values ('R001', 'H05', 'Double', 39);
Insert into Room
    Values ('R003', 'H05', 'Single', 40);
Insert into Room
    Values ('R103', 'H05', 'Single', 55);
Insert into Room
    Values ('R101', 'H05', 'Double', 40);
Insert into Room
    Values ('R104', 'H05', 'Double', 105);
Insert into Room
    Values ('R104', 'H07', 'Double', 100);
Insert into Room
    Values ('R105', 'H12', 'Double', 45);
Insert into Room
    Values ('R201', 'H12', 'Family', 80);
Insert into Room
    Values ('R003', 'H28', 'Family', 49.95);
    
Insert into Guest
    Values('G01003', 'John White', '6 Lawrence Street, Glasgow');
Insert into Guest
    Values('G01011', 'Mary Tregear', '5 Tarbot Rd, Aberdeen');
Insert into Guest
    Values('G02003', 'Aline Stewart', '64 Fern Dr, London');
Insert into Guest
    Values('G02005', 'Mike Ritchie', '18 Tain St, London, W1H 7DL, England');
Insert into Guest
    Values('G02007', 'Joe Keogh', Null);
Insert into Guest
    Values('G12345', 'CS 3630',       'London');
Insert into Guest
    Values('G02008', 'Scott Summers', 'London, W1H 7DL, England');
    
Insert into Booking
    Values('H01', 'G01003', '5-Apr-2004', '14-May-2004', 'R001');
Insert into Booking
    Values('H01', 'G02003', '24-Apr-2004', '26-Apr-2004', 'R103');
Insert into Booking
    Values('H01', 'G01011', '25-Apr-2004', '30-Apr-2004', 'R209');
Insert into Booking
    Values('H05', 'G01003', '05-May-2005', '14-May-2005', 'R003');
Insert into Booking
    Values('H05', 'G02003', '14-Apr-2005', '16-Apr-2005', 'R101');
Insert into Booking
    Values('H05', 'G01011', '15-Apr-2005', '16-Apr-2005', 'R003');
Insert into Booking
    Values('H05', 'G02003', '12-Mar-2005', '15-May-2005', 'R003');
Insert into Booking
    Values('H01', 'G01011', '11-Mar-2005', '30-Apr-2005', 'R103');
Insert into Booking
    Values('H01', 'G02007', '11-Apr-2005', '02-Sep-2005', 'R001');
Insert into Booking
    Values('H28', 'G01003', '11-Mar-2005', '30-Apr-2005', 'R003');
Insert into Booking
    Values('H28', 'G01003', '01-Jan-2010', '10-Jan-2010', 'R003');
Insert into Booking
    Values('H05', 'G02003', '12-Mar-2019', '15-May-2019', 'R003');
Insert into Booking
    Values('H01', 'G01011', '11-Mar-2019', '30-Apr-2019', 'R103');
Insert into Booking
    Values('H01', 'G02007', '11-Apr-2019', '02-Sep-2019', 'R001');
Insert into Booking
    Values('H01', 'G02007', '11-Jan-2019', '22-Jan-2019', 'R001');
Insert into Booking
    Values('H07', 'G02007', '15-Apr-2018', '02-May-2019', 'R104');
    
commit;