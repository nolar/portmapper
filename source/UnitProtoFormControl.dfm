object ProtoFormControl: TProtoFormControl
  Left = 376
  Top = 211
  Width = 410
  Height = 279
  Caption = '[Port Mapper]'
  Color = clBtnFace
  Constraints.MinHeight = 250
  Constraints.MinWidth = 400
  ParentFont = True
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000CCC00000000000000000000000000000CCC0000000000000000000
    0000000000CCC00000000000000000000000000000CCC0000000000000000000
    0000000000CCC00000000000000000000000000088CCC8880000000000000000
    00000088AAACCCAA8800000000000000000008AAAAACCCAAAA80000000000000
    00008AAAAAAACCCAAAA80000000000000008AAAAAAAACCCAAAAA800000000000
    008AAAAAAAAAACCCAAAAA80000000000008AAAAAAAAAAACCCAAAA80000000000
    08AAAAAAAAA999999CAAAA800000000008AAAAAAAA999ACCCCCCAA8000009999
    99AAAAAAA999AACCCCCCCC80000099999999AAAA999AAACCCACCCCCCCCCC9999
    999999A999AAACCCAAAACCCCCCCC00000899999999AACCCAAAAAAACCCCCC0000
    08AA999999ACCCAAAAAAAA800000000008AAAA9CCCCCCAAAAAAAAA8000000000
    008AAAA999AAAAAAAAAAA80000000000008AAAAA999AAAAAAAAAA80000000000
    0008AAAAA999AAAAAAAA80000000000000008AAAA999AAAAAAA8000000000000
    000008AAAA999AAAAA8000000000000000000088AA999AAA8800000000000000
    0000000088899988000000000000000000000000000999000000000000000000
    0000000000099900000000000000000000000000000999000000000000000000
    000000000009990000000000000000000000000000099900000000000000FFFC
    7FFFFFFC7FFFFFFC7FFFFFFC7FFFFFFC7FFFFFF00FFFFFC003FFFF8001FFFF00
    00FFFE00007FFC00003FFC00003FF800001FF800001F0000001F000000000000
    0000F8000000F800001FF800001FFC00003FFC00003FFE00007FFF0000FFFF80
    01FFFFC003FFFFF00FFFFFFE3FFFFFFE3FFFFFFE3FFFFFFE3FFFFFFE3FFF}
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnHide = FormDeactivate
  DesignSize = (
    402
    250)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelRemoteAddress: TLabel
    Left = 222
    Top = 0
    Width = 160
    Height = 20
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = '[remote ip address and port]'
    FocusControl = EditRemoteHost
    Layout = tlBottom
  end
  object LabelRemotDelimiter: TLabel
    Left = 322
    Top = 20
    Width = 10
    Height = 20
    Alignment = taCenter
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = ':'
    FocusControl = EditRemotePort
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Layout = tlCenter
  end
  object LabelLocalDelimiter: TLabel
    Left = 120
    Top = 20
    Width = 10
    Height = 20
    Alignment = taCenter
    AutoSize = False
    Caption = ':'
    FocusControl = EditLocalPort
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Layout = tlCenter
  end
  object LabelDirector: TLabel
    Left = 180
    Top = 20
    Width = 42
    Height = 20
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = '->'
    FocusControl = EditRemoteHost
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Layout = tlCenter
  end
  object LabelDelay: TLabel
    Left = 20
    Top = 40
    Width = 200
    Height = 20
    AutoSize = False
    Caption = '[delay]'
    FocusControl = Delay
    Layout = tlBottom
  end
  object LabelDelayValue: TLabel
    Left = 220
    Top = 40
    Width = 102
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = '0'
    Transparent = True
    Layout = tlBottom
  end
  object LabelLocalAddress: TLabel
    Left = 20
    Top = 0
    Width = 160
    Height = 20
    AutoSize = False
    Caption = '[local ip address and port]'
    FocusControl = EditLocalHost
    Layout = tlBottom
  end
  object LabelDelayUnit: TLabel
    Left = 332
    Top = 40
    Width = 50
    Height = 20
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = '[msec]'
    Transparent = True
    Layout = tlBottom
  end
  object LabelMaps: TLabel
    Left = 10
    Top = 140
    Width = 382
    Height = 20
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = '[mappings]'
    FocusControl = Maps
    Layout = tlBottom
  end
  object EditLocalPort: TEdit
    Left = 130
    Top = 20
    Width = 50
    Height = 21
    Hint = '[if empty, then dynamic]'
    TabOrder = 1
  end
  object EditRemoteHost: TEdit
    Left = 222
    Top = 20
    Width = 100
    Height = 21
    Hint = '[if empty, then localhost]'
    Anchors = [akTop, akRight]
    TabOrder = 2
  end
  object EditRemotePort: TEdit
    Left = 332
    Top = 20
    Width = 50
    Height = 21
    Hint = '[if empty, then 0]'
    Anchors = [akTop, akRight]
    TabOrder = 3
  end
  object Delay: TTrackBar
    Left = 10
    Top = 60
    Width = 382
    Height = 41
    Hint = '[transmission delay]'
    Anchors = [akLeft, akTop, akRight]
    Max = 100
    PageSize = 5
    Frequency = 5
    TabOrder = 4
    TickMarks = tmBoth
    OnChange = DelayChange
  end
  object ButtonAppend: TButton
    Left = 20
    Top = 110
    Width = 150
    Height = 30
    Action = ActionMapAppend
    TabOrder = 5
  end
  object ButtonRemove: TButton
    Left = 232
    Top = 110
    Width = 150
    Height = 30
    Action = ActionMapRemove
    Anchors = [akTop, akRight]
    TabOrder = 7
  end
  object EditLocalHost: TEdit
    Left = 20
    Top = 20
    Width = 100
    Height = 21
    Hint = '[if empty, then all ips]'
    TabOrder = 0
  end
  object ButtonAbout: TButton
    Left = 180
    Top = 110
    Width = 42
    Height = 30
    Action = ActionAbout
    Anchors = [akLeft, akTop, akRight]
    Caption = '[?]'
    TabOrder = 6
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 230
    Width = 402
    Height = 20
    AutoHint = True
    Panels = <>
    ParentColor = True
    SimplePanel = True
  end
  object Maps: TCheckListBox
    Left = 10
    Top = 160
    Width = 382
    Height = 59
    Hint = '[list of mappings]'
    OnClickCheck = MapsClickCheck
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoComplete = False
    ItemHeight = 13
    Sorted = True
    TabOrder = 8
    OnClick = MapsClick
  end
  object ApplicationEvents: TApplicationEvents
    OnDeactivate = FormDeactivate
    OnHint = ApplicationEventsHint
    Left = 65526
    Top = 90
  end
  object ActionList: TActionList
    Left = 65526
    object ActionAbout: TAction
      Caption = '[about]'
      Hint = '[show information about this program]'
      OnExecute = ActionAboutExecute
    end
    object ActionControlShow: TAction
      Caption = '[show control window]'
      Hint = '[show control window]'
      OnExecute = ActionControlShowExecute
    end
    object ActionControlHide: TAction
      Caption = '[hide control window]'
      Hint = '[hide control window]'
      OnExecute = ActionControlHideExecute
    end
    object ActionMapAppend: TAction
      Caption = '[make mapping]'
      Hint = '[append or update port mapping, described above]'
      OnExecute = ActionMapAppendExecute
    end
    object ActionMapRemove: TAction
      Caption = '[cancel mapping]'
      Hint = '[remove currently selected port mapping]'
      OnExecute = ActionMapRemoveExecute
    end
    object ActionMapToggle: TAction
      Caption = '[toggle mapping]'
      Hint = '[toggle mapping activity ON/OFF]'
      OnExecute = ActionMapToggleExecute
    end
    object ActionLoadSettings: TAction
      Caption = '[load settings]'
      Hint = '[load settings from registry]'
      OnExecute = ActionLoadSettingsExecute
    end
    object ActionSaveSettingsMaps: TAction
      Caption = '[save port mappings]'
      Hint = '[save port mappings and their properties to registry]'
      OnExecute = ActionSaveSettingsMapsExecute
    end
    object ActionSaveSettingsWindow: TAction
      Caption = '[save window settings]'
      Hint = '[save window properties to registry]'
      OnExecute = ActionSaveSettingsWindowExecute
    end
  end
  object TrayPopup: TPopupMenu
    Left = 65526
    Top = 60
    object MenuControl: TMenuItem
      Action = ActionControlShow
      Default = True
    end
    object MenuLine1: TMenuItem
      Caption = '-'
    end
    object MenuAbout: TMenuItem
      Action = ActionAbout
    end
  end
  object TrayIcon: TCoolTrayIcon
    CycleInterval = 0
    Hint = '[port mapper]'
    Icon.Data = {
      0000010001002020100000000000E80200001600000028000000200000004000
      0000010004000000000080020000000000000000000000000000000000000000
      000000008000008000000080800080000000800080008080000080808000C0C0
      C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
      0000000000CCC00000000000000000000000000000CCC0000000000000000000
      0000000000CCC00000000000000000000000000000CCC0000000000000000000
      0000000000CCC00000000000000000000000000088CCC8880000000000000000
      00000088AAACCCAA8800000000000000000008AAAAACCCAAAA80000000000000
      00008AAAAAAACCCAAAA80000000000000008AAAAAAAACCCAAAAA800000000000
      008AAAAAAAAAACCCAAAAA80000000000008AAAAAAAAAAACCCAAAA80000000000
      08AAAAAAAAA999999CAAAA800000000008AAAAAAAA999ACCCCCCAA8000009999
      99AAAAAAA999AACCCCCCCC80000099999999AAAA999AAACCCACCCCCCCCCC9999
      999999A999AAACCCAAAACCCCCCCC00000899999999AACCCAAAAAAACCCCCC0000
      08AA999999ACCCAAAAAAAA800000000008AAAA9CCCCCCAAAAAAAAA8000000000
      008AAAA999AAAAAAAAAAA80000000000008AAAAA999AAAAAAAAAA80000000000
      0008AAAAA999AAAAAAAA80000000000000008AAAA999AAAAAAA8000000000000
      000008AAAA999AAAAA8000000000000000000088AA999AAA8800000000000000
      0000000088899988000000000000000000000000000999000000000000000000
      0000000000099900000000000000000000000000000999000000000000000000
      000000000009990000000000000000000000000000099900000000000000FFFC
      7FFFFFFC7FFFFFFC7FFFFFFC7FFFFFFC7FFFFFF00FFFFFC003FFFF8001FFFF00
      00FFFE00007FFC00003FFC00003FF800001FF800001F0000001F000000000000
      0000F8000000F800001FF800001FFC00003FFC00003FFE00007FFF0000FFFF80
      01FFFFC003FFFFF00FFFFFFE3FFFFFFE3FFFFFFE3FFFFFFE3FFFFFFE3FFF}
    IconVisible = True
    IconIndex = 0
    PopupMenu = TrayPopup
    OnClick = TrayIconClick
    Left = 65526
    Top = 30
  end
end
