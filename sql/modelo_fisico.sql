CREATE DATABASE sistema_arquivos3;
USE sistema_arquivos3;

CREATE TABLE usuario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    login VARCHAR(50) NOT NULL UNIQUE,
    senha VARCHAR(50) NOT NULL,
    data_ingresso DATE,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE arquivo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    tipo VARCHAR(50),
    permissoes_acesso VARCHAR(50),
    tamanho INT,
    data_ultima_modificacao DATE,
    localizacao VARCHAR(100),
    URL VARCHAR(100) NOT NULL,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

CREATE TABLE compartilhamento (
    id_arquivo INT NOT NULL,
    id_dono INT NOT NULL,
    id_compartilhado INT NOT NULL,
    data_compartilhamento DATE,
    PRIMARY KEY (id_arquivo, id_dono, id_compartilhado),
    FOREIGN KEY (id_arquivo) REFERENCES arquivo(id),
    FOREIGN KEY (id_dono) REFERENCES usuario(id),
    FOREIGN KEY (id_compartilhado) REFERENCES usuario(id)
);

CREATE TABLE comentario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    conteudo TEXT,
    data DATE,
    hora TIME,
    id_arquivo INT NOT NULL,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_arquivo) REFERENCES arquivo(id),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

CREATE TABLE plano (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    duracao INT,
    data_aquisicao DATE,
    espaco_por_usuario INT UNSIGNED
);

CREATE TABLE instituicao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    causa_social VARCHAR(100),
    endereco VARCHAR(100),
    id_plano INT,
    FOREIGN KEY (id_plano) REFERENCES plano(id)
);

CREATE TABLE administrador (
    id INT PRIMARY KEY AUTO_INCREMENT,
    login VARCHAR(50) NOT NULL UNIQUE,
    senha VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    id_administrador INT NOT NULL
);

CREATE TABLE suporte (
    id INT PRIMARY KEY AUTO_INCREMENT,
    dia DATE,
    hora TIME,
    descricao TEXT,
    id_usuario INT NOT NULL,
    id_admin INT NOT NULL,
    id_arquivo INT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_admin) REFERENCES administrador(id),
    FOREIGN KEY (id_arquivo) REFERENCES arquivo(id)
);

CREATE TABLE historicoversionamento (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data DATE,
    hora TIME,
    operacao VARCHAR(50),
    id_usuario_alteracao INT NOT NULL,
    conteudo_mudado TEXT,
    id_arquivo INT NOT NULL,
    FOREIGN KEY (id_arquivo) REFERENCES arquivo(id),
    FOREIGN KEY (id_usuario_alteracao) REFERENCES usuario(id)
);

-- Inserções
INSERT INTO usuario (login, senha, data_ingresso, email) VALUES 
('guilherme.ribeiro', 'mobilia16', '2024-11-01', 'guilherme1@gmail.com'),
('ana.silva', 'tamandua27', '2024-11-01', 'aninha65@gmail.com'),
('joao.oliveira', 'livrariaonline89', '2024-11-01', 'jotinhaoli@gmail.com'),
('maria.fernandes', 'caderno35', '2024-11-01', 'mafernandes@gmail.com'),
('lucas.santos', '23454315', '2024-11-02', 'lucas87santos@gmail.com');

