--
 
SELECT coleta.grupo,
coleta.empresa,
empresa.nome as nomeempresa,
coleta.filial,
FNC_FORMATA_CNPJCPFCOD(filial.cnpj) AS cnpj_filial,
filial.apelido AS apelidofilial,
filial.cidade AS cidadefilial,
filial.uf AS uffilial,
coleta.unidade,
unidade.descricao AS descricaounidade,
coleta.diferenciadornumero,
coleta.numero,
coleta.dtemissao::DATE AS dtemissao,
FNC_FORMATA_CNPJCPFCOD(coleta.remetente) AS remetente,
remetente.razaosocial AS nomeremetente,
remetente.cidade AS cidaderemetente,
remetente.uf AS ufrementente,
FNC_FORMATA_CNPJCPFCOD(coleta.destinatario) AS destinatario,
destinatario.razaosocial AS nomedestinatario,
destinatario.cidade AS cidadedestinatario,
destinatario.uf AS ufdestinatario,
grupocapa.nome AS nomegrupocapa,
empresacapa.nome AS nomeempresacapa,
filialcapa.apelido AS nomefilialcapa,
unidadecapa.descricao AS nomeunidadecapa,
remetentecapa.razaosocial AS nomeremetentecapa,
destinatariocapa.razaosocial AS nomedestinatariocapa,
coleta.veiculo,
coleta.carreta1,
coleta.carreta2,
coleta.carreta3,
FNC_FORMATA_CNPJCPFCOD(coleta.motorista) AS motorista,
motorista.identidade,
veiculo.cidadeemplacamento AS cidadeemplacamento_veiculo,
carreta1.cidadeemplacamento AS cidadeemplacamento_carreta1,
carreta2.cidadeemplacamento AS cidadeemplacamento_carreta2,
carreta2.cidadeemplacamento AS cidadeemplacamento_carreta2,
coleta_item.numeropedido AS pedido_remetente,
coleta_item.numeropedidodestinatario AS pedido_destinatario,
coleta_item.produtodescricao,
coleta_item.quantidade,
coleta_item.peso,
coleta.observacao,
programacaocarregamento.numero

FROM coleta

JOIN coleta_item ON coleta_item.grupo = coleta.grupo
AND coleta_item.empresa = coleta.empresa
AND coleta_item.filial = coleta.filial
AND coleta_item.unidade = coleta.unidade
AND coleta_item.diferenciadornumero = coleta.diferenciadornumero
AND coleta_item.serie = coleta.serie
AND coleta_item.numero = coleta.numero
--(grupoprogramacaocarregamento, empresaprogramacaocarregamento, filialprogramacaocarregamento, unidadeprogramacaocarregamento, diferenciadornumeroprogramacaocarregamento, numeroprogramacaocarregamento)
 --     REFERENCES programacaocarregamento (grupo, empresa, filial, unidade, diferenciadornumero, numero)

LEFT JOIN programacaocarregamento ON programacaocarregamento.grupo = coleta.grupoprogramacaocarregamento
AND programacaocarregamento.empresa = coleta.empresaprogramacaocarregamento
AND programacaocarregamento.filial = coleta.filialprogramacaocarregamento
AND programacaocarregamento.unidade = coleta.unidadeprogramacaocarregamento
AND programacaocarregamento.diferenciadornumero = coleta.diferenciadornumeroprogramacaocarregamento
AND programacaocarregamento.numero = coleta.numeroprogramacaocarregamento







LEFT JOIN empresa ON empresa.grupo = coleta.grupo
AND empresa.codigo = coleta.empresa


LEFT JOIN filial ON filial.grupo = {?Grupo}
AND filial.empresa = {?Empresa}
AND filial.codigo = coleta.filial

LEFT JOIN unidade ON unidade.grupo = {?Grupo}
AND unidade.empresa = {?Empresa}
AND unidade.filial = coleta.filial
AND unidade.codigo = coleta.unidade

LEFT JOIN veiculo ON veiculo.placa = coleta.veiculo
LEFT JOIN veiculo carreta1 ON carreta1.placa = coleta.carreta1
LEFT JOIN veiculo carreta2 ON carreta2.placa = coleta.carreta2
LEFT JOIN veiculo carreta3 ON carreta3.placa = coleta.carreta3

LEFT JOIN cadastro motorista ON motorista.codigo = coleta.motorista

LEFT JOIN cadastro remetente ON remetente.codigo = coleta.remetente

LEFT JOIN cadastro destinatario ON destinatario.codigo = coleta.destinatario

JOIN grupo grupocapa ON grupocapa.codigo = {?Grupo}

JOIN empresa empresacapa ON empresacapa.grupo = {?Grupo}
AND empresacapa.codigo = {?Empresa}

LEFT JOIN filial filialcapa ON filialcapa.grupo = {?Grupo}
AND filialcapa.empresa = {?Empresa}
AND filialcapa.codigo = {?Filial}

LEFT JOIN unidade unidadecapa ON unidadecapa.grupo = {?Grupo}
AND unidadecapa.empresa = {?Empresa}
AND unidadecapa.filial = {?Filial}
AND unidadecapa.codigo = {?Unidade}

LEFT JOIN cadastro remetentecapa ON remetentecapa.codigo = coleta.remetente
LEFT JOIN cadastro destinatariocapa ON destinatariocapa.codigo = coleta.destinatario



WHERE coleta.grupo = {?Grupo}
AND coleta.empresa = {?Empresa}
AND coleta.filial = {?Filial}
AND coleta.unidade = {?Unidade}
AND coleta.diferenciadornumero = {?DiferenciadorNumero}
AND coleta.serie = {?Serie}
AND coleta.codigousuario ={?CodigoUsuario}
AND coleta.numero BETWEEN  '{?NumeroInicial}' AND '{?NumeroFinal}'
