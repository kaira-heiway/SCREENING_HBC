table 58025 "Trintech Interface Setup INT"
{
    // Heilite Navision Old Id - 50125
    // version HEI.03

    // HEI.01 FDD-RTRGAP073 BRD HB142- Trintech connection , IBM.NAIKH01 , 25.02.2019
    //   # Created new table
    // HEI.02 CHG2262655 SAHAL01 05.12.2024 Automatic data export for control purposes
    //   # Created New Fields:  5 - Cadency Base Calendar Code
    //                          6 - JQ Run Date for Working Day-2
    //                          7 - JQ Run Date for Working Day-6
    //                         11 - Last GLBAL Completion Date
    //                         12 - Last GLTRAN Completion Date
    //                         13 - Last SLBAL Completion Date
    //                         17 - Last Date Modified
    //                         18 - Last Time Modified
    //                         19 - Last Modified By User
    //                         20 - Enabled E-Mail Notification
    //                         21 - Max No. of Records for GLBAL
    //                         22 - Max No. of Records for GLTRAN
    //                         23 - Max No. of Records for SLBAL
    //                         27 - E-Mail List 1
    //                         28 - E-Mail List 2
    //                         29 - E-Mail List 3
    //                         30 - E-Mail List 4
    //   # Created New Function - SetLastModifiedDateTime
    //   # Added Code
    // HEI.03 CHG2311415 KAPOOV01 23.07.2025 Automatic data export for control purposes schedule change
    //   # Added Code

    // BC Upgrade PATELP08>>
    // Changed name of table from "Cadency Running Calendar" to "Cadency Running Calendar FND"
    // BC Upgrade PATELP08<<

    Caption = 'Trintech Interface Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; GLBAL; Code[20])
        {
            TableRelation = "Interface Setup INT";
        }
        field(3; GLTRAN; Code[20])
        {
            TableRelation = "Interface Setup INT";
        }
        field(4; SLBAL; Code[20])
        {
            TableRelation = "Interface Setup INT";
        }
        field(5; "Cadency Base Calendar Code"; Code[10])
        {
            Caption = 'Cadency Base Calendar Code';
            Description = 'HEI.02';
            TableRelation = "Base Calendar";

            trigger OnValidate();
            begin
                //HEI.02>>
                if "Cadency Base Calendar Code" <> '' then begin
                    TESTFIELD(GLBAL);
                    TESTFIELD(GLTRAN);
                    TESTFIELD(SLBAL);
                end;
                //HEI.02<<
            end;
        }
        field(6; "JQ Run Date for Working Day-2"; DateFormula)
        {
            Caption = 'JQ Run Date for Working Day-2';
            Description = 'HEI.02';

            trigger OnValidate();
            var
                CadencyRunningCalendarL: Record "Cadency Running Calendar FND";
                CalendarMgtL: Codeunit "Calendar Management";
            begin
                //HEI.02>>
                //HEI.03>>
                //IF (FORMAT("JQ Run Date for Working Day-2") <> '') AND (FORMAT("JQ Run Date for Working Day-2") <> Text001) THEN BEGIN
                if (FORMAT("JQ Run Date for Working Day-2") <> '') then begin
                    //HEI.03<<
                    TESTFIELD("Cadency Base Calendar Code");
                    //ERROR(Text000,Text001,FIELDCAPTION("JQ Run Date for Working Day-2"));  //HEI.03 Commented
                    CadencyRunningCalendar.SETCURRENTKEY("Cadency Base Calendar Code");
                    //HEI.03>>
                    CadencyRunningCalendar.SETFILTER("Working Day-2 (E-Mail Sent)", '%1', false);
                    CadencyRunningCalendar.SETFILTER("Working Day-6 (E-Mail Sent)", '%1', false);
                    CadencyRunningCalendar.SETFILTER("Manual Run Date (E-Mail Sent)", '%1', false);
                    CadencyRunningCalendar.SETFILTER("Addnl. Run Date (E-Mail Sent)", '%1', false);
                    //HEI.03<<
                    CadencyRunningCalendar.SETRANGE("Cadency Base Calendar Code", "Cadency Base Calendar Code");
                    if CadencyRunningCalendar.findset(true) then begin
                        repeat
                            CadencyRunningCalendar.TESTFIELD("Working Day-2 (E-Mail Sent)", false);
                            CadencyRunningCalendar.TESTFIELD("Working Day-6 (E-Mail Sent)", false);
                            CadencyRunningCalendar.TESTFIELD("Manual Run Date (E-Mail Sent)", false);
                            CadencyRunningCalendar.TESTFIELD("Addnl. Run Date (E-Mail Sent)", false);
                            if ((DATE2DMY(CadencyRunningCalendar."Starting Date", 3) >= DATE2DMY(TODAY, 3)) and ((DATE2DMY(CadencyRunningCalendar."Starting Date", 2) >= DATE2DMY(TODAY, 2))) or (DATE2DMY(CadencyRunningCalendar."Starting Date", 3) > DATE2DMY(TODAY, 3))) then begin //HEI.03
                                CadencyRunningCalendar."Cadency Base Calendar Code" := "Cadency Base Calendar Code";
                                // CadencyRunningCalendar."Working Day-2 (Auto Run Date)" := CalendarMgtL.CalcNextWorkingDate("JQ Run Date for Working Day-2",(CadencyRunningCalendar."Starting Date" - 1),"Cadency Base Calendar Code");  // BC Upgrade NANDIS03 - Dependency on Calendar Management CU to be compiled
                                CadencyRunningCalendar.MODIFY(true);
                            end;//HEI.03
                        until CadencyRunningCalendar.NEXT() = 0;
                    end;
                end;
                //HEI.02<<
            end;
        }
        field(7; "JQ Run Date for Working Day-6"; DateFormula)
        {
            Caption = 'JQ Run Date for Working Day-6';
            Description = 'HEI.02';

            trigger OnValidate();
            var
                CadencyRunningCalendarL: Record "Cadency Running Calendar FND";
                CalendarMgtL: Codeunit "Calendar Management";
            begin
                //HEI.02>>
                //HEI.03>>
                //IF (FORMAT("JQ Run Date for Working Day-6") <> '') AND (FORMAT("JQ Run Date for Working Day-6") <> Text002) THEN BEGIN
                if (FORMAT("JQ Run Date for Working Day-2") <> '') then begin
                    //HEI.03<<
                    TESTFIELD("Cadency Base Calendar Code");
                    //ERROR(Text000,Text002,FIELDCAPTION("JQ Run Date for Working Day-6")); //HEI.03 Commented
                    CadencyRunningCalendar.SETCURRENTKEY("Cadency Base Calendar Code");
                    //HEI.03>>
                    CadencyRunningCalendar.SETFILTER("Working Day-2 (E-Mail Sent)", '%1', false);
                    CadencyRunningCalendar.SETFILTER("Working Day-6 (E-Mail Sent)", '%1', false);
                    CadencyRunningCalendar.SETFILTER("Manual Run Date (E-Mail Sent)", '%1', false);
                    CadencyRunningCalendar.SETFILTER("Addnl. Run Date (E-Mail Sent)", '%1', false);
                    //HEI.03<<
                    CadencyRunningCalendar.SETRANGE("Cadency Base Calendar Code", "Cadency Base Calendar Code");
                    if CadencyRunningCalendar.findset(true) then begin
                        repeat
                            CadencyRunningCalendar.TESTFIELD("Working Day-2 (E-Mail Sent)", false);
                            CadencyRunningCalendar.TESTFIELD("Working Day-6 (E-Mail Sent)", false);
                            CadencyRunningCalendar.TESTFIELD("Manual Run Date (E-Mail Sent)", false);
                            CadencyRunningCalendar.TESTFIELD("Addnl. Run Date (E-Mail Sent)", false);
                            if ((DATE2DMY(CadencyRunningCalendar."Starting Date", 3) >= DATE2DMY(TODAY, 3)) and ((DATE2DMY(CadencyRunningCalendar."Starting Date", 2) >= DATE2DMY(TODAY, 2))) or (DATE2DMY(CadencyRunningCalendar."Starting Date", 3) > DATE2DMY(TODAY, 3))) then begin //HEI.03
                                CadencyRunningCalendar."Cadency Base Calendar Code" := "Cadency Base Calendar Code";
                                // CadencyRunningCalendar."Working Day-6 (Auto Run Date)" := CalendarMgtL.CalcNextWorkingDate("JQ Run Date for Working Day-6", (CadencyRunningCalendar."Starting Date" - 1), "Cadency Base Calendar Code");  // BC Upgrade NANDIS03 - Dependency on Calendar Management CU to be compiled
                                CadencyRunningCalendar.MODIFY(true);
                            end;//HEI.03
                        until CadencyRunningCalendar.NEXT() = 0;
                    end;
                end;
                //HEI.02<<
            end;
        }
        field(11; "Last GLBAL Completion Date"; Date)
        {
            Caption = 'Last GLBAL Completion Date';
            Description = 'HEI.02';
            Editable = false;
        }
        field(12; "Last GLTRAN Completion Date"; Date)
        {
            Caption = 'Last GLTRAN Completion Date';
            Description = 'HEI.02';
            Editable = false;
        }
        field(13; "Last SLBAL Completion Date"; Date)
        {
            Caption = 'Last SLBAL Completion Date';
            Description = 'HEI.02';
            Editable = false;
        }
        field(17; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Description = 'HEI.02';
            Editable = false;
        }
        field(18; "Last Time Modified"; Time)
        {
            Caption = 'Last Time Modified';
            Description = 'HEI.02';
            Editable = false;
        }
        field(19; "Last Modified By User"; Code[50])
        {
            Caption = 'Last Modified By User';
            Description = 'HEI.02';
            Editable = false;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup();
            var
                UserMgtL: Codeunit "User Management";
            begin
                //HEI.02>>
                // UserMgtL.LookupUserID("Last Modified By User");  // BC Upgrade NANDIS03 - Dependency on User Management CU to be compiled
                //HEI.02<<
            end;
        }
        field(20; "Enabled E-Mail Notification"; Boolean)
        {
            Caption = 'Enabled E-Mail Notification';
            Description = 'HEI.02';

            trigger OnValidate();
            var
                Err001: Label 'Cadency Running Calender is not created.';
                Err002: Label 'JQ Run Date First Run must have a value in Trintech Interface Setup it cannot be blank.';
                Err003: Label 'JQ Run Date Second Run must have a value in Trintech Interface Setup it cannot be blank.';
            begin
                //HEI.02>>
                //HEI.03>>
                //IF "Enabled E-Mail Notification" THEN
                if "Enabled E-Mail Notification" then begin
                    //HEI.03<<
                    TESTFIELD("E-Mail List 1");
                    //HEI.03>>
                    if FORMAT("JQ Run Date for Working Day-2") = '' then
                        ERROR(Err002);
                    if FORMAT("JQ Run Date for Working Day-6") = '' then
                        ERROR(Err003);
                    CadencyRunningCalendar.SETRANGE("Cadency Base Calendar Code", "Cadency Base Calendar Code");
                    if not CadencyRunningCalendar.FINDFIRST() then
                        ERROR(Err001);
                end;
                //HEI.03<<
                //HEI.02<<
            end;
        }
        field(21; "Max No. of Records for GLBAL"; Integer)
        {
            Caption = 'Max No. of Records for GLBAL';
            Description = 'HEI.02';
        }
        field(22; "Max No. of Records for GLTRAN"; Integer)
        {
            Caption = 'Max No. of Records for GLTRAN';
            Description = 'HEI.02';
        }
        field(23; "Max No. of Records for SLBAL"; Integer)
        {
            Caption = 'Max No. of Records for SLBAL';
            Description = 'HEI.02';
        }
        field(27; "E-Mail List 1"; Text[250])
        {
            Caption = 'E-Mail List 1';
            Description = 'HEI.02';
            ExtendedDatatype = EMail;

            trigger OnValidate();
            begin
                //HEI.02>>
                if "E-Mail List 1" <> xRec."E-Mail List 1" then begin
                    if "Enabled E-Mail Notification" then
                        ERROR(Text003, FIELDCAPTION("Enabled E-Mail Notification"), FIELDCAPTION("E-Mail List 1"));
                end;
                if "E-Mail List 1" <> '' then begin
                    TESTFIELD("Cadency Base Calendar Code");
                    TESTFIELD("JQ Run Date for Working Day-2");
                    TESTFIELD("JQ Run Date for Working Day-6");
                end;
                //HEI.02<<
            end;
        }
        field(28; "E-Mail List 2"; Text[250])
        {
            Caption = 'E-Mail List 2';
            Description = 'HEI.02';
            ExtendedDatatype = EMail;
        }
        field(29; "E-Mail List 3"; Text[250])
        {
            Caption = 'E-Mail List 3';
            Description = 'HEI.02';
            ExtendedDatatype = EMail;
        }
        field(30; "E-Mail List 4"; Text[250])
        {
            Caption = 'E-Mail List 4';
            Description = 'HEI.02';
            ExtendedDatatype = EMail;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        //HEI.02>>
        SetLastModifiedDateTime();
        //HEI.02<<
    end;

    trigger OnModify();
    begin
        //HEI.02>>
        SetLastModifiedDateTime();
        //HEI.02<<
    end;

    var
        Text000: Label 'Please enter this value ''%1'' in this "%2" field.';
        Text001: Label '2D';
        Text002: Label '6D';
        Text003: Label 'Please disable this "%1" field before updating the "%2" value.';
        CadencyRunningCalendar: Record "Cadency Running Calendar FND";

    local procedure SetLastModifiedDateTime();
    var
        DateFilterCalcL: Codeunit "DateFilter-Calc";
        NowL: DateTime;
    begin
        //HEI.02>>
        NowL := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
        "Last Date Modified" := DT2DATE(NowL);
        "Last Time Modified" := DT2TIME(NowL);
        "Last Modified By User" := USERID;
        //HEI.02<<
    end;
}