INSERT INTO arquivo (nome, tipo, permissoes_acesso, tamanho, data_ultima_modificacao, localizacao, URL, id_usuario) VALUES
('Relatorio_Anual_2024', 'pdf', 'publico', 512, '2024-11-05', '/docs/relatorios/', 'http://sistema.com/docs/Relatorio_Anual_2024.pdf', 1),
('Plano_Estrategico', 'xlsx', 'privado', 1024, '2024-11-06', '/docs/planos/', 'http://sistema.com/docs/Plano_Estrategico.xlsx', 1),
('Projeto_Inclusao', 'docx', 'publico', 2048, '2024-11-05', '/docs/projetos/', 'http://sistema.com/docs/Projeto_Inclusao.docx', 3),
('Lista_Clientes', 'csv', 'privado', 256, '2024-11-05', '/docs/listas/', 'http://sistema.com/docs/Lista_Clientes.csv', 4),
('Apresentacao_Vendas', 'pptx', 'publico', 3072, '2024-11-07', '/docs/apresentacoes/', 'http://sistema.com/docs/Apresentacao_Vendas.pptx', 4),
('Manual_Treinamento', 'pdf', 'privado', 1024, '2024-11-06', '/docs/manuais/', 'http://sistema.com/docs/Manual_Treinamento.pdf', 2),
('Relatorio_Financeiro', 'xlsx', 'publico', 4096, '2024-11-06', '/docs/relatorios/', 'http://sistema.com/docs/Relatorio_Financeiro.xlsx', 1),
('Guia_Usuario', 'docx', 'privado', 512, '2024-11-03', '/docs/guias/', 'http://sistema.com/docs/Guia_Usuario.docx', 2),
('Cronograma_Eventos', 'xlsx', 'publico', 1024, '2024-11-02', '/docs/cronogramas/', 'http://sistema.com/docs/Cronograma_Eventos.xlsx', 1),
('Politicas_Privacidade', 'pdf', 'privado', 2048, '2024-11-06', '/docs/politicas/', 'http://sistema.com/docs/Politicas_Privacidade.pdf', 3);


INSERT INTO compartilhamento (id_arquivo, id_dono, id_compartilhado, data_compartilhamento) VALUES
(1, 1, 2, '2024-11-08'),
(2, 2, 3, '2024-11-08'),
(3, 3, 1, '2024-11-08'),
(4, 4, 5, '2024-11-08'),
(5, 5, 3, '2024-11-08'),
(6, 3, 2, '2024-11-08'),
(7, 3, 5, '2024-11-08'),
(8, 2, 4, '2024-11-08'),
(9, 4, 3, '2024-11-08'),
(10, 1, 3, '2024-11-08');

INSERT INTO comentario (conteudo, data, hora, id_arquivo, id_usuario) VALUES
('Ótimo relatório, muito detalhado!', '2024-11-09', '10:15:00', 1, 3),
('Estratégia, em grego strateegia.', '2024-11-08', '14:30:00', 2, 3),
('Parabéns pelo projeto de inclusão!', '2024-11-08', '09:45:00', 3, 2),
('Lista de clientes bem organizada.', '2024-11-08', '11:20:00', 4, 1),
('Apresentação muito bem feita!', '2024-11-08', '13:55:00', 5, 2),
('Manual de treinamento claro e direto.', '2024-11-09', '15:40:00', 6, 2),
('Relatório financeiro preciso.', '2024-11-09', '08:30:00', 7, 4),
('Guia do usuário muito útil.', '2024-11-10', '16:25:00', 8, 5),
('Cronograma de eventos bem planejado.', '2024-11-11', '17:50:00', 9, 1),
('Política de privacidade bem explicada.', '2024-11-10', '12:00:00', 10, 1);

INSERT INTO plano (nome, duracao, data_aquisicao, espaco_por_usuario)
VALUES ('Plano Premium', 12, '2024-11-05', 10240);

INSERT INTO instituicao (nome, causa_social, endereco, id_plano)
VALUES ('UNICAP', 'Educação', 'R. do Príncipe, 526', 1);


-- Consultas (Buscas)
SELECT nome, tipo, tamanho, data_ultima_modificacao
FROM arquivo
WHERE usuario_id = 1;

SELECT c.conteudo, u.login AS usuario, c.data, c.hora
FROM Comentario c
JOIN Usuario u ON c.usuario_id = u.id
WHERE c.arquivo_id = 1;

SELECT a.nome, a.tipo, a.tamanho, a.data_ultima_modificacao, c.data_compartilhamento
FROM Compartilhamento c
JOIN Arquivo a ON c.id_arquivo = a.id
WHERE c.id_compartilhado = 3;


-- Updates (Atualizações)

UPDATE usuario
SET email = 'guilherme.ribeiro@gmail.com'
WHERE id = 1;

UPDATE arquivo
SET permissoes_acesso = 'privado'
WHERE id = 7;

UPDATE comentario
SET conteudo = 'Comentário atualizado: excelente projeto!'
WHERE id = 3;

-- Deletes

DELETE FROM comentario
WHERE id_arquivo = 2;

DELETE FROM compartilhamento
WHERE id_arquivo = 4;

DELETE FROM compartilhamento WHERE id_dono = 5 OR id_compartilhado = 5;







