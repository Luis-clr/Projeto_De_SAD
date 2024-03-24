USE PROJETO_LAGARTO
DROP TABLE TB_SECRETARIA
DROP TABLE TB_VEICULO
DROP TABLE TB_TIPO_VEICULO
DROP TABLE TB_INSTITUICAO
DROP TABLE TB_CONTRATO
DROP TABLE TB_OBSERVACAO
DROP TABLE TB_MODALIDADE

CREATE TABLE TB_SECRETARIA (
	COD_SECRETARIA INT NOT NULL PRIMARY KEY,
	NOME VARCHAR(45) NOT NULL
)

CREATE TABLE TB_TIPO_VEICULO (
	COD_TIPO_VEICULO INT NOT NULL PRIMARY KEY,
	NOME VARCHAR(45) NOT NULL
)

CREATE TABLE TB_INSTITUICAO (
	COD_INSTITUICAO INT NOT NULL PRIMARY KEY,
	NOME VARCHAR(45)
)

CREATE TABLE TB_TIPO_OBSERVACAO (
	COD_TIPO_OBSERVACAO INT NOT NULL PRIMARY KEY,
	TIPO_CAR VARCHAR(45)
)

CREATE TABLE TB_VEICULO (
	COD_VEICULO INT NOT NULL PRIMARY KEY,
	PLACA VARCHAR(7),
	ANO_FABRICACAO DATE NOT NULL,
	ANO_MODELO DATE NOT NULL,
	COR VARCHAR(45) NOT NULL,
	COD_TIPO_VEICULO INT NOT NULL CONSTRAINT FK_TIPO_VEICULO_TB_VEICULO FOREIGN KEY (COD_TIPO_VEICULO) REFERENCES TB_TIPO_VEICULO (COD_TIPO_VEICULO),
	COD_SECRETARIA INT NOT NULL CONSTRAINT FK_SECRETARIA_TB_VEICULO FOREIGN KEY (COD_SECRETARIA) REFERENCES TB_SECRETARIA (COD_SECRETARIA),
	COD_TIPO_OBSERVACAO INT NOT NULL CONSTRAINT FK_TIPO_OBSERVACAO_TB_VEICULO FOREIGN KEY (COD_TIPO_OBSERVACAO) REFERENCES TB_TIPO_OBSERVACAO (COD_TIPO_OBSERVACAO),
	COD_INSTITUICAO INT NOT NULL CONSTRAINT FK_INSTITUICAO_TB_VEICULO FOREIGN KEY (COD_INSTITUICAO) REFERENCES TB_INSTITUICAO (COD_INSTITUICAO)
) 
 
 CREATE TABLE TB_CONTRATO(
	COD_CONTRATO INT NOT NULL PRIMARY KEY,
	DATA_CONTRATO DATE,
	NUMERO VARCHAR(8),
	OBJETIVO_CONTRATO VARCHAR(99),
	DATA_REALIZACAO DATETIME,
	VALOR VARCHAR(45),
	COD_INSTITUICAO INT NOT NULL CONSTRAINT FK_INSTITUICAO_TB_CONTRATO FOREIGN KEY (COD_INSTITUICAO) REFERENCES TB_INSTITUICAO (COD_INSTITUICAO),
	COD_MODALIDADE INT NOT NULL CONSTRAINT FK_MODALIDADE_TB_CONTRATO FOREIGN KEY (COD_MODALIDADE) REFERENCES TB_MODALIDADE (COD_MODALIDADE)
 )
 
 CREATE TABLE TB_MODALIDADE(
	COD_MODALIDADE INT NOT NULL PRIMARY KEY,
	TIPO VARCHAR(10)
 )