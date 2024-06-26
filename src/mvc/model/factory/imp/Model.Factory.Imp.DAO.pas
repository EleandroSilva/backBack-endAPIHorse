{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 13/03/2024 10:43           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Factory.Imp.DAO;

interface

uses
  Model.Factory.DAO.Interfaces,
  Model.DAO.Usuario.Interfaces,
  Model.DAO.Empresa.Interfaces,
  Model.DAO.Categoria.Produto.Interfaces,
  Model.DAO.Marca.Produto.Interfaces,
  Model.DAO.Unidade.Produto.Interfaces,
  Model.DAO.Endereco.Interfaces,
  Model.DAO.Numero.Interfaces,
  Model.DAO.Produto.Interfaces,
  Model.DAO.Endereco.Empresa.Interfaces,
  Model.DAO.Email.Empresa.Interfaces,
  Model.DAO.Pessoa.Interfaces,
  Model.DAO.Endereco.Pessoa.Interfaces,
  Model.DAO.Email.Pessoa.Interfaces,
  Model.DAO.Telefone.Empresa.Interfaces,
  Model.DAO.Telefone.Pessoa.Interfaces,
  Model.DAO.Municipio.Interfaces,
  Model.DAO.Estado.Interfaces,
  Model.DAO.Regiao.Estado.Interfaces,
  Model.DAO.Natureza.Juridica.Interfaces,
  Model.DAO.Caixa.Interfaces,
  Model.DAO.Movimento.Caixa.Interfaces,
  Model.DAO.Fechar.Caixa.Interfaces,
  Model.DAO.Condicao.Pagamento.Interfaces,
  Model.DAO.Condicao.Pagamento.Item.Interfaces,
  Model.DAO.Movimento.Pedido.Interfaces,
  Model.DAO.Pedido.Interfaces,
  Model.DAO.Pedido.Item.Interfaces,
  Model.DAO.Pedido.Pagamento.Interfaces,
  Model.DAO.Caixa.Pedido.Interfaces;
type
  TFactoryDAO = class(TInterfacedObject, iFactoryDAO)
    private
      FDAOUsuario           : iDAOUsuario;
      FDAOEmpresa           : iDAOEmpresa;
      FDAOEnderecoEmpresa   : iDAOEnderecoEmpresa;
      FDAOEmailEmpresa      : iDAOEmailEmpresa;
      FDAOTelefoneEmpresa   : iDAOTelefoneEmpresa;
      FDAOPessoa            : iDAOPessoa;
      FDAOEnderecoPessoa    : iDAOEnderecoPessoa;
      FDAOEmailPessoa       : iDAOEmailPessoa;
      FDAOTelefonePessoa    : iDAOTelefonePessoa;
      FDAOCategoriaProduto  : iDAOCategoriaProduto;
      FDAOMarcaProduto      : iDAOMarcaProduto;
      FDAOUnidadeProduto    : iDAOUnidadeProduto;
      FDAOProduto           : iDAOProduto;
      FDAOEndereco          : iDAOEndereco;
      FDAONumero            : iDAONumero;
      FDAOMunicipio         : iDAOMunicipio;
      FDAOEstado            : iDAOEstado;
      FDAORegiaoEstado      : iDAORegiaoEstado;
      FDAONaturezaJuridica  : iDAONaturezaJuridica;
      FDAOCaixaDiario       : iDAOCaixa;
      FDAOMovimentoCaixa    : iDAOMovimentoCaixa;
      FDAOFecharCaixa       : iDAOFecharCaixa;
      FDAOCondicaoPagamento : iDAOCondicaoPagamento;
      FDAOCondicaoPagamentoItem : iDAOCondicaoPagamentoItem;
      FDAOPedido            : iDAOPedido;
      FDAOPedidoItem        : iDAOPedidoItem;
      FDAOPedidoPagamento   : iDAOPedidoPagamento;
      FDAOMovimentoPedido   : iDAOMovimentoPedido;
      FDAOCaixaPedido       : iDAOCaixaPedido;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iFactoryDAO;

      function DAOUsuario           : iDAOUsuario;
      function DAOEmpresa           : iDAOEmpresa;
      function DAOEnderecoEmpresa   : iDAOEnderecoEmpresa;
      function DAOEmailEmpresa      : iDAOEmailEmpresa;
      function DAOTeleFoneEmpresa   : iDAOTelefoneEmpresa;
      function DAOPessoa            : iDAOPessoa;
      function DAOEnderecoPessoa    : iDAOEnderecoPessoa;
      function DAOEmailPessoa       : iDAOEmailPessoa;
      function DAOTelefonePessoa    : iDAOTelefonePessoa;
      function DAOCategoriaProduto  : iDAOCategoriaProduto;
      function DAOMarcaProduto      : iDAOMarcaProduto;
      function DAOUnidadeProduto    : iDAOUnidadeProduto;
      function DAOProduto           : iDAOProduto;
      function DAOEndereco          : iDAOEndereco;
      function DAONumero            : iDAONumero;
      function DAOMunicipio         : iDAOMunicipio;
      function DAOEstado            : iDAOEstado;
      function DAORegiaoEstado      : iDAORegiaoEstado;
      function DAONaturezaJuridica  : iDAONaturezaJuridica;
      function DAOCaixa             : iDAOCaixa;
      function DAOMovimentoCaixa    : iDAOMovimentoCaixa;
      function DAOFecharCaixa       : iDAOFecharCaixa;
      function DAOPedido            : iDAOPedido;
      function DAOPedidoItem        : iDAOPedidoItem;
      function DAOPedidoPagamento   : iDAOPedidoPagamento;
      function DAOMovimentoPedido   : iDAOMovimentoPedido;
      function DAOCaixaPedido       : iDAOCaixaPedido;
      function DAOCondicaoPagamento     : iDAOCondicaoPagamento;
      function DAOCondicaoPagamentoItem : iDAOCondicaoPagamentoItem;
  end;

implementation

uses
  Uteis,
  Model.DAO.Imp.Usuario,
  Model.DAO.Imp.Empresa,
  Model.DAO.Imp.Categoria.Produto,
  Model.DAO.Imp.Marca.Produto,
  Model.DAO.Imp.Unidade.Produto,
  Model.DAO.Imp.Endereco,
  Model.DAO.Imp.Numero,
  Model.DAO.Imp.Produto,
  Model.DAO.Imp.Email.Empresa,
  Model.DAO.Imp.Endereco.Empresa,
  Model.DAO.Imp.Pessoa,
  Model.DAO.Imp.Endereco.Pessoa,
  Model.DAO.Imp.Email.Pessoa,
  Model.DAO.Imp.Telefone.Empresa,
  Model.DAO.Imp.Municipio,
  Model.DAO.Imp.Estado,
  Model.DAO.Imp.Regiao.Estado,
  Model.DAO.Imp.Natureza.Juridica,
  Model.DAO.Imp.Caixa,
  Model.DAO.Imp.Movimento.Caixa,
  Model.DAO.Imp.Fechar.Caixa,
  Model.DAO.Imp.Telefone.Pessoa,
  Model.DAO.Imp.Condicao.Pagamento,
  Model.DAO.Imp.Condicao.Pagamento.Item,
  Model.DAO.Imp.Pedido,
  Model.DAO.Imp.Pedido.Item,
  Model.DAO.Imp.Pedido.Pagamento,
  Model.DAO.Imp.Movimento.Pedido,
  Model.DAO.Imp.Caixa.Pedido;

{ TFactoryDAO }

constructor TFactoryDAO.Create;
begin
  //
end;

destructor TFactoryDAO.Destroy;
begin
  //
  inherited;
end;

class function TFactoryDAO.New: iFactoryDAO;
begin
  Result := Self.Create;
end;

function TFactoryDAO.DAOUsuario: iDAOUsuario;
begin
  if not Assigned(FDAOUsuario) then
    FDAOUsuario := TDAOUsuario.New;

  Result := FDAOUsuario;
end;

function TFactoryDAO.DAOEmpresa: iDAOEmpresa;
begin
  if not Assigned(FDAOEmpresa) then
    FDAOEmpresa := TDAOEmpresa.New;

  Result := FDAOEmpresa;
end;

function TFactoryDAO.DAOEnderecoEmpresa: iDAOEnderecoEmpresa;
begin
  if not Assigned(FDAOEnderecoEmpresa) then
    FDAOEnderecoEmpresa := TDAOEnderecoEmpresa.New;

  Result := FDAOEnderecoEmpresa;
end;

function TFactoryDAO.DAOEmailEmpresa: iDAOEmailEmpresa;
begin
  if not Assigned(FDAOEmailEmpresa) then
    FDAOEmailEmpresa := TDAOEmailEmpresa.New;

  Result := FDAOEmailEmpresa;
end;

function TFactoryDAO.DAOTelefoneEmpresa: iDAOTelefoneEmpresa;
begin
  if not Assigned(FDAOTelefoneEmpresa) then
    FDAOTelefoneEmpresa := TDAOTelefoneEmpresa.New;

  Result := FDAOTelefoneEmpresa;
end;

function TFactoryDAO.DAOPessoa: iDAOPessoa;
begin
  if not Assigned(FDAOPessoa) then
    FDAOPessoa := TDAOPessoa.New;

  Result := FDAOPessoa;
end;

function TFactoryDAO.DAOEnderecoPessoa: iDAOEnderecoPessoa;
begin
  if not Assigned(FDAOEnderecoPessoa) then
    FDAOEnderecoPessoa := TDAOEnderecoPessoa.New;

  Result := FDAOEnderecoPessoa;
end;

function TFactoryDAO.DAOEmailPessoa: iDAOEmailPessoa;
begin
  if not Assigned(FDAOEmailPessoa) then
    FDAOEmailPessoa := TDAOEmailPessoa.New;

  Result := FDAOEmailPessoa;
end;

function TFactoryDAO.DAOTelefonePessoa: iDAOTelefonePessoa;
begin
  if not Assigned(FDAOTelefonePessoa) then
    FDAOTelefonePessoa := TDAOTelefonePessoa.New;

  Result := FDAOTelefonePessoa;
end;

function TFactoryDAO.DAOCategoriaProduto: iDAOCategoriaProduto;
begin
  if not Assigned(FDAOCategoriaProduto) then
    FDAOCategoriaProduto := TDAOCategoriaProduto.New;

  Result := FDAOCategoriaProduto;
end;

function TFactoryDAO.DAOMarcaProduto: iDAOMarcaProduto;
begin
  if not Assigned(FDAOMarcaProduto) then
    FDAOMarcaProduto := TDAOMarcaProduto.New;

  Result := FDAOMarcaProduto;
end;

function TFactoryDAO.DAOUnidadeProduto: iDAOUnidadeProduto;
begin
  if not Assigned(FDAOUnidadeProduto) then
    FDAOUnidadeProduto := TDAOUnidadeProduto.New;

  Result := FDAOUnidadeProduto;
end;

function TFactoryDAO.DAOEndereco: iDAOEndereco;
begin
  if not Assigned(FDAOEndereco) then
    FDAOEndereco := TDAOEndereco.New;

  Result := FDAOEndereco;
end;

function TFactoryDAO.DAONumero: iDAONumero;
begin
  if not Assigned(FDAONumero) then
    FDAONumero := TDAONumero.New;

  Result := FDAONumero;
end;

function TFactoryDAO.DAOProduto: iDAOProduto;
begin
  if not Assigned(FDAOProduto) then
    FDAOProduto := TDAOProduto.New;

  Result := FDAOProduto;
end;

function TFactoryDAO.DAOMunicipio: iDAOMunicipio;
begin
  if not Assigned(FDAOMunicipio) then
    FDAOMunicipio := TDAOMunicipio.New;

  Result := FDAOMunicipio;
end;

function TFactoryDAO.DAOEstado: iDAOEstado;
begin
  if not Assigned(FDAOEstado) then
    FDAOEstado := TDAOEstado.New;

  Result := FDAOEstado;
end;

function TFactoryDAO.DAORegiaoEstado: iDAORegiaoEstado;
begin
  if not Assigned(FDAORegiaoEstado) then
    FDAORegiaoEstado := TDAORegiaoEstado.New;

  Result := FDAORegiaoEstado;
end;

function TFactoryDAO.DAONaturezaJuridica: iDAONaturezaJuridica;
begin
  if not Assigned(FDAONaturezaJuridica) then
    FDAONaturezaJuridica := TDAONaturezaJuridica.New;

  Result := FDAONaturezaJuridica;
end;

function TFactoryDAO.DAOCaixa: iDAOCaixa;
begin
  if not Assigned(FDAOCaixaDiario) then
    FDAOCaixaDiario := TDAOCaixa.New;

  Result := FDAOCaixaDiario;
end;

function TFactoryDAO.DAOMovimentoCaixa: iDAOMovimentoCaixa;
begin
  if not Assigned(FDAOMovimentoCaixa) then
    FDAOMovimentoCaixa := TDAOMovimentoCaixa.New;

  Result := FDAOMovimentoCaixa;
end;

function TFactoryDAO.DAOFecharCaixa: iDAOFecharCaixa;
begin
  if not Assigned(FDAOFecharCaixa) then
    FDAOFecharCaixa := TDAOFecharCaixa.New;

  Result := FDAOFecharCaixa;
end;

function TFactoryDAO.DAOPedido: iDAOPedido;
begin
  if not Assigned(FDAOPedido) then
    FDAOPedido := TDAOPedido.New;

  Result := FDAOPedido;
end;

function TFactoryDAO.DAOPedidoItem: iDAOPedidoItem;
begin
  if not Assigned(FDAOPedidoItem) then
    FDAOPedidoItem := TDAOPedidoItem.New;

  Result := FDAOPedidoItem;
end;

function TFactoryDAO.DAOPedidoPagamento: iDAOPedidoPagamento;
begin
  if not Assigned(FDAOPedidoPagamento) then
    FDAOPedidoPagamento := TDAOPedidoPagamento.New;

  Result := FDAOPedidoPagamento;
end;

function TFactoryDAO.DAOMovimentoPedido: iDAOMovimentoPedido;
begin
  if not Assigned(FDAOMovimentoPedido) then
    FDAOMovimentoPedido := TDAOMovimentoPedido.New;

  Result := FDAOMovimentoPedido;
end;

function TFactoryDAO.DAOCaixaPedido: iDAOCaixaPedido;
begin
  if not Assigned(FDAOCaixaPedido) then
    FDAOCaixaPedido := TDAOCaixaPedido.New;

  Result := FDAOCaixaPedido;
end;

function TFactoryDAO.DAOCondicaoPagamento: iDAOCondicaoPagamento;
begin
  if not Assigned(FDAOCondicaoPagamento) then
    FDAOCondicaoPagamento := TDAOCondicaoPagamento.New;

  Result := FDAOCondicaoPagamento;
end;

function TFactoryDAO.DAOCondicaoPagamentoItem: iDAOCondicaoPagamentoItem;
begin
  if not Assigned(FDAOCondicaoPagamentoItem) then
    FDAOCondicaoPagamentoItem := TDAOCondicaoPagamentoItem.New;

  Result := FDAOCondicaoPagamentoItem;
end;

end.
