{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Empresa;

interface

uses
  Model.Entidade.Empresa.Interfaces,
  Model.Entidade.Endereco.Empresa.Interfaces,
  Model.Entidade.Email.Empresa.Interfaces,
  Model.Entidade.Telefone.Empresa.Interfaces,
  Model.Entidade.Natureza.Juridica.Interfaces;

type
  TEntidadeEmpresa<T : iInterface> = class(TInterfacedObject, iEntidadeEmpresa<T>)
    private
      [weak]
      FParent                : T;
      FId                    : Integer;
      FCNPJ                  : String;
      FInscricaoEstadual     : String;
      FNomeEmpresarial       : String;
      FNomeFantasia          : String;
      FIdNaturezaJuridica    : Integer;
      FDataHoraEmissao       : TDateTime;
      FDataSituacaoCadastral : TDateTime;
      FAtivo                 : Integer;

      //Inje��o de depend�ncia
      FEnderecoEmpresa  : iEntidadeEnderecoEmpresa <iEntidadeEmpresa<T>>;//EnderecoEmpresa
      FEmailEmpresa     : iEntidadeEmailEmpresa    <iEntidadeEmpresa<T>>;//EmailEmpresa
      FTelefoneEmpresa  : iEntidadeTelefoneEmpresa <iEntidadeEmpresa<T>>;//TeledoneEmpresa
      FNaturezaJuridica : iEntidadeNaturezaJuridica<iEntidadeEmpresa<T>>;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T) : iEntidadeEmpresa<T>;

      function Id                   (Value : Integer)   : iEntidadeEmpresa<T>; overload;
      function Id                                       : Integer;             overload;
      function CNPJ                 (Value : String)    : iEntidadeEmpresa<T>; overload;
      function CNPJ                                     : String;              overload;
      function InscricaoEstadual    (Value : String)    : iEntidadeEmpresa<T>; overload;
      function InscricaoEstadual                        : String;              overload;
      function NomeEmpresarial      (Value : String)    : iEntidadeEmpresa<T>; overload;
      function NomeEmpresarial                          : String;              overload;
      function NomeFantasia         (Value : String)    : iEntidadeEmpresa<T>; overload;
      function NomeFantasia                             : String;              overload;
      function IdNaturezaJuridica   (Value : Integer)   : iEntidadeEmpresa<T>; overload;
      function IdNaturezaJuridica                       : Integer;             overload;
      function DataHoraEmissao      (Value : TDateTime) : iEntidadeEmpresa<T>; overload;
      function DataHoraEmissao                          : TDateTime;           overload;
      function DataSituacaoCadastral(Value : TDateTime) : iEntidadeEmpresa<T>; overload;
      function DataSituacaoCadastral                    : TDateTime;           overload;
      function Ativo                (Value : Integer)   : iEntidadeEmpresa<T>; overload;
      function Ativo                                    : Integer;             overload;

      //Inje��o de depend�ncia
      function EnderecoEmpresa  : iEntidadeEnderecoEmpresa <iEntidadeEmpresa<T>>;
      function EmailEmpresa     : iEntidadeEmailEmpresa    <iEntidadeEmpresa<T>>;
      function TelefoneEmpresa  : iEntidadeTelefoneEmpresa <iEntidadeEmpresa<T>>;
      function NaturezaJuridica : iEntidadeNaturezaJuridica<iEntidadeEmpresa<T>>;

      function &End : T;
  end;

implementation

uses
  Model.Entidade.Imp.Endereco.Empresa,
  Model.Entidade.Imp.Email.Empresa,
  Model.Entidade.Imp.Telefone.Empresa,
  Model.Entidade.Imp.Natureza.Juridica;

{ TEntidadeEmpresa<T> }

constructor TEntidadeEmpresa<T>.Create(Parent: T);
begin
  FParent           := Parent;
  FEnderecoEmpresa  := TEntidadeEnderecoEmpresa <iEntidadeEmpresa<T>>.New(Self);
  FEmailEmpresa     := TEntidadeEmailEmpresa    <iEntidadeEmpresa<T>>.New(Self);
  FTelefoneEmpresa  := TEntidadeTelefoneEmpresa <iEntidadeEmpresa<T>>.New(Self);
  FNaturezaJuridica := TEntidadeNaturezaJuridica<iEntidadeEmpresa<T>>.New(Self);
