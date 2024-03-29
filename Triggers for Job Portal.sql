CREATE TRIGGER tr_verifier
ON Application
INSTEAD OF INSERT
AS
BEGIN
DECLARE @appliedate DATETIME;
DECLARE @closingdate DATETIME;
DECLARE @D FLOAT;
SET @appliedate = (SELECT Date_Applied FROM inserted);
SET @closingdate = (SELECT Closing_Date FROM inserted);
IF (@appliedate>@closingdate)
BEGIN
ROLLBACK TRANSACTION;
			SELECT 'Error: Wrong applied date ' AS ErrorMessage;
	PRINT 'ERROR!!! Should have applied before the closing date ' 
	RETURN
END
ELSE IF (@appliedate=@closingdate)
BEGIN
SET @D=(SELECT (CAST(@appliedate AS float)- FLOOR(CAST(@appliedate AS float)))-
		(CAST(@closingdate AS float) - FLOOR(CAST(@closingdate AS float))))
	
IF (@D > 0)
BEGIN 
ROLLBACK;
			SELECT 'Error: Wrong applied date ' AS ErrorMessage;
	PRINT 'ERROR!!! Should have applied before the closing date ' 
	RETURN
END
ELSE 
	BEGIN
	PRINT 'INSERT SUCCESFULL'

END
END
END;


SELECT * 
FROM Application;

drop TRIGGER tr_verifier

INSERT INTO Application
VALUES( 'J00000003','Js00000002', 'Contract' , '2019-03-31 17:00:00','2019-03-31 10:30:00' );

----------

CREATE TRIGGER tr_datecheck
ON Login
INSTEAD OF INSERT
AS
BEGIN
DECLARE @logintime DATETIME;
DECLARE @logouttime DATETIME;
DECLARE @DIFF FLOAT;
SET @logintime = (SELECT Log_in_time FROM inserted);
SET @logouttime = (SELECT Log_out_time FROM inserted);
IF (@logintime>@logouttime)
BEGIN
ROLLBACK TRANSACTION;
			SELECT 'Error: ' + ERROR_MESSAGE() AS ErrorMessage;
	PRINT 'ERROR!!! Date for log in time cannot be after log out time ' 
	RETURN 
END
 ELSE IF (@logintime = @logouttime)
BEGIN
SET @DIFF=(SELECT (CAST(@logintime AS float)- FLOOR(CAST(@logintime AS float)))-
		(CAST(@logouttime AS float) - FLOOR(CAST(@logouttime AS float))))
	
IF (@DIFF > 0)
BEGIN 
ROLLBACK;
			SELECT 'Error: Wrong applied date ' AS ErrorMessage;
	PRINT 'ERROR!!! Should have applied before the closing date ' 
	RETURN
END
END
ELSE 
	BEGIN
	PRINT 'INSERT SUCCESFULL'

END
END;

DROP TRIGGER tr_datecheck

DECLARE @Login_id VARCHAR(10)
EXEC sp_idgenerator @tablename='Login', @id=@Login_id OUTPUT;
INSERT INTO Login
VALUES (@Login_id, 'deadlysin' , ENCRYPTBYPASSPHRASE('tdi202','deadl') , 'deadlysin@captain.com'  , '2019-03-28 15:04:23'  ,'2019-03-27 10:05:23',  'Jobseeker' );

SELECT * 
FROM Login;

-------------------

CREATE TRIGGER tr_feedback
ON Feedback
AFTER INSERT
AS
BEGIN
DECLARE @cfeedback VARCHAR(MAX)
DECLARE @userid VARCHAR(10)
DECLARE @company VARCHAR(60)
DECLARE @empid VARCHAR(10)
DECLARE @ufeedback VARCHAR(MAX)
SET @empid =(SELECT Emp_id FROM inserted);
SET @cfeedback= (SELECT Company_feedback FROM inserted);
SET @ufeedback= (SELECT Applicant_feedback FROM inserted);
SET @userid = (SELECT User_id FROM inserted);
SET @company = (SELECT Company_Name
				FROM Employer
					WHERE Emp_id = @empid);

 PRINT 'The user ' +@userid +'is given the feedback: '+@cfeedback+ ' from the company '+@company+ ' from employer id '+@empid
 PRINT ' The user has given the feedback ' +@ufeedback+ 'to the company ' +@company+ ' through employer with id ' +@empid
 END;

 insert into Feedback (User_id,Emp_id,Company_feedback,Applicant_feedback)
values ((select User_id from Jobseeker where Name  = 'Missa Young'),(select Emp_id from Employer where Efname  = 'Mary' AND Elname = ' Yagami ') ,'Good communication skills and seems to have good attitude' , 'Very Good offers');

 DROP TRIGGER tr_feedback



----------- Triggers for update statement
CREATE TABLE update_audit(
Login_id VARCHAR(20),
Oldlogintime DATETIME,
Oldlogouttime DATETIME
);

drop TABLE update_audit;

select *
from update_audit;

CREATE TRIGGER tr_chk_audit
ON Login 
AFTER UPDATE
AS
IF (@@ROWCOUNT=0)
RETURN

DECLARE @ologintime DATETIME;
DECLARE @nlogintime DATETIME;
DECLARE @ologouttime DATETIME;
DECLARE @nlogouttime DATETIME;
DECLARE @login_id VARCHAR(10);


IF EXISTS(SELECT * FROM INSERTED) AND EXISTS(SELECT * FROM DELETED)
	BEGIN
	SET @nlogintime=(SELECT Log_in_time FROM INSERTED)
	SET @ologintime=(SELECT Log_in_time FROM DELETED)
      SET @nlogouttime=(SELECT Log_out_time FROM INSERTED)
	SET @ologouttime=(SELECT Log_out_time FROM DELETED)
	SET @login_id=(SELECT Login_id FROM INSERTED)
	
	INSERT INTO update_audit VALUES
