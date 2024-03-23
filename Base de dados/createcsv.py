import pandas as pd
import mysql.connector

# Substitua 'seu_arquivo.csv' pelo caminho do seu arquivo CSV
arquivo_veiculo = 'consulta_frota_veiculos.csv'
arquivo_licitacoes = 'contratos_licitacoes.csv'

# Configuração para conexão ao banco de dados
host = "localhost"
user = "root"
password = "123456"
database = "mydb"

try:
    # Lê o arquivo CSV usando pandas
    dataframe_veiculos = pd.read_csv(arquivo_veiculo, header=None, sep=';')
    dataframe_licitacoes = pd.read_csv(arquivo_licitacoes, sep=';')
    # -> pega todas as instituicoes da prefeitura 
    Instituicoes_prefeitura = dataframe_veiculos.iloc[:, 0].drop_duplicates().tolist()
    Instituicoes_prefeitura =  Instituicoes_prefeitura + dataframe_licitacoes['Instituição'].drop_duplicates().to_list()
    Instituicoes_prefeitura = list(set(Instituicoes_prefeitura))
    # -> pega a secretaria da prefeitura
    secretaria_prefeitura = dataframe_veiculos.iloc[:, 1].drop_duplicates().tolist()
    # -> pega os tipos de veiculos
    tipo_do_veiculo = dataframe_veiculos.iloc[:, 2].drop_duplicates().tolist()
    # -> pega os tipos de observacoes do veiculo
    obesercao_veiculo_tipo_de_dados = dataframe_veiculos.iloc[:, 8].drop_duplicates().tolist()
    obesercao_veiculo_tipo_de_dados = pd.Series(obesercao_veiculo_tipo_de_dados).fillna('null').to_list()

    ### -> caso queira pega as placas
    #placas_veiculos = dataframe_veiculos.iloc[:, 3].drop_duplicates().tolist()

    # Conecta ao MySQL
    connection = mysql.connector.connect(
        host=host,
        user=user,
        password=password,
        database=database
    )

    if connection.is_connected():
        print("Connected to MySQL database")
        cursor = connection.cursor()

        # comecas as consultas sql

        for tipo_veiculo in tipo_do_veiculo:
            cursor.execute("INSERT INTO Tipo_veiculo (nome) VALUES (%s)", (tipo_veiculo,))

        for tipo_observacao in obesercao_veiculo_tipo_de_dados:
            cursor.execute("INSERT INTO Tipo_observacao (Tipo_carro) VALUES (%s)", (tipo_observacao,))

        for instituicao in Instituicoes_prefeitura:
            cursor.execute("INSERT INTO Instituicao (nome) VALUES (%s)", (instituicao,))


        for secretaria_inst in secretaria_prefeitura:
            cursor.execute("INSERT INTO Secretaria (nome) VALUES (%s)", (secretaria_inst,))

        # Commit para salvar as alterações
        connection.commit()

        # Imprime os resultados
        print("Inserções realizadas com sucesso.")

except FileNotFoundError:
    print(f"O arquivo {arquivo_veiculo} não foi encontrado.")
except Exception as e:
    print(f"Ocorreu um erro: {e}")
finally:
    # Sempre feche a conexão, seja qual for o resultado
    if connection.is_connected():
        cursor.close()
        connection.close()
        print("Connection closed.")
