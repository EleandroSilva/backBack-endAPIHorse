{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 22/04/2024 14:46           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Caixa;

interface

uses
  Data.DB,
  System.SysUtils,

  Uteis.Interfaces,
  Uteis,
  Uteis.Tratar.Mensagens,


  Model.DAO.Caixa.Interfaces,
  Model.Entidade.Caixa.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;
type
  TDAOCaixa = class(TInterfacedObject, iDAOCaixa)
    private
      FCaixa   : iEntidadeCaixa<iDAOCaixa>;
      FConexao : iConexao;
      FDataSet : TDataSet;
      FQuery   : iQuery;
      FUteis   : iUteis;
      FMSG     : TMensagens;

    const
      FSQL=('select '+
            'cx.id, '+
            'cx.idempresa, '+
            'cx.idusuario, '+
            'u.nomeusuario, '+
            'cx.valorinicial, '+
            'cx.datahoraemissao, '+
            'cx.status '+
            'from caixa cx '+
            'inner join usuario u on u.id =cx.idusuario '
            );
      function LoopRegistro(Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOCaixa;

      function DataSet    (DataSource : TDataSource) : iDAOCaixa; overload;
      function DataSet                               : TDataSet;        overload;
      function GetAll                                : iDAOCaixa;
      function GetbyId    (Id : Variant)             : iDAOCaixa;
      function GetbyParams                           : iDAOCaixa; overload;
      function GetbyParams(IdUsuario : Variant)      : iDAOCaixa; overload;
      function GetbyParams(NomeUsuario : String)     : iDAOCaixa; overload;
      function Post                                  : iDAOCaixa;
      function Put                                   : iDAOCaixa;
      function Delete                                : iDAOCaixa;

      function QuantidadeRegistro : Integer;
      function This : iEntidadeCaixa<iDAOCaixa>;
  end;

implementation

uses
  Model.Entidade.Imp.Caixa,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

{ TDAOCaixa }

constructor TDAOCaixa.Create;
begin
  FCaixa   := TEntidadeCaixa<iDAOCaixa>.New(Self);
  FConexao := TModelConexaoFiredacMySQL.New;
  FQuery   := TQuery.New;
  FUteis   := TUteis.New;
  FMSG     := TMensagens.Create;
end;

destructor TDAOCaixa.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOCaixa.New: iDAOCaixa;
begin
  Result := Self.Create;
end;

function TDAOCaixa.DataSet(DataSource: TDataSource): iDAOCaixa;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOCaixa.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOCaixa.GetAll: iDAOCaixa;
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
      WriteLn('Erro  no TDAOCaixa.GetAll -ao tentar encontrar todos os caixa(s): ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FCaixa.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FCaixa.Id(0);
end;

function TDAOCaixa.GetbyId(Id: Variant): iDAOCaixa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL+' where cd.Id=:Id')
                    .Params('Id', Id)
                  .Open
                  .DataSet;
    except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro  no TDAOCaixa.GetId -ao tentar encontrar todos os caixa(s): ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FCaixa.Id(FDataSet.FieldByName('id').AsInteger)
    else
    FCaixa.Id(0);
end;

function TDAOCaixa.GetbyParams: iDAOCaixa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where u.nomeusuario=:nomeusuario')
                    .Params('nomeusuario', FCaixa.Usuario.NomeUsuario)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro  no TDAOCaixa.GetParams -ao tentar encontrar caixa(s) por nomeusuario: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FCaixa.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FCaixa.Id(0);
end;

function TDAOCaixa.GetbyParams(IdUsuario: Variant): iDAOCaixa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where cx.idusuario=:idusuario')
                    .Params('idusuario', IdUsuario)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro  no TDAOCaixa.GetParams -ao tentar encontrar caixa(s) aIdUsuario: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FCaixa.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FCaixa.Id(0);
end;

function TDAOCaixa.GetbyParams(NomeUsuario: String): iDAOCaixa;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL+' where ' + FUteis.Pesquisar('u.nomeusuario', ';' + NomeUsuario))
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro  no TDAOCaixa.GetAll -ao tentar encontrar caixa(s) NomeUsuario: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FCaixa.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FCaixa.Id(0);
end;

function TDAOCaixa.Post: iDAOCaixa;
const
  LSQL=('insert into caixa( '+
                             'idempresa, '+
                             'idusuario, '+
                             'valorinicial, '+
                             'datahoraemissao, '+
                             'status '+
                           ')'+
                             ' values '+
                           '('+
                             ':idempresa, '+
                             ':idusuario, '+
                             ':valorinicial, '+
                             ':datahoraemissao, '+
                             ':status '+
                            ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('idempresa'       , FCaixa.IdEmpresa)
        .Params('idusuario'       , FCaixa.IdUsuario)
        .Params('valorinicial'    , FCaixa.ValorInicial)
        .Params('datahoraemissao' , FCaixa.DataHoraEmissao)
        .Params('status'          , FCaixa.Status)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro  no TDAOCaixa.Post -ao tentar insert into caixa: ' + E.Message);
      Abort;
    end;
  end;
  FConexao.Commit;
  FDataSet := FQuery
                    .SQL('select LAST_INSERT_ID () as id')
                    .Open
                    .DataSet;
  FCaixa.Id(FDataSet.FieldByName('id').AsInteger);
end;

function TDAOCaixa.Put: iDAOCaixa;
const
  LSQL=('update caixa set '+
                           'valorinicial   =:valorinicial '+
                           'where id       =:id '+
                           'and idempresa=idempresa '
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('id'           , FCaixa.Id)
        .Params('idempresa'    , FCaixa.IdEmpresa)
        .Params('valorinicial' , FCaixa.ValorInicial)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro  no TDAOCaixa.Put -ao tentar update caixa: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOCaixa.Delete: iDAOCaixa;
const
  LSQL=('delete from caixa where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    FQuery.SQL(LSQL)
                .Params('id', FCaixa.Id)
              .ExecSQL;
    except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro  no TDAOCaixa.Delete -ao tentar delete caixa: ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOCaixa.LoopRegistro(Value: Integer): Integer;
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

function TDAOCaixa.QuantidadeRegistro: Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOCaixa.This: iEntidadecaixa<iDAOCaixa>;
begin
  Result := FCaixa;
end;

end.
