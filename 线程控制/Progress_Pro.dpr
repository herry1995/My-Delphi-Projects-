program Progress_Pro;

uses
  Forms,
  Progress in 'Progress.pas' {Form3},
  Thread1 in 'Thread1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFM_Progress, FM_Progress);
  Application.Run;
end.
