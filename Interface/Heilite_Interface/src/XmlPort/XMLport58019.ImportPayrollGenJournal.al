xmlport 58019 "Import Payroll Gen Journal"
{
    // version HEI.04

    // HEI.01 CHG2127493 IBM YADAVP04 27.11.2021 HB2527 Development of Payroll interface in Heilite Base V1.6
    //   # Object created
    // HEI.02 CHG2127493 IBM BHATTA09 27.07.2022 HB2527 Development of Payroll interface in Heilite Base V1.6
    //   # Missed modification added from Classic Old Q Environment
    // HEI.03 CHG2127493 IBM BHATTA09 06.09.2022 HB2527 Development of Payroll interface in Heilite Base V1.6
    //   # Request Page Added
    // HEI.04 CHG2127493 IBM BHATTA09 27.09.2022 HB2527 Development of Payroll interface in Heilite Base V1.6
    //   # Condition added for picking correct Amount

    //Bc Upgrade YADAVM09 Old id is-50162.
    Direction = Import;
    FieldDelimiter = '<>';
    FieldSeparator = '< >';
    //Format = FixedText;//Bc Upgrade YADAVM09 this property can be used with format variable text
    Format = VariableText;//Bc Upgrade YADAVM09 this property can be used with format variable text
    FormatEvaluate = Legacy;
    PreserveWhiteSpace = true;
    TextEncoding = WINDOWS;
    UseRequestPage = true;


    schema
    {
        textelement(Root)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                XmlName = 'Int';
                textelement(A)
                {
                    MinOccurs = Zero;
                    Width = 50;
                }
                textelement(B)
                {
                    MinOccurs = Zero;
                    Width = 15;
                }
                fieldelement(AccountNo; "Gen. Journal Line"."Account No.")
                {
                    MaxOccurs = Unbounded;
                    MinOccurs = Zero;
                    Width = 12;

                    trigger OnAfterAssignField();
                    begin
                        //HEI.02>.
                        if STRPOS("Gen. Journal Line"."Account No.", '3') = 1 then begin
                            "Gen. Journal Line"."Account Type" := "Gen. Journal Line"."Account Type"::Vendor;
                            "Gen. Journal Line"."Account No." := '00' + "Gen. Journal Line"."Account No.";
                        end;
                        //HEI.02<<


                        if "Gen. Journal Line"."Account No." = '' then
                            currXMLport.SKIP;
                        //HEI.02>>
                        if k = 1 then begin
                            "Gen. Journal Line"."Account No." := '';
                            k := 2;
                        end;

                        GLAccount.RESET;
                        GLAccount.SETRANGE("No.", "Gen. Journal Line"."Account No.");
                        GLAccount.SETRANGE(Blocked, true);
                        if GLAccount.FINDFIRST then
                            ERROR('GL account No. %1 is blocked, please unblock %1 first and retry', GLAccount."No.");

                        GLAccountNo := '';
                        GLAccountNo := "Gen. Journal Line"."Account No.";
                        //HEI.02<<
                    end;
                }
                textelement(C)
                {
                    MinOccurs = Zero;
                    Width = 2;
                }
                fieldelement(AmountLCY; "Gen. Journal Line"."Amount (LCY)")
                {
                    FieldValidate = yes;
                    MaxOccurs = Unbounded;
                    MinOccurs = Zero;
                    Width = 14;
                }
                textelement(E)
                {
                    MinOccurs = Zero;
                    Width = 26;
                }
                textelement(D)
                {
                    MinOccurs = Zero;
                    Width = 20;
                }

                trigger OnAfterInitRecord();
                begin
                    //HEI.02>>
                    if PostingDate < CALCDATE('-1Y', TODAY) then
                        ERROR('Posting Date is outside Accounting Period');
                    //HEI.02<<
                end;

                trigger OnBeforeInsertRecord();
                begin

                    //HEI.02>>
                    //IF CheckJournal THEN
                    // BEGIN
                    /*
                   "Gen. Journal Line".SETRANGE("Gen. Journal Line"."Journal Template Name",GeneralTemplateName);
                   "Gen. Journal Line".SETRANGE("Gen. Journal Line"."Journal Batch Name",GeneralBatchName);
                   IF "Gen. Journal Line".FINDFIRST THEN
                     ERROR('The selected journal contains unposted entries');
                   //CheckJournal := FALSE;
                    //END;
                    */
                    //HEI.02<<
                    i += 1;
                    //HEI.02
                    if i = 1 then
                        currXMLport.SKIP;

                    if i >= 2 then
                        //HEI.02<<
                        if (i mod 2 = 0) then
                            currXMLport.SKIP;

                    if "Gen. Journal Line"."Account No." = '' then
                        currXMLport.SKIP;

                    //HEI.02>>
                    GenJournalTemplate.RESET;
                    GenJournalTemplate.SETRANGE(Name, GeneralTemplateName);
                    if GenJournalTemplate.FINDFIRST then;

                    /*
                    GLAccount.RESET;
                    GLAccount.SETRANGE("No.","Gen. Journal Line"."Account No.");
                    GLAccount.SETRANGE(Blocked,TRUE);
                    IF GLAccount.FINDFIRST THEN
                      ERROR('GL account No. is blocked, please unblock %1 first and retry',GLAccount."No.");
                      */
                    //DateText := FORMAT(DATE2DMY(PostingDate,2),2) + '/' + FORMAT(DATE2DMY(PostingDate,3),2);
                    //HEI.02<<
                    DateText := FORMAT(PostingDate, 0, '<Month,2>/<Year>');
                    j += 10000;
                    "Gen. Journal Line".VALIDATE("Gen. Journal Line"."Journal Template Name", GeneralTemplateName);
                    "Gen. Journal Line".VALIDATE("Gen. Journal Line"."Journal Batch Name", GeneralBatchName);
                    "Gen. Journal Line"."Line No." := j;
                    "Gen. Journal Line".Description := 'Payroll Upload ' + DateText;//HEI.02
                    "Gen. Journal Line"."Posting Date" := PostingDate;
                    "Gen. Journal Line"."Source Code" := GenJournalTemplate."Source Code";//HEI.02

                    //HEI.02>.
                    if
                    ("Gen. Journal Line"."Gen. Bus. Posting Group" <> '') or ("Gen. Journal Line"."Gen. Prod. Posting Group" <> '') or
                    ("Gen. Journal Line"."VAT Bus. Posting Group" <> '') or ("Gen. Journal Line"."VAT Prod. Posting Group" <> '')
                    then
                        "Gen. Journal Line".VALIDATE("Gen. Journal Line"."Gen. Posting Type", "Gen. Journal Line"."Gen. Posting Type"::Purchase);
                    /*
                    GenJournalBatch2.RESET;
                    GenJournalBatch2.SETRANGE("Journal Template Name",GeneralTemplateName);
                    GenJournalBatch2.SETRANGE(Name,GeneralBatchName);
                    IF GenJournalBatch2.FINDFIRST THEN
                      BEGIN
                        NoSeriesLines.RESET;
                        NoSeriesLines.SETRANGE("Series Code",GenJournalBatch2."No. Series");
                        NoSeriesLines.SETRANGE(Open,TRUE);
                        IF NoSeriesLines.FINDFIRST THEN
                            IF FirstLine THEN
                              BEGIN
                            LastNoUsed := INCSTR(NoSeriesLines."Last No. Used");
                              FirstLine := FALSE;
                              END
                              ELSE
                               LastNoUsed := INCSTR(LastNoUsed);
                    
                       "Gen. Journal Line"."Document No." := LastNoUsed;
                      END;
                      */
                    //HEI.02<<
                    //DimEntry +=10 ;
                    //HEI.02>>
                    "Gen. Journal Line"."Document No." := 'PAY-' + DateText;

                    SourceCodeDimension.RESET;
                    SourceCodeDimension.SETRANGE("GL Account No.", GLAccountNo);
                    SourceCodeDimension.SETRANGE("Source Code", GenJournalTemplate."Source Code");
                    SourceCodeDimension.SETRANGE("Dimension Code", 'MVMT');
                    if SourceCodeDimension.FINDFIRST then
                    /*
                    BEGIN
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name",GeneralTemplateName);
                    GenJournalLine.SETRANGE("Journal Batch Name",GeneralBatchName);
                    GenJournalLine.SETRANGE("Line No.","Gen. Journal Line"."Line No.");
                    IF GenJournalLine.FINDFIRST THEN
                    */
                    begin
                        DimensionSetEntry2.RESET;
                        DimensionSetEntry2.SETRANGE("Dimension Code", 'MVMT');
                        DimensionSetEntry2.SETRANGE("Dimension Value Code", SourceCodeDimension."Dimension Value Code");
                        if DimensionSetEntry2.FINDFIRST then
                            "Gen. Journal Line"."Dimension Set ID" := DimensionSetEntry2."Dimension Set ID";
                        //END;
                    end;
                    //HEI.02<<



                    if STRPOS(C, 'C') > 0 then
                        "Gen. Journal Line".VALIDATE("Gen. Journal Line"."Amount (LCY)", -("Gen. Journal Line"."Amount (LCY)" / 100))
                    else
                        if STRPOS(C, 'D') > 0 then
                            "Gen. Journal Line".VALIDATE("Gen. Journal Line"."Amount (LCY)", ("Gen. Journal Line"."Amount (LCY)" / 100));
                    D := DELCHR(D, '=', ' ');
                    if (STRLEN(D) > 8) then//HEI.04
                        D := COPYSTR(D, STRLEN(D) - 7, 8);
                    //HEI.02>>
                    DimensionValue.RESET;
                    DimensionValue.SETFILTER("Dimension Code", 'CCC');
                    DimensionValue.SETFILTER(Code, D);
                    if DimensionValue.FINDFIRST then
                        //HEI.02<<
                        "Gen. Journal Line"."Shortcut Dimension 2 Code" := D;
                    /*
                    CLEAR(DimEntry);
                    DimensionSetEntry.INIT;
                    DimensionSetEntry.VALIDATE("Dimension Code", 'CCC');
                    DimensionSetEntry.VALIDATE("Dimension Value Code", D);
                    DimensionSetEntry.INSERT;
                    
                    DimEntry := DimMgt.GetDimensionSetID(DimensionSetEntry);
                    
                    DimensionSetEntry2.RESET;
                    DimensionSetEntry2.SETRANGE("Dimension Code",'CCC');
                    DimensionSetEntry2.SETRANGE("Dimension Value Code",D);
                    IF DimensionSetEntry2.FINDFIRST THEN
                      "Gen. Journal Line"."Dimension Set ID" := DimEntry;
                      */
                    /*
                  BEGIN
                  DimensionSetEntry2."Dimension Set ID" := DimMgt.GetDimensionSetID(DimensionSetEntry2);
                  DimensionSetEntry2.MODIFY;
                  END;
                  "Gen. Journal Line"."Dimension Set ID" := DimensionSetEntry2."Dimension Set ID";
                  */
                    /*
                    
                    */

                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("General Template Name"; GeneralTemplateName)
                {
                    TableRelation = "Gen. Journal Template" WHERE("Payroll FND" = FILTER(true));
                    Caption = 'General Template Name';//Bc Upgrade YADAVM09<<
                    ToolTip = 'Please select General Template Name';//Bc Upgrade YADAVM09<<
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
                field("General Batch Name"; GeneralBatchName)
                {
                    Caption = 'General Batch Name';//Bc Upgrade YADAVM09<<
                    ToolTip = 'Please select General Batch Name';//Bc Upgrade YADAVM09<<
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
                field("Posting Date"; PostingDate)
                {
                    Caption = 'Posting Date';//Bc Upgrade YADAVM09<<
                    ToolTip = 'Please select posting date';//Bc Upgrade YADAVM09<<
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
                field("Force Posting Date"; ForcePostingDate)
                {
                    Caption = 'Force Posting Date';//Bc Upgrade YADAVM09<<
                    ToolTip = 'Please select force posting Date';//Bc Upgrade YADAVM09<<
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
                field("Check Journal"; CheckJournal)
                {
                    Caption = 'CheckJournal';//Bc Upgrade YADAVM09<<
                    ToolTip = 'Please select CheckJournal';//Bc Upgrade YADAVM09<<
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
            }
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort();
    begin
        MESSAGE('Payroll file imported Successfully');//HEI.02
    end;

    trigger OnPreXmlPort();
    begin

        i := 0;
        FirstLine := true;
        DimEntry := 0;
        k := 1;//HEI.02
    end;

    var
        GeneralTemplateName: Code[20];
        GeneralBatchName: Code[20];
        PostingDate: Date;
        ForcePostingDate: Boolean;
        CheckJournal: Boolean;
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalTemplate: Record "Gen. Journal Template";
        i: Integer;
        j: Integer;
        NoSeriesLines: Record "No. Series Line";
        GenJournalBatch2: Record "Gen. Journal Batch";
        LastNoUsed: Code[20];
        NextNo: Code[20];
        FirstLine: Boolean;
        GenJournalLine: Record "Gen. Journal Line";
        DimensionSetEntry: Record "Dimension Set Entry";
        DimEntry: Integer;
        DimMgt: Codeunit DimensionManagement;
        DimensionSetEntry2: Record "Dimension Set Entry";
        Dlength: Integer;
        firstline1: Boolean;
        k: Integer;
        DimensionValue: Record "Dimension Value";
        GLAccount: Record "G/L Account";
        DateText: Text;
        SourceCodeDimension: Record "Source Code Dimension FND";
        GLAccountNo: Code[20];

    procedure RequestPageFilters(GeneralTemplateName1: Code[20]; GeneralBatchName1: Code[20]; PostingDate1: Date; ForcePostingDate1: Boolean; CheckJournal1: Boolean);
    begin
        //HEI.02>>
        GeneralTemplateName := GeneralTemplateName1;
        GeneralBatchName := GeneralBatchName1;
        PostingDate := PostingDate1;
        ForcePostingDate := ForcePostingDate1;
        CheckJournal := CheckJournal1;
        //HEI.02<<
    end;
}

