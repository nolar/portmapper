object PortMapper: TPortMapper
  OldCreateOrder = False
  Dependencies = <
    item
      Name = 'Tcpip'
      IsGroup = False
    end>
  DisplayName = 'Port Mapper'
  Interactive = True
  OnContinue = ServiceContinue
  OnPause = ServicePause
  Left = 326
  Top = 240
  Height = 150
  Width = 215
  object XPManifest: TXPManifest
    Left = 20
    Top = 10
  end
end
