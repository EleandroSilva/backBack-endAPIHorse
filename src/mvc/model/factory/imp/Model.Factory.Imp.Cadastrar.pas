{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 26/04/2024 17:41           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Factory.Imp.Cadastrar;

interface

uses
  Model.Factory.Cadastrar.Interfaces,

  Model.Cadastrar.Empresa.Interfaces,
  Model.Cadastrar.Usuario.Interfaces,
  Model.Cadastrar.Endereco.Interfaces,
  Model.Cadastrar.Numero.Interfaces,
  Model.Cadastrar.Endereco.Empresa.Interfaces,
  Model.Cadastrar.Email.Empresa.Interfaces,
  Model.Cadastrar.Telefone.Empresa.Interfaces,
  Model.Cadastrar.Pessoa.Interfaces,
  Model.Cadastrar.Email.Pessoa.Interfaces,
  Model.Cadastrar.Telefone.Pessoa.Interfaces,
  Model.Cadastrar.Pedido.Interfaces,
  Model.Cadastrar.Pedido.Item.Interfaces,
  Model.Cadastrar.Pedido.Pagamento.Interfaces,
  Model.Cadastrar.Caixa.Pedido.Interfaces;

type
  TFactoryCadastrar = class(TInterfacedObject, iFactoryCadastrar)
    private
      FCadastrarEmpresa  : iCadastrarEmpresa;
      FCadastrarUsuario  : iCadastrarUsuario;
      FCadastrarEndereco : iCadastrarEndereco;
      FCadastrarNumero   : iCadastrarNumero;
      FCadastrarEnderecoEmpresa : iCadastrarEnderecoEmpresa;
      FCadastrarEmailEmpresa    : iCadastrarEmailEmpresa;
      FCadastrarTelefoneEmpresa : iCadastrarTelefoneEmpresa;
      FCadastrarPessoa          : iCadastrarPessoa;
      FCadastrarEmailPessoa     : iCadastrarEmailPessoa;
      FCadastrarTelefonePessoa  : iCadastrarTelefonePessoa;
      FCadastrarPedido          : iCadastrarPedido;
      FCadastrarPedidoItem      : iCadastrarPedidoItem;
      FCadastrarPedidoPagamento : iCadastrarPedidoPagamento;
      FCadastrarCaixaPedido     : iCadastrarCaixaPedido;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iFactoryCadastrar;

      function CadastrarEmpresa  : iCadastrarEmpresa;
      function CadastrarUsuario  : iCadastrarUsuario;
      function CadastrarEndereco : iCadastrarEndereco;
      function CadastrarNumero   : iCadastrarNumero;
      function CadastrarEnderecoEmpresa : iCadastrarEnderecoEmpresa;
      function CadastrarEmailEmpresa    : iCadastrarEmailEmpresa;
      function CadastrarTelefoneEmpresa : iCadastrarTelefoneEmpresa;
      function CadastrarPessoa          : iCadastrarPessoa;
      function CadastrarEmailPessoa     : iCadastrarEmailPessoa;
      function CadastrarTelefonePessoa  : iCadastrarTelefonePessoa;
      function CadastrarPedido          : iCadastrarPedido;
      function CadastrarPedidoItem      : iCadastrarPedidoItem;
      function CadastrarPedidoPagamento : iCadastrarPedidoPagamento;
      function CadastrarCaixaPedido     : iCadastrarCaixaPedido;
  end;

implementation

uses
  Model.Imp.Cadastrar.Empresa,
  Model.Imp.Cadastrar.Usuario,
  Model.Imp.Cadastrar.Endereco,
  Model.Imp.Cadastrar.Numero,
  Model.Imp.Cadastrar.Endereco.Empresa,
  Model.Imp.Cadastrar.Email.Empresa,
  Model.Imp.Cadastrar.Telefone.Empresa,
  Model.Imp.Cadastrar.Pessoa,
  Model.Imp.Cadastrar.Email.Pessoa,
  Model.Imp.Cadastrar.Telefone.Pessoa,
  Model.Imp.Cadastrar.Pedido,
  Model.Imp.Cadastrar.Pedido.Item,
  Model.Imp.Cadastrar.Pedido.Pagamento,
  Model.Imp.Cadastrar.Caixa.Pedido;

{ TViewFactory }

constructor TFactoryCadastrar.Create;
begin
  //
end;

destructor TFactoryCadastrar.Destroy;
begin
  inherited;
end;

class function TFactoryCadastrar.New: iFactoryCadastrar;
begin
  Result := Self.Create;
end;

function TFactoryCadastrar.CadastrarEmpresa: iCadastrarEmpresa;
begin
  if not Assigned(FCadastrarEmpresa) then
    FCadastrarEmpresa  := TCadastrarEmpresa.New;

  Result := FCadastrarEmpresa;
end;

function TFactoryCadastrar.CadastrarUsuario: iCadastrarUsuario;
begin
  if not Assigned(FCadastrarUsuario) then
    FCadastrarUsuario := TCadastrarUsuario.New;

  Result := FCadastrarUsuario;
end;

function TFactoryCadastrar.CadastrarEndereco: iCadastrarEndereco;
begin
  if not Assigned(FCadastrarEndereco) then
    FCadastrarEndereco := TCadastrarEndereco.New;

  Result := FCadastrarEndereco;
end;

function TFactoryCadastrar.CadastrarNumero: iCadastrarNumero;
begin
  if not Assigned(FCadastrarNumero) then
    FCadastrarNumero := TCadastrarNumero.New;

  Result := FCadastrarNumero;
end;

function TFactoryCadastrar.CadastrarTelefoneEmpresa: iCadastrarTelefoneEmpresa;
begin
  if not Assigned(FCadastrarTelefoneEmpresa) then
    FCadastrarTelefoneEmpresa := TCadastrarTelefoneEmpresa.New;

  Result := FCadastrarTelefoneEmpresa;
end;

function TFactoryCadastrar.CadastrarEmailEmpresa: iCadastrarEmailEmpresa;
begin
  if not Assigned(FCadastrarEmailEmpresa) then
    FCadastrarEmailEmpresa := TCadastrarEmailEmpresa.New;

  Result := FCadastrarEmailEmpresa;
end;

function TFactoryCadastrar.CadastrarEnderecoEmpresa: iCadastrarEnderecoEmpresa;
begin
  if not Assigned(FCadastrarEnderecoEmpresa) then
    FCadastrarEnderecoEmpresa := TCadastrarEnderecoEmpresa.New;

  Result := FCadastrarEnderecoEmpresa;
end;

function TFactoryCadastrar.CadastrarPessoa: iCadastrarPessoa;
begin
  if not Assigned(FCadastrarPessoa) then
    FCadastrarPessoa := TCadastrarPessoa.New;

  Result := FCadastrarPessoa;
end;

function TFactoryCadastrar.CadastrarEmailPessoa: iCadastrarEmailPessoa;
begin
  if not Assigned(FCadastrarEmailPessoa) then
    FCadastrarEmailPessoa := TCadastrarEmailPessoa.New;

  Result := FCadastrarEmailPessoa;
end;

function TFactoryCadastrar.CadastrarTelefonePessoa: iCadastrarTelefonePessoa;
begin
  if not Assigned(FCadastrarTelefonePessoa) then
    FCadastrarTelefonePessoa := TCadastrarTelefonePessoa.New;

  Result := FCadastrarTelefonePessoa;
end;

function TFactoryCadastrar.CadastrarPedido: iCadastrarPedido;
begin
  if not Assigned(FCadastrarPedido) then
    FCadastrarPedido := TCadastrarPedido.New;

  Result := FCadastrarPedido;
end;

function TFactoryCadastrar.CadastrarPedidoItem: iCadastrarPedidoItem;
begin
  if not Assigned(FCadastrarPedidoItem) then
    FCadastrarPedidoItem := TCadastrarPedidoItem.New;

  Result := FCadastrarPedidoItem;
end;

function TFactoryCadastrar.CadastrarPedidoPagamento: iCadastrarPedidoPagamento;
begin
  if not Assigned(FCadastrarPedidoPagamento) then
    FCadastrarPedidoPagamento := TCadastrarPedidoPagamento.New;

  Result := FCadastrarPedidoPagamento;
end;

function TFactoryCadastrar.CadastrarCaixaPedido: iCadastrarCaixaPedido;
begin
  if not Assigned(FCadastrarCaixaPedido) then
    FCadastrarCaixaPedido := TCadastrarCaixaPedido.New;

  Result := FCadastrarCaixaPedido;
end;

end.
