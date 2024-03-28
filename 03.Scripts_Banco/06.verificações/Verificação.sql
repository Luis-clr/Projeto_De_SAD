USE PROJETO_LAGARTO


SELECT ID_INSTITUICAO, COUNT(2) AS Total_Contratos FROM FATO_VEICULO GROUP BY ID_VEICULO;



--TESTE INDICADORES

--FATO VEICULO
--Contagem do número de veículos agrupados por tipo.
SELECT ID_TIPO_VEICULO, COUNT(ID_VEICULO) AS Quantidade_Veiculos FROM FATO_VEICULO GROUP BY ID_TIPO_VEICULO


--Contagem do número de veículos agrupados por instituição.
SELECT ID_INSTITUICAO, COUNT(ID_VEICULO) AS Quantidade_Veiculos FROM FATO_VEICULO GROUP BY ID_INSTITUICAO


--Identificar os veículos mais antigos de cada instituição.
SELECT ID_INSTITUICAO, MIN(ANO_FABRICACAO) AS Ano_Fabricacao FROM FATO_VEICULO GROUP BY ID_INSTITUICAO

--Contagem do número de veículos agrupados por secretaria.
SELECT ID_SECRETARIA, COUNT(ID_VEICULO) AS Quantidade_Veiculos FROM FATO_VEICULO GROUP BY ID_SECRETARIA



--INDICADORES EXTRAS PARA VEÍCULO

--Identificar os veículos mais antigos de cada secretaria.
SELECT ID_SECRETARIA, MIN(ANO_FABRICACAO) AS Ano_Fabricacao FROM FATO_VEICULO GROUP BY ID_SECRETARIA


--Identificar os veículos mais antigos de cada tipo.
SELECT ID_TIPO_VEICULO, MIN(ANO_FABRICACAO) AS Ano_Fabricacao FROM FATO_VEICULO GROUP BY ID_TIPO_VEICULO

--Contagem do número de veículos por cor.
SELECT COR, COUNT(ID_VEICULO) AS Quantidade_Veiculos FROM FATO_VEICULO GROUP BY COR