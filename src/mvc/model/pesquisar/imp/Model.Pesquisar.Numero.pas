{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 01/05/2024 14:07           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Pesquisar.Numero;

interface

uses
  Data.DB,
  System.JSON,
  System.SysUtils,

  DataSet.Serialize,
  Model.Pesquisar.Numero.Interfaces,
  Model.Entidade.Numero.Interfaces,
  Controller.Interfaces;

type
  TPesquisarNumero = class(TInterfacedObject, iPesquisarNumero)
    private
      FController : iController;
      FNumero     : iEntidadeNumero<iPesquisarNumero>;
      FDSNumero   : TDataSource;

      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;

      FFound : Boolean;
      FError : Boolean;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iPesquisarNumero;
      function Getby(IdEndereco : Integer; NumeroEndereco : String) : iPesquisarNumero;
      function Found : Boolean;
      function Error : Boolean;

      function Numero : iEntidadeNumero<iPesquisarNumero>;
      function &End   : iPesquisarNumero;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Numero;

{ TPesquisarNumero }

constructor TPesquisarNumero.Create;
begin
  FController := TController.New;
  FNumero     := TEntidadeNumero<iPesquisarNumero>.New(Self);
  FDSNumero   := TDataSource.Create(nil);

  FFound := False;
  FError := False;
end;

destructor TPesquisarNumero.Destroy;
begin
  inherited;
end;

class function TPesquisarNumero.New: iPesquisarNumero;
begin
  Result := Self.Create;
end;

function TPesquisarNumero.Getby(IdEndereco: Integer; NumeroEndereco: String): iPesquisarNumero;
begin
  Result := Self;
  FFound := False;
  try
    FController
      .FactoryDAO
        .DAONumero
          .This
            .IdEndereco    (IdEndereco)
            .NumeroEndereco(NumeroEndereco)
          .&End
        .GetbyParams
        .DataSet(FDSNumero);
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar alterar n�mero da tabela numero: ' + E.Message);
      FError := True;
    end;
  end;
  FFound := not FDSNumero.DataSet.IsEmpty;
end;

function TPesquisarNumero.Found: Boolean;
begin
  Result := FFound;
end;

function TPesquisarNumero.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TPesquisarNumero.Numero: iEntidadeNumero<iPesquisarNumero>;
begin
  Result := FNumero;
end;

function TPesquisarNumero.&End: iPesquisarNumero;
begin
  Result := Self;
end;

end.
