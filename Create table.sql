--Admin table--
CREATE TABLE Admin
(
    Admin_id VARCHAR(10)   PRIMARY KEY NOT NULL,
	AName VARCHAR(20),
	Degree VARCHAR(50), 
	Skills VARCHAR(MAX)
);

ALTER TABLE Admin ADD login_id VARCHAR(10) ;
ALTER TABLE Admin ADD FOREIGN KEY (login_id) REFERENCES Login(Login_id) ON DELETE CASCADE ON UPDATE CASCADE;

UPDATE Admin 
SET login_id='L00000000'
WHERE Admin_id='A00000000';

--Auto-Generate admin_id
DECLARE @admin_id VARCHAR(10);
BEGIN

EXEC sp_idgenerator @tablename='Admin', @id=@admin_id OUTPUT;
INSERT INTO Admin(Admin_id , AName , Degree , Skills ,  login_id)
VALUES(@admin_id,'Harry Potter','Bsc Computer Science','problem-solving,good analytical,communication and negotiation',NULL);

	SELECT 'Auto Generated Admin_id created' AS 'Success';
	PRINT 'INSERT SUCCESSFUL';
 END

--Application table--
CREATE TABLE Application
(
    job_id   VARCHAR(10) FOREIGN KEY REFERENCES Jobs(Job_id),
	User_id VARCHAR(10)  FOREIGN KEY REFERENCES Jobseeker(User_id),
    Status       VARCHAR(15) CHECK(Status IN ('Permanent' , 'Trainee' , 'Contract' )),
    Date_Applied DATETIME   ,
    Closing_Date DATETIME,
	PRIMARY KEY(job_id ,User_id)
);


INSERT INTO Application 
VALUES('J00000000','Js00000001','Contract','2019-02-12 08:23:10','2019-03-30 17:00:00'); 


INSERT INTO Application 
VALUES( 'J00000000','Js00000002','Permanent','2019-02-13 02:23:23','2019-02-25 17:00:00');


INSERT INTO Application 
VALUES( 'J00000001','Js00000003','Contract','2019-01-30 10:53:25','2019-01-31 17:00:00');


INSERT INTO Application 
VALUES('J00000002','Js00000003','Trainee','2018-12-31 15:50:03','2019-01-30 17:00:00');


INSERT INTO Application
VALUES('J00000003','Js00000004','Trainee','2019-01-31 06:00:00','2019-03-30 17:00:00');


INSERT INTO Application
VALUES( 'J00000004','Js00000005','Permanent','2019-01-01 14:06:09','2019-01-30 17:00:00');

INSERT INTO Application
VALUES('J00000005','Js00000000','Contract','2018-11-23 17:00:00','2019-01-01 17:00:00');



--Employer table--

CREATE TABLE Employer
(
    Emp_id       VARCHAR(10)     PRIMARY KEY     NOT NULL,
    Efname        VARCHAR(60),
	Elname        VARCHAR(60),
    Company_Name VARCHAR(60),
    Address      VARCHAR(200),
    Position     VARCHAR(100) DEFAULT'Human Resources',
   
);

ALTER TABLE Employer ADD login_id VARCHAR(10) ;
ALTER TABLE Employer ADD FOREIGN KEY (login_id) REFERENCES login(Login_id) ;



DECLARE @Emp_id VARCHAR(10)
BEGIN

EXEC sp_idgenerator @tablename='Employer', @id=@Emp_id OUTPUT;
INSERT INTO Employer
VALUES(@Emp_id,'Stephanie',' Smith','PVC LMT','Rose Hill','Executive Manager',NULL);
end
EXEC sp_idgenerator @tablename='Employer', @id=@Emp_id OUTPUT;
INSERT INTO Employer
VALUES(@Emp_id,'Bob',' Brown','Accenture', 'Paille','Human Resources',NULL);

