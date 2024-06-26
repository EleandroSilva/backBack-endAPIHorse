{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 03/04/2024 16:03           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Endereco.Pessoa.Interfaces;

interface

uses
  Data.DB,
  Model.Entidade.Endereco.Pessoa.Interfaces;

type
  iDAOEnderecoPessoa = interface
    ['{AAE1CCD5-7978-4180-B3D3-3C1A3EEF5080}']
    function DataSet(DataSource : TDataSource) : iDAOEnderecoPessoa; overload;
    function DataSet                           : TDataSet;           overload;
    function GetAll                            : iDAOEnderecoPessoa;
    function GetbyId(Id : Variant)             : iDAOEnderecoPessoa; overload;
    function GetbyId(IdPessoa : Integer)       : iDAOEnderecoPessoa; overload;
    function GetbyParams                       : iDAOEnderecoPessoa; overload;
    function GetbyParams(IdEmpresa, IdEndereco, IdPessoa : Integer) : iDAOEnderecoPessoa; overload;
    function Post                              : iDAOEnderecoPessoa;
    function Put                               : iDAOEnderecoPessoa;
    function Delete                            : iDAOEnderecoPessoa;

    function QuantidadeRegistro : Integer;
    function This : iEntidadeEnderecoPessoa<iDAOEnderecoPessoa>;
  end;

implementation

end.
