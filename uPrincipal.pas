unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.VCLUI.Wait,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Comp.UI,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.ToolWin,
  Vcl.ComCtrls, Vcl.Menus, Vcl.StdCtrls, System.ImageList, Vcl.ImgList, UCadTanques,UCadBombas,
  UCadPrecos, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Vcl.DBCtrls, System.Skia,UcadMovimento,
  Vcl.Skia;

type
  TFrmPrincipal = class(TForm)
    FDConnection: TFDConnection;
    TopToolBar: TToolBar;
    ButtonToolBar: TToolBar;
    PrincipalPanel: TPanel;
    TanquesButton: TButton;
    PrincipalMainMenu: TMainMenu;
    Cadastros1: TMenuItem;
    anques1: TMenuItem;
    Bombas1: TMenuItem;
    axasImposto1: TMenuItem;
    TaxasButton: TButton;
    Button2: TButton;
    Bomba1Image: TImage;
    PorLitroEdit: TEdit;
    PorValorEdit: TEdit;
    IniciarBomba1Button: TButton;
    Bomba1DBLookupComboBox: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bomba1FDQuery: TFDQuery;
    Bomba1DataSource: TDataSource;
    Bomba1FDQueryCOD_BOMBA: TIntegerField;
    Bomba1FDQueryDESCRICAO: TStringField;
    SkLabel1: TSkLabel;
    Bomba1FDQueryCOD_TANQUE: TIntegerField;
    Bomba1FDQueryTOTAL_LITROS_TANQUE: TFMTBCDField;
    SkLabel2: TSkLabel;
    Image1: TImage;
    Bomba2DBLookupComboBox: TDBLookupComboBox;
    Label4: TLabel;
    PorLitroBomba2Edit: TEdit;
    Label5: TLabel;
    PorValorBomba2Edit: TEdit;
    Label6: TLabel;
    IniciarBomba2Button: TButton;
    SkLabel3: TSkLabel;
    Image2: TImage;
    Bomba3DBLookupComboBox: TDBLookupComboBox;
    Label7: TLabel;
    PorLitroBomba3Edit: TEdit;
    Label8: TLabel;
    PorValorBomba3Edit: TEdit;
    Label9: TLabel;
    IniciarBomba3Button: TButton;
    SkLabel4: TSkLabel;
    Image3: TImage;
    Bomba4DBLookupComboBox: TDBLookupComboBox;
    Label10: TLabel;
    PorLitroBomba4Edit: TEdit;
    Label11: TLabel;
    PorValorBomba4Edit: TEdit;
    Label12: TLabel;
    IniciarBomba4Button: TButton;
    Bomba2FDQuery: TFDQuery;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    IntegerField2: TIntegerField;
    FMTBCDField1: TFMTBCDField;
    Bomba2DataSource: TDataSource;
    Bomba3FDQuery: TFDQuery;
    IntegerField3: TIntegerField;
    StringField2: TStringField;
    IntegerField4: TIntegerField;
    FMTBCDField2: TFMTBCDField;
    Bomba3DataSource: TDataSource;
    Bomba4FDQuery: TFDQuery;
    IntegerField5: TIntegerField;
    StringField3: TStringField;
    IntegerField6: TIntegerField;
    FMTBCDField3: TFMTBCDField;
    Bomba4DataSource: TDataSource;
    MovimentoButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure TanquesButtonClick(Sender: TObject);
    procedure anques1Click(Sender: TObject);
    procedure TaxasButtonClick(Sender: TObject);
    procedure Bombas1Click(Sender: TObject);
    procedure axasImposto1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PorLitroEditKeyPress(Sender: TObject; var Key: Char);
    procedure PorLitroEditExit(Sender: TObject);
    procedure PorValorEditExit(Sender: TObject);
    procedure IniciarBomba1ButtonClick(Sender: TObject);
    procedure PorLitroBomba2EditExit(Sender: TObject);
    procedure PorValorBomba2EditExit(Sender: TObject);
    procedure PorLitroBomba3EditExit(Sender: TObject);
    procedure PorValorBomba3EditExit(Sender: TObject);
    procedure PorLitroBomba4EditExit(Sender: TObject);
    procedure PorValorBomba4EditExit(Sender: TObject);
    procedure IniciarBomba2ButtonClick(Sender: TObject);
    procedure IniciarBomba3ButtonClick(Sender: TObject);
    procedure IniciarBomba4ButtonClick(Sender: TObject);
    procedure Bomba1DBLookupComboBoxDropDown(Sender: TObject);
    procedure MovimentoButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    function ResgataDiretorio(const CaminhoExecutavel:string; Tipo: Integer) :String;
    function RetornarPrecosCombustiveis(CodBomba : Integer) :Double;
    function AbastecimentoGeral(CodBomba, CodTanque, Tipo: Integer; TotalLitros, TotalValor: Double):Boolean;
    function AtualizaTotalLitrosTanque(CodTanque :Integer; TotalLitros: Double):Boolean;
    procedure AtualizaObjetos;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

