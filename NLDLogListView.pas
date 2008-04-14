Unit NLDLogListView;

Interface

Uses
  SysUtils, ComCtrls, Windows, Classes, ExtCtrls, Controls, ImgList, DateUtils, StrUtils;

Type
  TLogFilterOptions = (SoInformation, SoConfirmation, SoWarning, SoError,
    SoTimeEvent, SoCustom, SoEmpty);
  TLogFilterOptionsArray = Set Of TLogFilterOptions;

Const
  DefSmallImageCount = 6;
  AllFilterOptionsHint: Array[0..DefSmallImageCount] Of String =
    ('Information', 'Confirmation', 'Warning', 'Error', 'TimeEvent', 'Custom', '-');
  AllFilterOptions  : TLogFilterOptionsArray =
    [Low(TLogFilterOptions)..High(TLogFilterOptions)];

Type
  TNLDLogListView = Class(TCustomListView)
  Private
    FColumns: TListColumn;
    FDupe: boolean;
    Flogfile: TextFile;
    FInclPrefix: Boolean;
    FOverwriteExtFile: Boolean;
    FInclSuffix: Boolean;
    FDateLog: Boolean;
    FInclSeparator: Boolean;
    FInclDateTime: Boolean;
    FlogID: Boolean;
    FSuffix: String;
    FSeparator: String;
    FPrefix: String;
    FLogFileName: String;
    Fdatetime: Tdatetime;
    FDateTimeFormatStr: String;
    FLogOptie: TLogFilterOptions;
    FOnChange: TNotifyEvent;
    FLogText: TPanel;
    FLogTime: TPanel;
    FLogListItem: TListitem;
    FLogStatusPanel: TStatuspanel;
    FLogFilePath: String;
    FLastLogTime: Tdatetime;
    FLastMessage: String;
    FAantalregels: Integer;
    FOptions_2D: TLogFilterOptionsArray;
    FOptions_2F: TLogFilterOptionsArray;
    FFirstColomn: Boolean;
    FCombineEvents: Boolean;
    FLogOptieImage: Integer;
    FLogIDLong: Boolean;

    Procedure SetDateLog(Const Value: Boolean);
    Procedure SetVersion(Const Value: String);
    Function GetVersion: String;
    Function SetNrtoOption(Const messageId: Integer): TLogFilterOptions;
    Function SetOptiontoNr(Const FilterOptie: TLogFilterOptions): Integer;
    Procedure Doorgeven(Const RegelTijd, RegelText: String);
    Procedure SchrijvennaarLog(Const RegelText: String);
    Procedure AddListview(Const id: Integer; Const Tijd, Regel: String); Overload;
    Procedure AddListview(Const id: TLogFilterOptions; Const Tijd, Regel: String); Overload;
    Procedure SetLogOptie(Const Value: TLogFilterOptions);
    Procedure SetLogOptieImage(Const Value: Integer);
    Procedure WriteToLog(Const MeldingText: String);
    Procedure SetLastMessage(Const Value: String);
    Procedure SetFFirstColomn(Const Value: Boolean);
  Public
    Constructor Create(AOwner: TComponent); Override;
    Destructor Destroy; Override;
    Function CreateLogFile: Boolean;
    Procedure CloseLogFile;
    Procedure WriteIDLE(Const Text: String);
    Procedure WriteLineToLogFile(Const MeldingText: String);
    Procedure WriteToLogFile(Const MeldingText: String); Overload;
    Procedure WriteToLogFile(Const MeldingText: String; Const Id: Integer); Overload;
    Procedure WriteToLogFile(Const MeldingText: String; Const FilterOption: TLogFilterOptions);
      Overload;
    Procedure WriteToDisplay(Const MeldingText: String; Const Id: Integer; Const Tijd: String);
  Published

    { Published declarations }
    InternImageList: TCustomImageList;
    // Listviewproperties
    Property Action;
    Property Align;
    Property AllocBy;
    Property Anchors;
    Property BevelEdges;
    Property BevelInner;
    Property BevelOuter;
    Property BevelKind Default bkNone;
    Property BevelWidth;
    Property BiDiMode;
    Property BorderStyle;
    Property BorderWidth;
    Property Checkboxes;
    Property Color;
    Property Columns;
    Property ColumnClick;
    Property Constraints;
    Property Ctl3D;
    Property Enabled;
    Property Font;
    Property FlatScrollBars;
    Property FullDrag;
    Property GridLines;
    Property HideSelection;
    Property IconOptions;
    Property Items;
    Property LargeImages;
    Property ReadOnly Default False;
    Property ParentBiDiMode;
    Property ParentColor Default False;
    Property ParentFont;
    Property ParentShowHint;
    Property PopupMenu;
    Property ShowColumnHeaders;
    Property ShowHint;
    Property SmallImages;
    Property SortType;
    Property ShowWorkAreas;
    Property TabOrder;
    Property TabStop Default True;
    Property Viewstyle;
    Property Visible;
    Property OnAdvancedCustomDraw;
    Property OnAdvancedCustomDrawItem;
    Property OnAdvancedCustomDrawSubItem;
    Property OnChange;
    Property OnChanging;
    Property OnClick;
    Property OnColumnClick;
    Property OnColumnDragged;
    Property OnColumnRightClick;
    Property OnCompare;
    Property OnContextPopup;
    Property OnCustomDraw;
    Property OnCustomDrawItem;
    Property OnCustomDrawSubItem;
    Property OnData;
    Property OnDataFind;
    Property OnDataHint;
    Property OnDataStateChange;
    Property OnDblClick;
    Property OnDeletion;
    Property OnDrawItem;
    Property OnEdited;
    Property OnEditing;
    Property OnEndDock;
    Property OnEndDrag;
    Property OnEnter;
    Property OnExit;
    Property OnGetImageIndex;
    Property OnGetSubItemImage;
    Property OnDragDrop;
    Property OnDragOver;
    Property OnInfoTip;
    Property OnInsert;
    Property OnKeyDown;
    Property OnKeyPress;
    Property OnKeyUp;
    Property OnMouseDown;
    Property OnMouseMove;
    Property OnMouseUp;
    Property OnResize;
    Property OnSelectItem;
    Property OnStartDock;
    Property OnStartDrag;

    //own added properties

    Property Aantalregels: Integer Read FAantalregels Write FAantalregels;
    // aantal regels, geeft maximaal aantal listview regels, welke in de listview
    // komen, om  bij grote of langdurige logfiles gehugenproblemen te voorkomen
    Property CombineSameEvents: Boolean Read FCombineEvents Write FCombineEvents;
    // dezelfde acties combineren in de listview
    Property DateLog: Boolean Read FDateLog Write SetDateLog;
    // datum in logfilename opnemen
    Property DateTimeFormatStr: String Read FDateTimeFormatStr Write FDateTimeFormatStr;
    // values beschreven in "FormatDateTime Function" in Delphi Help
    Property FirstColomn: Boolean Read FFirstColomn Write SetFFirstcolomn Default False;
    // als je in de eerste colom alleen een image wilt.
    Property InclDateTime: Boolean Read FInclDateTime Write FInclDateTime;
    // datum en/of tijd in logregel opnemen
    Property LastLogTime: Tdatetime Read FLastLogTime Write FLastLogTime;
    // laatste tijd
    Property LastMessage: String Read FLastMessage Write SetLastMessage;
    // laatste melding
    Property LogOptie: TLogFilterOptions Read FLogOptie Write SetLogOptie;
    // welke event zie AllFilterOptionsHint
    Property LogOptieImage: Integer Read FLogOptieImage Write SetLogOptieImage;
    // daar hoort ook een image bij
    Property LogFileName: String Read FLogFileName Write FLogFileName;
    // logfilename
    Property LogFilePath: String Read FLogFilePath Write FLogFilePath;
    // logfilepath
    Property LogID: Boolean Read FlogID Write FlogID;
    // image nummer of naam in de melding wegschrijven
    Property LogIDLong: Boolean Read FLogIDLong Write FLogIDLong;
    // image nummer of naam  wegschrijven
    Property LogText: TPanel Read FLogText Write FLogText;
    Property LogTime: TPanel Read FLogTime Write FLogTime;
    Property LogStatusPanel: TStatuspanel Read FLogStatusPanel Write FLogStatusPanel;
    //  doorgeefluik
    Property Options_toDisplay: TLogFilterOptionsArray Read FOptions_2D Write FOptions_2D;
    // welke meldingen wel of niet getoond worden
    Property Options_toFile: TLogFilterOptionsArray Read FOptions_2F Write FOptions_2F;
    // welke meldingen wel of niet wegeschreven worden
    Property OverwriteExistingFile: Boolean Read FOverwriteExtFile Write FOverwriteExtFile;
    Property InclPrefix: Boolean Read FInclPrefix Write FInclPrefix;
    // iets ervoor zetten
    Property Prefix: String Read FPrefix Write FPrefix;
    Property InclSeparator: Boolean Read FInclSeparator Write FInclSeparator;
    // iets ertussen zetten
    Property Separator: String Read FSeparator Write FSeparator;
    Property InclSuffix: Boolean Read FInclSuffix Write FInclSuffix;
    // iets erachter zetten
    Property Suffix: String Read FSuffix Write FSuffix;
    Property Version: String Read GetVersion Write SetVersion Stored False;
    // versienummer geven
    Property AfterAddItem: TNotifyEvent Read FOnChange Write FOnChange;
    Property BeforeAddItem: TNotifyEvent Read FOnChange Write FOnChange;
    // events voor en na wegschrijven
  End;