EXEC sp_idgenerator @tablename='Employer', @id=@Emp_id OUTPUT;
INSERT INTO Employer
VALUES(@Emp_id,'Mary',' Yagami','KPMG','Phoneix','M.Director',NULL);

EXEC sp_idgenerator @tablename='Employer', @id=@Emp_id OUTPUT;
INSERT INTO Employer
VALUES(@Emp_id,'Alan',' Wong','Ceridian', 'Curepipe','Human Resources',NULL);

EXEC sp_idgenerator @tablename='Employer', @id=@Emp_id OUTPUT;
INSERT INTO Employer
VALUES(@Emp_id,'Light',' Chan','Procivil LMT', 'Grand-Baie','Human Resources',NULL);

EXEC sp_idgenerator @tablename='Employer', @id=@Emp_id OUTPUT;
INSERT INTO Employer
VALUES(@Emp_id, 'Kurt',' Wesley','IFMA', 'Flacq', 'Human Resources',NULL);

EXEC sp_idgenerator @tablename='Employer', @id=@Emp_id OUTPUT;
INSERT INTO Employer
VALUES(@Emp_id,'Alan',' Shinigami','Work Solvz', 'Vacoas', 'M.Director',NULL);
SELECT 'Auto Generated Emp_id created' AS 'Success';
	PRINT 'INSERT SUCCESSFUL';
END

UPDATE Employer
SET login_id='L00000001'
WHERE Emp_id='E00000000';

UPDATE Employer
SET login_id='L00000005'
WHERE Emp_id='E00000001';

UPDATE Employer
SET login_id='L00000007'
WHERE Emp_id='E00000002';

UPDATE Employer
SET login_id='L00000008'
WHERE Emp_id='E00000003';

UPDATE Employer
SET login_id='L00000009'
WHERE Emp_id='E00000004';

UPDATE Employer
SET login_id='L00000010'
WHERE Emp_id='E00000005';

UPDATE Employer
SET login_id='L00000011'
WHERE Emp_id='E00000006';

--Jobs table--
CREATE TABLE Jobs(
    Job_id					 VARCHAR(10)    PRIMARY KEY NOT  NULL,
    Title					 VARCHAR(100),
    Description				 VARCHAR(200),
    Working_Experience_Required  DECIMAL(9,3) ,
    Basic_Salary        INT ,
    Location            VARCHAR(40) ,
    Post_date           DATETIME,
    Field               VARCHAR(30) CHECK(Field IN ('IT' , 'Accounting' , 'Management','Finance' , 'Languages' , 'Life Science' , 'Engineering' , 'Others' )),

);
ALTER TABLE Jobs ADD Emp_id VARCHAR(10) ;
ALTER table Jobs ADD FOREIGN KEY (Emp_id) REFERENCES Employer(Emp_id) ON DELETE CASCADE ON UPDATE CASCADE ;

DECLARE @Jobs_id VARCHAR(10)
BEGIN

EXEC sp_idgenerator @tablename='Jobs', @id=@Jobs_id OUTPUT;
INSERT INTO Jobs
VALUES(@Jobs_id,'IT Analyst','Design & information system implementation',2,30000,'Ebene','2018-08-24 16:00:00','IT', NULL );

EXEC sp_idgenerator @tablename='Jobs', @id=@Jobs_id OUTPUT;
INSERT INTO Jobs
VALUES(@Jobs_id,'accounts officer','account for purchase invoices',1,15000,'Port-louis','2018-08-12 16:00:00','Finance',NULL);

EXEC sp_idgenerator @tablename='Jobs', @id=@Jobs_id OUTPUT;
INSERT INTO Jobs
VALUES(@Jobs_id,'quality assurance officer','Train process owners,employees and new recruits on processes and updates',1,20000,'Quatre-Bornes','2018-03-12 16:00:00','Management', NULL);

EXEC sp_idgenerator @tablename='Jobs', @id=@Jobs_id OUTPUT;
INSERT INTO Jobs
VALUES(@Jobs_id,'admininistrative and sales coordinator',' sales of products' , 0 , 10000 , 'Port-louis','2018-12-24 16:00:00','Finance',NULL);

