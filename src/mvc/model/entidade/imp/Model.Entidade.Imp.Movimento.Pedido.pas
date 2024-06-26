{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 26/04/2024 12:00           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Movimento.Pedido;

interface

uses
  Model.Entidade.Movimento.Pedido.Interfaces,
  Model.Entidade.Pessoa.Interfaces;

type
  TEntidadeMovimentoPedido<T : iInterface> = class(TInterfacedObject, iEntidadeMovimentoPedido<T>)
    private
      [weak]
      FParent          : T;
      FId              : Integer;
      FIdEmpresa       : Integer;
      FIdPedido        : Integer;
      FIdUsuario       : Integer;
      FDataHoraEmissao : TDateTime;
      FStatus          : Integer;

      FPessoa  : iEntidadePessoa<iEntidadeMovimentoPedido<T>>;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T) : iEntidadeMovimentoPedido<T>;

      function Id             (Value: Integer)   : iEntidadeMovimentoPedido<T>; overload;
      function Id                                : Integer;                     overload;
      function IdEmpresa      (Value: Integer)   : iEntidadeMovimentoPedido<T>; overload;
      function IdEmpresa                         : Integer;                     overload;
      function IdPedido       (Value: Integer)   : iEntidadeMovimentoPedido<T>; overload;
      function IdPedido                          : Integer;                     overload;
      function IdUsuario      (Value: Integer)   : iEntidadeMovimentoPedido<T>; overload;
      function IdUsuario                         : Integer;                     overload;
      function DataHoraEmissao(Value: TDateTime) : iEntidadeMovimentoPedido<T>; overload;
      function DataHoraEmissao                   : TDateTime;                   overload;
      function Status         (Value: Integer)   : iEntidadeMovimentoPedido<T>; overload;
      function Status                            : Integer;                     overload;

      //Inje��o de depend�ncia
      function Pessoa  : iEntidadePessoa<iEntidadeMovimentoPedido<T>>;

      function &End : T;
  end;

implementation

{ TEntidadeMovimentoPedido<T> }

constructor TEntidadeMovimentoPedido<T>.Create(Parent: T);
begin
  FParent := Parent;
end;

destructor TEntidadeMovimentoPedido<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeMovimentoPedido<T>.New(Parent: T): iEntidadeMovimentoPedido<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeMovimentoPedido<T>.Id(Value: Integer): iEntidadeMovimentoPedido<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeMovimentoPedido<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeMovimentoPedido<T>.IdEmpresa(Value: Integer): iEntidadeMovimentoPedido<T>;
begin
  Result := Self;
  FIdEmpresa := Value;
end;

function TEntidadeMovimentoPedido<T>.IdEmpresa: Integer;
begin
  Result := FIdEmpresa;
end;

function TEntidadeMovimentoPedido<T>.IdPedido(Value: Integer): iEntidadeMovimentoPedido<T>;
begin
  Result := Self;
  FIdPedido := Value;
end;

function TEntidadeMovimentoPedido<T>.IdPedido: Integer;
begin
  Result := FIdPedido;
end;

function TEntidadeMovimentoPedido<T>.IdUsuario(Value: Integer): iEntidadeMovimentoPedido<T>;
begin
  Result := Self;
  FIdUsuario := Value;
end;

function TEntidadeMovimentoPedido<T>.IdUsuario: Integer;
begin
  Result := FIdUsuario;
end;

function TEntidadeMovimentoPedido<T>.DataHoraEmissao(Value: TDateTime): iEntidadeMovimentoPedido<T>;
begin
  Result := Self;
  FDataHoraEmissao := Value;
end;

function TEntidadeMovimentoPedido<T>.DataHoraEmissao: TDateTime;
begin
  Result := FDataHoraEmissao;
end;

function TEntidadeMovimentoPedido<T>.Status(Value: Integer): iEntidadeMovimentoPedido<T>;
begin
  Result := Self;
  FStatus := Value;
end;

function TEntidadeMovimentoPedido<T>.Status: Integer;
begin
  Result := FStatus;
end;

//inje��o de depend�ncia
function TEntidadeMovimentoPedido<T>.Pessoa: iEntidadePessoa<iEntidadeMovimentoPedido<T>>;
begin
  Result := FPessoa;
end;

function TEntidadeMovimentoPedido<T>.&End: T;
begin
  Result := FParent;
end;

end.
