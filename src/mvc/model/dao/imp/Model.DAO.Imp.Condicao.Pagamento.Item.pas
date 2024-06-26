{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 24/04/2024 14:24           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Condicao.Pagamento.Item;

interface

uses
  Data.DB,
  Uteis, System.SysUtils,

  Uteis.Tratar.Mensagens,

  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces,
  Model.DAO.Condicao.Pagamento.Item.Interfaces,
  Model.Entidade.Condicao.Pagamento.Item.Interfaces;
type
  TDAOCondicaoPagamentoItem = class(TInterfacedObject, iDAOCondicaoPagamentoItem)
    private
      FCondicaoPagamentoItem : iEntidadeCondicaoPagamentoItem<iDAOCondicaoPagamentoItem>;
      FConexao : iConexao;
      FQuery   : iQuery;
      FMSG     : TMensagens;
      FDataSet : TDataSet;

      const
        FSQL= ('select '+
               'cpi.id, '+
               'cpi.idcondicaopagamento, '+
               'cpi.numeropagamento, '+
               'cpi.quantidadedias '+
               'from condicaopagamentoitem cpi '
               );
      function LoopRegistro (Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOCondicaoPagamentoItem;

      function DataSet    (DataSource : TDataSource) : iDAOCondicaoPagamentoItem; overload;
      function DataSet                               : TDataSet;                  overload;
      function GetAll                                : iDAOCondicaoPagamentoItem;
      function GetbyId    (Id : Variant)             : iDAOCondicaoPagamentoItem; overload;
      function GetbyId    (IdParent : Integer)       : iDAOCondicaoPagamentoItem; overload;
      function GetbyParams                           : iDAOCondicaoPagamentoItem; overload;
      function Post                                  : iDAOCondicaoPagamentoItem;
      function Put                                   : iDAOCondicaoPagamentoItem;
      function Delete                                : iDAOCondicaoPagamentoItem;

      function QuantidadeRegistro : Integer;
      function This : iEntidadeCondicaoPagamentoItem<iDAOCondicaoPagamentoItem>;
  end;

implementation

uses
  Model.Entidade.Imp.Condicao.Pagamento.Item,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

constructor TDAOCondicaoPagamentoItem.Create;
begin
  FCondicaoPagamentoItem  := TEntidadeCondicaoPagamentoItem<iDAOCondicaoPagamentoItem>.New(Self);
  FConexao := TModelConexaoFiredacMySQL.New;
  FQuery   := TQuery.New;
  FMSG     := TMensagens.Create;
end;

destructor TDAOCondicaoPagamentoItem.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOCondicaoPagamentoItem.New: iDAOCondicaoPagamentoItem;
begin
  Result := Self.Create;
end;

function TDAOCondicaoPagamentoItem.DataSet(DataSource: TDataSource): iDAOCondicaoPagamentoItem;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOCondicaoPagamentoItem.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOCondicaoPagamentoItem.GetAll: iDAOCondicaoPagamentoItem;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOCondicaoPagamentoItem.GetAll -ao tentar encontrar condicaopagamentoitem todos: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FCondicaoPagamentoItem.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FCondicaoPagamentoItem.Id(0);
end;

function TDAOCondicaoPagamentoItem.GetbyId(Id: Variant): iDAOCondicaoPagamentoItem;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where cpi.Id=:Id')
                    .Params('Id', Id)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOCondicaoPagamentoItem.GetId -ao tentar encontrar condicaopagamentoitem por Id: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FCondicaoPagamentoItem.Id(FDataSet.FieldByName('id').AsInteger)
    else
    FCondicaoPagamentoItem.Id(0);
end;

function TDAOCondicaoPagamentoItem.GetbyId(IdParent: Integer): iDAOCondicaoPagamentoItem;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where cpi.idcondicaopagamento.Id=:idcondicaopagamento')
                    .Params('idcondicaopagamento', IdParent)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOCondicaoPagamentoItem.GetId -ao tentar encontrar condicaopagamentoitem por IdParent: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FCondicaoPagamentoItem.Id(FDataSet.FieldByName('id').AsInteger)
    else
    FCondicaoPagamentoItem.Id(0);
end;

function TDAOCondicaoPagamentoItem.GetbyParams: iDAOCondicaoPagamentoItem;
begin
  {analisar como vai ficar este filtro
  Result := Self;
  try
   try
     FDataSet := FQuery
                   .SQL(FSQL)
                   .Add('where cpi.idcondicaopagamento=:idcondicaopagamento')
                   .Params('idcondicaopagamento', FCondicaoPagamentoItem.IdCondicaoPagamento)
                   .Open
                 .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
    begin
      FCondicaoPagamentoItem.Id(FDataSet.FieldByName('id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FCondicaoPagamentoItem.Id(0);
  end;
  }
end;

function TDAOCondicaoPagamentoItem.Post: iDAOCondicaoPagamentoItem;
const
  LSQL=('insert into condicaopagamentoitem('+
                                       'idcondicaopagamento, '+
                                       'numeropagamento, '+
                                       'quantidadedias '+
                                      ')'+
                                       ' values '+
                                      '('+
                                       ':idcondicaopagamento, '+
                                       ':numeropagamento, '+
                                       ':quantidadedias '+
                                      ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('idcondicaopagamento' , FCondicaoPagamentoItem.IdCondicaoPagamento)
        .Params('numeropagamento'     , FCondicaoPagamentoItem.NumeroPagamento)
        .Params('quantidadedias'      , FCondicaoPagamentoItem.QuantidadeDias)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOCondicaoPagamentoItem.Post -ao tentar incluir condicaopagamentoitem: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
    FDataSet := FQuery
                    .SQL('select LAST_INSERT_ID () as id')
                    .Open
                    .DataSet;
    FCondicaoPagamentoItem.Id(FDataSet.FieldByName('id').AsInteger);
end;

function TDAOCondicaoPagamentoItem.Put: iDAOCondicaoPagamentoItem;
const
  LSQL=('update condicaopagamentoitem set '+
                                       'numeropagamento    =:numeropagamento, '+
                                       'quantidadedias     =:quantidadedias'+
                                       'where            id=:id '+
                                       'and idcondicaopagamento=:idcondicaopagamento '
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('id'                  , FCondicaoPagamentoItem.Id)
        .Params('idcondicaopagamento' , FCondicaoPagamentoItem.IdCondicaoPagamento)
        .Params('numeropagamento'     , FCondicaoPagamentoItem.NumeroPagamento)
        .Params('quantidadedias'      , FCondicaoPagamentoItem.QuantidadeDias)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOCondicaoPagamentoItem.Put -ao tentar alterar condicaopagamentoitem: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOCondicaoPagamentoItem.Delete: iDAOCondicaoPagamentoItem;
const
  LSQL=('delete from condicaopagamentoitem where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    FQuery.SQL(LSQL)
                .Params('id', FCondicaoPagamentoItem.Id)
              .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOCondicaoPagamentoItem.Delete -ao tentar exlu�r condicaopagamentoitem: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOCondicaoPagamentoItem.LoopRegistro(Value : Integer): Integer;
begin
  FDataSet.First;
  try
    while not FDataSet.Eof do
    begin
      Value := Value + 1;
      FDataSet.Next;
    end;
  finally
    Result := Value;
  end;
end;

function TDAOCondicaoPagamentoItem.QuantidadeRegistro : Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOCondicaoPagamentoItem.This: iEntidadeCondicaoPagamentoItem<iDAOCondicaoPagamentoItem>;
begin
  Result := FCondicaoPagamentoItem;
end;

end.
