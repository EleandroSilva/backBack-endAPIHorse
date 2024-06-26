{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 01/05/2024 14:52           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Pesquisar.Telefone.Empresa;

interface

uses
  Data.DB,
  System.JSON,
  System.SysUtils,

  DataSet.Serialize,
  Model.Pesquisar.Telefone.Empresa.Interfaces,
  Model.Entidade.Telefone.Empresa.Interfaces,
  Controller.Interfaces;

type
  TPesquisarTelefoneEmpresa = class(TInterfacedObject, iPesquisarTelefoneEmpresa)
    private
      FController : iController;
      FTelefoneEmpresa   : iEntidadeTelefoneEmpresa<iPesquisarTelefoneEmpresa>;
      FDSTelefoneEmpresa : TDataSource;

      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;

      FFound : Boolean;
      FError : Boolean;

      FQuantidadeRegistro : Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iPesquisarTelefoneEmpresa;

      function GetBy(IdEmpresa : Integer; DDD, NumeroTelefone: String) :iPesquisarTelefoneEmpresa;
      function LoopTelefoneEmpresa : TJSONValue;
      function Found : Boolean;
      function Error : Boolean;

      //inje��o de depend�ncia
      function TelefoneEmpresa : iEntidadeTelefoneEmpresa<iPesquisarTelefoneEmpresa>;
      function &End : iPesquisarTelefoneEmpresa;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Telefone.Empresa;

{ TPesquisarNumero }

constructor TPesquisarTelefoneEmpresa.Create;
begin
  FController := TController.New;
  FTelefoneEmpresa   := TEntidadeTelefoneEmpresa<iPesquisarTelefoneEmpresa>.New(Self);
  FDSTelefoneEmpresa := TDataSource.Create(nil);

  FFound := False;
  FError := False;
end;

destructor TPesquisarTelefoneEmpresa.Destroy;
begin
  inherited;
end;

class function TPesquisarTelefoneEmpresa.New: iPesquisarTelefoneEmpresa;
begin
  Result := Self.Create;
end;

function TPesquisarTelefoneEmpresa.GetBy(IdEmpresa: Integer; DDD, NumeroTelefone: String): iPesquisarTelefoneEmpresa;
begin
  Result := Self;
  FController
    .FactoryDAO
      .DAOTelefoneEmpresa
        .This
          .IdEmpresa(IdEmpresa)
          .NumeroTelefone(NumeroTelefone)
        .&End
      .GetbyParams
      .DataSet(FDSTelefoneEmpresa);
  FFound := Not FDSTelefoneEmpresa.DataSet.IsEmpty;
end;

//loop para carregar os telefones da tabela para json da empresa
function TPesquisarTelefoneEmpresa.LoopTelefoneEmpresa: TJSONValue;
begin
   FQuantidadeRegistro:= FController
                           .FactoryDAO
                              .DAOTelefoneEmpresa
                                .GetbyId(FTelefoneEmpresa.IdEmpresa)
                              .DataSet(FDSTelefoneEmpresa)
                              .QuantidadeRegistro;

  if not FDSTelefoneEmpresa.DataSet.IsEmpty then
  begin
    FJSONArray := TJSONArray.Create;//JSONArray

    FDSTelefoneEmpresa.DataSet.First;
    while not FDSTelefoneEmpresa.DataSet.Eof do
    begin
      FJSONObject := TJSONObject.Create;//JSONObject
      FJSONObject := FDSTelefoneEmpresa.DataSet.ToJSONObject;
      Result := FJSONObject;
      // Se tiver mais de um registro, adiciona ao array
      if FQuantidadeRegistro > 1 then
      begin
        FJSONArray.Add(FJSONObject);
        Result := FJSONArray;
      end;
      FDSTelefoneEmpresa.DataSet.Next;
    end;
  end;
end;

function TPesquisarTelefoneEmpresa.Found: Boolean;
begin
  Result := FFound;
end;

function TPesquisarTelefoneEmpresa.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TPesquisarTelefoneEmpresa.TelefoneEmpresa: iEntidadeTelefoneEmpresa<iPesquisarTelefoneEmpresa>;
begin
  Result := FTelefoneEmpresa;
end;

function TPesquisarTelefoneEmpresa.&End: iPesquisarTelefoneEmpresa;
begin
  Result := Self;
end;

end.
