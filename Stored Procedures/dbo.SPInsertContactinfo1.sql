SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

   CREATE PROCEDURE [dbo].[SPInsertContactinfo1]
    @jsonData NVARCHAR(MAX),
    @PersonID INT,
    @ContactInfoID INT OUTPUT,
    @ErrorMessage NVARCHAR(MAX) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    --declare variables
    DECLARE @Email NVARCHAR(50)
    DECLARE @Phone NVARCHAR(20)
    DECLARE @Fax NVARCHAR(20)
    DECLARE @Website NVARCHAR(50)

    -- Parse the JSON data to extract the ContactInfo values
    SELECT 
        @Email = Email,
        @Phone = Phone,
        @Fax = Fax,
        @Website = Website
	FROM OPENJSON(@jsonData)
    WITH (
			Email NVARCHAR(50),
			Phone NVARCHAR(20),
			Fax NVARCHAR(20),
			Website NVARCHAR(50)
			)



    BEGIN TRY
        -- Insert data into ContactInfo table
        INSERT INTO dbo.ContactInfo (PersonID, Email, Phone, Fax, Website)
        VALUES (@PersonID, @Email, @Phone, @Fax, @Website)

        -- Get the ID of the inserted ContactInfo record
        SET @ContactInfoID = SCOPE_IDENTITY()

        -- Set error message to NULL if the insert was successful
        SET @ErrorMessage = NULL
    END TRY
    BEGIN CATCH
        -- Rollback the transaction if there is an error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION

        -- Set the error message to the error description
        SET @ErrorMessage = ERROR_MESSAGE()

        -- Set the ContactInfoID to -1 to indicate that there was an error
        SET @ContactInfoID = -1
    END CATCH
END
GO
