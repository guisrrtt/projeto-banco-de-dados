CREATE VIEW view_usuario AS
SELECT nome, tipo, permissoes_acesso, tamanho, data_ultima_modificacao, localizacao, URL
FROM arquivo
JOIN compartilhamento ON arquivo.id = compartilhamento.id_arquivo
WHERE compartilhamento.id_compartilhado = CURRENT_USER();

CREATE VIEW view_administrador AS
SELECT nome, tipo, permissoes_acesso, tamanho, data_ultima_modificacao, localizacao, URL
FROM arquivo;

CREATE VIEW view_historico AS
SELECT data, hora, operacao, conteudo_mudado
FROM historicoversionamento;
