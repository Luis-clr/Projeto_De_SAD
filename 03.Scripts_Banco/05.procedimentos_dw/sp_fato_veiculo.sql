USE PROJETO_LAGARTO

 drop PROCEDURE SP_FATO_VEICULO

CREATE OR ALTER PROCEDURE SP_FATO_VEICULO(@DATA_CARGA DATETIME)
AS
BEGIN
	DECLARE @COD_TIPO_VEICULO INT,
			@COD_SECRETARIA INT,
			@COD_INSTITUICAO INT, 
			@COD_VEICULO BIGINT,
			@PLACA VARCHAR(7),
			@MARCA VARCHAR(45),
			@MODELO VARCHAR(45),
			@ANO_FABRICACAO DATE,
			@ANO_MODELO DATE,
			@COR VARCHAR(45),
			@TIPO_OBSERVACAO VARCHAR(45),
			@ID_TIPO_VEICULO INT,
			@ID_TEMPO BIGINT,
			@ID_INSTITUICAO INT,
			@ID_SECRETARIA INT

	DECLARE C_VEICULO CURSOR FOR 			
	SELECT COD_TIPO_VEICULO,COD_SECRETARIA,COD_INSTITUICAO,COD_VEICULO,PLACA,MARCA,MODELO,ANO_FABRICACAO,ANO_MODELO,COR,TIPO_OBSERVACAO
	FROM TB_AUX_VEICULO
	WHERE DATA_CARGA = @DATA_CARGA

	OPEN C_VEICULO
	FETCH NEXT FROM C_VEICULO INTO @COD_TIPO_VEICULO,@COD_SECRETARIA,@COD_INSTITUICAO,@COD_VEICULO,@PLACA,@MARCA,@MODELO,@ANO_FABRICACAO,@ANO_MODELO,@COR,@TIPO_OBSERVACAO

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @ID_TEMPO = (SELECT T.ID_TEMPO FROM DIM_TEMPO T WHERE T.DATA = @ANO_FABRICACAO)
		SET @ID_INSTITUICAO = (SELECT I.ID_INSTITUICAO FROM DIM_INSTITUICAO I WHERE I.COD_INSTITUICAO = @COD_INSTITUICAO)
		SET @ID_SECRETARIA = (SELECT S.ID_SECRETARIA FROM DIM_SECRETARIA S WHERE S.COD_SECRETARIA = @COD_SECRETARIA)
		SET @ID_TIPO_VEICULO = (SELECT TV.ID_TIPO_VEICULO FROM DIM_TIPO_VEICULO TV WHERE TV.COD_TIPO_VEICULO = @COD_TIPO_VEICULO)

		IF NOT EXISTS(SELECT 1 FROM FATO_VEICULO WHERE COD_VEICULO = @COD_VEICULO)
		BEGIN
			INSERT INTO FATO_VEICULO(ID_TEMPO,ID_TIPO_VEICULO,ID_SECRETARIA,ID_INSTITUICAO,COD_VEICULO, PLACA, MARCA, MODELO, ANO_FABRICACAO, ANO_MODELO, COR, TIPO_OBSERVACAO,QUANTIDADE)
			VALUES(@ID_TEMPO,@ID_TIPO_VEICULO,@ID_SECRETARIA,@ID_INSTITUICAO,@COD_VEICULO, @PLACA, @MARCA, @MODELO, @ANO_FABRICACAO, @ANO_MODELO, @COR, @TIPO_OBSERVACAO,1)
		END
		ELSE
		BEGIN
			UPDATE FATO_VEICULO
			SET ID_TIPO_VEICULO = @ID_TIPO_VEICULO,
				ID_SECRETARIA = @ID_SECRETARIA,
				ID_INSTITUICAO = @ID_INSTITUICAO,
				ID_TEMPO = @ID_TEMPO,
				PLACA = @PLACA,
				MARCA = @MARCA,
				MODELO = @MODELO,
				ANO_FABRICACAO = @ANO_FABRICACAO,
				ANO_MODELO = @ANO_MODELO,
				COR = @COR,
				TIPO_OBSERVACAO =@TIPO_OBSERVACAO,
				QUANTIDADE = 1
			WHERE COD_VEICULO = @COD_VEICULO
		END

		FETCH NEXT FROM C_VEICULO INTO @COD_TIPO_VEICULO,@COD_SECRETARIA,@COD_INSTITUICAO,@COD_VEICULO,@PLACA,@MARCA,@MODELO,@ANO_FABRICACAO,@ANO_MODELO,@COR,@TIPO_OBSERVACAO

	END
	CLOSE C_VEICULO
	DEALLOCATE C_VEICULO
END



-- Teste

EXEC SP_FATO_VEICULO '20240120'


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