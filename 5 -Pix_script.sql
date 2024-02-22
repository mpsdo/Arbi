SELECT * FROM INTEGRACAO..TI_FILACADASTRO_PARCEIRO
WHERE CODIGO_PARCEIRO = '278'

SELECT * FROM INTEGRACAO..TI_FILACADASTRO_PARCEIRO
WHERE CNPJ_CPF_PARCEIRO = '20192223000105'

SELECT * FROM DBP2.ARBI_API.DBO.TI_APIARBIPIX_POST_REQUISICAO WITH(NOLOCK)
WHERE BODY LIKE '%E54403563202301251216YWKXDCBMR1X%' AND CAST (DATA_CADASTRO AS DATE) = '2023-01-25'

SELECT * FROM arbi_api..TI_APIARBIPIX_POST_REQUISICAO
WHERE IDREQUISICAO_ARBI = 'E18236120202312121200s053bed67cb '

SELECT * FROM APIBAAS..TI_APIARBIPIX_POST_RETORNO_HISTORICO
WHERE RESULTADO LIKE '%DBB4D1EA-88A0-41FB-33D2-08DA91B9E7DC%'

---------------VALIDA��O GI AUTBANK PIX ------------------------------------------------------
SELECT * FROM AB_PAGAMENTO_INSTANTANEO.DBO.ANOTACAO_CREDITO WITH(NOLOCK)-- CREDITO
WHERE END_TO_END = 'E54403563202310311027ov4uwnNj48k'

SELECT * FROM AB_PAGAMENTO_INSTANTANEO.DBO.ORDEM_PAGAMENTO WITH(NOLOCK) -- PAGAMENTO DEBITO
WHERE END_TO_END = 'E54403563202310311027ov4uwnNj48k'

SELECT * FROM AB_PAGAMENTO_INSTANTANEO.DBO.BLOQUEIO_ORDEM_PAGAMENTO WITH(NOLOCK) -- DEBITO 
WHERE END_TO_END = 'E54403563202310311027ov4uwnNj48k'

SELECT * FROM AB_PAGAMENTO_INSTANTANEO.DBO.[ERROS_ORDEM_PAGAMENTO] WITH(NOLOCK)
WHERE ID_ORDEM_PAGAMENTO = '4029354'

SELECT * FROM AB_PAGAMENTO_INSTANTANEO.DBO.[STATUS_ORDEM_PAGAMENTO] WITH(NOLOCK)
WHERE ID_ORDEM_PAGAMENTO = '4029354'

----------------------VERIFICAR MOVIMENTO DE CONTA -------------------
SELECT * FROM AGENCIAW.[DBO].[MOVTO]
WHERE NROCONTA = '0003734371' AND cast(datamovto as date) = '2023-10-31' and valor = 67.50
ORDER BY DATAATU DESC

SELECT * FROM DBP2.AGENCIAW.[DBO].[MOVTO]
WHERE CAST (DATAMOVTO AS DATE) = '2022-09-12' /*AND NROCONTA = '0000813758' */AND VALOR = '49.59'
ORDER BY DATAMOVTO DESC

/* VERIFICAR CONTA NO LEGADO */
SELECT * FROM DBP2.AGENCIAW.DBO.CONTA
WHERE CONVERT(BIGINT,NROCONTA) = '0000385694'

---------------------WEBHOOK PIX VERIFICAR LOG POR END

-- REQUISICAO
SELECT * FROM DBP2.[ARBI_API].[DBO].[TI_APIARBIPIX_NOTIFICACAO_REQUISICAO] WITH(NOLOCK)
WHERE CODPARCEIRO = 574 AND CAST(DATA_CADASTRO AS DATE) = '2022-11-04'
ORDER BY DATA_CADASTRO DESC

-- RETORNO
SELECT * FROM DBP2.[ARBI_API].[DBO].[TI_APIARBIPIX_NOTIFICACAO_RETORNO] WITH(NOLOCK)
WHERE CAST(DATA_CADASTRO AS DATE) = '2022-01-03' 
ORDER BY DATA_CADASTRO DESC
WHERE BODY LIKE '%D22896431202210201838UA39B74AFE2%'


-- JOIN WEBHOOK

SELECT * FROM DBP2.[ARBI_API].[DBO].[TI_APIARBIPIX_NOTIFICACAO_REQUISICAO]  AS A WITH(NOLOCK),
DBP2.[ARBI_API].[DBO].[TI_APIARBIPIX_NOTIFICACAO_RETORNO] AS B WITH(NOLOCK)
WHERE 
A.IDREQUISICAO_ARBI = B.IDREQUISICAO_ARBI
AND A.CODPARCEIRO = 574 AND CAST(A.DATA_CADASTRO AS DATE) = '2022-11-04'
ORDER BY A.DATA_CADASTRO DESC

/*CONSULTA DADOS*/
EXEC DBP2.ARBI_API.DBO.PCONSULTA_GERAL '0000385694'

/*VIEW QUE CONSULTA DADOS PIX EXTRATO*/

SELECT * FROM DBP2.BUREAU.DBO.V_TI_BUREAU_PIX_ORDEMANOTACAO_EXTRACAO
WHERE CAST(DATA_HORA_FIM AS DATE) = '2022-09-19' --BETWEEN '2022-09-20' AND '2022-09-21'
AND PARCEIRO = 'PRIMEPAG'
ORDER BY DATA_HORA_INICIO DESC


SELECT * FROM DBP2.BUREAU.DBO.V_TI_BUREAU_PIX_ORDEMANOTACAO_EXTRACAO
WHERE DESTINO_CONTA_NRO = '0000383098' OR ORIGEM_CONTA_NRO = '0000383098' AND DATA_HORA_FIM BETWEEN '2021-04-09' AND '2022-09-27'
ORDER BY DATA_HORA_INICIO

