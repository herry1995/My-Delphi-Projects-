object Fm_EmptyFloder: TFm_EmptyFloder
  Left = 0
  Top = 0
  Caption = #25628#32034#31354#25991#20214#22841#24037#20855
  ClientHeight = 481
  ClientWidth = 668
  Color = clBtnFace
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
  object Lbl_ShowPath: TLabel
    Left = 8
    Top = 459
    Width = 3
    Height = 13
  end
  object Lbl_Path: TLabel
    Left = 8
    Top = 19
    Width = 60
    Height = 13
    Caption = #25628#32034#36335#24452#65306
  end
  object Btn_Scan: TButton
    Left = 574
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Scan'
    TabOrder = 0
    OnClick = Btn_ScanClick
  end
  object Btn_Stop: TButton
    Left = 574
    Top = 280
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 1
    OnClick = Btn_StopClick
  end
  object LB_EmptyDir: TListBox
    Left = 0
    Top = 55
    Width = 568
    Height = 398
    ItemHeight = 13
    TabOrder = 2
    OnDblClick = LB_EmptyDirDblClick
  end
  object Edit_Path: TEdit
    Left = 74
    Top = 16
    Width = 494
    Height = 21
    TabOrder = 3
  end
  object Btn_EmptyFileTest: TButton
    Left = 576
    Top = 336
    Width = 75
    Height = 25
    Caption = 'EmptyFileTest'
    TabOrder = 4
    Visible = False
  end
end
