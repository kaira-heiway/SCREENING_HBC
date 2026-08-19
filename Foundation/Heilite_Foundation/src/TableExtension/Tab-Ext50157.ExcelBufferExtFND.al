tableextension 50157 ExcelBufferExtFND extends "Excel Buffer"
{
    // version NAVW110.0.00.16177,DITW110.00.11
    // DITW18.00 MSF 27/04/2015 DIT-770 #1363 Fix Upgade tag
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.11 SFI 12/12/2017 NRQ#10509 Sales and purchase gross net prices
    // HEI.02 CHG2020865 MATHEJ01 29.11.2019 Mass Work Order creation file.
    // #Modified Function: ParseCellValue
    // HEI.03 FDD_HB1029 BULIMC01 IBM 07.03.2020#new code added to create multiple sheets in only one workbook
    //     #new function added: OnlyOpenExcel
    //     #new code added to "WriteSheet" function
    //     #new global variables added: NewSheetName, ExcelBookCreated - these local variables from "InsertIntoExcelBook" function have been deleted
    // Hei.04 CHG2127496 IBM SHIVAS05 12/03/2021
    // # Create New function AddSheet.

    fields
    {
        modify("Row No.")
        {
            CaptionML = ENU = 'Row No.', FRA = 'N° ligne totalisation';
        }
        modify(xlRowID)
        {
            CaptionML = ENU = 'xlRowID', FRA = 'xlIDLigne';
        }
        modify("Column No.")
        {
            CaptionML = ENU = 'Column No.', FRA = 'N° colonne';
        }
        modify(xlColID)
        {
            CaptionML = ENU = 'xlColID', FRA = 'xlIDColonne';
        }
        modify("Cell Value as Text")
        {
            CaptionML = ENU = 'Cell Value as Text', FRA = 'Valeur cellule texte';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify(Formula)
        {
            CaptionML = ENU = 'Formula', FRA = 'Formule';
        }
        modify(Bold)
        {
            CaptionML = ENU = 'Bold', FRA = 'Gras';
        }
        modify(Italic)
        {
            CaptionML = ENU = 'Italic', FRA = 'Italique';
        }
        modify(Underline)
        {
            CaptionML = ENU = 'Underline', FRA = 'Souligné';
        }
        modify(NumberFormat)
        {
            CaptionML = ENU = 'NumberFormat', FRA = 'Format numéro';
        }
        modify(Formula2)
        {
            CaptionML = ENU = 'Formula2', FRA = 'Formule2';
        }
        modify(Formula3)
        {
            CaptionML = ENU = 'Formula3', FRA = 'Formule3';
        }
        modify(Formula4)
        {
            CaptionML = ENU = 'Formula4', FRA = 'Formule4';
        }
        modify("Cell Type")
        {
            CaptionML = ENU = 'Cell Type', FRA = 'Type de cellule';
            OptionCaptionML = ENU = 'Number,Text,Date,Time', FRA = 'Nombre,Texte,Date,Heure';
        }
        modify("Double Underline")
        {
            CaptionML = ENU = 'Double Underline', FRA = 'Souligné double';
        }
    }

    procedure OnlyOpenExcel()
    Begin
        //HEI.03<<
        CloseBook();
        OpenExcel();
        // GiveUserControl;  // BC Upgrade Priya >> GiveUserControl base function is removed from Base table.
        //HEI.03>>
    End;


    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

    var
        //DateTimeHelper : DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.DateTime";
        DateTime: DateTime;

    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : @@@="{Locked=""Excel""}";ENU=Excel not found.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : @@@="{Locked=""Excel""}";ENU=Excel not found.;FRA=Programme Excel non trouvé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You must enter a file name.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You must enter a file name.;FRA=Vous devez entrer un nom de fichier.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : @@@="{Locked=""Excel""}";ENU=You must enter an Excel worksheet name.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : @@@="{Locked=""Excel""}";ENU=You must enter an Excel worksheet name.;FRA=Vous devez entrer un nom de feuille Excel.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=The file %1 does not exist.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=The file %1 does not exist.;FRA=Le fichier %1 n'existe pas.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : @@@="{Locked=""Excel""}";ENU=The Excel worksheet %1 does not exist.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : @@@="{Locked=""Excel""}";ENU=The Excel worksheet %1 does not exist.;FRA=La feuille Excel %1 n'existe pas.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : @@@="{Locked=""Excel""}";ENU=Creating Excel worksheet...\\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : @@@="{Locked=""Excel""}";ENU=Creating Excel worksheet...\\;FRA=Création feuille Excel...\\;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "PageTxt(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //PageTxt : ENU=Page;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PageTxt : ENU=Page;FRA=Page;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : @@@="{Locked=""Excel""}";ENU=Reading Excel worksheet...\\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : @@@="{Locked=""Excel""}";ENU=Reading Excel worksheet...\\;FRA=Lecture feuille Excel...\\;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text013(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text013 : ENU=&B;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text013 : ENU=&B;FRA=&B;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text014(Variable 1014)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text014 : ENU=&D;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text014 : ENU=&D;FRA=&D;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text015(Variable 1015)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text015 : ENU=&P;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text015 : ENU=&P;FRA=&P;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text016(Variable 1016)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text016 : ENU=A1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text016 : ENU=A1;FRA=A1;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text017(Variable 1017)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text017 : ENU=SUMIF;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text017 : ENU=SUMIF;FRA=SUMIF;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text018(Variable 1018)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text018 : ENU=#N/A;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text018 : ENU=#N/A;FRA=#N/A;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text019(Variable 1019)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text019 : @@@={Locked} Used to define an Excel range name. You must refer to Excel rules to change this term.;ENU=GLAcc;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text019 : @@@={Locked} Used to define an Excel range name. You must refer to Excel rules to change this term.;ENU=GLAcc;FRA=GLAcc;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text020(Variable 1020)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text020 : @@@={Locked} Used to define an Excel range name. You must refer to Excel rules to change this term.;ENU=Period;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text020 : @@@={Locked} Used to define an Excel range name. You must refer to Excel rules to change this term.;ENU=Period;FRA=Period;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text021(Variable 1021)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text021 : ENU=Budget;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text021 : ENU=Budget;FRA=Budget;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text022(Variable 1041)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text022 : @@@={Locked} Used to define an Excel range name. You must refer to Excel rules to change this term.;ENU=CostAcc;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text022 : @@@={Locked} Used to define an Excel range name. You must refer to Excel rules to change this term.;ENU=CostAcc;FRA=CostAcc;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text023(Variable 1037)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text023 : ENU=Information;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text023 : ENU=Information;FRA=Informations;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text034(Variable 1039)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text034 : @@@="{Split=r'\|\*\..{1,4}\|?'}{Locked=""Excel""}";ENU=Excel Files (*.xls*)|*.xls*|All Files (*.*)|*.*;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text034 : @@@="{Split=r'\|\*\..{1,4}\|?'}{Locked=""Excel""}";ENU=Excel Files (*.xls*)|*.xls*|All Files (*.*)|*.*;FRA=Fichiers Excel (*.xls*)|*.xls*|Tous les fichiers (*.*)|*.*;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text035(Variable 1040)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text035 : ENU=The operation was canceled.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text035 : ENU=The operation was canceled.;FRA=L'opération a été annulée.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text036(Variable 1042)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text036 : @@@="{Locked=""Excel""}";ENU=The Excel workbook does not exist.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text036 : @@@="{Locked=""Excel""}";ENU=The Excel workbook does not exist.;FRA=Le classeur Excel n'existe pas.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text037(Variable 1047)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text037 : @@@="{Locked=""Excel""}";ENU=Could not create the Excel workbook.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text037 : @@@="{Locked=""Excel""}";ENU=Could not create the Excel workbook.;FRA=Impossible de créer le classeur Excel.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text038(Variable 1048)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text038 : ENU=Global variable %1 is not included for test.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text038 : ENU=Global variable %1 is not included for test.;FRA=La variable globale %1 n'est pas incluse à des fins de test.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text039(Variable 1050)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text039 : ENU=Cell type has not been set.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text039 : ENU=Cell type has not been set.;FRA=Le type de cellule n'a pas été défini.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text040(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text040 : @@@="{Locked=""Excel""}";ENU=Export Excel File;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text040 : @@@="{Locked=""Excel""}";ENU=Export Excel File;FRA=Exporter fichier Excel;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SavingDocumentMsg(Variable 1010)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SavingDocumentMsg : ENU=Saving the following document: %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SavingDocumentMsg : ENU=Saving the following document: %1.;FRA=Enregistrement du document suivant : %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ExcelFileExtensionTok(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ExcelFileExtensionTok : @@@={Locked};ENU=.xlsx;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ExcelFileExtensionTok : @@@={Locked};ENU=.xlsx;FRA=.xlsx;
    //Variable type has not been exported.

    var
        ExcelBookCreated: Boolean;
        NewSheetName: Text;
}