(@Login_id,@ologintime, @ologouttime)
   END

   drop TRIGGER tg_chk_audit

	update Login
	set log_in_time='2019-04-08 19:30:00', log_out_time='2019-04-08 21:00:00'
	WHERE Login_id='L00000000';

	select *
	from Login;



	----trigger to check for duplicate email
	CREATE TRIGGER tr_dupemail
	ON LOGIN
	INSTEAD OF INSERT, UPDATE
	AS
	BEGIN
	DECLARE @Email VARCHAR(MAX)
	SET @Email=(SELECT Email FROM INSERTED)
	   IF EXISTS (SELECT Email 
	                FROM Login
					WHERE Email=@Email)
	   BEGIN
	   PRINT 'Email already exists in database'
	   ROLLBACK TRANSACTION;
	   END
	   ELSE
	    BEGIN
		PRINT'Insert successful'
		END
		END;

		DECLARE @Login_id VARCHAR(10)
EXEC sp_idgenerator @tablename='Login', @id=@Login_id OUTPUT;
INSERT INTO Login
VALUES (@Login_id,'mremployer',ENCRYPTBYPASSPHRASE('tdi202','fairytail0'),'harrypotter@hogwart.com','2019-03-07  16:05:12','2019-03-07  18:10:12','Employer');

------TRIGGER FOR DELETE
CREATE TABLE Audit_Delete(
Emp_id varchar(10) PRIMARY KEY,
Efirstname VARCHAR(60),
Elastname VARCHAR(60),
Company_name VARCHAR(60),
Address VARCHAR(200),
Position VARCHAR(100),
Date_delt DATETIME);

SELECT *
FROM Audit_Delete;

DROP TABLE Audit_Delete;

CREATE TRIGGER trg_del
ON Employer
FOR DELETE
AS
BEGIN
 DECLARE @Emp_id varchar(10);
DECLARE @Efname VARCHAR(60);
DECLARE @Elname VARCHAR(60);
DECLARE @Company_name VARCHAR(60);
DECLARE @Address VARCHAR(200);
DECLARE @Position VARCHAR(100);
SET @Emp_id=(select Emp_id FROM DELETED);
SET @Efname=(select Efname FROM DELETED);
SET @Elname=(select Elname FROM DELETED);
SET @Company_name=(select Company_Name FROM DELETED);
SET @Address=(select Address from deleted);
SET @Position=(select Position from deleted);

INSERT INTO Audit_Delete
VALUES(@Emp_id,@Efname,@Elname,@Company_name,@Address,@Position,GETDATE())
END;

DELETE 
FROM Employer
WHERE Emp_id='E00000000';

--TRIGGERS CHECK THAT DATA IS NOT NULL

CREATE TRIGGER tr_checkdata
ON Jobseeker
INSTEAD OF INSERT, UPDATE
AS
BEGIN
DECLARE @Qualification VARCHAR(60);
DECLARE @Skills VARCHAR(60);
SET @Qualification=(SELECT Qualification FROM INSERTED)
SET @Skills=(SELECT Skills FROM INSERTED)
If(@Qualification IS NULL)
BEGIN
PRINT 'A user without qualification cannot apply for a job'
rollback transaction;
END
ELSE IF(@Skills IS NULL)
BEGIN
PRINT 'A user without skills is not qualified to apply for a job'
rollback transaction;
END
END;

DECLARE @User_id VARCHAR(10)
EXEC sp_idgenerator @tablename='Jobseeker', @id=@User_id OUTPUT;
INSERT INTO Jobseeker
VALUES(@User_id,'Milo Young', 'Mauritian','Rose-hill',56548978,'1989-01-16',1, 'Intership at Telecom' ,NULL, NULL,NULL);

---------



CREATE TABLE User_standing(
Userid VARCHAR(10)  PRIMARY KEY,
Name VARCHAR(80),
Average_Rating FLOAT
);

INSERT INTO User_standing
VALUES('Js00000000', 'Missa Young' , NULL);

INSERT INTO User_standing
VALUES('Js00000001', 'Shiro L' , NULL);

INSERT INTO User_standing
VALUES('Js00000002', 'Kira Small' , NULL);

INSERT INTO User_standing
VALUES('Js00000003', 'Dora Win' , NULL);

INSERT INTO User_standing
VALUES('Js00000004', 'Elite Ryuk' , NULL);

INSERT INTO User_standing
VALUES('Js00000005', 'Shina Pearl' , NULL);

INSERT INTO User_standing
VALUES('Js00000006', 'Jean Louis' , NULL);


DROP TABLE User_standing;

SELECT *
FROM User_standing;


CREATE TRIGGER tr_rating
ON Feedback
AFTER INSERT
AS
BEGIN
DECLARE @userid VARCHAR(10);
DECLARE @averagerating FLOAT;
SET @userid = (SELECT User_id FROM inserted);
SET @averagerating = ( SELECT AVG(Rating_applicant)
						FROM Feedback
							WHERE User_id=@userid)
UPDATE User_standing
SET Average_Rating = @averagerating
WHERE Userid =@userid
END;

drop TRIGGER tr_rating;

INSERT INTO Feedback
VALUES('Js00000006' , 'E00000002', 'quite absent minded','encouraging heads',1 );

INSERT INTO Feedback
VALUES('Js00000006' , 'E00000003','does not seem concentrated','Good company',2 );

INSERT INTO Feedback
VALUES('Js00000006' , 'E00000004','good candidate','nice interviewer',3 );

INSERT INTO Feedback
VALUES('Js00000006' , 'E00000005','very good candidate','interested',4 );	





