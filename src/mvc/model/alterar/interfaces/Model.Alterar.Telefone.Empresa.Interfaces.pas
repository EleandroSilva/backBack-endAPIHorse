{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 01/05/2024 00:22           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Alterar.Telefone.Empresa.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Telefone.Empresa.Interfaces;

type
  iAlterarTelefoneEmpresa = Interface
    ['{EE188DBA-8E22-4790-9B5B-019B99CB9264}']
    function JSONObject(Value : TJSONObject) : iAlterarTelefoneEmpresa; overload;
    function JSONObject                      : TJSONObject;             overload;
    function Put    : iAlterarTelefoneEmpresa;
    function Found  : Boolean;
    function Error  : Boolean;

    //inje��o de depend�ncia
    function TelefoneEmpresa : iEntidadeTelefoneEmpresa<iAlterarTelefoneEmpresa>;
    function &End            : iAlterarTelefoneEmpresa;
  End;

implementation

end.
