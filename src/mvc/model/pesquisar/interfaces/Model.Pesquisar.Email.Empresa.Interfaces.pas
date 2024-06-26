{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 01/05/2024 11:37           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Pesquisar.Email.Empresa.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Email.Empresa.Interfaces;

type
  iPesquisarEmailEmpresa = Interface
    ['{80844454-AF56-430D-A42F-3C38A9226BC5}']
    function GetBy(IdEmpresa : Integer; Email: String) : iPesquisarEmailEmpresa;
    function LoopEmailEmpresa : TJSONValue;
    function Found : Boolean;
    function Error : Boolean;

    function EmailEmpresa : iEntidadeEmailEmpresa<iPesquisarEmailEmpresa>;
    function &End  : iPesquisarEmailEmpresa;
  End;

implementation

end.
