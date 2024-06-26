{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 23/04/2024 08:32           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Controller.Fechar.Caixa;

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
  TViewControllerFecharCaixa= class
    private
      FController    : iController;
      FDSFecharCaixa : TDataSource;

      FBody       : TJSONValue;
      FJSONObject : TJSONObject;
      FJSONArray  : TJSONArray;
      //Json Fechar Caixa
      FJSONObjectFecharCaixa : TJSONObject;
      FJSONArrayFecharCaixa  : TJSONArray;

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

{ TViewControllerFecharCaixa }

constructor TViewControllerFecharCaixa.Create;
begin
  FController    := TController.New;
  FDSFecharCaixa := TDataSource.Create(nil);
  Registry;
end;

destructor TViewControllerFecharCaixa.Destroy;
begin
  inherited;
end;

procedure TViewControllerFecharCaixa.GetAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lQuantidadeRegistro : Integer;
begin
  lQuantidadeRegistro := 0;
  try
    try
      if Req.Query.Field('nomeusuario').AsString<>'' then
        lQuantidadeRegistro := FController
                                 .FactoryDAO
                                   .DAOFecharCaixa
                                     .This
                                       .Usuario
                                         .NomeUsuario(Req.Query.Field('nomeusuario').AsString)
                                         .&End
                                       .&End
                                     .GetbyParams
                                   .DataSet(FDSFecharCaixa)
                                   .QuantidadeRegistro
      else
        lQuantidadeRegistro := FController
                                 .FactoryDAO
                                   .DAOFecharCaixa
                                     .GetAll
                                   .DataSet(FDSFecharCaixa)
                                   .QuantidadeRegistro;

    if lQuantidadeRegistro > 1  then
     begin
       FJSONArray := FDSFecharCaixa.DataSet.ToJSONArray();
       Res.Send<TJSONArray>(FJSONArray);
     end
     else
     begin
       FJSONObject := FDSFecharCaixa.DataSet.ToJSONObject();
       Res.Send<TJSONObject>(FJSONObject);
     end;
    except
      on E: Exception do
      begin
        Res.Status(500).Send('Ocorreu um erro interno no servidor'+E.Message);
        Exit;
      end;
    end;
  finally
    if not FDSfecharCaixa.DataSet.IsEmpty then
    begin
      //LoopCaixaDiario;
      if lQuantidadeRegistro > 1 then
        Res.Send<TJSONArray>(FJSONArrayFecharCaixa) else
        Res.Send<TJSONObject>(FJSONObjectFecharCaixa);
      Res.Status(201).Send('Registro encontrado com sucesso!');
    end
    else
    begin
      Res.Send<TJSONObject>(FJSONObjectFecharCaixa);
      Res.Status(400).Send('Registro n�o encontrado!');
    end;
  end;
end;

procedure TViewControllerFecharCaixa.GetbyId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FController
        .FactoryDAO
          .DAOFecharCaixa
            .GetbyId(Req.Params['id'].ToInt64)
          .DataSet(FDSFecharCaixa)
    except
      on E: Exception do
      begin
        Res.Status(500).Send('Ocorreu um erro interno no servidor'+E.Message);
        Exit;
      end;
    end;
  finally
    if not FDSFecharCaixa.DataSet.IsEmpty then
    begin
      FJSONObject := FDSFecharCaixa.DataSet.ToJSONObject();
      Res.Send<TJSONObject>(FJSONObjectFecharCaixa);
      Res.Status(201).Send('Registro encontrado com sucesso!');
    end
    else
    begin
      Res.Send<TJSONObject>(FJSONObjectFecharCaixa);
      Res.Status(400).Send('Registro n�o encontrado!');
    end;
  end;
end;

procedure TViewControllerFecharCaixa.Post(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FJSONObjectfecharCaixa := Req.Body<TJSONObject>;
      FController
        .FactoryDAO
          .DAOFecharCaixa
            .This
              .IdCaixa        (FJSONObjectfecharCaixa.GetValue<integer>  ('idcaixa'))
              .IdUsuario      (FJSONObjectfecharCaixa.GetValue<Integer>  ('idusuario'))
              .ValorLancado   (FJSONObjectfecharCaixa.GetValue<Currency> ('valorlancado'))
              .DataHoraEmissao(FJSONObjectfecharCaixa.GetValue<TDateTime>('datahoraemissao'))
              .Observacao     (FJSONObjectfecharCaixa.GetValue<string>   ('observacao'))
            .&End
          .Post;
      //altero o status do caixa para caixa fechado
      FController
        .FactoryDAO
          .DAOCaixa
            .This
              .Id    (FJSONObjectFecharCaixa.GetValue<Integer>('idcaixa'))
              .Status('F')
            .&End
          .Put;
  except
    on E: Exception do
    begin
      Res.Send<TJSONObject>(FJSONObjectFecharCaixa);
      Res.Status(500).Send('Ocorreu um erro interno no servidor'+E.Message);
      Exit;
    end;
  end;
  finally
    Res.Send<TJSONObject>(FJSONObjectFecharCaixa);
    Res.Status(204).Send('Registro inclu�do com sucesso!');
  end;
end;

procedure TViewControllerFecharCaixa.Put(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FJSONObjectFecharCaixa := Req.Body<TJSONObject>;
      FController
        .FactoryDAO
          .DAOFecharCaixa
            .This
              .Id          (FJSONObjectFecharCaixa.GetValue<Integer> ('id'))
              .ValorLancado(FJSONObjectFecharCaixa.GetValue<Currency>('valorlancado'))
              .Observacao  (FJSONObjectfecharCaixa.GetValue<string>  ('observacao'))
            .&End
          .Put;
      //altero o status do caixa para caixa fechado
      FController
        .FactoryDAO
          .DAOCaixa
            .This
              .Id    (FJSONObjectFecharCaixa.GetValue<Integer>('idcaixa'))
              .Status('F')
            .&End
          .Put;
  except
    on E: Exception do
    begin
      Res.Send<TJSONObject>(FJSONObjectFecharCaixa);
      Res.Status(500).Send('Ocorreu um erro interno no servidor'+E.Message);
      Exit;
    end;
  end;
  finally
    Res.Send<TJSONObject>(FJSONObjectFecharCaixa);
    Res.Status(204).Send('Registro alterado com sucesso!');
  end;
end;


procedure TViewControllerFecharCaixa.Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try
      FController
        .FactoryDAO
          .DAOFecharCaixa
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
    Res.Send<TJSONObject>(FJSONObjectFecharCaixa);
    Res.Status(204).Send('Registro exclu�do com sucesso!');
  end;
end;

procedure TViewControllerFecharCaixa.Registry;
begin
  THorse
      .Group
        .Prefix  ('bmw')
          .Get   ('/fechar-caixa/:id' , GetbyId)
          .Get   ('/fechar-caixa'     , GetAll)
          .Post  ('fechar-caixa'      , Post)
          .Put   ('fechar-caixa/:id'  , Put)
          .Delete('fechar-caixa/:id'  , Delete);
end;

end.
