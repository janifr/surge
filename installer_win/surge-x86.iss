; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppPublisher "Surge Synth Team"
#define MyAppPublisherShort "SST"
#define MyAppURL "http://www.surge-synth-team.org/"
#define MyAppName "Surge"
#define MyAppVersion GetEnv('SURGE_VERSION')
#define MyID "650E559A-2F44-44FE-861F-4108AE4BC30F"

#if MyAppVersion == ""
#define MyAppVersion "0.0.0"
#endif

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={#MyID}
AppName="{#MyAppName} {#MyAppVersion}"
AppVersion={#MyAppVersion}
AppVerName={#MyAppPublisherShort} {#MyAppName} (32-bit)
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={cf}\VST3\Surge Synth Team\
DefaultGroupName=Surge
DisableProgramGroupPage=yes
DisableDirPage=yes
DisableReadyPage=no
LicenseFile=..\LICENSE
OutputBaseFilename="{#MyAppName}-{#MyAppVersion}-Setup-x86"
SetupIconFile=surge.ico
UninstallDisplayIcon=surge.ico
UsePreviousAppDir=yes
Compression=lzma
SolidCompression=yes
UninstallFilesDir={commonappdata}\Surge\uninstall\x86\

;; since the fx bank is now a dir not a file we have to force delete the old version in case it was a file
[InstallDelete]
Type: filesandordirs; Name: "{cf}\VST3\SurgeEffectsBank.vst3"
Type: filesandordirs; Name: "{cf}\VST3\Surge Synth Team\SurgeEffectsBank.vst3"
;; also since we're now putting the .vst3 file in SST subfolder, remove old one
Type: files; Name: "{cf}\VST3\Surge.vst3"
;; and since there have been changes in patch subfoldering for factory and 3rd party folders in Surge 1.7, delete them first to ensure clean slate
Type: filesandordirs; Name: "{commonappdata}\Surge\patches_3rdparty"
Type: filesandordirs; Name: "{commonappdata}\Surge\patches_factory"

[Components]
Name: Data; Description: Data Files; Types: full compact custom; Flags: fixed
Name: VST3; Description: Surge VST3 (32-bit); Types: full compact custom; Flags: checkablealone
Name: EffectsVST3; Description: SurgeEffectsBank VST3 (32-bit); Types: full compact custom; Flags: checkablealone

[Files]
Source: ..\resources\data\*; DestDir: {commonappdata}\Surge; Components: Data; Flags: recursesubdirs; Excludes: "*.git";
Source: ..\resources\fonts\Lato-Regular.ttf; DestDir: "{fonts}"; Components: Data; FontInstall: "Lato"; Flags: onlyifdoesntexist uninsneveruninstall

;; these two lines are used by Azure pipelines - if you want to build the installer locally, comment them out!
Source: ..\build\surge_products\Surge_x86.vst3; DestDir: {cf}\VST3\Surge Synth Team\; Components: VST3; Flags: ignoreversion
Source: ..\surge-fx\build\product\SurgeEffectsBank.vst3; DestDir: {cf}\VST3\Surge Synth Team\; Components: EffectsVST3; Flags: ignoreversion skipifsourcedoesntexist recursesubdirs

;; these two lines are used when building the installer locally - uncomment them if you want to do that!
;;Source: ..\build32\surge_products\Surge_x86.vst3; DestDir: {cf}\VST3\Surge Synth Team\; Components: VST3; Flags: ignoreversion
;;Source: ..\surge-fx\build32\product\SurgeEffectsBank.vst3; DestDir: {cf}\VST3\Surge Synth Team\; Components: EffectsVST3; Flags: ignoreversion skipifsourcedoesntexist recursesubdirs

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Icons]
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"

[Run]
Filename: "{cmd}"; \
    WorkingDir: "{cf}\VST3"; \
    Parameters: "/C mklink /D /J  ""{cf}\VST3\Surge Synth Team\SurgeData"" ""{commonappdata}\Surge"""; \
    Flags: runascurrentuser

[Code]
procedure AddToReadyMemo(var Memo: string; Info, NewLine: string);
begin
  if Info <> '' then Memo := Memo + Info + Newline + NewLine;
end;

function UpdateReadyMemo(
  Space, NewLine, MemoUserInfoInfo, MemoDirInfo, MemoTypeInfo, MemoComponentsInfo,
  MemoGroupInfo, MemoTasksInfo: String): String;
begin
  AddToReadyMemo(Result, MemoComponentsInfo, NewLine);

  Result := Result + 'Installation Locations:' + NewLine
  Result := Result + Space + 'Data Files: ' + ExpandConstant( '{commonappdata}' ) + '\Surge' + NewLine
  Result := Result + Space + 'VST3: ' + ExpandConstant( '{cf}' ) + '\VST3\Surge Synth Team' + NewLine
  Result := Result + Space + 'Portable Junction: ' + ExpandConstant( '{cf}' ) + '\VST3\Surge Synth Team\SurgeData' + NewLine
  
end;
