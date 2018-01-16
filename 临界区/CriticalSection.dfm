object FM_CriticalSection: TFM_CriticalSection
  Left = 0
  Top = 0
  Caption = #32447#31243#20020#30028#21306
  ClientHeight = 306
  ClientWidth = 581
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
  object List_Screen: TListBox
    Left = 0
    Top = 0
    Width = 492
    Height = 305
    ItemHeight = 13
    TabOrder = 0
  end
  object Btn_Start: TButton
    Left = 498
    Top = 113
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = Btn_StartClick
  end
  object Btn_Stop: TButton
    Left = 498
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 2
    OnClick = Btn_StopClick
  end
end
