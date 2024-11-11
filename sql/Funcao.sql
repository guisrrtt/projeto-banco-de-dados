DELIMITER //
CREATE FUNCTION Verifica_Alteracao_100_Dias(arquivo_id INT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE resultado BOOLEAN DEFAULT FALSE;

    IF (SELECT DATEDIFF(CURDATE(), data_ultima_modificacao) FROM arquivo WHERE id = arquivo_id) > 100 THEN
        SET resultado = TRUE;
    ELSE
        SET resultado = FALSE;
    END IF;

    RETURN resultado;
END //
DELIMITER ;

SELECT Verifica_Alteracao_100_Dias(4) AS resultado;