{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 01/05/2024 11:37           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Pesquisar.Endereco.Empresa.Interfaces;

interface

uses
  System.JSON,
  Model.Entidade.Endereco.Empresa.Interfaces;

type
  iPesquisarEnderecoEmpresa = interface
    ['{128F28E2-FD35-4D89-A2C2-6B18290CD39D}']
    function Getby(IdEmpresa, IdEndereco : Integer) : iPesquisarEnderecoEmpresa;
    function LoopEnderecoEmpresa : TJSONValue;
    function Found : Boolean;
    function Error : Boolean;

    function EnderecoEmpresa : iEntidadeEnderecoEmpresa<iPesquisarEnderecoEmpresa>;
    function &End  : iPesquisarEnderecoEmpresa;
  end;

implementation

end.
