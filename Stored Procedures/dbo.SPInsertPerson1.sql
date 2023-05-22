SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

 CREATE PROCEDURE [dbo].[SPInsertPerson1]
    @jsonData NVARCHAR(MAX),
    @PersonID INT OUTPUT,
    @ErrorMessage NVARCHAR(MAX) OUTPUT
AS
BEGIN
    -- Declare variables
    DECLARE @FirstName NVARCHAR(50)
    DECLARE @LastName NVARCHAR(50)
    DECLARE @Gender NVARCHAR(10)
    DECLARE @BirthDate DATE
    DECLARE @ErrorFlag BIT

    -- Parse the JSON data and insert into the Person table

   SELECT @FirstName = FirstName,
         @LastName = LastName,
         @Gender = Gender,
         @BirthDate = BirthDate
	FROM OPENJSON(@jsonData)
    WITH (  
			FirstName NVARCHAR(50),
			LastName NVARCHAR(50),
			Gender NVARCHAR(10),
			BirthDate DATE
	  )


   -- Insert data into person table
    BEGIN TRY

        INSERT INTO dbo.Person (FirstName, LastName, Gender, BirthDate)
        VALUES (@FirstName, @LastName, @Gender, @BirthDate)

        SET @PersonID = SCOPE_IDENTITY()
        SET @ErrorFlag = 0
    END TRY
    BEGIN CATCH
        SET @ErrorMessage = ERROR_MESSAGE()
        SET @ErrorFlag = 1
    END CATCH

    -- Return the error message if there was an error
    IF @ErrorFlag = 1
    BEGIN
        RAISERROR(@ErrorMessage, 16, 1)
        RETURN
    END
END
GO
