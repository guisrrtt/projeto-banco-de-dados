from conexao import conectar

def deletar_usuario(id_usuario):
    """Deleta um usuário do banco de dados pelo ID fornecido."""
    conexao = conectar() 
    if conexao:
        cursor = conexao.cursor()
        try:
            cursor.execute("DELETE FROM usuario WHERE id = %s", (id_usuario,))
            conexao.commit()
            if cursor.rowcount > 0:
                print(f"Usuário com ID {id_usuario} deletado com sucesso!")
            else:
                print(f"Nenhum usuário com ID {id_usuario} foi encontrado.")
        except Exception as e:
            print(f"Erro ao deletar usuário com ID {id_usuario}: {e}")
        finally:
            cursor.close()
            conexao.close()

# Exemplo de uso
if __name__ == "__main__":
    try:
        id_usuario = int(input("Digite o ID do usuário que deseja deletar: "))
        deletar_usuario(id_usuario)
    except ValueError:
        print("Por favor, insira um número válido para o ID.")
