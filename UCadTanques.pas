unit UCadTanques;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TCadastroTanquesForm = class(TForm)
    TanquesPanel: TPanel;
    Panel1: TPanel;
    TanquesDBGrid: TDBGrid;
    CodTanqueLabeledEdit: TLabeledEdit;
    DescricaoLabeledEdit: TLabeledEdit;
    TipoComboBox: TComboBox;
    Label1: TLabel;
    CapacidadeLabeledEdit: TLabeledEdit;
    TotalLitrosLabeledEdit: TLabeledEdit;
    SalvarButton: TButton;
    DeletarButton: TButton;
    TanquesFDQuery: TFDQuery;
    TanquesDataSource: TDataSource;
    CodigoFDQuery: TFDQuery;
    LargeintField1: TLargeintField;
    TanquesFDQueryCOD_TANQUE: TIntegerField;
    TanquesFDQueryDESCRICAO: TStringField;
    TanquesFDQueryCAPACIDADE_LITROS: TFMTBCDField;
    TanquesFDQueryTOTAL_LITROS: TFMTBCDField;
    TanquesFDQueryTIPO: TStringField;
    IncluirButton: TButton;
    TanquesFDQueryDATA_ATUALIZACAO: TDateField;
    TanquesFDQueryDATA_INCLUSAO: TDateField;
    procedure SalvarButtonClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure TotalLitrosLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure TanquesDBGridDblClick(Sender: TObject);
    procedure IncluirButtonClick(Sender: TObject);
    procedure DeletarButtonClick(Sender: TObject);
    procedure CapacidadeLabeledEditKeyPress(Sender: TObject; var Key: Char);
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
  CadastroTanquesForm: TCadastroTanquesForm;

implementation

{$R *.dfm}

{ TCadastroTanquesForm }

procedure TCadastroTanquesForm.AtualizaGrid;
begin
   TanquesFDQuery.Close;
   TanquesFDQuery.SQL.Clear;
   TanquesFDQuery.SQL.Add('SELECT COD_TANQUE,DESCRICAO,CASE WHEN TIPO = 0 THEN ''Gasolina'' ELSE ''Diesel'' END AS TIPO ,CAPACIDADE_LITROS,TOTAL_LITROS, DATA_ATUALIZACAO, DATA_INCLUSAO FROM TANQUES');
   TanquesFDQuery.Open;
   LimpaCampos;
end;


procedure TCadastroTanquesForm.CapacidadeLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9', #8, #13, '.', '-']) then
    Key := #0;
end;

procedure TCadastroTanquesForm.DeletarButtonClick(Sender: TObject);
begin
  TanquesFDQuery.Close;
  TanquesFDQuery.SQL.Clear;
  TanquesFDQuery.SQL.Add('DELETE FROM  TANQUES ');
  TanquesFDQuery.SQL.Add('WHERE COD_TANQUE = :COD_TANQUE');
  TanquesFDQuery.ParamByName('COD_TANQUE').AsInteger := StrToInt(CodTanqueLabeledEdit.Text);
  TanquesFDQuery.ExecSQL;
  LimpaCampos;
  AtualizaGrid;
end;

procedure TCadastroTanquesForm.DesabilitaCampos;
begin
  CodTanqueLabeledEdit.Enabled :=false;
  TipoComboBox.Enabled :=false;
  DescricaoLabeledEdit.Enabled :=false;
  CapacidadeLabeledEdit.Enabled :=false;
  TotalLitrosLabeledEdit.Enabled :=false;
  SalvarButton.Enabled :=false;
  DeletarButton.Enabled :=false;
end;

procedure TCadastroTanquesForm.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8, #13, '.', '-']) then
    Key := #0;
end;

procedure TCadastroTanquesForm.FormShow(Sender: TObject);
begin
    CodTanqueLabeledEdit.Text := IntToStr(RetornaProximoCodigoTanque);
    AtualizaGrid;
    DesabilitaCampos;
end;

procedure TCadastroTanquesForm.HabilitaCampos;
begin
  TipoComboBox.Enabled :=true;
  DescricaoLabeledEdit.Enabled :=true;
  CapacidadeLabeledEdit.Enabled :=true;
  TotalLitrosLabeledEdit.Enabled :=true;
  SalvarButton.Enabled :=true;
  DeletarButton.Enabled :=true;
  CodTanqueLabeledEdit.Text := IntToStr(RetornaProximoCodigoTanque);
end;

procedure TCadastroTanquesForm.IncluirButtonClick(Sender: TObject);
begin
  HabilitaCampos;
  DeletarButton.Enabled :=false;
end;

procedure TCadastroTanquesForm.LimpaCampos;
begin
  CodTanqueLabeledEdit.Text :=Emptystr;
  TipoComboBox.ItemIndex :=0;
  DescricaoLabeledEdit.Text :=Emptystr;
  CapacidadeLabeledEdit.Text :=Emptystr;
  TotalLitrosLabeledEdit.Text :=Emptystr;
  SalvarButton.Enabled := False;
  IncluirButton.Enabled := True;
  DeletarButton.Enabled := False;
end;

