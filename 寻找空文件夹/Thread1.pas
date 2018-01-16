unit Thread1;

interface

uses
  Classes,Windows,SysUtils;

type
  TMyThread = class;
  TLBUpdate = procedure(Sender: TMyThread) of object;
  TLblUpdate = procedure(Sender: TMyThread) of object;
  TMyThread = class(TThread)
  protected
    procedure Execute; override;
    procedure SearchDir(Path:string);
  public
    FPath,TmpSrc,Text:string;
    LblUpdate:TLblUpdate;
    LBUpdate:TLblUpdate;
  end;

implementation

uses
  FindEmptyDir;

procedure TMyThread.Execute;
var
  I:Char;
begin
  if Length(FPath) <> 0 then
  begin
    SearchDir(FPath);
  end
  else
  begin
    for I := 'A' to 'Z' do
    begin
      FPath := I + ':';
      SearchDir(FPath);
    end;
  end;
end;

procedure TMyThread.SearchDir(Path:string);
var
  Found:Integer;
  SearchRes:TSearchRec;
begin
  TmpSrc := IncludeTrailingPathDelimiter(Path);
  Found := FindFirst(TmpSrc + '*.*',faAnyFile,SearchRes);

  while Found = 0 do
  begin
    if Terminated then Break;
    
    if (SearchRes.Attr and faDirectory) <> 0 then  //如果是目录
    begin
      if (SearchRes.Name <> '.') and (SearchRes.Name <> '..') then  //不为空目录
      begin
        TmpSrc := IncludeTrailingPathDelimiter(Path) + SearchRes.Name;
        if Assigned(LblUpdate) then
        begin
          LblUpdate(Self);
          Text :=SearchRes.Name;
        end;
        SearchDir(TmpSrc);
      end;
      if SearchRes.Name = '.' then
      begin
        if Assigned(LBUpdate) then
          LBUpdate(Self);
      end;
    end;
    Found := FindNext(SearchRes);
  end;
  FindClose(SearchRes);
end;



end.
