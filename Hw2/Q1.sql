/*
Ehsan Hosseinzadeh Khaligh
Den Section
Used: https://livesql.oracle.com/

Q1 (1 point). To work on their projects, each student group (who sit in numbered tables, as described in HW1) can also (in addition to working at those numbered tables) reserve one of ten available rooms to work on their project. The rooms can be reserved for a block of a few hours (eg. 3 hours), with a start time and end time, eg. 3pm-6pm, 9am-2pm etc. At the end of the day, everyone goes home, so there's no possibility of rooms being booked for multiple days. The table structure you are asked to use, is this [you might need to change the syntax slightly, to make it work on your specific platform - same for other questions that follow]:
CREATE TABLE ProjectRoomBookings
(roomNum INTEGER NOT NULL,
startTime INTEGER NOT NULL,
endTime INTEGER NOT NULL,
groupName CHAR(10) NOT NULL,
PRIMARY KEY (roomNum, startTime));
There are two issues with the above. First, the start time could be incorrectly entered to be later than the end time. Second, a new entry (for a new group) could be accidentally put in to occupy a room, even before the existing group in that room is done using that room. For simplicity, you can express times in the 24h 'military-style' format, eg. 9 for 9AM, 17 for 5PM, etc. For further simplicity, all bookings start and end 'on the hour', so, ints between 7 (7AM) and 18 (6PM) should be sufficient.
How would you redesign the table to fix both these issues? For your answer, you can either provide a textual explanation, and/or provide SQL statements. Hint - "do not be concerned with efficiency" - ANY working solution is acceptable :) Another hint - no need to learn new techniques/syntax.

Summary:

10 rooms
rooms can be reserved block of hours (3h) just for that day
At the end of the day, everyone goes home, so there's no possibility of rooms being booked for multiple days.


issues:
the start time could be incorrectly entered to be later than the end time
a new entry (for a new group) could be accidentally put in to occupy a room, even before the existing group in that room is done using that room

Example:
CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    City varchar(255),
    CONSTRAINT CHK_Person CHECK (Age>=18 AND City='Sandnes')
);
*/


/*
The first fix is to add these constraints to the create table cmd
constraints to check:
   1) open and close time of building should be between 7 and 18 -> 'Fixes First, the start time could be incorrectly entered to be later than the end time.'
   2) Room Numbers are between 1 and 10
   3) in reservation startTime < endTime
*/
DROP TABLE ProjectRoomBookings;

CREATE TABLE ProjectRoomBookings
(roomNum INTEGER NOT NULL,
startTime INTEGER NOT NULL,
endTime INTEGER NOT NULL,
groupName CHAR(10) NOT NULL,
PRIMARY KEY (roomNum, startTime),
constraint timecheck check (startTime < endTime),
constraint earliest check (7 <= startTime),
constraint lastestReservation check (endTime <= 18),
constraint roomResvCheck check (1 <= roomNum AND roomNum <= 10)
);

/*
Trigger: A trigger is a stored procedure in database which automatically invokes whenever a special event in the database occurs. For example, a trigger can be invoked when a row is inserted into a specified table or when certain table columns are being updated.
CREATE
[DEFINER = { user | CURRENT_USER }]
TRIGGER trigger_name
trigger_time trigger_event
ON tbl_name FOR EACH ROW
trigger_body
trigger_time: { BEFORE | AFTER }
trigger_event: { INSERT | UPDATE | DELETE }


To check the room number if its double booked at the same time or not:
(Second, a new entry (for a new group) could be accidentally put in to occupy a room, even before the existing group in that room is done using that room)

Assuming rooms all are the same size, and students do not have any preference on room number - just need to book something.
Assuming one group can book more than a room in case they would like to split working in separate subgroups

We create a trigger i.e called ProjectRoomBookings_trigger
before the insertion, for each row we check and update
  if room number is overlapping the time its booked,
    a. it picks another room at the same time if available
    b. if no room is available at that time, it picks the first room available for an hour.
       The users have an option or reject (in front end).
    c. If no room is available, it throws an error.
*/
