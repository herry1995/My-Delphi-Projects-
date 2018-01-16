program Event_pro;

uses
  Forms,
  Event in 'Event.pas' {FM_Event},
  Thread1 in 'Thread1.pas',
  Thread2 in 'Thread2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFM_Event, FM_Event);
  Application.Run;
end.
