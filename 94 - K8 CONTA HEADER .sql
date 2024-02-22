-- VERIFICAR CONTA HEADER K8 :

DECLARE @CONTA VARCHAR(10)
DECLARE @CODPARCEIRO VARCHAR(3)
SET @CONTA = '0570002890'
SET @CODPARCEIRO = (select codigo_parceiro from integracao..ti_filacadastro_conta where convert(bigint,nroconta) = @conta)
-- RELACIONA CTAHEADER
select codproduto,NUMCONTAMOVTO,CTAHEADER,CODCLIENTE,NUMOPERACAO from ab_cobranca.dbo.operacoes
where codcliente in (
select CODCLIENTE from agenciaw.dbo.titulares
where convert(bigint,nroconta) = @CONTA
)
-- CODIGO DO CLIENTE:

select CODCLIENTE from agenciaw.dbo.titulares
where convert(bigint,nroconta) = @CONTA


-- QUAL PARCEIRO ESTÁ ATRIBUIDO 
select * from integracao..ti_filacadastro_conta where convert(bigint,nroconta) = @conta
-- QUAL WEBHOOK ESTA ATRELADO
select * from arbi_corp.[dbo].[TI_WEBHOOK_ENVIO_GERAL_PARAMETRIZACAO_PARCEIRO] where codparceiro = @codparceiro
-- QUAIS PERMISSOES A CONTA TEM 
select * from arbi_api..TI_APIARBIACESSO_PERMISSOES
where convert(bigint,conta) = @CONTA
-- STATUS DA CONTA 
select * from agenciaw.dbo.conta
where convert(bigint,nroconta) = @CONTA
--NOME PARCEIRO
select * from integracao..ti_filacadastro_parceiro
where codigo_parceiro = @CODPARCEIRO

/*
541415686 -- duas 
541415694
541415708
541415716
541415724
541415740
541415767
541415775
541425649
570001630
570001649


-- pegar todas as contas por codparceiro
DECLARE @CONTAS TABLE (
    NROCONTA BIGINT
)

INSERT INTO @CONTAS
select * from integracao..ti_filacadastro_parceiro
where codigo_parceiro = 773

select t.CODCLIENTE, o.CTAHEADER, t.nroconta from agenciaw.dbo.titulares as t
inner join ab_cobranca.dbo.operacoes as o
on t.CODCLIENTE = o.codcliente
where t.nroconta in (select NROCONTA from @CONTAS)

*/