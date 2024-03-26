import pandas as pd


# Caminho para o arquivos CSV
caminho_arquivo_csv = 'Base de dados//consulta_frota_veiculoss.csv'
df = pd.read_csv(caminho_arquivo_csv)

#contratos_arquivo = 'Base de dados//contratos_licitacoes.csv'

#df_contratos_csv = pd.read_csv(contratos_arquivo)
#print(df_contratos_csv)
# Separar os dados da primeira coluna em diferentes colunas
colunas = df.iloc[:, 0].str.split(';', expand=True)


# Extrair todos os dados da coluna 1
Instituicao_dados = colunas[0]
secretaria_dados = colunas[1]
Tipo_veiculo = colunas[2]
Tipo_observacao = colunas[8]
Placa = colunas[3]
marca_modelo = colunas[4]
Ano_fabricao = colunas[5]
Ano_fabricao = Ano_fabricao.str.replace('.', '')
Ano_modelo = colunas[6]
Ano_modelo = Ano_modelo.str.replace('.', '')
Cor = colunas[7]

Instituicao_dados = Instituicao_dados.unique()
secretaria_dados = secretaria_dados.unique()
Tipo_veiculo_dados = Tipo_veiculo.unique()
Tipo_observacao = Tipo_observacao.unique()


secretaria_codigos = "Base de dados//SECRETARIA.csv"
caminho_arquivo = "Base de dados//INSERTS.txt"
Tipos_obs_codigos = "Base de dados//Tipo_observacao.csv"
caminho_instituicao = 'Base de dados//Instituicao.csv'

df_SECRETARIA = pd.read_csv(secretaria_codigos)

df_SECRETARIA = df_SECRETARIA.iloc[:, 0].str.split(';', expand=True)

df_obs_tipo = pd.read_csv(Tipos_obs_codigos)
df_obs_tipo = df_obs_tipo.iloc[:, 0].str.split(';', expand=True)

df_instituicao = pd.read_csv(caminho_instituicao)
df_instituicao = df_instituicao.iloc[:, 0].str.split(';', expand=True)

mapeamento = dict(zip(df_SECRETARIA[1], df_SECRETARIA[0]))
mapeamento_obs = dict(zip(df_obs_tipo[1], df_obs_tipo[0]))
mapeamento_instituicao = dict(zip(df_instituicao[1], df_instituicao[0]))


incrementador = 0
with open(caminho_arquivo, 'w') as arquivo_sql:
    for instituicao in Instituicao_dados:
        arquivo_sql.write(f"INSERT INTO TB_INSTITUICAO (nome) VALUES ('{instituicao}');\n")
    for secretaria in secretaria_dados:
        arquivo_sql.write(f"INSERT INTO TB_SECRETARIA (COD_SECRETARIA, nome) VALUES ('{secretaria}');\n")
    for tipo_veiculo in Tipo_veiculo_dados:
        arquivo_sql.write(f"INSERT INTO TB_TIPO_VEICULO (nome) VALUES ('{tipo_veiculo}');\n")
    for Tipo_observacao in Tipo_observacao:
        arquivo_sql.write(f"INSERT INTO TB_TIPO_OBSERVACAO (TIPO_CAR) VALUES ('{Tipo_observacao}');\n")
    for veiculo in Placa:
        codigo = mapeamento.get(colunas[1][incrementador]) 
        obs_codigo = mapeamento_obs.get(colunas[8][incrementador])
        intituicao_cod = mapeamento_instituicao.get(colunas[0][incrementador])
        arquivo_sql.write(f"INSERT INTO TB_VEICULO (PLACA, MARCA, MODELO, ANO_FABRICACAO, ANO_MODELO, COR, COD_TIPO_VEICULO, COD_SECRETARIA, COD_TIPO_OBSERVACAO, COD_INSTITUICAO) \n VALUES ( '{Placa[incrementador]}', '{marca_modelo[incrementador]}','{marca_modelo[incrementador]}', '01/01/{Ano_fabricao[incrementador]}', '01/01/{Ano_modelo[incrementador]}', '{Cor[incrementador]}', 1, {codigo}, {obs_codigo}, {intituicao_cod});\n")
        incrementador += 1


# Retirando valores none do txt de inserts
        
caminho_arquivo_entrada = 'Base de dados//INSERTS.txt'
# Abrir o arquivo de entrada para leitura e escrita
with open(caminho_arquivo_entrada, 'r+') as arquivo:
    # Ler todas as linhas do arquivo
    linhas = arquivo.readlines()
    # Voltar ao início do arquivo para sobrescrevê-lo
    arquivo.seek(0)
    # Iterar sobre as linhas lidas do arquivo
    for linha in linhas:
        # Substituir 'None' por '1' e escrever a linha modificada no arquivo
        nova_linha = linha.replace('None', '1')
        arquivo.write(nova_linha)
    # Truncar o restante do arquivo caso o novo conteúdo seja menor
    arquivo.truncate()
