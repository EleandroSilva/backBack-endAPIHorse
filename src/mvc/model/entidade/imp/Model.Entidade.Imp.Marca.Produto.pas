{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Marca.Produto;

interface

uses
  Model.Entidade.Marca.Produto.Interfaces;

type
  TEntidadeMarcaProduto<T : iInterface> = class(TInterfacedObject, iEntidadeMarcaProduto<T>)
    private
      [weak]
      FParent          : T;
      FId              : Integer;
      FIdEmpresa       : Integer;
      FIdUsuario       : Integer;
      FNomeMarca       : String;
      FDataHoraEmissao : TDateTime;
      FAtivo           : Integer;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T): iEntidadeMarcaProduto<T>;

      function Id       (Value : Integer)         : iEntidadeMarcaProduto<T>; overload;
      function Id                                 : Integer;                  overload;
      function IdEmpresa(Value : Integer)         : iEntidadeMarcaProduto<T>; overload;
      function IdEmpresa                          : Integer;                  overload;
      function IdUsuario(Value : Integer)         : iEntidadeMarcaProduto<T>; overload;
      function IdUsuario                          : Integer;                  overload;
      function NomeMarca(Value : String)          : iEntidadeMarcaProduto<T>; overload;
      function NomeMarca                          : String;                   overload;
      function DataHoraEmissao(Value : TDateTime) : iEntidadeMarcaProduto<T>; overload;
      function DataHoraEmissao                    : TDateTime;                overload;
      function Ativo    (Value : Integer)         : iEntidadeMarcaProduto<T>; overload;
      function Ativo                              : Integer;                  overload;

      function &End : T;
  end;

implementation

constructor TEntidadeMarcaProduto<T>.Create(Parent: T);
begin
  FParent := Parent;
end;

destructor TEntidadeMarcaProduto<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeMarcaProduto<T>.New(Parent: T): iEntidadeMarcaProduto<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeMarcaProduto<T>.Id(Value: Integer): iEntidadeMarcaProduto<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeMarcaProduto<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeMarcaProduto<T>.IdEmpresa(Value: Integer): iEntidadeMarcaProduto<T>;
begin
  Result := Self;
  FIdEmpresa := Value;
end;

function TEntidadeMarcaProduto<T>.IdEmpresa: Integer;
begin
  Result := FIdEmpresa;
end;

function TEntidadeMarcaProduto<T>.IdUsuario(Value: Integer): iEntidadeMarcaProduto<T>;
begin
  Result := Self;
  FIdUsuario := Value;
end;

function TEntidadeMarcaProduto<T>.IdUsuario: Integer;
begin
  Result := FIdUsuario;
end;

function TEntidadeMarcaProduto<T>.NomeMarca(Value: String): iEntidadeMarcaProduto<T>;
begin
  Result := Self;
  FNomeMarca  := Value;
end;

function TEntidadeMarcaProduto<T>.NomeMarca: String;
begin
  Result := FNomeMarca;
end;

function TEntidadeMarcaProduto<T>.DataHoraEmissao(Value: TDateTime): iEntidadeMarcaProduto<T>;
begin
  Result := Self;
  FDataHoraEmissao := Value;
end;

function TEntidadeMarcaProduto<T>.DataHoraEmissao: TDateTime;
begin
  Result := FDataHoraEmissao;
end;

function TEntidadeMarcaProduto<T>.Ativo(Value: Integer): iEntidadeMarcaProduto<T>;
begin
  Result := Self;
  FAtivo := Value;
end;

function TEntidadeMarcaProduto<T>.Ativo: Integer;
begin
  Result := FAtivo;
end;

function TEntidadeMarcaProduto<T>.&End: T;
begin
  Result := FParent;
end;

end.
