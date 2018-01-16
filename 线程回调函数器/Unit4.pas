unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Unit5;

type
  TForm4 = class(TForm)
    ListView1: TListView;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
     procedure OnUpdateData(Sender: TMyThread);
  end;

var
  Form4: TForm4;

implementation



{$R *.dfm}
procedure TForm4.OnUpdateData(Sender: TMyThread);
begin
  TThread.Synchronize(nil,
    procedure
    var
      Item:TListItem;
    begin
      Item := ListView1.Items.Add;
      Item.Caption := Sender.FileName;
      Item.SubItems.Add(Sender.FilePath);
    end);
end;
procedure TForm4.Button1Click(Sender: TObject);
var
  Thread: TMyThread;
begin
  Thread := TMyThread.Create(true);
  Thread.OnUpdate := self.OnUpdateData;
  Thread.FreeOnTerminate := true;
  Thread.Num := 100;
  Thread.Resume;
end;

end.
