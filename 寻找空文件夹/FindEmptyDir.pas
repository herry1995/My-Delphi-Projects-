unit FindEmptyDir;

interface

uses
  Windows, Messages,SysUtils,Variants,Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Thread1, ShellAPI;

type
  TFM_FindEmptyDir = class(TForm)
    LB_EmptyDir: TListBox;
    Btn_Scan: TButton;
    Btn_Stop: TButton;
    Edit_Path: TEdit;
    Lbl_Path: TLabel;
    Lbl_ShowSearchPath: TLabel;
    procedure Btn_ScanClick(Sender: TObject);
    procedure Btn_StopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    procedure ThreadExit(Sender: TObject);
  protected
    procedure Update1(Sender:TMyThread);
    procedure Update2(Sender:TMyThread);
  public
    procedure FreeThread;
    procedure CreateThread;
  end;

var
  FM_FindEmptyDir: TFM_FindEmptyDir;
  hThread: TMyThread;
  DirList: TStrings;

implementation

{$R *.dfm}

procedure TFM_FindEmptyDir.Btn_StopClick(Sender: TObject);
begin
  if Assigned(hThread) then
  begin
    FreeThread;
  end;
end;

procedure TFM_FindEmptyDir.CreateThread;
begin
  if not Assigned(hThread) then
  begin
    hThread := TMyThread.Create(False);
    hThread.FPath := Edit_Path.Text;
    hThread.LblUpdate := Self.Update1;
    hThread.LBUpdate := Self.Update2;
    hThread.OnTerminate := ThreadExit;//线程结束时，执行结束事件
  end;
end;

procedure TFM_FindEmptyDir.FormCreate(Sender: TObject);
begin
  DirList := TStringList.Create;
end;

procedure TFM_FindEmptyDir.FormDestroy(Sender: TObject);
begin
  FreeThread;
  DirList.Free;
end;

procedure TFM_FindEmptyDir.FreeThread;
begin
  if Assigned(hThread) then
    hThread.Terminate;

  if Assigned(hThread) then
  begin
    hThread.WaitFor;
    FreeAndNil(hThread);
  end;
end;

procedure TFM_FindEmptyDir.ThreadExit(Sender: TObject);
var
  I:Integer;
begin
  for I := 0 to DirList.Count - 1  do
  begin
    FM_FindEmptyDir.LB_EmptyDir.Items.Add(DirList[I]);
  end;
end;

procedure TFM_FindEmptyDir.Update1(Sender: TMyThread);
begin
  TThread.Synchronize(nil,
  procedure
  begin
    Lbl_ShowSearchPath.Caption := Sender.TmpSrc;
  end);
end;

procedure TFM_FindEmptyDir.Update2(Sender: TMyThread);
begin
  TThread.Synchronize(nil,
  procedure
  begin
    if Length(Sender.Text) > 0 then
      DirList.Add(Sender.Text + '   ' + Sender.TmpSrc);
    //LB_EmptyDir.Items.Add(Sender.Text + '    ' + Sender
    //.TmpSrc);
  end);
end;

procedure DisplayDir;
var
  I:Integer;
begin
  for I := 0 to DirList.Count - 1  do
  begin
    FM_FindEmptyDir.LB_EmptyDir.Items.Add(DirList[I]);
  end;
end;

procedure TFM_FindEmptyDir.Btn_ScanClick(Sender: TObject);
begin
  if Assigned(hThread) then
  begin
    FreeThread;
    LB_EmptyDir.Items.Clear;
  end;
  CreateThread;
end;

end.
