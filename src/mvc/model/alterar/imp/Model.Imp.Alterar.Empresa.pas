{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 26/04/2024 17:41           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Alterar.Empresa;

interface

uses
  Data.DB,
  System.JSON,
  System.SysUtils,

  Model.Alterar.Empresa.Interfaces,
  Model.Entidade.Empresa.Interfaces,
  Controller.Interfaces,
  Model.Entidade.Endereco.Interfaces;

type
  TAlterarEmpresa = class(TInterfacedObject, iAlterarEmpresa)
    private
      FController : iController;
      FEmpresa    : iEntidadeEmpresa<iAlterarEmpresa>;
      FEndereco   : iEntidadeEndereco<iAlterarEmpresa>;
      FDSEmpresa  : TDataSource;
      FJSONObject : TJSONObject;
      FFound : Boolean;
      FError : Boolean;

      function AlterarEndereco   : Boolean;
      function AlterarEmail      : Boolean;
      function AlterarTelefone   : Boolean;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iAlterarEmpresa;

      function JSONObject(Value : TJSONObject) : iAlterarEmpresa; overload;
      function JSONObject                      : TJSONObject;     overload;

      function Put    : iAlterarEmpresa;
      function Found  : Boolean;
      function Error  : Boolean;

      //inje��o de depend�ncia
      function Empresa  : iEntidadeEmpresa<iAlterarEmpresa>;
      function Endereco : iEntidadeEndereco<iAlterarEmpresa>;
      function &End     : iAlterarEmpresa;
  end;

implementation

uses
  Model.Entidade.Imp.Empresa,
  Imp.Controller,
  Model.Entidade.Imp.Endereco;

{ TAlterarEmpresa }
constructor TAlterarEmpresa.Create;
begin
  FController := TController.New;
  FEmpresa    := TEntidadeEmpresa <iAlterarEmpresa>.New(Self);
  FEndereco   := TEntidadeEndereco<iAlterarEmpresa>.New(Self);
  FDSEmpresa  := TDataSource.Create(nil);

  FFound := False;
  FError := False;
end;

destructor TAlterarEmpresa.Destroy;
begin
  inherited;
end;

class function TAlterarEmpresa.New: iAlterarEmpresa;
begin
  Result := Self.Create;
end;

function TAlterarEmpresa.JSONObject(Value: TJSONObject): iAlterarEmpresa;
begin
  Result := Self;
  FJSONObject := Value;
end;

function TAlterarEmpresa.JSONObject: TJSONObject;
begin
  Result := FJSONObject;
end;

function TAlterarEmpresa.Put: iAlterarEmpresa;
begin
  Result := Self;
  if not FController
          .FactoryPesquisar
            .PesquisarEmpresa
              .GetbyId(FEmpresa.Id)
                .Found then
  begin
    try
      FController
        .FactoryDAO
          .DAOEmpresa
            .This
              .Id                   (FJSONObject.GetValue<Integer>  ('id'))
              .CNPJ                 (FJSONObject.GetValue<String>   ('cnpj'))
              .InscricaoEstadual    (FJSONObject.GetValue<String>   ('inscricaoestadual'))
              .NomeEmpresarial      (FJSONObject.GetValue<String>   ('nomeempresarial'))
              .NomeFantasia         (FJSONObject.GetValue<String>   ('nomefantasia'))
              .IdNaturezaJuridica   (FJSONObject.GetValue<Integer>  ('idnaturezajuridica'))
              .DataHoraEmissao      (FJSONObject.GetValue<TDateTime>('datahoraemissao'))
              .DataSituacaoCadastral(FJSONObject.GetValue<TDateTime>('datasituacaocadastral'))
              .Ativo                (FJSONObject.GetValue<Integer>  ('ativo'))
            .&End
          .Put
          .DataSet(FDSEmpresa);
      //Chamo function para alterar--> endereco; email e telefone na sequ�ncia
      if not AlterarEndereco then
        if not AlterarEmail then
          AlterarTelefone;
    except
      on E: Exception do
      begin
        WriteLn('Erro ao tentar alterar registro: ' + E.Message);
        FError := True;
      end;
    end;
  end;
end;

function TAlterarEmpresa.Error: Boolean;
begin
  Result := FError;
end;

function TAlterarEmpresa.Found: Boolean;
begin
  Result := FFound;
end;

//Alterar endereco
function TAlterarEmpresa.AlterarEndereco: Boolean;
begin
  Result := False;
  Result := FController
              .FactoryAlterar
                .AlterarEndereco
                  .Endereco
                    .Id(FEndereco.Id)
                  .&End
                .JSONObject(FJSONObject)
                .Put
                .Error;
end;

//Alterar email
function TAlterarEmpresa.AlterarEmail: Boolean;
begin
  //Obt�m os dados JSON do corpo da requisi��o da tabela('emailempresa')
  Result := False;
  Result := FController
              .FactoryAlterar
                .AlterarEmailEmpresa
                  .EmailEmpresa
                    .IdEmpresa(FEmpresa.Id)
                  .&End
                .JSONObject(FJSONObject)
                .Put
                .Error;
end;

//Alterar Telefone
function TAlterarEmpresa.AlterarTelefone: Boolean;
begin
  //Obt�m os dados JSON do corpo da requisi��o da tabela('emailempresa')
  Result := False;
  Result := FController
              .FactoryAlterar
                .AlterarTelefoneEmpresa
                  .TelefoneEmpresa
                  .IdEmpresa(FEmpresa.Id)
                  .&End
                .JSONObject(FJSONObject)
                .Put
                .Error;
end;

//Inje��o de depend�ncia
function TAlterarEmpresa.Empresa: iEntidadeEmpresa<iAlterarEmpresa>;
begin
  Result := FEmpresa;
end;

function TAlterarEmpresa.Endereco: iEntidadeEndereco<iAlterarEmpresa>;
begin
  Result := FEndereco;
end;

function TAlterarEmpresa.&End: iAlterarEmpresa;
begin
  Result := Self;
end;

end.
