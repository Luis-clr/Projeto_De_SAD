USE PROJETO_LAGARTO

CREATE OR ALTER PROCEDURE SP_FATO_CONTRATO(@DATA_CARGA DATETIME)
AS
BEGIN
	DECLARE @DATA_CONTRATO DATE,
			@COD_CONTRATO INT,
			@COD_MODALIDADE INT,
			@COD_INSTITUICAO INT,
			@NUMERO VARCHAR(8),
			@OBJETIVO_CONTRATO VARCHAR(99),
			@DATA_REALIZACAO DATETIME,
			@VALOR VARCHAR(45),
			@SITUACAO VARCHAR(45),
			@AVISO VARCHAR(45),
			@VENCEDORES VARCHAR(45),
			@ID_TEMPO BIGINT,
			@ID_INSTITUICAO INT,
			@ID_MODALIDADE INT

	DECLARE C_CONTRATO CURSOR FOR 			
	SELECT COD_MODALIDADE,COD_INSTITUICAO,COD_CONTRATO,DATA_CONTRATO,NUMERO,OBJETIVO_CONTRATO,DATA_REALIZACAO,VALOR,SITUACAO,AVISO,VENCEDORES 
	FROM TB_AUX_CONTRATO
	WHERE @DATA_CARGA = DATA_CARGA

	OPEN C_CONTRATO
	FETCH C_CONTRATO INTO @COD_MODALIDADE,@COD_INSTITUICAO,@COD_CONTRATO,@DATA_CONTRATO,@NUMERO,@OBJETIVO_CONTRATO,@DATA_REALIZACAO,@VALOR,@SITUACAO,@AVISO,@VENCEDORES


	WHILE @@FETCH_STATUS = 0
	BEGIN

		SET @ID_TEMPO = (SELECT T.ID_TEMPO FROM DIM_TEMPO T WHERE T.DATA = @DATA_CONTRATO)
		SET @ID_INSTITUICAO = (SELECT I.ID_INSTITUICAO FROM DIM_INSTITUICAO I WHERE I.COD_INSTITUICAO = @COD_INSTITUICAO)
		SET @ID_MODALIDADE = (SELECT M.ID_MODALIDADE FROM DIM_MODALIDADE M WHERE M.COD_MODALIDADE = @COD_MODALIDADE)


		IF NOT EXISTS (SELECT 1 FROM FATO_CONTRATO WHERE COD_CONTRATO = @COD_CONTRATO)
		BEGIN
			INSERT INTO FATO_CONTRATO(ID_TEMPO,ID_INSTITUICAO,ID_MODALIDADE,COD_CONTRATO,DATA_CONTRATO,NUMERO,OBJETIVO_CONTRATO,DATA_REALIZACAO,VALOR,SITUACAO,AVISO,VENCEDORES,QUANTIDADE)
			VALUES(@ID_TEMPO,@ID_INSTITUICAO,@ID_MODALIDADE,@COD_CONTRATO,@DATA_CONTRATO,@NUMERO,@OBJETIVO_CONTRATO,@DATA_REALIZACAO,@VALOR,@SITUACAO,@AVISO,@VENCEDORES,1)		
		END
		ELSE
		BEGIN
			UPDATE FATO_CONTRATO
			SET ID_TEMPO = @ID_TEMPO,
				ID_INSTITUICAO = @ID_INSTITUICAO,
				ID_MODALIDADE = @ID_MODALIDADE,
				DATA_CONTRATO = @DATA_CONTRATO,
				NUMERO = @NUMERO,
				OBJETIVO_CONTRATO = @OBJETIVO_CONTRATO,
				DATA_REALIZACAO = @DATA_REALIZACAO,
				VALOR = @VALOR,
				SITUACAO = @SITUACAO,
				AVISO = @AVISO,
				VENCEDORES = @VENCEDORES
			WHERE COD_CONTRATO = @COD_CONTRATO		
		END

		FETCH C_CONTRATO INTO @COD_MODALIDADE,@COD_INSTITUICAO,@COD_CONTRATO,@DATA_CONTRATO,@NUMERO,@OBJETIVO_CONTRATO,@DATA_REALIZACAO,@VALOR,@SITUACAO,@AVISO,@VENCEDORES

	END
	CLOSE C_CONTRATO
	DEALLOCATE C_CONTRATO
END



-- Teste

EXEC SP_FATO_CONTRATO'20230323'


SELECT * FROM FATO_CONTRATO
SELECT * FROM FATO_VEICULO

SELECT * FROM DIM_INSTITUICAO
SELECT * FROM DIM_MODALIDADE
SELECT * FROM DIM_SECRETARIA
SELECT * FROM DIM_TEMPO
SELECT * FROM DIM_TIPO_VEICULO

SELECT * FROM TB_AUX_MODALIDADE
SELECT * FROM TB_AUX_TIPO_VEICULO
SELECT * FROM TB_AUX_SECRETARIA
SELECT * FROM TB_AUX_INSTITUICAO
SELECT * FROM TB_AUX_VEICULO
SELECT * FROM TB_AUX_CONTRATO

