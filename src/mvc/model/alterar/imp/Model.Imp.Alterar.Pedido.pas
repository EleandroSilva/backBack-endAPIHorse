{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 04/05/2024 11:42           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Alterar.Pedido;

interface

uses
  Data.DB,
  System.SysUtils,
  System.JSON,

  Model.Alterar.Pedido.Interfaces,
  Model.Entidade.Pedido.Interfaces,
  Controller.Interfaces;

type
  TAlterarPedido = class(TInterfacedObject, iAlterarPedido)
    private
      FController : iController;
      FPedido     : iEntidadePedido<iAlterarPedido>;
      FDSPedido   : TDataSource;
      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;

      FFound : Boolean;
      FError : Boolean;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iAlterarPedido;

      function JSONObject(Value : TJSONObject) : iAlterarPedido; overload;
      function JSONObject                      : TJSONObject;    overload;
      function Put    : iAlterarPedido;
      function Found  : Boolean;
      function Error  : Boolean;

      //inje��o de depend�ncia
      function Pedido : iEntidadePedido <iAlterarPedido>;
      function &End   : iAlterarPedido;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Pedido;

{ TAlterarPedido }

constructor TAlterarPedido.Create;
begin
  FController := TController.New;
  FPedido     := TEntidadePedido<iAlterarPedido>.New(Self);
  FDSPedido   := TDataSource.Create(nil);
  FFound := False;
  FError := False;
end;

destructor TAlterarPedido.Destroy;
begin
  inherited;
end;

class function TAlterarPedido.New: iAlterarPedido;
begin
  Result := Self.Create;
end;

function TAlterarPedido.JSONObject(Value: TJSONObject): iAlterarPedido;
begin
  Result := Self;
  FJSONObject := Value;
end;

function TAlterarPedido.JSONObject: TJSONObject;
begin
  Result := FJSONObject;
end;

function TAlterarPedido.Put: iAlterarPedido;
begin
//
end;

function TAlterarPedido.Found: Boolean;
begin
  Result := FFound;
end;

function TAlterarPedido.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TAlterarPedido.Pedido: iEntidadePedido<iAlterarPedido>;
begin
  Result := FPEdido;
end;

function TAlterarPedido.&End: iAlterarPedido;
begin
  Result := Self;
end;

end.
