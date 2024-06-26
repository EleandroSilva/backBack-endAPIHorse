{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 19/03/2024 22:59           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Controller.Produto;

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
  TViewControllerProduto = class
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

constructor TViewControllerProduto.Create;
begin
  FController := TController.New;
  FDataSource := TDataSource.Create(nil);
  Registry;
end;

destructor TViewControllerProduto.Destroy;
begin
  FreeAndNil(FDataSource);
  inherited;
end;

procedure TViewControllerProduto.GetAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      if ((Req.Query.Field('nomeproduto').AsString<>'') or (Req.Query.Field('gtin').AsString<>'')
      or (Req.Query.Field('ceantrib').AsString<>'') or (Req.Query.Field('cean').AsString<>'')) then
       FQuantidadeRegistro := FController
                                .FactoryDAO
                                  .DAOProduto
                                    .This
                                      .NomeProduto(Req.Query.Field('nomeproduto').AsString)
                                      .Gtin       (Req.Query.Field('gtin').AsString)
                                      .cEanTrib   (Req.Query.Field('ceantrib').AsString)
                                      .cEan       (Req.Query.Field('cean').AsString)
                                    .&End
                                  .GetbyParams
                                  .DataSet(FDataSource)
                                  .QuantidadeRegistro
      else
        FQuantidadeRegistro := FController
                                  .FactoryDAO
                                    .DAOProduto
                                      .GetAll
                                      .DataSet(FDataSource)
                                      .QuantidadeRegistro;

      if FQuantidadeRegistro > 1 then
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
    Res.Send<TJSONObject>(FJSONObject);
    if not FDataSource.DataSet.IsEmpty then
      Res.Status(201).Send('Registro encontrado com sucesso!')
      else
      Res.Status(400).Send('Registro n�o encontrado!');
  end;
end;

procedure TViewControllerProduto.GetbyId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Try
     try
       FController
         .FactoryDAO
           .DAOProduto
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
     if not FDataSource.DataSet.IsEmpty then
      Res.Status(201).Send('Registro encontrado com sucesso!')
      else
      Res.Status(400).Send('Registro n�o encontrado!');
   End;
end;

procedure TViewControllerProduto.Post(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FBody := Req.Body<TJSONObject>;
      FController
        .FactoryDAO
          .DAOProduto
            .This
              .IdEmpresa            (FBody.GetValue<integer>  ('idempresa'))
              .IdUsuario            (FBody.GetValue<integer>  ('idusuario'))
              .IdCategoria          (FBody.GetValue<integer>  ('idcategoria'))
              .IdUnidade            (FBody.GetValue<integer>  ('idunidade'))
              .Gtin                 (FBody.GetValue<String>   ('gtin'))
              .cEanTrib             (FBody.GetValue<String>   ('ceantrib'))
              .cEan                 (FBody.GetValue<String>   ('cean'))
              .NomeProduto          (FBody.GetValue<String>   ('nomeproduto'))
              .NCM                  (FBody.GetValue<integer>  ('ncm'))
              .ValorCusto           (FBody.GetValue<Currency> ('valorcusto'))
              .AliquotaLucro        (FBody.GetValue<Currency> ('aliquotalucro'))
              .ValorVendaGelado     (FBody.GetValue<Currency> ('valorvendagelado'))
              .ValorVendaNatural    (FBody.GetValue<Currency> ('valorvendanatural'))
              .ValorVendaPromocional(FBody.GetValue<Currency> ('valorvendapromocional'))
              .EstoqueAnterior      (FBody.GetValue<Currency> ('estoqueanterior'))
              .EstoqueMaximo        (FBody.GetValue<Currency> ('estoquemaximo'))
              .EstoqueMinimo        (FBody.GetValue<Currency> ('estoqueminimo'))
              .EstoqueAtual         (FBody.GetValue<Currency> ('estoqueatual'))
              .Origem               (FBody.GetValue<integer>  ('origem'))
              .Volume               (FBody.GetValue<integer>  ('volume'))
              .QuantidadeEmbalagem  (FBody.GetValue<integer>  ('quantidadeembalagem'))
              .Balanca              (FBody.GetValue<integer>  ('balanca'))
              .PesoLiquido          (FBody.GetValue<Currency> ('pesoliquido'))
              .PesoBruto            (FBody.GetValue<Currency> ('pesobruto'))
              .DataHoraEmissao      (FBody.GetValue<TDateTime>('datahoraemissao'))
              .Ativo                (FBody.GetValue<integer>  ('ativo'))
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

procedure TViewControllerProduto.Put(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FBody := Req.Body<TJSONObject>;
      FController
        .FactoryDAO
          .DAOProduto
            .This
              .Id                   (FBody.GetValue<integer>  ('id'))
              .IdEmpresa            (FBody.GetValue<integer>  ('idempresa'))
              .IdUsuario            (FBody.GetValue<integer>  ('idusuario'))
              .IdCategoria          (FBody.GetValue<integer>  ('idcategoria'))
              .IdUnidade            (FBody.GetValue<integer>  ('idunidade'))
              .Gtin                 (FBody.GetValue<String>   ('gtin'))
              .cEanTrib             (FBody.GetValue<String>   ('nome'))
              .cEan                 (FBody.GetValue<String>   ('cean'))
              .NomeProduto          (FBody.GetValue<String>   ('nomeproduto'))
              .NCM                  (FBody.GetValue<integer>  ('ncm'))
              .ValorCusto           (FBody.GetValue<Currency> ('valorcusto'))
              .AliquotaLucro        (FBody.GetValue<Currency> ('aliquotalucro'))
              .ValorVendaGelado     (FBody.GetValue<Currency> ('valorvendagelado'))
              .ValorVendaNatural    (FBody.GetValue<Currency> ('valorvendanatural'))
              .ValorVendaPromocional(FBody.GetValue<Currency> ('valorvendapromocional'))
              .EstoqueAnterior      (FBody.GetValue<Currency> ('estoqueanterior'))
              .EstoqueMaximo        (FBody.GetValue<Currency> ('estoquemaximo'))
              .EstoqueMinimo        (FBody.GetValue<Currency> ('estoqueminimo'))
              .EstoqueAtual         (FBody.GetValue<Currency> ('estoqueatual'))
              .Origem               (FBody.GetValue<integer>  ('origem'))
              .Volume               (FBody.GetValue<integer>  ('volume'))
              .QuantidadeEmbalagem  (FBody.GetValue<integer>  ('quantidadeembalagem'))
              .Balanca              (FBody.GetValue<integer>  ('balanca'))
              .PesoLiquido          (FBody.GetValue<Currency> ('pesoliquido'))
              .PesoBruto            (FBody.GetValue<Currency> ('pesobruto'))
              .DataHoraEmissao      (FBody.GetValue<TDateTime>('datahoraemissao'))
              .Ativo                (FBody.GetValue<integer>  ('ativo'))
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

procedure TViewControllerProduto.Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FController
        .FactoryDAO
          .DAOProduto
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
    End;
  Finally
    Res.Status(204).Send('Registro exclu�do com sucesso!');
  End;
end;

procedure TViewControllerProduto.Registry;
begin
  THorse
      .Group
      .Prefix('bmw')
      .Get   ('produto'     , GetAll)
      .Get   ('produto/:id' , GetbyId)
      .Post  ('produto'     , Post)
      .Put   ('produto/:id' , Put)
      .Delete('produto/:id' , Delete);
end;

end.
