{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 01/05/2024 19:15           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Imp.Alterar.Usuario;

interface

uses
  Data.DB,
  System.JSON,
  System.SysUtils,

  Model.Alterar.Usuario.Interfaces,
  Controller.Interfaces,
  Model.Entidade.Usuario.Interfaces;

type
  TAlterarUsuario = class(TInterfacedObject, iAlterarUsuario)
    private
      FController : iController;
      FUsuario    : iEntidadeUsuario<iAlterarUsuario>;
      FDSUsuario  : TDataSource;

      FJSONObjectPai : TJSONObject;
      FJSONObject    : TJSONObject;

      FFound : Boolean;
      FError : Boolean;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iAlterarUsuario;

      function JSONObjectPai(Value : TJSONObject) : iAlterarUsuario; overload;
      function JSONObjectPai                      : TJSONObject;     overload;
      function Put    : iAlterarUsuario;
      function Found  : Boolean;
      function Error  : Boolean;

      //inje��o de depend�ncia
      function Usuario : iEntidadeUsuario<iAlterarUsuario>;
      function &End    : iAlterarUsuario;
  end;

implementation

uses
  Imp.Controller,
  Model.Entidade.Imp.Usuario;

{ TAlterarUsuario }

constructor TAlterarUsuario.Create;
begin
  FController := TController.New;
  FUsuario    := TEntidadeUsuario<iAlterarUsuario>.New(Self);
  FDSUsuario  := TDataSource.Create(nil);

  FFound := False;
  FError := False;
end;

destructor TAlterarUsuario.Destroy;
begin
  inherited;
end;

class function TAlterarUsuario.New: iAlterarUsuario;
begin
  Result := Self.Create;
end;

function TAlterarUsuario.JSONObjectPai(Value: TJSONObject): iAlterarUsuario;
begin
  Result := Self;
  FJSONObjectPai := Value;
end;

function TAlterarUsuario.JSONObjectPai: TJSONObject;
begin
  Result := FJSONObjectPai;
end;

function TAlterarUsuario.Put: iAlterarUsuario;
begin
 FJSONObject := TJSONObject(FJSONObjectPai.GetValue('usuario'));
  try
    FController
      .FactoryDAO
        .DAOUsuario
          .This
            .Id         (FJSONObject.GetValue<Integer>('id'))
            .IdEmpresa  (FUsuario.IdEmpresa)
            .NomeUsuario(FJSONObject.GetValue<String>('numeroendereco'))
            .Email      (FJSONObject.GetValue<String>('email'))
            .Senha      (FJSONObject.GetValue<String>('complementoendereco'))
          .&End
        .Put;
  except
    on E: Exception do
    begin
      WriteLn('Erro ao tentar alterar a tabela de usu�rio: ' + E.Message);
      FError := True;
    end;
  end;
end;

function TAlterarUsuario.Found: Boolean;
begin
  Result := FFound;
end;

function TAlterarUsuario.Error: Boolean;
begin
  Result := FError;
end;

//Inje��o de depend�ncia
function TAlterarUsuario.Usuario: iEntidadeUsuario<iAlterarUsuario>;
begin
  Result := FUsuario;
end;

function TAlterarUsuario.&End: iAlterarUsuario;
begin
  Result := Self;
end;

end.
