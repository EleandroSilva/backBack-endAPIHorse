{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 02/05/2024 13:42           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Alterar.Pessoa;

interface

uses
  Data.DB,
  System.JSON,
  System.SysUtils,

  Model.Alterar.Pessoa.Interfaces,
  Model.Entidade.Pessoa.Interfaces,
  Controller.Interfaces,
  Model.Entidade.Endereco.Interfaces;

type
  TAlterarPessoa = class(TInterfacedObject, iAlterarPessoa)
    private
      FController : iController;
      FPessoa     : iEntidadePessoa<iAlterarPessoa>;
      FEndereco   : iEntidadeEndereco<iAlterarPessoa>;
      FDSPessoa   : TDataSource;
      FJSONObject : TJSONObject;
      FFound : Boolean;
      FError : Boolean;

      function AlterarEndereco : Boolean;
      function AlterarEmail    : Boolean;
      function AlterarTelefone : Boolean;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iAlterarPessoa;

      function JSONObject(Value : TJSONObject) : iAlterarPessoa; overload;
      function JSONObject                      : TJSONObject;    overload;

      function Put   : iAlterarPessoa;
      function Found : Boolean;
      function Error : Boolean;

      //inje��o de depend�ncia
      function Pessoa   : iEntidadePessoa<iAlterarPessoa>;
      function Endereco : iEntidadeEndereco<iAlterarPessoa>;
      function &End     : iAlterarPessoa;
  end;

implementation

uses
  Model.Entidade.Imp.Pessoa,
  Imp.Controller,
  Model.Entidade.Imp.Endereco;

{ TAlterarPessoa }
constructor TAlterarPessoa.Create;
begin
  FController := TController.New;
  FPessoa     := TEntidadePessoa  <iAlterarPessoa>.New(Self);
  FEndereco   := TEntidadeEndereco<iAlterarPessoa>.New(Self);
  FDSPessoa   := TDataSource.Create(nil);

  FFound := False;
  FError := False;
end;

destructor TAlterarPessoa.Destroy;
begin
  inherited;
end;

class function TAlterarPessoa.New: iAlterarPessoa;
begin
  Result := Self.Create;
end;

function TAlterarPessoa.JSONObject(Value: TJSONObject): iAlterarPessoa;
begin
  Result := Self;
  FJSONObject := Value;
end;

function TAlterarPessoa.JSONObject: TJSONObject;
begin
  Result := FJSONObject;
end;

function TAlterarPessoa.Put: iAlterarPessoa;
begin
  Result := Self;
  if not FController
          .FactoryPesquisar
            .PesquisarPessoa
              .GetbyId(FPessoa.Id)
                .Found then
  begin
    try
      FController
        .FactoryDAO
          .DAOPessoa
            .This
              .Id             (FJSONObject.GetValue<Integer>  ('id'))
              .IdEmpresa      (FJSONObject.GetValue<Integer>  ('idempresa'))
              .IdUsuario      (FJSONObject.GetValue<Integer>  ('idusuario'))
              .CPFCNPJ        (FJSONObject.GetValue<String>   ('cpfcnpj'))
              .RGIE           (FJSONObject.GetValue<String>   ('rgie'))
              .NomePessoa     (FJSONObject.GetValue<String>   ('nomepessoa'))
              .SobreNome      (FJSONObject.GetValue<String>   ('sobrenome'))
              .FisicaJuridica (FJSONObject.GetValue<String>   ('fisicajuridica'))
              .Sexo           (FJSONObject.GetValue<String>   ('sexo'))
              .TipoPessoa     (FJSONObject.GetValue<String>   ('tipopessoa'))
              .DataHoraEmissao(FJSONObject.GetValue<TDateTime>('dataemissao'))
              .DataNascimento (FJSONObject.GetValue<TDateTime>('datanascimento'))
              .Ativo          (FJSONObject.GetValue<Integer>  ('ativo'))
            .&End
          .Put
          .DataSet(FDSPessoa);
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

function TAlterarPessoa.Error: Boolean;
begin
  Result := FError;
end;

function TAlterarPessoa.Found: Boolean;
begin
  Result := FFound;
end;

//Alterar endereco
function TAlterarPessoa.AlterarEndereco: Boolean;
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
function TAlterarPessoa.AlterarEmail: Boolean;
begin
  //Obt�m os dados JSON do corpo da requisi��o da tabela('emailPessoa')
  Result := False;
  Result := FController
              .FactoryAlterar
                .AlterarEmailPessoa
                  .EmailPessoa
                    .IdPessoa(FPessoa.Id)
                  .&End
                .JSONObject(FJSONObject)
                .Put
                .Error;
end;

//Alterar Telefone
function TAlterarPessoa.AlterarTelefone: Boolean;
begin
  //Obt�m os dados JSON do corpo da requisi��o da tabela('emailPessoa')
  Result := False;
  Result := FController
              .FactoryAlterar
                .AlterarTelefonePessoa
                  .TelefonePessoa
                  .IdPessoa(FPessoa.Id)
                  .&End
                .JSONObject(FJSONObject)
                .Put
                .Error;
end;

//Inje��o de depend�ncia
function TAlterarPessoa.Pessoa: iEntidadePessoa<iAlterarPessoa>;
begin
  Result := FPessoa;
end;

function TAlterarPessoa.Endereco: iEntidadeEndereco<iAlterarPessoa>;
begin
  Result := FEndereco;
end;

function TAlterarPessoa.&End: iAlterarPessoa;
begin
  Result := Self;
end;

end.
