unit Thread1;

interface

uses
  Classes,Windows;
type
  TThread1 = class;
  TUpdate =  procedure(Sender: TThread1) of object;
  TThread1 = class(TThread)
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


procedure TThread1.Execute;
var
  I:Integer;
begin
  while not Terminated do
  begin
    for I := 0 to 5 - 1 do
    begin
      if Terminated then Break;

      //WaitForSingleObject(hMutex1,INFINITE);//Ëø×¡
      Text_Src := 'aa';
      if Assigned(Update) then
          Update(Self);
      //ReleaseMutex(hMutex1);
      Sleep(500);
    end;
    Suspend;
  end;
end;

end.
