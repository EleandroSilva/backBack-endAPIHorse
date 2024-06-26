{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 13/03/2024 10:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Factory.DAO.Interfaces;

interface

uses
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
  Model.DAO.Pedido.Interfaces,
  Model.DAO.Pedido.Item.Interfaces,
  Model.DAO.Pedido.Pagamento.Interfaces,
  Model.DAO.Movimento.Pedido.Interfaces,
  Model.DAO.Caixa.Pedido.Interfaces;

type
  iFactoryDAO = interface
    ['{88D4F535-E18B-46F2-BBC2-33BAD5C7A389}']
    function DAOUsuario           : iDAOUsuario;
    function DAOEmpresa           : iDAOEmpresa;
    function DAOEnderecoEmpresa   : iDAOEnderecoEmpresa;
    function DAOEmailEmpresa      : iDAOEmailEmpresa;
    function DAOTelefoneEmpresa   : iDAOTelefoneEmpresa;
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
    function DAOCondicaoPagamento : iDAOCondicaoPagamento;
    function DAOCondicaoPagamentoItem : iDAOCondicaoPagamentoItem;
    function DAOPedido            : iDAOPedido;
    function DAOPedidoItem        : iDAOPedidoItem;
    function DAOPedidoPagamento   : iDAOPedidoPagamento;
    function DAOMovimentoPedido   : iDAOMovimentoPedido;
    function DAOCaixaPedido       : iDAOCaixaPedido;
  end;

implementation

end.
