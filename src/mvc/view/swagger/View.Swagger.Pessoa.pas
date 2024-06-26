{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            In�cio do projeto 18/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2023                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit View.Swagger.Pessoa;

interface

uses
  Horse.GBSwagger,
  Entidade.Swagger.Pessoa;
type
  TSwaggerPessoa = class
   private
   public
     class procedure SwaggerPessoa;
  end;

implementation

{ TSwaggerPessoa }

class procedure TSwaggerPessoa.SwaggerPessoa;
begin
  Swagger
    .Path('pessoa')//nome do meu Path
      .Tag('pessoa')//agrupando meus Endpoint Tag do Path Pessoa
        .GET('Listar todas', 'Listo todas as Pessoas')
          .AddResponse(201, 'lista de Pessoa encontrada com sucesso!')//Aqui passo a resposta do Path
            .Schema(TPessoa)//A resposta seria do objeto Pessoa
            .IsArray(True)//Como � um GET ALL passo um Array=True
      .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
    .&End
    .POST('Adicionar uma nova Pessoa!')
      .AddParamBody('Dados da Pessoa')
        .Schema(TPessoa)
      .&End
          .AddResponse(201)
          .Schema(TPessoa)
        .&End
          .AddResponse(400).&End
          .AddResponse(404).&End
          .AddResponse(500).&End
      .&End
    .&End
    .Path('pessoa/{id}')
      .Tag('pessoa')
        .GET('encontrar Pessoa por id')
          .AddParamPath('id', 'id da pessoa')
            .Schema(SWAG_INTEGER)
          .&End
          .AddResponse(201, 'Pessoa encontrada com sucesso!').&End
          .AddResponse(400).&End//erro de valida��o
          .AddResponse(404).&End//id inv�lido
          .AddResponse(500).&End//erro banco de dados
    .&End
    .PUT('Update pessoa')
      .AddParamPath('id', 'id da Pessoa')
        .Schema(SWAG_INTEGER)
          .&End
        .AddParamBody('Pessoa', 'Dados da Pessoa')
          .Schema(TPessoa)
        .&End
        .AddResponse(204).&End//sucesso na exclus�o
        .AddResponse(400).&End//erro de valida��o
        .AddResponse(404).&End//id inv�lido
        .AddResponse(500).&End//erro banco
    .&End
    .DELETE('Delete pessoa')
      .AddParamPath('id', 'id da Pessoa')
        .Schema(SWAG_INTEGER)
    .&End
    .&End
    .&End
    .Path('pessoa?cpfcnpj')
      .Tag('pessoa')
        .GET('encontrar Pessoa por cpfcnpj')
          .AddParamQuery('cpfcnpj', 'CPF ou CNPJ da Pessoa a ser filtrada')//, TSwagStringFormat.FormatString);
           .Schema(SWAG_STRING)
          .&End
          .AddResponse(201, 'Pessoa encontrada com sucesso!').&End
          .AddResponse(400).&End//erro de valida��o
          .AddResponse(404).&End//id inv�lido
          .AddResponse(500).&End//erro banco de dados
    .&End
    .&End
    .&End
    .Path('pessoa?nomepessoa')
      .Tag('pessoa')
        .GET('encontrar Pessoa por Nome Pessoa Pessoa')
          .AddParamQuery('nomepessoa','Nome Pessoa Pessoa')
           .Schema(SWAG_STRING)
          .&End
          .AddResponse(201, 'Pessoa encontrada com sucesso!').&End
          .AddResponse(400).&End//erro de valida��o
          .AddResponse(404).&End//id inv�lido
          .AddResponse(500).&End//erro banco de dados
    .&End
end;



end.
