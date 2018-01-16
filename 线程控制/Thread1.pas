unit Thread1;

interface

uses
  Classes;

type
  TThread1 = class;
  TUpdate = procedure(Sender: TThread1) of object;
  TThread1 = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  public
  Position:Cardinal;
  Update:TUpdate;
  end;

implementation

uses
  Progress,Windows;

procedure TThread1.Execute;
var
  I:Integer;
begin
  for I := 0 to 101 - 1 do
  begin
    if not Terminated then
    begin
      Position := I;
      Sleep(50);
      if Assigned(Update) then
        Update(Self);
    end;
  end;
end;

end.
