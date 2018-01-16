program Mutex_Pro;

uses
  Forms,
  Mutex in 'Mutex.pas' {FM_Mutex},
  Thread1 in 'Thread1.pas',
  Thread2 in 'Thread2.pas';

{$R *.res}

begin
  Application.Initialize;
  System.ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFM_Mutex, FM_Mutex);
  Application.Run;
end.