end;

destructor TEntidadeEmpresa<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeEmpresa<T>.New(Parent: T): iEntidadeEmpresa<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeEmpresa<T>.Id(Value: Integer): iEntidadeEmpresa<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeEmpresa<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeEmpresa<T>.CNPJ(Value: String): iEntidadeEmpresa<T>;
begin
  Result := Self;
  FCNPJ  := Value;
end;

function TEntidadeEmpresa<T>.CNPJ: String;
begin
  Result := FCNPJ;
end;

function TEntidadeEmpresa<T>.InscricaoEstadual(Value: String): iEntidadeEmpresa<T>;
begin
  Result := Self;
  FInscricaoEstadual := Value;
end;

function TEntidadeEmpresa<T>.InscricaoEstadual: String;
begin
  Result := FInscricaoEstadual;
end;

function TEntidadeEmpresa<T>.NomeEmpresarial(Value: String): iEntidadeEmpresa<T>;
begin
  Result := Self;
  FNomeEmpresarial := Value;
end;

function TEntidadeEmpresa<T>.NomeEmpresarial: String;
begin
  Result := FNomeEmpresarial;
end;

function TEntidadeEmpresa<T>.NomeFantasia(Value: String): iEntidadeEmpresa<T>;
begin
  Result := Self;
  FNomeFantasia := Value;
end;

function TEntidadeEmpresa<T>.NomeFantasia: String;
begin
  Result := FNomeFantasia;
end;

function TEntidadeEmpresa<T>.IdNaturezaJuridica(Value: Integer): iEntidadeEmpresa<T>;
begin
  Result := Self;
  FIdNaturezaJuridica := Value;
end;

function TEntidadeEmpresa<T>.IdNaturezaJuridica: Integer;
begin
  Result := FIdNaturezaJuridica;
end;

function TEntidadeEmpresa<T>.DataHoraEmissao(Value: TDateTime): iEntidadeEmpresa<T>;
begin
  Result := Self;
  FDataHoraEmissao := Value;
end;

function TEntidadeEmpresa<T>.DataHoraEmissao: TDateTime;
begin
  Result := FDataHoraEmissao;
end;

function TEntidadeEmpresa<T>.DataSituacaoCadastral(Value: TDateTime): iEntidadeEmpresa<T>;
begin
  Result := Self;
  FDataSituacaoCadastral := Value;
end;

function TEntidadeEmpresa<T>.DataSituacaoCadastral: TDateTime;
begin
  Result := FDataSituacaoCadastral;
end;

function TEntidadeEmpresa<T>.Ativo(Value: Integer): iEntidadeEmpresa<T>;
begin
  Result := Self;
  FAtivo := Value;
end;

function TEntidadeEmpresa<T>.Ativo: Integer;
begin
  Result := FAtivo;
end;

//Inje��o de depend�ncia
function TEntidadeEmpresa<T>.EnderecoEmpresa: iEntidadeEnderecoEmpresa<iEntidadeEmpresa<T>>;
begin
  Result := FEnderecoEmpresa;
end;

function TEntidadeEmpresa<T>.EmailEmpresa: iEntidadeEmailEmpresa<iEntidadeEmpresa<T>>;
begin
  Result := FEmailEmpresa;
end;

function TEntidadeEmpresa<T>.TelefoneEmpresa: iEntidadeTelefoneEmpresa<iEntidadeEmpresa<T>>;
begin
  Result := FTelefoneEmpresa;
end;

function TEntidadeEmpresa<T>.NaturezaJuridica: iEntidadeNaturezaJuridica<iEntidadeEmpresa<T>>;
begin
  Result := FNaturezaJuridica;
end;

function TEntidadeEmpresa<T>.&End: T;
begin
  Result := FParent;
end;

end.
