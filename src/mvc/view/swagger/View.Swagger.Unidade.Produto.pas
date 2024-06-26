{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            In�cio do projeto 17/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Swagger.Unidade.Produto;

interface

uses
  Horse.GBSwagger,
  Entidade.Swagger.Unidade.Produto;
type
  TSwaggerUnidadeProduto = class
   private
   public
     class procedure SwaggerUnidadeProduto;
  end;

implementation

{ TSwaggerUnidadeProduto }

class procedure TSwaggerUnidadeProduto.SwaggerUnidadeProduto;
begin

  Swagger
    .Path('unidade-produto')//nome do meu Path
      .Tag('Unidade do produto')//agrupando meus Endpoint Tag do Path unidadeproduto
        .GET('Listar todos', 'Listo todas as unidades dos produtos')
          .AddResponse(201, 'lista de todas unidades dos produtos encontrada com sucesso!')//Aqui passo a resposta do Path
            .Schema(TunidadeProduto)//A resposta seria do objeto unidadeproduto
            .IsArray(True)//Como � um GET ALL passo um Array=True
      .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
    .&End
    .POST('Adicionar uma nova unidade de produto!')
      .AddParamBody('Dados da unidade dos produtos')
        .Schema(TunidadeProduto)
      .&End
          .AddResponse(201)
          .Schema(TunidadeProduto)
        .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
      .&End
    .&End
    .Path('unidade-produto/{id}')
      .Tag('Unidade do produto')
        .GET('encontrar unidade do produto por id')
          .AddParamPath('id', 'Id da unidade do produto')
            .Schema(SWAG_INTEGER)
          .&End
          .AddResponse(201).&End
          .AddResponse(400).&End//erro de valida��o
          .AddResponse(404).&End//id inv�lido
          .AddResponse(500).&End//erro banco de dados
    .&End
    .PUT('Update unidadeproduto')
      .AddParamPath('Update unidadeproduto', 'id da unidade do produto')
        .Schema(SWAG_INTEGER)
      .&End
      .AddParamBody('unidadeproduto', 'Dados da unidade do produto')
        .Schema(TunidadeProduto)
      .&End
      .AddResponse(204,'Altera��o realizada com sucesso!').&End//sucesso na altera��o
      .AddResponse(400).&End//erro de valida��o
      .AddResponse(404).&End//id inv�lido
      .AddResponse(500).&End//erro banco
    .&End
    .DELETE('Delete unidadeproduto')
      .AddParamPath('id', 'id da unidade do produto')
        .Schema(SWAG_INTEGER)
    .&End
      .AddResponse(204,'Exclus�o realizada com sucesso!').&End//sucesso na exclus�o
      .AddResponse(400).&End//erro de valida��o
      .AddResponse(404).&End//id inv�lido
      .AddResponse(500).&End//erro banco
    .&End
    .&End
    .Path('unidade-produto?nomeunidade')
      .Tag('Unidade do produto')
        .GET('encontrar unidade do produto pelo nome da unidade')
          .AddParamQuery('nomeunidade', 'Nome da unidade do produto a ser filtrado')//, TSwagStringFormat.FormatString);
           .Schema(SWAG_STRING)
          .&End
          .AddResponse(201, 'Registro encontrado com sucesso!').&End
          .AddResponse(400).&End//erro de valida��o
          .AddResponse(404).&End//id inv�lido
          .AddResponse(500).&End//erro banco de dados
    .&End;
end;

end.
