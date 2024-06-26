{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 30/04/2024 14:18           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Cadastrar.Email.Empresa.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Email.Empresa.Interfaces;

type
  iCadastrarEmailEmpresa = interface
    ['{F5560BEE-733A-48A6-98BD-BE8E8B3150F1}']
    function JSONObjectPai(Value : TJSONObject) : iCadastrarEmailEmpresa; overload;
    function JSONObjectPai                      : TJSONObject;            overload;
    function Post : iCadastrarEmailEmpresa;

    function Error     : Boolean;
    //inje��o de depend�ncia
    function EmailEmpresa : iEntidadeEmailEmpresa<iCadastrarEmailEmpresa>;
    function &End : iCadastrarEmailEmpresa;
  end;

implementation

end.
