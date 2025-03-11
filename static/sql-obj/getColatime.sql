CREATE PROCEDURE GetTiempoCola
    @sessionId UNIQUEIDENTIFIER
AS 
BEGIN
    SET NOCOUNT ON;

    DECLARE @entradaCola DATETIME;
    DECLARE @SalidaCola DATETIME;
    DECLARE @TiempoTotal NVARCHAR(50);

    SELECT
        @entradaCola = MIN(CASE WHEN SM.name_g = 'nOffered' THEN DATEADD(HOUR, -6, SM.emitDate) END),
        @SalidaCola = MIN(CASE WHEN SM.name_g = 'tAcd' THEN DATEADD(HOUR, -6, SM.emitDate) END)
    FROM [dbo].[Dim_SessionMetrics] AS SM
    WHERE SM.sessionId = @sessionId;

    SELECT @TiempoTotal = FORMAT(
        DATEADD(SECOND, 
            DATEDIFF(SECOND, 
                @entradaCola, 
                @SalidaCola
            ), 
            0
        ), 
        'HH:mm:ss'
    );

    SELECT @entradaCola AS entradaCola, @SalidaCola AS salidaCola, @TiempoTotal AS tiempoTotalCola;
    --exec	 GetTiempoCola '518FE5D9-811D-4B37-A4AF-2AD414756156'
    --
    --
END;
	 
	 
	 
	 

	 