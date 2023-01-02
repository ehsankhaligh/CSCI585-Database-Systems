/*
Ehsan Hosseinzadeh Khaligh
Den Section
Used: https://livesql.oracle.com/

Q4 (1 point). The owners decide to reward instructors with a bonus, at the end of the term. The bonus (a one-time payout) is calculated, like so:
bonus = hourly_rate * sum_of_class_counts * 0.1
'sum_of_class_counts' is simply a total, of student count from each class an instructor taught - eg. if instructor Dat taught Electronic Music Fundamentals, EDM synthesis and MIDI controllers, with enrollments of 20, 20 and 15 students respectively, the sum_of_class_counts for Dat will be 55 (if a student takes multiple courses - we count that student as many times, not count them as 1). Also, this bonus is just for teaching, not for supervising projects.
Write a query that will output the highest bonus amount paid. Do feel free to create whatever table(s) you need, and populate it/them with your own data.
*/

/*

Assummption:
 1) All instructors are getting paid 55 dollars an hour this semester
 2) In reality we need students and class tables but here not needed to solve the problem
 3) In homework 1, we had a seprate enrolment and teach table but here for simplicity we combine both

Example 1:
CREATE TABLE Orders (
    OrderID int NOT NULL,
    OrderNumber int NOT NULL,
    PersonID int,
    PRIMARY KEY (OrderID),
    FOREIGN KEY (PersonID) REFERENCES Persons(PersonID)
);

Example 2:
DROP TABLE artists;
DROP TABLE tracks;

CREATE TABLE artists (
  myid    number PRIMARY KEY,
  myname  varchar(100)
);

CREATE TABLE tracks (
  traid     number,
  title     varchar(100),
  artist    number,
  FOREIGN KEY(artist) REFERENCES artists(myid)
);

INSERT INTO artists VALUES (1, 'Tom Chapin');
INSERT INTO artists VALUES (2, 'Harry Chapin');


INSERT INTO tracks VALUES (1, 'Great Big Words', 1);
INSERT INTO tracks VALUES (1, 'This Pretty Planet', 1);
INSERT INTO tracks VALUES (2, 'Cats in the Cradle', 2);

SELECT * FROM artists;
SELECT * FROM tracks;

Link: https://www.khanacademy.org/computer-programming/sql-create-table-with-foreign-key-reference/4700108318965760
*/

DROP TABLE enrollment;
DROP TABLE Instructor;

create table Instructor(
instructorId     number(3) not null,
instructorName   varchar(30) not null,
instructorPhone  number(30) not null,
instructorEmail  varchar(30) not null,
rate             number(3) not null,
primary key(instructorId)
);

insert into Instructor (instructorId, instructorName, instructorPhone, instructorEmail, rate) values (780,  'John Smith', 2137401111, 'sm@usc.edu', 55);
insert into Instructor (instructorId, instructorName, instructorPhone, instructorEmail, rate) values (781,  'Marry Smith', 2137401112, 'mm@usc.edu', 55);
insert into Instructor (instructorId, instructorName, instructorPhone, instructorEmail, rate) values (782,  'Dan Smith', 2137401113, 'dm@usc.edu', 55);
insert into Instructor (instructorId, instructorName, instructorPhone, instructorEmail, rate) values (783,  'Joe Smith', 2137401114, 'jm@usc.edu', 55);


create table enrollment(
studentID    number(3) not null,
instructorId  number(3) not null,
classid  number(4) not null,
PRIMARY KEY (studentID,instructorId),
FOREIGN KEY (instructorId) REFERENCES Instructor(instructorId)
);

insert into enrollment (studentID, instructorId, classid) values (123, 780, 1000);
insert into enrollment (studentID, instructorId, classid) values (124, 780, 1000);
insert into enrollment (studentID, instructorId, classid) values (125, 780, 1000);
insert into enrollment (studentID, instructorId, classid) values (126, 780, 1000);

insert into enrollment (studentID, instructorId, classid) values (127, 780, 1002);
insert into enrollment (studentID, instructorId, classid) values (128, 780, 1002);
insert into enrollment (studentID, instructorId, classid) values (129, 780, 1002);
insert into enrollment (studentID, instructorId, classid) values (130, 780, 1002);

insert into enrollment (studentID, instructorId, classid) values (131, 782, 1003);
insert into enrollment (studentID, instructorId, classid) values (132, 782, 1003);

insert into enrollment (studentID, instructorId, classid) values (133, 781, 1004);
insert into enrollment (studentID, instructorId, classid) values (134, 781, 1004);

insert into enrollment (studentID, instructorId, classid) values (135, 783, 1004);
insert into enrollment (studentID, instructorId, classid) values (136, 783, 1004);

--These are scratch steps used to create last one
--select * from Instructor;
--select * from enrollment;
--select count(*) from Instructor;
--select count(*) from enrollment;

--showing instructors and rates
/*
select DISTINCT enrollment.INSTRUCTORID, Instructor.rate
from enrollment
INNER JOIN Instructor ON Instructor.instructorId = enrollment.instructorId;
*/

/*
Result Set 244
INSTRUCTORID	RATE
780	55
783	55
781	55
782	55
*/

--showing instructors and and total students
/*
select INSTRUCTORID, count(*) as totalStudents
from enrollment
group by INSTRUCTORID;
*/

/*
INSTRUCTORID	TOTALSTUDENTS
781	2
782	2
783	2
780	8
*/

--showing instructors and their bonus - manuall  calculation
/*
select INSTRUCTORID, (TOTALSTUDENTS * 55 * 0.1) as HighestBones
from (select INSTRUCTORID, count(*) as totalStudents
      from enrollment
      group by INSTRUCTORID
     );
*/

/*
 INSTRUCTORID	HIGHESTBONES
 781	11
 782	11
 783	11
 780	44
*/

--showing instructors, their rates, and totalstudents
/*
SELECT *
FROM (select INSTRUCTORID, count(*) as totalStudents from enrollment group by INSTRUCTORID)
NATURAL JOIN (select DISTINCT enrollment.INSTRUCTORID, Instructor.rate from enrollment INNER JOIN Instructor ON Instructor.instructorId = enrollment.instructorId);
*/

/*
INSTRUCTORID	TOTALSTUDENTS	RATE
781	2	55
782	2	55
783	2	55
780	8	55
*/


--showing calculated bonus rates per distinct faculty
/*
select INSTRUCTORID, (TOTALSTUDENTS * RATE * 0.1) as HighestBones
from (SELECT *
      FROM (select INSTRUCTORID, count(*) as totalStudents from enrollment group by INSTRUCTORID)
      NATURAL JOIN (select DISTINCT enrollment.INSTRUCTORID, Instructor.rate from enrollment INNER JOIN Instructor ON Instructor.instructorId = enrollment.instructorId)
     );
*/

/*
 INSTRUCTORID	HIGHESTBONES
 781	11
 782	11
 783	11
 780	44
 Download CSV
*/

--Final Query: Table showing highest bonus rate
select max(rateTable.HIGHESTBONES) as InstructorHighestBonus
from (select INSTRUCTORID, (TOTALSTUDENTS * RATE * 0.1) as HighestBones
       from (SELECT *
             FROM (select INSTRUCTORID, count(*) as totalStudents from enrollment group by INSTRUCTORID)
              NATURAL JOIN (select DISTINCT enrollment.INSTRUCTORID, Instructor.rate from enrollment INNER JOIN Instructor ON Instructor.instructorId = enrollment.instructorId)
            )
     ) rateTable;

 /*
 INSTRUCTORHIGHESTBONUS
 44
 */
