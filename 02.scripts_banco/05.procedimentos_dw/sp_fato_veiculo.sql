USE PROJETO_LAGARTO

CREATE OR ALTER PROCEDURE SP_FATO_VEICULO(@DATA_CARGA DATETIME)
AS
BEGIN
	INSERT INTO FATO_VEICULO (ID_TEMPO,ID_TIPO_VEICULO,ID_SECRETARIA,ID_INSTITUICAO,COD_VEICULO, PLACA, MARCA, MODELO, ANO_FABRICACAO, ANO_MODELO, COR, TIPO_OBSERVACAO,QUANTIDADE)
			SELECT 
				T.ID_TEMPO,
				TV.ID_TIPO_VEICULO,
				S.ID_SECRETARIA,
				I.ID_INSTITUICAO,
				V.COD_VEICULO,
				V.PLACA,
				V.MARCA, 
				V.MODELO, 
				V.ANO_FABRICACAO, 
				V.ANO_MODELO, 
				V.COR, 
				V.TIPO_OBSERVACAO,
				1
			FROM 
				TB_AUX_VEICULO V
				INNER JOIN DIM_TEMPO T ON V.COD_VEICULO = T.ID_TEMPO
				INNER JOIN DIM_TIPO_VEICULO TV ON V.COD_VEICULO = TV.ID_TIPO_VEICULO
				INNER JOIN DIM_SECRETARIA S ON V.COD_VEICULO = S.ID_SECRETARIA
				INNER JOIN DIM_INSTITUICAO I ON V.COD_VEICULO = I.ID_INSTITUICAO
END



-- Teste

EXEC SP_FATO_VEICULO '20230323'

SELECT * FROM FATO_VEICULO