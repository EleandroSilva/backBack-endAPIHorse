{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2004/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Pessoa.Interfaces;

interface

uses
  Model.Entidade.Endereco.Pessoa.Interfaces,
  Model.Entidade.Email.Pessoa.Interfaces,
  Model.Entidade.Telefone.Pessoa.Interfaces;

type
  iEntidadePessoa<T>= interface
    ['{2B1D51DC-B059-4D4F-ABC9-9B2046CA2B63}']
    function Id             (Value : Integer)   : iEntidadePessoa<T>; overload;
    function Id                                 : Integer;            overload;
    function IdEmpresa      (Value : Integer)   : iEntidadePessoa<T>; overload;
    function IdEmpresa                          : Integer;            overload;
    function IdUsuario      (Value : Integer)   : iEntidadePessoa<T>; overload;
    function IdUsuario                          : Integer;            overload;
    function CPFCNPJ        (Value : String)    : iEntidadePessoa<T>; overload;
    function CPFCNPJ                            : String;             overload;
    function RGIE           (Value : String)    : iEntidadePessoa<T>; overload;
    function RGIE                               : String;             overload;
    function NomePessoa     (Value : String)    : iEntidadePessoa<T>; overload;
    function NomePessoa                         : String;             overload;
    function SobreNome      (Value : String)    : iEntidadePessoa<T>; overload;
    function SobreNome                          : String;             overload;
    function FisicaJuridica (Value : String)    : iEntidadePessoa<T>; overload;
    function FisicaJuridica                     : String;             overload;
    function Sexo           (Value : String)    : iEntidadePessoa<T>; overload;
    function Sexo                               : String;             overload;
    function TipoPessoa     (Value : String)    : iEntidadePessoa<T>; overload;
    function TipoPessoa                         : String;             overload;
    function DataHoraEmissao(Value : TDateTime) : iEntidadePessoa<T>; overload;
    function DataHoraEmissao                    : TDateTime;          overload;
    function DataNascimento (Value : TDateTime) : iEntidadePessoa<T>; overload;
    function DataNascimento                     : TDateTime;          overload;
    function Ativo          (Value : Integer)   : iEntidadePessoa<T>; overload;
    function Ativo                              : Integer;            overload;

    //Inje��o de depend�ncia
    function EnderecoPessoa : iEntidadeEnderecoPessoa<iEntidadePessoa<T>>;
    function EmailPessoa    : iEntidadeEmailPessoa   <iEntidadePessoa<T>>;
    function TelefonePessoa : iEntidadeTelefonePessoa<iEntidadePessoa<T>>;

    function &End : T;
  end;

implementation

end.
