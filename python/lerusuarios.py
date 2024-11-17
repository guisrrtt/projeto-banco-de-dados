from conexao import conectar

def ler_usuarios():
    conexao = conectar()
    if conexao:
        cursor = conexao.cursor()
        try:
            cursor.execute("SELECT * FROM usuario")
            resultados = cursor.fetchall()
            for usuario in resultados:
                print(f"ID: {usuario[0]}, Login: {usuario[1]}, Email: {usuario[4]}, Data Ingresso: {usuario[3]}")
        except Exception as e:
            print(f"Erro ao ler usuários: {e}")
        finally:
            cursor.close()
            conexao.close()

# Exemplo de uso
if __name__ == "__main__":
    ler_usuarios()
