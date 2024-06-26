{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 08/04/2024 18:12           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Regiao.Estado.Interfaces;

interface

type
  iEntidadeRegiaoEstado<T> = interface
    ['{D414495C-A4E2-4E21-9F7F-F472E3220694}']
    function Id       (Value : Integer) : iEntidadeRegiaoEstado<T>; overload;
    function Id                         : Integer;                  overload;
    function Regiao    (Value : String) : iEntidadeRegiaoEstado<T>; overload;
    function Regiao                     : String;                   overload;

    function &End : T;
  end;

implementation

end.
