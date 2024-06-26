{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 30/04/2024 14:18           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Cadastrar.Endereco.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Endereco.Interfaces,
  Model.Entidade.Empresa.Interfaces,
  Model.Entidade.Pessoa.Interfaces;

type
  iCadastrarEndereco = interface
    ['{45EDC1C8-87DA-46D6-B087-42FB8390BC3E}']
    function JSONObjectPai(Value : TJSONObject) : iCadastrarEndereco; overload;
    function JSONObjectPai                      : TJSONObject;        overload;
    function Post : iCadastrarEndereco;
    function Error     : Boolean;
    //inje��o de depend�ncia
    function Endereco : iEntidadeEndereco<iCadastrarEndereco>;
    function Empresa  : iEntidadeEmpresa<iCadastrarEndereco>;
    function Pessoa   : iEntidadePessoa<iCadastrarEndereco>;
    function &End : iCadastrarEndereco;
  end;

implementation

end.
