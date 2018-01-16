unit MyThread;

interface

uses
  Classes, Windows, SysUtils, Dialogs, AnsiStrings, IdGlobalProtocols;

type
  TMyThread = class;
  TUpdate = procedure (Sender:TMyThread) of object;
  TMyThread = class(TThread)

  public
    FPath,WindowsPath,TmpPath:string;
    ExpList,DriverList,FileList: TStringList;
    SearchPathList,ExtendList:TStrings;
    ShowPath,ShowFiles,ShowProgress:TUpdate;
    FileNo,FileName,FileSize,FilePath:string;
    Position:Integer;
    FileCnt: Cardinal;

  private
    procedure GetWindowsDir;
    procedure CreateList;
    procedure DestoryList;
    procedure SearchRepeatFiles(Path:string);
    procedure SearchFile(Path:string);
    procedure DeleteSingleStr(StrList:TStringList);
    procedure GetMyStringList(StrList:TStringList);
    function GetFinalFileSize(FilePath:string):string;


  protected
    procedure Execute; override;
    procedure GetDriverInfo;

  end;

  function MyComPare(List: TStringList; Index1, Index2: Integer): Integer;
  procedure GetRepeatString(StrList: TStringList);

implementation


procedure TMyThread.Execute;
var
  I:Integer;
  Time:Cardinal;
begin
  CreateList;
  Time := GetTickCount;
  GetDriverInfo;
  GetWindowsDir;
  Position := 1;
  ShowProgress(Self);
  try
    if Length(FPath) > 0 then
      SearchRepeatFiles(FPath)
