unit UnitService;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  IdBaseComponent, IdComponent, IdTCPServer, IdMappedPortTCP, CoolTrayIcon,
  XPMan;

type
  TPortMapper = class(TService)
    XPManifest: TXPManifest;
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  PortMapper: TPortMapper;

implementation

uses UnitFormControl;

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  PortMapper.Controller(CtrlCode);
end;

function TPortMapper.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TPortMapper.ServicePause(Sender: TService; var Paused: Boolean);
var
	Index: Integer;
	Port: TIdMappedPortTCP;
begin
	for Index := 0 to FormControl.Maps.Items.Count-1 do begin
		Port := FormControl.Maps.Items.Objects[Index] as TIdMappedPortTCP;
		Port.Active := false;
	end;
end;

procedure TPortMapper.ServiceContinue(Sender: TService; var Continued: Boolean);
var
	Index: Integer;
	Port: TIdMappedPortTCP;
begin
	for Index := 0 to FormControl.Maps.Items.Count-1 do begin
		Port := FormControl.Maps.Items.Objects[Index] as TIdMappedPortTCP;
		Port.Active := true;
	end;
end;

end.
