CREATE DATABASE DB_BIBLIOTECA

USE DB_BIBLIOTECA 

CREATE TABLE tb_secao (
  cod_secao INTEGER  NOT NULL IDENTITY,
  se_nome VARCHAR(30) NULL,
  CONSTRAINT co_pk_cod_sec PRIMARY KEY(cod_secao)
);

CREATE TABLE tb_tipo_de_obras (
  cod_tipo_obra INTEGER  NOT NULL IDENTITY,
  tp_ob_nome VARCHAR(30) NOT NULL,
  CONSTRAINT co_pk_cod_tipo_obra PRIMARY KEY(cod_tipo_obra)
);

CREATE TABLE tb_autor (
  cod_autor INTEGER NOT NULL IDENTITY,
  au_nome   VARCHAR(100) NOT NULL,
  CONSTRAINT co_pk_cod_autor PRIMARY KEY(cod_autor)
);

CREATE TABLE tb_usuario (
  cod_usuario INTEGER NOT NULL IDENTITY,
  cli_nome    VARCHAR(120) NOT NULL,
  tel_fixo    CHAR(10),
  tel_celular CHAR(11),
  cidade      VARCHAR(30)DEFAULT 'Fortaleza',
  logradouro  VARCHAR(50) ,
  cep         VARCHAR(8) DEFAULT '6000000',
  UF          CHAR(2),
  CONSTRAINT co_pk_cod_cli PRIMARY KEY(cod_cliente)
);

CREATE TABLE tb_devolucao (
  cod_dev INTEGER NOT NULL IDENTITY,
  id_emp  INTEGER NOT NULL,
  status_dev CHAR(1) NOT NULL DEFAULT 'P',
  multa FLOAT DEFAULT 0,
  data_dev DATE NOT NULL DEFAULT GetDate(),
  CONSTRAINT co_pk_cod_dev PRIMARY KEY(cod_dev),
  CONSTRAINT co_fk_cod_emp FOREIGN KEY(id_emp) REFERENCES tb_emprestimo(cod_emp)
);

CREATE TABLE tb_editora (
  cod_editora INTEGER  NOT NULL IDENTITY,
  ed_nome VARCHAR(100) NOT NULL,
  CONSTRAINT co_pk_cod_ed PRIMARY KEY(cod_editora)
);






CREATE TABLE tb_emprestimo (
  cod_emp INTEGER  NOT NULL IDENTITY,
  id_cliente INTEGER  NOT NULL,
  data_emp DATE  DEFAULT Getdate(),
  data_prevista DATE DEFAULT Getdate()+7,
  CONSTRAINT co_pk_cod_emp PRIMARY KEY(cod_emp),
  CONSTRAINT co_fk_cod_cli FOREIGN KEY (id_cliente) REFERENCES tb_cliente(cod_cliente)
  );

CREATE TABLE tb_itens_devolucao (
	id_dev   INTEGER  NOT NULL,
	id_obras INTEGER  NOT NULL,
	CONSTRAINT co_fk_id_dev   FOREIGN KEY (id_dev)   REFERENCES tb_devolucao(cod_dev),
	CONSTRAINT co_fk_id_obras FOREIGN KEY (id_obras) REFERENCES tb_obras(cod_obras)
  );

CREATE TABLE tb_itens_emprestimo (
  id_obras INTEGER NOT NULL,
  id_emp INTEGER NOT NULL,
  CONSTRAINT co_fk_id_emp   FOREIGN KEY (id_emp)  REFERENCES tb_emprestimo(cod_emp),
  CONSTRAINT co_fk_id_obras FOREIGN KEY (id_obras)REFERENCES tb_obras(cod_obras)
);

CREATE TABLE tb_obras (
  cod_obras INTEGER  NOT NULL IDENTITY,
  id_tipo_obra INTEGER  NOT NULL,
  id_secao INTEGER  NOT NULL,
  id_editora INTEGER  NOT NULL,
  id_autor INTEGER  NOT NULL,
  titulo VARCHAR(150) NOT NULL,
  ob_status CHAR(1) NULL DEFAULT 'D',
  edicao VARCHAR(8) NULL DEFAULT '1ª Edição',
  CONSTRAINT co_pk_cod_obra PRIMARY KEY(cod_obras),
 );
