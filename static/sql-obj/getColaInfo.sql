CREATE PROCEDURE GetQueueInfoByConversation
    @ConversationId UNIQUEIDENTIFIER,
    @SessionId UNIQUEIDENTIFIER,
    @ParticipantId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @colaId NVARCHAR(50);
	DECLARE @colaName NVARCHAR(50);

    SELECT TOP (1) 
		@colaId = Q.queueId,
		@colaName = Q.queueName
    FROM [dbo].[Dim_Segment] SEG
    JOIN [dbo].[Dim_Queue] Q ON SEG.queueId = Q.queueId
    WHERE SEG.sessionId = @SessionId;

    SELECT @colaId AS colaId,@colaName AS colaName;
 
--EXEC GetQueueInfoByConversation 'F6417650-693F-481C-8FE2-9EEB2752C9FE' ,'F4C0BC63-197D-4E69-B899-980A7AAA1955','BA86ED3F-74FD-4FFE-954F-00B94EA03F1F'  
END;




