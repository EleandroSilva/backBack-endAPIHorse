unit Model.DAO.Count.Interfaces;

interface

uses
  Data.DB;

type
  iDAOCount = interface
    ['{C63F270E-1B45-404D-B0AA-83A98FD9C4E7}']
    function DataSet    (DataSource : TDataSource) : iDAOCount; overload;
    function DataSet                               : TDataSet;  overload;
    function NomeTabela (Value : String)           : iDAOCount; overload;
    function NomeTabela                            : String;    overload;
    function NomeColuna (Value : String)           : iDAOCount; overload;
    function NomeColuna                            : String;    overload;
    function ValorColuna(Value : String)           : iDAOCount; overload;
    function ValorColuna                           : String;    overload;
    function IdEmpresa  (Value : Integer)          : iDAOCount; overload;
    function IdEmpresa                             : Integer;   overload;
    function QuantidadeRegistro                    : Integer;

    function GetCount                                                    : iDAOCount; overload;
    function GetCount(Coluna : String; Value: Integer)                   : iDAOCount; overload;
    function GetCount(Coluna, Coluna1 : String; Value : Integer; Value1 : String) : iDAOCount; overload;
    function GetCount(Coluna, Coluna1, Coluna2 : String; Value : Integer; Value1, Value2 : String) : iDAOCount; overload;
  end;

implementation

end.
