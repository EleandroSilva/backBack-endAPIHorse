{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 26/04/2024 12:00           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Movimento.Pedido.Interfaces;

interface

uses
  Model.Entidade.Pessoa.Interfaces;

type
  iEntidadeMovimentoPedido<T>= interface
    ['{CF724B6B-6C4E-4D48-B7CC-0CEA76BA7147}']
    function Id             (Value: Integer)   : iEntidadeMovimentoPedido<T>; overload;
    function Id                                : Integer;                     overload;
    function IdEmpresa      (Value: Integer)   : iEntidadeMovimentoPedido<T>; overload;
    function IdEmpresa                         : Integer;                     overload;
    function IdPedido       (Value: Integer)   : iEntidadeMovimentoPedido<T>; overload;
    function IdPedido                          : Integer;                     overload;
    function IdUsuario      (Value: Integer)   : iEntidadeMovimentoPedido<T>; overload;
    function IdUsuario                         : Integer;                     overload;
    function DataHoraEmissao(Value: TDateTime) : iEntidadeMovimentoPedido<T>; overload;
    function DataHoraEmissao                   : TDateTime;                   overload;
    function Status         (Value: Integer)   : iEntidadeMovimentoPedido<T>; overload;
    function Status                            : Integer;                     overload;

    //Inje��o de depend�ncia
    function Pessoa  : iEntidadePessoa<iEntidadeMovimentoPedido<T>>;

    function &End : T;
  end;

implementation

end.
