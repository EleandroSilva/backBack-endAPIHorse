{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 24/04/2024 14:40           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Controller.Condicao.Pagamento;

interface

uses
  System.Classes,
  System.SysUtils,
  System.JSON,
  Vcl.StdCtrls,
  Data.DB,
  FireDAC.Comp.Client,
  DataSet.Serialize,
  Horse,
  Horse.BasicAuthentication,
  Controller.Interfaces;

type
  TViewControllerCondicaPagamento= class
    private
      FController : iController;

      FBody            : TJSONValue;
      FJSONObjectPai   : TJSONObject;
      FJSONArrayPai    : TJSONArray;
      FJSONObjectFilho : TJSONObject;
      FJSONArrayFilho  : TJSONArray;

      FDSCondicaoPagamento     : TDataSource;
      FDSCondicaoPagamentoItem : TDataSource;

      FIdCondicaoPagamento : Integer;
      FQuantidadeRegistro  : Integer;

      function BuscarPorNome   (Value : String)  : Boolean;
      function BuscarPorIdPai  (Value : Variant) : Boolean;
      function BuscarPorIdFilho(Value : Variant) : Boolean;
      //Loop
      procedure LoopCondicaoPagamento;
      function  LoopCondicaoPagamentoItem : Boolean;
      //Horse
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

{ TViewControllerCondicaPagamento }

constructor TViewControllerCondicaPagamento.Create;
begin
  FController              := TController.New;
  FDSCondicaoPagamento     := TDataSource.Create(nil);
  FDSCondicaoPagamentoItem := TDataSource.Create(nil);
  Registry;
end;

destructor TViewControllerCondicaPagamento.Destroy;
begin
  inherited;
end;

//verifico se existe condicaopagamento na tabela(existindo retorno True)
function TViewControllerCondicaPagamento.BuscarPorNome(Value: String): Boolean;
begin
  Result := False;
  FController
    .FactoryDAO
      .DAOCondicaoPagamento
        .This
          .NomeCondicaoPagamento(Value)
        .&End
      .GetbyParams
      .DataSet(FDSCondicaoPagamento);
  Result := not FDSCondicaoPagamento.DataSet.IsEmpty;
end;

//verifico se existe condicaopagamentopai (existindo retorno True)
function TViewControllerCondicaPagamento.BuscarPorIdPai(Value: Variant): Boolean;
begin
  Result := False;
  FController
    .FactoryDAO
      .DAOCondicaoPagamento
        .GetbyId(Value)
      .DataSet(FDSCondicaoPagamentoItem);
  Result := not FDSCondicaoPagamentoItem.DataSet.IsEmpty;
end;

//verifico se existe condicaopagamentoitem (existindo retorno True)
function TViewControllerCondicaPagamento.BuscarPorIdFilho(Value: Variant): Boolean;
begin
  Result := False;
  FController
    .FactoryDAO
      .DAOCondicaoPagamentoItem
        .This
          .IdCondicaoPagamento(Value)
        .&End
      .GetbyParams
      .DataSet(FDSCondicaoPagamentoItem);
  Result := not FDSCondicaoPagamentoItem.DataSet.IsEmpty;
end;

//loop condicaopagamento tabela pai
procedure TViewControllerCondicaPagamento.LoopCondicaoPagamento;
begin
  FJSONArrayPai := TJSONArray.Create;//JSONArray tabela pai empresa
  FDSCondicaoPagamento.DataSet.First;
  while not FDSCondicaoPagamento.DataSet.Eof do
  begin
    FJSONObjectPai := TJSONObject.Create;//JSONObject tabela pai empresa
    try
      FJSONObjectPai := FDSCondicaoPagamento.DataSet.ToJSONObject;
    except
      on E: Exception do
      begin
        WriteLn('Erro ao converter DataSet para JSONObject: ' + E.Message);
        Break;
      end;
    end;

    try
      if LoopCondicaoPagamentoItem then
        if FQuantidadeRegistro > 1 then
          FJSONObjectPai.AddPair('condicaopagamentoitem' , FJSONArrayFilho) else
          FJSONObjectPai.AddPair('condicaopagamentoitem' , FJSONObjectFilho);
    except
      on E: Exception do
      begin
        WriteLn('Erro durante o loop de condicaopagamentoitem, verificar as instru��es SQL no DAOCondicaoPagamentoItem: ' + E.Message);
        Break;
      end;
    end;

    FJSONArrayPai.Add(FJSONObjectPai);
    FDSCondicaoPagamento.DataSet.Next;
  end;
end;

//Loop condicaopagamentoitem tabela filho
function TViewControllerCondicaPagamento.LoopCondicaoPagamentoItem : Boolean;
begin
  Result := False;
  FQuantidadeRegistro := FController
                           .FactoryDAO
                             .DAOCondicaoPagamentoItem
                               .GetbyId(FDSCondicaoPagamento.DataSet.FieldByName('id').AsInteger)
                               .DataSet(FDSCondicaoPagamentoItem)
                             .QuantidadeRegistro;

  if not FDSCondicaoPagamentoItem.DataSet.IsEmpty then
  begin
    Result := True;
    FJSONArrayFilho := TJSONArray.Create;

    FDSCondicaoPagamentoItem.DataSet.First;
    while not FDSCondicaoPagamentoItem.DataSet.Eof do
    begin
      FJSONObjectFilho := TJSONObject.Create;
      FJSONObjectFilho := FDSCondicaoPagamentoItem.DataSet.ToJSONObject;
      //tendo mais de um registro, adiciona ao array
      if FQuantidadeRegistro > 1 then
        FJSONArrayFilho.Add(FJSONObjectFilho);

      FDSCondicaoPagamentoItem.DataSet.Next;
    end;
  end;
end;

procedure TViewControllerCondicaPagamento.GetAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lQuantidadeRegistro : Integer;
begin
  lQuantidadeRegistro := 0;
  try
    if Req.Query.Field('nomecondicacaopagamento').AsString<>'' then
      lQuantidadeRegistro := FController
                               .FactoryDAO
                                 .DAOCondicaoPagamento
                                   .This
                                     .NomeCondicaoPagamento(Req.Query.Field('nomecondicaopagamento').AsString)
                                   .&End
                                 .GetbyParams
                                 .DataSet(FDSCondicaoPagamento)
                                 .QuantidadeRegistro
    else
      lQuantidadeRegistro := FController
                               .FactoryDAO
                                 .DAOCondicaoPagamento
                                   .GetAll
                                   .DataSet(FDSCondicaoPagamento)
                                   .QuantidadeRegistro;

  except
    on E: Exception do
    begin
      Res.Status(500).Send('Ocorreu um erro interno no servidor: '+ E.Message);
      Exit;
    end;
  end;

  if not FDSCondicaoPagamento.DataSet.IsEmpty then
  begin
    LoopCondicaoPagamento;

    if lQuantidadeRegistro > 1 then
      Res.Send<TJSONArray>(FJSONArrayPai) else
      Res.Send<TJSONObject>(FJSONObjectPai);

    Res.Status(201).Send('Registro encontrado com sucesso!');
  end
  else
    Res.Status(400).Send('Registro n�o encontrado!');
end;

procedure TViewControllerCondicaPagamento.GetbyId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    FController
      .FactoryDAO
        .DAOCondicaoPagamento
          .GetbyId(Req.Params['id'].ToInt64)
          .DataSet(FDSCondicaoPagamento);

    FJSONObjectPai := FDSCondicaoPagamento.DataSet.ToJSONObject();
    Res.Send<TJSONObject>(FJSONObjectPai);
  except
    on E: Exception do
    begin
      Res.Status(500).Send('Ocorreu um erro interno no servidor'+E.Message);
      Exit;
    end;
  End;

  if not FDSCondicaoPagamento.DataSet.IsEmpty then
  begin
    LoopCondicaoPagamento;
    Res.Send<TJSONObject>(FJSONObjectPai);
    Res.Status(201).Send('Registro encontrado com sucesso!');
  end
  else
    Res.Status(400).Send('Registro n�o encontrado!');
end;

procedure TViewControllerCondicaPagamento.Post(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  LJSONObjectPai   : TJSONObject;//JSONObect->condicaopagamento
  LJSONArrayFilho  : TJSONArray; //JSONArray->condicaopagamentoitem
  LJSONObjectFilho : TJSONObject;//JSONObect->condicaopagamentoitem
  I : Integer;
begin
  //L� os dados JSON da requisi��o (tabela pai='condicaopagamento, caso existir o registro saio do c�digo')
  LJSONObjectPai := TJSONObject.ParseJSONValue(Req.Body) as TJSONObject;
  try
    if BuscarPorNome(LJSONObjectPai.GetValue<String>('nomecondicaopagamento')) then
    begin
      Res.Status(400).Send('Esta condi��o de pagamento j� consta em nossa base de dados!');
      Exit;
    end;
  except
   on E: Exception do
   begin
      Res.Status(500).Send('Ocorreu um erro interno no servidor.'+ E.Message);
      Exit;
   end;
  end;

  //tabela pai
  LJSONObjectPai := Req.Body<TJSONObject>;
  try
    try
      try
        FController
          .FactoryDAO
            .DAOCondicaoPagamento
              .This
                .IdEmpresa            (LJSONObjectPai.GetValue<Integer>  ('idempresa'))
                .IdUsuario            (LJSONObjectPai.GetValue<Integer>  ('idusuario'))
                .NomeCondicaoPagamento(LJSONObjectPai.GetValue<String>   ('nomecondicaopagamento'))
                .QuantidadePagamento  (LJSONObjectPai.GetValue<Integer>  ('quantidadepagamento'))
                .TotalDias            (LJSONObjectPai.GetValue<Integer>  ('totaldias'))
                .PrazoMedio           (LJSONObjectPai.GetValue<Integer>  ('prazomedio'))
                .DataHoraEmissao      (LJSONObjectPai.GetValue<TDateTime>('datahoraemissao'))
              .&End
            .Post
            .DataSet(FDSCondicaoPagamento);
          FIdCondicaoPagamento := FDSCondicaoPagamento.DataSet.FieldByName('id').AsInteger;
      except
        on E: Exception do
        begin
          Res.Status(500).Send('Ocorreu um erro interno no servidor.');
          Exit;
        end;
      end;

      //Obt�m os dados JSON do corpo da requisi��o da tabela('endereco')
      LJSONArrayFilho := LJSONObjectPai.GetValue('condicaopagamentoitem') as TJSONArray;

      // Loop do(s) endere�o(s)
      for I := 0 to LJSONArrayFilho.Count - 1 do
      begin
        Try
          //Extraindo os dados do endere�o e salvando no banco de dados
          LJSONObjectFilho := LJSONArrayFilho.Items[I] as TJSONObject;
          //verificando se j� consta este condicaopagamento cadastrado na tabela filho.
          if not BuscarPorIdFilho(LJSONObjectFilho.GetValue<Integer>('idcondicaopagamento')) then
            FController
              .FactoryDAO
                .DAOCondicaoPagamentoItem
                  .This
                    .IdCondicaoPagamento(FIdCondicaoPagamento)
                    .NumeroPagamento    (LJSONObjectFilho.GetValue<Integer>('numeropagamento'))
                    .QuantidadeDias     (LJSONObjectFilho.GetValue<Integer>('quantidadedias'))
                  .&End
                .Post
                .DataSet(FDSCondicaoPagamentoItem);
        except
          on E: Exception do
          begin
            if BuscarPorIdPai(FIdCondicaoPagamento) then// caso de erro, excluo o registro que foi salvo na tabela pai
              FController
                .FactoryDAO
                  .DAOCondicaoPagamento
                    .This
                      .Id(FIdCondicaoPagamento)
                    .&End
                  .Delete;
            Res.Status(500).Send('Ocorreu um erro interno no servidor.');
            Exit;
          end;
        end;
        //caso n�o der nada errad ->Update tabela pai colunas-totaldias; prazomedio
        FController
          .FactoryDAO
            .DAOCondicaoPagamento
              .This
                .id(FIdCondicaoPagamento)
              .&End
            .Put(Self);
      end;
    //tratando erro final
    except
      on E: Exception do
      begin
        if BuscarPorIdPai(FIdCondicaoPagamento) then//excluir o registro que foi salvo na tabela pa
        FController
          .FactoryDAO
            .DAOCondicaoPagamento
              .This
                .Id(FIdCondicaoPagamento)
              .&End
            .Delete;//exclu�ndo condicaopagamento lan�ado
        Res.Status(500).Send('Ocorreu um erro interno no servidor.');
        Exit;
      end;
    end;
  finally
    FJSONObjectPai := FDSCondicaoPagamento.DataSet.ToJSONObject();
    Res.Send<TJSONObject>(FJSONObjectPai);
    Res.Status(204).Send('Registro inclu�do com sucesso!');
  end;
end;

procedure TViewControllerCondicaPagamento.Put(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  LJSONObjectPai   : TJSONObject;//JSONObect->condicaopagamento
  LJSONArrayFilho  : TJSONArray; //JSONArray->condicaopagamentoitem
  LJSONObjectFilho : TJSONObject;//JSONObect->condicaopagamentoitem
  I : Integer;
begin
  LJSONObjectPai := Req.Body<TJSONObject>; //Tabela Pai Empresa
  try
    try
      FController
        .FactoryDAO
          .DAOCondicaoPagamento
            .This
              .Id                   (LJSONObjectPai.GetValue<Integer>('id'))
              .IdEmpresa            (LJSONObjectPai.GetValue<Integer>('idempresa'))
              .IdUsuario            (LJSONObjectPai.GetValue<Integer>('idusuario'))
              .NomeCondicaoPagamento(LJSONObjectPai.GetValue<String> ('nomecondicaopagamento'))
              .QuantidadePagamento  (LJSONObjectPai.GetValue<Integer>('quantidadepagamento'))
              .TotalDias            (LJSONObjectPai.GetValue<Integer>('totaldias'))
              .PrazoMedio           (LJSONObjectPai.GetValue<Integer>('prazomedio'))
            .&End
          .Put
          .DataSet(FDSCondicaoPagamento);
          FIdCondicaoPagamento := LJSONObjectPai.GetValue<Integer>('id');
    except
      on E: Exception do
        Res.Status(500).Send('Ocorreu um erro interno no servidor.'+ E.Message);
    end;

    //Obt�m os dados JSON do corpo da requisi��o da tabela('condicaopagamentoitem')
    LJSONArrayFilho := LJSONObjectPai.Get('condicaopagamentoitem').JsonValue as TJSONArray;
    // Loop do(s) endere�o(s)
    for I := 0 to LJSONArrayFilho.Count - 1 do
    begin
      Try
        LJSONObjectFilho := LJSONArrayFilho.Items[I] as TJSONObject;
        FController
          .FactoryDAO
            .DAOCondicaoPagamentoItem
              .This
                .Id                 (LJSONObjectFilho.GetValue<Integer>('id'))
                .IdCondicaoPagamento(FIdCondicaoPagamento)
                .NumeroPagamento    (LJSONObjectFilho.GetValue<Integer>('numeropagamento'))
                .QuantidadeDias     (LJSONObjectFilho.GetValue<Integer>('quantidadedias'))
              .&End
            .Put
            .DataSet(FDSCondicaoPagamentoItem);

      except
        on E: Exception do
          Res.Status(500).Send('Ocorreu um erro interno no servidor.'+ E.Message);
      end;
      //caso n�o der nada errad ->Update tabela pai colunas-totaldias; prazomedio
      FController
        .FactoryDAO
          .DAOCondicaoPagamento
            .This
              .id(FIdCondicaoPagamento)
            .&End
          .Put(Self);
    end;
  finally
    Res.Status(204).Send('Registro alterado com sucesso!');
  end;
end;

procedure TViewControllerCondicaPagamento.Delete(Req: THorseRequest;  Res: THorseResponse; Next: TProc);
begin
  try
    FController
      .FactoryDAO
        .DAOCondicaoPagamento
          .This
            .Id(Req.Params['id'].ToInt64)
          .&End
          .Delete
          .DataSet(FDSCondicaoPagamento);
    except
      on E: Exception do
      raise Res.Status(500).Send('Ocorreu um erro interno no servidor.'+ E.Message);
  End;
    Res.Status(204).Send('Registro exclu�do com sucesso!');
end;

procedure TViewControllerCondicaPagamento.Registry;
begin
  THorse
      .Group
        .Prefix  ('bmw')
          .Get   ('/condicao-pagamento'     , GetAll)
          .Get   ('/condicao-pagamento/:id' , GetbyId)
          .Post  ('condicao-pagamento'      , Post)
          .Put   ('condicao-pagamento/:id'  , Put)
          .Delete('condicao-pagamento/:id'  , Delete);
end;

end.


