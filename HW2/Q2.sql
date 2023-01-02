/*
Ehsan Hosseinzadeh Khaligh
Den Section
Used: https://livesql.oracle.com/
Q2 (1 point). Given the following portion of the enrollment table, write a query to create a listing that includes class name and the number of students enrolled in the class, sorted in reverse order of enrollment (eg. to tell which were the most popular classes, at the end of the term).

SID  ClassName                     Grade

123  Synthesis algorithms          A
123  EDM synthesis                 B
123  MIDI controllers              B
662  Sound mixing                  B
662  EDM synthesis                 A
662  Electronic Music Fundamentals A
662  MIDI controllers              B
345  MIDI controllers              A
345  Electronic Music Fundamentals B
345  EDM synthesis                 A
555  EDM synthesis                 B
555  Electronic Music Fundamentals B
213  Electronic Music Fundamentals A

Given something like the above, the output could be:


ClassName                     Total

Electronic Music Fundamentals 4
EDM synthesis                 4
MIDI controllers              3
Synthesis algorithms          1
Sound mixing                  1


Read: https://stackoverflow.com/questions/1885630/whats-the-difference-between-varchar-and-char
*/

--1) create the table
--SID, ClassName, Grade cannot be null

DROP TABLE class_enrollment;

--Prep:
--create table
create table class_enrollment (
  SID          number(3) NOT NULL,
  ClassName    varchar(150) NOT NULL,
  Grade        CHAR(1) NOT NULL,
  PRIMARY KEY (SID,ClassName)
);

-- we need two primary keys here since one student can enroll in one or more classes

--insert values to populate
insert into class_enrollment (SID, ClassName, Grade) values (123,'Synthesis algorithms', 'A');
insert into class_enrollment (SID, ClassName, Grade) values (123,'EDM synthesis', 'B');
insert into class_enrollment (SID, ClassName, Grade) values (123,'MIDI controllers', 'B');
insert into class_enrollment (SID, ClassName, Grade) values (662,'Sound mixing', 'B');
insert into class_enrollment (SID, ClassName, Grade) values (662,'EDM synthesis', 'A');
insert into class_enrollment (SID, ClassName, Grade) values (662,'Electronic Music Fundamentals', 'A');
insert into class_enrollment (SID, ClassName, Grade) values (662,'MIDI controllers', 'B');
insert into class_enrollment (SID, ClassName, Grade) values (345,'MIDI controllers', 'A');
insert into class_enrollment (SID, ClassName, Grade) values (345,'Electronic Music Fundamentals', 'B');
insert into class_enrollment (SID, ClassName, Grade) values (345,'EDM synthesis', 'A');
insert into class_enrollment (SID, ClassName, Grade) values (555,'EDM synthesis', 'B');
insert into class_enrollment (SID, ClassName, Grade) values (555,'Electronic Music Fundamentals', 'B');
insert into class_enrollment (SID, ClassName, Grade) values (213,'Electronic Music Fundamentals', 'A');

--DROP TABLE class_enrollment;

select ClassName, count(Grade) as Total from class_enrollment group by ClassName order by Total DESC;

/*
Table created.

1 row(s) inserted.

1 row(s) inserted.

1 row(s) inserted.

1 row(s) inserted.

1 row(s) inserted.

1 row(s) inserted.

1 row(s) inserted.

1 row(s) inserted.

1 row(s) inserted.

1 row(s) inserted.

1 row(s) inserted.

1 row(s) inserted.

1 row(s) inserted.

CLASSNAME	                    TOTAL
Electronic Music Fundamentals	4
EDM synthesis	                4
MIDI controllers            	3
Sound mixing	                1
Synthesis algorithms	        1

*/
