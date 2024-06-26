{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 02/05/2024 13:42           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Alterar.Email.Pessoa;

interface

uses
  Data.DB,
  System.SysUtils,
  System.JSON,

  Model.Alterar.Email.Pessoa.Interfaces,
  Model.Entidade.Email.Pessoa.Interfaces,
  Controller.Interfaces;

type
  TAlterarEmailPessoa = class(TInterfacedObject, iAlterarEmailPessoa)
    private
      FController    : iController;
      FEmailPessoa   : iEntidadeEmailPessoa<iAlterarEmailPessoa>;
      FDSEmailPessoa : TDataSource;

      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;

      FFound : Boolean;
      FError : Boolean;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iAlterarEmailPessoa;

      function JSONObject(Value : TJSONObject) : iAlterarEmailPessoa; overload;
      function JSONObject                      : TJSONObject;         overload;
      function Put    : iAlterarEmailPessoa;
      function Found  : Boolean;
      function Error  : Boolean;

      //inje��o de depend�ncia
      function EmailPessoa : iEntidadeEmailPessoa<iAlterarEmailPessoa>;
      function &End        : iAlterarEmailPessoa;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Email.Pessoa;

{ TAlterarEmailPessoa }

constructor TAlterarEmailPessoa.Create;
begin
  FController    := TController.New;
  FEmailPessoa   := TEntidadeEmailPessoa<iAlterarEmailPessoa>.New(Self);
  FDSEmailPessoa := TDataSource.Create(nil);
  FFound := False;
  FError := False;
end;

destructor TAlterarEmailPessoa.Destroy;
begin
  inherited;
end;

class function TAlterarEmailPessoa.New: iAlterarEmailPessoa;
begin
  Result := Self.Create;
end;

function TAlterarEmailPessoa.JSONObject(Value: TJSONObject): iAlterarEmailPessoa;
begin
  Result := Self;
  FJSONObject := Value;
end;

function TAlterarEmailPessoa.JSONObject: TJSONObject;
begin
  Result := FJSONObject;
end;

function TAlterarEmailPessoa.Put: iAlterarEmailPessoa;
Var
  I : Integer;
begin
  //Obt�m os dados JSON do corpo da requisi��o da tabela('emailPessoa')
  FJSONArray := FJSONObject.Get('emailpessoa').JsonValue as TJSONArray;
  try
    //Loop emails
    for I := 0 to FJSONArray.Count - 1 do
    begin
      //Extraindo os dados do(s) emai(s)  e salvando no banco de dados
      FJSONObject :=  FJSONArray.Items[I] as TJSONObject;
      FController
        .FactoryDAO
          .DAOEmailPessoa
            .This
              .Id       (FJSONObject .GetValue<Integer>('id'))
              .IdEmpresa(FEmailPessoa.IdEmpresa)
              .IdPessoa (FEmailPessoa.IdPessoa)
              .Email    (FJSONObject .GetValue<String> ('email'))
              .TipoEmail(FJSONObject .GetValue<String> ('tipoemail'))
              .Ativo    (FJSONObject .GetValue<Integer>('ativo'))
            .&End
          .Put;
    end;
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar alterar o registro: ' + E.Message);
      FError := True;
    end;
  end;
end;

function TAlterarEmailPessoa.Found: Boolean;
begin
  Result := FFound;
end;

function TAlterarEmailPessoa.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TAlterarEmailPessoa.EmailPessoa: iEntidadeEmailPessoa<iAlterarEmailPessoa>;
begin
  Result := FEmailPessoa;
end;

function TAlterarEmailPessoa.&End: iAlterarEmailPessoa;
begin
  Result := Self;
end;

end.