EXEC sp_idgenerator @tablename='Jobs', @id=@Jobs_id OUTPUT;
INSERT INTO Jobs
VALUES(@Jobs_id,'software engineer','technical software support' ,4 ,30000,'Ebene','2018-08-31 16:00:00','IT',NULL);

EXEC sp_idgenerator @tablename='Jobs', @id=@Jobs_id OUTPUT;
INSERT INTO Jobs
VALUES(@Jobs_id,'front end developer-javascript', 'a developer who is keen to excel in JavaScript development, has an eye for detail and a focus on problem solving both before and during the build process.', 3,40000,'Ebene','2018-08-31 16:00:00','IT',NULL);

EXEC sp_idgenerator @tablename='Jobs', @id=@Jobs_id OUTPUT;
INSERT INTO Jobs
VALUES(@Jobs_id,'HR lead','Be the primary backup for payroll processing',2,35000,'Port-louis','2018-12-24 16:00:00','Management',NULL);
SELECT 'Auto Generated Jobs_id created' AS 'Success';
	PRINT 'INSERT SUCCESSFUL';
END

UPDATE Jobs
SET Emp_id='E00000000'
WHERE Job_id='J00000000';

UPDATE Jobs
SET Emp_id='E00000003'
WHERE Job_id='J00000003';

UPDATE Jobs
SET Emp_id='E00000006'
WHERE Job_id='J00000006';

UPDATE Jobs
SET Emp_id='E00000005'
WHERE Job_id='J00000005';

UPDATE Jobs
SET Emp_id='E00000004'
WHERE Job_id='J00000004';

UPDATE Jobs
SET Emp_id='E00000002'
WHERE Job_id='J00000002';

UPDATE Jobs
SET Emp_id='E00000001'
WHERE Job_id='J00000001';

--Jobseeker table--
CREATE TABLE Jobseeker
(
    User_id       VARCHAR(10)     PRIMARY KEY NOT NULL,
    Name          VARCHAR(20) NOT NULL,
    Nationality   VARCHAR(40) DEFAULT 'Mauritian',
    Address       VARCHAR(60),
    phone_no      VARCHAR(8)  UNIQUE CHECK(LEN(phone_no)=8),
    DOB           DATE,
	Working_Experience_YEAR DECIMAL(9,3),
    Experience_Acquired    VARCHAR(MAX),
    Skills        VARCHAR(MAX),
    Qualification VARCHAR(MAX),
	Login_id VARCHAR(10) FOREIGN KEY  REFERENCES Login(Login_id) ON DELETE CASCADE ON UPDATE CASCADE
);

DECLARE @User_id VARCHAR(10)
BEGIN
EXEC sp_idgenerator @tablename='Jobseeker', @id=@User_id OUTPUT;
INSERT INTO Jobseeker
VALUES(@User_id,'Missa Young', 'Mauritian','Rose-hill',56548977,'1989-01-16',0.166, 'Intership at Telecom' ,'communication skills', 'Bsc Electronics',NULL);


EXEC sp_idgenerator @tablename='Jobseeker', @id=@User_id OUTPUT;
INSERT INTO Jobseeker
VALUES(@User_id,'Shiro L','Mauritian','Roches-Brunes',56854379,'1967-03-24',0.5,'Trainee at Solvz','analytical skills' ,'Bsc Computer engineering',NULL);

EXEC sp_idgenerator @tablename='Jobseeker', @id=@User_id OUTPUT;
INSERT INTO Jobseeker
VALUES(@User_id,'Kira Small','Mauritian','Vacoas',59875437,'2000-02-29',2,'Junior clerk' ,'customer service' ,'HSC',NULL);

