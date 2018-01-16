unit MyThread;

interface

uses
  Classes,Windows;

type
  TMyThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;

  end;

implementation

uses
  CriticalSection;

procedure TMyThread.Execute;
var
  I:Integer;
begin
  while not Terminated do
  begin
    for I := 0 to 5 - 1 do
    begin
      EnterCriticalSection(CS);
      FM_CriticalSection.List_Screen.Items.Add('aa');
      FM_CriticalSection.List_Screen.Items.Add('aa');
      LeaveCriticalSection(CS);
      Sleep(1000);
    end;
    Suspend;
  end;
end;

end.
