SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE   PROCEDURE [dbo].[InsertAllDataFromJson]
   @json NVARCHAR(MAX)
AS

BEGIN


SELECT *
INTO #temp
FROM OPENJSON(@json)
WITH (
  FirstName VARCHAR(50),
  LastName VARCHAR(50),
  Gender NVARCHAR(50),
  BirthDate DATE,
  AddressLine1 NVARCHAR(50),
  AddressLine2 NVARCHAR(50),
  City NVARCHAR(50),
  StateProvince NVARCHAR(50),
  PostalCode NVARCHAR(50),
  Country NVARCHAR(50),
  Email NVARCHAR(50),
  Phone NVARCHAR(50),
  Fax NVARCHAR(50),
  Website NVARCHAR(50)
)
  DECLARE @JsonData NVARCHAR(MAX)
  SELECT @JsonData = ( SELECT * FROM #temp t
    WHERE NOT EXISTS (
        SELECT 1 
        FROM dbo.Person p 
        WHERE p.firstName = t.firstName AND p.lastName = t.lastName AND p.birthDate = t.birthDate
    ) FOR JSON AUTO	)  
	 
	
	IF EXISTS (	
        SELECT 1 
        FROM dbo.Person p ,#temp t
        WHERE p.firstName = t.firstName AND p.lastName = t.lastName AND p.birthDate = t.birthDate )
		BEGIN
        RAISERROR('Person already exists In the table.', 16, 1)
        RETURN
		 END
DROP TABLE #temp



    -- Declare variables
    DECLARE @PersonID INT
    DECLARE @AddressID INT
    DECLARE @ContactInfoID INT
    DECLARE @ErrorMessage NVARCHAR(MAX)

   

    -- Start a transaction
    BEGIN TRANSACTION
        -- Insert data into Person table
        EXEC dbo.SPInsertPerson1 @jsonData, @PersonID OUTPUT, @ErrorMessage OUTPUT

        -- Rollback the transaction if there is an error in InsertIntoPersonTable
        IF @@ERROR <> 0
        BEGIN
            ROLLBACK TRANSACTION
            RAISERROR(@ErrorMessage, 16, 1)
            RETURN
        END

        -- Insert data into Address table
        EXEC [dbo].[SPInsertAddress1] @jsonData, @PersonID, @AddressID OUTPUT, @ErrorMessage OUTPUT

        -- Rollback the transaction if there is an error in InsertIntoAddressTable
        IF @@ERROR <> 0
        BEGIN
            ROLLBACK TRANSACTION
            RAISERROR(@ErrorMessage, 16, 1)
            RETURN
        END

        -- Insert data into ContactInfo table
        EXEC [dbo].[SPInsertContactinfo1] @jsonData, @PersonID, @ContactInfoID OUTPUT, @ErrorMessage OUTPUT

        -- Rollback the transaction if there is an error in InsertIntoContactInfoTable
        IF @@ERROR <> 0
        BEGIN
            ROLLBACK TRANSACTION
            RAISERROR(@ErrorMessage, 16, 1)
            RETURN
        END

    -- Commit the transaction
    COMMIT TRANSACTION

    -- Combine the data from all three tables into a single JSON file
    DECLARE @combinedData NVARCHAR(MAX)
    SELECT @combinedData = COALESCE(@combinedData + ',', '') + (
        SELECT p.PersonID AS 'PersonID', p.FirstName AS 'FirstName', p.LastName AS 'LastName', p.Gender AS 'Gender', p.BirthDate AS 'BirthDate',
               a.AddressID AS 'AddressID', a.AddressLine1 AS 'AddressLine1', a.AddressLine2 AS 'AddressLine2', a.City AS 'City', a.StateProvince AS 'StateProvince', a.PostalCode AS 'PostalCode', a.Country AS 'Country',
               c.ContactInfoID AS 'ContactInfoID', c.Email AS 'Email', c.Phone AS 'Phone', c.Fax AS 'Fax', c.Website AS 'Website'
        FROM dbo.Person p
        INNER JOIN dbo.Address a ON p.PersonID = a.PersonID
        INNER JOIN dbo.ContactInfo c ON p.PersonID = c.PersonID
        WHERE p.PersonID = @PersonID
        FOR JSON PATH, INCLUDE_NULL_VALUES
    )

    -- Print the combined data as a JSON string
    PRINT @combinedData

			

END
GO
