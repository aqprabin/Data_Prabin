SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[SPInsertAddress1]
    @jsonData NVARCHAR(MAX),
    @PersonID INT,
    @AddressID INT OUTPUT,
    @ErrorMessage NVARCHAR(MAX) OUTPUT
AS
BEGIN
    -- Declare variables
    DECLARE @AddressLine1 NVARCHAR(100)
    DECLARE @AddressLine2 NVARCHAR(100)
    DECLARE @City NVARCHAR(50)
    DECLARE @StateProvince NVARCHAR(50)
    DECLARE @PostalCode NVARCHAR(20)
    DECLARE @Country NVARCHAR(50)

    -- Parse JSON input and assign values to variables
    SELECT @AddressLine1 = AddressLine1,
           @AddressLine2 = AddressLine2,
           @City = City,
           @StateProvince = StateProvince,
           @PostalCode = PostalCode,
           @Country = Country
    FROM OPENJSON(@jsonData)
    WITH (
        AddressLine1 NVARCHAR(100),
        AddressLine2 NVARCHAR(100),
        City NVARCHAR(50),
        StateProvince NVARCHAR(50),
        PostalCode NVARCHAR(20),
        Country NVARCHAR(50)
    )

    -- Insert data into Address table
    BEGIN TRY
        INSERT INTO dbo.Address (PersonID, AddressLine1, AddressLine2, City, StateProvince, PostalCode, Country)
        VALUES (@PersonID, @AddressLine1, @AddressLine2, @City, @StateProvince, @PostalCode, @Country)

        -- Get the newly inserted AddressID
        SELECT @AddressID = SCOPE_IDENTITY()
    END TRY
    BEGIN CATCH
        SET @ErrorMessage = 'Error inserting data into Address table: ' + ERROR_MESSAGE()
        RETURN
    END CATCH
END
GO
