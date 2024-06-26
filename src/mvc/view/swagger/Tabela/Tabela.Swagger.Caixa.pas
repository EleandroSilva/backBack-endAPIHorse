{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            In�cio do projeto 23/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2023                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Tabela.Swagger.Caixa;

interface

uses
  GBSwagger.Model.Attributes;

type
  TCaixa = class
    private
      FId              : Integer;
      FIdEmpresa       : Integer;
      FIdUsuario       : Integer;
      FValorInicial    : Currency;
      FDataHoraEmissao : TDateTime;
      FStatus          : String;
    public
      [SwagProp('PRIMARY KEY (auto_increment)', True, False)]
      property id              : Integer   read FId              write FId;
      [SwagProp('FOREIGN KEY Tabela empresa->id=idempresa->Tabela caixadiario',True)]
      property idempresa       : Integer   read FIdEmpresa       write FIdEmpresa;
      [SwagProp('FOREIGN KEY Tabela usuario->id=idusuario->Tabela caixadiario',True)]
      property idusuario       : Integer   read FIdUsuario       write FIdUsuario;
      [SwagProp('Valor troco', True)]
      property valorinicial    : Currency  read FValorInicial    write FValorInicial;
      [SwagProp('Data Abertura', True)]
      property datahoraemissao : TDateTime read FDataHoraEmissao write FDataHoraEmissao;
      [SwagProp('J� vem com A-Aberto', True)]
      property status          : String    read FStatus          write FStatus;
  end;

implementation

end.
