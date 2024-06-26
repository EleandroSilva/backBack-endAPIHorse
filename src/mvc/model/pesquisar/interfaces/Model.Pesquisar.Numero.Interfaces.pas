{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 01/05/2024 11:37           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Pesquisar.Numero.Interfaces;

interface

uses
  Model.Entidade.Numero.Interfaces;

type
  iPesquisarNumero = Interface
    ['{3651B6A9-52EE-4A71-8D8A-F3DB333CC056}']
    function Getby(IdEndereco : Integer; NumeroEndereco : String) : iPesquisarNumero;
    function Found : Boolean;
    function Error : Boolean;

    function Numero : iEntidadeNumero<iPesquisarNumero>;
    function &End   : iPesquisarNumero;
  End;

implementation

end.
