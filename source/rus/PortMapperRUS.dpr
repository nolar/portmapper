program PortMapperRUS;

uses
  SvcMgr,
  UnitService in '..\UnitService.pas' {PortMapper: TService},
  UnitProtoFormControl in '..\UnitProtoFormControl.pas' {ProtoFormControl},
  UnitProtoFormAbout in '..\UnitProtoFormAbout.pas' {ProtoFormAbout},
  UnitFormControl in 'UnitFormControl.pas' {FormControl},
  UnitFormAbout in 'UnitFormAbout.pas' {FormAbout};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Отображатель портов';
  Application.CreateForm(TFormControl, FormControl);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.CreateForm(TPortMapper, PortMapper);
  Application.Run;
end.
