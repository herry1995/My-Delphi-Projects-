program ScanEmptyFolderTool;

uses
  Forms,
  SearchFloder in 'SearchFloder.pas' {Fm_EmptyFloder},
  MyThread in 'MyThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFm_EmptyFloder, Fm_EmptyFloder);
  Application.Run;
end.
