unit UnitFormControl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UnitProtoFormControl, CoolTrayIcon, Menus, ActnList, AppEvnts,
  StdCtrls, CheckLst, ComCtrls;

type
  TFormControl = class(TProtoFormControl)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormControl: TFormControl;

implementation

{$R *.dfm}

end.
