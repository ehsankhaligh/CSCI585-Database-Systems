/*
Ehsan Hosseinzadeh Khaligh
Den Section
Used: https://livesql.oracle.com/

We post job descriptions, to build a list of qualified instructors that we can pick from. Here's an abbreviated table of possible candidates, with just their name and the subject(s) they can teach:

Instructor   Subject

Aleph        MIDI controllers
Aleph        Sound mixing
Aleph        Synthesis algorithms
Bit          EDM synthesis
Bit          Electronic Music Fundamentals
Bit          Sound mixing
CRC          EDM synthesis
CRC          Electronic Music Fundamentals
Dat          MIDI controllers
Dat          EDM synthesis
Dat          Electronic Music Fundamentals
Emscr        MIDI controllers
Emscr        Synthesis algorithms
Emscr        Electronic Music Fundamentals
Emscr        EDM synthesis
Write a query that will pick out just the instructors who can teach every subject in the table below (this is so we can hire a small number of instructors who would be easy to manage, compared to a larger group) - we're deciding to offer just the classes listed below:

Electronic Music Fundamentals
MIDI controllers
EDM synthesis

With the above data, the query would output

Instructor
Dat
Emscr

Visit:
https://stackoverflow.com/questions/33486361/how-to-select-rows-where-that-record-has-multiple-entries
https://stackoverflow.com/questions/2686254/how-to-select-all-records-from-one-table-that-do-not-exist-in-another-table

*/

DROP TABLE candidates;
DROP TABLE teachingSubjects;


create table candidates(
Instructor     varchar(200) not null,
Subject        varchar(200) not null,
primary key(Instructor, Subject)
);

insert into candidates (Instructor, Subject) values ('Aleph','MIDI controllers');
insert into candidates (Instructor, Subject) values ('Aleph','Sound mixing');
insert into candidates (Instructor, Subject) values ('Aleph','Synthesis algorithms');
insert into candidates (Instructor, Subject) values ('Bit','EDM synthesis');
insert into candidates (Instructor, Subject) values ('Bit','Electronic Music Fundamentals');
insert into candidates (Instructor, Subject) values ('Bit','Sound mixing');
insert into candidates (Instructor, Subject) values ('CRC','EDM synthesis');
insert into candidates (Instructor, Subject) values ('CRC','Electronic Music Fundamentals');
insert into candidates (Instructor, Subject) values ('Dat','MIDI controllers');
insert into candidates (Instructor, Subject) values ('Dat','EDM synthesis');
insert into candidates (Instructor, Subject) values ('Dat','Electronic Music Fundamentals');
insert into candidates (Instructor, Subject) values ('Emscr','MIDI controllers');
insert into candidates (Instructor, Subject) values ('Emscr','Synthesis algorithms');
insert into candidates (Instructor, Subject) values ('Emscr','Electronic Music Fundamentals');
insert into candidates (Instructor, Subject) values ('Emscr','EDM synthesis');


create table teachingSubjects(
currentSubject  varchar(200) not null,
primary key(currentSubject)
);

insert into teachingSubjects (currentSubject) values ('Electronic Music Fundamentals');
insert into teachingSubjects (currentSubject) values ('MIDI controllers');
insert into teachingSubjects (currentSubject) values ('EDM synthesis');

--select * from candidates;
--select * from teachingSubjects;

select joinedInstCurrentSubject.INSTRUCTOR
  from (SELECT t1.INSTRUCTOR, t1.Subject
        FROM candidates t1
        LEFT JOIN teachingSubjects t2 ON t2.CURRENTSUBJECT = t1.SUBJECT
        WHERE t2.CURRENTSUBJECT IS NOT NULL) joinedInstCurrentSubject
group by joinedInstCurrentSubject.INSTRUCTOR
having count(*) = (select count(*) from teachingSubjects);

/*

Explanation:
In the inner select, we are left-joining the two tables to only show instructors
able to teach any of the subjects from the teachingSubjects table. As an example, the rows for
instructors able to teach 'Sound mixing' not shown.

SELECT t1.INSTRUCTOR, t1.Subject
FROM candidates t1
LEFT JOIN teachingSubjects t2 ON t2.CURRENTSUBJECT = t1.SUBJECT
WHERE t2.CURRENTSUBJECT IS NOT NULL;

output:

INSTRUCTOR	SUBJECT
Aleph	MIDI controllers
Bit	EDM synthesis
Bit	Electronic Music Fundamentals
CRC	EDM synthesis
CRC	Electronic Music Fundamentals
Dat	EDM synthesis
Dat	Electronic Music Fundamentals
Dat	MIDI controllers
Emscr	EDM synthesis
Emscr	Electronic Music Fundamentals
Emscr	MIDI controllers

Next, we group by INSTRUCTOR and get the count being equal to the count of CURRENTSUBJECT on the teachingSubjects table.
let's say in this case, we have a count of 3 on the teachingSubjects table; instructors having a count of 3 means
they are able to teach all subjects that exist in the teachingSubjects table.

(Final quaery above comment block)

Final output:
INSTRUCTOR
Dat
Emscr

*/
