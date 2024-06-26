{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 22/04/2024 14:46           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Caixa.Diario.Movimento;

interface

uses
  Data.DB,
  System.SysUtils,

  Uteis.Interfaces,
  Uteis,
  Uteis.Tratar.Mensagens,

  Model.DAO.Caixa.Diario.Movimento.Interfaces,
  Model.Entidade.Caixa.Diario.Movimento.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;

type
  TDAOCaixaDiarioMovimento= class(TInterfacedObject, iDAOCaixaDiarioMovimento)
    private
      FCaixaDiarioMovimento : iEntidadeCaixaDiarioMovimento<iDAOCaixaDiarioMovimento>;
      FConexao     : iConexao;
      FDataSet     : TDataSet;
      FQuery       : iQuery;
      FUteis       : iUteis;
      FMSG         : TMensagens;

    const
      FSQL=('select '+
            'cdm.id, '+
            'cdm.idcaixadiario, '+
            'cdm.idpedido, '+
            'cdm.idformapagamento, '+
            'cdm.idusuario, '+
            'u.nomeusuario, '+
            'cdm.valorlancamento, '+
            'cdm.datahoraemissao, '+
            'cdm.tipolancamento '+
            'from caixadiariomovimento cdm '+
            'inner join usuario u on u.id = cdm.idusuario '
            );
      function LoopRegistro(Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOCaixaDiarioMovimento;

      function DataSet    (DataSource : TDataSource) : iDAOCaixaDiarioMovimento; overload;
      function DataSet                               : TDataSet;                 overload;
      function GetAll                                : iDAOCaixaDiarioMovimento;
      function GetbyId    (Id : Variant)             : iDAOCaixaDiarioMovimento;
      function GetbyParams                           : iDAOCaixaDiarioMovimento; overload;
      function GetbyParams(aIdUsuario : Variant)     : iDAOCaixaDiarioMovimento; overload;
      function GetbyParams(aNomeUsuario : String)    : iDAOCaixaDiarioMovimento; overload;
      function GetbyParams(aIdPedido : Integer)      : iDAOCaixaDiarioMovimento; overload;
      function Post                                  : iDAOCaixaDiarioMovimento;
      function Put                                   : iDAOCaixaDiarioMovimento;
      function Delete                                : iDAOCaixaDiarioMovimento;
      function QuantidadeRegistro                    : Integer;

      function This : iEntidadeCaixaDiarioMovimento<iDAOCaixaDiarioMovimento>;
  end;

implementation

uses
  Model.Entidade.Imp.Caixa.Diario.Movimento,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

{ TDAOCaixaDiarioMovimento }

constructor TDAOCaixaDiarioMovimento.Create;
begin
  FCaixaDiarioMovimento := TEntidadeCaixaDiarioMovimento<iDAOCaixaDiarioMovimento>.New(Self);
  FConexao     := TModelConexaoFiredacMySQL.New;
  FQuery       := TQuery.New;
  FUteis       := TUteis.New;
  FMSG         := TMensagens.Create;
end;

destructor TDAOCaixaDiarioMovimento.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOCaixaDiarioMovimento.New: iDAOCaixaDiarioMovimento;
begin
  Result := Self.Create;
end;

function TDAOCaixaDiarioMovimento.DataSet(DataSource: TDataSource): iDAOCaixaDiarioMovimento;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOCaixaDiarioMovimento.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOCaixaDiarioMovimento.GetAll: iDAOCaixaDiarioMovimento;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
    begin
      FCaixaDiarioMovimento.Id(FDataSet.FieldByName('cdm.id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FCaixaDiarioMovimento.Id(0);
  end;
end;

function TDAOCaixaDiarioMovimento.GetbyId(Id: Variant): iDAOCaixaDiarioMovimento;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL+' where cdm.Id=:Id')
                    .Params('Id', Id)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
      FCaixaDiarioMovimento.Id(FDataSet.FieldByName('cdm.id').AsInteger)
    else
      FCaixaDiarioMovimento.Id(0);
  end;
end;

function TDAOCaixaDiarioMovimento.GetbyParams(aIdPedido: Integer): iDAOCaixaDiarioMovimento;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL+' where cdm.idpedido=:Idpedido')
                    .Params('Idpedido', aIdPedido)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
      FCaixaDiarioMovimento.Id(FDataSet.FieldByName('cdm.id').AsInteger)
    else
      FCaixaDiarioMovimento.Id(0);
  end;
end;

function TDAOCaixaDiarioMovimento.GetbyParams: iDAOCaixaDiarioMovimento;
begin
   Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Add('where u.nomeusuario=:nomeusuario')
                    .Params('nomeusuario', FCaixaDiarioMovimento.Usuario.NomeUsuario)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
    begin
      FCaixaDiarioMovimento.Id(FDataSet.FieldByName('cmd.id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FCaixaDiarioMovimento.Id(0);
  end;
end;

function TDAOCaixaDiarioMovimento.GetbyParams(aIdUsuario: Variant): iDAOCaixaDiarioMovimento;
begin
  Result := Self;
  try
    try
      FDataSet := FQuery
                    .SQL(FSQL)
                    .Add('where cdm.idusuario=:idusuario')
                    .Params('idusuario', FCaixaDiarioMovimento.IdUsuario)
                    .Open
                  .DataSet;
    except
      on E: Exception do
      raise Exception.Create(FMSG.MSGerroGet+E.Message);
    end;
  finally
    if not FDataSet.IsEmpty then
    begin
      FCaixaDiarioMovimento.Id(FDataSet.FieldByName('cdm.id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FCaixaDiarioMOvimento.Id(0);
  end;
end;

function TDAOCaixaDiarioMovimento.GetbyParams(aNomeUsuario: String): iDAOCaixaDiarioMovimento;
begin
  Result := Self;
  try
   try
     FDataSet := FQuery
                   .SQL(FSQL+' where ' + FUteis.Pesquisar('u.nomeusuario', ';' + aNomeUsuario))
                   .Open
                 .DataSet;
   except
     on E: Exception do
     raise exception.Create(FMSG.MSGerroGet+E.Message);
   end;
  finally
    if not FDataSet.IsEmpty then
    begin
      FCaixaDiarioMovimento.Id(FDataSet.FieldByName('cdm.id').AsInteger);
      QuantidadeRegistro;
    end
    else
      FCaixaDiarioMOvimento.Id(0);
  end;
end;

function TDAOCaixaDiarioMovimento.Post: iDAOCaixaDiarioMovimento;
const
  LSQL=('insert into caixadiariomovimento( '+
                                         'idcaixadiario, '+
                                         'idpedido, '+
                                         'idformapagamento, '+
                                         'idusuario, '+
                                         'valorlancamento, '+
                                         'datahoraemissao, '+
                                         'tipolancamento '+
                                       ')'+
                                         ' values '+
                                       '('+
                                         ':idcaixadiario, '+
                                         ':idpedido, '+
                                         ':idformapagamento, '+
                                         ':idusuario, '+
                                         ':valorlancamento, '+
                                         ':datahoraemissao, '+
                                         ':tipolancamento '+
                                        ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    try
      FQuery
        .SQL(LSQL)
          .Params('idcaixadiario'    , FCaixaDiarioMovimento.IdCaixaDiario)
          .Params('idpedido'         , FCaixaDiarioMovimento.IdPedido)
          .Params('idformapagamento' , FCaixaDiarioMovimento.IdFormaPagamento)
          .Params('idusuario'        , FCaixaDiarioMovimento.IdUsuario)
          .Params('valorlancamento'  , FCaixaDiarioMovimento.ValorLancamento)
          .Params('datahoraemissao'  , FCaixaDiarioMovimento.DataHoraEmissao)
          .Params('tipolancamento'   , FCaixaDiarioMovimento.TipoLancamento)
        .ExecSQL;
    except
      on E: Exception do
      begin
        FConexao.Rollback;
        raise Exception.Create(FMSG.MSGerroPost+E.Message);
      end;
    end;
  finally
    FConexao.Commit;
    FDataSet := FQuery
                    .SQL('select LAST_INSERT_ID () as id')
                    .Open
                    .DataSet;
    FCaixaDiarioMovimento.Id(FDataSet.FieldByName('id').AsInteger);
  end;
end;

function TDAOCaixaDiarioMovimento.Put: iDAOCaixaDiarioMovimento;
const
  LSQL=('update caixadiariomovimento set '+
                                   'idcaixadiario   =:idcaixadiario, '+
                                   'idpedido        =:idpedido, '+
                                   'idformapagamento=:idformapagamento, '+
                                   'idusuario       =:idusuario, '+
                                   'valorlancamento =:valorlancamento '+
                                   'tipolancamento  =:tipolancamento '+
                                   'where id        =:id '
       );
begin
  Result := Self;

  FConexao.StartTransaction;
  try
    try
      FQuery
        .SQL(LSQL)
          .Params('id'               , FCaixaDiarioMovimento.Id)
          .Params('idcaixadiario'    , FCaixaDiarioMovimento.IdCaixaDiario)
          .Params('idpedido'         , FCaixaDiarioMovimento.IdPedido)
          .Params('idformapagamento' , FCaixaDiarioMovimento.IdFormaPagamento)
          .Params('idusuario'        , FCaixaDiarioMovimento.IdUsuario)
          .Params('valorlancamento'  , FCaixaDiarioMovimento.ValorLancamento)
          .Params('tipolancamento'   , FCaixaDiarioMovimento.TipoLancamento)
        .ExecSQL;
    except
      on E: Exception do
      begin
        FConexao.Rollback;
        raise Exception.Create(FMSG.MSGerroPut+E.Message);
      end;
    end;
  finally
    FConexao.Commit;
  end;
end;

function TDAOCaixaDiarioMovimento.Delete: iDAOCaixaDiarioMovimento;
const
  LSQL=('delete from caixadiariomovimento where id=:id ');
begin
   Result := self;
  FConexao.StartTransaction;
  try
    try
      FQuery.SQL(LSQL)
              .Params('id', FCaixaDiarioMovimento.Id)
            .ExecSQL;
    except
      on E: Exception do
      begin
        FConexao.Rollback;
        raise Exception.Create(FMSG.MSGerroDelete+E.Message);
      end;
    end;
  finally
    FConexao.Commit;
  end;
end;

function TDAOCaixaDiarioMovimento.LoopRegistro(Value: Integer): Integer;
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

function TDAOCaixaDiarioMovimento.QuantidadeRegistro: Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOCaixaDiarioMovimento.This: iEntidadeCaixaDiarioMovimento<iDAOCaixaDiarioMovimento>;
begin
  Result := FCaixaDiarioMovimento;
end;

end.
