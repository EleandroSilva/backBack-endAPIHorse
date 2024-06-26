unit View.Swagger.Cabecalho.Documentacao;

interface

uses
  Horse.GBSwagger,
  View.API.Error;

procedure ConfiguracaoSwagger;

implementation

procedure ConfiguracaoSwagger;
begin
  //http://localhost:9000/swagger/doc/html   URL
  //Configura��o do cabe�alho para toda minha API
  //para eu n�o precisar configurar o cabe�alho
  //em todos os controller
  Swagger
    .Info
      .Title('API PDV Be More Web')
      .Description('Documenta��o da API PDV Be More Web')
      .Contact
        .Name('Eleandro Silva')
        .Email('eleandrosilva3107@gmail.com')
        .URL('https://www.bemoreweb.com.br')
      .&End
      .&End
      .BasePath('bmw')
      .Register
        .SchemaOnError(TAPIError);
end;

initialization
  ConfiguracaoSwagger;

end.
