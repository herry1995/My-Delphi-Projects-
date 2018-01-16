unit FindFiles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFm_Main = class(TForm)
    Edit_Path: TEdit;
    Edit_FileName: TEdit;
    Btn_Find: TButton;
    Lbl_Path: TLabel;
    Lbl_FileName: TLabel;
    List_FileList: TListBox;
    Btn_Queue: TButton;
    procedure Btn_FindClick(Sender: TObject);
    procedure Btn_QueueClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    MyList:TStrings;
  public
    procedure SearchCurPathFile(path:string);
    procedure EnumFileInRecursion(Path:string);
    procedure EnumFileInQueue(path:string);
  end;

var
  Fm_Main: TFm_Main;

implementation

{$R *.dfm}
procedure TFm_Main.Btn_FindClick(Sender: TObject);
var
  Path: string;
begin
  Path := Edit_Path.Text;
  EnumFileInRecursion(Path);
end;

procedure TFm_Main.Btn_QueueClick(Sender: TObject);
var
  Path:string;
begin
  Path:= Edit_Path.Text;
  EnumFileInQueue(Path);
end;

procedure TFm_Main.FormCreate(Sender: TObject);
begin
  MyList := TStringList.Create;
end;

procedure TFm_Main.FormDestroy(Sender: TObject);
begin
  MyList.Free;
end;

//递归方式搜索文件
procedure TFm_Main.EnumFileInRecursion(Path:string);
var
  SearchRes: TSearchRec;
  Found : Integer;
  TmpStr : string;
begin
  TmpStr := IncludeTrailingPathDelimiter(Path) + '*.*';
  Found := FindFirst(TmpStr,faAnyFile,SearchRes);
  while Found = 0 do
  begin
    if SearchRes.Attr and faDirectory <> 0 then //目录
      begin
        if (SearchRes.Name <> '.') and (SearchRes.Name <> '..') then
        begin
          TmpStr := IncludeTrailingPathDelimiter(Path) + SearchRes.Name;
          EnumFileInRecursion(TmpStr);
        end;
      end
    else
    begin
      List_FileList.Items.Add('File: ' + SearchRes.Name + '  ' + IntToStr(SearchRes.Size));
    end;
    Found := FindNext(SearchRes);
  end;
  FindClose(SearchRes);
end;

//队列搜索方式：
procedure TFm_Main.EnumFileInQueue(path: string);
var
  TmpSrc: string;
  SearchRec: TSearchRec;
  Found:Integer;
begin
  MyList.Clear;
  MyList.Add(path);
  while MyList.Count > 0 do
  begin
    path := MyList[MyList.Count - 1];
    MyList.Delete(MyList.Count - 1);
    TmpSrc := IncludeTrailingPathDelimiter(path) + '*.*';
    Found := FindFirst(TmpSrc,faAnyFile,SearchRec);

    while Found = 0 do
    begin
        //如果是目录
      if (SearchRec.Attr and faDirectory) <> 0 then
      begin //目录里还有目录
        if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
        begin
          TmpSrc := IncludeTrailingPathDelimiter(path) + SearchRec.Name;
          MyList.Add(TmpSrc);
          //EnumFileInQueue(tmpSrc);
        end;
      end
      else
      begin
        List_FileList.Items.Add('FILE: ' + SearchRec.Name + ' ' + IntToStr(SearchRec.Size));
      end;
      Found := FindNext(SearchRec);
    end;
  end;
  FindClose(SearchRec);

end;

//搜索当前路径所有文件
procedure TFm_Main.SearchCurPathFile(path:string);
var
  Found:Integer;
  SearchRec:TSearchRec;
  TmpPath:string;
begin
  TmpPath:= IncludeTrailingPathDelimiter(path) + '*.*';
  Found := FindFirst(TmpPath,faAnyFile,SearchRec);
  while Found = 0 do
  begin
    if (SearchRec.Attr and faDirectory) = 0 then  //如果是文件
      List_FileList.Items.Add('File:' + SearchRec.Name + ' ' + IntToStr(SearchRec.Size));

    Found:= FindNext(SearchRec);
  end;
  FindClose(SearchRec);
end;


end.
