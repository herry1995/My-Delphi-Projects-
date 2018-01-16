program CriticalSection_pro;

uses
  Forms,
  CriticalSection in 'CriticalSection.pas' {FM_CriticalSection},
  MyThread in 'MyThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFM_CriticalSection, FM_CriticalSection);
  Application.Run;
end.
