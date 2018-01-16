unit SearchFloder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls ,MyThread, ShellAPI;

type
  TFm_EmptyFloder = class(TForm)
    Btn_Scan: TButton;
    Btn_Stop: TButton;
    LB_EmptyDir: TListBox;
    Lbl_ShowPath: TLabel;
    Edit_Path: TEdit;
    Lbl_Path: TLabel;
    Btn_EmptyFileTest: TButton;
    procedure Btn_ScanClick(Sender: TObject);
    procedure Btn_StopClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LB_EmptyDirDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    hThread:TMyThread;
    MyList,MyPathList: TStrings;
    procedure CreateThread;
    procedure FreeThread;
    procedure LBUpdate(Sender:TMyThread);
    procedure LblUpdate(Sender:TMyThread);
    procedure ShowDirName(Sender: TObject);
  public
    function IsEmptyDir(sDir: String): Boolean;
  end;

var
  Fm_EmptyFloder: TFm_EmptyFloder;

implementation

{$R *.dfm}


function TFm_EmptyFloder.IsEmptyDir(sDir: String): Boolean;
var
  SearchRes: TSearchRec;
  TmpSrc:string;
  DeepPath:string;
begin
  TmpSrc := IncludeTrailingPathDelimiter(sDir) ;
  if FindFirst(TmpSrc + '*.*', faAnyFile, SearchRes) = 0 then
  repeat
    if ((SearchRes.Attr and faDirectory ) <> 0)  then
    begin
      if (SearchRes.Name <> '.') and (SearchRes.Name <> '..')  then
      begin
        DeepPath := TmpSrc+SearchRes.Name;
        Result := IsEmptyDir(DeepPath);
      end;
    end
    else
    begin
      Result := False;
      //OutputDebugString(PChar('Result='+BoolToStr(Result,True)));
      Break;
    end;
  until FindNext(SearchRes) <> 0;
  FindClose(SearchRes);
end;

procedure TFm_EmptyFloder.LB_EmptyDirDblClick(Sender:TObject);
var
  Tmp: string;
begin
  Tmp := MyPathList[LB_EmptyDir.ItemIndex];
  ShellExecute(Handle,'open','Explorer.exe',PChar(Tmp),nil,1);
end;

procedure TFm_EmptyFloder.LBUpdate(Sender: TMyThread);
begin
  TThread.Synchronize(nil,
  procedure
  begin
    LB_EmptyDir.Items.AddStrings(Sender.ResultList);
    MyPathList.AddStrings(Sender.DirPathList);
  end);
end;

procedure TFm_EmptyFloder.LblUpdate(Sender:TMyThread);
begin
  TThread.Synchronize(nil,
  procedure
  begin
    Lbl_ShowPath.Caption := Sender.TmpSrc;
  end);
end;

procedure TFm_EmptyFloder.CreateThread;
begin
  if Assigned(hThread) then FreeThread
  else
  begin
    hThread := TMyThread.Create(False);
    hThread.FPath := Edit_Path.Text;
    hThread.LblUpdate := Self.LblUpdate;
    hThread.LBUpdate := Self.LBUpdate;
    hThread.OnTerminate := Self.ShowDirName;
  end;
end;

procedure TFm_EmptyFloder.FreeThread;
begin
  if Assigned(hThread) then  hThread.Terminate;
  if Assigned(hThread) then
  begin
    hThread.WaitFor;
    FreeAndNil(hThread);
  end;
end;

procedure TFm_EmptyFloder.Btn_ScanClick(Sender: TObject);
begin
  if Assigned(hThread) then FreeThread;

  CreateThread;
  LB_EmptyDir.Clear;
end;

procedure TFm_EmptyFloder.Btn_StopClick(Sender: TObject);
begin
  FreeThread;
end;

procedure TFm_EmptyFloder.FormCreate(Sender: TObject);
begin
  MyList := TStringList.Create;
  MyPathList := TStringList.Create;
end;

procedure TFm_EmptyFloder.FormDestroy(Sender: TObject);
begin
  FreeThread;
  MyList.Free;
  MyPathList.Free;
end;

procedure TFm_EmptyFloder.ShowDirName(Sender: TObject);
begin
  LBUpdate(hThread);
end;


end.