procedure TCadastroTanquesForm.SalvarTanque(Incluir:Boolean);
begin
   try
     if Incluir then
     begin
       TanquesFDQuery.Close;
       TanquesFDQuery.SQL.Clear;
       TanquesFDQuery.SQL.Add('INSERT INTO TANQUES(COD_TANQUE,DESCRICAO,TIPO,CAPACIDADE_LITROS,TOTAL_LITROS,DATA_INCLUSAO)');
       TanquesFDQuery.SQL.Add('            VALUES(:COD_TANQUE,:DESCRICAO,:TIPO,:CAPACIDADE_LITROS,:TOTAL_LITROS,:DATA_INCLUSAO)');
       TanquesFDQuery.ParamByName('COD_TANQUE').AsInteger := StrToInt(CodTanqueLabeledEdit.Text);
       TanquesFDQuery.ParamByName('DESCRICAO').AsString :=  DescricaoLabeledEdit.Text;
       TanquesFDQuery.ParamByName('TIPO').AsString := IntToStr(TipoComboBox.ItemIndex);
       TanquesFDQuery.ParamByName('CAPACIDADE_LITROS').AsFloat := StrToFloat(CapacidadeLabeledEdit.Text);
       TanquesFDQuery.ParamByName('TOTAL_LITROS').AsFloat := StrToFloat(TotalLitrosLabeledEdit.Text);
       TanquesFDQuery.ParamByName('DATA_INCLUSAO').AsDate := Now;
       TanquesFDQuery.ExecSQL;
     end
    else begin
       TanquesFDQuery.Close;
       TanquesFDQuery.SQL.Clear;
       TanquesFDQuery.SQL.Add('UPDATE TANQUES ');
       TanquesFDQuery.SQL.Add('SET DESCRICAO = :DESCRICAO');
       TanquesFDQuery.SQL.Add('   ,TIPO = :TIPO ');
       TanquesFDQuery.SQL.Add('   ,CAPACIDADE_LITROS = :CAPACIDADE_LITROS ');
       TanquesFDQuery.SQL.Add('   ,TOTAL_LITROS = :TOTAL_LITROS');
       TanquesFDQuery.SQL.Add('   ,DATA_ATUALIZACAO = :DATA_ATUALIZACAO');
       TanquesFDQuery.SQL.Add('WHERE COD_TANQUE = :COD_TANQUE');
       TanquesFDQuery.ParamByName('COD_TANQUE').AsInteger := StrToInt(CodTanqueLabeledEdit.Text);
       TanquesFDQuery.ParamByName('DESCRICAO').AsString :=  DescricaoLabeledEdit.Text;
       TanquesFDQuery.ParamByName('TIPO').AsInteger := TipoComboBox.ItemIndex;
       TanquesFDQuery.ParamByName('CAPACIDADE_LITROS').AsFloat := StrToFloat(CapacidadeLabeledEdit.Text);
       TanquesFDQuery.ParamByName('TOTAL_LITROS').AsFloat := StrToFloat(TotalLitrosLabeledEdit.Text);
       TanquesFDQuery.ParamByName('DATA_ATUALIZACAO').AsDate := Now;
       TanquesFDQuery.ExecSQL;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao gravar no banco de dados: ' + E.Message);
    end;
end;

function TCadastroTanquesForm.RetornaProximoCodigoTanque: Integer;
begin
   result := 0;
   CodigoFDQuery.Close;
   CodigoFDQuery.SQL.Clear;
   CodigoFDQuery.SQL.Add('SELECT COALESCE(MAX(COD_TANQUE),0)+1 AS COD_TANQUE FROM TANQUES');
   CodigoFDQuery.Open;
   result := CodigoFDQuery.FieldByName('COD_TANQUE').AsInteger;
end;

procedure TCadastroTanquesForm.SalvarButtonClick(Sender: TObject);
begin
  if ValidaCampos then
  begin
     SalvarTanque(IncluirButton.Enabled);
     LimpaCampos;
     AtualizaGrid;
  end;
end;

procedure TCadastroTanquesForm.TanquesDBGridDblClick(Sender: TObject);
begin
  HabilitaCampos;
  IncluirButton.Enabled :=false;
  CodTanqueLabeledEdit.Text := TanquesFDQuery.FieldByName('COD_TANQUE').AsString;
  DescricaoLabeledEdit.Text := TanquesFDQuery.FieldByName('DESCRICAO').AsString;
  if TanquesFDQuery.FieldByName('TIPO').AsString = 'Gasolina' then
    TipoComboBox.ItemIndex := 0
  else if TanquesFDQuery.FieldByName('TIPO').AsString = 'Diesel' then
         TipoComboBox.ItemIndex := 1
           else
              TipoComboBox.ItemIndex := 2;
  CapacidadeLabeledEdit.Text := TanquesFDQuery.FieldByName('CAPACIDADE_LITROS').AsString;
  TotalLitrosLabeledEdit.Text := TanquesFDQuery.FieldByName('TOTAL_LITROS').AsString;
end;

procedure TCadastroTanquesForm.TotalLitrosLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9', #8, #13, '.', '-']) then
    Key := #0;
end;

function TCadastroTanquesForm.ValidaCampos :boolean;
begin
  result := true;
  if DescricaoLabeledEdit.Text = EmptyStr then
  begin
    ShowMessage('O Campo Descrição vazio!');
    DescricaoLabeledEdit.SetFocus;
    result := false;
    Exit;
  end;
  if StrToInt(CapacidadeLabeledEdit.Text) = 0  then
  begin
    ShowMessage('O Campo Capacidade não pode ser vazio!');
    CapacidadeLabeledEdit.SetFocus;
    result := false;
    Exit;
  end;
  if TotalLitrosLabeledEdit.Text = EmptyStr then
  begin
    ShowMessage('O Campo Total Litros não pode ser vazio!');
    TotalLitrosLabeledEdit.SetFocus;
    result := false;
    Exit;
  end;
  if StrToFloat(TotalLitrosLabeledEdit.Text) > StrToFloat(CapacidadeLabeledEdit.Text) then
  begin
    ShowMessage('O Total de de Litros não pode ser maior que a capacidade do Tanque!');
    TotalLitrosLabeledEdit.SetFocus;
    result := false;
    Exit;
  end;

end;

end.