procedure TFrmPrincipal.TanquesButtonClick(Sender: TObject);
begin
  CadastroTanquesForm := TCadastroTanquesForm.Create(Application);
  try
    CadastroTanquesForm.ShowModal;
  finally
     CadastroTanquesForm.Free;
  end;
end;

procedure TFrmPrincipal.TaxasButtonClick(Sender: TObject);
begin
 CadastroPrecosForm := TCadastroPrecosForm.Create(Application);
  try
    CadastroPrecosForm.ShowModal;
  finally
     CadastroPrecosForm.Free;
  end;
end;

function TFrmPrincipal.AbastecimentoGeral(CodBomba, CodTanque, Tipo: Integer; TotalLitros,
  TotalValor: Double): Boolean;
var
   QueryAbastecimento :TFDQuery;
begin
   Sleep(5000);
   result:=false;
   QueryAbastecimento := TFDQuery.Create(nil);
   QueryAbastecimento.Connection := FDConnection;
   try
      QueryAbastecimento.SQL.Add('INSERT INTO ABASTECIMENTOS (COD_BOMBA,COD_TANQUE,TIPO,VALOR_TOTAL,TOTAL_LITROS,DATA_ABASTECIMENTO)');
      QueryAbastecimento.SQL.Add('                    VALUES (:COD_BOMBA,:COD_TANQUE,:TIPO,:VALOR_TOTAL,:TOTAL_LITROS,:DATA_ABASTECIMENTO)');
      QueryAbastecimento.ParamByName('COD_BOMBA').AsInteger := CodBomba;
      QueryAbastecimento.ParamByName('COD_TANQUE').AsInteger :=CodTanque;
      QueryAbastecimento.ParamByName('TIPO').AsInteger  :=Tipo;
      QueryAbastecimento.ParamByName('VALOR_TOTAL').AsFloat := TotalValor;
      QueryAbastecimento.ParamByName('TOTAL_LITROS').AsFloat := TotalLitros;
      QueryAbastecimento.ParamByName('DATA_ABASTECIMENTO').AsDateTime := Now;
      QueryAbastecimento.ExecSQL;
      result:=true;
   finally
       QueryAbastecimento.Free;
       QueryAbastecimento := nil;
   end;
end;

procedure TFrmPrincipal.anques1Click(Sender: TObject);
begin
  CadastroBombasForm := TCadastroBombasForm.Create(Application);
  try
    CadastroBombasForm.ShowModal;
  finally
     CadastroBombasForm.Free;
  end;
end;

