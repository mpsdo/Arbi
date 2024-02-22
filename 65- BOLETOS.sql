/******* TABELAS QUE VERIFICAM SE O BOLETO FOI PAGO DENTRO OU FORA DO ARBI *******/

-- PAGO SR (SUA REMESSA) 
--VERIFICAR AGREGADOS BLU

SELECT * FROM bureau.dbo.V_TI_BUREAU_PAGADORAGREGADO
WHERE CNPJ_CPF_pagador = '10506341000197'



SELECT * FROM AB_SGC.DBO.BLOQUETE_SR WITH (NOLOCK) WHERE NUMCODBARRAS in (SELECT NUMCODBARRAS FROM AB_DDA.DBO.TITULOS WITH(NOLOCK)
WHERE CNPJ_CPF_SACADOR = '34701685000115')
-- RECEBIDO (NOSSA REMESSA)
SELECT * FROM AB_SGC.DBO.BLOQUETE_NR WITH (NOLOCK) WHERE NUMCODBARRAS
in (SELECT NUMCODBARRAS FROM AB_DDA.DBO.TITULOS WITH(NOLOCK)
WHERE CNPJ_CPF_SACADOR = '34701685000115')

-- RELACIONA NOSSO NUMERO COM CODIGO DE BARRAS 

SELECT * FROM AB_COBRANCA.DBO.BARRAS
WHERE BARRABOLETO = '34199935800002133951570004090080045663069000'

SELECT * FROM AB_COBRANCA.DBO.BARRAS
WHERE NOSSONUMERO = '00013001039'
-- DESCOBRIR DA ONDE FOI PAGO O TITULO
SELECT * FROM AB_COBRANCA.DBO.titulos
WHERE NOSSONUMERO = '00013001039'

select * from agenciaw.dbo.bancos
where codbanco = 0077

select * from agenciaw.dbo.banco_agencias
where codbanco = 0077

select * from ab_infobanc.dbo.municipios
where CODMUNICIPIO_BACEN = '024828'

-- FIM 


select * from TI_WEBHOOK_ENVIO_GERAL_MSG with(nolock)
--where body like '%00013454295%'
where COD_PARCEIRO = 486
and CAST(DATA_CADASTRO AS DATE) = '2023-07-26'
order by DATA_CADASTRO desc

--WEBHOOK DBP2 ENVIO 
SELECT * FROM ARBI_CORP.DBO.TI_WEBHOOK_ENVIO_GERAL_LOG
WHERE BODY LIKE '%00013454295%'
order by DATA_CADASTRO desc

SELECT * FROM ARBI_CORP.DBO.TI_WEBHOOK_ENVIO_GERAL_LOG with(nolock)
where body like '%00013454295%'
--where cod_parceiro = 486 and data_cadastro > '2022-11-22' and tipo_webhook = 3 and status <> 200
order by data_cadastro desc

-- ENVIO FORMATADO: 
USE ARBI_CORP
SELECT * FROM TI_WEBHOOK_ENVIO_GERAL_LOG
WHERE COD_PARCEIRO = 486 /*PARCEIRO*/
AND TIPO_WEBHOOK = 3  /* WEBHOOK BOLETO */ 
and CAST(DATA_CADASTRO AS DATE) = '2023-07-26'
--AND DATA_CADASTRO BETWEEN '2022-10-19' AND '2022-10-21' /*DATA REGISTRO*/
ORDER BY DATA_CADASTRO DESC

---------------------------WEBHOOK PROCESSAMENTO DA INFORMA��O----------------------------------------

SELECT * FROM ARBI_CORP.[DBO].[TI_WEBHOOK_TITULOEMITIDOPAGO_PROCESSAMENTO]
WHERE NOSSONUMERO = '00008449540'

-- PROCESSAMENTO V3
SELECT * FROM ARBI_CORP.[DBO].[TI_WEBHOOK_TITULOEMITIDOPAGO_PROCESSAMENTO_V3]
WHERE NOSSONUMERO = '00008449540'

--PROCESSAMENTO BODY BOLETO 
SELECT top(1)* FROM [DBO].[TI_WEBHOOK_TITULOEMITIDOPAGO_PROCESSAMENTO_BODY]
WHERE BODY LIKE '%00008449540%'

--PROCESSAMENTO BODY BOLETO V3 

SELECT * FROM [DBO].[TI_WEBHOOK_TITULOEMITIDOPAGO_PROCESSAMENTO_BODY_V3]
WHERE BODY LIKE '%00008449540%'

-- VIEW PARA VERIFICAR SITUACAO DO PARCEIRO DDA: 

SELECT COUNT(SITUACAOAGREGADO)
FROM BUREAU.DBO.V_TI_BUREAU_PAGADORAGREGADO 
WHERE CNPJ_CPF_PAGADOR ='34701685000115'
and SITUACAOAGREGADO = 'ativo'

-- TITULOS DDA

/*VERIFICAR SE O CNPJ PAGADOR AGREGADO EST� ATIVO */

SELECT * FROM bureau.dbo.V_TI_BUREAU_PAGADORAGREGADO
WHERE CNPJ_CPF_AGREGADO = '41743791000127'

/* VERIFICAR SE O TITULO DDA EXISTE */

SELECT NUMCODBARRAS FROM AB_DDA.DBO.TITULOS WITH(NOLOCK)
WHERE CNPJ_CPF_SACADOR = '34701685000115'
order by DATAEMISSAO desc

SELECT * FROM AB_DDA.DBO.TITULOS_PASS WITH(NOLOCK)
WHERE NUMIDENTCDDA = '2022102507677639115'

-- WEBHOOK DDDA
SELECT * FROM ARBI_CORP.[DBO].[TI_WEBHOOK_TITULOSDDA_PARCEIRO]
SELECT * FROM ARBI_CORP.[DBO].[TI_WEBHOOK_TITULOSDDA_PROCESSAMENTO]
n;/SELECT * FROM ARBI_CORP.[DBO].[TI_WEBHOOK_TITULOSDDA_PROCESSAMENTO_BODY] with(nolock) WHERE BODY LIKE '%34199935800002133951570004090080045663069000%'

-- PARAMETRIZA��O PARCEIRO
SELECT * FROM arbi_corp.dbo.[TI_WEBHOOK_ENVIO_GERAL_PARAMETRIZACAO_PARCEIRO]
where codparceiro = 486 
WHERE URL = 'HTTPS://FATORI.K8BANK.COM.BR/PAGAMENTOSWEBHOOK/API/PIX/WEBHOOKNOTIFICACAORECEBIMENTOPIXARBI'


/* VIEW PARA VISUALIZAR PAGADOR DDA */ 

SELECT * FROM BUREAU.DBO.V_TI_BUREAU_PAGADORAGREGADO WHERE CNPJ_CPF_AGREGADO ='07416055000207'

SELECT top(100)* FROM BUREAU.DBO.V_TI_BUREAU_PAGADORAGREGADO_TITULOS 
where NUMCODBARRAS = '34199935800002133951570004090080045663069000'
WHERE CNPJ_CPF_SACADO  ='33206532000139'
order by DATAEMISSAO desc


