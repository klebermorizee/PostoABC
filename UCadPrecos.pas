unit UCadPrecos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.DBCtrls;

type
  TCadastroPrecosForm = class(TForm)
    TanquesPanel: TPanel;
    Panel1: TPanel;
    TanquesDBGrid: TDBGrid;
    CodPrecoLabeledEdit: TLabeledEdit;
    DescricaoLabeledEdit: TLabeledEdit;
    Label1: TLabel;
    SalvarButton: TButton;
    DeletarButton: TButton;
    PrecosFDQuery: TFDQuery;
    PrecosDataSource: TDataSource;
    CodigoFDQuery: TFDQuery;
    LargeintField1: TLargeintField;
    IncluirButton: TButton;
    TipoComboBox: TComboBox;
    AtivoComboBox: TComboBox;
    Label2: TLabel;
    ImpostoLabeledEdit: TLabeledEdit;
    PrecosFDQueryCOD_PRECOS: TIntegerField;
    PrecosFDQueryDESCRICAO: TStringField;
    PrecosFDQueryTIPO: TStringField;
    PrecosFDQueryPRECOS_LITRO: TFMTBCDField;
    PrecosFDQueryTAXA: TFMTBCDField;
    PrecosFDQueryATIVO: TStringField;
    PrecoLabeledEdit: TLabeledEdit;
    PrecosFDQueryDATA_INCLUSAO: TDateField;
    PrecosFDQueryDATA_ATUALIZACAO: TDateField;
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
  CadastroPrecosForm: TCadastroPrecosForm;

implementation

{$R *.dfm}

{ TCadastroTanquesForm }

procedure TCadastroPrecosForm.AtualizaGrid;
begin
   PrecosFDQuery.Close;
   PrecosFDQuery.SQL.Clear;
   PrecosFDQuery.SQL.Add('SELECT COD_PRECOS, DESCRICAO, CASE WHEN TIPO = ''0'' THEN ''Gasolina'' WHEN TIPO = ''1'' THEN ''Diesel'' ELSE  ''Etanol'' END  AS TIPO,');
   PrecosFDQuery.SQL.Add('PRECOS_LITRO, TAXA, CASE WHEN ATIVO = ''1'' THEN ''SIM'' ELSE ''NÃO'' END AS ATIVO, PRECOS_LITRO,  TAXA, DATA_INCLUSAO, DATA_ATUALIZACAO FROM  PRECOS');
   PrecosFDQuery.Open;
end;


procedure TCadastroPrecosForm.DeletarButtonClick(Sender: TObject);
begin
  PrecosFDQuery.Close;
  PrecosFDQuery.SQL.Clear;
  PrecosFDQuery.SQL.Add('DELETE FROM  PRECOS ');
  PrecosFDQuery.SQL.Add('WHERE COD_PRECOS = :COD_PRECOS');
  PrecosFDQuery.ParamByName('COD_PRECOS').AsInteger := StrToInt(CodPrecoLabeledEdit.Text);
  PrecosFDQuery.ExecSQL;
  LimpaCampos;
  AtualizaGrid;

end;

procedure TCadastroPrecosForm.DesabilitaCampos;
begin
  CodPrecoLabeledEdit.Enabled :=false;
  TipoComboBox.Enabled :=false;
  DescricaoLabeledEdit.Enabled :=false;
  SalvarButton.Enabled :=false;
  DeletarButton.Enabled :=false;
  AtivoComboBox.Enabled :=false;
  ImpostoLabeledEdit.Enabled :=false;
  PrecoLabeledEdit.Enabled :=false;
end;

procedure TCadastroPrecosForm.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8, #13, '.', '-']) then
    Key := #0;
end;

procedure TCadastroPrecosForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CodigoFDQuery.Close;
  CodigoFDQuery.Free;
  CodigoFDQuery := nil;
  PrecosFDQuery.Close;
  PrecosFDQuery.Free;
  PrecosFDQuery:= nil;
end;

procedure TCadastroPrecosForm.FormShow(Sender: TObject);
begin
    CodPrecoLabeledEdit.Text := IntToStr(RetornaProximoCodigoTanque);
    AtualizaGrid;
    DesabilitaCampos;
end;

procedure TCadastroPrecosForm.HabilitaCampos;
begin
  CodPrecoLabeledEdit.Enabled :=true;
  TipoComboBox.Enabled :=true;
  DescricaoLabeledEdit.Enabled :=true;
  PrecoLabeledEdit.Enabled :=true;
  SalvarButton.Enabled :=true;
  DeletarButton.Enabled :=true;
  AtivoComboBox.Enabled :=true;
end;

procedure TCadastroPrecosForm.IncluirButtonClick(Sender: TObject);
begin
  HabilitaCampos;
  DeletarButton.Enabled :=false;
end;

procedure TCadastroPrecosForm.LimpaCampos;
begin
  CodPrecoLabeledEdit.Text := IntToStr(RetornaProximoCodigoTanque);
  DescricaoLabeledEdit.Text :=EmptyStr;
  PrecoLabeledEdit.Text :=EmptyStr;
  AtivoComboBox.ItemIndex := 0;
  SalvarButton.Enabled := False;
  IncluirButton.Enabled := True;
  DeletarButton.Enabled := False;
end;

