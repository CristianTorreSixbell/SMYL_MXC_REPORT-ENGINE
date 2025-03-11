CREATE PROCEDURE GetTiempoInteraccionCliente
    @sessionId UNIQUEIDENTIFIER
AS 
BEGIN
    SET NOCOUNT ON;

    DECLARE @inicioInteraccionCliente DATETIME;
    DECLARE @finInteraccionCliente DATETIME;
    DECLARE @tiempoTotalInteraccionCliente NVARCHAR(50);

    SELECT
        @inicioInteraccionCliente = MIN(CASE WHEN SM.name_g = 'nConnected' THEN DATEADD(HOUR, -6, SM.emitDate) END),
        @finInteraccionCliente = MIN(CASE WHEN SM.name_g = 'tConnected' THEN DATEADD(HOUR, -6, SM.emitDate) END)
    FROM [dbo].[Dim_SessionMetrics] AS SM
    WHERE SM.sessionId = @sessionId;

    SELECT @tiempoTotalInteraccionCliente = FORMAT(
        DATEADD(SECOND, 
            DATEDIFF(SECOND, 
                @inicioInteraccionCliente, 
                @finInteraccionCliente
            ), 
            0
        ), 
        'HH:mm:ss'
    );

    SELECT @inicioInteraccionCliente AS inicioInteraccionCliente, 
    @finInteraccionCliente           AS finInteraccionCliente, 
     @tiempoTotalInteraccionCliente  AS tiempoTotalInteraccionCliente;
    --
    ----exec	 GetTiempoInteraccionCliente '518FE5D9-811D-4B37-A4AF-2AD414756156'
END;