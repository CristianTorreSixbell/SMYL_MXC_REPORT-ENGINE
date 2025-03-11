CREATE PROCEDURE GetConversationDetailsByDate_2  
    @StartDate DATETIME,  
    @EndDate DATETIME  
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    -- Crear tabla temporal para almacenar resultados simplificados  
    CREATE TABLE ##Result (  
        conversationId UNIQUEIDENTIFIER,  
        conversationStart DATETIME,  
        conversationEnd DATETIME,  
        participantId UNIQUEIDENTIFIER,  
        sessionId UNIQUEIDENTIFIER,  
        mediaTypeId INT,  
        addressFrom NVARCHAR(255),  
        addressTo NVARCHAR(255)  
    );  
  
    -- Obtener los ConversationId dentro del rango de fechas  
    DECLARE @conversationId UNIQUEIDENTIFIER;  
    DECLARE @conversationStart DATETIME;  
    DECLARE @conversationEnd DATETIME;  
  
    DECLARE ConversationCursor CURSOR FOR  
        SELECT   
            conversationId,  
            DATEADD(HOUR, -6, conversationStart),  
            DATEADD(HOUR, -6, conversationEnd)  
        FROM   
            [dbo].[Dim_Conversation]  
        WHERE   
            conversationStart BETWEEN @StartDate AND @EndDate;  
  
    OPEN ConversationCursor;  
    FETCH NEXT FROM ConversationCursor INTO @conversationId, @conversationStart, @conversationEnd;  
  
    WHILE @@FETCH_STATUS = 0  
    BEGIN  
        -- Obtener participantes asociados al ConversationId  
        DECLARE @participantId UNIQUEIDENTIFIER;  
  
        DECLARE ParticipantCursor CURSOR FOR  
            SELECT   
                participantId  
            FROM   
                [dbo].[Dim_Participant]  
            WHERE   
                conversationId = @conversationId;  
  
        OPEN ParticipantCursor;  
        FETCH NEXT FROM ParticipantCursor INTO @participantId;  
  
        WHILE @@FETCH_STATUS = 0  
        BEGIN  
            -- Obtener sesiones asociadas al ParticipantId y agregar a resultados simplificados  
            INSERT INTO ##Result  
            SELECT   
                @conversationId AS conversationId,  
                @conversationStart AS conversationStart,  
                @conversationEnd AS conversationEnd,  
                @participantId AS participantId,  
                S.sessionId,  
                S.mediaTypeId,  
                S.addressFrom,  
                S.addressTo  
            FROM   
                [dbo].[Dim_Session] AS S  
            WHERE   
                S.participantId = @participantId  
   AND S.mediaTypeId = 3;  
  
            FETCH NEXT FROM ParticipantCursor INTO @participantId;  
        END;  
  
        CLOSE ParticipantCursor;  
        DEALLOCATE ParticipantCursor;  
  
        FETCH NEXT FROM ConversationCursor INTO @conversationId, @conversationStart, @conversationEnd;  
    END;  
  
    CLOSE ConversationCursor;  
    DEALLOCATE ConversationCursor;  
  
   
END;  