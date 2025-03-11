ALTER PROCEDURE DoneOrNot 
    @conversationID UNIQUEIDENTIFIER
    
AS 
BEGIN
    SET NOCOUNT ON;
    DECLARE @done NVARCHAR(50);

     select 
		 @done=CASE     
            WHEN  CO.conversationEnd = null THEN 'NO'
            WHEN  CO.conversationEnd IS NOT NULL THEN 'YES'
            ELSE 'NO'    
         END     
	from [dbo].[Dim_Conversation] as CO 
    where CO.conversationId = @conversationID
 

    -- Si no se encontró ningún registro, asignar 'NO'
    IF @done IS NULL
    BEGIN
        SET @done = 'NO';
    END

    SELECT @done AS done;
	--EXEC DoneOrNot  ''
END;