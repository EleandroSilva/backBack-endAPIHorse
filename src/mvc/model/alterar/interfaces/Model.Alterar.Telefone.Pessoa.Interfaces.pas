{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 02/05/2024 13:42           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Alterar.Telefone.Pessoa.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Telefone.Pessoa.Interfaces;

type
  iAlterarTelefonePessoa = Interface
    ['{C438A388-2DDC-4B60-8571-A4F39FCC9FBA}']
    function JSONObject(Value : TJSONObject) : iAlterarTelefonePessoa; overload;
    function JSONObject                      : TJSONObject;            overload;
    function Put    : iAlterarTelefonePessoa;
    function Found  : Boolean;
    function Error  : Boolean;

    //inje��o de depend�ncia
    function TelefonePessoa : iEntidadeTelefonePessoa<iAlterarTelefonePessoa>;
    function &End : iAlterarTelefonePessoa;
  End;

implementation

end.
