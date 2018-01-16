unit Thread2;

interface

uses
  Classes,SyncObjs,Windows;

type
  TThread2 = class;
  TUpdate = procedure(Sender:TThread2) of object;
  TThread2 = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  public
    Text_Str:String;
    Update: TUpdate;
  end;

implementation

uses
  Event;

procedure TThread2.Execute;
var
  I:Integer;
begin
  //FreeOnTerminate := True; //线程终止时,自动释放
  Text_Str := '';
  while not Terminated do
  begin
    for I := 0 to 5 - 1 do
    begin
      WaitForSingleObject(hEvent2,INFINITE);//等待 其它线程发来的信号
      if Terminated then Break;
        Text_Str := 'bb';
      if Assigned(Update) then
        Update(Self);
      if I < 4 then
        SetEvent(hEvent1);
    end;
  end;
end;

end.
