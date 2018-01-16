program SearchFile;

uses
  Forms,
  FindFiles in 'FindFiles.pas' {Fm_Main};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFm_Main, Fm_Main);
  Application.Run;
end.
