{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 26/04/2024 16:08           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Caixa.Pedido;

interface

uses
  Model.Entidade.Caixa.Pedido.Interfaces;

type
  TEntidadeCaixaPedido<T : iInterface> = class(TInterfacedObject, iEntidadeCaixaPedido<T>)
    private
      [weak]
      FParent          : T;
      FId              : Integer;
      FIdEmpresa       : Integer;
      FIdCaixa         : Integer;
      FIdPedido        : Integer;
      FIdUsuario       : Integer;
      FDataHoraEmissao : TDateTime;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T) : iEntidadeCaixaPedido<T>;

      function Id             (Value : Integer)   : iEntidadeCaixaPedido<T>; overload;
      function Id                                 : Integer;                 overload;
      function IdEmpresa      (Value : Integer)   : iEntidadeCaixaPedido<T>; overload;
      function IdEmpresa                          : Integer;                 overload;
      function IdCaixa        (Value : Integer)   : iEntidadeCaixaPedido<T>; overload;
      function IdCaixa                            : Integer;                 overload;
      function IdPedido       (Value : Integer)   : iEntidadeCaixaPedido<T>; overload;
      function IdPedido                           : Integer;                 overload;
      function IdUsuario      (Value : Integer)   : iEntidadeCaixaPedido<T>; overload;
      function IdUsuario                          : Integer;                 overload;
      function DataHoraEmissao(Value : TDateTime) : iEntidadeCaixaPedido<T>; overload;
      function DataHoraEmissao                    : TDateTime;               overload;

      function &End : T;
  end;

implementation

{ TEntidadeCaixaPedido<T> }

constructor TEntidadeCaixaPedido<T>.Create(Parent: T);
begin
  FParent := Parent;
end;

destructor TEntidadeCaixaPedido<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeCaixaPedido<T>.New(Parent: T): iEntidadeCaixaPedido<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeCaixaPedido<T>.Id(Value: Integer): iEntidadeCaixaPedido<T>;
begin
  Result := Self;
  FId    := FId;
end;

function TEntidadeCaixaPedido<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeCaixaPedido<T>.IdEmpresa(Value: Integer): iEntidadeCaixaPedido<T>;
begin
  Result := Self;
  FIdEmpresa := Value;
end;

function TEntidadeCaixaPedido<T>.IdEmpresa: Integer;
begin
  Result := FIdEmpresa;
end;

function TEntidadeCaixaPedido<T>.IdCaixa(Value: Integer): iEntidadeCaixaPedido<T>;
begin
  Result := Self;
  FIdCaixa := Value;
end;

function TEntidadeCaixaPedido<T>.IdCaixa: Integer;
begin
  Result := FIdCaixa;
end;

function TEntidadeCaixaPedido<T>.IdPedido(Value: Integer): iEntidadeCaixaPedido<T>;
begin
  Result := Self;
  FIdPedido := Value;
end;

function TEntidadeCaixaPedido<T>.IdPedido: Integer;
begin
  Result := FIdPedido;
end;

function TEntidadeCaixaPedido<T>.IdUsuario(Value: Integer): iEntidadeCaixaPedido<T>;
begin
  Result := Self;
  FIdUsuario := Value;
end;

function TEntidadeCaixaPedido<T>.IdUsuario: Integer;
begin
  Result := FIdUsuario;
end;

function TEntidadeCaixaPedido<T>.DataHoraEmissao(Value: TDateTime): iEntidadeCaixaPedido<T>;
begin
  Result := Self;
  FDataHoraEmissao := Value;
end;

function TEntidadeCaixaPedido<T>.DataHoraEmissao: TDateTime;
begin
  Result := FDataHoraEmissao;
end;

function TEntidadeCaixaPedido<T>.&End: T;
begin
  Result := FParent;
end;

end.
