object FM_Event: TFM_Event
  Left = 0
  Top = 0
  Caption = #20107#20214
  ClientHeight = 273
  ClientWidth = 593
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
  object LB_Event: TListBox
    Left = 0
    Top = 0
    Width = 505
    Height = 273
    ItemHeight = 13
    TabOrder = 0
  end
  object Btn_Start: TButton
    Left = 511
    Top = 104
    Width = 75
    Height = 25
    Caption = #24320#22987
    TabOrder = 1
    OnClick = Btn_StartClick
  end
  object Btn_Stop: TButton
    Left = 511
    Top = 168
    Width = 75
    Height = 25
    Caption = #20013#27490
    TabOrder = 2
    OnClick = Btn_StopClick
  end
end
