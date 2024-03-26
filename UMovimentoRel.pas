unit UMovimentoRel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TMovimentoRelForm = class(TForm)
    MovimentosRLReport: TRLReport;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    PeriodoRLDBText: TRLDBText;
    TanquesRLDBText: TRLDBText;
    BombasRLDBText: TRLDBText;
    RLDraw1: TRLDraw;
    TanqueRLLabel: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    DetailRLBand: TRLBand;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText1: TRLDBText;
    RLDraw2: TRLDraw;
    RLDraw3: TRLDraw;
    RLDraw4: TRLDraw;
    RLDraw5: TRLDraw;
    RLBand2: TRLBand;
    RLLabel9: TRLLabel;
    RLDBText6: TRLDBText;
    RLLabel10: TRLLabel;
    RLDBText7: TRLDBText;
    procedure MovimentosRLReportBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Periodo, Tanques, Bombas: String;
   end;

var
  MovimentoRelForm: TMovimentoRelForm;

implementation

uses UCadMovimento;

{$R *.dfm}

procedure TMovimentoRelForm.MovimentosRLReportBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  PeriodoRLDBText.Text  := Periodo;
  TanquesRLDBText.Text  := Tanques;
  BombasRLDBText.Text  :=  Bombas;
end;

end.
