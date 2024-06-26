{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Email.Empresa;

interface

uses
  Model.Entidade.Email.Empresa.Interfaces;
type
  TEntidadeEmailEmpresa<T : iInterface> = class(TInterfacedObject, iEntidadeEmailEmpresa<T>)
    private
      [Weak]
      FParent    : T;
      FId        : Integer;
      FIdEmpresa : Integer;
      FEmail     : String;
      FTipoEmail : String;
      FAtivo     : Integer;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T) : iEntidadeEmailEmpresa<T>;

      function Id       (Value : Integer) : iEntidadeEmailEmpresa<T>; overload;
      function Id                         : Integer;                  overload;
      function IdEmpresa(Value : Integer) : iEntidadeEmailEmpresa<T>; overload;
      function IdEmpresa                  : Integer;                  overload;
      function Email    (Value : String)  : iEntidadeEmailEmpresa<T>; overload;
      function Email                      : String;                   overload;
      function TipoEmail(Value : String)  : iEntidadeEmailEmpresa<T>; overload;
      function TipoEmail                  : String;                   overload;
      function Ativo    (Value : Integer) : iEntidadeEmailEmpresa<T>; overload;
      function Ativo                      : Integer;                  overload;

      function &End : T;
    end;

implementation

{ TEntidadeEmailEmpresa<T> }

constructor TEntidadeEmailEmpresa<T>.Create(Parent: T);
begin
  FParent := Parent;
end;

destructor TEntidadeEmailEmpresa<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeEmailEmpresa<T>.New(Parent: T): iEntidadeEmailEmpresa<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeEmailEmpresa<T>.Id(Value: Integer): iEntidadeEmailEmpresa<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeEmailEmpresa<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeEmailEmpresa<T>.IdEmpresa(Value: Integer): iEntidadeEmailEmpresa<T>;
begin
  Result := Self;
  FIdEmpresa := Value;
end;

function TEntidadeEmailEmpresa<T>.IdEmpresa: Integer;
begin
  Result := FIdEmpresa;
end;

function TEntidadeEmailEmpresa<T>.Email(Value: String): iEntidadeEmailEmpresa<T>;
begin
  Result := Self;
  FEmail := Value;
end;

function TEntidadeEmailEmpresa<T>.Email: String;
begin
  Result := FEmail;
end;

function TEntidadeEmailEmpresa<T>.TipoEmail(Value: String): iEntidadeEmailEmpresa<T>;
begin
  Result := Self;
  FTipoEmail := Value;
end;

function TEntidadeEmailEmpresa<T>.TipoEmail: String;
begin
  Result := FTipoEmail;
end;

function TEntidadeEmailEmpresa<T>.Ativo(Value: Integer): iEntidadeEmailEmpresa<T>;
begin
  Result := Self;
  FAtivo := Value;
end;

function TEntidadeEmailEmpresa<T>.Ativo: Integer;
begin
  Result := FAtivo;
end;

function TEntidadeEmailEmpresa<T>.&End: T;
begin
  Result := FParent;
end;

end.
