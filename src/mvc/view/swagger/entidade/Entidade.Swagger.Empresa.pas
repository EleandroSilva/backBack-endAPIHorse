{*******************************************************}
{                    API PDV - JSON                     }
{                      Be More Web                      }
{            In�cio do projeto 09/04/2024               }
{                 www.bemoreweb.com.br                  }
{                     (17)98169-5336                    }
{                        2003/2023                      }
{         Analista desenvolvedor (Eleandro Silva)       }
{*******************************************************}
unit Entidade.Swagger.Empresa;

interface

uses
  GBSwagger.Model.Attributes,
  System.Generics.Collections,
  Entidade.Swagger.Endereco,
  Entidade.Swagger.Numero,
  Entidade.Swagger.Email.Empresa,
  Entidade.Swagger.Telefone.Empresa,
  Entidade.Swagger.Natureza.Juridica,
  Entidade.Swagger.Usuario;


//Tabela que salva os clientes da empresa BeMoreWeb-Empresa que vai usar nosso sistema
type
  TEmpresa = class
    private
      FId                    : Integer;{bigint-Primary Key}
      FCNPJ                  : String; {Varchar(18)->Unique Key-Not Null}
      FInscricaoEstadual     : String; {Varchar(20)->Caso n�o existir informar (ISENTO) em mai�sculo}
      FNomeEmpresarial       : String; {Varchar(100)-> Not Null}
      FNomeFantasia          : String; {Varchar(100)}
      FIdNaturezaJuridica    : Integer; {bigint-}
      FDataHoraEmissao       : TDate;  {TDate-Data que foi cadastrada no sistema-Not Null}
      FDataSituacaoCadastral : TDate;  {TDate-Data da abertura da empresa-Not Null}
      FAtivo                 : Integer;{Integer->0-Inativo; 1-Ativo-Not Null}
      FUsuario               : TObjectList<TUsuario>;
      FEndereco              : TObjectList<TEndereco>;//crio a classe endereco
      FNumero                : TObjectList<TNumero>;
      FEMailEmpresa          : TObjectList<TEmailEmpresa>;//crio a classe emailempresa
      FTelefoneEmpresa       : TObjectList<TTelefoneEmpresa>;
    public
      [SwagParamQuery('id', true)]
      [SwagProp('PRIMARY KEY (auto_increment)', True)]
      [SwagProp(False, True)]
      property id : Integer  read FId                    write FId;
      [SwagProp('Varchar(18) Max18-Min18->Formato CNPJ 99.999.999/9999-99', True)]
      [SwagParamQuery('Varchar(18) Max18-Min18->Formato CNPJ 99.999.999/9999-99'),false,false]
      property cnpj                  : String   read FCNPJ                  write FCNPJ;
      [SwagProp('Varchar(20) Caso n�o existir informar em mai�sculo (ISENTO)', True)]
      property inscricaoestadual     : String   read FInscricaoEstadual     write FInscricaoEstadual;
      [SwagProp('Varchar(120) Max120-Min20->Nome da Empresa', True)]
      property nomeempresarial       : String   read FNomeEmpresarial       write FNomeEmpresarial;
      [SwagProp('Varchar(120) Max120-Min5->Nome fantasia', False)]
      property nomefantasia          : String   read FNomeFantasia          write FNomeFantasia;
      [SwagProp('(Bigint) Consultar em https://www.sintegra.gov.br/', False)]
      property idnaturezajuridica      : Integer read FIdNaturezaJuridica   write FIdNaturezaJuridica;
      [SwagDate('TDate YYYY-MM-DD')]
      [SwagRequired]
      [SwagProp('Data que esta cadastrando a empresa', True)]
      property datahoraemissao         : TDate    read FDataHoraEmissao     write FDataHoraEmissao;
      [SwagDate('TDate YYYY-MM-DD')]
      [SwagRequired]
      [SwagProp('Data da abertura da empresa. Encontrar no https://www.sintegra.gov.br/', True)]
      property datasituacaocadastral : TDate    read FDataSituacaoCadastral write FDataSituacaoCadastral;
      [SwagProp('(0-Intativo ou 1-Ativo)', True)]
      property ativo : Integer read FAtivo write FAtivo;
      //campos tabela de usuario
      property usuario : TObjectList<TUsuario> read FUsuario write FUsuario;
      //campos pertencem a tabela endereco
      property endereco : TObjectList<TEndereco> read FEndereco write FEndereco;
      property numero   : TObjectList<TNumero>   read FNumero   write FNumero;
      //campos tabela email da empresa
      property emailempresa   : TObjectList<TEmailEmpresa>     read FEMailEmpresa    write FEmailEmpresa;
      //campos tabela telefone da empresa
      property telefoneempresa : TObjectList<TTelefoneEmpresa> read FTelefoneEmpresa write FTelefoneEmpresa;
  end;

implementation


end.
