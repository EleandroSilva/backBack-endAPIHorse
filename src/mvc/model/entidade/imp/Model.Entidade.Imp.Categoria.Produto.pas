{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Categoria.Produto;

interface

uses
  Model.Entidade.Categoria.Produto.Interfaces;

type
  TEntidadeCategoriaProduto<T : iInterface> = class(TInterfacedObject, iEntidadeCategoriaProduto<T>)
    private
      [weak]
      FParent          : T;
      FId              : Integer;
      FIdempresa       : Integer;
      FIdUsuario       : Integer;
      FNomeCategoria   : String;
      FDataHoraEmissao : TDateTime;
      FAtivo           : Integer;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T): iEntidadeCategoriaProduto<T>;

      function Id             (Value : Integer)   : iEntidadeCategoriaProduto<T>; overload;
      function Id                                 : Integer;                      overload;
      function IdEmpresa      (Value : Integer)   : iEntidadeCategoriaProduto<T>; overload;
      function IdEmpresa                          : Integer;                      overload;
      function IdUsuario    (Value : Integer)     : iEntidadeCategoriaProduto<T>; overload;
      function IdUsuario                          : Integer;                      overload;
      function NomeCategoria  (Value : String)    : iEntidadeCategoriaProduto<T>; overload;
      function NomeCategoria                      : String;                       overload;
      function DataHoraEmissao(Value : TDateTime) : iEntidadeCategoriaProduto<T>; overload;
      function DataHoraEmissao                    : TDateTime;                    overload;
      function Ativo          (Value : Integer)   : iEntidadeCategoriaProduto<T>; overload;
      function Ativo                              : Integer;                      overload;

      function &End : T;
  end;

implementation

{ TEntidadeCategoriaProduto<T> }

constructor TEntidadeCategoriaProduto<T>.Create(Parent: T);
begin
  FParent := Parent;
end;

destructor TEntidadeCategoriaProduto<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeCategoriaProduto<T>.New(Parent: T): iEntidadeCategoriaProduto<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeCategoriaProduto<T>.Id(Value: Integer): iEntidadeCategoriaProduto<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeCategoriaProduto<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeCategoriaProduto<T>.IdEmpresa(Value: Integer): iEntidadeCategoriaProduto<T>;
begin
  Result := Self;
  FIdEmpresa := Value;
end;

function TEntidadeCategoriaProduto<T>.IdEmpresa: Integer;
begin
  Result := FIdEmpresa;
end;

function TEntidadeCategoriaProduto<T>.IdUsuario(Value: Integer): iEntidadeCategoriaProduto<T>;
begin
  Result := Self;
  FIdUsuario := Value;
end;

function TEntidadeCategoriaProduto<T>.IdUsuario: Integer;
begin
  Result := FIdUsuario;
end;

function TEntidadeCategoriaProduto<T>.NomeCategoria(Value: String): iEntidadeCategoriaProduto<T>;
begin
  Result := Self;
  FNomeCategoria := Value;
end;

function TEntidadeCategoriaProduto<T>.NomeCategoria: String;
begin
  Result := FNomeCategoria;
end;

function TEntidadeCategoriaProduto<T>.DataHoraEmissao(Value: TDateTime): iEntidadeCategoriaProduto<T>;
begin
  Result := Self;
  FDataHoraEmissao := Value;
end;

function TEntidadeCategoriaProduto<T>.DataHoraEmissao: TDateTime;
begin
  Result := FDataHoraEmissao;
end;

function TEntidadeCategoriaProduto<T>.Ativo(Value: Integer): iEntidadeCategoriaProduto<T>;
begin
  Result := Self;
  FAtivo := Value;
end;

function TEntidadeCategoriaProduto<T>.Ativo: Integer;
begin
  Result := FAtivo;
end;

function TEntidadeCategoriaProduto<T>.&End: T;
begin
  Result := FParent;
end;

end.
