{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 08/04/2024 18:12           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Municipio.Interfaces;

interface

uses
  Model.Entidade.Estado.Interfaces;

type
  iEntidadeMunicipio<T> = Interface
    ['{6A4EB5AB-8A71-41F8-B2E5-6A92739B1359}']
    function Id       (Value : Integer) : iEntidadeMunicipio<T>; overload;
    function Id                         : Integer;               overload;
    function IdEstado (Value : Integer) : iEntidadeMunicipio<T>; overload;
    function IdEstado                   : Integer;               overload;
    function IBGE     (Value : Integer) : iEntidadeMunicipio<T>; overload;
    function IBGE                       : Integer;               overload;
    function Municipio(Value : String)  : iEntidadeMunicipio<T>; overload;
    function Municipio                  : String;                overload;
    function UF       (Value : String)  : iEntidadeMunicipio<T>; overload;
    function UF                         : String;                overload;

    //Inje��o de depend�ncia
    function Estado : iEntidadeEstado<iEntidadeMunicipio<T>>;

    function &End : T;
  End;

implementation

end.
