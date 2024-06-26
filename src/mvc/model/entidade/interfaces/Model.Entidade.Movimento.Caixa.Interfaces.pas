{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 22/04/2024 11:12           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Movimento.Caixa.Interfaces;

interface

uses
  Model.Entidade.Usuario.Interfaces;

type
  iEntidadeMovimentoCaixa<T> = interface
    ['{DB6E00D2-0959-44D7-B8F8-6505417F743F}']
    function Id              (Value : Integer)   : iEntidadeMovimentoCaixa<T>; overload;
    function Id                                  : Integer;                    overload;
    function IdCaixa         (Value : Integer)   : iEntidadeMovimentoCaixa<T>; overload;
    function IdCaixa                             : Integer;                    overload;
    function IdPedido        (Value : Integer)   : iEntidadeMovimentoCaixa<T>; overload;
    function IdPedido                            : Integer;                    overload;
    function IdFormaPagamento(Value : Integer)   : iEntidadeMovimentoCaixa<T>; overload;
    function IdFormaPagamento                    : Integer;                    overload;
    function IdUsuario       (Value : Integer)   : iEntidadeMovimentoCaixa<T>; overload;
    function IdUsuario                           : Integer;                    overload;
    function ValorLancado    (Value : Currency)  : iEntidadeMovimentoCaixa<T>; overload;
    function ValorLancado                        : Currency;                   overload;
    function CreditoDebito   (Value : String)    : iEntidadeMovimentoCaixa<T>; overload;
    function CreditoDebito                       : String;                     overload;
    function DataHoraEmissao (Value : TDateTime) : iEntidadeMovimentoCaixa<T>; overload;
    function DataHoraEmissao                     : TDateTime;                  overload;
    function TipoLancamento  (Value : String)    : iEntidadeMovimentoCaixa<T>; overload;
    function TipoLancamento                      : String;                     overload;

    //Inje��o de depend�ncia
    function Usuario  : iEntidadeUsuario<iEntidadeMovimentoCaixa<T>>;

    function &End : T;
  end;

implementation

end.
