inherited FormControl: TFormControl
  Caption = 'Port Mapper'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited LabelRemoteAddress: TLabel
    Caption = 'Remote IP address and port'
  end
  inherited LabelDelay: TLabel
    Caption = 'Transmission delay'
  end
  inherited LabelLocalAddress: TLabel
    Caption = 'Local IP address and port'
  end
  inherited LabelDelayUnit: TLabel
    Caption = 'msec'
  end
  inherited LabelMaps: TLabel
    Caption = 'Mappings'
  end
  inherited EditLocalPort: TEdit
    Hint = 'If local port is empty, then it will be allocated dynamically'
  end
  inherited EditRemoteHost: TEdit
    Hint = 'If remote address is empty, then local host will be used'
  end
  inherited EditRemotePort: TEdit
    Hint = 'If remote port is empty, then 0 (zero) will be used'
  end
  inherited Delay: TTrackBar
    Hint = 'Delay for data passed through mapping'
  end
  inherited EditLocalHost: TEdit
    Hint = 
      'If local address is empty, then all local IP addresses will be u' +
      'sed'
  end
  inherited ButtonAbout: TButton
    Caption = 'O'
  end
  inherited Maps: TCheckListBox
    Hint = 'List of created mappings'
  end
  inherited ActionList: TActionList
    inherited ActionAbout: TAction
      Caption = 'About this program...'
      Hint = 'Show information about this program and its developers'
    end
    inherited ActionControlShow: TAction
      Caption = 'Control window'
      Hint = 'Show window with mapping controls'
    end
    inherited ActionControlHide: TAction
      Caption = 'Hide control window'
      Hint = 'Hide control window with mapping controls'
    end
    inherited ActionMapAppend: TAction
      Caption = 'Make mapping'
      Hint = 'Append or update mapping, described above'
    end
    inherited ActionMapRemove: TAction
      Caption = 'Drop mapping'
      Hint = 'Remove currently selected mapping'
    end
    inherited ActionMapToggle: TAction
      Caption = 'Toggle mapping'
      Hint = 'Toggle mapping activity ON/OFF'
    end
    inherited ActionLoadSettings: TAction
      Caption = 'Load settings'
      Hint = 'Load settings from registry'
    end
    inherited ActionSaveSettingsMaps: TAction
      Caption = 'Save port mappings'
      Hint = 'Save port mappings and their properties to registry'
    end
    inherited ActionSaveSettingsWindow: TAction
      Caption = 'Save window settings'
      Hint = 'Save window properties to registry'
    end
  end
  inherited TrayIcon: TCoolTrayIcon
    Hint = 'Port Mapper'
  end
end