/*WEBHOOK ENVIO GERAL*/

SELECT * FROM DBP2.ARBI_CORP.DBO.TI_WEBHOOK_ENVIO_GERAL_LOG WITH(NOLOCK) WHERE BODY LIKE '%E60746948202210270900P1636003439%'


-- EXTRATO PIX PROC
USE ARBI_CORP
EXEC DBP2.P_SEL_EXTRATO_PIX_EFETIVADO '0000313146','2023-01-06'

-- BLOQUEIO DE SALDO PIX 
SELECT * FROM  VALORESBLOQ_BLOQ_INTRADIA WITH(NOLOCK)
WHERE NROCONTA = '0000313086' AND DATABLOQUEIO > '2023-01-23'
-- DESBLOQUEIO
SELECT * FROM  VALORESBLOQ_DESBLOQ_INTRADIA WITH(NOLOCK)
WHERE NROCONTA = '0000313086' AND DATABLOQUEIO > '2023-01-23'

-- VERIFICAR O ENDTOEND PELO NUMERO_MOVIMENTO

--USE  AB_PAGAMENTO_INSTANTANEO
--GO

DECLARE @DTREF AS DATETIME = '20230205'
DECLARE @DTREFD1 AS DATETIME =	'20230206'

SELECT * FROM DBP2.AB_PAGAMENTO_INSTANTANEO.DBO.STATUS_BLOQUEIO_ORDEM_PAGAMENTO WITH (NOLOCK)
WHERE DATA_HORA_REGISTRO >= @DTREF
AND DATA_HORA_REGISTRO < @DTREFD1	
AND NRO_MOVIMENTO = '915983379'



DECLARE @DTREF AS DATETIME = '20230417'
DECLARE @DTREFD1 AS DATETIME =	'20230419'

SELECT * FROM DBP2.AB_PAGAMENTO_INSTANTANEO.[dbo].[STATUS_ANOTACAO_CREDITO] WITH (NOLOCK)
WHERE DATA_HORA_REGISTRO >= @DTREF
AND DATA_HORA_REGISTRO < @DTREFD1	
AND NRO_MOVIMENTO = '918122322'

/*EXTRATO PIX COM REF INTERNA*/

SELECT a.*, ISNULL(b.REFERENCIA_INTERNA, '') AS REFERENCIA_INTERNA 
FROM bureau..V_TI_BUREAU_PIX_ORDEMANOTACAO_EXTRACAO AS a WITH (NOLOCK)
LEFT JOIN AB_PAGAMENTO_INSTANTANEO.DBO.ANOTACAO_CREDITO AS b WITH (NOLOCK)
ON a.END_TO_END = b.END_TO_END
WHERE a.PARCEIRO LIKE '%ALPE%'
AND CAST(a.DATA_HORA_FIM AS DATE) = '2023-05-04'
ORDER BY a.DATA_HORA_FIM DESC


--SELECT 
--CPFCNPJ,
--VLR_MAX_TRANSACAO,
--HORARIO_INICIAL,
--HORARIO_FINAL,
--DIA_UTIL,
--DIA_NAO_UTIL,
--VLR_MAX_CLIENTE_DIA
--FROM AB_PAGAMENTO_INSTANTANEO.DBO.PARAMETROS_PAGAMENTO_HORARIO_CLIENTE
--where CPFCNPJ = '39693526000130' 
--and VLR_MAX_TRANSACAO = 15000.00
--and horario_incial = '20:00:00.0000000'
--and horario_final = '23:59:59.0000000'
--and dia_util = 1 and dia_nao_util = 0
--and VLR_MAX_CLIENTE_DIA = 15000.00

--INSERT INTO dbp.AB_PAGAMENTO_INSTANTANEO.DBO.PARAMETROS_PAGAMENTO_HORARIO_CLIENTE 
--(CPFCNPJ, VLR_MAX_TRANSACAO, HORARIO_INICIAL, HORARIO_FINAL, DIA_UTIL, DIA_NAO_UTIL, VLR_MAX_CLIENTE_DIA) 
--VALUES 
--('14671177000124', 15000.00, '20:00:00.0000000', '23:59:59.0000000', 1, 0, 15000.00)

--INSERT INTO dbp.AB_PAGAMENTO_INSTANTANEO.DBO.PARAMETROS_PAGAMENTO_HORARIO_CLIENTE 
--(CPFCNPJ, VLR_MAX_TRANSACAO, HORARIO_INICIAL, HORARIO_FINAL, DIA_UTIL, DIA_NAO_UTIL, VLR_MAX_CLIENTE_DIA) 
--VALUES 
--('14671177000124', 15000.00, '00:00:00.0000000', '06:30:00.0000000', 1, 0, 15000.00)

select * from AB_PAGAMENTO_INSTANTANEO.DBO.PARAMETROS_PAGAMENTO_HORARIO_CLIENTE 
where CPFCNPJ = '14671177000124'

select * from AB_PAGAMENTO_INSTANTANEO.DBO.PARAMETROS_PAGAMENTO_CLIENTE 

--INSERT INTO AB_PAGAMENTO_INSTANTANEO.DBO.PARAMETROS_PAGAMENTO_CLIENTE 
--(CPFCNPJ, VLR_MAX_TRANSACAO, VLR_MAX_CLIENTE_DIA) 
--VALUES 
--('39693526000130', 15000.00, 250000.00)

exec arbi_api.dbo.PCONSULTA_GERAL 'paytrack'

select * from agenciaw.dbo.conta
where cgc_cpf_tit1 = '14073438000104'

select * from permissoes
where conta = '3729564'