procedure TCadastroPrecosForm.SalvarTanque(Incluir:Boolean);
begin
   try
     if Incluir then
     begin
       PrecosFDQuery.Close;
       PrecosFDQuery.SQL.Clear;
       PrecosFDQuery.SQL.Add('INSERT INTO PRECOS(COD_PRECOS,DESCRICAO,TIPO,PRECOS_LITRO,TAXA,ATIVO, DATA_INCLUSAO)');
       PrecosFDQuery.SQL.Add('            VALUES(:COD_PRECOS,:DESCRICAO,:TIPO,:PRECOS_LITRO,:TAXA,:ATIVO, :DATA_INCLUSAO)');
       PrecosFDQuery.ParamByName('COD_PRECOS').AsInteger := StrToInt(CodPrecoLabeledEdit.Text);
       PrecosFDQuery.ParamByName('DESCRICAO').AsString :=  DescricaoLabeledEdit.Text;
       PrecosFDQuery.ParamByName('TIPO').AsInteger := TipoComboBox.ItemIndex;
       PrecosFDQuery.ParamByName('PRECOS_LITRO').AsCurrency := StrtoFloat(PrecoLabeledEdit.Text);
       PrecosFDQuery.ParamByName('TAXA').AsCurrency :=  StrtoFloat(ImpostoLabeledEdit.Text);
       PrecosFDQuery.ParamByName('ATIVO').AsInteger := AtivoComboBox.ItemIndex;
       PrecosFDQuery.ParamByName('DATA_INCLUSAO').AsDate := Now;
       PrecosFDQuery.ExecSQL;
     end
    else begin
       PrecosFDQuery.Close;
       PrecosFDQuery.SQL.Clear;
       PrecosFDQuery.SQL.Add('UPDATE PRECOS ');
       PrecosFDQuery.SQL.Add('SET DESCRICAO = :DESCRICAO');
       PrecosFDQuery.SQL.Add('   ,TIPO = :TIPO ');
       PrecosFDQuery.SQL.Add('   ,PRECOS_LITRO = :PRECOS_LITRO ');
       PrecosFDQuery.SQL.Add('   ,TAXA = :TAXA ');
       PrecosFDQuery.SQL.Add('   ,ATIVO = :ATIVO ');
       PrecosFDQuery.SQL.Add('   ,DATA_ATUALIZACAO = :DATA_ATUALIZACAO ');
       PrecosFDQuery.SQL.Add('WHERE COD_PRECOS = :COD_PRECOS');
       PrecosFDQuery.ParamByName('COD_PRECOS').AsInteger := StrToInt(CodPrecoLabeledEdit.Text);
       PrecosFDQuery.ParamByName('DESCRICAO').AsString :=  DescricaoLabeledEdit.Text;
       PrecosFDQuery.ParamByName('TIPO').AsInteger := TipoComboBox.ItemIndex;
       PrecosFDQuery.ParamByName('PRECOS_LITRO').AsCurrency := StrtoFloat(PrecoLabeledEdit.Text);
       PrecosFDQuery.ParamByName('TAXA').AsCurrency :=  StrtoFloat(ImpostoLabeledEdit.Text);
       PrecosFDQuery.ParamByName('ATIVO').AsString :=  AtivoComboBox.Text;
       PrecosFDQuery.ParamByName('DATA_ATUALIZACAO').AsDate := Now;
       PrecosFDQuery.ExecSQL;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao gravar no banco de dados: ' + E.Message);
    end;
end;

function TCadastroPrecosForm.RetornaProximoCodigoTanque: Integer;
begin
   result := 0;
   CodigoFDQuery.Close;
   CodigoFDQuery.SQL.Clear;
   CodigoFDQuery.SQL.Add('SELECT COALESCE(MAX(COD_PRECOS),0)+1 AS COD_PRECOS FROM PRECOS');
   CodigoFDQuery.Open;
   result := CodigoFDQuery.FieldByName('COD_PRECOS').AsInteger;
end;

procedure TCadastroPrecosForm.SalvarButtonClick(Sender: TObject);
begin
  if ValidaCampos then
  begin
     SalvarTanque(IncluirButton.Enabled);
     LimpaCampos;
     AtualizaGrid;
  end;
end;

procedure TCadastroPrecosForm.TanquesDBGridDblClick(Sender: TObject);
begin
  HabilitaCampos;
  IncluirButton.Enabled :=false;
  CodPrecoLabeledEdit.Text := PrecosFDQuery.FieldByName('COD_PRECOS').AsString;
  DescricaoLabeledEdit.Text := PrecosFDQuery.FieldByName('DESCRICAO').AsString;
  PrecoLabeledEdit.Text := PrecosFDQuery.FieldByName('PRECOS_LITRO').AsString;
  if PrecosFDQuery.FieldByName('TIPO').AsString = 'Gasolina' then
    TipoComboBox.ItemIndex := 0
  else if PrecosFDQuery.FieldByName('TIPO').AsString = 'Diesel' then
         TipoComboBox.ItemIndex := 1
           else
              TipoComboBox.ItemIndex := 2;
  if PrecosFDQuery.FieldByName('TIPO').AsString = 'SIM' then
     AtivoComboBox.ItemIndex := 0
       else  AtivoComboBox.ItemIndex := 1;
end;

function TCadastroPrecosForm.ValidaCampos :boolean;
begin
  result := true;
  if DescricaoLabeledEdit.Text = EmptyStr then
  begin
    ShowMessage('O Campo Descrição vazio!');
    DescricaoLabeledEdit.SetFocus;
    result := false;
    Exit;
  end;
  if PrecoLabeledEdit.Text = EmptyStr then
  begin
    ShowMessage('O Campo Preço vazio!');
    PrecoLabeledEdit.SetFocus;
    result := false;
    Exit;
  end;
end;

end.
