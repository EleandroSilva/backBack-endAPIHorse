{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 18/03/2024 13:39           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Controller.Categoria.Produto;

interface

uses
  System.SysUtils,
  System.JSON,
  Data.DB,
  FireDAC.Comp.Client,
  DataSet.Serialize,
  Horse,
  Horse.BasicAuthentication,
  Controller.Interfaces;
type
  TViewControllerCategoriaProduto = class
    private
      FBody       : TJSONValue;
      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;
      FDataSource : TDataSource;
      FController : iController;
      FQuantidadeRegistro : Integer;
      procedure GetAll (Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure GetbyId(Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure Post   (Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure Put    (Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure Delete (Req: THorseRequest; Res: THorseResponse; Next : TProc);
      procedure Registry;
    public
      constructor Create;
      destructor Destroy; override;
  end;

implementation

uses
  Imp.Controller;

{ TViewControllerCategoriaProduto }

constructor TViewControllerCategoriaProduto.Create;
begin
  FController := TController.New;
  FDataSource := TDataSource.Create(nil);
  Registry;
end;

destructor TViewControllerCategoriaProduto.Destroy;
begin
  FreeAndNil(FDataSource);
  inherited;
end;

procedure TViewControllerCategoriaProduto.GetAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  //L� os dados JSON da requisi��o (tabela pai='empresa')
  FJSONObject := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Body), 0) as TJSONObject;
  try
    try
      if ((Req.Query.Field('nomecategoria').AsString<>'') or (Req.Query.Field('idempresa').AsInteger>0)) then
        FQuantidadeRegistro := FController
                                .FactoryDAO
                                  .DAOCategoriaProduto
                                    .This
                                      .NomeCategoria(Req.Query.Field('nomecategoria').AsString)
                                      .IdEmpresa    (Req.Query.Field('idempresa').AsInteger)
                                  .&End
                                  .GetbyParams
                                  .DataSet(FDataSource)
                                  .QuantidadeRegistro
        else
        FQuantidadeRegistro := FController
                                .FactoryDAO
                                  .DAOCategoriaProduto
                                    .This
                                      .IdEmpresa(Req.Query.Field('idempresa').AsInteger)
                                    .&End
                                  .GetAll
                                  .DataSet(FDataSource)
                                  .QuantidadeRegistro;
     if FQuantidadeRegistro > 1  then
     begin
       FJSONArray := FDataSource.DataSet.ToJSONArray();
       Res.Send<TJSONArray>(FJSONArray);
     end
     else
     begin
       FJSONObject := FDataSource.DataSet.ToJSONObject();
       Res.Send<TJSONObject>(FJSONObject);
     end;
   except
     on E: Exception do
     begin
       Res.Status(500).Send('Ocorreu um erro interno no servidor'+E.Message);
       Exit;
     end;
   End;
  finally
    if FDataSource.DataSet.IsEmpty then
      Res.Status(404).Send('Registro n�o encontrado!')
    else
      Res.Status(201).Send('Registro encontrado com sucesso!');
  end;
end;

procedure TViewControllerCategoriaProduto.GetbyId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Try
     try
       FController
         .FactoryDAO
           .DAOCategoriaProduto
             .This
               .IdEmpresa(Req.Query.Field('idempresa').AsInteger)
             .&End
             .GetbyId(Req.Params['id'].ToInt64)
           .DataSet(FDataSource);

       FJSONObject := FDataSource.DataSet.ToJSONObject();
       Res.Send<TJSONObject>(FJSONObject);
   except
     on E: Exception do
     begin
       Res.Status(500).Send('Ocorreu um erro interno no servidor'+E.Message);
       Exit;
     end;
   End;
   Finally
     if FDataSource.DataSet.IsEmpty then
       Res.Status(404).Send('Registro n�o encontrado!')
     else
       Res.Status(201).Send('Registro encontrado com sucesso!');
   End;
end;

procedure TViewControllerCategoriaProduto.Post(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FJSONObject := Req.Body<TJSONObject>;
      FController
        .FactoryDAO
          .DAOCategoriaProduto
            .This
              .IdEmpresa      (FJSONObject.GetValue<integer>('idempresa'))
              .IdUsuario      (FJSONObject.GetValue<integer>('idusuario'))
              .DataHoraEmissao(FJSONObject.GetValue<TDateTime>('datahoraemissao'))
              .NomeCategoria  (FJSONObject.GetValue<String> ('nomecategoria'))
              .Ativo          (1)
            .&End
          .Post;
  except
    on E: Exception do
    begin
      Res.Status(500).Send('Ocorreu um erro interno no servidor'+E.Message);
      Exit;
    end;
  end;
  finally
    Res.Status(204).Send('Registro inclu�do com sucesso!');
  end;
end;

procedure TViewControllerCategoriaProduto.Put(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FJSONObject := Req.Body<TJSONObject>;
      FController
        .FactoryDAO
          .DAOCategoriaProduto
            .This
              .Id             (FJSONObject.GetValue<Integer>('id'))
              .IdEmpresa      (FJSONObject.GetValue<Integer>('idempresa'))
              .IdUsuario      (FJSONObject.GetValue<Integer>('idusuario'))
              .DataHoraEmissao(FJSONObject.GetValue<Integer>('datahoraemissao'))
              .NomeCategoria  (FJSONObject.GetValue<String> ('nomecategoria'))
              .Ativo          (FJSONObject.GetValue<Integer>('ativo'))
            .&End
          .Put;
  except
    on E: Exception do
    begin
      Res.Status(500).Send('Ocorreu um erro interno no servidor'+E.Message);
      Exit;
    end;
  end;
  finally
    Res.Status(204).Send('Registro alterado com sucesso!');
  end;
end;

procedure TViewControllerCategoriaProduto.Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FController
        .FactoryDAO
          .DAOCategoriaProduto
            .This
              .Id(Req.Params['id'].ToInt64)
            .&End
          .Delete;
    except
      on E: Exception do
      begin
        Res.Status(500).Send('Ocorreu um erro interno no servidor'+E.Message);
        Exit;
      end;
  end;
  finally
    Res.Status(204).Send('Registro exclu�do com sucesso!');
  end;
end;

procedure TViewControllerCategoriaProduto.Registry;
begin
  THorse
      .Group
      .Prefix('bmw')
      .Get   ('/categoria-produto'     , GetAll)
      .Get   ('/categoria-produto/:id' , GetbyId)
      .Post  ('categoria-produto'      , Post)
      .Put   ('categoria-produto/:id'  , Put)
      .Delete('categoria-produto/:id'  , Delete);
end;

end.