Procedure Register;

Implementation

{$R NLDLogListView_images.res}

Uses
  Graphics, Dialogs;

Const
  crlf              = #13#10;
  Major_Version     = 0;
  Minor_Version     = 90;

Procedure Register;
Begin
  RegisterComponents('NLDelphi', [TNLDLogListView]);
End;

{Historylist

18-12-07 first relase
05-01-08 Aantalregels added
12-02-08 Options added
07-03-08 Smallimages added
11-03-08 CombineSameEvents added
23-03-08 First public release
}

{ TNLDLogListView }

Constructor TNLDLogListView.Create(AOwner: TComponent);
//------------------------------------------------------------------------------
// Creeer component, haal de staandaard images uit NLDLogListView_images.res.
// Vul de standaard waarden in.
//------------------------------------------------------------------------------
Var
  i                 : Integer;
  Bitmap            : TBitmap;

Begin
  Inherited Create(AOwner);
  If Not (csDesigning In ComponentState) Then
    Begin                                                                       // imagelist maken
      InternImageList := TCustomImageList.Create(Self);
      Bitmap := TBitmap.Create;
      Try
        For i := 0 To DefSmallImageCount Do // alle image's uit de res halen
          Begin
            Bitmap.LoadFromResourceName(HInstance, Format('LOG%d', [i]));
            InternImageList.AddMasked(Bitmap, clDefault);
          End;
      Finally
        Bitmap.Free;
        SmallImages := InternImageList;
        LargeImages := InternImageList;
      End;
    End;

  FLogFileName := 'LogFile.Txt'; // standaard waarde invullen
  FLogFilePath := '';
  If Not (csDesigning In ComponentState) Then
    FLogFilePath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  FOverwriteExtFile := False;
  FInclDateTime := True;
  FInclPrefix := False;
  FInclSeparator := True;
  FInclSuffix := False;
  FFirstColomn := True;
  FlogID := True;
  FPrefix := '';
  FSeparator := '';
  FSuffix := '';
  FDateTimeFormatStr := 'hh:nn:ss';
  Fdatetime := Now;
  FLastLogTime := 0;
  FLastMessage := '';
  FAantalregels := 25;
  FDateLog := True;
  FOptions_2D := AllFilterOptions;
  FOptions_2F := AllFilterOptions;
  Viewstyle := vsReport;
  Rowselect := True;
  FColumns := Columns.Add;

  Columns.Items[0].Width := 160;
  Columns.Items[0].Caption := 'Actie';                                          // gebeurtenis

  FColumns := Columns.Add;                                                      // tijd
  Columns.Items[1].Width := 55;
  Columns.Items[1].Caption := 'Tijd';

  FColumns := Columns.Add;                                                      // actie
  Columns.Items[2].Width := 500;
