
CREATE PROCEDURE GetSubjetBySession
	@SesionId UNIQUEIDENTIFIER
AS 
BEGIN 
	SET NOCOUNT ON;
	DECLARE @subject_g NVARCHAR (50);
		SELECT TOP (1)
			@subject_g=	SEG.subject_g 
		FROM [dbo].[Dim_Segment] SEG 
		WHERE SEG.sessionId = @SesionId
	SELECT @subject_g AS  subject_g
--EXEC GetSubjetBySession 'F4C0BC63-197D-4E69-B899-980A7AAA1955'
END;