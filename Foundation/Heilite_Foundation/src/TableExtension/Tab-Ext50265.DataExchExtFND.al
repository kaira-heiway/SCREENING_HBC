tableextension 50265 DataExchExtFND extends "Data Exch."
{
    // version NAVW110.0,HEI.01
    // HEI.01 FDD-GAPID001 IBM LAZARE02 04.08.2017 # New fields Parent Data Exch. No., File Encoding
    // HEI.02 CHG2020184 IBM POENAB02 26.06.2019 Bank Connectivity interface
    //   # New functions:
    //     # ImportToDataExchCAM053
    //     # ReplaceString
    // HEI.03 CHG2112261 IBM SAXENA03 20.05.2021
    //   # Interface Logging processing Execution Time and Webservices Response Times
    //   # Added below fields:50002
    
    // BC UPGRADE PATELP08 >>
    // Changed table ext name from "DataExchExt" to "DataExchExtFND"
    // Changed fields name from "Parent Data Exch. No." to "Parent Data Exch. No. FND", "File Encoding" to "File Encoding FND", "Interface Entry Header No." to "Interface Entry Header No. FND"
    // BC UPGRADE PATELP08 <<

    fields
    {
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("File Name")
        {
            CaptionML = ENU = 'File Name', FRA = 'Nom du fichier';
        }
        modify("File Content")
        {
            CaptionML = ENU = 'File Content', FRA = 'Contenu fichier';
        }
        modify("Data Exch. Def Code")
        {
            CaptionML = ENU = 'Data Exch. Def Code', FRA = 'Code déf. échange données';
        }
        modify("Data Exch. Line Def Code")
        {

            //Unsupported feature: Change TableRelation on ""Data Exch. Line Def Code"(Field 5)". Please convert manually.

            CaptionML = ENU = 'Data Exch. Line Def Code', FRA = 'Code déf. ligne échange données';
        }
        modify("Table Filters")
        {
            CaptionML = ENU = 'Table Filters', FRA = 'Filtres de table';
        }
        modify("Incoming Entry No.")
        {
            CaptionML = ENU = 'Incoming Entry No.', FRA = 'N° document entrant';
        }
        modify("Related Record")
        {
            CaptionML = ENU = 'Related Record', FRA = 'Enregistrement associé';
        }
        field(50000; "Parent Data Exch. No. FND"; Integer)
        {
            Caption = 'Parent Data Exch. No.';
            Description = 'HEI.01';
            NotBlank = true;
            TableRelation = "Data Exch.";
        }
        field(50001; "File Encoding FND"; Text[30])
        {
            Caption = 'File Encoding';
            Description = 'HEI.01';
        }
        field(50002; "Interface Entry Header No. FND"; Integer)
        {
            Caption = 'Interface Entry Header No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "ProgressWindowMsg(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ProgressWindowMsg : ENU=Please wait while the operation is being completed.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ProgressWindowMsg : ENU=Please wait while the operation is being completed.;FRA=Veuillez patienter lors de l'exécution de l'opération.;
    //Variable type has not been exported.

    // BC Upgrade NANDIS03 >>
    procedure ImportToDataExchCAM053(DataExchDef: Record "Data Exch. Def"; BankAccount: Record "Bank Account"): Boolean
    var
        Source: InStream;
    begin
        //HEI.02>>
        IF NOT "File Content".HASVALUE THEN
            IF NOT ImportFileContent(DataExchDef) THEN
                EXIT(FALSE);

        IF DataExchDef."Reading/Writing Codeunit" > 0 THEN
            CODEUNIT.RUN(DataExchDef."Reading/Writing Codeunit", Rec)
        ELSE BEGIN
            DataExchDef.TESTFIELD("Reading/Writing XMLport");
            XMLPORT.IMPORT(DataExchDef."Reading/Writing XMLport", Source, Rec);
        END;

        EXIT(TRUE);
        //HEI.02<<
    end;

    local procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text): Text
    var
        NewString: Text;
    begin
        //HEI.02>>
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;

        EXIT(NewString);
        //HEI.02<<  
    end;
    // BC Upgrade NANDIS03 <<
}

