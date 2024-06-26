{*******************************************************}
{                    API PDV - JSON                     }
{                      ES Sistemas                      }
{          In�cio do projeto 05/04/2024 09:19           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2004/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Count;

interface

Uses
  Data.DB,

  System.SysUtils,

  Uteis,
  Uteis.Tratar.Mensagens,

  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp,
  Model.DAO.Count.Interfaces;

type
  TDAOCount = class(TInterfacedObject, iDAOCount)
    private
      FConexao     : iConexao;
      FQuery       : iQuery;
      FDataSet     : TDataSet;
      FUteis       : TUteis;
      FNomeTabela  : String;
      FNomeColuna  : String;
      FValorColuna : String;
      FIdEmpresa   : Integer;

      FKey     : String;
      FValue   : String;

      FQuantidadeRegistro : Integer;

    const
       FSQLCount=('select count(*) as quantidaderegistro ');

      procedure FiltroKey;
      function  FiltroValue(Value : String) : String;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOCount;

      function DataSet    (DataSource : TDataSource) : iDAOCount; overload;
      function DataSet                               : TDataSet;  overload;
      function NomeTabela (Value : String)           : iDAOCount; overload;
      function NomeTabela                            : String;    overload;
      function NomeColuna (Value : String)           : iDAOCount; overload;
      function NomeColuna                            : String;    overload;
      function ValorColuna(Value : String)           : iDAOCount; overload;
      function ValorColuna                           : String;    overload;
      function IdEmpresa  (Value : Integer)          : iDAOCount; overload;
      function IdEmpresa                             : Integer;   overload;
      function QuantidadeRegistro                    : Integer;

      function GetCount                                                    : iDAOCount; overload;
      function GetCount(Coluna : String; Value: Integer)                   : iDAOCount; overload;
      function GetCount(Coluna, Coluna1 : String; Value : Integer; Value1 : String) : iDAOCount; overload;
      function GetCount(Coluna, Coluna1, Coluna2 : String; Value : Integer; Value1, Value2 : String) : iDAOCount; overload;
   end;

implementation

{ TDAOCount }

constructor TDAOCount.Create;
begin
  FConexao := TModelConexaoFiredacMySQL.New;
  FQuery   := TQuery.New;
  FUteis   := TUteis.Create;
end;

destructor TDAOCount.Destroy;
begin
  FreeAndNil(FUteis);
  inherited;
end;

class function TDAOCount.New: iDAOCount;
begin
  Result := Self.Create;
end;

procedure TDAOCount.FiltroKey;
begin
  if FNomeColuna<>'' then FKey := FNomeColuna;

  FValue := FiltroValue(FKey);
end;

function TDAOCount.FiltroValue(Value : String) : String;
begin
  Result := '';
  Result := FNomeColuna;
end;

function TDAOCount.DataSet(DataSource: TDataSource): iDAOCount;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOCount.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOCount.NomeTabela(Value: String): iDAOCount;
begin
  Result := Self;
  FNomeTabela := Value;
end;

function TDAOCount.NomeTabela: String;
begin
  Result := FNomeTabela;
end;

function TDAOCount.QuantidadeRegistro: Integer;
begin
  Result := FQuantidadeRegistro;
end;

function TDAOCount.NomeColuna(Value: String): iDAOCount;
begin
  Result := Self;
  FNomeColuna := Value;
end;

function TDAOCount.NomeColuna: String;
begin
  Result := FNomeColuna;
end;

function TDAOCount.ValorColuna(Value: String): iDAOCount;
begin
  Result := Self;
  FValorColuna := Value;
end;

function TDAOCount.ValorColuna: String;
begin
  Result := FValorColuna;
end;

function TDAOCount.GetCount : iDAOCount;
var
  lContar : Integer;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FValorColuna)
                    .Open
                  .DataSet;
    except
     raise Exception.Create('erro interno no servidor');
    end;
  finally
    if not FDataSet.IsEmpty then
    begin
      lContar := 0;
      FDataSet.First;
      while not FDataSet.Eof do
      begin
        lContar := lContar + 1;
        FDataSet.Next;
      end;
      FQuantidadeRegistro := lContar;
    end;
  end;
end;

function TDAOCount.GetCount(Coluna : String; Value: Integer) : iDAOCount;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQLCount+'from '+NomeTabela+' ')
                  .Add('where '+Coluna+'=:'+Coluna+' ')
                  .Params(Coluna,IntToStr(Value))
                  .Open
                .DataSet;
  finally
    if not FDataSet.IsEmpty then
      FQuantidadeRegistro := FDataSet.FieldByName('quantidaderegistro').AsInteger;
  end;
end;

function TDAOCount.GetCount(Coluna, Coluna1 : String; Value : Integer; Value1 : String) : iDAOCount;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQLCount+'from '+NomeTabela+' ')
                  .Add('where '+Coluna +'=:'+Coluna+' ')
                  .Add('and   '+Coluna1+'=:'+Coluna1+' ')
                  .Params(Coluna,''+IntToStr(Value)+' ')
                  .Params(Coluna1,FUteis.Pesquisar(Coluna1, ';' + Value1))
                  .Open
                .DataSet;
  finally
    if not FDataSet.IsEmpty then
      FQuantidadeRegistro := FDataSet.FieldByName('quantidaderegistro').AsInteger;
  end;
end;

function TDAOCount.GetCount(Coluna, Coluna1, Coluna2 : String; Value : Integer; Value1, Value2 : String) : iDAOCount;
begin
  Result := Self;
  try
    {
    FDataSet := FQuery
                  .SQL(FSQLCount+'from '+NomeTabela+' ')
                  .Add('where '+Key1+'=:'+Key1+' ')
                  .Add('and   '+Key2+'=:'+Key2+' ')
                  .Add('and   '+Key3+'=:'+Key3+' ')
                  .Params(Key1,''+Value1+' ')
                  .Params(Key2,''+Value2+' ')
                  .Params(Key3,''+Value3+' ')
                  .Open
                .DataSet;
                }
  finally
    if not FDataSet.IsEmpty then
      FQuantidadeRegistro := FDataSet.FieldByName('quantidaderegistro').AsInteger;
  end;
end;

function TDAOCount.IdEmpresa(Value: Integer): iDAOCount;
begin
  Result := Self;
  FIdEmpresa := Value;
end;

function TDAOCount.IdEmpresa: Integer;
begin
  Result := FIdEmpresa;
end;

end.
