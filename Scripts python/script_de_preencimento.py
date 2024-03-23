import pandas as pd

import mysql.connector

# Replace these values with your actual MySQL server credentials
host = "localhost"
user = "root    "
password = "123456"
database = "mydb"



# caminho para o arquivo dos veiculos
caminho_arquivo_csv = 'consulta_frota_veiculos.csv'

try:
    # Lê o arquivo CSV usando pandas
    dataframe = pd.read_csv(caminho_arquivo_csv, header=None, sep=';')

    # Pega os dados da terceira coluna
    tipo_do_veiculo = dataframe.iloc[:, 2].drop_duplicates().tolist()

    # Imprime os dados da terceira coluna
    print("Dados da terceira coluna:", tipo_do_veiculo)

except FileNotFoundError:
    print(f"O arquivo {caminho_arquivo_csv} não foi encontrado.")
except Exception as e:
    print(f"Ocorreu um erro: {e}")


try:
    # Establish a connection to the MySQL server
    connection = mysql.connector.connect(
        host=host,
        user=user,
        password=password,
        database=database
    )

    if connection.is_connected():
        print("Connected to MySQL database")

        # Execute your SQL queries or operations here
        # For example, you can create a cursor and execute a simple query
        cursor = connection.cursor()
        cursor.execute("SELECT * FROM Tipo_veiculo")

        # Fetch and print the results
        result = cursor.fetchall()
        for row in result:
            print(row)

except mysql.connector.Error as e:
    print(f"Error: {e}")

finally:
    # Close the connection when done
    if connection.is_connected():
        cursor.close()
        connection.close()
        print("Connection closed")




