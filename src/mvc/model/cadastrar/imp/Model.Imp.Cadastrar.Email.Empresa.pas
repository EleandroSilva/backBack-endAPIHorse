{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 30/04/2024 14:18           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Cadastrar.Email.Empresa;

interface

uses
  Data.DB,
  System.JSON,
  System.SysUtils,

  DataSet.Serialize,
  Controller.Interfaces,
  Model.Cadastrar.Email.Empresa.Interfaces,
  Model.Entidade.Email.Empresa.Interfaces;

type
  TCadastrarEmailEmpresa = class(TInterfacedObject, iCadastrarEmailEmpresa)
    private
      FController : iController;
      FEmailEmpresa    : iEntidadeEmailEmpresa<iCadastrarEmailEmpresa>;
      FJSONArrayEmail  : TJSONArray;
      FJSONObjectEmail : TJSONObject;
      FJSONObjectPai   : TJSONObject;

      FDSEmailEmpresa  : TDataSource;

      FError     : Boolean;
      FQuantidadeRegistro : Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iCadastrarEmailEmpresa;

      function JSONObjectPai(Value : TJSONObject) : iCadastrarEmailEmpresa; overload;
      function JSONObjectPai                      : TJSONObject;            overload;
      function Post : iCadastrarEmailEmpresa;

      function Error     : Boolean;
      //inje��o de depend�ncia
      function EmailEmpresa : iEntidadeEmailEmpresa<iCadastrarEmailEmpresa>;
      function &End         : iCadastrarEmailEmpresa;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Email.Empresa;

{ TCadastrarEmailEmpresa }

constructor TCadastrarEmailEmpresa.Create;
begin
  FController   := TController.New;
  FEmailEmpresa := TEntidadeEmailEmpresa<iCadastrarEmailEmpresa>.New(Self);
  FDSEmailEmpresa := TDataSource.Create(nil);

  FError     := False;
end;

destructor TCadastrarEmailEmpresa.Destroy;
begin
  inherited;
end;

class function TCadastrarEmailEmpresa.New: iCadastrarEmailEmpresa;
begin
  Result := Self.Create;
end;

function TCadastrarEmailEmpresa.JSONObjectPai(Value: TJSONObject): iCadastrarEmailEmpresa;
begin
  Result := Self;
  FJSONObjectPai := Value;
end;

function TCadastrarEmailEmpresa.JSONObjectPai: TJSONObject;
begin
  Result := FJSONObjectPai;
end;

function TCadastrarEmailEmpresa.Post: iCadastrarEmailEmpresa;
Var
  I : Integer;
begin
  Result := Self;
  FJSONArrayEmail := FJSONObjectPai.GetValue('emailempresa') as TJSONArray;
  try
    //Loop emails
    for I := 0 to FJSONArrayEmail.Count - 1 do
    begin
      //Extraindo os dados do(s) emai(s)  e salvando no banco de dados
      FJSONObjectEmail :=  FJSONArrayEmail.Items[I] as TJSONObject;
      //verifico se consta o email que esta vindo no json. Na tabela emailempresa, se n�o existir insiro.
      if not FController
               .FactoryPesquisar
                 .PesquisarEmailEmpresa
                 .GetBy(FEmailEmpresa.IdEmpresa , FJSONObjectEmail.GetValue<String>('email')).Found Then
        FController
          .FactoryDAO
            .DAOEmailEmpresa
              .This
                .IdEmpresa(FEmailEmpresa.IdEmpresa)
                .Email    (FJSONObjectEmail.GetValue<String>('email'))
                .TipoEmail(FJSONObjectEmail.GetValue<String>('tipoemail'))
                .Ativo    (1)
              .&End
            .Post;
    end;
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar incluir o registro: ' + E.Message);
      FError := True;
    end;
  end;
end;

function TCadastrarEmailEmpresa.EmailEmpresa: iEntidadeEmailEmpresa<iCadastrarEmailEmpresa>;
begin
  Result := FEmailEmpresa;
end;

function TCadastrarEmailEmpresa.Error: Boolean;
begin
  Result := FError;
end;

function TCadastrarEmailEmpresa.&End: iCadastrarEmailEmpresa;
begin
  Result := Self;
end;

end.
