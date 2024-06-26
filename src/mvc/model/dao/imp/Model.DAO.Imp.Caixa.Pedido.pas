{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 26/04/2024 16:08           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Model.DAO.Imp.Caixa.Pedido;

interface

uses
  Data.DB,
  System.SysUtils,

  Uteis.Tratar.Mensagens,

  Model.DAO.Caixa.Pedido.Interfaces,
  Model.Entidade.Caixa.Pedido.Interfaces,
  Model.Conexao.Firedac.Interfaces,
  Model.Conexao.Query.Interfaces;

type
  TDAOCaixaPedido= class(TInterfacedObject, iDAOCaixaPedido)
    private
      FCaixaPedido : iEntidadeCaixaPedido<iDAOCaixaPedido>;
      FConexao : iConexao;
      FQuery   : iQuery;
      FMSG     : TMensagens;
      FDataSet : TDataSet;

    const
      FSQL =('select '+
             'id, '+
             'idempresa, '+
             'idcaixa, '+
             'idpedido, '+
             'idusuario, '+
             'datahoraemissao '+
             'from caixapedido cp '
            );
      function LoopRegistro(Value : Integer): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDAOCaixaPedido;

      function DataSet(DataSource : TDataSource) : iDAOCaixaPedido; overload;
      function DataSet                           : TDataSet;        overload;
      function GetAll                            : iDAOCaixaPedido;
      function GetbyId(Id : Variant)             : iDAOCaixaPedido;
      function GetbyParams                       : iDAOCaixaPedido;
      function Post                              : iDAOCaixaPedido;
      function Put                               : iDAOCaixaPedido;
      function Delete                            : iDAOCaixaPedido;

      function QuantidadeRegistro : Integer;
      function This : iEntidadeCaixaPedido<iDAOCaixaPedido>;
  end;

implementation

uses
  Model.Entidade.Imp.Caixa.Pedido,
  Model.Conexao.Firedac.MySQL.Imp,
  Model.Conexao.Query.Imp;

{ TDAOCaixaPedido }

constructor TDAOCaixaPedido.Create;
begin
  FCaixaPedido := TEntidadeCaixaPedido<iDAOCaixaPedido>.New(Self);
  FConexao     := TModelConexaoFiredacMySQL.New;
  FQuery       := TQuery.New;
  FMSG         := TMensagens.Create;
end;

destructor TDAOCaixaPedido.Destroy;
begin
   FreeAndNil(FMSG);
  inherited;
end;

class function TDAOCaixaPedido.New: iDAOCaixaPedido;
begin
  Result := Self.Create;
end;

function TDAOCaixaPedido.DataSet(DataSource: TDataSource): iDAOCaixaPedido;
begin
  Result := Self;
  if not Assigned(FDataset) then
    DataSource.DataSet := FQuery.DataSet
  else
    DataSource.DataSet := FDataSet;
end;

function TDAOCaixaPedido.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TDAOCaixaPedido.GetAll: iDAOCaixaPedido;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                    .Add('order by p.id asc')
                    .Open
                  .DataSet;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro ao tentar encontrar todos caixa/pedido: ' + E.Message);
      Abort;
    end;
  end;
  if not FDataSet.IsEmpty then
    FCaixaPedido.Id(FDataSet.FieldByName('id').AsInteger)
    else
    FCaixaPedido.Id(0);
end;

function TDAOCaixaPedido.GetbyId(Id: Variant): iDAOCaixaPedido;
begin
  Result := Self;
  try
    FDataSet := FQuery
                  .SQL(FSQL)
                  .Add('cp.id=:id')
                  .Params('id', id)
                  .Open
                .DataSet;
    except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro ao tentar encontrar caixa/pedido por Id: ' + E.Message);
      Abort;
    end;
  end;

  if not FDataSet.IsEmpty then
  begin
    FCaixaPedido.Id(FDataSet.FieldByName('id').AsInteger);
    QuantidadeRegistro;
  end
  else
    FCaixaPedido.Id(0);
end;

function TDAOCaixaPedido.GetbyParams: iDAOCaixaPedido;
begin
//Analisar como vou criar este filtro
end;

function TDAOCaixaPedido.Post: iDAOCaixaPedido;
const
  LSQL=('insert into caixapedido('+
                                        'idempresa, '+
                                 'idcaixa, '+
                                 'idpedido, '+
                                 'idusuario, '+
                                 'datahoraemissao '+
                                 ')'+
                                 ' values '+
                                 '( '+
                                 ':idempresa, '+
                                 ':idcaixa, '+
                                 ':idpedido, '+
                                 ':idusuario, '+
                                 ':datahoraemissao '+
                                 ') '
       );
begin
  Result := Self;
  FConexao.StartTransaction;
  try
    FQuery
      .SQL(LSQL)
        .Params('idempresa'       , FCaixaPedido.IdEmpresa)
        .Params('idcaixa'         , FCaixaPedido.IdCaixa)
        .Params('idpedido'        , FCaixaPedido.IdPedido)
        .Params('idusuario'       , FCaixaPedido.IdUsuario)
        .Params('datahoraemissao' , FCaixaPedido.DataHoraEmissao)
      .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro ao tentar incluir caixa/pedido: ' + E.Message);
      Abort;
    end;
  end;
  FConexao.Commit;
  FDataSet := FQuery
                .SQL('select LAST_INSERT_ID () as id')
                  .Open
                .DataSet;
  FCaixaPedido.Id(FDataSet.FieldByName('id').AsInteger);
end;

function TDAOCaixaPedido.Put: iDAOCaixaPedido;
begin
  //Sem c�digo
end;

function TDAOCaixaPedido.Delete: iDAOCaixaPedido;
const
  LSQL=('delete from caixapedido ');
begin
  Result := self;
  FConexao.StartTransaction;
  try
    FQuery.SQL(LSQL)
             .Add('where id=:id')
             .Params('id', FCaixaPedido.Id)
          .ExecSQL;
  except
    on E: Exception do
    begin
      FConexao.Rollback;
      WriteLn('Erro ao tentar exclu�r caixa/pedido: ' + E.Message);
      Abort;
    end;
  end;
  FConexao.Commit;
end;

function TDAOCaixaPedido.LoopRegistro(Value: Integer): Integer;
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

function TDAOCaixaPedido.QuantidadeRegistro: Integer;
begin
  Result := LoopRegistro(0);
end;

function TDAOCaixaPedido.This: iEntidadeCaixaPedido<iDAOCaixaPedido>;
begin
  Result := FCaixaPedido;
end;

end.
