unit Thread1;

interface

uses
  Classes,SyncObjs,Windows;

type
  TThread1 = class;
  TUpdate = procedure(Sender:TThread1) of object;
  TThread1 = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  public
    Text_Str:string;
    Update:TUpdate;
  end;

implementation

uses
  Event;

procedure TThread1.Execute;
var
  I:Integer;
begin
  //FreeOnTerminate := True;//线程结束时自动释放资源
  Text_Str := '';
  while not Terminated do
  begin
    for I := 0 to 5 - 1 do
    begin
      WaitForSingleObject(hEvent1,INFINITE);
      if Terminated then Break;
        Text_Str := 'aa';
      if Assigned(Update) then
        Update(Self);
      SetEvent(hEvent2);
    end;
  end;
end;

end.
