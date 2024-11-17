from conexao import conectar

def inserir_usuario(login, senha, email, data_ingresso):
    conexao = conectar()
    if conexao:
        cursor = conexao.cursor()
        try:
            sql = "INSERT INTO usuario (login, senha, email, data_ingresso) VALUES (%s, %s, %s, %s)"
            valores = (login, senha, email, data_ingresso)
            cursor.execute(sql, valores)
            conexao.commit()
            print("Usuário inserido com sucesso!")
        except Exception as e:
            print(f"Erro ao inserir usuário: {e}")
            conexao.rollback()
        finally:
            cursor.close()
            conexao.close()

if __name__ == "__main__":
    print("Insira os dados do novo usuário:")
    login = input("Login: ").strip()
    senha = input("Senha: ").strip()
    email = input("Email: ").strip()
    data_ingresso = input("Data de ingresso (AAAA-MM-DD): ").strip()
    
    if login and senha and email and data_ingresso:
        inserir_usuario(login, senha, email, data_ingresso)
    else:
        print("Erro: Todos os campos devem ser preenchidos!")
