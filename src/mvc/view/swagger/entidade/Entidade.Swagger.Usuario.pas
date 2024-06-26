{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            In�cio do projeto 09/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2023                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Entidade.Swagger.Usuario;

interface

uses
  GBSwagger.Model.Attributes;

//Relacionamento com tabela empresa <- Id=IdEmpresa->Tabela Usuario
type
  TUsuario = class
    private
      FId              : Integer;{bigint-Primary Key}
      FIdEmpresa       : Integer;{bigint-Foreign Key->Tabela empresa->Exclu�r Cascade; Alterar Cascade}
      FNomeUsuario     : String; {Varchar(120)->Not Null}
      FEmail           : String; {Varchar(100)->Unique Key(Email+Senha)->Not Null}
      FSenha           : String; {Varchar(20)->Unique Key(Email+Senha)->Not Null}
      FDataHoraEmissao : TDateTime;
      FAtivo           : Integer;{Integer->0-Inativo 1-Ativo->Not Null}
    public
      //[SwagParamQuery('id', true)]
      [SwagProp('PRIMARY KEY (auto_increment)', True, False)]
      property id              : Integer read FId        write FId;
      [SwagProp('FOREIGN KEY Tabela empresa->id=idempresa->Tabela Usuario',True)]
      property idempresa       : Integer read FIdempresa write FIdempresa;
      [SwagProp('Varchar(120) Not Null', True)]
      property nomeusuario     : String  read FNomeUsuario      write FNomeUsuario;
      [SwagProp('Varchar(80) Not Null---Email/Senha campo Unique Key---', True)]
      property email           : String  read FEmail     write FEmail;
      [SwagProp('Varchar(20) Not Null', True)]
      property senha           : String  read FSenha     write FSenha;
      [SwagProp(True)]
      property datahoraemissao : TDateTime read FDataHoraEmissao write FDataHoraEmissao;
      [SwagProp('0-Inavito; 1-Ativo', True)]
      property ativo           : Integer read FAtivo     write FAtivo;
  end;

implementation

end.
