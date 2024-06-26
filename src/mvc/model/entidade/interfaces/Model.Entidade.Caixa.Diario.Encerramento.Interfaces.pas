{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 22/04/2024 11:12           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Caixa.Diario.Encerramento.Interfaces;

interface

uses
  Model.Entidade.Usuario.Interfaces;

type
  iEntidadeCaixaDiarioEncerramento<T> = interface
    ['{7895FB5B-D1A2-4CEF-9041-0732D2CD8558}']
    function Id              (Value : Integer)   : iEntidadeCaixaDiarioEncerramento<T>; overload;
    function Id                                  : Integer;                             overload;
    function IdCaixaDiario   (Value : Integer)   : iEntidadeCaixaDiarioEncerramento<T>; overload;
    function IdCaixaDiario                       : Integer;                             overload;
    function IdUsuario       (Value : Integer)   : iEntidadeCaixaDiarioEncerramento<T>; overload;
    function IdUsuario                           : Integer;                             overload;
    function ValorLancamento (Value : Currency)  : iEntidadeCaixaDiarioEncerramento<T>; overload;
    function ValorLancamento                     : Currency;                            overload;
    function DataHoraEmissao (Value : TDateTime) : iEntidadeCaixaDiarioEncerramento<T>; overload;
    function DataHoraEmissao                     : TDateTime;                           overload;
    function Observacao      (Value : String)    : iEntidadeCaixaDiarioEncerramento<T>; overload;
    function Observacao                          : String;                              overload;

    //Inje��o de depend�ncia
    function Usuario  : iEntidadeUsuario<iEntidadeCaixaDiarioEncerramento<T>>;
    function &End : T;
  end;

implementation

end.