//        SearchFile(FPath)
    else
    begin
      for I := 0 to DriverList.Count - 1 do
      begin
        FPath := (DriverList[I] + '\');
//        ShowMessage(DriverList.Text);

        SearchRepeatFiles(FPath);
        if (Position >= 1) and (Position <= 25) then
        begin
          Position := Position + (25 div DriverList.Count);
          ShowProgress(Self);
        end;
//          SearchFile(FPath);
        if Terminated then Break; // 点击停止按钮后就不会继续向下执行
      end;
    end;

    if Terminated then Exit;

    FileList.CustomSort(MyCompare);
    Position := 50;
    ShowProgress(Self);
//      DeleteSingleStr(FileList);
    GetMyStringList(FileList);
 //     GetRepeatString(FileList);
    //ShowFiles(Self);
    Position := 75;
    ShowProgress(Self);
    for I := 0 to FileList.Count - 1 do
      begin
        if Terminated then Break;

        Position := 75;
        FileNo := IntToStr( I + 1);
        FilePath := FileList[I];
        FileName := ExtractFileName(FilePath);
        FileSize := GetFinalFileSize(FilePath);
        ShowFiles(Self);
        if (Position >= 75) and (Position <= 100)
          and (I mod 25 = 0) then
        begin
          Position := Position + (25*I  div FileList.Count);
          ShowProgress(Self);
        end;
      end;
    Position := 100;
    ShowProgress(Self);
//      ShowMessage(IntToStr(FileList.Count));
  finally
    DestoryList;
    Time:= GetTickCount - Time;
    OutputDebugString(PChar('Time ='+ IntToStr(Time)));
  end;
end;

function TMyThread.GetFinalFileSize(FilePath:string):string;
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


function MyCompare(List: TStringList; Index1, Index2: Integer): Integer;
var
  MyFileName1,MyFileName2:string;
  MyFileSize1,MyFileSize2,Num:Integer;
begin
  MyFileName1 := ExtractFileName(List[Index1]);
  MyFileName2 := ExtractFileName(List[Index2]);

  Num := AnsiCompareFileName(MyFileName1,MyFileName2);
  if Num < 0 then Result := -1
  else if Num > 0  then Result := 1
  else
  begin
    MyFileSize1 := FileSizeByName(List[Index1]);
    MyFileSize2 := FileSizeByName(List[Index2]);

    if MyFileSize1 > MyFileSize2 then Result := -1
    else if MyFileSize1 < MyFileSize2  then Result := 1
    else
      Result := 0;
  end;
end;

{--做此过程之前必须保证链表是已经排好序了--}
procedure TMyThread.DeleteSingleStr(StrList: TStringList);
var
  I:Integer;
  Tmp:string;
begin
  if StrList.Count > 1 then //避免链表为空时，越界危险
  begin
    Tmp := ExtractFileName(StrList[StrList.Count - 1]);
    for I := (StrList.Count - 2) downto 1 do
    begin
      //if Terminated then  Break;

      if not SameStr(Tmp,ExtractFileName(StrList[I])) then
      begin
//        Tmp := ExtractFileName(StrList[I]);
        if not SameStr(ExtractFileName(StrList[I]),ExtractFileName(StrList[I - 1])) then
        begin
          if I = 1 then  StrList.Delete(0);
          StrList.Delete(I);
        end;
        Tmp := ExtractFileName(StrList[I]);
      end
//      else
//      Tmp := ExtractFileName(StrList[I]);
    end;
  end;
end;

procedure GetRepeatString(StrList: TStringList);
var
  I:Integer;
  Tmp:string;
begin
  if StrList.Count > 1 then //避免链表为空时，越界危险
  begin
    Tmp := StrList[StrList.Count - 1];
    for I := (StrList.Count - 1) downto 1 do
    begin
      if not SameStr(ExtractFileName(Tmp),ExtractFileName(StrList[I])) then
        begin
          if not SameStr(ExtractFileName(StrList[I]),ExtractFileName(StrList[I - 1])) then
          begin
            if I = 1 then  StrList.Delete(0);
            Tmp := StrList[I - 1];
            StrList.Delete(I);
          end
          else
            if FileSizeByName(Tmp) <> FileSizeByName(StrList[I - 1]) then
            begin
              Tmp := StrList[I - 1];
              StrList.Delete(I);
            end;
        end
      else
      begin
        if FileSizeByName(Tmp) <> FileSizeByName(StrList[I]) then
        begin
          if not SameStr(ExtractFileName(StrList[I]),ExtractFileName(StrList[I - 1])) then
          begin
            if I = 1 then  StrList.Delete(0);
            Tmp := StrList[I - 1];
            StrList.Delete(I);
          end
          else
            if FileSizeByName(Tmp) <> FileSizeByName(StrList[I - 1]) then
            begin
              Tmp := StrList[I - 1];
              StrList.Delete(I);
            end;
        end;
      end;
//      else
//      Tmp := ExtractFileName(StrList[I]);
//      StrList.Delete(I);
    end;
  end;
end;

{--前提是链表已经进行过排序--}
procedure TMyThread.GetMyStringList(StrList:TStringList);
var
  I:Integer;
  List:TStringList;
begin
  List := TStringList.Create;
  try
    for I := 0 to StrList.Count - 1 do
    begin
      {--链表头--}
      if I = 0 then
        begin
          if not SameStr(ExtractFileName(StrList[I]),ExtractFileName(StrList[I + 1]))  then
            List.Add(IntToStr(I))
          else
            if FileSizeByName(StrList[I]) <> FileSizeByName(StrList[I + 1]) then
            List.Add(IntToStr(I));
        end
        {--链表尾--}
      else if I = (StrList.Count - 1) then
      begin
        if not SameStr(ExtractFileName(StrList[I - 1]),ExtractFileName(StrList[I])) then
          List.Add(IntToStr(I))
        else
          if FileSizeByName(StrList[I - 1]) <> FileSizeByName(StrList[I]) then
            List.Add(IntToStr(I));
      end
      else {--链表中间--}
      begin
        {--链表节点左边名字不同--}
        if not SameStr(ExtractFileName(StrList[I - 1]),ExtractFileName(StrList[I])) then
        begin
          {--链表节点右边名字不同--}
          if not SameStr(ExtractFileName(StrList[I]),ExtractFileName(StrList[I + 1])) then
            List.Add(IntToStr(I))
          else
            {--右边节点名字相同，但是文件大小不相同--}
            if FileSizeByName(StrList[I]) <> FileSizeByName(StrList[I + 1]) then
            List.Add(IntToStr(I));
        end
        else
          {--链表节点左边名字相同，文件大小不相同--}
        if FileSizeByName(StrList[I - 1]) <> FileSizeByName(StrList[I]) then
        begin
          {--链表节点右边名字不相同--}
          if not SameStr(ExtractFileName(StrList[I]),ExtractFileName(StrList[I + 1])) then
            List.Add(IntToStr(I))
          else
            {--链表节点右边名字相同，大小不相同--}
            if FileSizeByName(StrList[I]) <> FileSizeByName(StrList[I + 1]) then
            List.Add(IntToStr(I));
        end;
      end;
    end;
    {--删除记录下单一字符串在链表中的位置--}
    for I := 0 to List.Count - 1  do
    begin
      TmpPath := StrList[StrToInt(List[I]) - I];
      Position := Position + (25 div List.Count);
      StrList.Delete(StrToInt(List[I]) - I);
    end;
  finally
    List.Free;
  end;
end;

procedure TMyThread.CreateList;
begin
  DriverList := TStringList.Create;
  ExpList := TStringList.Create;
  SearchPathList := TStringList.Create;
  FileList := TStringList.Create;
  ExtendList := TStringList.Create;
end;

procedure TMyThread.DestoryList;
begin
  ExpList.Free;
  DriverList.Free;
  FileList.Free;
  SearchPathList.Free;
  ExtendList.Free;
end;

procedure TMyThread.GetDriverInfo;
var
  I:Integer;
begin
  for I := 65 to 90 do
  begin
    if (GetDriveType(Pchar(Chr(I)+':\')) = 2) or (GetDriveType(Pchar(Chr(I)+':\')) = 3) then
      DriverList.Add(Chr(I) + ':');
  end;
end;

procedure TMyThread.GetWindowsDir;
var
  PathArray:array [0..255] of Char;
begin
  GetWindowsDirectory(@PathArray,255);
  WindowsPath := PathArray;
  WindowsPath := IncludeTrailingPathDelimiter(WindowsPath);

  ExpList.Add(WindowsPath);
  ExpList.Add(ExtractFileDir(WindowsPath)+'.old\'); //排除 Windows和 Windows.old 目录
  ExpList.Add(GetEnvironmentVariable('TMP') + '\');
  ExpList.Add(GetEnvironmentVariable('APPDATA') + '\');
  ExpList.Add(GetEnvironmentVariable('HOMEDRIVE') + '\Program Files\');
  ExpList.Add(GetEnvironmentVariable('HOMEDRIVE') + '\Program Files (x86)\');
  ExpList.Add(GetEnvironmentVariable('ALLUSERSPROFILE') + '\');

  ExtendList.Add('.jpg');
  ExtendList.Add('.png');
  ExtendList.Add('.txt');
  ExtendList.Add('.pas');
  ExtendList.Add('.xml');
  ExtendList.Add('.doc');
  ExtendList.Add('.msi');
  ExtendList.Add('.htm');
end;

{-队列-}
procedure TMyThread.SearchRepeatFiles(Path:string);
var
  SearchRes:TSearchRec;
  Found:Integer;
begin
  SearchPathList.Add(Path);
  while SearchPathList.Count > 0 do
  begin
    Path := SearchPathList[SearchPathList.Count - 1];
    SearchPathList.Delete(SearchPathList.Count - 1);
    TmpPath := IncludeTrailingPathDelimiter(Path);

    if ExpList.IndexOf(TmpPath) >= 0 then Continue;//排除系统路径

    if FileCnt mod 150 = 0 then
      if Assigned(ShowPath) then ShowPath(Self);

    Found := FindFirst(Path + '*.*',faAnyFile,SearchRes);//TmpPath -> Path 原因全局变量会被搜索到的文件夹所改变
    while Found = 0 do
    begin
      if Terminated then Break;

      if ((SearchRes.Attr and faDirectory) <> 0) then
        begin
          if (SearchRes.Name <> '.') and (SearchRes.Name <> '..') then
          begin;
            Inc(FileCnt);
            TmpPath := IncludeTrailingPathDelimiter(Path) + SearchRes.Name + '\';
            SearchPathList.Add(TmpPath);
          end;
        end
      else
      begin
        if ExtendList.IndexOf(ExtractFileExt(SearchRes.Name)) >= 0 then
        begin
          //OutputDebugString(PChar('Path='+TmpPath + SearchRes.Name));
          FileList.Add(Path + SearchRes.Name );
        end;
      end;
      Found := FindNext(SearchRes);
    end;
    FindClose(SearchRes);
    if Terminated then Break;
  end;
end;

{-递归-}
procedure TMyThread.SearchFile(Path:string);
var
  SearchRes:TSearchRec;
begin
  if FindFirst(IncludeTrailingPathDelimiter(Path) +'*.*',faAnyFile,SearchRes) = 0 then
  repeat
    if Terminated then Break;
    if ExpList.IndexOf(IncludeTrailingPathDelimiter(Path)) >=0 then Exit;

    if (SearchRes.Attr and faDirectory) <> 0 then
      begin
        if (SearchRes.Name <> '.') and (SearchRes.Name <> '..') then
        begin
          TmpPath := IncludeTrailingPathDelimiter(Path) + SearchRes.Name;

          ShowPath(Self);

          SearchFile(TmpPath);
        end;
      end
    else
      if ExtendList.IndexOf(ExtractFileExt(SearchRes.Name)) >= 0 then
      begin
        FileList.Add(TmpPath + '\' + SearchRes.Name);
      end;
  until FindNext(SearchRes) <> 0;
  FindClose(SearchRes);
end;
end.
