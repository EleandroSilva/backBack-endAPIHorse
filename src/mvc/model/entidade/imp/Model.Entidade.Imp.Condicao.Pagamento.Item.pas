{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 22/04/2024 12:08           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.Entidade.Imp.Condicao.Pagamento.Item;

interface

uses
  Model.Entidade.Condicao.Pagamento.Item.Interfaces;

type
  TEntidadeCondicaoPagamentoItem<T : iInterface> = class(TInterfacedObject, iEntidadeCondicaoPagamentoItem<T>)
    private
      [weak]
      FParent              : T;
      FId                  : Integer;
      FIdCondicaoPagamento : Integer;
      FNumeroPagamento     : Integer;
      FQuantidadeDias      : Integer;
    public
      constructor Create(Parent : T);
      destructor Destroy; override;
      class function New(Parent : T ) : iEntidadeCondicaoPagamentoItem<T>;

      function Id                 (Value : Integer) : iEntidadeCondicaoPagamentoItem<T>; overload;
      function Id                                   : Integer;                           overload;
      function IdCondicaoPagamento(Value : Integer) : iEntidadeCondicaoPagamentoItem<T>; overload;
      function IdCondicaoPagamento                  : Integer;                           overload;
      function NumeroPagamento    (Value : Integer) : iEntidadeCondicaoPagamentoItem<T>; overload;
      function NumeroPagamento                      : Integer;                           overload;
      function QuantidadeDias     (Value : Integer) : iEntidadeCondicaoPagamentoItem<T>; overload;
      function QuantidadeDias                       : Integer;                           overload;

      function &End : T;
  end;

implementation

{ TEntidadeCondicaoPagamentoItem<T> }

constructor TEntidadeCondicaoPagamentoItem<T>.Create(Parent: T);
begin
  FParent := Parent;
end;

destructor TEntidadeCondicaoPagamentoItem<T>.Destroy;
begin
  inherited;
end;

class function TEntidadeCondicaoPagamentoItem<T>.New(Parent: T): iEntidadeCondicaoPagamentoItem<T>;
begin
  Result := Self.Create(Parent);
end;

function TEntidadeCondicaoPagamentoItem<T>.Id(Value: Integer): iEntidadeCondicaoPagamentoItem<T>;
begin
  Result := Self;
  FId    := Value;
end;

function TEntidadeCondicaoPagamentoItem<T>.Id: Integer;
begin
  Result := FId;
end;

function TEntidadeCondicaoPagamentoItem<T>.IdCondicaoPagamento(Value: Integer): iEntidadeCondicaoPagamentoItem<T>;
begin
  Result := Self;
  FIdCondicaoPagamento := Value;
end;

function TEntidadeCondicaoPagamentoItem<T>.IdCondicaoPagamento: Integer;
begin
  Result := FIdCondicaoPagamento;
end;

function TEntidadeCondicaoPagamentoItem<T>.NumeroPagamento(Value: Integer): iEntidadeCondicaoPagamentoItem<T>;
begin
  Result := Self;
  FNumeroPagamento := Value;
end;

function TEntidadeCondicaoPagamentoItem<T>.NumeroPagamento: Integer;
begin
  Result := FNumeroPagamento;
end;

function TEntidadeCondicaoPagamentoItem<T>.QuantidadeDias(Value: Integer): iEntidadeCondicaoPagamentoItem<T>;
begin
  Result := Self;
  FQuantidadeDias := Value;
end;

function TEntidadeCondicaoPagamentoItem<T>.QuantidadeDias: Integer;
begin
  Result := FQuantidadeDias;
end;

function TEntidadeCondicaoPagamentoItem<T>.&End: T;
begin
  Result := FParent;
end;

end.
