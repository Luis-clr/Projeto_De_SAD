-- Scripts ddl para o ambiente dimensional

USE PROJETO_LAGARTO

DROP TABLE FATO_CONTRATO
DROP TABLE FATO_VEICULO
DROP TABLE DIM_SECRETARIA
DROP TABLE DIM_TIPO_VEICULO
DROP TABLE DIM_TEMPO
DROP TABLE DIM_MODALIDADE
DROP TABLE DIM_INSTITUICAO

-- Tabelas de Dimens�o
CREATE TABLE DIM_TEMPO (
	ID_TEMPO BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	NIVEL VARCHAR(8) NOT NULL CHECK (NIVEL IN ('DIA','MES','ANO')),
	DATA DATETIME NULL, 
	DIA INT NULL,
	DIA_SEMANA VARCHAR(50) NULL, 
	FIM_SEMANA VARCHAR(3) NULL CHECK (FIM_SEMANA IN ('SIM','NAO')),
	FERIADO VARCHAR(100) NULL, 
	FL_FERIADO VARCHAR(3) NULL CHECK (FL_FERIADO IN ('SIM','NAO')),
	MES INT NULL, 
	NOME_MES VARCHAR(100) NULL,
	TRIMESTRE INT NULL, 
	NOME_TRIMESTRE VARCHAR(100) NULL, 
	SEMESTRE INT NULL, 
	NOME_SEMESTRE VARCHAR(100) NULL, 
	ANO INT NOT NULL
)
CREATE INDEX IX_DIM_TEMPO_DATA ON DIM_TEMPO (DATA)
CREATE INDEX IX_DIM_TEMPO_DATA_MES ON DIM_TEMPO (NIVEL, MES)
CREATE INDEX IX_DIM_TEMPO_DATA_ANO ON DIM_TEMPO (NIVEL, ANO)

CREATE TABLE DIM_SECRETARIA (
	ID_SECRETARIA INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	COD_SECRETARIA INT NOT NULL,
	NOME VARCHAR(45) NOT NULL
)

CREATE TABLE DIM_INSTITUICAO (
	ID_INSTITUICAO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	COD_INSTITUICAO INT NOT NULL,
	NOME VARCHAR(45) NOT NULL
)

CREATE TABLE DIM_MODALIDADE (
	ID_MODALIDADE INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    COD_MODALIDADE INT NOT NULL,
    TIPO VARCHAR(10) NOT NULL
)

CREATE TABLE DIM_TIPO_VEICULO (
    ID_TIPO_VEICULO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	COD_TIPO_VEICULO INT NOT NULL,
    NOME VARCHAR(45) NOT NULL
)

-- Tabelas de Fato
CREATE TABLE FATO_CONTRATO (
	ID_CONTRATO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ID_TEMPO BIGINT NOT NULL,
	ID_INSTITUICAO INT NOT NULL,
	ID_MODALIDADE INT NOT NULL,
	COD_CONTRATO INT NOT NULL,
	DATA_CONTRATO DATE NOT NULL,
	NUMERO VARCHAR(8) NOT NULL,
	OBJETIVO_CONTRATO VARCHAR(99) NOT NULL,
	DATA_REALIZACAO DATETIME,
	VALOR VARCHAR(45) NOT NULL,
	SITUACAO VARCHAR(45),
	AVISO VARCHAR(45),
	VENCEDORES VARCHAR(45),
	QUANTIDADE INT NOT NULL DEFAULT (1)
	CONSTRAINT FK_TEMPO_FATO_CONTRATO FOREIGN KEY (ID_TEMPO) REFERENCES DIM_TEMPO (ID_TEMPO),
    CONSTRAINT FK_INSTITUICAO_FATO_CONTRATO FOREIGN KEY (ID_INSTITUICAO) REFERENCES DIM_INSTITUICAO(ID_INSTITUICAO),
	CONSTRAINT FK_MODALIDADE_FATO_CONTRATO FOREIGN KEY (ID_MODALIDADE) REFERENCES DIM_MODALIDADE(ID_MODALIDADE)
)

CREATE INDEX IX_FATO_CONTRATO_TEMPO ON FATO_CONTRATO(ID_TEMPO)
CREATE INDEX IX_FATO_CONTRATO_INSTITUICAO ON FATO_CONTRATO(ID_INSTITUICAO)
CREATE INDEX IX_FATO_GCONTRATO_MODALIDADE ON FATO_CONTRATO(ID_MODALIDADE)