procedure TFrmPrincipal.AtualizaObjetos;
begin
  Bomba1FDQuery.Close;
  Bomba1FDQuery.Open;
  Bomba2FDQuery.Close;
  Bomba2FDQuery.Open;
  Bomba3FDQuery.Close;
  Bomba3FDQuery.Open;
  Bomba4FDQuery.Close;
  Bomba4FDQuery.Open;
  IniciarBomba1Button.Enabled := False;
  IniciarBomba2Button.Enabled := False;
  IniciarBomba3Button.Enabled := False;
  IniciarBomba4Button.Enabled := False;
end;

function TFrmPrincipal.AtualizaTotalLitrosTanque(CodTanque: Integer;
  TotalLitros: Double): Boolean;
var
   QueryAtualizaTanque :TFDQuery;
begin
   result:=false;
   QueryAtualizaTanque := TFDQuery.Create(nil);
   QueryAtualizaTanque.Connection := FDConnection;
   try
      QueryAtualizaTanque.SQL.Add('UPDATE TANQUES');
      QueryAtualizaTanque.SQL.Add('SET TOTAL_LITROS = :TOTAL_LITROS');
      QueryAtualizaTanque.SQL.Add('   ,DATA_ATUALIZACAO = :DATA_ATUALIZACAO');
      QueryAtualizaTanque.SQL.Add('WHERE COD_TANQUE = :COD_TANQUE');
      QueryAtualizaTanque.ParamByName('COD_TANQUE').AsInteger :=CodTanque;
      QueryAtualizaTanque.ParamByName('TOTAL_LITROS').AsFloat := TotalLitros;
      QueryAtualizaTanque.ParamByName('DATA_ATUALIZACAO').AsDateTime := Now;
      QueryAtualizaTanque.ExecSQL;
      result:=true;
   finally
       QueryAtualizaTanque.Free;
       QueryAtualizaTanque := nil;
   end;
end;

procedure TFrmPrincipal.axasImposto1Click(Sender: TObject);
begin
  CadastroPrecosForm := TCadastroPrecosForm.Create(Application);
  try
    CadastroPrecosForm.ShowModal;
  finally
     CadastroPrecosForm.Free;
  end;
end;

procedure TFrmPrincipal.Bomba1DBLookupComboBoxDropDown(Sender: TObject);
begin
 // if not VarIsNull(Bomba2DBLookupComboBox.KeyValue) then
  //  Bomba1FDQuery.ParamByName('COD_BOMBA').AsInteger := Bomba2FDQuery.FieldByName('COD_BOMBA').AsInteger;
end;

procedure TFrmPrincipal.Bombas1Click(Sender: TObject);
begin
   CadastroBombasForm := TCadastroBombasForm.Create(Application);
  try
    CadastroBombasForm.ShowModal;
  finally
     CadastroBombasForm.Free;
  end;
end;


procedure TFrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Bomba1FDQuery.Close;
  Bomba2FDQuery.Close;
  Bomba3FDQuery.Close;
  Bomba4FDQuery.Close;
  Bomba1FDQuery.Free;
  Bomba2FDQuery.Free;
  Bomba3FDQuery.Free;
  Bomba4FDQuery.Free;
  Bomba1FDQuery := nil;
  Bomba2FDQuery := nil;
  Bomba3FDQuery := nil;
  Bomba4FDQuery := nil;
  FDConnection.Connected := false;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
var
 LocalArquivoBanco:String;
begin
  LocalArquivoBanco :=  ResgataDiretorio(ExtractFileDir(GetCurrentDir),1);
  try
    with FDConnection do
     begin
         Close;
         with params do
         begin
           Add('DriverID=FB');
           Add('Server=localhost');
           Add('Database='+LocalArquivoBanco);
           Add('User=SYSDBA');
           Add('Password=masterkey');
         end;
         Connected := true;
      end;
  except
    on E: Exception do
      ShowMessage('Erro ao conectar no banco de dados: ' + E.Message);
    end;
 end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  AtualizaObjetos;
end;


procedure TFrmPrincipal.IniciarBomba1ButtonClick(Sender: TObject);
var
 TotalLitrosAtualizados:Double;
