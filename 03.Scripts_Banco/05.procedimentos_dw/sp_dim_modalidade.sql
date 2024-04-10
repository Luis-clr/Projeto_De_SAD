USE PROJETO_LAGARTO

CREATE OR ALTER PROCEDURE SP_DIM_MODALIDADE(@DATA_CARGA DATETIME)
AS
BEGIN
	DECLARE @COD_MODALIDADE INT,
			@TIPO VARCHAR(45),
			@TIPO_AUX VARCHAR(999)

	DECLARE C_DIM_MODALIDADE CURSOR FOR 			
	SELECT COD_MODALIDADE,TIPO 
	FROM TB_AUX_MODALIDADE
	WHERE DATA_CARGA = @DATA_CARGA


	OPEN C_DIM_MODALIDADE
	FETCH C_DIM_MODALIDADE INTO @COD_MODALIDADE, @TIPO

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM DIM_MODALIDADE WHERE COD_MODALIDADE = @COD_MODALIDADE)
		BEGIN

			INSERT INTO DIM_MODALIDADE
			VALUES (@COD_MODALIDADE,@TIPO)
			
		END
		ELSE
		BEGIN
			SELECT @TIPO_AUX = M.TIPO
		FROM DIM_MODALIDADE M
			WHERE M.COD_MODALIDADE = @COD_MODALIDADE

			IF @TIPO_AUX <> @TIPO
			BEGIN
				UPDATE DIM_MODALIDADE
				SET TIPO = @TIPO
				WHERE COD_MODALIDADE = @COD_MODALIDADE
			END
		END
		FETCH C_DIM_MODALIDADE INTO @COD_MODALIDADE, @TIPO
		END
	CLOSE C_DIM_MODALIDADE
	DEALLOCATE C_DIM_MODALIDADE
END



-- Teste

EXEC SP_DIM_MODALIDADE'20230323'

SELECT * FROM DIM_MODALIDADE
