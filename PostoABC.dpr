program PostoABC;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {FrmPrincipal},
  UCadTanques in 'UCadTanques.pas' {CadastroTanquesForm},
  UCadPrecos in 'UCadPrecos.pas' {CadastroPrecosForm},
  UCadBombas in 'UCadBombas.pas' {CadastroBombasForm},
  UMovimentoRel in 'UMovimentoRel.pas' {MovimentoRelForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
