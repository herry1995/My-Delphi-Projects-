object Fm_Main: TFm_Main
  Left = 0
  Top = 0
  Caption = 'SearchFile'
  ClientHeight = 322
  ClientWidth = 631
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Lbl_Path: TLabel
    Left = 16
    Top = 43
    Width = 26
    Height = 13
    Caption = 'path:'
  end
  object Lbl_FileName: TLabel
    Left = 16
    Top = 99
    Width = 46
    Height = 13
    Caption = 'Filename:'
  end
  object Edit_Path: TEdit
    Left = 73
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Edit_FileName: TEdit
    Left = 73
    Top = 96
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object Btn_Find: TButton
    Left = 48
    Top = 160
    Width = 75
    Height = 25
    Caption = #36882#24402
    TabOrder = 2
    OnClick = Btn_FindClick
  end
  object List_FileList: TListBox
    Left = 208
    Top = 0
    Width = 423
    Height = 321
    ItemHeight = 13
    TabOrder = 3
  end
  object Btn_Queue: TButton
    Left = 48
    Top = 208
    Width = 75
    Height = 25
    Caption = #38431#21015
    TabOrder = 4
    OnClick = btn_queueClick
  end
end
