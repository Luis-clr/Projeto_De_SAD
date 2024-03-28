USE PROJETO_LAGARTO


SELECT ID_INSTITUICAO, COUNT(2) AS Total_Contratos FROM FATO_VEICULO GROUP BY ID_VEICULO;



--TESTE INDICADORES

--FATO VEICULO
--Contagem do n�mero de ve�culos agrupados por tipo.
SELECT ID_TIPO_VEICULO, COUNT(ID_VEICULO) AS Quantidade_Veiculos FROM FATO_VEICULO GROUP BY ID_TIPO_VEICULO


--Contagem do n�mero de ve�culos agrupados por institui��o.
SELECT ID_INSTITUICAO, COUNT(ID_VEICULO) AS Quantidade_Veiculos FROM FATO_VEICULO GROUP BY ID_INSTITUICAO


--Identificar os ve�culos mais antigos de cada institui��o.
SELECT ID_INSTITUICAO, MIN(ANO_FABRICACAO) AS Ano_Fabricacao FROM FATO_VEICULO GROUP BY ID_INSTITUICAO

--Contagem do n�mero de ve�culos agrupados por secretaria.
SELECT ID_SECRETARIA, COUNT(ID_VEICULO) AS Quantidade_Veiculos FROM FATO_VEICULO GROUP BY ID_SECRETARIA



--INDICADORES EXTRAS PARA VE�CULO

--Identificar os ve�culos mais antigos de cada secretaria.
SELECT ID_SECRETARIA, MIN(ANO_FABRICACAO) AS Ano_Fabricacao FROM FATO_VEICULO GROUP BY ID_SECRETARIA


--Identificar os ve�culos mais antigos de cada tipo.
SELECT ID_TIPO_VEICULO, MIN(ANO_FABRICACAO) AS Ano_Fabricacao FROM FATO_VEICULO GROUP BY ID_TIPO_VEICULO

--Contagem do n�mero de ve�culos por cor.
SELECT COR, COUNT(ID_VEICULO) AS Quantidade_Veiculos FROM FATO_VEICULO GROUP BY COR