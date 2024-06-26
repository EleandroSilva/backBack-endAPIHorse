{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 26/04/2024 12:56           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Movimento.Pedido.Interfaces;

interface

uses
  Data.DB,

  Model.Entidade.Movimento.Pedido.Interfaces;

type
  iDAOMovimentoPedido = interface
    ['{634FBF36-237A-41BD-AF97-91B430C8236B}']
    function DataSet(DataSource : TDataSource) : iDAOMovimentoPedido; overload;
    function DataSet                           : TDataSet;            overload;
    function GetAll                            : iDAOMovimentoPedido;
    function GetbyId(Id : Variant)             : iDAOMovimentoPedido; overload;
    function GetbyId(IdPedido : Integer)       : iDAOMovimentoPedido; overload;
    function GetbyParams                       : iDAOMovimentoPedido;
    function Post                              : iDAOMovimentoPedido;
    function Put                               : iDAOMovimentoPedido;
    function Delete                            : iDAOMovimentoPedido;

    function QuantidadeRegistro : Integer;
    function This : iEntidadeMovimentoPedido<iDAOMovimentoPedido>;
  end;

implementation

end.
