unit MyThread;

interface

uses
  Windows,Classes,SysUtils,Dialogs;

type
  TMyThread = class;
  TUpdate = procedure(Sender: TMythread) of object;
  TMythread = class(TThread)
  private
    WindowsPath:string;
    ExpList:TStringList;
  protected
    procedure Execute; override;
    procedure SearchFile(Path:string);
    procedure ListCreate;
    procedure ListDestroy;
    function IsEmptyDir(sDir: String): Boolean;
  public
    DirCount:Cardinal;
    LBUpdate,LblUpdate: TUpdate;
    FPath,Text,TmpSrc: string;
    ResultList,DirNameList,DirPathList: TStrings;
  end;

implementation


procedure TMyThread.Execute;
var
  I:Char;
  T:Cardinal;
  PathArray:array [0..255] of Char;
begin
  ListCreate;
  T:= GetTickCount;

  {--获取系统文件夹路径--}
  GetWindowsDirectory(@PathArray,255);
  WindowsPath := PathArray;
  WindowsPath := IncludeTrailingPathDelimiter(WindowsPath);

  ExpList.Add(WindowsPath);
  ExpList.Add(ExtractFileDir(WindowsPath)+'.old\'); //排除 Windows和 Windows.old 目录
  DirCount := 0;

  if Length(FPath) > 0 then
    begin
      SearchFile(FPath);
    end
  else
  begin
    for I := 'A'  to 'Z' do
    begin
      FPath := I + ':';
      SearchFile(FPath);
    end;
  end;
  T:= GetTickCount - T;
  OutputDebugString(PChar('T='+ IntToStr(T)));

  LBUpdate(Self);
  ListDestroy;
end;

function TMyThread.IsEmptyDir(sDir: String): Boolean;
var
  SearchRes: TsearchRec;
  TmpSrc:string;
  DeepPath:string;
begin
  TmpSrc := IncludeTrailingPathDelimiter(sDir) ;
  if FindFirst(TmpSrc + '*.*', faAnyFile, SearchRes) = 0 then
  repeat
    if ((SearchRes.Attr and faDirectory ) <> 0)  then // 判断是目录
      begin
        if (SearchRes.Name <> '.') and (SearchRes.Name <> '..')  then // 判断非空目录
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

procedure TMyThread.SearchFile(Path: string);
var
  Found:Integer;
  SearchRes:TSearchRec;
begin
  TmpSrc := IncludeTrailingPathDelimiter(Path);
  if ExpList.IndexOf(TmpSrc) >= 0 then Exit;

  //if SameText(WindowsPath,TmpSrc) then Exit; {--排除操作系统文件--}
  Found := FindFirst(TmpSrc + '*.*',faAnyFile,SearchRes);
  while Found = 0 do
  begin

    if Terminated then Break; //等待线程终止信号，接到信号就Break
   // if SameText('Windows.old',SearchRes.Name) then  Exit; // 跳过 ‘Windows.old’(旧系统) 目录
   // ShowMessage('');

    if ((SearchRes.Attr and faDirectory) = faDirectory) {--搜索到的是目录--}
      and ((SearchRes.Name <> '.') and (SearchRes.Name <> '..')){--排除系统目录 '.','..'--}
      and ((SearchRes.Attr and faHidden ) = 0){--排除隐藏文件--}
      and ((SearchRes.Attr and faSysFile) = 0) {--排除系统文件--}
    then // 目录
    begin
      Inc(DirCount);
      TmpSrc := IncludeTrailingPathDelimiter(Path) + SearchRes.Name;
      Text := SearchRes.Name;

      if DirCount mod 150  = 0 then  LblUpdate(Self);

//      if TmpSrc = 'C:\Windows.old' then
//        OutputDebugString(PChar('TmpSrc1='+TmpSrc));

      if IsEmptyDir(TmpSrc) then
        begin
          ResultList.Add(Text + '  ' + TmpSrc);
          DirPathList.Add(TmpSrc);
        end
      else  SearchFile(TmpSrc);
    end;
    Found :=  FindNext(SearchRes);
  end;
  FindClose(SearchRes);
end;


procedure TMyThread.ListCreate;
begin
  ExpList := TStringList.Create;
  ResultList := TStringList.Create;
  DirNameList := TStringList.Create;
  DirPathList := TStringList.Create;
end;

procedure TMyThread.ListDestroy;
begin
  ExpList.Free;
  ResultList.Free;
  DirNameList.Free;
  DirPathList.Free;
end;

end.
