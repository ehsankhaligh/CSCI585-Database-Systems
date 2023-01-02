Ehsan Hosseinzadeh Khaligh	
CSCI 585 - DEN SECTION 

Nouns -> entities 
Verbs -> relationships 

First tried to create this readme and then ERD

Entities, Relations, and Attributes

1) Course:
	 Assumption:
		CourseDescription will show details I.e which programming 
	Attributes: 
		CourseID (PK), CourseSyllabus, CourseDescription 


2) Class: 

   Assumption:
    	 They only offer programming class now
   	 Some fields taken from lecture slide
	 ClassFinishDate will be needed in case they change current one week

    Attributes:
    		ClassID (PK),  RoomID (FK1), CourseID (FK2), InstructorID (FK3), ClassTime, ClassDates, ClassStartDate, ClassFinishDate

3) Student:
	Attributes: 
		StudentID (PK),  StudentIFirstName, StudentLastName, StudentEmail, StudentPhone, StudentDOB (Date of Birth), StudentGender, HighSchoolName, StudentCurrentResidingCity, StudentBalance 


4) Project:
	Assumption:
		Each project has one instructor 
		ProjectFinishDate will be needed in case they change current one week
	
	Attributes:
		ProjectID (PK), RoomID (FK1), CourseID (FK2), InstructorID (FK3),  ProjectTime, ProjectDates, ProjectStartDate, ProjectFinishDate

5) Room
	Assumption:
		They may have or will have more buildings 
	Attributes:
		RoomID (PK), BuildingID (FK1), RoomSize,  RoomType

6)  Building 
	Assumption:
		N/A
	Attributes:
		BuildingID (PK), BuildingName, BuildingLocation  

7) Project Enroll 
	Assumption:
		N/A
	Attributes:
		ProjectID (PK,FK1), StudentID (PK,FK2), ProjectEnrollDate, ProjectEnrollGrade


8) Class Enroll 

	Assumption:
		N/A
	Attributes:
		ClassID (PK,FK1), StudentID (PK,FK2), ClassEnrollDate, ClassEnrollGrade

9). Class Rate 

	Assumption:
		N/A
	Attributes:
		ClassRateTransactionID (PK), StudentID (FK1), ClassID (FK2), ClassRate  


10) Project Rate 
	Assumption:
		N/A
	Attributes:
		ProjectRateTransactionID (PK), StudentID (FK1), ProjectID (FK2),  ProjectRate  


11) Instructor Rate 
	Assumption:
		N/A
	Attributes:
		InstructorRateTransactionID (PK), StudentID (FK1), InstructorID (FK2),  InstructorRate  


12) Table 
	Assumption:
		Tables are numbered and may move over time to different rooms.  We need the table to track 
		They may buy tables other than large and square in the future 
		One table may be used for more than a project at different times 
	Attributes:
		TableID (PK), ProjectID (PK, FK1), RoomID (FK2), TableShape, TableSize, TableChairNumbers

13) Table Assign 
	Assumption:
		Tables are in fixed location during the time of course		
	Attributes:
		 TableAssignID (PK), TableID (PK, FK1), ProjectID (FK2), StudentID (FK3)

 
14) Textbook
	Assumption:
		N/A
	Attributes:
		ISBN (PK), CourseID(FK), BookPrice, RecoemndedVendortoBuy 

15) Instructor 

	Assumption:
		N/A
	Attributes:
     		InstructorID(PK), InstructorFirstName, InstructorLastName, InstructorDOB, InstructorAVGClassScore, InstructorGender,  InstructorPhone, InstructorEmail


16) Project Teach  
	Assumption:
		Faculty rating  also given by School used to decide whether to select for next time or not
	Attributes:
		ProjectID (PK,FK1), InstructorID (PK,FK2), FacultyRatingBySchoolForProject, ProjectTeachHoursWorked, ProjectHourlyRate


17) Class Teach  
	Assumption:
		Faculty rating also given by School used to decide whether to select for next time or not
	Attributes:
		ClassID (PK,FK1), InstructorID (PK,FK2), FacultyRatingBySchoolForClass, ClassTeachHoursWorked, ClassHourlyRate

18) parts bag 
	Assumption:
		Damage fee will be charged equality among all students Balance. 
	Attributes:
    	 	PartsBagID (PK), ProjectID (FK), Damaged (Boolean), TotalDamageChargeFee


19) Part order: 
	Assumption:
		 Assuming they may change parts in the future (add or remove) 
		
	Attributes:
      		partID (PK), PartName, VendorInvoiceOrderID,  QuantityOrdered, Vendor, ItemReceived (Boolean), DateReceived, QuantityReceived

     
20) Assigned Parts:
	Assumption:
		 Assigned parts to projects are fixed during term
		Some parts may not be used every term
		Pa
	Attributes:
      		ProjectID (PK,FK1), partID (PK,FK2), numberItemUsed 

21) Library 
	Assumption:
		 Due to book limitations only students can borrow books 
		 We can create a temporary derived attribute to calculate each student's number of borrowed book as it is not needed to store 
	Attributes:
      		BookID (PK), studentID (FK), BookName, BookCategory, BorrowedDate, ExpectedReturnDate 



Additional Notes:
Class Teach, Project Teach, Project Enroll, Class Enroll are composite Entities similar to lecture example
Student can have one to many assigned tables 
A table can have one to many assigned students for different classes assuming all tables are in use 
Student can borrow zero or many books 
A book can be given to zero or one student  assuming Instructors can’t borrow a book
Student can rate one or many instructors -> similar for project and class rate 
A unique instructor rate can belong to only one student -> similar for project and class rate 
A table can have zero or many projects -> Similar for room and project
A Project cab belong to one table -> similar for room and project
A project can have one or many assigned parts and vice versa 
Class and course relation is similar to lecture with the same assumptions 
Room and Building relation is similar to lecture with the same assumptions 
A unique table assignment can belong to only one table assuming all have assignments 
One table can be used for one to many assignments 
Considering an instructor can be on a leave, he/she can teach zero to many classes and oversee classes 
One class or project if not cancelled, can have one or more instructors 
Assigned parts can be ordered by one or more vendors and multiple times. 
An order part can be used for one or more projects 
Project can have one or many parts bag 
A unique parts bag ID can belong to only one project 


