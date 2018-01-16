unit RepeatFiles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MyThread, ShellAPI, ShlObj, ComCtrls, IdGlobalProtocols,
  ExtCtrls;

type
  TFM_RepeatFiles = class(TForm)
    Btn_Search: TButton;
    Btn_SearchStop: TButton;
    Edit_Path: TEdit;
    Lbl_SearchPath: TLabel;
    Lbl_PathName: TLabel;
    Lbl_ShowPath: TLabel;
    LV_Files: TListView;
    PB_Progress: TProgressBar;
    Lbl_Progress: TLabel;
    procedure Btn_SearchClick(Sender: TObject);
    procedure Btn_SearchStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure LB_FilesDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Display(Sender: TObject);
  private
    Over:Integer;
    hThread: TMyThread;
    MyFileList: TStrings;

    procedure CreateThread;
    procedure FreeThread;

  public

    procedure ShowPath(Sender:TMyThread);
    procedure ShowFile(Sender:TMyThread);
    procedure ShowProgress(Sender:TMyThread);
    function GetFinalFileSize(FilePath:string):string;

  end;

var
  FM_RepeatFiles: TFM_RepeatFiles;

implementation

{$R *.dfm}

procedure TFM_RepeatFiles.Btn_SearchClick(Sender: TObject);
begin
  if Assigned(hThread) then FreeThread;
  LV_Files.Clear;
  CreateThread;
end;

procedure TFM_RepeatFiles.Btn_SearchStopClick(Sender: TObject);
begin
  FreeThread;
end;

procedure TFM_RepeatFiles.CreateThread;
begin
  if Assigned(hThread) then FreeThread;

  hThread := TMyThread.Create(False);
  hThread.FPath := Edit_Path.Text;
  hThread.ShowPath := Self.ShowPath;
  hThread.ShowFiles := Self.ShowFile;
  hThread.ShowProgress := Self.ShowProgress;
  hThread.OnTerminate := Display;
end;

procedure TFM_RepeatFiles.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Over := 1;
  FreeThread;
end;

procedure TFM_RepeatFiles.FormCreate(Sender: TObject);
begin
  MyFileList := TStringList.Create;
end;

procedure TFM_RepeatFiles.FormDestroy(Sender: TObject);
begin
  FreeThread;
  MyFileList.Free;
end;

procedure TFM_RepeatFiles.FreeThread;
begin
  if Assigned(hThread) then hThread.Terminate;

  if Assigned(hThread) then
  begin
    hThread.WaitFor;
    FreeAndNil(hThread);
  end;
end;

procedure TFM_RepeatFiles.LB_FilesDblClick(Sender: TObject);
var
  Tmp:string;
begin
  //Tmp := MyPathList[LV_Files.ItemIndex];
  ShellExecute(Handle,'open','Explorer.exe',PChar(Tmp),nil,1);
end;

procedure TFM_RepeatFiles.ShowPath(Sender: TMyThread);
begin
  TThread.Synchronize(nil,
  procedure
  begin
    Lbl_ShowPath.Caption := Sender.TmpPath;
  end);
end;

procedure TFM_RepeatFiles.ShowProgress(Sender:TMyThread);
begin
  TThread.Synchronize(nil,
  procedure
  begin
    PB_Progress.Position := Sender.Position;
  end);
end;

procedure TFM_RepeatFiles.ShowFile(Sender: TMyThread);
begin
  if Over = 1 then Exit;
  TThread.Synchronize(nil,
  procedure
  begin
    with LV_Files.Items.Add do
    begin
      Caption := Sender.FileNo;
      SubItems.Add(Sender.FileName);
      SubItems.Add(Sender.FileSize);
      SubItems.Add(Sender.FilePath);
    end
  end);
end;
//begin
//  TThread.Synchronize(nil, -->  如果这里不去掉，这样将执行完成后才会显示在listview上
//  procedure
// 这样会导致的结果是，应用程序会无响应！造成应用程序卡死现象！

{--所以这下面的就是动态显示--}
//var
//  I: Integer;
//begin
//  MyFileList.Clear;
//  MyFileList.AddStrings(Sender.FileList);
//
//  for I := 0 to MyFileList.Count - 1 do
//  begin
//    if Over = 1 then Break;    // 触发onClose 事件时解救该循环
//
//    with LV_Files.Items.Add do
//    begin
//      Caption := IntToStr(I + 1);
//      SubItems.Add(ExtractFileName(MyFileList[I]));
//      SubItems.Add(GetFinalFileSize(MyFileList[I]));
//      SubItems.Add(MyFileList[I]);
//    end;
//  end;
//end;

function TFM_RepeatFiles.GetFinalFileSize(FilePath:string):string;
var
  Size:Integer;
begin
  Size := FileSizeByName(FilePath);
  if Size > 1073741824  then
    Result := FormatFloat('###,##0.0  G', Size / 1073741824)
  else if Size > 1048576 then
    Result := FormatFloat('###,##0.0  M', Size / 1048576)
  else if Size > 1024 then
    Result := FormatFloat('###,##0  K', Size / 1024)
  else
    Result := FormatFloat('###,##0  B',Size);
end;

procedure TFM_RepeatFiles.Display(Sender: TObject);
var
  I:Integer;
begin

end;

end.
