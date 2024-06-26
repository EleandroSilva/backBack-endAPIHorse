{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 03/04/2024 16:03           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Numero.Interfaces;

interface

uses
  Data.DB,

  Model.Entidade.Numero.Interfaces;

type
  iDAONumero = interface
    ['{DEACAB25-BB3C-4BFD-87B1-88B0BFFFD81F}']
    function DataSet(DataSource : TDataSource) : iDAONumero; overload;
    function DataSet                           : TDataSet;   overload;
    function GetAll                            : iDAONumero;
    function GetbyId(Id : Variant)             : iDAONumero;
    function GetbyParams                       : iDAONumero;
    function Post                              : iDAONumero;
    function Put                               : iDAONumero;
    function Delete                            : iDAONumero;

    function QuantidadeRegistro : Integer;
    function This : iEntidadeNumero<iDAONumero>;
  end;

implementation

end.
