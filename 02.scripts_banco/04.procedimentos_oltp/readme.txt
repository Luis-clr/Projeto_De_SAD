CREATE OR ALTER PROCEDURE sp_fato_venda
    @data_carga DATETIME
AS
BEGIN
    DECLARE @DATA_VENDA DATETIME,
            @ID_TEMPO INT,
            @ID_LOJA INT,
            @ID_PRODUTO INT,
            @ID_TIPO_PAGAMENTO INT,
            @COD_LOJA INT,
            @COD_PRODUTO INT,
            @COD_TIPO_PAGAMENTO INT,
            @COD_VENDA INT,
            @VOLUME NUMERIC(10,2),
            @VALOR NUMERIC(10,2),
            @VIOLACAO VARCHAR(150)

    DECLARE C_VENDA CURSOR FOR
        SELECT DATA_VENDA, COD_LOJA, COD_PRODUTO, COD_TIPO_PAGAMENTO, COD_VENDA, VOLUME, VALOR
        FROM TB_AUX_VENDA
        WHERE @data_carga = DATA_CARGA

    OPEN C_VENDA
    FETCH NEXT FROM C_VENDA INTO @DATA_VENDA, @COD_LOJA, @COD_PRODUTO, @COD_TIPO_PAGAMENTO, @COD_VENDA, @VOLUME, @VALOR

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Verificar se a data de venda é válida na dimensão tempo
        IF NOT EXISTS (SELECT 1 FROM DIM_TEMPO WHERE ID_TEMPO = @DATA_VENDA)
        BEGIN
            SET @VIOLACAO = 'Data de venda inválida na dimensão tempo'
            INSERT INTO TB_VIO_VENDA (DATA_CARGA, DATA_VENDA, COD_LOJA, COD_PRODUTO, COD_TIPO_PAGAMENTO, COD_VENDA, VOLUME, VALOR, DT_ERRO, VIOLACAO)
            VALUES (@data_carga, @DATA_VENDA, @COD_LOJA, @COD_PRODUTO, @COD_TIPO_PAGAMENTO, @COD_VENDA, @VOLUME, @VALOR, GETDATE(), @VIOLACAO)
            FETCH NEXT FROM C_VENDA INTO @DATA_VENDA, @COD_LOJA, @COD_PRODUTO, @COD_TIPO_PAGAMENTO, @COD_VENDA, @VOLUME, @VALOR
            CONTINUE
        END

        -- Verificar se o código da loja é válido na dimensão loja
        IF NOT EXISTS (SELECT 1 FROM DIM_LOJA WHERE COD_LOJA = @COD_LOJA)
        BEGIN
            SET @VIOLACAO = 'Código da loja inválido na dimensão loja'
            INSERT INTO TB_VIO_VENDA (DATA_CARGA, DATA_VENDA, COD_LOJA, COD_PRODUTO, COD_TIPO_PAGAMENTO, COD_VENDA, VOLUME, VALOR, DT_ERRO, VIOLACAO)
            VALUES (@data_carga, @DATA_VENDA, @COD_LOJA, @COD_PRODUTO, @COD_TIPO_PAGAMENTO, @COD_VENDA, @VOLUME, @VALOR, GETDATE(), @VIOLACAO)
            FETCH NEXT FROM C_VENDA INTO @DATA_VENDA, @COD_LOJA, @COD_PRODUTO, @COD_TIPO_PAGAMENTO, @COD_VENDA, @VOLUME, @VALOR
            CONTINUE
        END

        -- Verificar se o código do produto é válido na dimensão produto
        IF NOT EXISTS (SELECT 1 FROM DIM_PRODUTO WHERE COD_PRODUTO = @COD_PRODUTO)
        BEGIN
            SET @VIOLACAO = 'Código do produto inválido na dimensão produto'
            INSERT INTO TB_VIO_VENDA (DATA_CARGA, DATA_VENDA, COD_LOJA, COD_PRODUTO, COD_TIPO_PAGAMENTO, COD_VENDA, VOLUME, VALOR, DT_ERRO, VIOLACAO)
            VALUES (@data_carga, @DATA_VENDA, @COD_LOJA, @COD_PRODUTO, @COD_TIPO_PAGAMENTO, @COD_VENDA, @VOLUME, @VALOR, GETDATE(), @VIOLACAO)
            FETCH NEXT FROM C_VENDA INTO @DATA_VENDA, @COD_LOJA, @COD_PRODUTO, @COD_TIPO_PAGAMENTO, @COD_VENDA, @VOLUME, @VALOR
            CONTINUE
        END

        -- Verificar se o código do tipo de pagamento é válido na dimensão tipo de pagamento
        IF NOT EXISTS (SELECT 1 FROM DIM_TIPO_PAGAMENTO WHERE COD_TIPO_PAGAMENTO = @COD_TIPO_PAGAMENTO)
        BEGIN
            SET @VIOLACAO = 'Código do tipo de pagamento inválido na dimensão tipo de pagamento'
            INSERT INTO TB_VIO_VENDA (DATA_CARGA, DATA_VENDA, COD_LOJA, COD_PRODUTO, COD_TIPO_PAGAMENTO, COD_VENDA, VOLUME, VALOR, DT_ERRO, VIOLACAO)
            VALUES (@data_carga, @DATA_VENDA, @COD_LOJA, @COD_PRODUTO, @COD_TIPO_PAGAMENTO, @COD_VENDA, @VOLUME, @VALOR, GETDATE(), @VIOLACAO)
            FETCH NEXT FROM C_VENDA INTO @DATA_VENDA, @COD_LOJA, @COD_PRODUTO, @COD_TIPO_PAGAMENTO, @COD_VENDA, @VOLUME, @VALOR
            CONTINUE
        END

        -- Verificar se o volume é um valor numérico maior que 0
        IF @VOLUME <= 0
        BEGIN
            SET @VIOLACAO = 'Volume inválido, deve ser maior que zero'
            INSERT INTO TB_VIO_VENDA (DATA_CARGA, DATA_VENDA, COD_LOJA, COD_PRODUTO, COD_TIPO_PAGAMENTO, COD_VENDA, VOLUME, VALOR, DT_ERRO, VIOLACAO)
            VALUES (@data_carga, @DATA_VENDA, @COD_LOJA, @COD_PRODUTO, @COD_TIPO_PAGAMENTO, @COD_VENDA, @VOLUME, @VALOR, GETDATE(), @VIOLACAO)
            FETCH NEXT FROM C_VENDA INTO @DATA_VENDA, @COD_LOJA, @COD_PRODUTO, @COD_TIPO_PAGAMENTO, @COD_VENDA, @VOLUME, @VALOR
            CONTINUE
        END

        -- Verificar se o valor é um valor numérico maior que 0
        IF @VALOR <= 0
        BEGIN
            SET @VIOLACAO = 'Valor inválido, deve ser maior que zero'
            INSERT INTO TB_VIO_VENDA (DATA_CARGA, DATA_VENDA, COD_LOJA, COD_PRODUTO, COD_TIPO_PAG