EXEC sp_idgenerator @tablename='Jobseeker', @id=@User_id OUTPUT;
INSERT INTO Jobseeker
VALUES(@User_id,'Dora Win','Mauritian','Virginia',59762680,'1988-04-20', 0,NULL ,'Communicatiion skills', 'Bsc Finance',NULL);

EXEC sp_idgenerator @tablename='Jobseeker', @id=@User_id OUTPUT;
INSERT INTO Jobseeker
VALUES(@User_id,'Elite Ryuk','Irish','Tamarin',50765367,'1978-11-02',4,'Senior Software engineer','Leadership', 'Phd software Engineering',NULL);

EXEC sp_idgenerator @tablename='Jobseeker', @id=@User_id OUTPUT;
INSERT INTO Jobseeker
VALUES(@User_id,'Shina Pearl','Mauritian','Rose-hill',52457899,'1992-03-24',1,'Junior accounting clerk','Time management skills','ACCA',NULL);

EXEC sp_idgenerator @tablename='Jobseeker', @id=@User_id OUTPUT;
INSERT INTO Jobseeker
VALUES(@User_id,'Jean Louis','Haitian','St-Pierre',59876432,'1998-12-12',6,'Project manager','Analytical skills','Msc management',NULL);
SELECT 'Auto Generated User_id created' AS 'Success';
	PRINT 'INSERT SUCCESSFUL';
END

UPDATE Jobseeker
SET  Login_id='L00000002'
WHERE User_id='Js00000000';

UPDATE Jobseeker
SET Login_id='L00000003'
WHERE User_id='Js00000001';

UPDATE Jobseeker
SET  Login_id='L00000004'
WHERE User_id='Js00000002';

UPDATE Jobseeker
SET  Login_id='L00000006'
WHERE User_id='Js00000003';

UPDATE Jobseeker
SET Login_id='L00000012'
WHERE User_id='Js00000004';

UPDATE Jobseeker
SET  Login_id='L00000013'
WHERE User_id='Js00000005';

UPDATE Jobseeker
SET  Login_id='L00000014'
WHERE User_id='Js00000006';

--Phone number table--
CREATE TABLE phone_number
(
    Emp_id  VARCHAR(10) REFERENCES Employer(Emp_id) ON DELETE CASCADE ON UPDATE CASCADE,
    Phone_no1 VARCHAR(8) UNIQUE  CHECK(LEN(Phone_no1)=8) , check(Phone_no1 like '5%')  ,
    Phone_no2 VARCHAR(8) UNIQUE  CHECK(LEN(Phone_no2)=8) ,check( Phone_no2 LIKE '5%'), 
	PRIMARY KEY(Emp_id)
);


INSERT INTO Phone_number 
VALUES('E00000000',57528235,57456715);


INSERT INTO phone_number
VALUES('E00000001',57192930,51234567);


INSERT INTO phone_number
VALUES('E00000002',57393206,58971234);


INSERT INTO phone_number
VALUES('E00000003',59807657,59714567);


INSERT INTO phone_number
VALUES('E00000004',59854326,51269745);


INSERT INTO phone_number
VALUES('E00000005',57219748,59876549);


INSERT INTO phone_number
VALUES('E00000006',57392303,59863159);


--Login table--
CREATE TABLE Login
(
    Login_id        VARCHAR(10) PRIMARY KEY NOT NULL,
    Username        VARCHAR(40) NOT NULL UNIQUE,
    Password        VARBINARY(MAX) ,
	Email           VARCHAR(MAX)      CHECK(Email LIKE ('%@%.%')),
	Log_in_time     DATETIME ,
	Log_out_time    DATETIME ,
    Classification  VARCHAR(60) CHECK(Classification IN ('Admin' , 'Employer' , 'Jobseeker' ))
);

DECLARE @Login_id VARCHAR(10)
BEGIN

EXEC sp_idgenerator @tablename='Login', @id=@Login_id OUTPUT;
INSERT INTO Login
VALUES (@Login_id,'mradmin',ENCRYPTBYPASSPHRASE('tdi202','fairytail0'),'harrypotter@hogwart.com','2019-03-07  16:05:12','2019-03-07  18:10:12','Admin');


