SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[SPInsertPersonAddressContactInfo]
    @json NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    -- Insert data into Person table
    DECLARE @personId INT;

    INSERT INTO Person (FirstName, LastName, Gender, BirthDate)
    SELECT FirstName, LastName, Gender, CONVERT(DATE, BirthDate, 126)
    FROM OPENJSON(@json)
    WITH (
        FirstName VARCHAR(50),
        LastName VARCHAR(50),
        Gender VARCHAR(10),
        BirthDate VARCHAR(10)
    );

    SET @personId = SCOPE_IDENTITY();

    -- Insert data into Address table
    INSERT INTO Address (PersonID, AddressLine1, AddressLine2, City, StateProvince, PostalCode,Country)
    SELECT @personId, AddressLine1, AddressLine2, City, StateProvince, PostalCode,Country
    FROM OPENJSON(@json)
    WITH (
        AddressLine1 VARCHAR(100),
        AddressLine2 VARCHAR(100),
        City VARCHAR(50),
        StateProvince VARCHAR(50),
        PostalCode VARCHAR(10),
		Country  VARCHAR(50)
    );

    -- Insert data into ContactInfo table
    INSERT INTO ContactInfo (PersonID, Email, Phone,fax,Website)
    SELECT @personId, Email, Phone,fax,website
    FROM OPENJSON(@json)
    WITH (
        Email VARCHAR(100),
        Phone VARCHAR(20),
		 Fax VARCHAR(20),
		 Website VARCHAR(100)
    );

    SELECT 'Data inserted successfully.' AS Result;
END
GO
