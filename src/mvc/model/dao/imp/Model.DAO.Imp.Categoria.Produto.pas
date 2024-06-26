{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Categoria.Produto;

interface

uses
  System.SysUtils,

  Data.DB,

  Uteis,
  Uteis.Interfaces,
  Uteis.Tratar.Mensagens,

  Model.DAO.Categoria.Produto.Interfaces,
  Model.Entidade.Categoria.Produto.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;

type
  TDAOCategoriaProduto = class(TInterfacedObject, iDAOCategoriaProduto)
    private
      FCategoriaProduto : iEntidadeCategoriaProduto<iDAOCategoriaProduto>;
      FConexao          : iConexao;
      FUteis            : iUteis;
      FMSG              : TMensagens;
      FDataSet      : TDataSet;
      FQuery        : iQuery;
   const
      FSQL=('select '+
            'cp.id, '+
            'cp.idempresa, '+
            'cp.idusuario, '+
            'cp.nomecategoria, '+
            'cp.datahoraemissao, '+
            'cp.ativo '+
            'from categoriaproduto cp ');
      function LoopRegistro (Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOCategoriaProduto;
      function DataSet(DataSource : TDataSource) : iDAOCategoriaProduto; overload;
      function DataSet                           : TDataSet;             overload;
      function GetAll                            : iDAOCategoriaProduto;
      function GetbyId(Id : Variant)             : iDAOCategoriaProduto;
      function GetbyParams                       : iDAOCategoriaProduto;
      function Post                              : iDAOCategoriaProduto;
      function Put                               : iDAOCategoriaProduto;
      function Delete                            : iDAOCategoriaProduto;

      function QuantidadeRegistro : Integer;
      function This : iEntidadeCategoriaProduto<iDAOCategoriaProduto>;
  end;

implementation

uses
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp,
  Model.Entidade.Imp.Categoria.Produto;

{ TDAOCategoriaProduto }
constructor TDAOCategoriaProduto.Create;
begin
  FCategoriaProduto := TEntidadeCategoriaProduto<iDAOCategoriaProduto>.New(Self);
  FConexao          := TModelConexaoFiredacMySQL.New;
  FQuery            := TQuery.New;
  FUteis := TUteis.New;
  FMSG   := TMensagens.Create;
end;

destructor TDAOCategoriaProduto.Destroy;
begin
  FreeAndNil(FMSG);
  inherited;
end;

class function TDAOCategoriaProduto.New: iDAOCategoriaProduto;
begin
  Result := Self.Create;
end;

function TDAOCategoriaProduto.DataSet(DataSource: TDataSource): iDAOCategoriaProduto;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOCategoriaProduto.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOCategoriaProduto.GetAll: iDAOCategoriaProduto;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where cp.idempresa=cp.idempresa')
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOCategoriaProduto.GetAll -ao tentar encontrar categoria de produto(s): ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FCategoriaProduto.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FCategoriaProduto.Id(0);
end;

function TDAOCategoriaProduto.GetbyId(Id: Variant): iDAOCategoriaProduto;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('where cp.id=:id')
                    .Add('and cp.idempresa=cp.idempresa')
                    .Params('Id', Id)
                  .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOCategoriaProduto.GetId -ao tentar encontrar categoria de produto(s): ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FCategoriaProduto.Id(FDataSet.FieldByName('id').AsInteger)
    else
    FCategoriaProduto.Id(0);
end;

function TDAOCategoriaProduto.GetbyParams: iDAOCategoriaProduto;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL+' where ' + FUteis.Pesquisar('cp.nomecategoria', ';' + FCategoriaProduto.NomeCategoria))
                    .Add('and cp.idempresa=idempresa ')
                  .Open
                  .DataSet;
   except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOCategoriaProduto.GetParams -ao tentar encontrar categoria de produto(s): ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
  begin
    FCategoriaProduto.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FCategoriaProduto.Id(0);
end;

function TDAOCategoriaProduto.Post: iDAOCategoriaProduto;
const
  LSQL=('insert into categoriaproduto( '+
                                     'idempresa, '+
                                     'idusuario, '+
                                     'nomecategoria, '+
                                     'datahoraemissao, '+
                                     'ativo '+
                                     ')'+
                                     ' values '+
                                     '('+
                                     ':idempresa, '+
                                     ':idusuario, '+
                                     ':nomecategoria, '+
                                     ':datahoraemissao, '+
                                     ':ativo ' +
                                     ')'
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('idempresa'       , FCategoriaProduto.IdEmpresa)
        .Params('idusuario'       , FCategoriaProduto.IdUsuario)
        .Params('nomecategoria'   , FCategoriaProduto.NomeCategoria)
        .params('datahoraemissao' , FCategoriaProduto.DataHoraEmissao)
        .Params('ativo'           , FCategoriaProduto.Ativo)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOCategoriaProduto.Post -ao tentar incluir categoria de produto(s): ' + E.Message);
      Abort;
    end;
  end;
  FConexao.Commit;
  FDataSet := FQuery
                .SQL('select LAST_INSERT_ID () as id')
                  .Open
                .DataSet;
  FCategoriaProduto.Id(FDataSet.FieldByName('id').AsInteger);
end;

function TDAOCategoriaProduto.Put: iDAOCategoriaProduto;
const
  LSQL=('update categoriaproduto set '+
                                 'idempresa       =:idempresa, '+
                                 'idusuario       =:idusuario, '+
                                 'nomecategoria   =:nomecategoria, '+
                                 'datahoraemissao =:datahoraemissao, '+
                                 'ativo           =:ativo '+
                                 'where id        =:id '
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('id'              , FCategoriaProduto.Id)
        .Params('idempresa'       , FCategoriaProduto.IdEmpresa)
        .Params('idusuario'       , FCategoriaProduto.IdUsuario)
        .Params('nomecategoria'   , FCategoriaProduto.NomeCategoria)
        .Params('datahoraemissao' , FCategoriaProduto.DataHoraEmissao)
        .Params('ativo'           , FCategoriaProduto.Ativo)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOCategoriaProduto.Put -ao tentar alterar categoria de produto(s): ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOCategoriaProduto.Delete: iDAOCategoriaProduto;
const
  LSQL=('delete from categoriaproduto where id=:id ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    FQuery.SQL(LSQL)
                .Params('id', FCategoriaProduto.Id)
              .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro no TDAOCategoriaProduto.Delete -ao tentar exclu�r categoria de produto(s): ' + E.Message);
      Abort;
    end;
  end;
    FConexao.Commit;
end;

function TDAOCategoriaProduto.LoopRegistro(Value: Integer): Integer;
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

function TDAOCategoriaProduto.QuantidadeRegistro: Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOCategoriaProduto.This: iEntidadeCategoriaProduto<iDAOCategoriaProduto>;
begin
  Result := FCategoriaProduto;
end;

end.
