unit Progress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,Thread1, Buttons;

type
  TFM_Progress = class(TForm)
    PB_Progress: TProgressBar;
    Btn_Start: TButton;
    Btn_Stop: TBitBtn;
    procedure Btn_StartClick(Sender: TObject);
    procedure Update(Sender: TThread1);
    procedure Btn_StopClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FM_Progress: TFM_Progress;
  MyThread: TThread1;

implementation

{$R *.dfm}

procedure TFM_Progress.Btn_StopClick(Sender: TObject);
begin
  MyThread.Terminate;
end;

procedure TFM_Progress.FormDestroy(Sender: TObject);
begin
  MyThread.Free;
end;

procedure TFM_Progress.Update(Sender:TThread1);
begin
  TThread.Synchronize(nil,
  procedure
  begin
    PB_Progress.position := Sender.Position;
  end);
end;

procedure TFM_Progress.Btn_StartClick(Sender: TObject);
begin
  if Assigned(MyThread) then MyThread.Free;

  Mythread := TThread1.Create(True);
  MyThread.Update := Self.Update;
  MyThread.Resume;
end;

end.
