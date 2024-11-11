CREATE ROLE PapelUsuario;
GRANT SELECT, INSERT, UPDATE ON view_usuario TO PapelUsuario;

CREATE ROLE PapelEmpresa;
GRANT SELECT ON usuario TO PapelEmpresa;
GRANT SELECT ON view_usuario TO PapelEmpresa;

CREATE ROLE PapelAdm;
GRANT ALL PRIVILEGES ON *.* TO PapelAdm;

