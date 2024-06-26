{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 22/04/2024 11:12           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Caixa.Diario.Interfaces;

interface

uses
  Model.Entidade.Usuario.Interfaces;

type
  iEntidadeCaixaDiario<T> = interface
    ['{20798A26-E449-405D-9658-06C0034CAC46}']
    function Id             (Value : Integer)   : iEntidadeCaixaDiario<T>; overload;
    function Id                                 : Integer;                 overload;
    function IdEmpresa      (Value : Integer)   : iEntidadeCaixaDiario<T>; overload;
    function IdEmpresa                          : Integer;                 overload;
    function IdUsuario      (Value : Integer)   : iEntidadeCaixaDiario<T>; overload;
    function IdUsuario                          : Integer;                 overload;
    function ValorInicial   (Value : Currency)  : iEntidadeCaixaDiario<T>; overload;
    function ValorInicial                       : Currency;                overload;
    function DataHoraEmissao(Value : TDateTime) : iEntidadeCaixaDiario<T>; overload;
    function DataHoraEmissao                    : TDateTime;               overload;
    function Status         (Value : String)    : iEntidadeCaixaDiario<T>; overload;
    function Status                             : String;                  overload;

    //Inje��o de depend�ncia
    function Usuario  : iEntidadeUsuario<iEntidadeCaixaDiario<T>>;

    function &End : T;
  end;


implementation

end.
