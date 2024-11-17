import mysql.connector
from mysql.connector import Error

def conectar():
    try:
        print("Tentando conectar ao MySQL...")
        conexao = mysql.connector.connect(
            host='localhost',          
            user='root',             
            password='Messi10',         
            database='sistema_arquivos3'
        )
        
        if conexao.is_connected():
            db_info = conexao.get_server_info()
            print(f"Conectado ao MySQL Server versão {db_info}")
            print(f"Conexão ao banco de dados 'sistema_arquivos3' estabelecida com sucesso!\n")
            return conexao
        else:
            print("Falha ao conectar ao MySQL. Verifique suas credenciais e tente novamente.")
            return None
    
    except Error as e:
        print(f"Erro ao tentar conectar ao MySQL: {e}")
        return None


# Testando a conexão
if __name__ == "__main__":
    conexao = conectar()
    if conexao:
        print("Teste de conexão bem-sucedido!")
        conexao.close()
    else:
        print("Falha no teste de conexão.")


