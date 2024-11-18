from conexao import conectar

def atualizar_usuario(id_usuario, novo_login=None, nova_senha=None, novo_email=None):
    conexao = conectar()
    if conexao:
        cursor = conexao.cursor()
        try:
            query = "UPDATE usuario SET "
            params = []
            
            if novo_login:
                query += "login = %s, "
                params.append(novo_login)
            if nova_senha:
                query += "senha = %s, "
                params.append(nova_senha)
            if novo_email:
                query += "email = %s, "
                params.append(novo_email)
            
            query = query.rstrip(', ') + " WHERE id = %s"
            params.append(id_usuario)

            cursor.execute(query, tuple(params))
            conexao.commit()
            print("Usuário atualizado com sucesso!")
        except Exception as e:
            print(f"Erro ao atualizar usuário: {e}")
        finally:
            cursor.close()
            conexao.close()

if __name__ == "__main__":
    try:
        print("Atualizar Usuário")
        id_usuario = int(input("Digite o ID do usuário que deseja atualizar: "))
        
        novo_login = input("Digite o novo login (ou deixe em branco): ").strip()
        novo_login = novo_login if novo_login else None
        
        nova_senha = input("Digite a nova senha (ou deixe em branco): ").strip()
        nova_senha = nova_senha if nova_senha else None
        
        novo_email = input("Digite o novo e-mail (ou deixe em branco): ").strip()
        novo_email = novo_email if novo_email else None

        atualizar_usuario(
            id_usuario=id_usuario,
            novo_login=novo_login,
            nova_senha=nova_senha,
            novo_email=novo_email
        )
    except ValueError:
        print("Erro: O ID do usuário deve ser um número inteiro válido.")
