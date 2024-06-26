{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 30/04/2024 20:04           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Factory.Pesquisar.Interfaces;

interface

uses
  Model.Pesquisar.Empresa.Interfaces,
  Model.Pesquisar.Endereco.Empresa.Interfaces,
  Model.Pesquisar.Email.Empresa.Interfaces,
  Model.Pesquisar.Endereco.Interfaces,
  Model.Pesquisar.Numero.Interfaces,
  Model.Pesquisar.Telefone.Empresa.Interfaces,
  Model.Pesquisar.Usuario.Interfaces,
  Model.Pesquisar.Pessoa.Interfaces,
  Model.Pesquisar.Endereco.Pessoa.Interfaces,
  Model.Pesquisar.Email.Pessoa.Interfaces,
  Model.Pesquisar.Telefone.Pessoa.Interfaces,
  Model.Pequisar.Caixa.Interfaces,
  Model.Pesquisar.Pedido.Interfaces,
  Model.Pesquisar.Pedido.Item.Interfaces,
  Model.Pesquisar.Pedido.Pagamento.Interfaces;

type
  iFactoryPesquisar = interface
    ['{3BAFF66A-F259-4FAB-90EA-46BB0BBD274D}']
    function PesquisarEmpresa         : iPesquisarEmpresa;
    function PesquisarEnderecoEmpresa : iPesquisarEnderecoEmpresa;
    function PesquisarEmailEmpresa    : iPesquisarEmailEmpresa;
    function PesquisarEndereco        : iPesquisarEndereco;
    function PesquisarNumero          : iPesquisarNumero;
    function PesquisarTelefoneEmpresa : iPesquisarTelefoneEmpresa;
    function PesquisarUsuario         : iPesquisarUsuario;
    function PesquisarPessoa          : iPesquisarPessoa;
    function PesquisarEnderecoPessoa  : iPesquisarEnderecoPessoa;
    function PesquisarEmailPessoa     : iPesquisarEmailPessoa;
    function PesquisarTelefonePessoa  : iPesquisarTelefonePessoa;
    function PesquisarCaixa           : iPesquisarCaixa;
    function PesquisarPedido          : iPesquisarPedido;
    function PesquisarPedidoItem      : iPesquisarPedidoItem;
    function PesquisarPedidoPagamento : iPesquisarPedidoPagamento;
  end;


implementation

end.
