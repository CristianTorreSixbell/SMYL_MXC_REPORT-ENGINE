CREATE PROCEDURE GetConversationDetailsByDate 
    @StartDate DATETIME,    
    @EndDate DATETIME
AS 
BEGIN
    SET NOCOUNT ON;

    -- Crear tabla temporal para almacenar resultados
    CREATE TABLE #Result (
        conversationId UNIQUEIDENTIFIER,
        conversationStart DATETIME,
        conversationEnd DATETIME,
        participantId UNIQUEIDENTIFIER,
        participantName NVARCHAR(255),
        purposeId INT,
        sessionId UNIQUEIDENTIFIER,
        mediaTypeId INT,
        addressFrom NVARCHAR(255),
        addressTo NVARCHAR(255),
        ani NVARCHAR(255),
        dnis NVARCHAR(255),
        direction NVARCHAR(50),
        agentRank INT,
        remoteNameDisplayable NVARCHAR(255),
        conversationStartHourId INT,
        entradaCola DATETIME,
        salidaCola DATETIME,
        tiempoEnCola NVARCHAR(50),
        inicioInteraccionCliente DATETIME,
        finInteraccionCliente DATETIME,
        tiempoTotalInteraccionCliente NVARCHAR(50),
        inicioInteraccionAgente DATETIME,
        finInteraccionAgente DATETIME,
        tiempoInteraccionAgente NVARCHAR(50)
    );

    -- Obtener los ConversationId dentro del rango de fechas
    DECLARE @conversationId UNIQUEIDENTIFIER;
    DECLARE @conversationStart DATETIME;
    DECLARE @conversationEnd DATETIME;
    DECLARE @conversationStartHourId NVARCHAR(255);

    DECLARE ConversationCursor CURSOR FOR
        SELECT 
            conversationId,
            DATEADD(HOUR, -6, conversationStart), 
            DATEADD(HOUR, -6, conversationEnd)
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
            SELECT 
                participantId, 
                participantName, 
                purposeId
            FROM [insight_smnyl].[dbo].[Dim_Participant]
            WHERE conversationId = @conversationId;

        OPEN ParticipantCursor;
        FETCH NEXT FROM ParticipantCursor INTO @participantId, @participantName, @purposeId;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Obtener sesiones asociadas al ParticipantId
            INSERT INTO #Result
            SELECT 
                @conversationId AS conversationId,
                @conversationStart AS conversationStart,
                @conversationEnd AS conversationEnd,
                @participantId AS participantId,
                @participantName AS participantName,
                @purposeId AS purposeId,
                S.sessionId,
                S.mediaTypeId,
                S.addressFrom,
                S.addressTo,
                S.ani,
                S.dnis,
                S.direction,
                S.agentRank,
                S.remoteNameDisplayable,
                @conversationStartHourId,
                -- Subconsulta para Cola
                (SELECT MIN(CASE WHEN SM.name_g = 'nOffered' THEN DATEADD(HOUR, -6, SM.emitDate) END)
                 FROM [dbo].[Dim_SessionMetrics] AS SM
                 WHERE SM.sessionId = S.sessionId) AS entradaCola,
                (SELECT MIN(CASE WHEN SM.name_g = 'tAcd' THEN DATEADD(HOUR, -6, SM.emitDate) END)
                 FROM [dbo].[Dim_SessionMetrics] AS SM
                 WHERE SM.sessionId = S.sessionId) AS salidaCola,
                (SELECT FORMAT(
                    DATEADD(SECOND, 
                        DATEDIFF(SECOND, 
                            MIN(CASE WHEN SM.name_g = 'nOffered' THEN SM.emitDate END), 
                            MIN(CASE WHEN SM.name_g = 'tAcd' THEN SM.emitDate END)
                        ), 
                        0
                    ), 
                    'HH:mm:ss'
                )
                 FROM [dbo].[Dim_SessionMetrics] AS SM
                 WHERE SM.sessionId = S.sessionId) AS tiempoEnCola,
                -- Subconsulta para Interacción Cliente
                (SELECT MIN(CASE WHEN SM.name_g = 'nConnected' THEN DATEADD(HOUR, -6, SM.emitDate) END)
                 FROM [dbo].[Dim_SessionMetrics] AS SM
                 WHERE SM.sessionId = S.sessionId) AS inicioInteraccionCliente,
                (SELECT MIN(CASE WHEN SM.name_g = 'tConnected' THEN DATEADD(HOUR, -6, SM.emitDate) END)
                 FROM [dbo].[Dim_SessionMetrics] AS SM
                 WHERE SM.sessionId = S.sessionId) AS finInteraccionCliente,
                (SELECT FORMAT(
                    DATEADD(SECOND, 
                        DATEDIFF(SECOND, 
                            MIN(CASE WHEN SM.name_g = 'nConnected' THEN SM.emitDate END), 
                            MIN(CASE WHEN SM.name_g = 'tConnected' THEN SM.emitDate END)
                        ), 
                        0
                    ), 
                    'HH:mm:ss'
                )
                 FROM [dbo].[Dim_SessionMetrics] AS SM
                 WHERE SM.sessionId = S.sessionId) AS tiempoTotalInteraccionCliente,
                -- Subconsulta para Interacción Agente
                (SELECT MIN(CASE WHEN SM.name_g = 'tAnswered' THEN DATEADD(HOUR, -6, SM.emitDate) END)
                 FROM [dbo].[Dim_SessionMetrics] AS SM
                 WHERE SM.sessionId = S.sessionId) AS inicioInteraccionAgente,
                (SELECT MIN(CASE WHEN SM.name_g = 'tAcw' THEN DATEADD(HOUR, -6, SM.emitDate) END)
                 FROM [dbo].[Dim_SessionMetrics] AS SM
                 WHERE SM.sessionId = S.sessionId) AS finInteraccionAgente,
                (SELECT FORMAT(
                    DATEADD(SECOND, 
                        DATEDIFF(SECOND, 
                            MIN(CASE WHEN SM.name_g = 'tAnswered' THEN SM.emitDate END), 
                            MIN(CASE WHEN SM.name_g = 'tAcw' THEN SM.emitDate END)
                        ), 
                        0
                    ), 
                    'HH:mm:ss'
                )
                 FROM [dbo].[Dim_SessionMetrics] AS SM
                 WHERE SM.sessionId = S.sessionId) AS tiempoInteraccionAgente
            FROM [insight_smnyl].[dbo].[Dim_Session] AS S
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
