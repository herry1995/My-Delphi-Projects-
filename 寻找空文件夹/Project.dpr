program Project;

uses
  Forms,
  FindEmptyDir in 'FindEmptyDir.pas' {FM_FindEmptyDir},
  Thread1 in 'Thread1.pas';

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFM_FindEmptyDir, FM_FindEmptyDir);
  Application.Run;
end.
