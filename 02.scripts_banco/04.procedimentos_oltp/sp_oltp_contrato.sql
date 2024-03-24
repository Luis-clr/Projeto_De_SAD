USE PROJETO_LAGARTO

CREATE OR ALTER PROCEDURE SP_OLTP_CONTRATO (@DATA_CARGA DATETIME)
AS
BEGIN
	INSERT INTO TB_AUX_CONTRATO(DATA_CARGA,COD_COTRATO,DATA_CONTRATO,NUMERO,OBJETIVO_CONTRATO,DATA_REALIZACAO,VALOR,SITUACAO,AVISO,VENCEDORES,MODALIDADE)			
		SELECT 
				@DATA_CARGA,
				C.COD_CONTRATO,
				C.DATA_CONTRATO,
				C.NUMERO,C.OBJETIVO_CONTRATO,
				C.DATA_REALIZACAO,
				C.VALOR,
				C.SITUACAO,
				C.AVISO,
				C.VENCEDORES,
				M.TIPO AS MODALIDADE
			FROM 
				TB_CONTRATO C
				INNER JOIN TB_MODALIDADE M ON C.COD_MODALIDADE = M.COD_MODALIDADE
END






-- Teste

EXEC SP_OLTP_CONTRATO '20230323'