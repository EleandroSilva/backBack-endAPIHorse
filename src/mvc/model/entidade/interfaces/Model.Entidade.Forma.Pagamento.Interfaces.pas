{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 22/04/2024 11:46           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Forma.Pagamento.Interfaces;

interface

//Tabela fixa somente a empresa Be More Web, pode fazer altera��es
type
  iEntidadeFormaPagamento<T> = interface
    ['{2248B885-B894-4FA3-B07C-DB72E2A51EBA}']
    function Id                (Value : Integer)   : iEntidadeFormaPagamento<T>; overload;
    function Id                                    : Integer;                    overload;
    function NomeFormaPagamento(Value : String)    : iEntidadeFormaPagamento<T>; overload;
    function NomeFormaPagamento                    : String;                     overload;
    function DataHoraEmissao   (Value : TDateTime) : iEntidadeFormaPagamento<T>; overload;
    function DataHoraEmissao                       : TDateTime;                  overload;

    function &End : T;
  end;

implementation

end.
