{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 22/04/2024 12:08           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Caixa.Diario;

interface

uses
  Model.Entidade.Caixa.Diario.Interfaces,
  Model.Entidade.Usuario.Interfaces;

type
  TEntidadeCaixaDiario<T : iInterface> = class(TInterfacedObject, iEntidadeCaixaDiario<T>)
   private
     [weak]
     FParent   : T;
     FId              : Integer;
     FIdEmpresa       : Integer;
     FIdUsuario       : Integer;
     FValorInicial    : Currency;
     FDataHoraEmissao : TDateTime;
     FStatus          : String;

     //Inje��o de depend�ncia
     FUsuario  : iEntidadeUsuario<iEntidadeCaixaDiario<T>>;//Caixa di�rio
   public
     constructor Create(Parent : T);
     destructor Destroy; override;
     class Function New(Parent : T): iEntidadeCaixaDiario<T>;

     function Id             (Value : Integer)   : iEntidadeCaixaDiario<T>; overload;
     function Id                                 : Integer;                 overload;
     function IdEmpresa      (Value : Integer)   : iEntidadeCaixaDiario<T>; overload;
     function IdEmpresa                          : Integer;                 overload;
     function IdUsuario      (Value : Integer)   : iEntidadeCaixaDiario<T>; overload;
     function IdUsuario                          : Integer;                 overload;
     function ValorInicial   (Value : Currency)  : iEntidadeCaixaDiario<T>; overload;
     function ValorInicial                       : Currency;                overload;
     function DataHoraEmissao(Value : TDateTime) : iEntidadeCaixaDiario<T>; overload;
     function DataHoraEmissao                    : TDateTime;               overload;
     function Status         (Value : String)    : iEntidadeCaixaDiario<T>; overload;
     function Status                             : String;                  overload;

     //Inje��o de depend�ncia
     function Usuario  : iEntidadeUsuario<iEntidadeCaixaDiario<T>>;
     function &End : T;
  end;

implementation

{ TCaixaDiario<T> }

constructor TEntidadeCaixaDiario<T>.Create(Parent: T);
begin
  FParent := Parent;
end;

class function TEntidadeCaixaDiario<T>.New(Parent: T): iEntidadeCaixaDiario<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeCaixaDiario<T>.DataHoraEmissao: TDateTime;
begin
  Result := FDataHoraEmissao;
end;

function TEntidadeCaixaDiario<T>.DataHoraEmissao(Value: TDateTime): iEntidadeCaixaDiario<T>;
begin
  Result := Self;
  FDataHoraEmissao := Value;
end;

destructor TEntidadeCaixaDiario<T>.Destroy;
begin
  inherited;
end;

function TEntidadeCaixaDiario<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeCaixaDiario<T>.Id(Value: Integer): iEntidadeCaixaDiario<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeCaixaDiario<T>.IdEmpresa(Value: Integer): iEntidadeCaixaDiario<T>;
begin
  Result := Self;
  FIdEmpresa := Value;
end;

function TEntidadeCaixaDiario<T>.IdEmpresa: Integer;
begin
  Result := FIdEmpresa;
end;

function TEntidadeCaixaDiario<T>.IdUsuario: Integer;
begin
  Result := FIdUsuario;
end;

function TEntidadeCaixaDiario<T>.IdUsuario(Value: Integer): iEntidadeCaixaDiario<T>;
begin
  Result := Self;
  FIdUsuario := Value;
end;

function TEntidadeCaixaDiario<T>.Status(Value: String): iEntidadeCaixaDiario<T>;
begin
  Result := self;
  FStatus := Value;
end;

function TEntidadeCaixaDiario<T>.Status: String;
begin
  Result := FStatus;
end;

function TEntidadeCaixaDiario<T>.ValorInicial(Value: Currency): iEntidadeCaixaDiario<T>;
begin
  Result := Self;
  FValorInicial := Value;
end;

function TEntidadeCaixaDiario<T>.ValorInicial: Currency;
begin
  Result := FValorInicial;
end;

//Inje��o de dep�ndencia
function TEntidadeCaixaDiario<T>.Usuario: iEntidadeUsuario<iEntidadeCaixaDiario<T>>;
begin
  Result := FUsuario;
end;

function TEntidadeCaixaDiario<T>.&End: T;
begin
  Result := FParent;
end;

end.