begin
  TotalLitrosAtualizados := (Bomba1FDQuery.FieldByName('TOTAL_LITROS_TANQUE').AsInteger  -  StrToFloat(PorLitroEdit.Text));
  if AbastecimentoGeral(Bomba1FDQuery.FieldByName('COD_BOMBA').AsInteger,
                        Bomba1FDQuery.FieldByName('COD_TANQUE').AsInteger,
                        0,
                        StrToFloat(PorLitroEdit.Text),
                        StrToFloat(PorValorEdit.Text)) then
                      if AtualizaTotalLitrosTanque( Bomba1FDQuery.FieldByName('COD_TANQUE').AsInteger,
                                                                                      TotalLitrosAtualizados) then
                      begin
                          IniciarBomba1Button.Enabled := false;
                          PorValorEdit.Text := EmptyStr;
                          PorLitroEdit.Text := EmptyStr;
                      end;

end;

procedure TFrmPrincipal.IniciarBomba2ButtonClick(Sender: TObject);
var
 TotalLitrosAtualizados:Double;
begin
  TotalLitrosAtualizados := (Bomba2FDQuery.FieldByName('TOTAL_LITROS_TANQUE').AsInteger  -  StrToFloat(PorLitroBomba2Edit.Text));
  if AbastecimentoGeral(Bomba2FDQuery.FieldByName('COD_BOMBA').AsInteger,
                        Bomba2FDQuery.FieldByName('COD_TANQUE').AsInteger,
                        0,
                        StrToFloat(PorLitroBomba2Edit.Text),
                        StrToFloat(PorValorBomba2Edit.Text)) then
                      if AtualizaTotalLitrosTanque( Bomba2FDQuery.FieldByName('COD_TANQUE').AsInteger,
                                                                                      TotalLitrosAtualizados) then
                      begin
                          IniciarBomba2Button.Enabled := false;
                          PorValorBomba2Edit.Text := EmptyStr;
                          PorLitroBomba2Edit.Text := EmptyStr;
                      end;
end;

procedure TFrmPrincipal.IniciarBomba3ButtonClick(Sender: TObject);
var
 TotalLitrosAtualizados:Double;
begin
  TotalLitrosAtualizados := (Bomba3FDQuery.FieldByName('TOTAL_LITROS_TANQUE').AsInteger  -  StrToFloat(PorLitroBomba3Edit.Text));
  if AbastecimentoGeral(Bomba3FDQuery.FieldByName('COD_BOMBA').AsInteger,
                        Bomba3FDQuery.FieldByName('COD_TANQUE').AsInteger,
                        0,
                        StrToFloat(PorLitroBomba3Edit.Text),
                        StrToFloat(PorValorBomba3Edit.Text)) then
                      if AtualizaTotalLitrosTanque( Bomba3FDQuery.FieldByName('COD_TANQUE').AsInteger,
                                                                                      TotalLitrosAtualizados) then
                      begin
                          IniciarBomba3Button.Enabled := false;
                          PorValorBomba3Edit.Text := EmptyStr;
                          PorLitroBomba3Edit.Text := EmptyStr;
                      end;
end;

procedure TFrmPrincipal.IniciarBomba4ButtonClick(Sender: TObject);
var
 TotalLitrosAtualizados:Double;
begin
  TotalLitrosAtualizados := (Bomba4FDQuery.FieldByName('TOTAL_LITROS_TANQUE').AsInteger  -  StrToFloat(PorLitroBomba4Edit.Text));
  if AbastecimentoGeral(Bomba4FDQuery.FieldByName('COD_BOMBA').AsInteger,
                        Bomba4FDQuery.FieldByName('COD_TANQUE').AsInteger,
                        0,
                        StrToFloat(PorLitroBomba4Edit.Text),
                        StrToFloat(PorValorBomba4Edit.Text)) then
                      if AtualizaTotalLitrosTanque( Bomba4FDQuery.FieldByName('COD_TANQUE').AsInteger,
                                                                                      TotalLitrosAtualizados) then
                      begin
                          IniciarBomba4Button.Enabled := false;
                          PorValorBomba4Edit.Text := EmptyStr;
                          PorLitroBomba4Edit.Text := EmptyStr;
                      end;