End;

Destructor TNLDLogListView.Destroy;
//------------------------------------------------------------------------------
// Opruimen component, ook de Imagelist die eerder gemaakt is
//------------------------------------------------------------------------------
Begin
  If Not (csDesigning In ComponentState) Then
    Begin
      InternImageList.Free;
    End;
  Inherited;
End;

Procedure ShowMessageException;
Begin
  Raise Exception.Create('WokSoft© Exception Afhandeling' + crlf +
    'Grote fout gevonden in het component NLDListview ' + Version + crlf +
    'Waarschuw de programmeur'); // There is a big error !!
  exit;
End;

Function TNLDLogListView.CreateLogFile: Boolean;
//------------------------------------------------------------------------------
// Maak Logfile met opgegeven naam & path
//------------------------------------------------------------------------------

  Function InclPath(FLogFileName: String): String;
  Begin
    result := IncludeTrailingPathDelimiter(FLogFilePath) + FLogFileName;
  End;

Begin
  Try
    result := True;
    If DateLog Then
      Begin
        If CompareDate(Now, Fdatetime) = 1 Then                                 // Now > Datetime
          Fdatetime := Now;
        FLogFileName := 'Log' + FormatDateTime('ddmmyy', Fdatetime) + '.Txt';
        If FLogFilePath <> '' Then
          FLogFileName := InclPath(FLogFileName);
      End
    Else
      If Not (Copy(FLogFileName, 2, 1) = ':') Then // If LogFileName has a Drive letter
        If FLogFilePath = '' Then
          Begin
            FLogFilePath := ExtractFilePath(ParamStr(0));
            FLogFileName := InclPath(FLogFileName);
          End;
    AssignFile(Flogfile, FLogFileName); // Assign the TextFile Variable to the new name...

    If FileExists(FLogFileName) And Not FOverwriteExtFile Then // If FileExists then Append - unless overwrite flag is set.
      Begin
        Append(Flogfile);
        If Items.Count = 1 Then // als er al wat in staat kan je een melding meegeven
          Begin
            AddListview(SoEmpty, '',
              'Logfile bestaat reeds, gebruik een extern programma om de logfile te bekijken');
            FLastMessage := 'extern program';
          End;
      End
    Else
      Rewrite(Flogfile); //  Overschrijven lijst
  Except
    result := False;
    MessageDlg('Fout in het wegschrijven naar het bestand:' + FLogFileName, mtError, [mbOK], 0);
  End;
