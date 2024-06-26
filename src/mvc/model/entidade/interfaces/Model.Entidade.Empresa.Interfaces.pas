{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2004/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Empresa.Interfaces;

interface

uses
  Model.Entidade.Email.Empresa.Interfaces,
  Model.Entidade.Endereco.Empresa.Interfaces,
  Model.Entidade.Telefone.Empresa.Interfaces,
  Model.Entidade.Natureza.Juridica.Interfaces;

type
  iEntidadeEmpresa<T> = interface
    ['{FBD8184A-0671-4F70-86E4-A5ED07DCAFC8}']
    function Id                   (Value : Integer)   : iEntidadeEmpresa<T>; overload;
    function Id                                       : Integer;             overload;
    function CNPJ                 (Value : String)    : iEntidadeEmpresa<T>; overload;
    function CNPJ                                     : String;              overload;
    function InscricaoEstadual    (Value : String)    : iEntidadeEmpresa<T>; overload;
    function InscricaoEstadual                        : String;              overload;
    function NomeEmpresarial      (Value : String)    : iEntidadeEmpresa<T>; overload;
    function NomeEmpresarial                          : String;              overload;
    function NomeFantasia         (Value : String)    : iEntidadeEmpresa<T>; overload;
    function NomeFantasia                             : String;              overload;
    function IdNaturezaJuridica   (Value : Integer)   : iEntidadeEmpresa<T>; overload;
    function IdNaturezaJuridica                       : Integer;             overload;
    function DataHoraEmissao      (Value : TDateTime) : iEntidadeEmpresa<T>; overload;
    function DataHoraEmissao                          : TDateTime;           overload;
    function DataSituacaoCadastral(Value : TDateTime) : iEntidadeEmpresa<T>; overload;
    function DataSituacaoCadastral                    : TDateTime;           overload;
    function Ativo                (Value : Integer)   : iEntidadeEmpresa<T>; overload;
    function Ativo                                    : Integer;             overload;


    //Inje��o de depend�ncia
    function EnderecoEmpresa  : iEntidadeEnderecoEmpresa <iEntidadeEmpresa<T>>;
    function EmailEmpresa     : iEntidadeEmailEmpresa    <iEntidadeEmpresa<T>>;
    function TelefoneEmpresa  : iEntidadeTelefoneEmpresa <iEntidadeEmpresa<T>>;
    function NaturezaJuridica : iEntidadeNaturezaJuridica<iEntidadeEmpresa<T>>;

    function &End : T;
  end;

implementation

end.
