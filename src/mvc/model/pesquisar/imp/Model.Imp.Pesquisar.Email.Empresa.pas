{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 01/05/2024 11:37           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Pesquisar.Email.Empresa;

interface

uses
  Data.DB,
  System.JSON,
  System.SysUtils,

  DataSet.Serialize,
  Model.Pesquisar.Email.Empresa.Interfaces,
  Model.Entidade.Email.Empresa.Interfaces,
  Controller.Interfaces;

type
  TPesquisarEmailEmpresa = class(TInterfacedObject, iPesquisarEmailEmpresa)
    private
      FController     : iController;
      FEmailEmpresa   : iEntidadeEmailEmpresa<iPesquisarEmailEmpresa>;
      FDSEmailEmpresa : TDataSource;

      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;

      FFound : Boolean;
      FError : Boolean;

      FQuantidadeRegistro : Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iPesquisarEmailEmpresa;

      function GetBy(IdEmpresa : Integer; Email: String) : iPesquisarEmailEmpresa;
      function LoopEmailEmpresa : TJSONValue;
      function Found : Boolean;
      function Error : Boolean;

      function EmailEmpresa : iEntidadeEmailEmpresa<iPesquisarEmailEmpresa>;
      function &End  : iPesquisarEmailEmpresa;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Email.Empresa;

{ TPesquisarEmailEmpresa }

constructor TPesquisarEmailEmpresa.Create;
begin
  FController     := TController.New;
  FEmailEmpresa   := TEntidadeEmailEmpresa<iPesquisarEmailEmpresa>.New(Self);
  FDSEmailEmpresa := TDataSource.Create(nil);

  FFound := False;
  FError := False;
end;

destructor TPesquisarEmailEmpresa.Destroy;
begin
  inherited;
end;

class function TPesquisarEmailEmpresa.New: iPesquisarEmailEmpresa;
begin
  Result := Self.Create;
end;

function TPesquisarEmailEmpresa.GetBy(IdEmpresa: Integer; Email: String): iPesquisarEmailEmpresa;
begin
  Result := Self;
  try
    FController
      .FactoryDAO
        .DAOEmailEmpresa
          .This
            .IdEmpresa(IdEmpresa)
            .Email(Email)
          .&End
        .GetbyParams
        .DataSet(FDSEmailEmpresa);
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar encontrar o email da empresa: ' + E.Message);
      FError := True;
    end;
  end;
  FFound := Not FDSEMailEmpresa.DataSet.IsEmpty;
end;

//Loop para pegar email relacionado com a tabela empresa
function TPesquisarEmailEmpresa.LoopEmailEmpresa: TJSONValue;
begin
  FQuantidadeRegistro:= FController
                           .FactoryDAO
                             .DAOEmailEmpresa
                               .GetbyId(FEmailEmpresa.IdEmpresa)
                             .DataSet(FDSEmailEmpresa)
                             .QuantidadeRegistro;

  if not FDSEmailEmpresa.DataSet.IsEmpty then
  begin
    FJSONArray := TJSONArray.Create;
    FDSEmailEmpresa.DataSet.First;
    while not FDSEmailEmpresa.DataSet.Eof do
    begin
      FJSONObject := TJSONObject.Create;
      FJSONObject := FDSEmailEmpresa.DataSet.ToJSONObject;
      Result := FJSONObject;
      //tendo mais de um registro, adiciona ao array
      if FQuantidadeRegistro > 1 then
      begin
        FJSONArray.Add(FJSONObject);
        Result := FJSONArray;
      end;
      FDSEmailEmpresa.DataSet.Next;
    end;
  end;
end;

function TPesquisarEmailEmpresa.Found: Boolean;
begin
  Result := FFound;
end;

function TPesquisarEmailEmpresa.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TPesquisarEmailEmpresa.EmailEmpresa: iEntidadeEmailEmpresa<iPesquisarEmailEmpresa>;
begin
  Result := FEmailEmpresa;
end;

function TPesquisarEmailEmpresa.&End: iPesquisarEmailEmpresa;
begin
  Result := Self;
end;


end.