End;

Procedure TNLDLogListView.CloseLogFile;
//------------------------------------------------------------------------------
// Logfile afsluiten
//------------------------------------------------------------------------------
Begin
  CloseFile(Flogfile);
End;

Function TNLDLogListView.GetVersion: String;
//------------------------------------------------------------------------------
// Huidige Versienummer weergeven
//------------------------------------------------------------------------------
Begin
  result := Format('%d.%02d', [Major_Version, Minor_Version]);
End;

Procedure TNLDLogListView.SetVersion(Const Value: String);
Begin
  //------------------------------------------------------------------------------
  // Routine laten staan, om deze Readonly te maken !!
  //------------------------------------------------------------------------------
End;

Procedure TNLDLogListView.Doorgeven(Const Regeltijd, RegelText: String);
//------------------------------------------------------------------------------
// propeties LogStatusPanel, LogTime & LogText informatie doorgeven.
//------------------------------------------------------------------------------
Begin
  If Assigned(FLogTime) Then // doorgeven aan timepanel
    Begin
      FLogTime.Caption := RegelTijd;
      FLogTime.Refresh;
    End;
  If Assigned(FLogText) Then // doorgeven aan panel
    Begin
      FLogText.Caption := RegelText;
      FLogText.Refresh;
    End;
  If Assigned(FLogStatusPanel) Then // doorgeven aan Statusbarpanel
    Begin
      FLogStatusPanel.Text := ' ' + RegelText;
    End;
End;

Procedure TNLDLogListView.SchrijvennaarLog(Const RegelText: String);
//------------------------------------------------------------------------------
// wegschrijven naar logfile, met eventuele events eromheen.
//------------------------------------------------------------------------------
Begin
  If Assigned(BeforeAddItem) Then                                               //event before
    BeforeAddItem(Self);
  If (Flogoptie In FOptions_2F) Then
    WriteLn(Flogfile, RegelText); // Now write the actual Text to the file
  CloseLogFile;
  If Assigned(AfterAddItem) Then                                                //event after
    AfterAddItem(Self);
End;

