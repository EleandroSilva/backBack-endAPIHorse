{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Empresa.Interfaces;

interface

uses
  Data.DB,

  Model.Entidade.Empresa.Interfaces;

type
  iDAOEmpresa = interface
    ['{FEFEC630-0C85-4F02-9F3F-1E24019F279F}']
    function DataSet(DataSource : TDataSource) : iDAOEmpresa; overload;
    function DataSet                           : TDataSet;    overload;
    function GetAll                            : iDAOEmpresa;
    function GetbyId  (Id : Variant)           : iDAOEmpresa;
    function GetbyCNPJ(CNPJ: String)           : iDAOEmpresa;
    function GetbyParams                       : iDAOEmpresa;

    function Post                              : iDAOEmpresa;
    function Put                               : iDAOEmpresa;
    function Delete                            : iDAOEmpresa;

    function QuantidadeRegistro : Integer;
    function This : iEntidadeEmpresa<iDAOEmpresa>;
  end;

implementation

end.
