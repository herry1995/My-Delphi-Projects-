unit Mutex;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Thread1,Thread2;

type
  TFM_Mutex = class(TForm)
    LB_Mutex: TListBox;
    Btn_Start: TButton;
    Btn_Stop: TButton;
    procedure Btn_StartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Btn_StopClick(Sender: TObject);
  private
    { Private declarations }
  public
    hThread1: TThread1;
    hThread2: TThread2;
    procedure Update1(Sender:TThread1);
    procedure Update2(Sender:TThread2);
  end;

var
  FM_Mutex: TFM_Mutex;
  hMutex1: Cardinal = 0;
//  hMutex2: Cardinal = 0;
implementation

{$R *.dfm}

procedure TFM_Mutex.Update1(Sender:TThread1);
begin
  TThread.Synchronize(nil,
  procedure
  begin
    LB_Mutex.Items.Add(Sender.Text_Src);
    LB_Mutex.Items.Add(Sender.Text_Src);
  end);
end;

procedure TFM_Mutex.Update2(Sender:TThread2);
begin
  TThread.Synchronize(nil,
  procedure
  begin
    LB_Mutex.Items.Add(Sender.Text_Src);
  end);
end;

procedure TFM_Mutex.Btn_StartClick(Sender: TObject);
begin
  // Thread1 := TThread1.Create(True);
  // Thread2 := TThread2.Create(True);

  hThread1.Update := Self.Update1;
  hThread2.Update := Self.Update2;
  hThread1.Resume;
  hThread2.Resume;
end;

procedure TFM_Mutex.Btn_StopClick(Sender: TObject);
begin
  hThread1.Terminate;
  hThread2.Terminate;
end;

procedure TFM_Mutex.FormCreate(Sender: TObject);
begin
  hMutex1 := CreateMutex(nil,False,nil);
//  hMutex2 := CreateMutex(nil,False,nil);
  hThread1 := TThread1.Create(True);
  hThread2 := TThread2.Create(True);
end;

procedure TFM_Mutex.FormDestroy(Sender: TObject);
begin
  CloseHandle(hMutex1);
//  CloseHandle(hMutex2);
  hThread1.Free;
  hThread2.Free;
end;


end.
