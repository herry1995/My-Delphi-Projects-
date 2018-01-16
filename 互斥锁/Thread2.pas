unit Thread2;

interface

uses
  Classes,Windows;

type
  TThread2 = class;
  TUpdate  = procedure(Sender:TThread2) of object;
  TThread2 = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  public
    Text_Src:string;
    Update:TUpdate;
  end;

implementation

uses
  Mutex;

procedure TThread2.Execute;
var
  I:Integer;
begin
  while not Terminated do
  begin
    for I := 0 to 5 - 1  do
    begin
      if Terminated then Break;
      WaitForSingleObject(hMutex1,INFINITE);
      Text_Src := 'bb';
      if Assigned(Update) then Update(Self);

      ReleaseMutex(hMutex1);
      Sleep(500);
    end;
    Suspend;
  end;
end;


end.
