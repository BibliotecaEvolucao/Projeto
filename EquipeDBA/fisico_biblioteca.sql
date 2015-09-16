CREATE DATABASE DB_BIBLIOTECA

USE DB_BIBLIOTECA 

CREATE TABLE tb_secao (
  cod_secao INTEGER  NOT NULL IDENTITY,
  se_nome VARCHAR(30) NULL,
  CONSTRAINT co_pk_cod_sec PRIMARY KEY(cod_secao)
);

CREATE TABLE tb_tp_obra (
  cod_tp_obra INTEGER  NOT NULL IDENTITY,
  tp_obra_nome VARCHAR(30) NULL,
  CONSTRAINT co_pk_cod_tp_o PRIMARY KEY(cod_tp_obra)
);

CREATE TABLE tb_autor (
  cod_autor INTEGER NOT NULL IDENTITY,
  au_nome   VARCHAR(100) NOT NULL,
  CONSTRAINT co_pk_cod_autor PRIMARY KEY(cod_autor)
);
CREATE TABLE tb_editora (
  cod_editora INTEGER  NOT NULL IDENTITY,
  ed_nome VARCHAR(100) NOT NULL,
  CONSTRAINT co_pk_cod_ed PRIMARY KEY(cod_editora)
);
CREATE TABLE tb_exemplar (
  cod_exemplar INTEGER  NOT NULL IDENTITY,
  status_exemplar CHAR(1) NOT NULL,
  CONSTRAINT co_pk_cod_ex PRIMARY KEY(cod_exemplar)
);

CREATE TABLE tb_obras (
  cod_obras INTEGER  NOT NULL IDENTITY,
  id_tipo_obra INTEGER  NOT NULL,
  id_secao INTEGER  NOT NULL,
  id_editora INTEGER  NOT NULL,
  id_autor INTEGER  NOT NULL,
  id_exemplar INTEGER  NOT NULL,
  titulo VARCHAR(150) NOT NULL,
  ob_status CHAR(1) NULL DEFAULT 'D',
  CONSTRAINT co_pk_cod_obra PRIMARY KEY(cod_obras),
  CONSTRAINT co_fk_cod_tp_obra FOREIGN KEY(id_tipo_obra) REFERENCES tb_tp_obra(cod_tp_obra),
  CONSTRAINT co_fk_cod_sec FOREIGN KEY(id_secao) REFERENCES tb_secao(cod_secao),
  CONSTRAINT co_fk_cod_ed FOREIGN KEY(id_editora) REFERENCES tb_editora(cod_editora),
  CONSTRAINT co_fk_cod_autor FOREIGN KEY(id_autor) REFERENCES tb_autor(cod_autor),
  CONSTRAINT co_fk_cod_exemplar FOREIGN KEY(id_exemplar) REFERENCES tb_exemplar(cod_exemplar),
 );
 
CREATE TABLE tb_tp_user (
  cod_tp_user INTEGER  NOT NULL IDENTITY,
  tpu_descricao VARCHAR(200) NOT NULL,
  CONSTRAINT co_pk_cod_tp_user PRIMARY KEY(cod_tp_user)
);

CREATE TABLE tb_permissao (
  cod_permissao INTEGER  NOT NULL IDENTITY,
  tpu_descricao VARCHAR(200) NOT NULL,
  id_tp_user INTEGER NOT NULL,
  CONSTRAINT co_pk_cod_permissao PRIMARY KEY(cod_permissao),
  CONSTRAINT co_fk_cod_tp_user FOREIGN KEY(id_tp_user) REFERENCES tb_tp_user(cod_tp_user)
);

CREATE TABLE tb_usuario (
  cod_usuario INTEGER NOT NULL IDENTITY,
  user_nome    VARCHAR(120) NOT NULL,
  tel_fixo    CHAR(10),
  tel_celular CHAR(11),
  cidade      VARCHAR(30)DEFAULT 'Fortaleza',
  logradouro  VARCHAR(50) ,
  cep         VARCHAR(8) DEFAULT '6000000',
  uf          CHAR(2),
  status_financeiro CHAR(1),
  id_permissao INTEGER NOT NULL,
  CONSTRAINT co_pk_cod_cli PRIMARY KEY(cod_usuario),
  CONSTRAINT co_fk_cod_per FOREIGN KEY(id_permissao) REFERENCES tb_permissao(cod_permissao)
);

CREATE TABLE tb_emprestimo (
  cod_emp INTEGER  NOT NULL IDENTITY,
  id_user INTEGER  NOT NULL,
  data_emp DATE  DEFAULT Getdate(),
  data_prevista DATE,
  CONSTRAINT co_pk_cod_emp PRIMARY KEY(cod_emp),
  CONSTRAINT co_fk_cod_cli FOREIGN KEY (id_user) REFERENCES tb_usuario(cod_usuario)
  );
  
 CREATE TABLE tb_itens_emprestimo (
  id_exemplar INTEGER NOT NULL,
  id_emp INTEGER NOT NULL,
  CONSTRAINT co_fk_id_emp   FOREIGN KEY (id_emp)  REFERENCES tb_emprestimo(cod_emp),
  CONSTRAINT co_fk_id_exemplar FOREIGN KEY (id_exemplar)REFERENCES tb_exemplar(cod_exemplar)
);
  
CREATE TABLE tb_devolucao (
  cod_dev INTEGER NOT NULL IDENTITY,
  id_emp  INTEGER NOT NULL,
  multa FLOAT DEFAULT 0,
  data_dev DATE NOT NULL DEFAULT GetDate(),
  CONSTRAINT co_pk_cod_dev PRIMARY KEY(cod_dev),
  CONSTRAINT co_fk_cod_emp FOREIGN KEY(id_emp) REFERENCES tb_emprestimo(cod_emp)
);


CREATE TABLE tb_itens_devolucao (
	id_dev   INTEGER  NOT NULL,
	id_exemplar INTEGER  NOT NULL,
	CONSTRAINT co_fk_id_dev   FOREIGN KEY (id_dev)   REFERENCES tb_devolucao(cod_dev),
	CONSTRAINT co_fk_id_exemp FOREIGN KEY (id_exemplar) REFERENCES tb_exemplar(cod_exemplar)
  );



