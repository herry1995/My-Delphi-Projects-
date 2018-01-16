object FM_Mutex: TFM_Mutex
  Left = 0
  Top = 0
  Caption = 'Mutex'
  ClientHeight = 322
  ClientWidth = 550
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
  object LB_Mutex: TListBox
    Left = 0
    Top = 0
    Width = 433
    Height = 321
    ItemHeight = 13
    TabOrder = 0
  end
  object Btn_Start: TButton
    Left = 464
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = Btn_StartClick
  end
  object Btn_Stop: TButton
    Left = 464
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 2
    OnClick = Btn_StopClick
  end
end
