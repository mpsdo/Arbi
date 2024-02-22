use arbi_api
select 
    m.CNPJ_CPF_PARCEIRO,
    t.codigo_parceiro,
    u.CPF_USUARIO,
    u.TOKEN_USUARIO,
    g.IDGRUPO,
    u.nome,
    u.USUARIO_CADASTRO,
    u.DATA_CADASTRO,
    u.EMAIL,
    conta1.NROCONTA as conta1,
    conta2.NROCONTA as conta2,
    (select 
        m.CNPJ_CPF_PARCEIRO, 
        t.codigo_parceiro,
        u.CPF_USUARIO,
        u.TOKEN_USUARIO,
        g.IDGRUPO,
        u.nome,
        u.USUARIO_CADASTRO,
        u.DATA_CADASTRO,
        u.EMAIL,
        conta1.NROCONTA as conta1,
        conta2.NROCONTA as conta2
     for json path, without_array_wrapper) as informacoes_json
from 
    TI_APIARBIACESSO_USUARIO_PARCEIRO as m with(nolock)
inner join 
    TI_APIARBIACESSO_USUARIO as u with(nolock) on m.CPF_USUARIO = u.CPF_USUARIO
inner join 
    TI_APIARBIACESSO_REL_GRUPO_USUARIO as g with(nolock) on m.CPF_USUARIO = g.CPF_USUARIO
inner join 
    d15w12v.integracao.dbo.ti_filacadastro_parceiro as t with(nolock) on m.CNPJ_CPF_PARCEIRO = t.CNPJ_CPF_parceiro
outer apply 
    (select top(1) NROCONTA 
     from INTEGRACAO.DBO.TI_FILACADASTRO_CONTA 
     where codigo_parceiro = t.codigo_parceiro
     order by nroconta) as conta1
outer apply 
    (select top(1) NROCONTA 
     from INTEGRACAO.DBO.TI_FILACADASTRO_CONTA 
     where codigo_parceiro = t.codigo_parceiro and NROCONTA > ISNULL(conta1.NROCONTA, '0')
     order by nroconta) as conta2
where 
    T.CODIGO_PARCEIRO = '921'
order by 
    g.IDGRUPO;



/*
exec arbi_api.dbo.PCONSULTA_GERAL2 'apsa'

select * from INTEGRACAO..TI_FILACADASTRO_PARCEIRO
where CNPJ_CPF_parceiro = '25255881000112'

select * from TI_APIARBIACESSO_USUARIO where token_usuario = 'ToISoNteRIGleviTChRoloVerKHOrdst'
select * from TI_APIARBIACESSO_USUARIO_PARCEIRO where CNPJ_CPF_PARCEIRO = '49357917000137'
select * from TI_APIARBIACESSO_GRUPO where COD_PARCEIRO = '758'
select * from TI_APIARBIACESSO_REL_GRUPO_USUARIO where CPF_USUARIO = '09786896076'
select * from INTEGRACAO..TI_FILACADASTRO_CONTA where codigo_parceiro = '906'

select * from agenciaw.dbo.conta where nroconta in (
'7140011522',
'7140026520')
*/