end;

procedure TFrmPrincipal.MovimentoButtonClick(Sender: TObject);
begin
  MovimentoForm := TMovimentoForm.Create(Application);
  try
    MovimentoForm.ShowModal;
  finally
     MovimentoForm.Free;
  end;
end;

procedure TFrmPrincipal.PorLitroBomba2EditExit(Sender: TObject);
var
  Preco :Double;
begin
  if not VarIsNull(Bomba2DBLookupComboBox.KeyValue)  then
  begin
    PorValorBomba2Edit.Text := EmptyStr;
    Preco :=0;
    try
      if PorLitroBomba2Edit.Text <> EmptyStr then
        begin
           Preco := RetornarPrecosCombustiveis(Bomba2DBLookupComboBox.KeyValue);
           PorValorBomba2Edit.Text := FormatFloat('##,##0.00', Trunc(Preco * StrToInt(PorLitroBomba2Edit.Text)));
           PorLitroBomba2Edit.Text := FormatFloat('###0.000', StrToFloat(PorLitroBomba2Edit.Text));
        end;
      except
        on E: Exception do
          ShowMessage('Erro: ' + E.Message);
        on E: EConvertError do
        Exit;
    end;
    if (PorValorBomba2Edit.Text <> EmptyStr) and  (PorLitroBomba2Edit.Text <> EmptyStr) then
      IniciarBomba2Button.Enabled := True;
  end
  else if not VarIsNull(Bomba2DBLookupComboBox.KeyValue)  and (PorValorBomba2Edit.Text <> EmptyStr) or  (PorLitroBomba2Edit.Text <> EmptyStr) then
  begin
    ShowMessage('Você precisa informar a bomba antes de iniciar o abastecimento');
    PorValorBomba2Edit.Text := EmptyStr;
    PorLitroBomba2Edit.Text := EmptyStr;
  end;end;

procedure TFrmPrincipal.PorLitroBomba3EditExit(Sender: TObject);
var
  Preco :Double;
begin
  if not VarIsNull(Bomba3DBLookupComboBox.KeyValue)  then
  begin
    PorValorBomba3Edit.Text := EmptyStr;
    Preco :=0;
    try
      if PorLitroBomba3Edit.Text <> EmptyStr then
        begin
           Preco := RetornarPrecosCombustiveis(Bomba3DBLookupComboBox.KeyValue);
           PorValorBomba3Edit.Text := FormatFloat('##,##0.00', Trunc(Preco * StrToInt(PorLitroBomba3Edit.Text)));
           PorLitroBomba3Edit.Text := FormatFloat('###0.000', StrToFloat(PorLitroBomba3Edit.Text));
        end;
      except
        on E: Exception do
          ShowMessage('Erro: ' + E.Message);
        on E: EConvertError do
        Exit;
    end;
    if (PorValorBomba3Edit.Text <> EmptyStr) and  (PorLitroBomba3Edit.Text <> EmptyStr) then
      IniciarBomba3Button.Enabled := True;
  end
  else if not VarIsNull(Bomba3DBLookupComboBox.KeyValue)  and (PorValorBomba3Edit.Text <> EmptyStr) or  (PorLitroBomba3Edit.Text <> EmptyStr) then
  begin
    ShowMessage('Você precisa informar a bomba antes de iniciar o abastecimento');
    PorValorBomba3Edit.Text := EmptyStr;
    PorLitroBomba3Edit.Text := EmptyStr;
  end;
end;

procedure TFrmPrincipal.PorLitroBomba4EditExit(Sender: TObject);
var
  Preco :Double;
