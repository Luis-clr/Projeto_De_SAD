USE PROJETO_LAGARTO

CREATE OR ALTER PROCEDURE SP_OLTP_VEICULO (@DATA_CARGA DATETIME)
AS
BEGIN
	INSERT INTO TB_AUX_VEICULO(DATA_CARGA, COD_VEICULO, PLACA, MARCA, MODELO, ANO_FABRICACAO, ANO_MODELO, COR, TIPO_VEICULO, TIPO_OBSERVACAO)
			SELECT 
				@DATA_CARGA,
				V.COD_VEICULO,
				V.PLACA,
				V.MARCA, 
				V.MODELO, 
				V.ANO_FABRICACAO, 
				V.ANO_MODELO, 
				V.COR, 
				TV.COD_TIPO_VEICULO AS TIPO_VEICULO, 
				O.COD_TIPO_OBSERVACAO AS TIPO_OBSERVACAO
			FROM 
				TB_VEICULO V
				INNER JOIN TB_TIPO_VEICULO TV ON V.COD_TIPO_VEICULO = TV.COD_TIPO_VEICULO
				INNER JOIN TB_TIPO_OBSERVACAO O ON V.COD_TIPO_OBSERVACAO = O.COD_TIPO_OBSERVACAO

END






-- Teste

EXEC SP_OLTP_VEICULO '20230323'