unit UCadBombas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.DBCtrls;

type
  TCadastroBombasForm = class(TForm)
    TanquesPanel: TPanel;
    Panel1: TPanel;
    TanquesDBGrid: TDBGrid;
    CodBombasLabeledEdit: TLabeledEdit;
    DescricaoLabeledEdit: TLabeledEdit;
    Label1: TLabel;
    SalvarButton: TButton;
    DeletarButton: TButton;
    BombaFDQuery: TFDQuery;
    BombaDataSource: TDataSource;
    CodigoFDQuery: TFDQuery;
    LargeintField1: TLargeintField;
    IncluirButton: TButton;
    BombaFDQueryCOD_BOMBA: TIntegerField;
    BombaFDQueryDESCRICAO: TStringField;
    BombaFDQueryCOD_TANQUE: TIntegerField;
    TanquesDataSource: TDataSource;
    TanquesFDQuery: TFDQuery;
    TanquesFDQueryDESCRICAO: TStringField;
    TanquesFDQueryCOD_TANQUE: TIntegerField;
    DBLookupComboBox: TDBLookupComboBox;
    procedure SalvarButtonClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure TanquesDBGridDblClick(Sender: TObject);
    procedure IncluirButtonClick(Sender: TObject);
    procedure DeletarButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    function ValidaCampos :boolean;
    function RetornaProximoCodigoTanque: Integer;
    procedure AtualizaGrid;
    procedure DesabilitaCampos;
    procedure HabilitaCampos;
    procedure SalvarTanque(Incluir:Boolean);
    procedure LimpaCampos;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CadastroBombasForm: TCadastroBombasForm;

implementation

{$R *.dfm}

{ TCadastroTanquesForm }

procedure TCadastroBombasForm.AtualizaGrid;
begin
   BombaFDQuery.Close;
   BombaFDQuery.SQL.Clear;
   BombaFDQuery.SQL.Add('SELECT COD_BOMBA,DESCRICAO,COD_TANQUE FROM BOMBAS');
   BombaFDQuery.Open;
end;


procedure TCadastroBombasForm.DeletarButtonClick(Sender: TObject);
begin
  BombaFDQuery.Close;
  BombaFDQuery.SQL.Clear;
  BombaFDQuery.SQL.Add('DELETE FROM BOMBAS ');
  BombaFDQuery.SQL.Add('WHERE COD_BOMBA = :COD_BOMBA');
  BombaFDQuery.ParamByName('COD_BOMBA').AsInteger := StrToInt(CodBombasLabeledEdit.Text);
  BombaFDQuery.ExecSQL;
  LimpaCampos;
  AtualizaGrid;
end;

procedure TCadastroBombasForm.DesabilitaCampos;
begin
  CodBombasLabeledEdit.Enabled :=false;
  DBLookupComboBox.Enabled :=false;
  DescricaoLabeledEdit.Enabled :=false;
  SalvarButton.Enabled :=false;
  DeletarButton.Enabled :=false;
end;

procedure TCadastroBombasForm.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8, #13, '.', '-']) then
    Key := #0;
end;

procedure TCadastroBombasForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CodigoFDQuery.Close;
  CodigoFDQuery.Free;
  CodigoFDQuery := nil;
  BombaFDQuery.Close;
  BombaFDQuery.Free;
  BombaFDQuery:= nil;
  TanquesFDQuery.Close;
  TanquesFDQuery.Free;
  TanquesFDQuery:= nil;
end;

procedure TCadastroBombasForm.FormShow(Sender: TObject);
begin
    CodBombasLabeledEdit.Text := IntToStr(RetornaProximoCodigoTanque);
    AtualizaGrid;
    DesabilitaCampos;
end;

procedure TCadastroBombasForm.HabilitaCampos;
begin
  CodBombasLabeledEdit.Enabled :=true;
  DBLookupComboBox.Enabled :=true;
  DescricaoLabeledEdit.Enabled :=true;
  SalvarButton.Enabled :=true;
  DeletarButton.Enabled :=true;
  TanquesFDQuery.Close;
  TanquesFDQuery.Open;
end;

