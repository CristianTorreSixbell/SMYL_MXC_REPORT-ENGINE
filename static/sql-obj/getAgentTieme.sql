CREATE PROCEDURE GetTiempoInteraccionAgente
    @sessionId UNIQUEIDENTIFIER
AS 
BEGIN
    SET NOCOUNT ON;

    DECLARE @inicioInteraccionAgente DATETIME;
    DECLARE @finInteraccionAgente DATETIME;
    DECLARE @tiempoTotalInteraccionAgente NVARCHAR(50);

    SELECT
        @inicioInteraccionAgente = MIN(CASE WHEN SM.name_g = 'tAnswered' THEN DATEADD(HOUR, -6, SM.emitDate) END),
        @finInteraccionAgente = MIN(CASE WHEN SM.name_g = 'tAcw' THEN DATEADD(HOUR, -6, SM.emitDate) END)
    FROM [dbo].[Dim_SessionMetrics] AS SM
    WHERE SM.sessionId = @sessionId;

    SELECT @tiempoTotalInteraccionAgente = FORMAT(
        DATEADD(SECOND, 
            DATEDIFF(SECOND, 
                @inicioInteraccionAgente, 
                @finInteraccionAgente
            ), 
            0
        ), 
        'HH:mm:ss'
    );

    SELECT @inicioInteraccionAgente AS inicioInteraccionAgente,
     @finInteraccionAgente          AS finInteraccionAgente,
      @tiempoTotalInteraccionAgente AS tiempoTotalInteraccionAgente;
    --
    --exec	 GetTiempoInteraccionAgente '518FE5D9-811D-4B37-A4AF-2AD414756156'
END;