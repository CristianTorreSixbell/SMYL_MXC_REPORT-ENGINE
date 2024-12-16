alter
PROCEDURE GetConversationDetailsByDate  
    @StartDate DATETIME,  
    @EndDate DATETIME  
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    -- Crear tabla temporal para almacenar resultados  
    CREATE TABLE #Result (  
        CASE_ID UNIQUEIDENTIFIER,  
        CONVERSATION_START DATETIME,  
        CONVERSATION_END DATETIME,  
        PARTICIPANT_ID UNIQUEIDENTIFIER,  
        PARTICIPANT_NAME NVARCHAR(255),  
        --purposeId INT,  
        ID_SESSION UNIQUEIDENTIFIER,  
      --  mediaTypeId INT,  
        EMAIL_ADDRESS_FROM NVARCHAR(255),  
        EMAIL_ADDRESS_TO NVARCHAR(255),  
     --   ani NVARCHAR(255),  
    --    dnis NVARCHAR(255),  
      --  direction NVARCHAR(50),  
    --    agentRank INT,  
    --    remoteNameDisplayable NVARCHAR(255),  
--       conversationStartHourId INT,  
        QUEUE_INTERACTION_INIT DATETIME,  
        QUEUE_INTERACTION_END DATETIME,  
        TOTAL_HOLD_TIME NVARCHAR(50),  
        CLIENT_INTERACTION_INIT DATETIME,  
        CLIENT_INTERACTION_END DATETIME,  
        TOTAL_CLIENT_INTERACTION_TIME NVARCHAR(50),  
        AGENT_INTERACTION_INIT DATETIME,  
        AGENT_INTERACTION_END DATETIME,  
        TOTAL_AGENT_INTERACTION_TIME NVARCHAR(50),  
        QUEUE_ID UNIQUEIDENTIFIER,  
        QUEUE_NAME NVARCHAR(255),  
  SUBJET NVARCHAR(255),  
  TRANSFER_CALL NVARCHAR(255),  
  CASE_ENDED NVARCHAR(255)  
    );  
  
    -- Obtener los ConversationId dentro del rango de fechas  
    DECLARE @conversationId UNIQUEIDENTIFIER;  
    DECLARE @conversationStart DATETIME;  
    DECLARE @conversationEnd DATETIME;  
  
    DECLARE ConversationCursor CURSOR FOR  
        SELECT conversationId, conversationStart, conversationEnd  
        FROM [insight_smnyl].[dbo].[Dim_Conversation]  
        WHERE conversationStart BETWEEN @StartDate AND @EndDate;  
  
    OPEN ConversationCursor;  
    FETCH NEXT FROM ConversationCursor INTO @conversationId, @conversationStart, @conversationEnd;  
  
    WHILE @@FETCH_STATUS = 0  
    BEGIN  
        -- Obtener participantes asociados al ConversationId  
        DECLARE @participantId UNIQUEIDENTIFIER;  
        DECLARE @participantName NVARCHAR(255);  
        DECLARE @purposeId INT;  
  
        DECLARE ParticipantCursor CURSOR FOR  
            SELECT participantId, participantName, purposeId  
            FROM [insight_smnyl].[dbo].[Dim_Participant]  
            WHERE conversationId = @conversationId;  
  
        OPEN ParticipantCursor;  
        FETCH NEXT FROM ParticipantCursor INTO @participantId, @participantName, @purposeId;  
  
        WHILE @@FETCH_STATUS = 0  
        BEGIN  
            -- Insertar datos en la tabla temporal  
            INSERT INTO #Result  
            SELECT  
                @conversationId,  
                @conversationStart,  
                @conversationEnd,  
                @participantId,  
                @participantName,  
            --    @purposeId,  
                S.sessionId,  
            --    NULL AS mediaTypeId,  
                S.addressFrom,  
                S.addressTo,  
           --     NULL AS ani,  
             --   NULL AS dnis,  
              --  NULL AS direction,  
               -- NULL AS agentRank,  
                --NULL AS remoteNameDisplayable,  
              --  NULL AS conversationStartHourId,  
                -- Subconsultas para métricas de cola  
                (SELECT MIN(CASE WHEN SM.name_g = 'nOffered' THEN DATEADD(HOUR, -6, SM.emitDate) END)  
                 FROM [dbo].[Dim_SessionMetrics] AS SM   
     WHERE SM.sessionId = S.sessionId  
      --  AND SM.name_g != NULL  
      -- AND SM.emitDate != NULL  
     ) AS entradaCola,  
                (SELECT MIN(CASE WHEN SM.name_g = 'tAcd' THEN DATEADD(HOUR, -6, SM.emitDate) END)  
                 FROM [dbo].[Dim_SessionMetrics] AS SM   
     WHERE SM.sessionId = S.sessionId  
       -- AND SM.name_g != NULL  
      --  AND SM.emitDate != NULL  
     ) AS salidaCola,  
                (SELECT FORMAT(  
                    DATEADD(SECOND,   
                        DATEDIFF(SECOND,   
    MIN(CASE WHEN SM.name_g = 'nOffered' THEN SM.emitDate END),  
                            MIN(CASE WHEN SM.name_g = 'tAcd' THEN SM.emitDate END)  
                        ), 0  
                    ), 'HH:mm:ss')  
                 FROM [dbo].[Dim_SessionMetrics] AS SM   
     WHERE SM.sessionId = S.sessionId  
     --   AND SM.name_g != NULL  
     --   AND SM.emitDate != NULL  
     ) AS tiempoEnCola,  
                -- Subconsultas para interacción cliente  
                (SELECT MIN(CASE WHEN SM.name_g = 'nConnected' THEN DATEADD(HOUR, -6, SM.emitDate) END)  
                 FROM [dbo].[Dim_SessionMetrics] AS SM   
     WHERE SM.sessionId = S.sessionId  
      --  AND SM.name_g != NULL  
      --  AND SM.emitDate != NULL  
     ) AS inicioInteraccionCliente,  
                (SELECT MIN(CASE WHEN SM.name_g = 'tConnected' THEN DATEADD(HOUR, -6, SM.emitDate) END)  
                 FROM [dbo].[Dim_SessionMetrics] AS SM   
     WHERE SM.sessionId = S.sessionId  
     --   AND SM.name_g != NULL  
      --  AND SM.emitDate != NULL  
     ) AS finInteraccionCliente,  
                (SELECT FORMAT(  
                    DATEADD(SECOND,   
                        DATEDIFF(SECOND,   
                            MIN(CASE WHEN SM.name_g = 'nConnected' THEN SM.emitDate END),  
                            MIN(CASE WHEN SM.name_g = 'tConnected' THEN SM.emitDate END)  
                        ), 0  
                    ), 'HH:mm:ss')  
                 FROM [dbo].[Dim_SessionMetrics] AS SM   
     WHERE SM.sessionId = S.sessionId  
     --  AND SM.name_g != NULL  
    --  AND SM.emitDate != NULL  
     ) AS tiempoTotalInteraccionCliente,  
                -- Subconsultas para interacción agente  
                (SELECT MIN(CASE WHEN SM.name_g = 'tAnswered' THEN DATEADD(HOUR, -6, SM.emitDate) END)  
                 FROM [dbo].[Dim_SessionMetrics] AS SM   
     WHERE SM.sessionId = S.sessionId  
     -- AND SM.name_g != NULL  
    --  AND SM.emitDate != NULL  
     ) AS inicioInteraccionAgente,  
                (SELECT MIN(CASE WHEN SM.name_g = 'tAcw' THEN DATEADD(HOUR, -6, SM.emitDate) END)  
                 FROM [dbo].[Dim_SessionMetrics] AS SM   
     WHERE SM.sessionId = S.sessionId  
     -- AND SM.name_g != NULL  
      --AND SM.emitDate != NULL  
     ) AS finInteraccionAgente,  
                (SELECT FORMAT(  
                    DATEADD(SECOND,   
                        DATEDIFF(SECOND,   
                            MIN(CASE WHEN SM.name_g = 'tAnswered' THEN SM.emitDate END),  
                            MIN(CASE WHEN SM.name_g = 'tAcw' THEN SM.emitDate END)  
                        ), 0  
                    ), 'HH:mm:ss')  
                 FROM [dbo].[Dim_SessionMetrics] AS SM   
     WHERE SM.sessionId = S.sessionId  
     --AND SM.name_g != NULL  
     --AND SM.emitDate != NULL  
     ) AS tiempoInteraccionAgente,  
                -- Subconsultas para queueId y queueName  
                (SELECT top (1) Q.queueId   
                 FROM [dbo].[Dim_Segment] SEG  
                 JOIN [dbo].[Dim_Queue] Q ON SEG.queueId = Q.queueId  
                 WHERE SEG.sessionId = S.sessionId  
     ) AS queueId,  
                (SELECT top (1) Q.queueName  
                 FROM [dbo].[Dim_Segment] SEG  
                 JOIN [dbo].[Dim_Queue] Q ON SEG.queueId = Q.queueId  
                 WHERE SEG.sessionId = S.sessionId  
     ) AS queueName,  
     (SELECT top(1)  
     SEG.subject_g AS SUBJET  
     FROM [dbo].[Dim_Segment] SEG  
     WHERE SEG.sessionId =  S.sessionId and  
     S.participantId = @participantId  
     ),  
     (SELECT top(1)  
     CASE   
      WHEN SF.exitReason = 'TRANSFER' THEN 'SI'  
      ELSE 'NO'  
     END AS TRANSFERIDO  
     FROM [dbo].[Dim_SessionFlow] SF    
     WHERE SF.sessionId =  S.sessionId and  
     S.participantId = @participantId  
     ),  
     (SELECT top(1)  
     CASE   
      WHEN SF.exitReason = 'TRANSFER' THEN 'SI'  
      ELSE 'NO'  
     END AS TRANSFERIDO  
     FROM [dbo].[Dim_SessionFlow] SF    
     WHERE SF.sessionId =  S.sessionId and  
     S.participantId = @participantId  
     )  
            FROM [dbo].[Dim_Session] AS S  
            WHERE S.participantId = @participantId;  
  
            FETCH NEXT FROM ParticipantCursor INTO @participantId, @participantName, @purposeId;  
        END;  
  
        CLOSE ParticipantCursor;  
        DEALLOCATE ParticipantCursor;  
  
        FETCH NEXT FROM ConversationCursor INTO @conversationId, @conversationStart, @conversationEnd;  
    END;  
  
    CLOSE ConversationCursor;  
    DEALLOCATE ConversationCursor;  
  
    -- Retornar los datos consolidados  
    SELECT * FROM #Result;  
  
    -- Limpiar tabla temporal  
    DROP TABLE #Result;  
END;  