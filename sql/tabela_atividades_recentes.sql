CREATE TABLE atividades_recentes (
    id_arquivo INT PRIMARY KEY,
    ultima_versao DATE NOT NULL,
    acesso ENUM('prioritário', 'não prioritário') NOT NULL,
    FOREIGN KEY (id_arquivo) REFERENCES arquivo(id)
);

INSERT INTO atividades_recentes (id_arquivo, ultima_versao, acesso)
VALUES
    (1, '2024-07-15', 'prioritário'),
    (2, '2024-08-22', 'não prioritário'),
    (3, '2024-09-10', 'prioritário'),
    (4, '2024-10-05', 'não prioritário'),
    (5, '2024-10-15', 'prioritário'),
    (6, '2024-09-20', 'não prioritário'),
    (7, '2024-10-25', 'prioritário'),
    (8, '2024-11-01', 'não prioritário'),
    (9, '2024-08-30', 'prioritário'),
    (10, '2024-07-01', 'não prioritário');
