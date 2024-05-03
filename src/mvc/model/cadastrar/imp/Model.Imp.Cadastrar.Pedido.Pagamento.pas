{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 03/05/2024 14:31           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Cadastrar.Pedido.Pagamento;

interface

uses
  Data.DB,
  System.SysUtils,
  System.JSON,
  DataSet.Serialize,

  Model.Cadastrar.Pedido.Pagamento.Interfaces,
  Controller.Interfaces,
  Model.Entidade.Pedido.Pagamento.Interfaces;

type
  TCadastrarPedidoPagamento = class(TInterfacedObject, iCadastrarPedidoPagamento)
    private
      FController      : iController;
      FPedidoPagamento : iEntidadePedidoPagamento<iCadastrarPedidoPagamento>;
      FDSPedidoPagamento : TDataSource;

      FJSONObjectPai : TJSONObject;
      FJSONArray     : TJSONArray;
      FJSONObject    : TJSONObject;
      FError : Boolean;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iCadastrarPedidoPagamento;

      function JSONObjectPai(Value : TJSONObject) : iCadastrarPedidoPagamento; overload;
      function JSONObjectPai                      : TJSONObject;               overload;
      function Post   : iCadastrarPedidoPagamento;
      function Error  : Boolean;
      //inje��o de depend�ncia
      function PedidoPagamento : iEntidadePedidoPagamento<iCadastrarPedidoPagamento>;
      function &End : iCadastrarPedidoPagamento;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Pedido.Pagamento;

{ TCadastrarPedidoPagamento }

constructor TCadastrarPedidoPagamento.Create;
begin
  FController        := TController.New;;
  FPedidoPagamento   := TEntidadePedidoPagamento<iCadastrarPedidoPagamento>.New(Self);
  FDSPedidoPagamento := TDataSource.Create(nil);
end;

destructor TCadastrarPedidoPagamento.Destroy;
begin
  inherited;
end;


function TCadastrarPedidoPagamento.JSONObjectPai(Value: TJSONObject): iCadastrarPedidoPagamento;
begin
  Result := Self;
  FJSONObjectPai := Value;
end;

function TCadastrarPedidoPagamento.JSONObjectPai: TJSONObject;
begin
  Result := FJSONObjectPai;
end;

class function TCadastrarPedidoPagamento.New: iCadastrarPedidoPagamento;
begin
  Result := Self.Create;
end;

function TCadastrarPedidoPagamento.Post: iCadastrarPedidoPagamento;
Var
  I : Integer;
begin
  //Obt�m os dados JSON do corpo da requisi��o da tabela('pedidopagamento')
  FJSONArray := FJSONObjectPai.GetValue('pedidopagamento') as TJSONArray;
  // Loop inserindo pedidopagamento(ns)
  for I := 0 to FJSONArray.Count - 1 do
  begin
    //Extraindo os dados do pagamento do pedido e salvando os dados na tabela
    FJSONObject := FJSONArray.Items[I] as TJSONObject;
    try
      FController
        .FactoryDAO
          .DAOPedidoPagamento
            .This
              .IdPedido      (FPedidoPagamento.IdPedido)
              .DataVencimento(FJSONObject.GetValue<TDateTime>('datavencimento'))
              .ValorParcela  (FJSONObject.GetValue<Currency> ('valorparcela'))
            .&End
          .Post;
    except
      on E: Exception do
      begin
        WriteLn('Erro ao tentar incluir itens do pedido: ' + E.Message);
        //caso ocorrer algum erro no lan�amento do item, excluo o pedido lan�ado
        FController
          .FactoryDAO
            .DAOPessoa
              .This
                .Id(FPedidoPagamento.IdPedido)
              .&End
            .Delete;
            Exit;
        FError := True;
      end;
    end;
  end;
end;

function TCadastrarPedidoPagamento.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TCadastrarPedidoPagamento.PedidoPagamento: iEntidadePedidoPagamento<iCadastrarPedidoPagamento>;
begin
  Result := FPedidoPagamento;
end;

function TCadastrarPedidoPagamento.&End: iCadastrarPedidoPagamento;
begin
  Result := Self;
end;

end.