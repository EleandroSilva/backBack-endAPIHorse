{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 03/05/2024 13:46           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Cadastrar.Pedido.Item;

interface

uses
  Data.DB,
  System.JSON,
  System.SysUtils,
  DataSet.Serialize,

  Model.Cadastrar.Pedido.Item.Interfaces,
  Model.Entidade.Pedido.Item.Interfaces,
  Controller.Interfaces;

type
  TCadastrarPedidoItem = class(TInterfacedObject, iCadastrarPedidoItem)
    private
      FController   : iController;
      FPedidoItem   : iEntidadePedidoItem<iCadastrarPedidoItem>;
      FDSPedidoItem : TDataSource;
      FError : Boolean;
      FJSONObjectPai : TJSONObject;
      FJSONArray     : TJSONArray;
      FJSONObject    : TJSONObject;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iCadastrarPedidoItem;
      function JSONObjectPai(Value : TJSONObject) : iCadastrarPedidoItem; overload;
      function JSONObjectPai                      : TJSONObject;          overload;
      function Post   : iCadastrarPedidoItem;
      function Error  : Boolean;
      //inje��o de depend�ncia
      function PedidoItem : iEntidadePedidoItem<iCadastrarPedidoItem>;
      function &End       : iCadastrarPedidoItem;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Pedido.Item;

{ TCadastrarPedidoItem }

constructor TCadastrarPedidoItem.Create;
begin
  FController   := TController.New;
  FPedidoItem   := TEntidadePedidoItem<iCadastrarPedidoItem>.New(Self);
  FDSPedidoItem := TDataSource.Create(nil);
  FError := False;
end;

destructor TCadastrarPedidoItem.Destroy;
begin
  inherited;
end;

class function TCadastrarPedidoItem.New: iCadastrarPedidoItem;
begin
  Result := Self.Create;
end;

function TCadastrarPedidoItem.JSONObjectPai(Value: TJSONObject): iCadastrarPedidoItem;
begin
  Result := Self;
  FJSONObjectPai := Value;
end;

function TCadastrarPedidoItem.JSONObjectPai: TJSONObject;
begin
  Result := FJSONObjectPai;
end;

function TCadastrarPedidoItem.Post: iCadastrarPedidoItem;
Var
  I : Integer;
begin
  //Obt�m os dados JSON do corpo da requisi��o da tabela('pedidoitem')
  FJSONArray := FJSONObjectPai.GetValue('pedidoitem') as TJSONArray;
  // Loop inserindo pedidoitem(ns)
  for I := 0 to FJSONArray.Count - 1 do
  begin
    //Extraindo os dados do pedidoitem e salvando na tabela
    FJSONObject := FJSONArray.Items[I] as TJSONObject;
    try
      FController
        .FactoryDAO
          .DAOPedidoItem
            .This
              .IdPedido         (FPedidoItem.IdPedido)
              .IdProduto        (FJSONObject.GetValue<Integer> ('idproduto'))
              .Quantidade       (FJSONObject.GetValue<Currency>('quantidade'))
              .ValorUnitario    (FJSONObject.GetValue<Currency>('valorunitario'))
              .ValorProduto     (FJSONObject.GetValue<Currency>('valorproduto'))
              .ValorDescontoItem(FJSONObject.GetValue<Currency>('valordescontoitem'))
              .ValorFinalItem   (FJSONObject.GetValue<Currency>('valorfinalitem'))
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
                .Id(FPedidoItem.IdPedido)
              .&End
            .Delete;
            Exit;
        FError := True;
      end;
    end;
  end;
end;

function TCadastrarPedidoItem.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TCadastrarPedidoItem.PedidoItem: iEntidadePedidoItem<iCadastrarPedidoItem>;
begin
  Result := FPedidoItem;
end;

function TCadastrarPedidoItem.&End: iCadastrarPedidoItem;
begin
  Result := Self;
end;

end.
