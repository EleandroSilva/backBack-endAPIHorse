{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            In�cio do projeto 15/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Swagger.Caixa;

interface

uses
  Horse.GBSwagger,
  Entidade.Swagger.Caixa;
type
  TSwaggerCaixa = class
   private
   public
     class procedure SwaggerCaixa;
  end;

implementation

{ TSwaggerCaixa }

class procedure TSwaggerCaixa.SwaggerCaixa;
begin
  Swagger
    .Path('caixa')//nome do meu Path
      .Tag('Caixa')//agrupando meus Endpoint Tag do Path Caixa
        .GET('Listar todos', 'Listo todos os caixas')
          .AddResponse(201, 'lista dos Caixa encontrada com sucesso!')//Aqui passo a resposta do Path
            .Schema(TCaixa)//A resposta seria do objeto CaixaDiario
            .IsArray(True)//Como � um GET ALL passo um Array=True
      .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
    .&End
    .POST('Adicionar um novo Caixa!')
      .AddParamBody('Dados do Caixa')
        .Schema(TCaixa)
      .&End
          .AddResponse(201)
          .Schema(TCaixa)
        .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
      .&End
    .&End
    .Path('caixa/{id}')
      .Tag('Caixa')
        .GET('encontrar caixa por id')
          .AddParamPath('id', 'Id do Caixa')
            .Schema(SWAG_INTEGER)
          .&End
          .AddResponse(201, 'Registro encontrada com sucesso!').&End
          .AddResponse(400).&End//erro de valida��o
          .AddResponse(404).&End//id inv�lido
          .AddResponse(500).&End//erro banco de dados
    .&End
    .PUT('Update caixa')
      .AddParamPath('Update Caixa', 'id do Caixa')
        .Schema(SWAG_INTEGER)
      .&End
      .AddParamBody('CaixaDiario', 'Dados do Caixa')
        .Schema(TCaixa)
      .&End
      .AddResponse(204,'Altera��o realizada com sucesso!').&End//sucesso na altera��o
      .AddResponse(400).&End//erro de valida��o
      .AddResponse(404).&End//id inv�lido
      .AddResponse(500).&End//erro banco
    .&End
    .DELETE('Delete caixa')
      .AddParamPath('id', 'id do Caixa')
        .Schema(SWAG_INTEGER)
    .&End
      .AddResponse(204,'Registro exclu�do com sucesso!').&End//sucesso na exclus�o
      .AddResponse(400).&End//erro de valida��o
      .AddResponse(404).&End//id inv�lido
      .AddResponse(500).&End//erro banco
    .&End
    .&End
    .&End
    .Path('caixa?nomeusuario')
      .Tag('Caixa')
        .GET('encontrar Caixa por Nome usu�rio')
          .AddParamQuery('nomeusuario','Nome usu�rio')
          .Schema(SWAG_STRING)
          .&End
          .AddResponse(201, 'Registro encontrada com sucesso!').&End
          .AddResponse(400).&End//erro de valida��o
          .AddResponse(404).&End//id inv�lido
          .AddResponse(500).&End//erro banco de dados
    .&End;
end;

end.
