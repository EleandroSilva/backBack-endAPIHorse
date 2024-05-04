{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 04/05/2024 11:42           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Pesquisar.Pedido.Pagamento;

interface

uses
  Data.DB,
  System.JSON,
  System.SysUtils,
  DataSet.Serialize,

  Model.Pesquisar.Pedido.Pagamento.Interfaces,
  Model.Entidade.Pedido.Pagamento.Interfaces,
  Controller.Interfaces;

type
  TPesquisarPedidoPagamento = class(TInterfacedObject, iPesquisarPedidoPagamento)
    private
      FController      : iController;
      FPedidoPagamento : iEntidadePedidoPagamento<iPesquisarPedidoPagamento>;
      FDSPedidoPagamento : TDataSource;

      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;

      FFound : Boolean;
      FError : Boolean;

      FQuantidadeRegistro : Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iPesquisarPedidoPagamento;

      function GetBy(IdPedido : Integer) : iPesquisarPedidoPagamento;
      function LoopPedidoPagamento : TJSONValue;
      function Found : Boolean;
      function Error : Boolean;

      function PedidoPagamento : iEntidadePedidoPagamento<iPesquisarPedidoPagamento>;
      function &End : iPesquisarPedidoPagamento;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Pedido.Pagamento;

{ TPesquisarPedidoPagamento }

constructor TPesquisarPedidoPagamento.Create;
begin
  FController        := TController.New;
  FPedidoPagamento   := TEntidadePedidoPagamento<iPesquisarPedidoPagamento>.New(Self);
  FDSPedidoPagamento := TDataSource.Create(nil);
  FFound := False;
  FError := False;
  FQuantidadeRegistro := 0;
end;

destructor TPesquisarPedidoPagamento.Destroy;
begin
  inherited;
end;

class function TPesquisarPedidoPagamento.New: iPesquisarPedidoPagamento;
begin
  Result := Self.Create;
end;

function TPesquisarPedidoPagamento.GetBy(IdPedido: Integer): iPesquisarPedidoPagamento;
begin
  Result := Self;
  try
    FController
      .FactoryDAO
        .DAOPedidoPagamento
          .GetbyId(IdPedido)
        .DataSet(FDSPedidoPagamento);
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar encontrar o pagamento do pedido: ' + E.Message);
      FError := True;
    end;
  end;
  FFound := Not FDSPedidoPagamento.DataSet.IsEmpty;
end;

function TPesquisarPedidoPagamento.LoopPedidoPagamento: TJSONValue;
begin
  FQuantidadeRegistro := FController
                           .FactoryDAO
                             .DAOPedidoPagamento
                               .GetbyId(FPedidoPagamento.IdPedido)
                               .DataSet(FDSPedidoPagamento)
                             .QuantidadeRegistro;

  if not FDSPedidoPagamento.DataSet.IsEmpty then
  begin
    FJSONArray := TJSONArray.Create;

    FDSPedidoPagamento.DataSet.First;
    while not FDSPedidoPagamento.DataSet.Eof do
    begin
      FJSONObject := TJSONObject.Create;
      FJSONObject := FDSPedidoPagamento.DataSet.ToJSONObject;
      Result := FJSONObject;
      //tendo mais de um registro, adiciona ao array
      if FQuantidadeRegistro > 1 then
      begin
        FJSONArray.Add(FJSONObject);
        Result := FJSONArray;
      end;
      FDSPedidoPagamento.DataSet.Next;
    end;
  end;
end;

function TPesquisarPedidoPagamento.Found: Boolean;
begin
  Result := FFound;
end;

function TPesquisarPedidoPagamento.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TPesquisarPedidoPagamento.PedidoPagamento: iEntidadePedidoPagamento<iPesquisarPedidoPagamento>;
begin
  Result := FPedidoPagamento;
end;

function TPesquisarPedidoPagamento.&End: iPesquisarPedidoPagamento;
begin
  result := Self;
end;

end.
