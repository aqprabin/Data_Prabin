SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[GetPersonInfo](@PersonID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT FirstName ,LastName
    FROM Person
    WHERE PersonID = @PersonID -1
)
GO
