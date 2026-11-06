Create DataBase Curso_Formacao;
Use Curso_Formacao;

CREATE TABLE turma (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    designacao VARCHAR(100) NOT NULL,
    data_criacao DATE NOT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB;

CREATE TABLE curso (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    designacao VARCHAR(150) NOT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB;

CREATE TABLE formando (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    numero_identificacao VARCHAR(50) NOT NULL,
    data_nascimento DATE NOT NULL,
    turma_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_formando_numero_identificacao (numero_identificacao),
    CONSTRAINT fk_formando_turma
        FOREIGN KEY (turma_id) REFERENCES turma (id)
) ENGINE = InnoDB;

CREATE TABLE turma_curso (
    turma_id INT UNSIGNED NOT NULL,
    curso_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (turma_id, curso_id),
    CONSTRAINT fk_turma_curso_turma
        FOREIGN KEY (turma_id) REFERENCES turma (id),
    CONSTRAINT fk_turma_curso_curso
        FOREIGN KEY (curso_id) REFERENCES curso (id)
) ENGINE = InnoDB;