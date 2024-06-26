{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 05/04/2024 09:19           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2004/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Telefone.Empresa;

interface

uses
  Model.Entidade.Telefone.Empresa.Interfaces;

type
  TEntidadeTelefoneEmpresa<T : iInterface> = class(TInterfacedObject, iEntidadeTelefoneEmpresa<T>)
    private
      [weak]
      FParent         : T;
      FId             : Integer;
      FIdEmpresa      : Integer;
      FOperadora      : String;
      FDDD            : String;
      FNumeroTelefone : String;
      FTipoTelefone   : String;
      FAtivo          : Integer;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T) : iEntidadeTelefoneEmpresa<T>;

      function Id            (Value : Integer) : iEntidadeTelefoneEmpresa<T>; overload;
      function Id                              : Integer;                     overload;
      function IdEmpresa     (Value : Integer) : iEntidadeTelefoneEmpresa<T>; overload;
      function IdEmpresa                       : Integer;                     overload;
      function Operadora     (Value : String)  : iEntidadeTelefoneEmpresa<T>; overload;
      function Operadora                       : String;                      overload;
      function DDD           (Value : String)  : iEntidadeTelefoneEmpresa<T>; overload;
      function DDD                             : String;                      overload;
      function NumeroTelefone(Value : String)  : iEntidadeTelefoneEmpresa<T>; overload;
      function NumeroTelefone                  : String;                      overload;
      function TipoTelefone  (Value : String)  : iEntidadeTelefoneEmpresa<T>; overload;
      function TipoTelefone                    : String;                      overload;
      function Ativo         (Value : Integer) : iEntidadeTelefoneEmpresa<T>; overload;
      function Ativo                           : Integer;                     overload;

      function &End : T;
  end;

implementation

{ TEntidadeTelefoneEmpresa<T> }

constructor TEntidadeTelefoneEmpresa<T>.Create(Parent: T);
begin
  FParent := Parent;
end;

destructor TEntidadeTelefoneEmpresa<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeTelefoneEmpresa<T>.New(Parent: T): iEntidadeTelefoneEmpresa<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeTelefoneEmpresa<T>.Id(Value: Integer): iEntidadeTelefoneEmpresa<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeTelefoneEmpresa<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeTelefoneEmpresa<T>.IdEmpresa(Value: Integer): iEntidadeTelefoneEmpresa<T>;
begin
  Result := Self;
  FIdEmpresa := Value;
end;

function TEntidadeTelefoneEmpresa<T>.IdEmpresa: Integer;
begin
  Result := FIdEmpresa;
end;

function TEntidadeTelefoneEmpresa<T>.Operadora(Value: String): iEntidadeTelefoneEmpresa<T>;
begin
  Result := Self;
  FOperadora := Value;
end;

function TEntidadeTelefoneEmpresa<T>.Operadora: String;
begin
  Result := FOperadora;
end;

function TEntidadeTelefoneEmpresa<T>.DDD(Value: String): iEntidadeTelefoneEmpresa<T>;
begin
  Result := Self;
  FDDD   := Value;
end;

function TEntidadeTelefoneEmpresa<T>.DDD: String;
begin
  Result := FDDD;
end;

function TEntidadeTelefoneEmpresa<T>.NumeroTelefone(Value: String): iEntidadeTelefoneEmpresa<T>;
begin
  Result := Self;
  FNumeroTelefone := Value;
end;

function TEntidadeTelefoneEmpresa<T>.NumeroTelefone: String;
begin
  Result := FNumeroTelefone;
end;

function TEntidadeTelefoneEmpresa<T>.TipoTelefone(Value: String): iEntidadeTelefoneEmpresa<T>;
begin
  Result := Self;
  FTipoTelefone := Value;
end;

function TEntidadeTelefoneEmpresa<T>.TipoTelefone: String;
begin
  Result := FTipoTelefone;
end;

function TEntidadeTelefoneEmpresa<T>.Ativo(Value: Integer): iEntidadeTelefoneEmpresa<T>;
begin
  Result := Self;
  FAtivo := Value;
end;

function TEntidadeTelefoneEmpresa<T>.Ativo: Integer;
begin
  Result := FAtivo;
end;

function TEntidadeTelefoneEmpresa<T>.&End: T;
begin
  Result := FParent;
end;

end.
