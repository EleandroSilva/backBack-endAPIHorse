{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 24/04/2024 10:41           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Condicao.Pagamento;

interface

uses
  Data.DB,
  System.SysUtils,
  Uteis.Interfaces,
  Uteis.Tratar.Mensagens,

  Model.DAO.Condicao.Pagamento.Interfaces,
  Model.Entidade.Condicao.Pagamento.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;

type
  TDAOCondicaoPagamento = class(TInterfacedObject, iDAOCondicaoPagamento)
    private
      FCondicaoPagamento : iEntidadeCondicaoPagamento<iDAOCondicaoPagamento>;
      FConexao : iConexao;
      FQuery   : iQuery;
      FDataSet : TDataSet;
      FUteis   : iUteis;
      FMSG     : TMensagens;


      const
        FSQL= ('select '+
               'cp.id, '+
               'cp.idempresa, '+
               'cp.idusuario, '+
               'cp.nomecondicaopagamento, '+
               'cp.quantidadepagamento, '+
               'cp.totaldias, '+
               'cp.prazomedio, '+
               'cp.datahoraemissao '+
               'from condicaopagamento cp '
               );
      function LoopRegistro (Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOCondicaoPagamento;

      function DataSet    (DataSource : TDataSource) : iDAOCondicaoPagamento; overload;
      function DataSet                               : TDataSet;              overload;
      function GetAll                                : iDAOCondicaoPagamento;
      function GetbyId    (Id : Variant)             : iDAOCondicaoPagamento;
      function GetbyParams                           : iDAOCondicaoPagamento; overload;
      function Post                                  : iDAOCondicaoPagamento;
      function Put                                   : iDAOCondicaoPagamento; overload;
      function Put(const iDAOCondicaoPagamento)      : iDAOCondicaoPagamento; overload;
      function Delete                                : iDAOCondicaoPagamento;

      function QuantidadeRegistro : Integer;
      function This : iEntidadeCondicaoPagamento<iDAOCondicaoPagamento>;
  end;

implementation

uses
  Uteis,
  Model.Entidade.Imp.Condicao.Pagamento,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

constructor TDAOCondicaoPagamento.Create;
begin
  FCondicaoPagamento  := TEntidadeCondicaoPagamento<iDAOCondicaoPagamento>.New(Self);
  FConexao := TModelConexaoFiredacMySQL.New;
  FQuery   := TQuery.New;
  FUteis   := TUteis.New;
  FMSG     := TMensagens.Create;
end;

destructor TDAOCondicaoPagamento.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOCondicaoPagamento.New: iDAOCondicaoPagamento;
begin
  Result := Self.Create;
end;

function TDAOCondicaoPagamento.DataSet(DataSource: TDataSource): iDAOCondicaoPagamento;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOCondicaoPagamento.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOCondicaoPagamento.GetAll: iDAOCondicaoPagamento;
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
      WriteLn('Erro no TDAOCondicaoPagamento.GetAll -ao tentar encontrar condicaopagamento todos: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FCondicaoPagamento.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FCondicaoPagamento.Id(0);
end;

function TDAOCondicaoPagamento.GetbyId(Id: Variant): iDAOCondicaoPagamento;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where cp.Id=:Id')
                    .Params('Id', Id)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOCondicaoPagamento.GetId -ao tentar encontrar condicaopagamento por Id: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FCondicaoPagamento.Id(FDataSet.FieldByName('id').AsInteger)
    else
    FCondicaoPagamento.Id(0);
end;

function TDAOCondicaoPagamento.GetbyParams: iDAOCondicaoPagamento;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL+' where ' + FUteis.Pesquisar('nomecondicaopagamento', ';' + FCondicaoPagamento.NomeCondicaoPagamento))
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOCondicaoPagamento.GetParams -ao tentar encontrar condicaopagamento por nomecondicaopagamento: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FCondicaoPagamento.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FCondicaoPagamento.Id(0);
end;

function TDAOCondicaoPagamento.Post: iDAOCondicaoPagamento;
const
  LSQL=('insert into condicaopagamento('+
                                       'idempresa, '+
                                       'idusuario, '+
                                       'nomecondicaopagamento, '+
                                       'quantidadepagamento, '+
                                       'totaldias, '+
                                       'prazomedio, '+
                                       'datahoraemissao '+
                                      ')'+
                                       ' values '+
                                      '('+
                                       ':idempresa, '+
                                       ':idusuario, '+
                                       ':nomecondicaopagamento, '+
                                       ':quantidadepagamento, '+
                                       ':totaldias, '+
                                       ':prazomedio, '+
                                       ':datahoraemissao '+
                                      ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('idempresa'             , FCondicaoPagamento.IdEmpresa)
        .Params('idusuario'             , FCondicaoPagamento.IdUsuario)
        .Params('nomecondicaopagamento' , FCondicaoPagamento.NomeCondicaoPagamento)
        .Params('quantidadepagamento'   , FCondicaoPagamento.QuantidadePagamento)
        .Params('totaldias'             , FCondicaoPagamento.TotalDias)
        .Params('prazomedio'            , FCondicaoPagamento.PrazoMedio)
        .Params('datahoraemissao'       , FCondicaoPagamento.DataHoraEmissao)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOCondicaoPagamento.Post -ao tentar incluir condicaopagamento: ' + E.Message);
      Abort;
    end;
  end;
  FConexao.Commit;
  FDataSet := FQuery
                .SQL('select LAST_INSERT_ID () as id')
                  .Open
                .DataSet;
  FCondicaoPagamento.Id(FDataSet.FieldByName('id').AsInteger);
end;

//Put para fazer atualiza��o nas colunas totaldias; prazomedio da tabela condicaopagamento
function TDAOCondicaoPagamento.Put(const iDAOCondicaoPagamento): iDAOCondicaoPagamento;
const
  LSQL=('update condicaopagamento set '+
                                  'totaldias =:totaldias, '+
                                  'prazomedio=:prazomedio, '+
                                  'where   id=:id '
       );
//procedure que faz a soma necess�ria
procedure SomarTotalDiasPrazoMedio;
const
  lSQL=('select '+
        'cp.id, '+
        'cp.nomecondicaopagamento, '+
        'cp.quantidadepagamento, '+
        'sum(cpi.quantidadedias) as totaldias, '+
        'sum(cpi.quantidadedias / cp.quantidadepagamento) as prazomedio '+
        'from condicaopagamento cp '+
        'inner join condicaopagamentoitem cpi ON cp.id = cpi.idcondicaopagamento '
        );
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(lSQL)
                    .Add('where cpi.Id=:Id')
                    .Params('Id', FCondicaoPagamento.Id)
                    .Params('group by',' 1,2,3')
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOCondicaoPagamento.Put - const iDAOCondicaoPagamento ao tentar alterar condicaopagamento: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FCondicaoPagamento.TotalDias (FDataSet.FieldByName('totaldias').AsInteger);
    FCondicaoPagamento.PrazoMedio(FDataSet.FieldByName('prazomedio').AsInteger);
  end;
end;

begin
  Result := Self;
  //ap�s salvar no controller condicaopagamento, caso n�o ocorreu nem um erro
  //prencho as coluna totaldias e prazomedio da tabela pai(condicaopagamento)
  SomarTotalDiasPrazoMedio;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('id'         , FCondicaoPagamento.Id)
        .Params('totaldias'  , FCondicaoPagamento.TotalDias)
        .Params('prazomedio' , FCondicaoPagamento.PrazoMedio)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOCondicaoPagamento.Put - const iDAOCondicaoPagamento ao tentar alterar condicaopagamento: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

//Altera��o padr�o
function TDAOCondicaoPagamento.Put: iDAOCondicaoPagamento;
const
  LSQL=('update condicaopagamento set '+
                                  'idempresa            =:idempresa, '+
                                  'idusuario            =:idusuario, '+
                                  'nomecondicaopagamento=:nomecondicaopagamento, '+
                                  'quantidadepagamento  =:quantidadepagamento, '+
                                  'totaldias            =:totaldias, '+
                                  'prazomedio           =:prazomedio, '+
                                  'where                id=:id '
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('id'                    , FCondicaoPagamento.Id)
        .Params('idempresa'             , FCondicaoPagamento.IdEmpresa)
        .Params('idusuario'             , FCondicaoPagamento.IdUsuario)
        .Params('nomecondicaopagamento' , FCondicaoPagamento.NomeCondicaoPagamento)
        .Params('quantidadepagamento'   , FCondicaoPagamento.QuantidadePagamento)
        .Params('totaldias'             , FCondicaoPagamento.TotalDias)
        .Params('prazomedio'            , FCondicaoPagamento.PrazoMedio)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOCondicaoPagamento.Put - padr�o ao tentar alterar condicaopagamento: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOCondicaoPagamento.Delete: iDAOCondicaoPagamento;
const
  LSQL=('delete from condicaopagamento where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    FQuery.SQL(LSQL)
                .Params('id', FCondicaoPagamento.Id)
              .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOCondicaoPagamento.Delete - ao tentar exclu�r condicaopagamento: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOCondicaoPagamento.LoopRegistro(Value : Integer): Integer;
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

function TDAOCondicaoPagamento.QuantidadeRegistro : Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOCondicaoPagamento.This: iEntidadeCondicaoPagamento<iDAOCondicaoPagamento>;
begin
  Result := FCondicaoPagamento;
end;

end.