procedure TCadastroBombasForm.IncluirButtonClick(Sender: TObject);
begin
  HabilitaCampos;
  DeletarButton.Enabled :=false;
end;

procedure TCadastroBombasForm.LimpaCampos;
begin
  CodBombasLabeledEdit.Text := IntToStr(RetornaProximoCodigoTanque);
  DescricaoLabeledEdit.Text :=EmptyStr;
  TanquesFDQuery.Close;
  TanquesFDQuery.Open;
  SalvarButton.Enabled := False;
  IncluirButton.Enabled := True;
  DeletarButton.Enabled := False;
end;

procedure TCadastroBombasForm.SalvarTanque(Incluir:Boolean);
begin
   try
     if Incluir then
     begin
       BombaFDQuery.Close;
       BombaFDQuery.SQL.Clear;
       BombaFDQuery.SQL.Add('INSERT INTO BOMBAS(COD_BOMBA,DESCRICAO,COD_TANQUE)');
       BombaFDQuery.SQL.Add('            VALUES(:COD_BOMBA,:DESCRICAO,:COD_TANQUE)');
       BombaFDQuery.ParamByName('COD_BOMBA').AsInteger := StrToInt(CodBombasLabeledEdit.Text);
       BombaFDQuery.ParamByName('DESCRICAO').AsString :=  DescricaoLabeledEdit.Text;
       BombaFDQuery.ParamByName('COD_TANQUE').AsInteger := TanquesFDQuery.FieldbyName('COD_TANQUE').AsInteger;
       BombaFDQuery.ExecSQL;
     end
    else begin
       BombaFDQuery.Close;
       BombaFDQuery.SQL.Clear;
       BombaFDQuery.SQL.Add('UPDATE BOMBAS ');
       BombaFDQuery.SQL.Add('SET DESCRICAO = :DESCRICAO');
       BombaFDQuery.SQL.Add('   ,COD_TANQUE = :COD_TANQUE ');
       BombaFDQuery.SQL.Add('WHERE COD_BOMBA = :COD_BOMBA');
       BombaFDQuery.ParamByName('COD_BOMBA').AsInteger := StrToInt(CodBombasLabeledEdit.Text);
       BombaFDQuery.ParamByName('DESCRICAO').AsString :=  DescricaoLabeledEdit.Text;
       BombaFDQuery.ParamByName('COD_TANQUE').AsInteger := TanquesFDQuery.FieldbyName('COD_TANQUE').AsInteger;
       BombaFDQuery.ExecSQL;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao gravar no banco de dados: ' + E.Message);
    end;
end;

function TCadastroBombasForm.RetornaProximoCodigoTanque: Integer;
begin
   result := 0;
   CodigoFDQuery.Close;
   CodigoFDQuery.SQL.Clear;
   CodigoFDQuery.SQL.Add('SELECT COALESCE(MAX(COD_BOMBA),0)+1 AS COD_BOMBA FROM BOMBAS');
   CodigoFDQuery.Open;
   result := CodigoFDQuery.FieldByName('COD_BOMBA').AsInteger;
end;

procedure TCadastroBombasForm.SalvarButtonClick(Sender: TObject);
begin
  if ValidaCampos then
  begin
     SalvarTanque(IncluirButton.Enabled);
     LimpaCampos;
     AtualizaGrid;
  end;
end;

procedure TCadastroBombasForm.TanquesDBGridDblClick(Sender: TObject);
begin
  HabilitaCampos;
  IncluirButton.Enabled :=false;
  CodBombasLabeledEdit.Text := BombaFDQuery.FieldByName('COD_BOMBA').AsString;
  DescricaoLabeledEdit.Text := BombaFDQuery.FieldByName('DESCRICAO').AsString;
  DBLookupComboBox.KeyValue :=  BombaFDQuery.FieldByName('COD_TANQUE').AsInteger;
end;

function TCadastroBombasForm.ValidaCampos :boolean;
begin
  result := true;
  if DescricaoLabeledEdit.Text = EmptyStr then
  begin
    ShowMessage('O Campo Descrição vazio!');
    DescricaoLabeledEdit.SetFocus;
    result := false;
    Exit;
  end;
end;

end.
