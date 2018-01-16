object FM_RepeatFiles: TFM_RepeatFiles
  Left = 0
  Top = 0
  Caption = 'Search RepeatFiles'
  ClientHeight = 464
  ClientWidth = 827
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Lbl_SearchPath: TLabel
    Left = 8
    Top = 12
    Width = 62
    Height = 13
    Caption = 'SearchPath: '
  end
  object Lbl_PathName: TLabel
    Left = 3
    Top = 426
    Width = 26
    Height = 13
    Caption = 'Path:'
  end
  object Lbl_ShowPath: TLabel
    Left = 35
    Top = 426
    Width = 3
    Height = 13
  end
  object Lbl_Progress: TLabel
    Left = 5
    Top = 444
    Width = 69
    Height = 13
    Caption = 'Finished Rate:'
  end
  object Btn_Search: TButton
    Left = 744
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Search Start'
    TabOrder = 0
    OnClick = Btn_SearchClick
  end
  object Btn_SearchStop: TButton
    Left = 744
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Search Stop'
    TabOrder = 1
    OnClick = Btn_SearchStopClick
  end
  object Edit_Path: TEdit
    Left = 88
    Top = 8
    Width = 649
    Height = 21
    TabOrder = 2
  end
  object LV_Files: TListView
    Left = 0
    Top = 35
    Width = 737
    Height = 387
    Columns = <
      item
        Caption = 'NO'
      end
      item
        AutoSize = True
        Caption = 'FileName'
      end
      item
        AutoSize = True
        Caption = 'FileSize'
      end
      item
        AutoSize = True
        Caption = 'FileUrl'
      end>
    TabOrder = 3
    ViewStyle = vsReport
  end
  object PB_Progress: TProgressBar
    Left = 80
    Top = 443
    Width = 657
    Height = 17
    TabOrder = 4
  end
end
