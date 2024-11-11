-- Trigger 1: Safe_security
-- Impede que arquivos executáveis (.exe) sejam inseridos na tabela de arquivos

DELIMITER //
CREATE TRIGGER Safe_security
BEFORE INSERT ON arquivo
FOR EACH ROW
BEGIN
    IF NEW.tipo = 'exe' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Inserção de arquivos executáveis não é permitida.';
    END IF;
END //
DELIMITER ;

-- Trigger 2: Registrar_operacao
-- Atualiza a data da última operação na tabela atividades_recentes sempre que houver uma nova operação no arquivo

DELIMITER //
CREATE TRIGGER Registrar_operacao
AFTER UPDATE ON arquivo
FOR EACH ROW
BEGIN
    UPDATE atividades_recentes
    SET ultima_versao = CURDATE()
    WHERE id_arquivo = NEW.id;
END //
DELIMITER ;

-- Trigger 3: Atualizar_acesso
-- Atualiza a data de acesso de um usuário ao conseguir acesso a um novo arquivo na tabela compartilhamento
DELIMITER //

CREATE TRIGGER Atualizar_acesso
AFTER INSERT ON Compartilhamento
FOR EACH ROW
BEGIN
    -- Verifica se o registro do arquivo já existe em Atividades_recentes
    IF NOT EXISTS (
        SELECT 1
        FROM Atividades_recentes
        WHERE Id_arquivo = NEW.Id_arquivo
    ) THEN
        -- Insere um novo registro para o arquivo recém-compartilhado
        INSERT INTO Atividades_recentes (Id_arquivo, Ultima_versao, Acesso)
        VALUES (NEW.Id_arquivo, CURDATE(), 'prioritário');
    ELSE
        -- Atualiza a data e o status do arquivo existente
        UPDATE Atividades_recentes
        SET Ultima_versao = CURDATE(), Acesso = 'prioritário'
        WHERE Id_arquivo = NEW.Id_arquivo;
    END IF;
END //

DELIMITER ;


