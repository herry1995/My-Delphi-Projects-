unit Unit5;

interface

uses
  Classes,SysUtils;

type
  TMyThread = class; //此为提前申明

  TOnUpdate = procedure(Sender: TMyThread) of object;
  TMyThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  public
     Num: integer;
     FileName:string;
     FilePath:string;
     FileSize:Cardinal;
     OnUpdate: TOnUpdate;
  end;

implementation



procedure TMyThread.Execute;
var
  i: integer;
begin
  for i := 1 to Num do
  begin
    FileName := inttostr(i);
    FilePath := 'FilePath'+inttostr(i);
    if Assigned(OnUpdate) then
      OnUpdate(self);
  end;

end;

end.
