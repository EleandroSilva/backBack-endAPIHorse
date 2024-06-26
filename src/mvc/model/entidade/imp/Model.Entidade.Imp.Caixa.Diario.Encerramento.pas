{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 22/04/2024 12:08           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Caixa.Diario.Encerramento;

interface

uses
  Model.Entidade.Caixa.Diario.Encerramento.Interfaces,
  Model.Entidade.Usuario.Interfaces;

type
  TEntidadeCaixaDiarioEncerramento<T : iInterface> = class(TInterfacedObject, iEntidadeCaixaDiarioEncerramento<T>)
    private
      [weak]
      FParent          : T;
      FId              : Integer;
      FIdCaixaDiario   : Integer;
      FIdUsuario       : Integer;
      FValorLancamento : Currency;
      FDataHoraEmissao : TDateTime;
      FObservacao      : String;
      FUsuario         : iEntidadeUsuario<iEntidadeCaixaDiarioEncerramento<T>>;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T) : iEntidadeCaixaDiarioEncerramento<T>;

      function Id              (Value : Integer)   : iEntidadeCaixaDiarioEncerramento<T>; overload;
      function Id                                  : Integer;                             overload;
      function IdCaixaDiario   (Value : Integer)   : iEntidadeCaixaDiarioEncerramento<T>; overload;
      function IdCaixaDiario                       : Integer;                             overload;
      function IdUsuario       (Value : Integer)   : iEntidadeCaixaDiarioEncerramento<T>; overload;
      function IdUsuario                           : Integer;                             overload;
      function ValorLancamento (Value : Currency)  : iEntidadeCaixaDiarioEncerramento<T>; overload;
      function ValorLancamento                     : Currency;                            overload;
      function DataHoraEmissao (Value : TDateTime) : iEntidadeCaixaDiarioEncerramento<T>; overload;
      function DataHoraEmissao                     : TDateTime;                           overload;
      function Observacao      (Value : String)    : iEntidadeCaixaDiarioEncerramento<T>; overload;
      function Observacao                          : String;                              overload;

      //Inje��o de depend�ncia
      function Usuario  : iEntidadeUsuario<iEntidadeCaixaDiarioEncerramento<T>>;

      function &End : T;
  end;

implementation

{ TEntidadeCaixaDiarioEncerramento<T> }

constructor TEntidadeCaixaDiarioEncerramento<T>.Create(Parent: T);
begin
  FParent := Parent;
end;

destructor TEntidadeCaixaDiarioEncerramento<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeCaixaDiarioEncerramento<T>.New(Parent: T): iEntidadeCaixaDiarioEncerramento<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeCaixaDiarioEncerramento<T>.Id(Value: Integer): iEntidadeCaixaDiarioEncerramento<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeCaixaDiarioEncerramento<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeCaixaDiarioEncerramento<T>.IdCaixaDiario(Value: Integer): iEntidadeCaixaDiarioEncerramento<T>;
begin
  Result := Self;
  FIdCaixaDiario := Value;
end;

function TEntidadeCaixaDiarioEncerramento<T>.IdCaixaDiario: Integer;
begin
  Result := FIdCaixaDiario;
end;

function TEntidadeCaixaDiarioEncerramento<T>.IdUsuario(Value: Integer): iEntidadeCaixaDiarioEncerramento<T>;
begin
  Result := Self;
  FIdUsuario := Value;
end;

function TEntidadeCaixaDiarioEncerramento<T>.IdUsuario: Integer;
begin
  Result := FIdUsuario;
end;

function TEntidadeCaixaDiarioEncerramento<T>.ValorLancamento(Value: Currency): iEntidadeCaixaDiarioEncerramento<T>;
begin
  Result := Self;
  FValorLancamento := Value;
end;

function TEntidadeCaixaDiarioEncerramento<T>.ValorLancamento: Currency;
begin
  Result := FValorLancamento;
end;

function TEntidadeCaixaDiarioEncerramento<T>.DataHoraEmissao(Value: TDateTime): iEntidadeCaixaDiarioEncerramento<T>;
begin
  Result := Self;
  FDataHoraEmissao := Value;
end;

function TEntidadeCaixaDiarioEncerramento<T>.DataHoraEmissao: TDateTime;
begin
  Result := FDataHoraEmissao;
end;

function TEntidadeCaixaDiarioEncerramento<T>.Observacao(Value: String): iEntidadeCaixaDiarioEncerramento<T>;
begin
  Result := Self;
  FObservacao := Value;
end;

function TEntidadeCaixaDiarioEncerramento<T>.Observacao: String;
begin
  Result := FObservacao;
end;

//Inje��o de depend�ncia
function TEntidadeCaixaDiarioEncerramento<T>.Usuario: iEntidadeUsuario<iEntidadeCaixaDiarioEncerramento<T>>;
begin
  Result := FUsuario
end;

function TEntidadeCaixaDiarioEncerramento<T>.&End: T;
begin
  Result := FParent;
end;

end.
