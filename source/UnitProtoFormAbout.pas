unit UnitProtoFormAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ShellAPI;

type
  TProtoFormAbout = class(TForm)
    Product: TLabel;
    LabelVersion: TLabel;
    Version: TLabel;
    LabelCompany: TLabel;
    Company: TLabel;
    Logo: TImage;
    OK: TButton;
    EMail: TEdit;
    EPage: TEdit;
    LANGUAGE: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ProtoFormAbout: TProtoFormAbout;

implementation

{$R *.dfm}

procedure TProtoFormAbout.FormCreate(Sender: TObject);
var
	FileName: String;
	Size, Zero, Length: DWORD;
	Buffer, Value: PChar; 
begin
	FileName := Application.ExeName;
	Size := GetFileVersionInfoSize(PChar(FileName), Zero);
	if (Size > 0) then begin
		Buffer := AllocMem(Size);
		GetFileVersionInfo(PChar(FileName), 0, Size, Buffer);

		if (VerQueryValue(Buffer, PChar('StringFileInfo\' + LANGUAGE.CAPTION + '\' + 'FileDescription'), Pointer(Value), Length))
		then Product.Caption := Value else Product.Caption := '???';
		if (VerQueryValue(Buffer, PChar('StringFileInfo\' + LANGUAGE.CAPTION + '\' + 'FileVersion'), Pointer(Value), Length))
		then Version.Caption := Value else Version.Caption := '???';

		if (VerQueryValue(Buffer, PChar('StringFileInfo\' + LANGUAGE.CAPTION + '\' + 'CompanyName'), Pointer(Value), Length))
		then Company.Caption := Value else Company.Caption := '???';

		if (VerQueryValue(Buffer, PChar('StringFileInfo\' + LANGUAGE.CAPTION + '\' + 'E-mail'), Pointer(Value), Length))
		then EMail.Text := Value else EMail.Text := '???';
		if (VerQueryValue(Buffer, PChar('StringFileInfo\' + LANGUAGE.CAPTION + '\' + 'E-page'), Pointer(Value), Length))
		then EPage.Text := Value else EPage.Text := '???';

		FreeMem(Buffer, Size);
	end;
end;

end.


