unit UnitProtoFormControl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPServer, IdMappedPortTCP, IdSocketHandle,
  StdCtrls, ComCtrls, Buttons, CoolTrayIcon, Registry, Menus, ActnList,
  AppEvnts, XPMan, IdUDPBase, IdUDPServer, IdMappedPortUDP, CheckLst;

type
  TProtoFormControl = class(TForm)
    EditLocalPort: TEdit;
    EditRemoteHost: TEdit;
    EditRemotePort: TEdit;
    LabelRemoteAddress: TLabel;
    Delay: TTrackBar;
    LabelRemotDelimiter: TLabel;
    LabelLocalDelimiter: TLabel;
    LabelDirector: TLabel;
    LabelDelay: TLabel;
    LabelDelayValue: TLabel;
    ButtonAppend: TButton;
    ButtonRemove: TButton;
    TrayIcon: TCoolTrayIcon;
    LabelLocalAddress: TLabel;
    EditLocalHost: TEdit;
    LabelDelayUnit: TLabel;
    LabelMaps: TLabel;
    TrayPopup: TPopupMenu;
    MenuControl: TMenuItem;
    MenuAbout: TMenuItem;
    MenuLine1: TMenuItem;
    ButtonAbout: TButton;
    ActionList: TActionList;
    ActionAbout: TAction;
    ActionControlShow: TAction;
    ActionMapAppend: TAction;
    ActionMapRemove: TAction;
    ActionSaveSettingsWindow: TAction;
    ActionSaveSettingsMaps: TAction;
    ActionLoadSettings: TAction;
    ActionControlHide: TAction;
    StatusBar: TStatusBar;
    ApplicationEvents: TApplicationEvents;
    Maps: TCheckListBox;
    ActionMapToggle: TAction;
    procedure DelayChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TrayIconClick(Sender: TObject);
    procedure EventOutboundData(AThread: TIdMappedPortThread);
    procedure MapsClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActionAboutExecute(Sender: TObject);
    procedure ActionControlShowExecute(Sender: TObject);
    procedure ActionControlHideExecute(Sender: TObject);
    procedure ActionMapRemoveExecute(Sender: TObject);
    procedure ActionMapAppendExecute(Sender: TObject);
    procedure ActionLoadSettingsExecute(Sender: TObject);
    procedure ActionSaveSettingsMapsExecute(Sender: TObject);
    procedure ActionSaveSettingsWindowExecute(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure MapsClickCheck(Sender: TObject);
    procedure ActionMapToggleExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function PortString(Port: TIdMappedPortTCP; ShowData: Boolean = true; Appendix: String = ''): String;
    function PortAppend(ALocalHost, ALocalPort, ARemoteHost, ARemotePort: string; Duration: Integer; IsActive: Boolean): Integer;
    function PortRemove(Index: Integer): Integer;
    function PortSelect(Index: integer): Integer;
  end;

var
  ProtoFormControl: TProtoFormControl;

implementation

uses UnitFormAbout;

const
	DelayUnitDuration = 10; {number of msecs in 1 delay unit}
	RegistryKey = '\SOFTWARE\NoLaCom\PortMapper';

{$R *.dfm}

///////////////////////////////////////////////////////////////////////////////
// Functions for encoding and decoding socket parameters
///////////////////////////////////////////////////////////////////////////////
function EncodeLocalHost(Value: String): String;
begin
	if (Value = '0.0.0.0') or (Value = '')
		then Result := '*'
		else Result := Value;
end;
function EncodeLocalPort(Value: Integer): String;
begin
	Result := IntToStr(Value);
end;
function EncodeRemoteHost(Value: String): String;
begin
	Result := Value;
end;
function EncodeRemotePort(Value: Integer): String;
begin
	Result := IntToStr(Value);
end;

function DecodeLocalHost(Value: String): String;
begin
	if (Value = '*') or (Value = '')
		then Result := '0.0.0.0'
		else Result := Trim(Value);
end;
function DecodeLocalPort(Value: String): Integer;
begin
	Result := StrToIntDef(Trim(Value), 0);
end;
function DecodeRemoteHost(Value: String): String;
begin
	if (Value = '*') or (Value = '')
		then Result := 'localhost'
		else Result := Trim(Value);
end;
function DecodeRemotePort(Value: String): Integer;
begin
	Result := StrToIntDef(Trim(Value), 0);
end;

function EqualSockets(HostA: String; PortA: Integer; HostB: String; PortB: Integer): Boolean;
begin
	Result := (PortA = PortB) and ((HostA = '0.0.0.0') or (HostB = '0.0.0.0') or (HostA=HostB));
end;

///////////////////////////////////////////////////////////////////////////////
// Functions to help list of ports processing
///////////////////////////////////////////////////////////////////////////////
function TProtoFormControl.PortString(Port: TIdMappedPortTCP; ShowData: Boolean; Appendix: String): String;
var
	Socket: TIdSocketHandle;
begin
	Result := '';
	Socket := Port.Bindings.Items[0];
	// writing mapping source and destination
	Result := Result + EncodeLocalHost(Socket.IP) + ':' + EncodeLocalPort(Socket.Port);
	Result := Result + ' -> ';
	Result := Result + EncodeRemoteHost(Port.MappedHost) + ':' + EncodeRemotePort(Port.MappedPort);
	// writing additional information
	if (ShowData) then begin
		Result := Result + ' ';
		Result := Result + '(' + IntToStr(Port.Tag) + ' ' + LabelDelayUnit.Caption + ')';
	end;
	if (Appendix <> '') then Result := Result + ' - ' + Appendix;
end;

function TProtoFormControl.PortAppend(ALocalHost, ALocalPort, ARemoteHost, ARemotePort: string; Duration: Integer; IsActive: Boolean): Integer;
var
	LocalHost, RemoteHost: String;
	LocalPort, RemotePort: Integer;
	Index: Integer;
	Port: TIdMappedPortTCP;
	Socket: TIdSocketHandle;
begin
	// extracting and correcting values
	LocalHost := DecodeLocalHost(ALocalHost);
	RemoteHost := DecodeRemoteHost(ARemoteHost);
	LocalPort := DecodeLocalPort(ALocalPort);
	RemotePort := DecodeRemotePort(ARemotePort);
	// removing all mapped ports for the equal socket
	Index := 0;
	while (Index < Maps.Items.Count) do begin
		Port := Maps.Items.Objects[Index] as TIdMappedPortTCP;
		Socket := Port.Bindings.Items[0];
		if (EqualSockets(Socket.IP, Socket.Port, LocalHost, LocalPort))
			then PortRemove(Index)
			else Index := Index + 1;
	end;
	// creating mapped port for requested socket
	Port := TIdMappedPortTCP.Create(self);
	Socket := Port.Bindings.Add;
	Socket.IP   := LocalHost;
	Socket.Port := LocalPort;
	Port.MappedHost := RemoteHost;
	Port.MappedPort := RemotePort;
	Port.Tag := Duration;
	Port.CommandHandlersEnabled := false;
	Port.OnOutboundData := EventOutboundData;
	Port.Active := IsActive;
	// appending new mapped port
	Result := Maps.Items.AddObject(PortString(Port, true), Port);
	Maps.Checked[Result] := Port.Active;
end;

function TProtoFormControl.PortRemove(Index: integer): integer;
var
	Port: TIdMappedPortTCP;
begin
	if (Index >= 0) then begin
		// removing mapped port for requested socket
		Port := Maps.Items.Objects[Index] as TIdMappedPortTCP;
		Port.Active := false;
		Port.Free;
		// deleting item from list
		Maps.Items.Delete(Index);
		Result := Index - 1;
	end else Result := -1;
end;

function TProtoFormControl.PortSelect(Index: integer): integer;
var
	Port: TIdMappedPortTCP;
	Socket: TIdSocketHandle;
begin
	if (Index >= 0) then begin
		Port := Maps.Items.Objects[Index] as TIdMappedPortTCP;
		Socket := Port.Bindings.Items[0];
		EditLocalHost.Text := EncodeLocalHost(Socket.IP);
		EditLocalPort.Text := EncodeLocalPort(Socket.Port);
		EditRemoteHost.Text := EncodeRemoteHost(Port.MappedHost);
		EditRemotePort.Text := EncodeRemotePort(Port.MappedPort);
		Delay.Position := Port.Tag div DelayUnitDuration;
	end else begin
		EditLocalHost.Text := '';
		EditLocalPort.Text := '';
		EditRemoteHost.Text := '';
		EditRemotePort.Text := '';
		Delay.Position := 0;
	end;
	Result := Index;
end;

///////////////////////////////////////////////////////////////////////////////
// Form Event Handlers
///////////////////////////////////////////////////////////////////////////////
procedure TProtoFormControl.FormCreate(Sender: TObject);
begin
	ActionLoadSettings.Execute;
end;

procedure TProtoFormControl.FormDeactivate(Sender: TObject);
begin
	ActionSaveSettingsWindow.Execute;
end;

procedure TProtoFormControl.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action := caNone;
	ActionControlHide.Execute;
end;

procedure TProtoFormControl.TrayIconClick(Sender: TObject);
begin
	ActionControlShow.Execute;
end;

procedure TProtoFormControl.ApplicationEventsHint(Sender: TObject);
begin
	StatusBar.SimpleText := Application.Hint;
end;

procedure TProtoFormControl.DelayChange(Sender: TObject);
begin
	LabelDelayValue.Caption := IntToStr(Delay.Position * DelayUnitDuration);
end;

procedure TProtoFormControl.MapsClick(Sender: TObject);
begin
	PortSelect(Maps.ItemIndex);
end;

procedure TProtoFormControl.MapsClickCheck(Sender: TObject);
begin
	ActionMapToggle.Execute;
end;

procedure TProtoFormControl.EventOutboundData(AThread: TIdMappedPortThread);
begin
	Sleep(AThread.Connection.Server.Tag);
end;

///////////////////////////////////////////////////////////////////////////////
// Actions
///////////////////////////////////////////////////////////////////////////////
procedure TProtoFormControl.ActionAboutExecute(Sender: TObject);
begin
	FormAbout.ShowModal;
end;

procedure TProtoFormControl.ActionControlShowExecute(Sender: TObject);
begin
	TrayIcon.ShowMainForm;
end;

procedure TProtoFormControl.ActionControlHideExecute(Sender: TObject);
begin
	TrayIcon.HideMainForm;
end;

procedure TProtoFormControl.ActionMapAppendExecute(Sender: TObject);
begin
	Maps.ItemIndex := PortAppend(EditLocalHost.Text, EditLocalPort.Text, EditRemoteHost.Text, EditRemotePort.Text, Delay.Position * DelayUnitDuration, true);
	if (Assigned(Maps.OnClick)) then Maps.OnClick(Maps);
	ActionSaveSettingsMaps.Execute;
end;

procedure TProtoFormControl.ActionMapRemoveExecute(Sender: TObject);
begin
	Maps.ItemIndex := PortRemove(Maps.ItemIndex);
	if (Assigned(Maps.OnClick)) then Maps.OnClick(Maps);
	ActionSaveSettingsMaps.Execute;
end;

procedure TProtoFormControl.ActionMapToggleExecute(Sender: TObject);
var
	Port: TIdMappedPortTCP;
begin
	if (Maps.ItemIndex >= 0) then begin
		Port := Maps.Items.Objects[Maps.ItemIndex] as TIdMappedPortTCP;
		Port.Active := Maps.Checked[Maps.ItemIndex];
	end;
	ActionSaveSettingsMaps.Execute;
end;

procedure TProtoFormControl.ActionLoadSettingsExecute(Sender: TObject);
var
	Registry: TRegistry;
	Keys: TStringList;
	Index: Integer;
	LocalHost, RemoteHost: String;
	LocalPort, RemotePort: Integer;
	Duration: Integer;
	IsActive: Boolean;
begin
	PortSelect(-1);
	while (Maps.Items.Count <> 0) do PortRemove(0);

	Keys := TStringList.Create;
	Registry := TRegistry.Create;

	Registry.RootKey := HKEY_LOCAL_MACHINE;
	if (Registry.OpenKey(RegistryKey, false)) then begin
		try Left := Registry.ReadInteger('Left'); except end;
		try Top := Registry.ReadInteger('Top'); except end;
		try Width := Registry.ReadInteger('Width'); except end;
		try Height := Registry.ReadInteger('Height'); except end;
		try WindowState := TWindowState(Registry.ReadInteger('State')); except end;

		Registry.GetKeyNames(Keys);
		Registry.CloseKey;

		for Index := 0 to Keys.Count-1 do begin
			Registry.OpenKey(RegistryKey + '\' + Keys[Index], false);
			try  LocalHost := Registry.ReadString( 'LocalHost'); except  LocalHost := ''; end;
			try RemoteHost := Registry.ReadString('RemoteHost'); except RemoteHost := ''; end;
			try  LocalPort := Registry.ReadInteger( 'LocalPort'); except  LocalPort := 0; end;
			try RemotePort := Registry.ReadInteger('RemotePort'); except RemotePort := 0; end;
			try Duration := Registry.ReadInteger('Duration'); except Duration := 0; end;
			try IsActive := Registry.ReadBool('IsActive'); except IsActive := true; end;
			PortAppend(LocalHost, inttostr(LocalPort), RemoteHost, inttostr(RemotePort), Duration, IsActive);
			Registry.CloseKey;
		end;
	end;

	Registry.Free;
	Keys.Free;
end;

procedure TProtoFormControl.ActionSaveSettingsMapsExecute(Sender: TObject);
var
	Registry: TRegistry;
	Keys: TStringList;
	Index: Integer;
	Port: TIdMappedPortTCP;
	Socket: TIdSocketHandle;
begin
	Keys := TStringList.Create;
	Registry := TRegistry.Create;
	Registry.RootKey := HKEY_LOCAL_MACHINE;
	if (Registry.OpenKey(RegistryKey, true)) then begin
		Registry.GetKeyNames(Keys);
		for Index := 0 to Keys.Count-1 do begin
			Registry.DeleteKey(Keys[Index]);
		end;
		Registry.CloseKey;

		for Index := 0 to Maps.Items.Count-1 do begin
			Port := Maps.Items.Objects[Index] as TIdMappedPortTCP;
			Socket := Port.Bindings.Items[0];
			Registry.OpenKey(RegistryKey + '\' + inttostr(Index), true);
			Registry.WriteString( 'LocalHost', Socket.IP);
			Registry.WriteString('RemoteHost', Port.MappedHost);
			Registry.WriteInteger( 'LocalPort', Socket.Port);
			Registry.WriteInteger('RemotePort', Port.MappedPort);
			Registry.WriteInteger('Duration', Port.Tag);
			Registry.WriteBool('IsActive', Port.Active);
			Registry.CloseKey;
		end;
	end;
	Registry.Free;
	Keys.Free;
end;

procedure TProtoFormControl.ActionSaveSettingsWindowExecute(Sender: TObject);
var
	Registry: TRegistry;
begin
	Registry := TRegistry.Create;
	Registry.RootKey := HKEY_LOCAL_MACHINE;
	if (Registry.OpenKey(RegistryKey, true)) then begin
		Registry.WriteInteger('Left', Left);
		Registry.WriteInteger('Top', Top);
		Registry.WriteInteger('Width', Width);
		Registry.WriteInteger('Height', Height);
		Registry.WriteInteger('State', integer(WindowState));
	end;
	Registry.Free;
end;

///////////////////////////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////////////////////////

end.
