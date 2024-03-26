unit UCadMovimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.ComCtrls, UMovimentoRel;

type
  TMovimentoForm = class(TForm)
    TanquesPanel: TPanel;
    Panel1: TPanel;
    TanquesDBGrid: TDBGrid;
    DeletarButton: TButton;
    MovimentoFDQuery: TFDQuery;
    MovimentoDataSource: TDataSource;
    InicialDateTimePicker: TDateTimePicker;
    FinalDateTimePicker: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    TanqueDBLookupComboBox: TDBLookupComboBox;
    Label3: TLabel;
    Label4: TLabel;
    BombasDBLookupComboBox: TDBLookupComboBox;
    TanqueFDQuery: TFDQuery;
    TanqueDataSource: TDataSource;
    BombaFDQuery: TFDQuery;
    BombaDataSource: TDataSource;
    TanqueFDQueryCOD_TANQUE: TIntegerField;
    TanqueFDQueryDESCRICAO: TStringField;
    BombaFDQueryCOD_BOMBA: TIntegerField;
    BombaFDQueryDESCRICAO: TStringField;
    MovimentoFDQueryCOD_BOMBA: TIntegerField;
    MovimentoFDQueryNOME_BOMBA: TStringField;
    MovimentoFDQueryCOD_TANQUE: TIntegerField;
    MovimentoFDQueryNOME_TANQUE: TStringField;
    MovimentoFDQueryTIPO: TStringField;
    MovimentoFDQueryVALOR_TOTAL: TFMTBCDField;
    MovimentoFDQueryTOTAL_LITROS: TFMTBCDField;
    MovimentoFDQueryDATA_ABASTECIMENTO: TDateField;
    LimparCamposButton: TButton;
    ImprimirButton: TButton;
    TotaisFDQuery: TFDQuery;
    TotaisDataSource: TDataSource;
    TotaisFDQueryTOTAL_LITROS: TFMTBCDField;
    TotaisFDQueryVALOR_TOTAL: TFMTBCDField;
    TotaisFDQueryDATA_ABASTECIMENTO: TDateField;
    procedure FormShow(Sender: TObject);
    procedure DeletarButtonClick(Sender: TObject);
    procedure LimparCamposButtonClick(Sender: TObject);
    procedure ImprimirButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure AtualizaGrid;
    procedure DesabilitaCampos;
    procedure CalculaTotais;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MovimentoForm: TMovimentoForm;

implementation

{$R *.dfm}

{ TCadastroTanquesForm }

procedure TMovimentoForm.AtualizaGrid;
begin
   MovimentoFDQuery.Close;
   MovimentoFDQuery.SQL.Clear;
   MovimentoFDQuery.SQL.Add('SELECT BOM.cod_bomba, BOM.descricao AS NOME_BOMBA, TAN.cod_tanque, TAN.descricao AS NOME_TANQUE, CASE WHEN TAN.tipo = 0 THEN ''Gasolina'' WHEN TAN.tipo = 1 THEN ''Diesel'' ELSE ''Etanol'' end AS Tipo,');
   MovimentoFDQuery.SQL.Add('sum(ABA.valor_total) AS valor_total, SUM(ABA.total_litros) AS total_litros, DATA_ABASTECIMENTO');
   MovimentoFDQuery.SQL.Add(' FROM ABASTECIMENTOS ABA ');
   MovimentoFDQuery.SQL.Add('   JOIN BOMBAS  BOM ON (BOM.COD_BOMBA = ABA.COD_BOMBA)');
   MovimentoFDQuery.SQL.Add('   JOIN  TANQUES TAN ON (TAN.COD_TANQUE = ABA.COD_TANQUE)');
   MovimentoFDQuery.SQL.Add('WHERE ABA.data_abastecimento >=  :DATA_ABAS_INICIAL');
   MovimentoFDQuery.SQL.Add('and   ABA.data_abastecimento <=  :DATA_ABAS_FINAL');
   if (TanqueDBLookupComboBox.KeyValue  <> 999)  then
     MovimentoFDQuery.SQL.Add('AND  ABA.COD_TANQUE = :COD_TANQUE');
   if (BombasDBLookupComboBox.KeyValue <> 999)  then
     MovimentoFDQuery.SQL.Add('AND  ABA.COD_BOMBA = :COD_BOMBA');
   MovimentoFDQuery.SQL.Add('group by DATA_ABASTECIMENTO, BOM.cod_bomba,TAN.cod_tanque,TAN.tipo, BOM.descricao, TAN.descricao ');
   MovimentoFDQuery.ParamByName('DATA_ABAS_INICIAL').AsDate :=  InicialDateTimePicker.Date;
   MovimentoFDQuery.ParamByName('DATA_ABAS_FINAL').AsDate :=  FinalDateTimePicker.Date;
   if (TanqueDBLookupComboBox.KeyValue  <> 999)  then
     MovimentoFDQuery.ParamByName('COD_TANQUE').AsInteger := TanqueDBLookupComboBox.KeyValue;
   if (BombasDBLookupComboBox.KeyValue <> 999)  then
     MovimentoFDQuery.ParamByName('COD_BOMBA').AsInteger := BombasDBLookupComboBox.KeyValue;
   MovimentoFDQuery.Open;
   CalculaTotais;
