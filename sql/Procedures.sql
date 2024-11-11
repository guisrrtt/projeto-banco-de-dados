-- Procedure 1: Verificar_atividades
-- Atualiza toda a tabela de atividades_recentes com a data atual
DELIMITER //
CREATE PROCEDURE Verificar_atividades()
BEGIN
    UPDATE atividades_recentes
    SET ultima_versao = CURDATE();
END //
DELIMITER ;

-- Procedure 2: Conta_usuarios
-- Recebe um id de arquivo e conta quantos usuários diferentes possuem acesso
DELIMITER //
CREATE PROCEDURE Conta_usuarios(IN arquivo_id INT)
BEGIN
    SELECT COUNT(DISTINCT usuario_id) AS total_usuarios
    FROM (
        SELECT id_compartilhado AS usuario_id
        FROM compartilhamento
        WHERE id_arquivo = arquivo_id
        UNION
        SELECT id_dono AS usuario_id
        FROM compartilhamento
        WHERE id_arquivo = arquivo_id
    ) AS todos_usuarios;
END //
DELIMITER ;

-- Procedure 3: Chavear
-- Alterna o estado de prioridade do arquivo entre 'prioritário' e 'não prioritário'
DELIMITER //
CREATE PROCEDURE Chavear(IN arquivo_id INT)
BEGIN
    UPDATE atividades_recentes
    SET acesso = CASE 
        WHEN acesso = 'prioritário' THEN 'não prioritário'
        ELSE 'prioritário'
    END
    WHERE id_arquivo = arquivo_id;
END //
DELIMITER ;

-- Procedure 4: Remover_acessos
-- Remove o acesso de todos os usuários de um arquivo, exceto do proprietário
DELIMITER //
CREATE PROCEDURE Remover_acessos(IN arquivo_id INT)
BEGIN
    DELETE FROM compartilhamento
    WHERE id_arquivo = arquivo_id AND id_compartilhado <> id_dono;
END //
DELIMITER ;


CALL Verificar_atividades();

CALL Conta_usuarios(2);

CALL Chavear(5);

CALL Remover_acessos(2);




