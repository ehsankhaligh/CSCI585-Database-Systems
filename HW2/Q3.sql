/*
Ehsan Hosseinzadeh Khaligh
Den Section
Used: https://livesql.oracle.com/

Q3 (1 point). Below is a small table that tracks work being done on the students' projects. We have a project ID column on the left, a 'step' column in the middle (0,1,2.. denote steps of the project), and a status column on the right (where 'W' denotes 'waiting', 'C' denotes 'completed'). Such a table lets project instructors get a quick status on the various aspects (steps) of their projects ("where they're at", in colloquial, ungrammatical language). Specifically, 'W' would mean that the students are stalled for whatever reason (don't understand what to do, a part broke, they have bugs they can't fix, etc) and need additional help from the instructors - students would have a way to input these (step number, status), and instructors can review the table periodically and run queries like the one you will be creating.
PID        Step  Status

P100       0     C
P100       1     W
P100       2     W
P201       0     C
P201       1     C
P333       0     W
P333       1     W
P333       2     W
P333       3     W
Write a query to output the project(s) where only step 0 has been completed, ie. the project gotten started but the rest of the steps are in waiting mode. In the above table, such a query would output just 'P100'. You can assume that steps get completed in order, ie. P333 will never have C,W,C,W for example [all Cs will occur before all Ws].

*/

DROP TABLE StudentWorkProjects;
--create table

create table StudentWorkProjects(
PID varchar(4),
Step number(1),
Status char(1),
primary key (PID, Step)
);

insert into StudentWorkProjects (PID, Step, Status) values ('P100', 0, 'C');
insert into StudentWorkProjects (PID, Step, Status) values ('P100', 1, 'W');
insert into StudentWorkProjects (PID, Step, Status) values ('P100', 2, 'W');
insert into StudentWorkProjects (PID, Step, Status) values ('P201', 0, 'C');
insert into StudentWorkProjects (PID, Step, Status) values ('P201', 1, 'C');
insert into StudentWorkProjects (PID, Step, Status) values ('P333', 0, 'W');
insert into StudentWorkProjects (PID, Step, Status) values ('P333', 1, 'W');
insert into StudentWorkProjects (PID, Step, Status) values ('P333', 2, 'W');
insert into StudentWorkProjects (PID, Step, Status) values ('P333', 3, 'W');

/*
The ALL operator:

returns a boolean value as a result
returns TRUE if ALL of the subquery values meet the condition
is used with SELECT, WHERE and HAVING statements

SELECT ProductName
FROM Products
WHERE ProductID = ANY
  (SELECT ProductID
  FROM OrderDetails
  WHERE Quantity = 10);

select myproject.PID, myproject.Step, myproject.Status from StudentWorkProjects myproject where myproject.Step != 0 and myproject.Status IN ('W');

*/

select outerStudentWorkProjects.PID
from StudentWorkProjects outerStudentWorkProjects
where outerStudentWorkProjects.Step = 0 and
      outerStudentWorkProjects.Status = 'C' and
      'W' = ALL(select innerStudentWorkProjects.Status
                    from StudentWorkProjects innerStudentWorkProjects
                    where innerStudentWorkProjects.Step != 0
                    and outerStudentWorkProjects.PID = innerStudentWorkProjects.PID
                    );

/*

Explanation: First we query the id with status = c and step = 0
             Then using ALL to match items 'W'; having same id as outter query
             and  inner query step number is not zero

Table dropped.

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

Result Set 10
PID
P100

*/