CREATE TABLE FATO_VEICULO (
	ID_VEICULO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ID_TIPO_VEICULO INT NOT NULL,
	ID_SECRETARIA INT NOT NULL,
	ID_INSTITUICAO INT NOT NULL,
	ID_TEMPO BIGINT NOT NULL,
	COD_VEICULO INT NOT NULL,
	PLACA VARCHAR(7) NOT NULL,
	MARCA VARCHAR(45) NOT NULL,
	MODELO VARCHAR(45) NOT NULL,
	ANO_FABRICACAO DATE NOT NULL,
	ANO_MODELO DATE NOT NULL,
	COR VARCHAR(45) NOT NULL,
	TIPO_OBSERVACAO VARCHAR(45),
	QUANTIDADE INT NOT NULL DEFAULT (1)
	CONSTRAINT FK_TEMPO_FATO_VEICULO FOREIGN KEY (ID_TEMPO) REFERENCES DIM_TEMPO (ID_TEMPO),
	CONSTRAINT FK_TIPO_VEICULO_FATO_VEICULO FOREIGN KEY (ID_TIPO_VEICULO) REFERENCES DIM_TIPO_VEICULO(ID_TIPO_VEICULO),
	CONSTRAINT FK_SECRETATARIA_FATO_VEICULO FOREIGN KEY (ID_SECRETARIA) REFERENCES DIM_SECRETARIA(ID_SECRETARIA),
	CONSTRAINT FK_INSTITUICAO_FATO_VEICULO FOREIGN KEY (ID_INSTITUICAO) REFERENCES DIM_INSTITUICAO(ID_INSTITUICAO)
)

CREATE INDEX IX_FATO_VEICULO_TEMPO ON FATO_VEICULO(ID_TEMPO)
CREATE INDEX IX_FATO_VEICULO_IPO_VEICULO ON FATO_VEICULO(ID_TIPO_VEICULO)
CREATE INDEX IX_FATO_VEICULO_SECRETARIA ON FATO_VEICULO(ID_SECRETARIA)
CREATE INDEX IX_FATO_VEICULO_INSTITUICAO ON FATO_VEICULO(ID_INSTITUICAO)

DROP TABLE FATO_CONTRATO_FERIADO
CREATE TABLE FATO_CONTRATO_FERIADO (
	ID_VENDA INT NOT NULL IDENTITY(1,1),
	ID_TEMPO BIGINT NOT NULL,
	ID_PRODUTO INT NOT NULL,
	ID_LOJA INT NOT NULL,
	COD_VENDA INT NOT NULL,
	VALOR DECIMAL(10,2) NOT NULL,
	DESCONTO DECIMAL(3,2) NOT NULL DEFAULT 1.00,
	ACAO VARCHAR(50) NOT NULL DEFAULT 'VENDIDO',
	QUANTIDADE INT NOT NULL DEFAULT 1,
	PRIMARY KEY (ID_VENDA),
	INDEX INDEX_COD_VENDA(COD_VENDA),
	INDEX INDEX_VALOR(VALOR),
	INDEX INDEX_ACAO(ACAO),
	
	CONSTRAINT FK_TEMPO_FERIADO
		FOREIGN KEY (ID_TEMPO)
		REFERENCES DIM_TEMPO (ID_TEMPO),
	CONSTRAINT FK_PRODUTO_FERIADO
		FOREIGN KEY (ID_PRODUTO)
		REFERENCES DIM_PRODUTO (ID_PRODUTO),
	CONSTRAINT FK_LOJA_FERIADO
		FOREIGN KEY (ID_LOJA)
		REFERENCES DIM_LOJA (ID_LOJA),
)

DROP TABLE TB_VIO_CONTRATO
CREATE TABLE TB_VIO_CONTRATO (
    ID_VIOLACAO INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	DATA_CARGA DATETIME NOT NULL,
	DATA_VENDA DATETIME NULL,
	ID_TEMPO BIGINT NOT NULL,
	ID_AVALIACAO INT NOT NULL,
	ID_PAGAMENTO INT NOT NULL,
	ID_STATUS INT NOT NULL,
	ID_PRODUTO INT NOT NULL,
	ID_LOJA INT NOT NULL,
	COD_VENDA INT NOT NULL,
	VALOR DECIMAL(10,2) NOT NULL,
	DESCONTO DECIMAL(3,2) NOT NULL DEFAULT 1.00,
	ACAO VARCHAR(50) NOT NULL DEFAULT 'VENDIDO',
	QUANTIDADE INT NOT NULL DEFAULT 1,
	DT_ERRO DATETIME NOT NULL,
    VIOLACAO VARCHAR(150) NOT NULL
)


