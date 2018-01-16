unit Event;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,SyncObjs,Thread1,Thread2;

type
  TFM_Event = class(TForm)
    LB_Event: TListBox;
    Btn_Start: TButton;
    Btn_Stop: TButton;
    procedure Btn_StartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Btn_StopClick(Sender: TObject);
  private
    procedure CreateThread;
    procedure FreeThread;
  public
    hThread1:TThread1;
    hThread2:TThread2;
    procedure Update1(Sender:TThread1);
    procedure Update2(Sender:TThread2);
  end;

var
  FM_Event: TFM_Event;
  hEvent1:Cardinal = 0;  //hEvent中的h是按照 Win32命名格式来的
  hEvent2:Cardinal = 0;
implementation

{$R *.dfm}

procedure TFM_Event.Btn_StartClick(Sender: TObject);
begin
  CreateThread;
  SetEvent(hEvent1);
end;

procedure TFM_Event.CreateThread;
begin
  if not Assigned(hThread1) then
  begin
    hThread1 := TThread1.Create(False);
    hThread1.Update := Self.Update1;
  end;

  if not Assigned(hThread2) then
  begin
    hThread2 := TThread2.Create(False);
    hThread2.Update := Self.Update2;
  end;
end;

procedure TFM_Event.FreeThread;
begin
  if Assigned(hThread1) then hThread1.Terminate; //提前告诉线程，线程要结束了
  if Assigned(hThread2) then hThread2.Terminate;

  if Assigned(hThread1) then
  begin
    SetEvent(hEvent1);
    hThread1.WaitFor;
    FreeAndNil(hThread1);
  end;

  if Assigned(hThread2) then
  begin
    SetEvent(hEvent2);
    hThread2.WaitFor;
    FreeAndNil(hThread2);
  end;
end;

procedure TFM_Event.Update1(Sender:TThread1);
begin
  TThread1.Synchronize(nil,
  procedure
  begin
    LB_Event.Items.Add(Sender.Text_Str);
    LB_Event.Items.Add(Sender.Text_Str);
  end);
end;

procedure TFM_Event.Update2(Sender:TThread2);
begin
  TThread2.Synchronize(nil,
  procedure
  begin
    LB_Event.Items.Add(Sender.Text_Str);
  end);
end;

procedure TFM_Event.Btn_StopClick(Sender: TObject);
begin
  FreeThread;
end;

procedure TFM_Event.FormCreate(Sender: TObject);
begin
  hEvent1 := CreateEvent(nil,False,False,nil);
  hEvent2 := CreateEvent(nil,False,False,nil);
end;

procedure TFM_Event.FormDestroy(Sender: TObject);
begin
  FreeThread;
  CloseHandle(hEvent1);
  CloseHandle(hEvent2);
end;

end.
