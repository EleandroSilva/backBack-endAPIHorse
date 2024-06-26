{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 30/04/2024 14:18           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Cadastrar.Telefone.Empresa;

interface

uses
  Data.DB,
  System.JSON,
  System.SysUtils,

  DataSet.Serialize,
  Controller.Interfaces,
  Model.Cadastrar.Telefone.Empresa.Interfaces,
  Model.Entidade.Telefone.Empresa.Interfaces;

type
  TCadastrarTelefoneEmpresa = class(TInterfacedObject, iCadastrarTelefoneEmpresa)
    private
      FController : iController;
      FTelefoneEmpresa    : iEntidadeTelefoneEmpresa<iCadastrarTelefoneEmpresa>;
      FJSONArrayTelefone  : TJSONArray;
      FJSONObjectTelefone : TJSONObject;
      FJSONObjectPai      : TJSONObject;

      FDSTelefoneEmpresa  : TDataSource;
      FError     : Boolean;
      FQuantidadeRegistro : Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iCadastrarTelefoneEmpresa;

      function JSONObjectPai(Value : TJSONObject) : iCadastrarTelefoneEmpresa; overload;
      function JSONObjectPai                      : TJSONObject;               overload;
      function Post : iCadastrarTelefoneEmpresa;
      function Error     : Boolean;

      //inje��o de depend�ncia
      function TelefoneEmpresa : iEntidadeTelefoneEmpresa<iCadastrarTelefoneEmpresa>;
      function &End : iCadastrarTelefoneEmpresa;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Telefone.Empresa;

{ TCadastrarTelefoneEmpresa }

constructor TCadastrarTelefoneEmpresa.Create;
begin
  FController        := TController.New;
  FTelefoneEmpresa   := TEntidadeTelefoneEmpresa<iCadastrarTelefoneEmpresa>.New(Self);
  FDSTelefoneEmpresa := TDataSource.Create(nil);

  FError := False;
end;

destructor TCadastrarTelefoneEmpresa.Destroy;
begin
  inherited;
end;

class function TCadastrarTelefoneEmpresa.New: iCadastrarTelefoneEmpresa;
begin
  Result := Self.Create;
end;

function TCadastrarTelefoneEmpresa.JSONObjectPai(Value: TJSONObject): iCadastrarTelefoneEmpresa;
begin
  Result := Self;
  FJSONObjectPai := Value;
end;

function TCadastrarTelefoneEmpresa.JSONObjectPai: TJSONObject;
begin
  Result := FJSONObjectPai;
end;

function TCadastrarTelefoneEmpresa.Post: iCadastrarTelefoneEmpresa;
Var
  I : Integer;
begin
  Result := Self;
  FJSONArrayTelefone := FJSONObjectPai.GetValue('telefoneempresa') as TJSONArray;
  try
    //Loop emails
    for I := 0 to FJSONArrayTelefone.Count - 1 do
    begin
      //Extraindo os dados do(s) emai(s)  e salvando no banco de dados
      FJSONObjectTelefone :=  FJSONArrayTelefone.Items[I] as TJSONObject;
      //verifico se consta o email que esta vindo no json. Na tabela emailempresa, se n�o existir insiro.
      if not FController
               .FactoryPesquisar
                 .PesquisarTelefoneEmpresa
                   .Getby(FTelefoneEmpresa.IdEmpresa,
                          FJSONObjectTelefone.GetValue<String>('ddd'),
                          FJSONObjectTelefone.GetValue<String>('numerotelefone')).Found Then
        FController
          .FactoryDAO
            .DAOTelefoneEmpresa
              .This
                .IdEmpresa     (FTelefoneEmpresa.IdEmpresa)
                .Operadora     (FJSONObjectTelefone.GetValue<String>('operadora'))
                .DDD           (FJSONObjectTelefone.GetValue<String>('ddd'))
                .NumeroTelefone(FJSONObjectTelefone.GetValue<String>('numerotelefone'))
                .TipoTelefone  (FJSONObjectTelefone.GetValue<String>('tipotelefone'))
                .Ativo         (1)
              .&End
            .Post;
    end;
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar incluir registro: ' + E.Message);
      FError := True;
    end;
  end;
end;

function TCadastrarTelefoneEmpresa.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TCadastrarTelefoneEmpresa.TelefoneEmpresa: iEntidadeTelefoneEmpresa<iCadastrarTelefoneEmpresa>;
begin
  Result := FTelefoneEmpresa;
end;

function TCadastrarTelefoneEmpresa.&End: iCadastrarTelefoneEmpresa;
begin
  Result := Self;
end;

end.
