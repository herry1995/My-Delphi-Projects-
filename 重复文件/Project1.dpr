program Project1;

uses
  Forms,
  Windows,
  RepeatFiles in 'RepeatFiles.pas' {FM_RepeatFiles},
  MyThread in 'MyThread.pas',
  wdRunOnce in 'wdRunOnce.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  if not AppHasRun(Application.Handle) then
    Application.CreateForm(TFM_RepeatFiles,FM_RepeatFiles);
  Application.Run;
end.
//var
//  MyHandle: THandle;
//begin
//  MyHandle:=FindWindow(nil,'Search RepeatFiles');
//  if MyHandle = 0 then
//  begin
//    Application.Initialize;
//    Application.MainFormOnTaskbar := True;
//    Application.CreateForm(TFM_RepeatFiles, FM_RepeatFiles);
//  Application.Run;
//  end;
//end.