begin
  if not VarIsNull(Bomba4DBLookupComboBox.KeyValue)  then
  begin
    PorValorBomba4Edit.Text := EmptyStr;
    Preco :=0;
    try
      if PorLitroBomba4Edit.Text <> EmptyStr then
        begin
           Preco := RetornarPrecosCombustiveis(Bomba4DBLookupComboBox.KeyValue);
           PorValorBomba4Edit.Text := FormatFloat('##,##0.00', Trunc(Preco * StrToInt(PorLitroBomba4Edit.Text)));
           PorLitroBomba4Edit.Text := FormatFloat('###0.000', StrToFloat(PorLitroBomba4Edit.Text));
        end;
      except
        on E: Exception do
          ShowMessage('Erro: ' + E.Message);
        on E: EConvertError do
        Exit;
    end;
    if (PorValorBomba4Edit.Text <> EmptyStr) and  (PorLitroBomba4Edit.Text <> EmptyStr) then
      IniciarBomba4Button.Enabled := True;
  end
  else if not VarIsNull(Bomba4DBLookupComboBox.KeyValue)  and (PorValorBomba4Edit.Text <> EmptyStr) or  (PorLitroBomba4Edit.Text <> EmptyStr) then
  begin
    ShowMessage('Você precisa informar a bomba antes de iniciar o abastecimento');
    PorValorBomba4Edit.Text := EmptyStr;
    PorLitroBomba4Edit.Text := EmptyStr;
  end;
end;

procedure TFrmPrincipal.PorLitroEditExit(Sender: TObject);
var
  Preco :Double;
begin
  if not VarIsNull(Bomba1DBLookupComboBox.KeyValue)  then
  begin
    PorValorEdit.Text := EmptyStr;
    Preco :=0;
    try
      if PorLitroEdit.Text <> EmptyStr then
        begin
           Preco := RetornarPrecosCombustiveis(Bomba1DBLookupComboBox.KeyValue);
           PorValorEdit.Text := FormatFloat('##,##0.00', Trunc(Preco * StrToInt(PorLitroEdit.Text)));
           PorLitroEdit.Text := FormatFloat('###0.000', StrToFloat(PorLitroEdit.Text));
        end;
      except
        on E: Exception do
          ShowMessage('Erro: ' + E.Message);
        on E: EConvertError do
        Exit;
    end;
    if (PorValorEdit.Text <> EmptyStr) and  (PorLitroEdit.Text <> EmptyStr) then
      IniciarBomba1Button.Enabled := True;
  end
  else if not VarIsNull(Bomba1DBLookupComboBox.KeyValue)  and (PorValorEdit.Text <> EmptyStr) or  (PorLitroEdit.Text <> EmptyStr) then
  begin
    ShowMessage('Você precisa informar a bomba antes de iniciar o abastecimento');
    PorValorEdit.Text := EmptyStr;
    PorLitroEdit.Text := EmptyStr;
  end;
end;

