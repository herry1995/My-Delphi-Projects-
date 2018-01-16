object FM_FindEmptyDir: TFM_FindEmptyDir
  Left = 0
  Top = 0
  Caption = #26597#25214#31354#25991#20214#22841
  ClientHeight = 345
  ClientWidth = 564
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Lbl_Path: TLabel
    Left = 7
    Top = 51
    Width = 36
    Height = 13
    Caption = #36335#24452#65306
  end
  object Lbl_ShowSearchPath: TLabel
    Left = 8
    Top = 319
    Width = 3
    Height = 13
  end
  object LB_EmptyDir: TListBox
    Left = 176
    Top = 0
    Width = 385
    Height = 321
    ItemHeight = 13
    TabOrder = 0
  end
  object Btn_Scan: TButton
    Left = 42
    Top = 128
    Width = 121
    Height = 25
    Caption = 'Scan'
    TabOrder = 1
    OnClick = Btn_ScanClick
  end
  object Btn_Stop: TButton
    Left = 42
    Top = 200
    Width = 121
    Height = 25
    Caption = 'Stop'
    TabOrder = 2
    OnClick = Btn_StopClick
  end
  object Edit_Path: TEdit
    Left = 42
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 3
  end
end
