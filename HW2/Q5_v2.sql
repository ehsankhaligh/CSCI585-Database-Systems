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

select t1.Instructor
from candidates t1
where t1.Subject IN (select t2.currentSubject
                     from teachingSubjects t2)
group by t1.Instructor
having count(t1.Instructor) = (select count(currentSubject) from teachingSubjects);


/*
Explanation:

1) we use IN to show the instructors from the candidates table whose teaching subjects match items in eachingSubjects table.
2) We are grouping by Instructor and adding a count condition inside having to get the number instructors' teaching subjects equal to the items in teachingSubjects table.

INSTRUCTOR
Dat
Emscr

*/
