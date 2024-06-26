{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 30/04/2024 14:18           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Cadastrar.Endereco;

interface

uses
  Data.DB,

  System.JSON,
  System.SysUtils,

  Model.Cadastrar.Endereco.Interfaces,
  Controller.Interfaces,
  Model.Entidade.Endereco.Interfaces,
  Model.Entidade.Empresa.Interfaces,
  Model.Entidade.Pessoa.Interfaces;

type
  TCadastrarEndereco = class(TInterfacedObject, iCadastrarEndereco)
    private
      FController  : iController;
      FEndereco    : iEntidadeEndereco<iCadastrarEndereco>;
      FEmpresa     : iEntidadeEmpresa<iCadastrarEndereco>;
      FPessoa      : iEntidadePessoa<iCadastrarEndereco>;
      FJSONArrayEndereco  : TJSONArray;
      FJSONObjectEndereco : TJSONObject;
      FJSONObjectPai      : TJSONObject;
      //
      FIdEndereco : Integer;
      FError      : Boolean;
      FDSEndereco : TDataSource;

      procedure CadastrarNumero;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iCadastrarEndereco;

      function JSONObjectPai(Value : TJSONObject) : iCadastrarEndereco; overload;
      function JSONObjectPai                      : TJSONObject;        overload;
      function Post : iCadastrarEndereco;
      function Error : Boolean;

      //inje��o de depend�ncia
      function Endereco : iEntidadeEndereco<iCadastrarEndereco>;
      function Empresa  : iEntidadeEmpresa<iCadastrarEndereco>;
      function Pessoa   : iEntidadePessoa<iCadastrarEndereco>;
      function &End : iCadastrarEndereco;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Endereco,
  Model.Entidade.Imp.Empresa,
  Model.Entidade.Imp.Pessoa;

{ TCadastrarEndereco }

constructor TCadastrarEndereco.Create;
begin
  FController := TController.New;
  FEndereco   := TEntidadeEndereco<iCadastrarEndereco>.New(Self);
  FEmpresa    := TEntidadeEmpresa<iCadastrarEndereco>.New(Self);
  FPessoa     := TEntidadePessoa<iCadastrarEndereco>.New(Self);
  FDSEndereco := TDataSource.Create(nil);
  FError      := False;
end;

destructor TCadastrarEndereco.Destroy;
begin
  inherited;
end;

class function TCadastrarEndereco.New: iCadastrarEndereco;
begin
  Result := Self.Create;
end;

function TCadastrarEndereco.JSONObjectPai(Value: TJSONObject): iCadastrarEndereco;
begin
  Result := Self;
  FJSONObjectPai := Value;
end;

function TCadastrarEndereco.JSONObjectPai: TJSONObject;
begin
  Result := FJSONObjectPai;
end;

function TCadastrarEndereco.Post: iCadastrarEndereco;
Var
  I : Integer;
begin
  Result := Self;
  //Obt�m os dados JSON do corpo da requisi��o da tabela('endereco')
  FJSONArrayEndereco := FJSONObjectPai.GetValue('endereco') as TJSONArray;
  try
    // Loop do(s) endere�o(s)
    for I := 0 to FJSONArrayEndereco.Count - 1 do
    begin
      //Extraindo os dados do endere�o e salvando no banco de dados
      FJSONObjectEndereco := FJSONArrayEndereco.Items[I] as TJSONObject;
      //verificando se j� consta este cep cadastrado na tabela endereco(se n�o estiver insert o mesmo)
      if not FController
               .FactoryPesquisar
                 .PesquisarEndereco
                   .GetbyCep(FJSONObjectEndereco.GetValue<String>('cep')).Found then
      begin
        FController
          .FactoryDAO
            .DAOEndereco
              .This
                .Cep           (FJSONObjectEndereco.GetValue<String> ('cep'))
                .IBGE          (FJSONObjectEndereco.GetValue<Integer>('ibge'))
                .UF            (FJSONObjectEndereco.GetValue<String> ('uf'))
                .TipoLogradouro(FJSONObjectEndereco.GetValue<String> ('tipologradouro'))
                .Logradouro    (FJSONObjectEndereco.GetValue<String> ('logradouro'))
                .Bairro        (FJSONObjectEndereco.GetValue<String> ('bairro'))
                .GIA           (FJSONObjectEndereco.GetValue<Integer>('gia'))
                .DDD           (FJSONObjectEndereco.GetValue<String> ('ddd'))
              .&End
            .Post
            .DataSet(FDSEndereco);

        FIdEndereco := FDSEndereco.DataSet.FieldByName('id').AsInteger;
        //Chamo function para cadastrar numero do endereco, caso n�o existir
        CadastrarNumero;
      end;
    end;
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar alterar cadastrar endere�o na tabela endereco: ' + E.Message);
      FError := True;
    end;
  end;
end;

//Cadastrar Numero
procedure TCadastrarEndereco.CadastrarNumero;
begin
  FController
    .FactoryCadastrar
      .CadastrarNumero
        .Empresa
          .Id(FEmpresa.Id)
        .&End
        .Numero
          .IdEndereco(FIdEndereco)
        .&End
      .JSONObjectPai(FJSONObjectEndereco)
      .Post;
end;

function TCadastrarEndereco.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TCadastrarEndereco.Endereco: iEntidadeEndereco<iCadastrarEndereco>;
begin
  Result := FEndereco;
end;


function TCadastrarEndereco.Empresa: iEntidadeEmpresa<iCadastrarEndereco>;
begin
  Result := FEmpresa;
end;

function TCadastrarEndereco.Pessoa: iEntidadePessoa<iCadastrarEndereco>;
begin
  Result := FPessoa;
end;

function TCadastrarEndereco.&End: iCadastrarEndereco;
begin
  Result := Self;
end;

end.
