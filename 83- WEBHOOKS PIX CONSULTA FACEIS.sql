use arbi_corp

exec arbi_api..PCONSULTA_GERAL '255'

select * from bureau..V_TI_BUREAU_PIX_ORDEMANOTACAO_EXTRACAO with(nolock)
where PARCEIRO like '%volus%'
order by DATA_HORA_FIM desc

	DECLARE @date DATE = GETDATE();

	-- tecban
	SELECT *
	FROM arbi_api..TI_APIARBIPIX_NOTIFICACAO_REQUISICAO AS a WITH (NOLOCK)
	JOIN arbi_api..TI_APIARBIPIX_NOTIFICACAO_RETORNO AS b WITH (NOLOCK) ON a.IDREQUISICAO_ARBI = b.IDREQUISICAO_ARBI
	WHERE a.CODPARCEIRO = 774
	  AND CAST(a.data_cadastro AS DATE) = @date
	--AND b.idstatus = 200
	ORDER BY a.DATA_CADASTRO DESC;

-- tecban
SELECT *
FROM arbi_api..TI_APIARBIPIX_NOTIFICACAO_REQUISICAO AS a WITH (NOLOCK)
JOIN arbi_api..TI_APIARBIPIX_NOTIFICACAO_RETORNO AS b WITH (NOLOCK) ON a.IDREQUISICAO_ARBI = b.IDREQUISICAO_ARBI
WHERE a.body like '%E18236120202309221216s1022c5b5e9%'
--  AND CAST(a.data_cadastro AS DATE) = @date
--AND b.idstatus = 200
ORDER BY a.DATA_CADASTRO DESC


select * from ARBI_CORP.dbo.TI_WEBHOOK_ENVIO_GERAL_PARAMETRIZACAO_PARCEIRO
where CODPARCEIRO = 255

select * from ARBI_CORP.dbo.TI_WEBHOOK_ENVIO_GERAL_PARAMETRIZACAO_PARCEIRO
where url = ''

select * from INTEGRACAO..TI_FILACADASTRO_CONTA where codigo_parceiro = 255
where convert(bigint,NROCONTA) = '3200636'

select * from agenciaw.dbo.conta
where convert(bigint,nroconta) = '0003729300'

select * from INTEGRACAO..TI_FILACADASTRO_PARCEIRO
where CNPJ_CPF_parceiro = ''

exec dbp2.arbi_api.dbo.pconsulta_geral '29255308000160'

-- convferir qual é o webhook que

exec arbi_api.dbo.pconsulta_geral 'tecban'


se