procedure TFrmPrincipal.PorLitroEditKeyPress(Sender: TObject; var Key: Char);
begin
 if not (Key in ['0'..'9', #8, #13, '.', '-']) then
    Key := #0;
end;

procedure TFrmPrincipal.PorValorBomba2EditExit(Sender: TObject);
var
  Preco, ValorTotal :Double;
begin
  if not VarIsNull(Bomba2DBLookupComboBox.KeyValue) then
  begin
    PorLitroBomba2Edit.Text := EmptyStr;
    Preco :=0;
    try
      if (PorValorBomba2Edit.Text <> EmptyStr) and  (PorLitroBomba2Edit.Text = EmptyStr) then
       begin
           Preco := RetornarPrecosCombustiveis(Bomba2DBLookupComboBox.KeyValue);
           ValorTotal :=  StrToFloat(PorValorBomba2Edit.Text);
           PorLitroBomba2Edit.Text := FormatFloat('###0.000',  (ValorTotal / Preco));
           PorValorBomba2Edit.Text := FormatCurr('##,##0.00', StrToFloat(PorValorBomba2Edit.Text));
       end;
      except
        on E: Exception do
          ShowMessage('Erro: ' + E.Message);
        on E: EConvertError do
          Exit;
    end;
    if (PorValorBomba2Edit.Text <> EmptyStr) and  (PorLitroBomba2Edit.Text <> EmptyStr) then
      IniciarBomba2Button.Enabled := True;

  end
  else if not VarIsNull(Bomba1DBLookupComboBox.KeyValue)  and ((PorValorEdit.Text <> EmptyStr) or  (PorLitroEdit.Text <> EmptyStr)) then
  begin
    ShowMessage('Você precisa informar a bomba antes de iniciar o abastecimento');
    PorValorEdit.Text := EmptyStr;
    PorLitroEdit.Text := EmptyStr;
  end;
end;

procedure TFrmPrincipal.PorValorBomba3EditExit(Sender: TObject);
var
  Preco, ValorTotal :Double;
begin
  if not VarIsNull(Bomba3DBLookupComboBox.KeyValue) then
  begin
    PorLitroBomba3Edit.Text := EmptyStr;
    Preco :=0;
    try
      if (PorValorBomba3Edit.Text <> EmptyStr) and  (PorLitroBomba3Edit.Text = EmptyStr) then
       begin
           Preco := RetornarPrecosCombustiveis(Bomba3DBLookupComboBox.KeyValue);
           ValorTotal :=  StrToFloat(PorValorBomba3Edit.Text);
           PorLitroBomba3Edit.Text := FormatFloat('###0.000',  (ValorTotal / Preco));
           PorValorBomba3Edit.Text := FormatCurr('##,##0.00', StrToFloat(PorValorBomba3Edit.Text));
       end;
      except
        on E: Exception do
          ShowMessage('Erro: ' + E.Message);
        on E: EConvertError do
          Exit;
    end;
    if (PorValorBomba3Edit.Text <> EmptyStr) and  (PorLitroBomba3Edit.Text <> EmptyStr) then
      IniciarBomba3Button.Enabled := True;

  end
  else if not VarIsNull(Bomba3DBLookupComboBox.KeyValue)  and ((PorValorBomba3Edit.Text <> EmptyStr) or  (PorLitroBomba3Edit.Text <> EmptyStr)) then
  begin
    ShowMessage('Você precisa informar a bomba antes de iniciar o abastecimento');
    PorValorBomba3Edit.Text := EmptyStr;
    PorLitroBomba3Edit.Text := EmptyStr;
  end;
end;

procedure TFrmPrincipal.PorValorBomba4EditExit(Sender: TObject);
var
  Preco, ValorTotal :Double;
begin
  if not VarIsNull(Bomba4DBLookupComboBox.KeyValue) then
  begin
    PorLitroBomba4Edit.Text := EmptyStr;
    Preco :=0;
    try
      if (PorValorBomba4Edit.Text <> EmptyStr) and  (PorLitroBomba4Edit.Text = EmptyStr) then
       begin
           Preco := RetornarPrecosCombustiveis(Bomba4DBLookupComboBox.KeyValue);
           ValorTotal :=  StrToFloat(PorValorBomba4Edit.Text);
           PorLitroBomba4Edit.Text := FormatFloat('###0.000',  (ValorTotal / Preco));
           PorValorBomba4Edit.Text := FormatCurr('##,##0.00', StrToFloat(PorValorBomba4Edit.Text));
       end;
      except
        on E: Exception do
          ShowMessage('Erro: ' + E.Message);
        on E: EConvertError do
          Exit;
    end;
    if (PorValorBomba4Edit.Text <> EmptyStr) and  (PorLitroBomba4Edit.Text <> EmptyStr) then
      IniciarBomba4Button.Enabled := True;

  end
  else if not VarIsNull(Bomba4DBLookupComboBox.KeyValue)  and ((PorValorBomba4Edit.Text <> EmptyStr) or  (PorLitroBomba4Edit.Text <> EmptyStr)) then
  begin
    ShowMessage('Você precisa informar a bomba antes de iniciar o abastecimento');
    PorValorBomba4Edit.Text := EmptyStr;
    PorLitroBomba4Edit.Text := EmptyStr;
  end;
end;

procedure TFrmPrincipal.PorValorEditExit(Sender: TObject);
var
  Preco, ValorTotal :Double;
begin
  if not VarIsNull(Bomba1DBLookupComboBox.KeyValue) then
  begin
    PorLitroEdit.Text := EmptyStr;
    Preco :=0;
    try
      if (PorValorEdit.Text <> EmptyStr) and  (PorLitroEdit.Text = EmptyStr) then
       begin
           Preco := RetornarPrecosCombustiveis(Bomba1DBLookupComboBox.KeyValue);
           ValorTotal :=  StrToFloat(PorValorEdit.Text);
           PorLitroEdit.Text := FormatFloat('###0.000',  (ValorTotal / Preco));
           PorValorEdit.Text := FormatCurr('##,##0.00', StrToFloat(PorValorEdit.Text));
       end;
      except
        on E: Exception do
          ShowMessage('Erro: ' + E.Message);
        on E: EConvertError do
          Exit;
    end;
    if (PorValorEdit.Text <> EmptyStr) and  (PorLitroEdit.Text <> EmptyStr) then
      IniciarBomba1Button.Enabled := True;

  end
  else if not VarIsNull(Bomba1DBLookupComboBox.KeyValue)  and ((PorValorEdit.Text <> EmptyStr) or  (PorLitroEdit.Text <> EmptyStr)) then
  begin
    ShowMessage('Você precisa informar a bomba antes de iniciar o abastecimento');
    PorValorEdit.Text := EmptyStr;
    PorLitroEdit.Text := EmptyStr;
  end;
end;

function TFrmPrincipal.ResgataDiretorio(const CaminhoExecutavel:string; Tipo: Integer) :String;
begin
  case Tipo of
     1:  Result := ExtractFilePath(ExcludeTrailingPathDelimiter(CaminhoExecutavel))+'\Banco\POSTOABC.FDB';
     2:  Result := ExtractFilePath(ExcludeTrailingPathDelimiter(CaminhoExecutavel))+'\Imagens\';
  end;

end;

function TFrmPrincipal.RetornarPrecosCombustiveis(CodBomba: Integer): Double;
var
   QueryPreco :TFDQuery;
begin
  result := 0;
  QueryPreco := TFDQuery.Create(nil);
  QueryPreco.Connection := FDConnection;
  try
    QueryPreco.SQL.Add('SELECT PRE.PRECOS_LITRO,PRE.TAXA');
    QueryPreco.SQL.Add(' FROM PRECOS PRE');
    QueryPreco.SQL.Add(' JOIN TANQUES TAN ON (TAN.TIPO = PRE.TIPO)');
    QueryPreco.SQL.Add(' JOIN BOMBAS  BOM ON (BOM.COD_TANQUE = TAN.COD_TANQUE)');
    QueryPreco.SQL.Add('WHERE BOM.COD_BOMBA = :COD_BOMBA');
    QueryPreco.SQL.Add('AND   PRE.ATIVO = ''SIM''');
    QueryPreco.ParamByName('COD_BOMBA').AsInteger := CodBomba;
    QueryPreco.Open;
    result :=  QueryPreco.FieldByName('PRECOS_LITRO').AsFloat * (1 +  QueryPreco.FieldByName('TAXA').AsFloat/100);
  finally
    QueryPreco.Free;
    QueryPreco := nil;
  end;
end;


end.
