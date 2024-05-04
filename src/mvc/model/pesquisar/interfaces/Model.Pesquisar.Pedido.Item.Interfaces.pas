{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 04/05/2024 11:42           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Pesquisar.Pedido.Item.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Pedido.Item.Interfaces;

type
  iPesquisarPedidoItem = Interface
    ['{25A8CBD7-A728-49FC-88EE-2A3889483A0E}']
    function GetBy(IdPedido : Integer) : iPesquisarPedidoItem;
    function LoopPedidoItem : TJSONValue;
    function Found : Boolean;
    function Error : Boolean;

    function PedidoItem : iEntidadePedidoItem<iPesquisarPedidoItem>;
    function &End : iPesquisarPedidoItem;
  End;

implementation

end.