EXEC sp_idgenerator @tablename='Login', @id=@Login_id OUTPUT;
INSERT INTO Login
VALUES (@Login_id,'clight',ENCRYPTBYPASSPHRASE('tdi202','onepiece'),'kagamilight@deathnote.com','2019-03-07 10:05:23','2019-03-07 15:05:23','Employer');

EXEC sp_idgenerator @tablename='Login', @id=@Login_id OUTPUT;
INSERT INTO Login
VALUES (@Login_id,'cjazz',ENCRYPTBYPASSPHRASE('tdi202','deathnote0'),'jazz@gmail.com','2019-01-06 05:00:00','2019-01-06 05:45:00','Jobseeker');

EXEC sp_idgenerator @tablename='Login', @id=@Login_id OUTPUT;
INSERT INTO Login
VALUES (@Login_id,'mhass',ENCRYPTBYPASSPHRASE('tdi202','kiminonawa'),'mhass@yahoo.mu','2019-02-06 02:30:00','2019-02-06 03:30:10','jobseeker');

EXEC sp_idgenerator @tablename='Login', @id=@Login_id OUTPUT;
INSERT INTO Login
VALUES (@Login_id,'g.hussen',ENCRYPTBYPASSPHRASE('tdi202','psw0rd'),'ghussen@outlook.mu','2018-12-31 10:05:23','2018-12-31 16:05:23','jobseeker');

EXEC sp_idgenerator @tablename='Login', @id=@Login_id OUTPUT;
INSERT INTO Login
VALUES (@Login_id,'kwesley',ENCRYPTBYPASSPHRASE('tdi202','Pasword'),'kwesley@megamail.com','2019-02-18 16:30:23','2019-02-18 20:30:23','Employer');

EXEC sp_idgenerator @tablename='Login', @id=@Login_id OUTPUT;
INSERT INTO Login
VALUES (@Login_id,'mrsearch',ENCRYPTBYPASSPHRASE('tdi202','paword'),'searching@hotmail.fr','2019-01-23 17:25:06','2019-01-23 18:20:06','Jobseeker');

EXEC sp_idgenerator @tablename='Login', @id=@Login_id OUTPUT;
INSERT INTO Login
VALUES (@Login_id,'blackclover',ENCRYPTBYPASSPHRASE('tdi202','asta07'),'asta@blackclover.com','2019-03-07  16:05:12','2019-03-07  18:10:12','Employer');

EXEC sp_idgenerator @tablename='Login', @id=@Login_id OUTPUT;
INSERT INTO Login
VALUES (@Login_id,'naruto',ENCRYPTBYPASSPHRASE('tdi202','kurama'),'kumarama2@naruto.com','2019-02-07  16:05:12','2019-02-07  18:10:12','Employer');

EXEC sp_idgenerator @tablename='Login', @id=@Login_id OUTPUT;
INSERT INTO Login
VALUES (@Login_id,'slimerecarnation',ENCRYPTBYPASSPHRASE('tdi202','rebornslim'),'reborn@slime.com','2019-04-06  16:05:12','2019-04-06  18:10:12','Employer');

EXEC sp_idgenerator @tablename='Login', @id=@Login_id OUTPUT;
INSERT INTO Login
VALUES (@Login_id,'fanthomman',ENCRYPTBYPASSPHRASE('tdi202','kuroko00'),'kurokono@basket.mu','2019-03-30  16:05:12','2019-03-30  18:10:12','Employer');

EXEC sp_idgenerator @tablename='Login', @id=@Login_id OUTPUT;
INSERT INTO Login
VALUES (@Login_id,'sao123',ENCRYPTBYPASSPHRASE('tdi202','swordart'),'swordart@online.mu','2019-04-06  16:05:12','2019-04-06  20:10:12','Employer');

