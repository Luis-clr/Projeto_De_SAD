USE PROJETO_LAGARTO
 -- IMCOMPLETO
CREATE OR ALTER PROCEDURE SP_FATO_GASTO(@DATA_CARGA DATETIME)
AS
BEGIN
	INSERT INTO FATO_GASTO(COD_COTRATO,DATA_CONTRATO,NUMERO,OBJETIVO_CONTRATO,DATA_REALIZACAO,VALOR,SITUACAO,AVISO,VENCEDORES,MODALIDADE)
			SELECT 
				C.COD_COTRATO,
				C.DATA_CONTRATO,
				C.NUMERO,C.OBJETIVO_CONTRATO,
				C.DATA_REALIZACAO,
				C.VALOR,
				C.SITUACAO,
				C.AVISO,
				C.VENCEDORES,
				C.MODALIDADE
			FROM 
				TB_AUX_CONTRATO C
END



-- Teste

EXEC SP_DIM_CONTRATO '20230323'
SELECT * FROM DIM_CONTRATO


create or alter procedure sp_fato_venda(@data_carga datetime)
as
BEGIN
    INSERT INTO FATO_VENDA (ID_TEMPO, ID_LOJA, ID_PRODUTO, ID_TIPO_PAGAMENTO, COD_VENDA, VOLUME, VALOR, QUANTIDADE)
    SELECT 
        T.ID_TEMPO,
        L.ID_LOJA,
        P.ID_PRODUTO,
        TP.ID_TIPO_PAGAMENTO,
        V.COD_VENDA,
        V.VOLUME,
        V.VALOR,
		1
    FROM 
        TB_AUX_VENDA V
        INNER JOIN DIM_TEMPO T ON V.COD_VENDA = T.ID_TEMPO
        INNER JOIN DIM_PRODUTO P ON V.COD_VENDA = P.ID_PRODUTO
        INNER JOIN DIM_LOJA L ON V.COD_VENDA = L.ID_LOJA
        INNER JOIN DIM_TIPO_PAGAMENTO TP ON V.COD_VENDA = TP.ID_TIPO_PAGAMENTO
END



-- Teste

exec sp_fato_venda '20230104'

USE dw_lowlatency

select * from fato_venda
select * from TB_AUX_VENDA
SELECT * FROM DIM_TEMPO