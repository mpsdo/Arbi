USE APIBAAS

--GRUPO  - PRD
insert into APIBAAS.. TI_APIARBIACESSO_GRUPO (IDGRUPO ,NOME_GRUPO ,LIMITE_TRANSFERENCIA ,USUARIO_CADASTRO ,DATA_CADASTRO,COD_PARCEIRO )
select (select max(idgrupo)+1 from APIBAAS.. TI_APIARBIACESSO_GRUPO),'USU�RIOS THOMSON REUTERS',0,'MARCOS.PAULO',GETDATE(),'796'
select max(idgrupo) from APIBAAS.. TI_APIARBIACESSO_GRUPO

-- INSERIR NA TABELA USUARIO 

DECLARE @CPF_USUARIO VARCHAR(11)
DECLARE @TOKEN_USUARIO VARCHAR(32)
DECLARE @NOME VARCHAR(32)
DECLARE @USUARIO_CADASTRO VARCHAR(30)
DECLARE @DATA_CADASTRO DATE

SET @CPF_USUARIO = ''
SET @TOKEN_USUARIO = ''
SET @NOME = ''
SET @USUARIO_CADASTRO = 'marcos.oliveira'
SET @DATA_CADASTRO = GETDATE()

INSERT INTO TI_APIARBIACESSO_USUARIO(CPF_USUARIO, TOKEN_USUARIO, NOME, USUARIO_CADASTRO, DATA_CADASTRO)
VALUES (@CPF_USUARIO, @TOKEN_USUARIO, @NOME, @USUARIO_CADASTRO, @DATA_CADASTRO)

-- INSERIR NA TABELA USURIO_PARCEIRO

DECLARE @CPF_USUARIO VARCHAR(11)
DECLARE @CNPJ_CPF_PARCEIRO VARCHAR(14)
DECLARE @USUARIO_CADASTRO VARCHAR(30)
DECLARE @DATA_CADASTRO DATE

SET @CPF_USUARIO = ''
SET @CNPJ_CPF_PARCEIRO = ''
SET @USUARIO_CADASTRO = 'marcos.oliveira'
SET @DATA_CADASTRO = GETDATE()

INSERT INTO TI_APIARBIACESSO_USUARIO_PARCEIRO (CPF_USUARIO, CNPJ_CPF_PARCEIRO, USUARIO_CADASTRO, DATA_CADASTRO)
VALUES (@CPF_USUARIO, @CNPJ_CPF_PARCEIRO, @USUARIO_CADASTRO, @DATA_CADASTRO)



-- INSERIR NA GRUPO USUARIO relacionado:

DECLARE @IDGRUPO INT
DECLARE @CPF_USUARIO VARCHAR(11)

SET @IDGRUPO = 1
SET @CPF_USUARIO = '12345678900'

INSERT INTO TI_APIARBIACESSO_REL_GRUPO_USUARIO (IDGRUPO, CPF_USUARIO)
VALUES (@IDGRUPO, @CPF_USUARIO)

