USE master;


DROP DATABASE sad_projeto;


CREATE DATABASE sad_projeto;
USE sad_projeto;

-- Secretaria Table
CREATE TABLE [mydb].[Secretaria] (
    [idSecretaria] INT IDENTITY(1,1) NOT NULL,
    [Nome] VARCHAR(45) NOT NULL,
    PRIMARY KEY ([idSecretaria]),
    CONSTRAINT [uc_idSecretaria] UNIQUE ([idSecretaria]),
    CONSTRAINT [uc_Nome] UNIQUE ([Nome])
);

-- Instituicao Table
CREATE TABLE [mydb].[Instituicao] (
    [idInstituicao] INT IDENTITY(1,1) NOT NULL,
    [nome] VARCHAR(45) NOT NULL,
    PRIMARY KEY ([idInstituicao]),
    CONSTRAINT [uc_nome] UNIQUE ([nome])
);

-- Tipo_veiculo Table
CREATE TABLE [mydb].[Tipo_veiculo] (
    [idTipo_veiculo] INT IDENTITY(1,1) NOT NULL,
    [nome] VARCHAR(10) NOT NULL CHECK ([nome] IN ('Proprio', 'Publico')),
    PRIMARY KEY ([idTipo_veiculo]),
    CONSTRAINT [uc_nome_tipo_veiculo] UNIQUE ([nome])
);

-- Tipo_observacao Table
CREATE TABLE [mydb].[Tipo_observacao] (
    [idTipo_veiculo] INT IDENTITY(1,1) NOT NULL,
    [Tipo_carro] VARCHAR(45) NOT NULL,
    PRIMARY KEY ([idTipo_veiculo])
);

-- Veiculo Table
CREATE TABLE [mydb].[Veiculo] (
    [idVeiculo] INT IDENTITY(1,1) NOT NULL,
    [placa] VARCHAR(7) NOT NULL,
    [ano_fabricacao] DATE NOT NULL,
    [ano_modelo] DATE NOT NULL,
    [cor] VARCHAR(45) NOT NULL,
    [Tipo_veiculo_idTipo_veiculo] INT NOT NULL,
    [Secretaria_idSecretaria] INT NOT NULL,
    [Instituicao_idInstituicao] INT NOT NULL,
    [Tipo_observacao_idTipo_veiculo] INT NOT NULL,
    PRIMARY KEY ([idVeiculo]),
    CONSTRAINT [uc_placa] UNIQUE ([placa]),
    CONSTRAINT [fk_Veiculo_Tipo_veiculo] FOREIGN KEY ([Tipo_veiculo_idTipo_veiculo]) REFERENCES [mydb].[Tipo_veiculo] ([idTipo_veiculo]),
    CONSTRAINT [fk_Veiculo_Secretaria1] FOREIGN KEY ([Secretaria_idSecretaria]) REFERENCES [mydb].[Secretaria] ([idSecretaria]),
    CONSTRAINT [fk_Veiculo_Instituicao1] FOREIGN KEY ([Instituicao_idInstituicao]) REFERENCES [mydb].[Instituicao] ([idInstituicao]),
    CONSTRAINT [fk_Veiculo_Tipo_observacao1] FOREIGN KEY ([Tipo_observacao_idTipo_veiculo]) REFERENCES [mydb].[Tipo_observacao] ([idTipo_veiculo])
);

-- Contrato Table
CREATE TABLE [mydb].[Contrato] (
    [idContrato] INT IDENTITY(1,1) NOT NULL,
    [data] DATE NOT NULL,
    [numero] VARCHAR(8) NOT NULL,
    [objetivo_contrato] VARCHAR(99) NOT NULL,
    [data_realizacao] DATETIME NULL,
    [valor] VARCHAR(45) NULL,
    [Instituicao_idInstituicao] INT NOT NULL,
    [modalidade_idmodalidade] INT NOT NULL,
    PRIMARY KEY ([idContrato]),
    CONSTRAINT [fk_Contrato_Instituicao1] FOREIGN KEY ([Instituicao_idInstituicao]) REFERENCES [mydb].[Instituicao] ([idInstituicao]),
    CONSTRAINT [fk_Contrato_modalidade1] FOREIGN KEY ([modalidade_idmodalidade]) REFERENCES [mydb].[modalidade] ([idmodalidade])
);

-- Modalidade Table
CREATE TABLE [mydb].[modalidade] (
    [idmodalidade] INT IDENTITY(1,1) NOT NULL,
    [tipo] VARCHAR(15) NOT NULL CHECK ([tipo] IN ('Dispensa', 'Concorrencia', 'Cotacao de Preco')),
    PRIMARY KEY ([idmodalidade])
);

insert into Tipo_veiculo(nome)
values('Proprio')

INSERT INTO Tipo_observacao (idTipo_veiculo, Tipo_carro)
VALUES (1, 'Flex');

insert INTO Secretaria(Nome)
values('SEMED')

insert into Instituicao(nome)
values('PML')

select * from Tipo_veiculo
select * from Tipo_observacao
select * from Secretaria
select * from Instituicao
select * from Veiculo

insert into Veiculo(placa,ano_fabricacao,ano_modelo,cor,Tipo_veiculo_idTipo_veiculo,Secretaria_idSecretaria,Instituicao_idInstituicao,Tipo_observacao_idTipo_veiculo)
values
('ABC1234','2022-01-01','2024-01-01', 'Preto',1,1,1,1);

