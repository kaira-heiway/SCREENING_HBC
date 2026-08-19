codeunit 51002 "Common Dialog Management CBN"
{
    // version HEI.01

    // HEI:EDD068:1:1 19/11/14 TECTURA.HKH
    //   # CodeUnit Duplicated From 412 in old version
    // HEI.02 CHG2133239 BHANDS01 11-17-2021
    //   # Code Commented and deleted Dotnet variables on OpenFile() and OpenFolder() to resolve compilation error


    trigger OnRun();
    begin
    end;

    var
        Text003: TextConst ENU = 'Text Files (*.txt)|*.txt|All Files (*.*)|*.*', FRA = 'Fichiers texte (*.txt)|*.txt|Tous les fichiers (*.*)|*.*';
        Text004: TextConst ENU = 'Microsoft Excel Files (*.xl*)|*.xl*|All Files (*.*)|*.*', FRA = 'Fichiers Microsoft Excel (*.xl*)|*.xl*|Tous les fichiers (*.*)|*.*';
        Text005: TextConst ENU = 'Word Documents (*.doc)|*.doc|All Files (*.*)|*.*', FRA = 'Documents Word (*.doc)|*.doc|Tous les fichiers (*.*)|*.*';

    procedure OpenFile(WindowTitle: Text[50]; DefaultFileName: Text[250]; DefaultFileType: Option " ",Text,Excel,Word,Custom; FilterString: Text[250]; "Action": Option Open,Save): Text[260];
    begin
        // HEI.02 >>
        /*
        CommonDialogControl.MaxFileSize := 256;      // Adedd By TECTURA-HKH mondatory in RTC Version
        CommonDialogControl.FileName := DefaultFileName;
        CommonDialogControl.DialogTitle := WindowTitle;

       IF DefaultFileType = DefaultFileType::Custom THEN BEGIN
         IF STRPOS(UPPERCASE(FilterString),'.DOC') > 0 THEN
           DefaultFileType := DefaultFileType::Word;
         IF STRPOS(UPPERCASE(FilterString),'.XL') > 0 THEN
           DefaultFileType := DefaultFileType::Excel;
       end;

       CASE DefaultFileType OF
         DefaultFileType::Text:
           CommonDialogControl.Filter := Text003;
         DefaultFileType::Excel:
           CommonDialogControl.Filter := Text004;
         DefaultFileType::Word:
           CommonDialogControl.Filter := Text005;
         DefaultFileType::Custom:
           CommonDialogControl.Filter := FilterString;
       end;
       CommonDialogControl.InitDir := DefaultFileName;
       IF Action = Action::Open THEN
         CommonDialogControl.ShowOpen
       else
         CommonDialogControl.ShowSave;
       EXIT(CommonDialogControl.FileName);
       */
        // HEI.02 <<

    end;

    procedure _fHIT();
    begin
    end;

    procedure OpenFolder(p_txtWindowTitle: Text[50]; p_txtDefaultInitDir: Text[250]): Text[250];
    var
        ltext001: TextConst ENU = 'Select a folder ...', FRB = 'Selectionnez un dossier ...', NLB = 'Map selecteren ...';
    begin
        // HEI.02 >>
        /*
        //<<HIT0001.1 JFE 03/12/2009
        locxCommonDialogControl.FileName := ltext001;
        locxCommonDialogControl.DialogTitle := p_txtWindowTitle;
        locxCommonDialogControl.Flags(4);
        
        locxCommonDialogControl.InitDir := p_txtDefaultInitDir;
        locxCommonDialogControl.ShowSave;
        
        EXIT(GetPathFilename(locxCommonDialogControl.FileName,0));
        //>>HIT0001.1 JFE 03/12/2009
        */
        // HEI.02 <<

    end;

    procedure GetPathFilename(p_fileText: Text[250]; p_optGetOn: Option Path,Filename,Extension,ExtensionDot,FilenameAndExt): Text[250];
    var
        lintPos: Integer;
        lintPos2: Integer;
        ltxtText: Text[250];
    begin
        //<<HIT0001.1 JFE 03/12/2009
        if p_fileText = '' then
            exit;

        ltxtText := StrReverse(p_fileText);

        lintPos := STRLEN(ltxtText) - STRPOS(ltxtText, '\') + 1;
        if lintPos < 2 then
            exit;

        lintPos2 := STRLEN(ltxtText) - STRPOS(ltxtText, '.') + 1;
        if (lintPos2 < lintPos) or ((STRLEN(ltxtText) - lintPos2) > 3) then
            lintPos2 := 0;

        if lintPos2 = 0 then
            lintPos2 := STRLEN(ltxtText) + 1;

        case p_optGetOn of
            p_optGetOn::Path:
                exit(COPYSTR(p_fileText, 1, lintPos));
            p_optGetOn::Filename:
                exit(COPYSTR(p_fileText, lintPos + 1, lintPos2 - lintPos - 1));
            p_optGetOn::Extension:
                exit(COPYSTR(p_fileText, lintPos2 + 1));
            p_optGetOn::ExtensionDot:
                exit(COPYSTR(p_fileText, lintPos2));
            p_optGetOn::FilenameAndExt:
                exit(COPYSTR(p_fileText, lintPos + 1));
        end;
        //>>HIT0001.1 JFE 03/12/2009
    end;

    procedure StrReverse(p_txtText: Text[1024]) rc: Text[1024];
    var
        lintCounter: Integer;
    begin
        //<<HIT0001.1 JFE 03/12/2009
        for lintCounter := STRLEN(p_txtText) downto 1 do
            rc += COPYSTR(p_txtText, lintCounter, 1);
        //>>HIT0001.1 JFE 03/12/2009
    end;
}

