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
  //FreeOnTerminate := True; //�߳���ֹʱ,�Զ��ͷ�
  Text_Str := '';
  while not Terminated do
  begin
    for I := 0 to 5 - 1 do
    begin
      WaitForSingleObject(hEvent2,INFINITE);//�ȴ� �����̷߳������ź�
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