end;



procedure TMovimentoForm.LimparCamposButtonClick(Sender: TObject);
begin
 FormShow(Sender);
end;

procedure TMovimentoForm.CalculaTotais;
begin
   TotaisFDQuery.Close;
   TotaisFDQuery.SQL.Clear;
   TotaisFDQuery.SQL.Add('SELECT SUM(ABA.total_litros) AS total_litros,SUM(ABA.valor_total) AS valor_total,DATA_ABASTECIMENTO');
   TotaisFDQuery.SQL.Add(' FROM ABASTECIMENTOS ABA ');
   TotaisFDQuery.SQL.Add('   JOIN BOMBAS  BOM ON (BOM.COD_BOMBA = ABA.COD_BOMBA)');
   TotaisFDQuery.SQL.Add('   JOIN  TANQUES TAN ON (TAN.COD_TANQUE = ABA.COD_TANQUE)');
   TotaisFDQuery.SQL.Add('WHERE ABA.data_abastecimento >=  :DATA_ABAS_INICIAL');
   TotaisFDQuery.SQL.Add('and   ABA.data_abastecimento <=  :DATA_ABAS_FINAL');
   if (TanqueDBLookupComboBox.KeyValue  <> 999)  then
     TotaisFDQuery.SQL.Add('AND  ABA.COD_TANQUE = :COD_TANQUE');
   if (BombasDBLookupComboBox.KeyValue <> 999)  then
     TotaisFDQuery.SQL.Add('AND  ABA.COD_BOMBA = :COD_BOMBA');
   TotaisFDQuery.SQL.Add('group by DATA_ABASTECIMENTO');
   TotaisFDQuery.ParamByName('DATA_ABAS_INICIAL').AsDate :=  InicialDateTimePicker.Date;
   TotaisFDQuery.ParamByName('DATA_ABAS_FINAL').AsDate :=  FinalDateTimePicker.Date;
   if (TanqueDBLookupComboBox.KeyValue  <> 999)  then
     TotaisFDQuery.ParamByName('COD_TANQUE').AsInteger := TanqueDBLookupComboBox.KeyValue;
   if (BombasDBLookupComboBox.KeyValue <> 999)  then
     TotaisFDQuery.ParamByName('COD_BOMBA').AsInteger := BombasDBLookupComboBox.KeyValue;
   TotaisFDQuery.Open;
end;

procedure TMovimentoForm.DeletarButtonClick(Sender: TObject);
begin
  AtualizaGrid;
end;

procedure TMovimentoForm.DesabilitaCampos;
begin
  DeletarButton.Enabled :=false;
end;

procedure TMovimentoForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MovimentoFDQuery.Close;
  MovimentoFDQuery.Free;
  MovimentoFDQuery := nil;
  BombaFDQuery.Close;
  BombaFDQuery.Free;
  BombaFDQuery:= nil;
  TanqueFDQuery.Close;
  TanqueFDQuery.Free;
  TanqueFDQuery:= nil;
  TotaisFDQuery.Close;
  TotaisFDQuery.Free;
  TotaisFDQuery:= nil;
end;

procedure TMovimentoForm.FormShow(Sender: TObject);
begin
   TanqueFDQuery.Close;
   TanqueFDQuery.Open;
   BombaFDQuery.Close;
   BombaFDQuery.Open;
   TanqueDBLookupComboBox.KeyValue := 999;
   BombasDBLookupComboBox.KeyValue := 999;
   AtualizaGrid;
end;



procedure TMovimentoForm.ImprimirButtonClick(Sender: TObject);
begin
  MovimentoRelForm := TMovimentoRelForm.Create(Application);
  try
    MovimentoRelForm.Periodo  := DateTimeToStr(InicialDateTimePicker.Date)+' Até '+ DateTimeToStr(FinalDateTimePicker.Date);
 //   if  TanqueDBLookupComboBox.KeyValue <> 999 then

    MovimentoRelForm.Tanques :=  TanqueDBLookupComboBox.Text;
    MovimentoRelForm.Bombas  :=  BombasDBLookupComboBox.Text;;
    MovimentoRelForm.MovimentosRLReport.Preview;
  finally
     MovimentoRelForm.Free;
  end;
end;

end.
