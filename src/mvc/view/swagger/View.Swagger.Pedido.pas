{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{          In�cio do projeto 26/04/2024 11:46           }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2024                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Swagger.Pedido;

interface

uses
  Horse.GBSwagger,
  Entidade.Swagger.Pedido;
type
  TSwaggerPedido = class
   private
   public
     class procedure SwaggerPedido;
  end;

implementation

{ TSwaggerPedido }

class procedure TSwaggerPedido.SwaggerPedido;
begin
  Swagger
    .Path('pedido')//nome do meu Path
      .Tag('pedido')//agrupando meus Endpoint Tag do Path pedido
        .GET('Listar todos', 'Listo todos os pedidos')
          .AddResponse(201, 'lista dos pedido encontrada com sucesso!')//Aqui passo a resposta do Path
            .Schema(TPedido)//A resposta seria do objeto pedido
            .IsArray(True)//Como � um GET ALL passo um Array=True
      .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
    .&End
    .POST('Adicionar um novo pedido!')
      .AddParamBody('Dados do pedido')
        .Schema(TPedido)
      .&End
          .AddResponse(201)
          .Schema(TPedido)
        .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
      .&End
    .&End
    .Path('pedido/{id}')
      .Tag('pedido')
        .GET('encontrar pedido por id')
          .AddParamPath('id', 'Id do pedido')
            .Schema(SWAG_INTEGER)
          .&End
          .AddResponse(201, 'Registro encontrada com sucesso!').&End
          .AddResponse(400).&End//erro de valida��o
          .AddResponse(404).&End//id inv�lido
          .AddResponse(500).&End//erro banco de dados
    .&End
    .PUT('Update pedido')
      .AddParamPath('Update pedido', 'id do pedido')
        .Schema(SWAG_INTEGER)
      .&End
      .AddParamBody('pedidoDiario', 'Dados do pedido')
        .Schema(TPedido)
      .&End
      .AddResponse(204,'Altera��o realizada com sucesso!').&End//sucesso na altera��o
      .AddResponse(400).&End//erro de valida��o
      .AddResponse(404).&End//id inv�lido
      .AddResponse(500).&End//erro banco
    .&End
    .DELETE('Delete pedido')
      .AddParamPath('id', 'id do pedido')
        .Schema(SWAG_INTEGER)
    .&End
      .AddResponse(204,'Registro exclu�do com sucesso!').&End//sucesso na exclus�o
      .AddResponse(400).&End//erro de valida��o
      .AddResponse(404).&End//id inv�lido
      .AddResponse(500).&End//erro banco
    .&End
    .&End
    .&End
    .Path('pedido?nomepessoa')
      .Tag('pedido')
        .GET('encontrar pedido por Nome pessoa(Cliente-Fornecedor-Ambos)')
          .AddParamQuery('nomepessoa','Nome pessoa')
          .Schema(SWAG_STRING)
          .&End
          .AddResponse(201, 'Registro encontrada com sucesso!').&End
          .AddResponse(400).&End//erro de valida��o
          .AddResponse(404).&End//id inv�lido
          .AddResponse(500).&End//erro banco de dados
    .&End
    .&End
    .&End
    .Path('pedido?nomeusuario')
      .Tag('pedido')
        .GET('encontrar pedido por Nome usu�rio')
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
