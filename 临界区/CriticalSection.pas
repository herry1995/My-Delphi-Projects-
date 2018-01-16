unit CriticalSection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,MyThread;

//type
//  TCriTicalSection = class(TObject)
//end;
type
  TMyThread2 = class(TThread)
  protected
    procedure Execute; override;
  end;

  TFM_CriticalSection = class(TForm)
    List_Screen: TListBox;
    Btn_Start: TButton;
    Btn_Stop: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Btn_StartClick(Sender: TObject);
    procedure Btn_StopClick(Sender: TObject);
  private
    { Private declarations }
  public
    hThread1 : TMyThread;
    hThread2 : TMyThread2;

  end;


var
  FM_CriticalSection: TFM_CriticalSection;
  CS:TRTLCriticalSection;

implementation
{$R *.dfm}

procedure TMyThread2.Execute;
var
  I:Integer;
begin
  for I := 0 to 5 - 1 do
  begin
    {这样的临界区是不稳定的,一会儿是正常的,一会儿是不正常,根据查询的资料说
     1. Windows 模块中 CreateThread 和 _beginthread 都不安全会造成内存泄漏,
     推荐使用_beginthreadEx }
    if Terminated then Break;

    Sleep(500);
    EnterCriticalSection(CS);
    FM_CriticalSection.List_Screen.Items.Add('bb');
    LeaveCriticalSection(CS);
    Sleep(500);
  end;
end;

procedure TFM_CriticalSection.Btn_StartClick(Sender: TObject);
begin
  if Assigned(hThread1) then
    hThread1.Free
  else
    hThread1 := TMyThread.Create(False);

  if Assigned(hThread2) then
    hThread2.Free
  else
    hThread2 := TMyThread2.Create(False);
end;

procedure TFM_CriticalSection.Btn_StopClick(Sender: TObject);
begin
  hThread1.Terminate;
  hThread2.Terminate;
end;

procedure TFM_CriticalSection.FormCreate(Sender: TObject);
begin
  InitializeCriticalSection(CS);

end;

procedure TFM_CriticalSection.FormDestroy(Sender: TObject);
begin
  hThread1.Free;
  hThread2.Free;
  DeleteCriticalSection(CS);
end;

end.
