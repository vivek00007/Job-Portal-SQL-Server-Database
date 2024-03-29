

CREATE PROCEDURE sp_decrypt @loginid VARCHAR(10)
AS
BEGIN
DECLARE @password VARBINARY(MAX);
DECLARE @decrypt NVARCHAR(MAX);
SET @password = (SELECT Password
					FROM Login
						WHERE Login_id = @loginid);
SET @decrypt= CONVERT( VARCHAR(MAX),DECRYPTBYPASSPHRASE('tdi202', @password)); 
PRINT 'The decrypted password for Login ' +@loginid +' is : ' +@decrypt
END;

DROP PROCEDURE sp_decrypt

EXEC sp_decrypt L00000000;

-------

CREATE PROCEDURE sp_authentication @Username VARCHAR(60), @pass VARCHAR(MAX)
AS
BEGIN
DECLARE @loginresult INTEGER
DECLARE @password VARBINARY(MAX)
SET @password = (SELECT Password 
						FROM Login
							where Username = @username)
IF EXISTS(SELECT 1 
			FROM Login
				WHERE (Username = @username) AND (@pass = CONVERT( VARCHAR(MAX),DECRYPTBYPASSPHRASE('tdi202', @password))))
	BEGIN
SELECT @loginresult = 1
PRINT 'Access has been granted for username: ' + @username 
	END
ELSE 
BEGIN 
SELECT @loginresult = 0
PRINT 'No user with that username and password found! TRY AGAIN' 
END
END;

EXEC sp_authentication mradmin,fairytail0;

DROP PROCEDURE sp_authentication




-----------------

CREATE PROCEDURE sp_count @userid VARCHAR(10)
AS
BEGIN
DECLARE @apply VARCHAR(10)
SET @apply = (SELECT COUNT(User_id)
				FROM Application
				WHERE User_id=@userid)
PRINT 'The number of application that the Jobseeker with id ' +@userid+ ' has applied is: ' +@apply
END;

EXEC sp_count Js00000002;

DROP PROCEDURE sp_count;


 --------
 CREATE PROCEDURE sp_idgenerator @tablename VARCHAR(MAX), @id VARCHAR(10) OUTPUT
 AS
 BEGIN
 DECLARE @start VARCHAR(2);
 DECLARE @num INT;
 IF @tablename= 'Admin'
 BEGIN
    SELECT @start ='A';
    SELECT @num=MAX(substring(Admin_id, 2, 10))+1
 FROM Admin
 END
 ELSE IF @tablename= 'Employer'
 BEGIN
    SELECT @start ='E';
    SELECT @num=MAX(substring(Emp_id, 2, 10))+1
 FROM Employer
 END
 ELSE IF @tablename= 'Jobs'
 BEGIN
    SELECT @start ='J';
    SELECT @num=MAX(substring(Job_id, 2, 10))+1
 FROM Jobs
 END
 ELSE IF @tablename= 'Jobseeker'
 BEGIN
    SELECT @start ='Js';
    SELECT @num=MAX(substring(User_id, 3, 10))+1
 FROM Jobseeker
 END
 ELSE IF @tablename= 'Login'
 BEGIN
    SELECT @start ='L';
    SELECT @num=MAX(substring(Login_id, 2, 10))+1
 FROM Login
 END
 ELSE 
    BEGIN
	 PRINT 'Wrong tablename provided.'
	 SELECT 'Wrong tablename provided' AS 'Error';
	 RETURN;
	 END
	IF @num IS NULL SET @num=0;
	SELECT @id =@start+RIGHT('00000000' + CAST (@num AS VARCHAR(8)), 8);
	RETURN;
	END

	drop PROCEDURE sp_idgenerator;

	 
-------------
CREATE PROCEDURE sp_duration @loginid VARCHAR(10)
AS
BEGIN
DECLARE @log_in DATETIME, @log_out DATETIME;
DECLARE @diff VARCHAR(MAX) 
SET @log_in = (SELECT Log_in_time
				FROM Login 
					WHERE Login_id = @loginid)
SET @log_out = (SELECT Log_out_time
				FROM Login 
					WHERE Login_id = @loginid)
SET @diff=(select convert(char(8),dateadd(s,datediff(s,@log_in,@log_out),'1900-1-1'),8))

PRINT 'The duration is '+@diff
END;

EXEC sp_duration L00000000;

DROP PROCEDURE sp_duration;


------------------------------------
CREATE PROCEDURE sp_rating @userid VARCHAR(10)
AS
BEGIN
DECLARE @avgrating FLOAT;
SET @avgrating=(SELECT Average_Rating
					FROM User_standing
					 WHERE Userid=@userid);
IF @@ROWCOUNT= 0
BEGIN
PRINT 'No data available'
END
ELSE IF (@avgrating>3)
BEGIN 
PRINT 'The Jobseeker with id ' +@userid+ ' is a very hard working person.'
END
ELSE IF (@avgrating<2)
BEGIN 
PRINT 'The Jobseeker with id ' +@userid+ ' is a lazy person.'
END
ELSE
BEGIN
PRINT 'The Jobseeker with id ' +@userid+ ' is a considerable worker.'
END
END;

EXEC sp_rating Js00000006

DROP PROCEDURE sp_rating;
---------------------------------------------------

CREATE PROCEDURE sp_age @User_id VARCHAR(10)
AS
BEGIN
DECLARE @DOB DATETIME 
DECLARE @AGE VARCHAR(MAX)
SET @DOB =(SELECT DOB
           FROM Jobseeker
		   WHERE User_id=@User_id)
SET @AGE=(select datediff(YEAR,@DOB, getdate() ))
PRINT 'The age of jobseeker with id ' +@User_id+ ' is ' +@AGE 
END;

EXEC sp_age Js00000002

DROP procedure sp_age

-------------
CREATE PROCEDURE sp_calc @userid VARCHAR(10)
AS
BEGIN
SELECT Title
FROM Jobs
WHERE Working_Experience_Required <= (SELECT Working_Experience_YEAR
										FROM Jobseeker
										 WHERE User_id=@userid)
END;

EXEC sp_calc Js00000006;

drop PROCEDURE sp_calc;