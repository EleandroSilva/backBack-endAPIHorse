{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            In�cio do projeto 09/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2023                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Entidade.Swagger.Estado;

interface

uses
  GBSwagger.Model.Attributes;

type
  TEstado = class
    private
      FId       : Integer;{bigint-Primary Key}
      FIdEstado : Integer;{bigint)->Unique Key-Not Null-C�digo padr�o do estado}
      FIdRegiao : Integer;{bigint->Foreign Key->tabela regiaoestado Id}
      FEstado   : String; {Varchar(120)-> Not Null}
      FUF       : String; {Varchar(2)}
    public
      property id       : Integer read FId       write FId;
      property idestado : Integer read FIdEstado write FIdEstado;
      property idregiao : Integer read FIdRegiao write FIdRegiao;
      property estado   : String  read FEstado   write FEstado;
      property uf       : String  read FUF       write FUF;
  end;

implementation

end.
