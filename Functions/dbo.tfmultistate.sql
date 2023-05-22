SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[tfmultistate] (@parameter NVARCHAR(MAX))
RETURNS @table_variable TABLE (
   PersonID INT,
    AddressLine1 NVARCHAR(50),
    AddressLine2 NVARCHAR(50),
	City  NVARCHAR(50)
)
AS
BEGIN
    INSERT INTO @table_variable
    SELECT PersonID,  AddressLine1, AddressLine2, City 
    FROM dbo.Address
   WHERE City = @parameter
    RETURN
END
GO
