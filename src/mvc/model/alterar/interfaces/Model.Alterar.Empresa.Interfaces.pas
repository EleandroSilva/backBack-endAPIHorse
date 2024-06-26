{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 26/04/2024 17:41           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Alterar.Empresa.Interfaces;

interface

uses
  System.JSON,

  Model.Entidade.Empresa.Interfaces,
  Model.Entidade.Endereco.Interfaces;

type
  iAlterarEmpresa = Interface
    ['{EC95F7CC-6EF7-40D9-9DAE-07B674C34D46}']
    function JSONObject(Value : TJSONObject) : iAlterarEmpresa; overload;
    function JSONObject                      : TJSONObject;     overload;
    function Put    : iAlterarEmpresa;
    function Found  : Boolean;
    function Error  : Boolean;

    //inje��o de depend�ncia
    function Empresa  : iEntidadeEmpresa <iAlterarEmpresa>;
    function Endereco : iEntidadeEndereco<iAlterarEmpresa>;
    function &End     : iAlterarEmpresa;
  End;

implementation

end.