Procedure TNLDLogListView.SetDateLog(Const Value: Boolean);
//------------------------------------------------------------------------------
// Datumnotatie in de Logfilename opnemen   'LOG'ddmmyy'.txt'
//------------------------------------------------------------------------------
Begin
  FDateLog := Value;
  If Not Value Then // als er geen waarde is dan standaard 'C'
    FDateTimeFormatStr := 'c';
End;

Procedure TNLDLogListView.WriteLineToLogFile(Const MeldingText: String);
//------------------------------------------------------------------------------
// Dupestringoptie, handig om een scheiding aan te geven in de logfile
//------------------------------------------------------------------------------
Begin
  WriteToLogFile(DupeString(MeldingText, 60)); // line with 60 chars
End;

Procedure TNLDLogListView.WriteToLogFile(Const MeldingText: String);
//------------------------------------------------------------------------------
// Schrijf naar de logfile, zonder extra's
//------------------------------------------------------------------------------
Begin
  LogOptie := SoEmpty;
  WriteToLog(MeldingText);
End;

Procedure TNLDLogListView.WriteToLogFile(Const MeldingText: String; Const Id: Integer);
//------------------------------------------------------------------------------
// Schrijf naar de logfile, met het imagenummer als toevoeging
//------------------------------------------------------------------------------
Begin
  LogOptieImage := Id;
  WriteToLog(MeldingText);
End;

Procedure TNLDLogListView.WriteToLogFile(Const MeldingText: String; Const FilterOption:
  TLogFilterOptions);
//------------------------------------------------------------------------------
// Schrijf naar de logfile, met de filteroptie als toevoeging
//------------------------------------------------------------------------------
Begin
  LogOptie := FilterOption;
  WriteToLog(MeldingText);
End;



Procedure TNLDLogListView.WriteToLog(Const MeldingText: String);
//------------------------------------------------------------------------------
// Het combineren van de gegevens om een logregel samen te stellen
//------------------------------------------------------------------------------
Var
  LogHeader         : String;
  LogFooter         : String;
  LogIDHeader       : String;

  Procedure AddPrefix;
  Begin
    If InclPrefix Then                                                          // Prefix
      LogHeader := Prefix + LogHeader;
  End;

  Procedure AddSuffix;
  Begin
    If InclSuffix Then                                                          // Suffix
      LogFooter := LogFooter + Suffix;
  End;

  Procedure AddSeparator;
  Begin
    If InclSeparator Then                                                       // InclSeperator
      Begin
        If Separator = '' Then
          Separator := ' ';
        If LogHeader <> '' Then
          LogHeader := LogHeader + Separator;
        If FLogID Then
          LogHeader := LogHeader + LogIDHeader + Separator;
        If LogFooter <> '' Then
          LogFooter := Separator + LogFooter;
      End;
  End;

  Function incl_ID: String;

    Function WithHooks(Const value: String): String;
    Var
      Temp          : String;
    Begin
      temp := '[' + Value;
      While length(temp) <= 12 Do
        Begin
          temp := temp + ' ';
        End;
      result := temp + ']';
    End;

  Begin
    LogIDHeader := '';
    If FLogID Then
      Begin
        If FLogIDLong Then
          result := WithHooks(AllFilterOptionsHint[FLogOptieImage])
        Else
          result := '[' + inttostr(FLogOptieImage) + ']';
      End;
  End;

  Function incl_DT: String;
  Begin
    If DateTimeFormatStr = '' Then // if no format supplied, default it to "c"
      DateTimeFormatStr := 'c';
    result := FormatDateTime(DateTimeFormatStr, Now);
  End;

Begin                                                                           // main
  Try
    If CreateLogFile Then // First Create/Open the LogFile
      Begin
        LogFooter := '';
        LogHeader := '';
        LastMessage := MeldingText;
        LogIDHeader := Incl_ID;
        If InclDateTime Then                                                    // add timestamp
          LogHeader := Incl_DT;
        AddListview(FLogOptieImage, LogHeader, MeldingText);
        AddPrefix;
        AddSuffix;
        AddSeparator;
        SchrijvennaarLog(LogHeader + MeldingText + LogFooter); // Now write the actual Text to the file
      End;
  Except
    ShowMessageException;
  End;
End;

Procedure TNLDLogListView.WriteToDisplay(Const MeldingText: String; Const Id: Integer; Const Tijd: String);
//------------------------------------------------------------------------------
// Een logregel alleen naar de listview sturen
//------------------------------------------------------------------------------
Begin
  Try
    LogOptie := SetNrtoOption(Id);
    AddListview(Id, Tijd, MeldingText);
  Except
    ShowMessageException;
  End;
