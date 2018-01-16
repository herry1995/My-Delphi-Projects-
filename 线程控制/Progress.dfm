object FM_Progress: TFM_Progress
  Left = 0
  Top = 0
  Caption = #36827#24230#26465
  ClientHeight = 148
  ClientWidth = 374
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PB_Progress: TProgressBar
    Left = 8
    Top = 40
    Width = 361
    Height = 9
    TabOrder = 0
  end
  object Btn_Start: TButton
    Left = 48
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = Btn_StartClick
  end
  object Btn_Stop: TBitBtn
    Left = 232
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Stop'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    OnClick = Btn_StopClick
  end
end
