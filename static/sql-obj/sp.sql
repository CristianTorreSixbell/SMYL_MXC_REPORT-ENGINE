CREATE PROCEDURE GetConversationDetailsByDate  
    @StartDate DATETIME,  
    @EndDate DATETIME  
AS  
BEGIN  
    SET NOCOUNT ON;  
    -- Insertar los resultados directamente en la tabla objetivo  
    INSERT INTO [GNREPORT_SMNYL].[dbo].[Historical_Report] (  
        CASE_ID,  
        CONVERSATION_START,  
        CONVERSATION_END,  
        PARTICIPANT_ID,  
        PARTICIPANT_NAME,  
        ID_SESSION,  
        EMAIL_ADDRESS_FROM,  
        EMAIL_ADDRESS_TO,  
        QUEUE_INTERACTION_INIT,  
        QUEUE_INTERACTION_END,  
        TOTAL_HOLD_TIME,  
        CLIENT_INTERACTION_INIT,  
        CLIENT_INTERACTION_END,  
        TOTAL_CLIENT_INTERACTION_TIME,  
        AGENT_INTERACTION_INIT,  
        AGENT_INTERACTION_END,  
        TOTAL_AGENT_INTERACTION_TIME,  
        QUEUE_ID,  
        QUEUE_NAME,  
        SUBJET,  
        TRANSFER_CALL,  
        CASE_ENDED  
    )  
    SELECT   
        DC.conversationId AS CASE_ID,  
        DATEADD(HOUR, -6, DC.conversationStart) AS CONVERSATION_START,  
        DATEADD(HOUR, -6, DC.conversationEnd) AS CONVERSATION_END,  
        DP.participantId AS PARTICIPANT_ID,  
        DP.participantName AS PARTICIPANT_NAME,  
        DS.sessionId AS ID_SESSION,  
        DS.addressFrom AS EMAIL_ADDRESS_FROM,  
        DS.addressTo AS EMAIL_ADDRESS_TO,  
        MIN(CASE WHEN SM.name_g = 'nOffered' THEN DATEADD(HOUR, -6, SM.emitDate) END) AS QUEUE_INTERACTION_INIT,  
        MIN(CASE WHEN SM.name_g = 'tAcd' THEN DATEADD(HOUR, -6, SM.emitDate) END) AS QUEUE_INTERACTION_END,  
        FORMAT(  
            DATEADD(SECOND,   
                DATEDIFF(SECOND,   
                    MIN(CASE WHEN SM.name_g = 'nOffered' THEN SM.emitDate END),  
                    MIN(CASE WHEN SM.name_g = 'tAcd' THEN SM.emitDate END)  
                ), 0  
            ), 'HH:mm:ss'  
        ) AS TOTAL_HOLD_TIME,  
        MIN(CASE WHEN SM.name_g = 'nConnected' THEN DATEADD(HOUR, -6, SM.emitDate) END) AS CLIENT_INTERACTION_INIT,  
        MIN(CASE WHEN SM.name_g = 'tConnected' THEN DATEADD(HOUR, -6, SM.emitDate) END) AS CLIENT_INTERACTION_END,  
        FORMAT(  
            DATEADD(SECOND,   
                DATEDIFF(SECOND,   
                    MIN(CASE WHEN SM.name_g = 'nConnected' THEN SM.emitDate END),  
                    MIN(CASE WHEN SM.name_g = 'tConnected' THEN SM.emitDate END)  
                ), 0  
            ), 'HH:mm:ss'  
        ) AS TOTAL_CLIENT_INTERACTION_TIME,  
        MIN(CASE WHEN SM.name_g = 'tAnswered' THEN DATEADD(HOUR, -6, SM.emitDate) END) AS AGENT_INTERACTION_INIT,  
        MIN(CASE WHEN SM.name_g = 'tAcw' THEN DATEADD(HOUR, -6, SM.emitDate) END) AS AGENT_INTERACTION_END,  
        FORMAT(  
            DATEADD(SECOND,   
                DATEDIFF(SECOND,   
                    MIN(CASE WHEN SM.name_g = 'tAnswered' THEN SM.emitDate END),  
                    MIN(CASE WHEN SM.name_g = 'tAcw' THEN SM.emitDate END)  
                ), 0  
            ), 'HH:mm:ss'  
        ) AS TOTAL_AGENT_INTERACTION_TIME,  
        NULL AS QUEUE_ID, -- Temporal hasta confirmar la columna  
        NULL AS QUEUE_NAME, -- Temporal hasta confirmar la columna  
        NULL AS SUBJET, -- Temporal hasta confirmar la columna  
        NULL AS TRANSFER_CALL, -- Temporal hasta confirmar la columna  
        NULL AS CASE_ENDED -- Temporal hasta confirmar la columna  
    FROM   
        [dbo].[Dim_Conversation] AS DC  
    INNER JOIN   
        [dbo].[Dim_Participant] AS DP  
        ON DC.conversationId = DP.conversationId  
    INNER JOIN   
        [dbo].[Dim_Session] AS DS  
        ON DP.participantId = DS.participantId  
    LEFT JOIN   
        [dbo].[Dim_SessionMetrics] AS SM  
        ON DS.sessionId = SM.sessionId  
    WHERE   
        DC.conversationStart BETWEEN @StartDate AND @EndDate  
    GROUP BY   
        DC.conversationId, DC.conversationStart, DC.conversationEnd,  
        DP.participantId, DP.participantName, DP.purposeId,  
        DS.sessionId, DS.mediaTypeId, DS.addressFrom, DS.addressTo,  
        DS.ani, DS.dnis, DS.direction, DS.agentRank, DS.remoteNameDisplayable;  
END;  