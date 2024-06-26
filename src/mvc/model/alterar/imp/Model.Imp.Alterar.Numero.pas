{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 01/05/2024 11:37           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Alterar.Numero;

interface

uses
  Data.DB,
  System.SysUtils,
  System.JSON,

  Model.Alterar.Numero.Interfaces,
  Model.Entidade.Numero.Interfaces,
  Controller.Interfaces,
  Model.Entidade.Empresa.Interfaces;

type
  TAlterarNumero = class(TInterfacedObject, iAlterarNumero)
    private
      FController : iController;
      FNumero     : iEntidadeNumero<iAlterarNumero>;
      FEmpresa    : iEntidadeEmpresa<iAlterarNumero>;
      FDSNumero   : TDataSource;

      FJSONObjectPai : TJSONObject;
      FJSONObject    : TJSONObject;
      FJSONArray     : TJSONArray;

      FIdNumero : Integer;
      FFound : Boolean;
      FError : Boolean;
      procedure CadastrarEnderecoEmpresa;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iAlterarNumero;

      function JSONObjectPai(Value : TJSONObject) : iAlterarNumero; overload;
      function JSONObjectPai                      : TJSONObject;    overload;
      function Put    : iAlterarNumero;
      function Found  : Boolean;
      function Error  : Boolean;

      //inje��o de depend�ncia
      function Numero  : iEntidadeNumero<iAlterarNumero>;
      function Empresa : iEntidadeEmpresa<iAlterarNumero>;
      function &End    : iAlterarNumero;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Numero,
  Model.Entidade.Imp.Empresa;

{ TAlterarNumero }

constructor TAlterarNumero.Create;
begin
  FController := TController.New;
  FNumero     := TEntidadeNumero<iAlterarNumero>.New(Self);
  FEmpresa    := TEntidadeEmpresa<iAlterarNumero>.New(Self);
  FDSNumero   := TDataSource.Create(nil);

  FFound := False;
  FError := False;
end;

destructor TAlterarNumero.Destroy;
begin
  inherited;
end;

class function TAlterarNumero.New: iAlterarNumero;
begin
  Result := Self.Create;
end;

function TAlterarNumero.JSONObjectPai(Value: TJSONObject): iAlterarNumero;
begin
  Result := Self;
  FJSONObjectPai := Value;
end;

function TAlterarNumero.JSONObjectPai: TJSONObject;
begin
  Result := FJSONObjectPai;
end;

function TAlterarNumero.Put: iAlterarNumero;
begin
  FJSONObject := TJSONObject(FJSONObjectPai.GetValue('numero'));
  try
    FController
      .FactoryDAO
        .DAONumero
          .This
            .Id                 (FJSONObject.GetValue<Integer>('id'))
            .IdEndereco         (FNumero.IdEndereco)
            .NumeroEndereco     (FJSONObject.GetValue<String>('numeroendereco'))
            .ComplementoEndereco(FJSONObject.GetValue<String>('complementoendereco'))
          .&End
        .Put;

    //Inserindo o numero com idempresa, caso n�o existir-esta tabela n�o altera, apenas inclui caso n�o existir
    CadastrarEnderecoEmpresa;
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar alterar n�mero da tabela numero: ' + E.Message);
      FError := True;
    end;
  end;
end;

function TAlterarNumero.Found: Boolean;
begin
  Result := FFound;
end;

function TAlterarNumero.Error: Boolean;
begin
  Result := FError;
end;

procedure TAlterarNumero.CadastrarEnderecoEmpresa;
begin
  FController
    .FactoryCadastrar
      .CadastrarEnderecoEmpresa
        .EnderecoEmpresa
          .IdEmpresa(FEmpresa.Id)
          .IdEndereco(FNumero.IdEndereco)
        .&End
      .JSONObjectPai(FJSONObject)
      .Post;
end;

//Inje��o de depend�mcia
function TAlterarNumero.Numero: iEntidadeNumero<iAlterarNumero>;
begin
  Result := FNumero;
end;

function TAlterarNumero.Empresa: iEntidadeEmpresa<iAlterarNumero>;
begin
  Result := FEmpresa;
end;

function TAlterarNumero.&End: iAlterarNumero;
begin
  Result := Self;
end;

end.