End;

Procedure TNLDLogListView.AddListview(Const id: Integer; Const Tijd, Regel: String);

Begin
  LogOptieImage := id;
  AddListview(FLogOptie, Tijd, Regel);
End;

Procedure TNLDLogListView.AddListview(Const id: TLogFilterOptions; Const Tijd, Regel: String);
//------------------------------------------------------------------------------
// Het combineren van de gegevens om een logregel samen te stellen
//------------------------------------------------------------------------------
Begin
  LogOptie := id;
  If (id In FOptions_2D) Then
    Try
      Begin
        Items.BeginUpdate;
        While Items.Count > FAantalregels Do
          Items.Delete(0);
        If FCombineEvents Then
          Begin
            If Not FDupe Then
              FLogListItem := Items.Add;
          End
        Else
          FLogListItem := Items.Add;
        FLogListItem.ImageIndex := FlogOptieImage;
        If FirstColomn Then
          FLogListItem.Caption := Regel;
        FLogListItem.Subitems.Add(Tijd);
        If Not FirstColomn Then
          FLogListItem.Subitems.Add(Regel);
      End;
    Finally
      Items.EndUpdate;
      Doorgeven(Tijd, Regel);
    End;
End;

Procedure TNLDLogListView.WriteIDLE(Const Text: String);
//------------------------------------------------------------------------------
// Schrijven van een logregel, waarin ook de IDLE tijd staat
//------------------------------------------------------------------------------
Var
  dt                : Tdatetime;
  Th, Tm, Ts, Te    : word;
Begin
  LastMessage := Text;
  If LastLogTime = 0 Then
    Begin
      LastLogTime := Now;
      WriteToLogFile(Text, SoTimeEvent);
    End
  Else
    If FDupe Then
      Begin
        Te := MilliSecondsBetween(Now, LastLogTime);
        Ts := Te Div 1000;
        Te := Te Mod 1000;
        Tm := Ts Div 60;
        Ts := Ts Mod 60;
        Th := Tm Div 60;
        Tm := Tm Mod 60;
        dt := EncodeTime(Th, Tm, Ts, Te);
        AddListview(SoTimeEvent, '', Text + ' ( ' + FormatDateTime(DateTimeFormatStr, dt)
          + ' Time Idle)');
      End
    Else
      Begin
        LastLogTime := 0;
        WriteToLogFile(Text, SoTimeEvent);
      End;
End;

//--------------------------------------------------------------------
// Interne routines
//--------------------------------------------------------------------

Function TNLDLogListView.SetNrtoOption(Const messageId: Integer): TLogFilterOptions;
Begin
  Case messageId Of
    0: result := SoInformation;
    1: result := SoConfirmation;
    2: result := SoWarning;
    3: result := SoError;
    4: result := SoTimeEvent;
    5: result := SoCustom;
  Else
    result := SoEmpty;
  End;
End;

Function TNLDLogListView.SetOptiontoNr(Const FilterOptie: TLogFilterOptions): Integer;
Begin
  Case FilterOptie Of
    SoInformation: result := 0;
    SoConfirmation: result := 1;
    SoWarning: result := 2;
    SoError: result := 3;
    SoTimeEvent: result := 4;
    SoCustom: result := 5;
    SoEmpty: result := 6;
  Else
    result := 6;
  End;
End;

Procedure TNLDLogListView.SetLogOptie(Const Value: TLogFilterOptions);
Begin
  FLogOptie := Value;
  FLogOptieImage := SetOptiontoNr(Value);
End;

Procedure TNLDLogListView.SetLogOptieImage(Const Value: Integer);
Begin
  FLogOptieImage := Value;
  FLogOptie := SetNrtoOption(Value);
End;

Procedure TNLDLogListView.SetLastMessage(Const Value: String);
Begin
  FDupe := (Value = LastMessage);
  If Value <> FLastMessage Then
    Begin
      FLastMessage := Value;
    End;
End;

Procedure TNLDLogListView.SetFFirstColomn(Const Value: Boolean);
Begin
  FFirstColomn := Value;
  FDupe := False;
End;

End.

