USE PROJETO_LAGARTO

CREATE OR ALTER PROCEDURE SP_OLTP_VEICULO (@DATA_CARGA DATETIME)
AS
BEGIN
	DELETE FROM TB_AUX_VEICULO
	WHERE @DATA_CARGA = DATA_CARGA

	
	INSERT INTO TB_AUX_VEICULO(DATA_CARGA,COD_VEICULO, PLACA, MARCA, MODELO, ANO_FABRICACAO, ANO_MODELO, COR, TIPO_OBSERVACAO, COD_TIPO_VEICULO, COD_SECRETARIA, COD_INSTITUICAO)
			SELECT 
				@DATA_CARGA,
				V.COD_VEICULO,
				V.PLACA,
				V.MARCA, 
				V.MODELO, 
				V.ANO_FABRICACAO, 
				V.ANO_MODELO, 
				V.COR, 
				O.TIPO_CAR AS TIPO_OBSERVACAO,
				TV.COD_TIPO_VEICULO,
				S.COD_SECRETARIA,
				I.COD_INSTITUICAO

			FROM 
				TB_VEICULO V
				INNER JOIN TB_TIPO_VEICULO TV ON V.COD_TIPO_VEICULO = TV.COD_TIPO_VEICULO
				INNER JOIN TB_TIPO_OBSERVACAO O ON V.COD_TIPO_OBSERVACAO = O.COD_TIPO_OBSERVACAO
				INNER JOIN TB_SECRETARIA S ON V.COD_SECRETARIA = S.COD_SECRETARIA
				INNER JOIN TB_INSTITUICAO I ON V.COD_INSTITUICAO = I.COD_INSTITUICAO

END






-- Teste

EXEC SP_OLTP_VEICULO '20240120'

SELECT * FROM TB_AUX_VEICULO