EXEC sp_idgenerator @tablename='Login', @id=@Login_id OUTPUT;
INSERT INTO Login
VALUES (@Login_id,'goku1',ENCRYPTBYPASSPHRASE('tdi202','kakarot'),'dragonball@super.com','2019-04-01  16:05:12','2019-04-01  22:10:12','Jobseeker');

EXEC sp_idgenerator @tablename='Login', @id=@Login_id OUTPUT;
INSERT INTO Login
VALUES (@Login_id,'bleach',ENCRYPTBYPASSPHRASE('tdi202','bleaching1'),'bleach@bleed.com','2019-04-05  16:05:12','2019-05-05  17:10:12','Jobseeker');

EXEC sp_idgenerator @tablename='Login', @id=@Login_id OUTPUT;
INSERT INTO Login
VALUES (@Login_id,'onepunch',ENCRYPTBYPASSPHRASE('tdi202','punching09'),'onepunch@man.com','2019-04-04  06:05:12','2019-04-04  10:10:12','Jobseeker');

SELECT 'Auto Generated Login_id created' AS 'Success';
	PRINT 'INSERT SUCCESSFUL';
END

--Feedback table--
CREATE TABLE Feedback
(   
    User_id              VARCHAR(10) FOREIGN KEY REFERENCES Jobseeker(User_id) ON DELETE CASCADE ON UPDATE CASCADE   ,
    Emp_id              VARCHAR(10)  FOREIGN KEY REFERENCES Employer(Emp_id) ON DELETE CASCADE ON UPDATE CASCADE,
    Company_feedback	VARCHAR(MAX) NOT NULL,
    Applicant_feedback	VARCHAR(MAX) NOT NULL,
	Rating_applicant FLOAT CHECK(Rating_applicant IN(0,1,2,3,4,5)),
	PRIMARY KEY(User_id,Emp_id )
);


insert into Feedback (User_id,Emp_id,Company_feedback,Applicant_feedback,Rating_applicant)
values ((select User_id from Jobseeker where Name  = 'Jean Louis'),(select Emp_id from Employer where Efname  = 'Bob' AND Elname = ' Brown '),'absent minded','encouraging heads',1 );


insert into Feedback (User_id,Emp_id,Company_feedback,Applicant_feedback,Rating_applicant)
values ((select User_id from Jobseeker where Name  = 'Missa Young'),(select Emp_id from Employer where Efname  = 'Kurt' AND Elname = ' Wesley ') ,'Good communication skills' , 'Good offers',2);


insert into Feedback (User_id,Emp_id,Company_feedback,Applicant_feedback,Rating_applicant)
values ((select User_id from Jobseeker where Name  = 'Shiro L'),(select Emp_id from Employer where Efname  = 'Light' AND Elname = ' Chan '),'good analytical skills','Nice fringe benefits',4 );


insert into Feedback (User_id,Emp_id,Company_feedback,Applicant_feedback,Rating_applicant)
values ((select User_id from Jobseeker where Name  = 'Kira Small'),(select Emp_id from Employer where Efname  = 'Mary' AND Elname = ' Yagami '), 'Not punctual','bad working environment',0);

insert into Feedback (User_id,Emp_id,Company_feedback,Applicant_feedback,Rating_applicant)
values ((select User_id from Jobseeker where Name  = 'Dora Win'),(select Emp_id from Employer where Efname  = 'Alan' AND Elname = ' Wong '), 'good overall behaviour','pleasant environment',3);


------
Drop table Feedback;
Drop table Admin;
Drop table Application;
Drop table Jobseeker;
Drop table Login;
Drop table Employer;
Drop table Jobs;
Drop table phone_number;

 select *
 from Feedback;
 select *
 from Admin;
 select *
 from Application;
 select *
 from Jobseeker;
 select *
 from Login;
 select *
 from Employer;
 select *
 from Jobs;
 select *
 from phone_number;


