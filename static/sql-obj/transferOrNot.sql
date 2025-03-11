CREATE PROCEDURE GetTransferOrNot 
	@participantId UNIQUEIDENTIFIER,
    @sessionId UNIQUEIDENTIFIER
    
AS 
BEGIN
    SET NOCOUNT ON;
    DECLARE @transfer NVARCHAR(50);

     select 
		 @transfer=CASE     
			WHEN SF.exitReason = 'TRANSFER' THEN 'SI'    
            ELSE 'NO'    
         END     
	from [dbo].[Dim_Participant] as PA 
	join 
	[dbo].[Dim_Session] as SE on PA.participantId = @participantId
	join 
	[dbo].[Dim_SessionFlow] as SF on SE.sessionId = @sessionId

    -- Si no se encontró ningún registro, asignar 'NO'
    IF @transfer IS NULL
    BEGIN
        SET @transfer = 'NO';
    END

    SELECT @transfer AS transfer;
	--exec GetTransferOrNot  '4429F117-5BF7-4809-AE72-39071D780AAA','591FFF5C-BBC7-4676-AB39-C03EBAC31AD9' ;
END;