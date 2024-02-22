--CONSULTA PARCEIRO
SELECT * FROM INTEGRACAO ..TI_FILACADASTRO_PARCEIRO
where CNPJ_CPF_parceiro = '04104898000107' 
--cnpj parceiro : 04104898000107

--CONSULTA TED COM CODIGO DO PARCEIRO 208 
select * from APIBAAS..[TI_APIARBICONTACORRENTE_REQUISICAO]
where CODIGO_PARCEIRO = 364/*Alterar codigo do parceiro */ and IDMODULO = 1 and IDTRANSACAO = 2 AND VALOR = 9912.70 --and NOMECLICRED = 'PRACA DOS AMORES MORUMBI LTDA'
order by DATACADASTRO /*Ordenando por data Cadastro*/ desc


 -- Status do retorno de TED producao 
select * from APIBAAS..[TI_APIARBICONTACORRENTE_RETORNO_HISTORICO]
where IDMODULO = 1 and IDTRANSACAO = 2  and IDREQUISICAO_ARBI in ('6520223641527409@7087364755663','862022364195465@1011721497797','10620223641535996@0296288753950')
order by DATA_CADASTRO desc

--Select de TRANSACOES:
select * from APIBAAS..TI_APIARBIACESSO_TRANSACOES


 -- SCRIPT PARA BUSCA NA TABELA DE TED COM CLIENTE SELECIONADO, NA DATA DE SETEMBRO , OPERACOES QUE NAO DERAM SUCESSO
select m.INSCRICAOPARCEIRO, m.TOKEN_USUARIO,m.IDREQUISICAO_PARCEIRO,m.IDREQUISICAO_ARBI,m.IDMODULO,m.IDTRANSACAO,m.BANCOORIGEM,m.AGENCIAORIGEM,m.CONTAORIGEM,m.TIPOCONTADEBITADA,m.BANCODESTINO,m.BANCODESTINO,m.BANCODESTINO,m.AGENCIADESTINO,m.CONTADESTINO,
p.DESCRICAOSTATUS,p.IDSTATUS,p.RESULTADO,m.DATACADASTRO,m.NOMECLICRED from
APIBAAS..TI_APIARBICONTACORRENTE_REQUISICAO m with(nolock),
APIBAAS..TI_APIARBICONTACORRENTE_RETORNO_HISTORICO p with(nolock)
where m.CODIGO_PARCEIRO = 364 and DATA_CADASTRO like '%2022-06-08%'  and m.IDMODULO = 1 and m.IDTRANSACAO = 2 and m.DATAAGENDAMENTO like '%2022-06%' --and p.DESCRICAOSTATUS <> 'Sucesso' 
order by m.DATACADASTRO

select * from dbp2.agenciaw.dbo.


select * from TI_APIARBICONTACORRENTE_REQUISICAO
where CONTAORIGEM = '0550018627'
--and cast (DATACADASTRO as date) = '2021-11-17'  
and VALOR = 59.85-- and valor < 8.10
order by DATACADASTRO desc

select * from APIBAAS..TI_APIARBICONTACORRENTE_RETORNO_HISTORICO
where IDREQUISICAO_ARBI = '17820233641940869@5180723504425'

select* from apibaas..ti_APIARBICONTACORRENTE_LIQUIDACAO
where IDREQUISICAO_ARBI = '17820233641940869@5180723504425'

select * from dbp2.agenciaw.dbo.movto with(nolock)
where nroconta = '0550018627'
and valor = 59.85
order by dataatu desc

select * from TI_APIARBICONTACORRENTE_REQUISICAO where IDREQUISICAO_ARBI ='862022364195465@1011721497797'
SELECT * FROM TI_APIARBICONTACORRENTE_RETORNO_HISTORICO  WHERE RESULTADO ='STR20211116004891611'
select * from TI_APIARBICONTACORRENTE_LIQUIDACAO  where IDREQUISICAO_ARBI ='862022364195465@1011721497797'
SELECT CODDOMINIO,DESCRICAO FROM BUREAU..TI_BUREAU_DOMINIOS_SPB WITH(NOLOCK)  WHERE TAG ='CodDevTransf' order by 1

select * from TI_APIARBICONTACORRENTE_REQUISICAO where IDREQUISICAO_ARBI ='862022364195465@1011721497797'
SELECT * FROM TI_APIARBICONTACORRENTE_RETORNO_HISTORICO  WHERE RESULTADO ='STR20211026004735913'
select * from TI_APIARBICONTACORRENTE_LIQUIDACAO  where IDREQUISICAO_ARBI ='862022364195465@1011721497797'
SELECT CODDOMINIO,DESCRICAO FROM BUREAU..TI_BUREAU_DOMINIOS_SPB WITH(NOLOCK)  WHERE TAG ='CodDevTransf' order by 1
select * from APIBAAS..TI_APIARBICONTACORRENTE_LIQUIDACAO_STATUS
exec dbp2.arbi_api.dbo.PCONSULTA_GERAL '0000383241'


select * from dbp2.agenciaw.dbo.movto
where valor = 9912.70 and cast(datamovto as date) = '2022-06-08' --and nroconta = '0550020974'
order by DATAMOVTO desc
select JSON_VALUE(body_conteudo, '$.conta.conta') AS json, *
from D15W12V.INTEGRACAO.[dbo].TI_WEBHOOK_LOG_ENVIO
where data_cadastro > '2022-07-21'
and JSON_VALUE(body_conteudo, '$.conta.conta') like '%531234891'

select * from agenciaw.dbo.TRANSACOES_SPB with (nolock) 

