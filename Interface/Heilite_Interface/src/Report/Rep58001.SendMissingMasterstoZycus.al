report 58001 "Send Missing Masters to Zycus"
{
    // Heilite Navision Old Id - 50060

    // version HEI.04

    // HEI.01 CHG2210794 SAHAL01 15.10.2024 Zycus - BASE HL Integration Master Dimension
    //   # Created New Report: 50060 - Send Missing Masters to Zycus
    //   # Created New Functions - GetZycusInterfaceSetup_Zycus
    //                           - ValidateInterfaceSetup_Zycus
    //                           - GetLocalCurrentDateTime_Zycus
    //                           - SendCCCDimCreateOrUpdate_Zycus
    //                           - SendWBNDimCreateOrUpdate_Zycus
    //                           - GetGeneralInterfaceSetup_Zycus
    //   # Added Code
    //   # Added Code to incorporate the logic for sending Dimension Value Code with accepted Special Character in WBN Interface.
    // HEI.02 CHG2210794 MAJUMS03 08.03.2024 Zycus - BASE HL Integration Master Vendor and GL Account. (*MSR)
    //   # Created New Functions - SendVendorCreateOrUpdate_Zycus
    //                           - SendGLAccCreateOrUpdate_Zycus
    //                           - CheckForValidGLAcc
    //                           - CreationOfValidGLAcc
    //   # Two new DataItem Vendor and G/L Account are added.
    //   # New Option Value Vendor and GLAccount are added against Global Variable SendInfoFor.
    //   # Code added
    // HEI.03 CHG2210794 MAJUMS03 13.05.2024 Zycus - BASE HL Integration - Vendor GL Account Development Rework.
    //   # Code added.
    // HEI.04 CHG2210794 SAHAL01 25.10.2024 Zycus - BASE HL Integration Master Dimension
    //   # Filter Added for Vendor
    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea property in report and requestpage fields.
    // BC Upgrade BHARDA11 <<
    Caption = 'Send Missing Masters to Zycus';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(DimensionCCC; "Dimension Value")
        {
            DataItemTableView = SORTING("Dimension Code", Code) ORDER(Ascending) WHERE("Dimension Code" = CONST('CCC'), Code = FILTER(<> ''));
            RequestFilterHeading = 'Dimension CCC';

            trigger OnAfterGetRecord();
            begin
                //HEI.01>>
                TESTFIELD("Dimension Code", ZycusInterfaceSetup."Zycus CCC Object Type");
                TESTFIELD(Code);
                if LineCount = MaxNoOfRecord then
                    CLEAR(LineCount);
                LineCount += 1;
                TotalLineCount += 1;
                SendCCCDimCreateOrUpdate_Zycus("Dimension Code", Code, ZycusInterfaceSetup."Zycus CCC Interface");
                //HEI.01<<
            end;

            trigger OnPreDataItem();
            var
                DimensionL: Record Dimension;
            begin
                //HEI.01>>
                if not (SendInfoFor in [SendInfoFor::CCC]) then
                    CurrReport.BREAK();
                if ZycusInterfaceSetup."Activate CCC Interface" then begin
                    ZycusInterfaceSetup.TESTFIELD("Zycus CCC Object Type");
                    DimensionL.GET(ZycusInterfaceSetup."Zycus CCC Object Type");
                    ZycusInterfaceSetup.TESTFIELD("Zycus CCC Interface");
                    ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus CCC Interface");
                    if DimValueCode = '' then
                        ERROR(Text003, FORMAT(SendInfoFor::CCC));
                    if DimensionCCC.GETFILTER(Code) <> '' then
                        ERROR(Text004, FORMAT(SendInfoFor::CCC));
                    if DimensionCONCAT.GETFILTER(Code) <> '' then
                        ERROR(Text004, FORMAT(SendInfoFor::CONCAT));
                    SETFILTER(Code, DimValueCode);
                end;
                if MaxNoOfRecord <> 0 then
                    LoopCount := ROUND((COUNT / MaxNoOfRecord), 1, '>')
                else
                    LoopCount := 1;
                //HEI.01<<
            end;
        }
        dataitem(DimensionCONCAT; "Dimension Value")
        {
            DataItemTableView = SORTING("Dimension Code", Code) ORDER(Ascending) WHERE("Dimension Code" = CONST('CONCAT'), Code = FILTER(<> ''));
            RequestFilterHeading = 'Dimension CONCAT';

            trigger OnAfterGetRecord();
            begin
                //HEI.01>>
                TESTFIELD("Dimension Code", ZycusInterfaceSetup."Zycus Project Object Type");
                TESTFIELD(Code);
                if LineCount = MaxNoOfRecord then
                    CLEAR(LineCount);
                LineCount += 1;
                TotalLineCount += 1;
                SendWBNDimCreateOrUpdate_Zycus("Dimension Code", Code, ZycusInterfaceSetup."Zycus WBN Interface");
                //HEI.01<<
            end;

            trigger OnPreDataItem();
            var
                DimensionL: Record Dimension;
            begin
                //HEI.01>>
                if not (SendInfoFor in [SendInfoFor::CONCAT]) then
                    CurrReport.BREAK();
                if ZycusInterfaceSetup."Activate Project Interface" then begin
                    ZycusInterfaceSetup.TESTFIELD("Zycus Project Object Type");
                    DimensionL.GET(ZycusInterfaceSetup."Zycus Project Object Type");
                    ZycusInterfaceSetup.TESTFIELD("Zycus WBN Interface");
                    ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus WBN Interface");
                    if DimValueCode = '' then
                        ERROR(Text003, FORMAT(SendInfoFor::CONCAT));
                    if DimensionCONCAT.GETFILTER(Code) <> '' then
                        ERROR(Text004, FORMAT(SendInfoFor::CONCAT));
                    if DimensionCCC.GETFILTER(Code) <> '' then
                        ERROR(Text004, FORMAT(SendInfoFor::CCC));
                    SETFILTER(Code, DimValueCode);
                end;
                if MaxNoOfRecord <> 0 then
                    LoopCount := ROUND((COUNT / MaxNoOfRecord), 1, '>')
                else
                    LoopCount := 1;
                //HEI.01<<
            end;
        }
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = WHERE("Global Delete FND" = FILTER(false));
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord();
            begin
                //HEI.02>>
                TempVendRec.INIT();
                TempVendRec := Vendor;
                TempVendRec.INSERT();
                //HEI.02<<
            end;

            trigger OnPostDataItem();
            begin
                //HEI.02>>
                if TempVendRec.COUNT > 0 then begin
                    SendVendorCreateOrUpdate_Zycus(ZycusInterfaceSetup."Zycus Vendor Interface Code");
                end;
                //HEI.02<<
            end;

            trigger OnPreDataItem();
            begin
                //HEI.02>>
                if not (SendInfoFor in [SendInfoFor::Vendor]) then
                    CurrReport.BREAK();
                if ZycusInterfaceSetup."Activate Vendor Interface" then begin
                    ZycusInterfaceSetup.TESTFIELD("Zycus Vendor Interface Code");
                    ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus Vendor Interface Code");
                    ZycusInterfaceSetup.TESTFIELD("Vendor Account Group Filter");
                    ZycusInterfaceSetup.TESTFIELD("Max. Vendor Per Interface");
                end;
                Vendor.SETFILTER(Vendor."Vendor Type FND", ZycusInterfaceSetup."Vendor Account Group Filter");
                CLEAR(TempVendRec);
                //HEI.02<<
            end;
        }
        dataitem("G/L Account"; "G/L Account")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord();
            begin
                //HEI.02>>
                CreationOfValidGLAcc();
                //HEI.02<<
            end;

            trigger OnPostDataItem();
            begin
                //HEI.02>>
                if TempGLAccRec.COUNT > 0 then begin
                    SendGLAccCreateOrUpdate_Zycus(ZycusInterfaceSetup."Zycus Account Interface Code");
                end;
                //HEI.02<<
            end;

            trigger OnPreDataItem();
            begin
                //HEI.02>>
                if not (SendInfoFor in [SendInfoFor::GLAccount]) then
                    CurrReport.BREAK();
                //HEI.02<<
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("Send Info For"; SendInfoFor)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the SendInfoFor field.';
                        trigger OnValidate();
                        begin
                            //HEI.01>>
                            CLEAR(DimValueCode);
                            //HEI.01<<
                        end;
                    }
                    field("Dim. Value Code"; DimValueCode)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the DimValueCode field.';
                        trigger OnLookup(var Text: Text): Boolean;
                        var
                            DimensionValueL: Record "Dimension Value";
                            DimensionValueListL: Page "Dimension Value List";
                        begin
                            //HEI.01>>
                            case SendInfoFor of
                                SendInfoFor::" ":
                                    ERROR(Text002);
                                SendInfoFor::CCC:
                                    begin
                                        DimensionValueL.SETRANGE("Dimension Code", FORMAT(SendInfoFor::CCC));
                                        DimensionValueL.SETFILTER(Code, '<>%1', '');
                                        DimensionValueListL.LOOKUPMODE(true);
                                        DimensionValueListL.SETTABLEVIEW(DimensionValueL);
                                        if not (DimensionValueListL.RUNMODAL() = ACTION::LookupOK) then
                                            exit(false)
                                        else begin
                                            DimensionValueListL.GETRECORD(DimensionValueL);
                                            DimValueCode := DimensionValueL.Code;
                                        end;
                                    end;
                                SendInfoFor::CONCAT:
                                    begin
                                        DimensionValueL.SETRANGE("Dimension Code", FORMAT(SendInfoFor::CONCAT));
                                        DimensionValueL.SETFILTER(Code, '<>%1', '');
                                        DimensionValueListL.LOOKUPMODE(true);
                                        DimensionValueListL.SETTABLEVIEW(DimensionValueL);
                                        if not (DimensionValueListL.RUNMODAL() = ACTION::LookupOK) then
                                            exit(false)
                                        else begin
                                            DimensionValueListL.GETRECORD(DimensionValueL);
                                            DimValueCode := DimensionValueL.Code;
                                        end;
                                    end;
                            end;
                            //HEI.01<<
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            //HEI.01>>
            CLEAR(CompanyInformation);
            CLEAR(GeneralInterfaceSetup);
            CLEAR(GeneralInterfaceSetupRead);
            CLEAR(ZycusInterfaceSetup);
            CLEAR(ZycusInterfaceSetupRead);
            CLEAR(SendInfoFor);
            CLEAR(DimValueCode);
            CLEAR(MaxNoOfRecord);
            CLEAR(LoopCount);
            CLEAR(ExecutedBy);
            CLEAR(LineCount);
            CLEAR(Created);
            CLEAR(Counted);
            CLEAR(HeaderEntryNo);
            CLEAR(AssignedLineCount);
            CLEAR(LineEntryNo);
            CLEAR(TotalLineCount);
            //HEI.01<<
        end;
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        //HEI.01>>
        if GUIALLOWED then begin
            case SendInfoFor of
                SendInfoFor::CCC:
                    begin
                        if AssignedLineCount <> 0 then
                            MESSAGE(Text008, FORMAT(SendInfoFor::CCC), AssignedLineCount, TotalLineCount)
                        else
                            MESSAGE(Text009, FORMAT(SendInfoFor::CCC));
                    end;
                SendInfoFor::CONCAT:
                    begin
                        if AssignedLineCount <> 0 then
                            MESSAGE(Text008, FORMAT(SendInfoFor::CONCAT), AssignedLineCount, TotalLineCount)
                        else
                            MESSAGE(Text009, FORMAT(SendInfoFor::CONCAT));
                    end;
                else
                    MESSAGE(Text010);
            end;
        end;
        //HEI.01<<
    end;

    trigger OnPreReport();
    var
        jL: Integer;
    begin
        //HEI.01>>
        CLEAR(MaxNoOfRecord);
        CLEAR(LoopCount);
        CLEAR(ExecutedBy);
        CLEAR(LineCount);
        CLEAR(Created);
        CLEAR(Counted);
        CLEAR(HeaderEntryNo);
        CLEAR(AssignedLineCount);
        CLEAR(LineEntryNo);
        CLEAR(TotalLineCount);
        CompanyInformation.GET();
        GetZycusInterfaceSetup_Zycus();
        GetGeneralInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then
            ERROR(Text001, CompanyInformation."Custom System Indicator Text");
        case SendInfoFor of
            SendInfoFor::" ":
                ERROR(Text002);
            SendInfoFor::CCC:
                begin
                    if ZycusInterfaceSetup."Max No. of Records for CCC" <> 0 then
                        MaxNoOfRecord := ZycusInterfaceSetup."Max No. of Records for CCC";
                end;
            SendInfoFor::CONCAT:
                begin
                    if ZycusInterfaceSetup."Max No. of Records for WBN" <> 0 then
                        MaxNoOfRecord := ZycusInterfaceSetup."Max No. of Records for WBN";
                end;
        end;
        jL := STRPOS(USERID, '\');
        if jL = 0 then
            ExecutedBy := USERID
        else
            ExecutedBy := DELSTR(USERID, 1, jL);
        //HEI.01<<
    end;

    var
        CompanyInformation: Record "Company Information";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        ZycusInterfaceSetup: Record "Zycus Interface Setup INT";
        GeneralInterfaceSetupRead: Boolean;
        ZycusInterfaceSetupRead: Boolean;
        Text000: Label 'Interface ''%1'' is not enabled.';
        Text001: Label 'Zycus Interface is not Enabled in this Company ''%1''.';
        SendInfoFor: Option " ",CCC,CONCAT,Vendor,GLAccount;
        Text002: Label 'Please select the "Send Info For" filter option to send the data for respective interface.';
        Text003: Label 'Please select the "Dim. Value Code" filter for this Dimension Code ''%1''.';
        Text004: Label 'Please clear the Code filter under the Dimension %1 Tab. As you have already selected the value on "Dim. Value Code" filter.';
        Text008: Label 'Total %1 Code %2, out of %3 Interfaced for Zycus.';
        Text009: Label 'No %1 Code found to Interface for Zycus.';
        Text010: Label 'Process done.';
        DimValueCode: Code[250];
        MaxNoOfRecord: Integer;
        LoopCount: Integer;
        ExecutedBy: Code[10];
        Text013: Label '%1 of this %2 %3 %4 is missing in %5. It is having some restricted special character for Zycus.';
        Text020: Label 'User Run';
        LineCount: Integer;
        Created: Integer;
        Counted: Integer;
        HeaderEntryNo: Integer;
        AssignedLineCount: Integer;
        LineEntryNo: Integer;
        TempVendRec: Record Vendor temporary;
        TempGLAccRec: Record "G/L Account" temporary;
        TotalLineCount: Integer;

    local procedure GetGeneralInterfaceSetup_Zycus();
    begin
        //HEI.01>>
        if not GeneralInterfaceSetupRead then begin
            GeneralInterfaceSetup.GET();
            GeneralInterfaceSetupRead := true;
        end;
        //HEI.01<<
    end;

    local procedure GetZycusInterfaceSetup_Zycus();
    begin
        //HEI.01>>
        if not ZycusInterfaceSetupRead then begin
            if ZycusInterfaceSetup.GET() and ZycusInterfaceSetup."Enabled Zycus Integration" then
                ZycusInterfaceSetupRead := true;
        end;
        //HEI.01<<
    end;

    local procedure ValidateInterfaceSetup_Zycus(InterfaceCode: Code[20]);
    var
        InterfaceSetupL: Record "Interface Setup INT";
    begin
        //HEI.01>>
        InterfaceSetupL.GET(InterfaceCode);
        if not InterfaceSetupL.Enabled then
            ERROR(Text000, InterfaceSetupL.Code);
        //HEI.01<<
    end;

    local procedure GetLocalCurrentDateTime_Zycus() Now: DateTime;
    var
        DateFilterCalcL: Codeunit "DateFilter-Calc";
    begin
        //HEI.01>>
        Now := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
        //HEI.01<<
    end;

    local procedure SendCCCDimCreateOrUpdate_Zycus(var DimCode: Code[20]; var DimValueCode: Code[20]; InterfaceCode: Code[20]);
    var
        DimensionValueL: Record "Dimension Value";
        UserSetupL: Record "User Setup";
        InterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIPL1: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIPL2: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIPL: Record "Interface Entry Line VIP INT";
        InterfaceLogHeaderVIPL: Record "Interface Log Header VIP INT";
        GeneralLedgerSetupL: Record "General Ledger Setup";
        jL: Integer;
        ParkedErrorL: Boolean;
    begin
        //HEI.01>>
        DimensionValueL.GET(DimCode, DimValueCode);
        if LineCount = 1 then begin
            Created := 0;
            Counted := 1;
        end;
        if Counted - Created = 1 then begin
            GeneralLedgerSetupL.GET();
            InterfaceEntryHeaderVIPL.INIT();
            InterfaceEntryHeaderVIPL."Interface Code" := InterfaceCode;
            InterfaceEntryHeaderVIPL.Direction := InterfaceEntryHeaderVIPL.Direction::Outbound;
            InterfaceEntryHeaderVIPL.Status := InterfaceEntryHeaderVIPL.Status::Pending;
            InterfaceEntryHeaderVIPL."Legal Entity" := CompanyInformation."Legal Entity Code FND";
            InterfaceEntryHeaderVIPL."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryHeaderVIPL."Msg. Sender Business System ID" := ZycusInterfaceSetup."HeiLite Business System ID";
            InterfaceEntryHeaderVIPL."Msg. Recv. Business System ID" := ZycusInterfaceSetup."Zycus Business System ID";
            InterfaceEntryHeaderVIPL."Source Type" := DATABASE::Dimension;
            InterfaceEntryHeaderVIPL."Source Subtype" := InterfaceEntryHeaderVIPL."Source Subtype"::"0";
            InterfaceEntryHeaderVIPL."Source No." := DimCode;
            InterfaceEntryHeaderVIPL."Message Name" := ExecutedBy;
            InterfaceEntryHeaderVIPL."Currency Code" := GeneralLedgerSetupL."LCY Code";
            if Counted > 1 then
                InterfaceEntryHeaderVIPL."Entry No." += 1;
            InterfaceEntryHeaderVIPL.INSERT(true);
            Created += 1;
            HeaderEntryNo := InterfaceEntryHeaderVIPL."Entry No.";
            InterfaceEntryHeaderVIPL1.GET(HeaderEntryNo);
            InterfaceEntryHeaderVIPL1."Message Creation DateTime" := CURRENTDATETIME;
            InterfaceEntryHeaderVIPL1."Sell-to Customer No." := FORMAT(CURRENTDATETIME, 0, '<Month,2>/<Day,2>/<Year> <Hours12,2>:<Minutes,2> <AM/PM>');
            InterfaceEntryHeaderVIPL1."Version No." := FORMAT(HeaderEntryNo);
            InterfaceEntryHeaderVIPL1.MODIFY(true);
        end;

        CLEAR(jL);
        InterfaceEntryLineVIPL.INIT();
        InterfaceEntryLineVIPL."Header Entry No." := HeaderEntryNo;
        LineEntryNo += 1;
        InterfaceEntryLineVIPL."Entry No." := LineEntryNo;
        InterfaceEntryLineVIPL.Flag := ExecutedBy;
        InterfaceEntryLineVIPL.EAN := DimensionValueL."Dimension Code";
        InterfaceEntryLineVIPL."Ccc Code" := DimensionValueL.Code;
        InterfaceEntryLineVIPL."Name 2" := DimensionValueL.Name;
        InterfaceEntryLineVIPL.Blocked := DimensionValueL.Blocked;
        if DimensionValueL."Approver ID FND" <> '' then begin
            UserSetupL.GET(DimensionValueL."Approver ID FND");
            InterfaceEntryLineVIPL."E-mail" := UserSetupL."E-Mail";
        end;
        jL := STRPOS(DimensionValueL."Approver ID FND", '\');
        if jL = 0 then
            InterfaceEntryLineVIPL."Customer Code" := DimensionValueL."Approver ID FND"
        else
            InterfaceEntryLineVIPL."Customer Code" := DELSTR(DimensionValueL."Approver ID FND", 1, jL);
        InterfaceEntryLineVIPL."Ending Date-Time" := DimensionValueL."Last DateTime Modif. Zycus FND";
        InterfaceEntryLineVIPL."Prod. Order Line No." := DimensionValueL."Dimension Value ID";
        InterfaceEntryLineVIPL.INSERT(true);

        if (HeaderEntryNo <> 0) or not ParkedErrorL then begin
            InterfaceEntryHeaderVIPL2.RESET();
            InterfaceEntryHeaderVIPL2.SETCURRENTKEY("Entry No.", Status, "Source No.");
            InterfaceEntryHeaderVIPL2.SETRANGE("Entry No.", HeaderEntryNo);
            InterfaceEntryHeaderVIPL2.SETRANGE(Status, InterfaceEntryHeaderVIPL2.Status::Error);
            InterfaceEntryHeaderVIPL2.SETRANGE("Source No.", DimCode);
            if not InterfaceEntryHeaderVIPL2.ISEMPTY then
                ParkedErrorL := true
            else if not ParkedErrorL then begin
                InterfaceLogHeaderVIPL.RESET();
                InterfaceLogHeaderVIPL.SETCURRENTKEY("Interface Entry No.", Status, "Source No.");
                InterfaceLogHeaderVIPL.SETRANGE("Interface Entry No.", HeaderEntryNo);
                InterfaceLogHeaderVIPL.SETRANGE(Status, InterfaceLogHeaderVIPL.Status::Error);
                InterfaceLogHeaderVIPL.SETRANGE("Source No.", DimCode);
                if not InterfaceLogHeaderVIPL.ISEMPTY then
                    ParkedErrorL := true;
            end;
        end;
        if not ParkedErrorL and (HeaderEntryNo <> 0) and (LineEntryNo <> 0) then begin
            AssignedLineCount += 1;
            if MaxNoOfRecord <> 0 then begin
                if (MaxNoOfRecord * Created) = AssignedLineCount then
                    Counted += 1;
            end else begin
                Counted += 1;
            end;
        end;
        //HEI.01<<
    end;

    local procedure SendWBNDimCreateOrUpdate_Zycus(var DimCode: Code[20]; var DimValueCode: Code[20]; InterfaceCode: Code[20]);
    var
        DimensionValueL: Record "Dimension Value";
        UserSetupL: Record "User Setup";
        InterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIPL1: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIPL2: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIPL: Record "Interface Entry Line VIP INT";
        InterfaceLogHeaderVIPL: Record "Interface Log Header VIP INT";
        jL: Integer;
        ParkedErrorL: Boolean;
        ZycusDimValueMappingL: Record "Zycus Dim Value Mapping INT";
        ZycusSpecialCharacterL: Record "Zycus Special Character INT";
        kL: Integer;
        FixedAssetL: Record "Fixed Asset";
    begin
        //HEI.01>>
        DimensionValueL.GET(DimCode, DimValueCode);
        if LineCount = 1 then begin
            Created := 0;
            Counted := 1;
        end;
        if Counted - Created = 1 then begin
            InterfaceEntryHeaderVIPL.INIT();
            InterfaceEntryHeaderVIPL."Interface Code" := InterfaceCode;
            InterfaceEntryHeaderVIPL.Direction := InterfaceEntryHeaderVIPL.Direction::Outbound;
            InterfaceEntryHeaderVIPL.Status := InterfaceEntryHeaderVIPL.Status::Pending;
            InterfaceEntryHeaderVIPL."Legal Entity" := CompanyInformation."Legal Entity Code FND";
            InterfaceEntryHeaderVIPL."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryHeaderVIPL."Msg. Sender Business System ID" := ZycusInterfaceSetup."HeiLite Business System ID";
            InterfaceEntryHeaderVIPL."Msg. Recv. Business System ID" := ZycusInterfaceSetup."Zycus Business System ID";
            InterfaceEntryHeaderVIPL."Source Type" := DATABASE::Dimension;
            InterfaceEntryHeaderVIPL."Source Subtype" := InterfaceEntryHeaderVIPL."Source Subtype"::"0";
            InterfaceEntryHeaderVIPL."Source No." := DimCode;
            InterfaceEntryHeaderVIPL."Message Name" := ExecutedBy;
            if Counted > 1 then
                InterfaceEntryHeaderVIPL."Entry No." += 1;
            InterfaceEntryHeaderVIPL.INSERT(true);
            Created += 1;
            HeaderEntryNo := InterfaceEntryHeaderVIPL."Entry No.";
            InterfaceEntryHeaderVIPL1.GET(HeaderEntryNo);
            InterfaceEntryHeaderVIPL1."Message Creation DateTime" := CURRENTDATETIME;
            InterfaceEntryHeaderVIPL1."Sell-to Customer No." := FORMAT(CURRENTDATETIME, 0, '<Month,2>/<Day,2>/<Year> <Hours12,2>:<Minutes,2> <AM/PM>');
            InterfaceEntryHeaderVIPL1."Version No." := FORMAT(HeaderEntryNo);
            InterfaceEntryHeaderVIPL1.MODIFY(true);
        end;

        CLEAR(jL);
        CLEAR(kL);
        CLEAR(ZycusDimValueMappingL);
        CLEAR(FixedAssetL);
        InterfaceEntryLineVIPL.INIT();
        InterfaceEntryLineVIPL."Header Entry No." := HeaderEntryNo;
        LineEntryNo += 1;
        InterfaceEntryLineVIPL."Entry No." := LineEntryNo;
        InterfaceEntryLineVIPL.Flag := ExecutedBy;
        InterfaceEntryLineVIPL.EAN := DimensionValueL."Dimension Code";
        InterfaceEntryLineVIPL."Ccc Code" := DimensionValueL.Code;
        if DimensionValueL."Updated Special Char Zycus FND" then begin
            ZycusDimValueMappingL.GET(DimensionValueL."Dimension Code", DimensionValueL.Code);
            InterfaceEntryLineVIPL."CMG Code" := ZycusDimValueMappingL."Dimension Value Code Zycus";
        end else begin
            InterfaceEntryLineVIPL."CMG Code" := DimensionValueL.Code;
            ZycusSpecialCharacterL.RESET();
            if ZycusSpecialCharacterL.findset(false) then begin
                repeat
                    kL := STRPOS(InterfaceEntryLineVIPL."CMG Code", ZycusSpecialCharacterL."Zycus Restricted Special Char");
                until (ZycusSpecialCharacterL.NEXT() = 0) or (kL <> 0);
            end;
            if kL <> 0 then
                ERROR(Text013, ZycusDimValueMappingL.FIELDCAPTION("Dimension Value Code Zycus"), DimensionValueL.TABLECAPTION,
                  DimensionValueL.FIELDCAPTION(Code), InterfaceEntryLineVIPL."CMG Code", ZycusDimValueMappingL.TABLECAPTION);
        end;
        InterfaceEntryLineVIPL."Name 2" := DimensionValueL.Name;
        InterfaceEntryLineVIPL.Blocked := DimensionValueL.Blocked;
        if DimensionValueL."Approver ID FND" <> '' then begin
            UserSetupL.GET(DimensionValueL."Approver ID FND");
            InterfaceEntryLineVIPL."E-mail" := UserSetupL."E-Mail";
        end;
        jL := STRPOS(DimensionValueL."Approver ID FND", '\');
        if jL = 0 then
            InterfaceEntryLineVIPL."Customer Code" := DimensionValueL."Approver ID FND"
        else
            InterfaceEntryLineVIPL."Customer Code" := DELSTR(DimensionValueL."Approver ID FND", 1, jL);
        InterfaceEntryLineVIPL."Ending Date-Time" := DimensionValueL."Last DateTime Modif. Zycus FND";
        InterfaceEntryLineVIPL."Prod. Order Line No." := DimensionValueL."Dimension Value ID";
        if FixedAssetL.GET(DimensionValueL.Code) then
            InterfaceEntryLineVIPL.Closed := true;
        InterfaceEntryLineVIPL.INSERT(true);

        if (HeaderEntryNo <> 0) or not ParkedErrorL then begin
            InterfaceEntryHeaderVIPL2.RESET();
            InterfaceEntryHeaderVIPL2.SETCURRENTKEY("Entry No.", Status, "Source No.");
            InterfaceEntryHeaderVIPL2.SETRANGE("Entry No.", HeaderEntryNo);
            InterfaceEntryHeaderVIPL2.SETRANGE(Status, InterfaceEntryHeaderVIPL2.Status::Error);
            InterfaceEntryHeaderVIPL2.SETRANGE("Source No.", DimCode);
            if not InterfaceEntryHeaderVIPL2.ISEMPTY then
                ParkedErrorL := true
            else if not ParkedErrorL then begin
                InterfaceLogHeaderVIPL.RESET();
                InterfaceLogHeaderVIPL.SETCURRENTKEY("Interface Entry No.", Status, "Source No.");
                InterfaceLogHeaderVIPL.SETRANGE("Interface Entry No.", HeaderEntryNo);
                InterfaceLogHeaderVIPL.SETRANGE(Status, InterfaceLogHeaderVIPL.Status::Error);
                InterfaceLogHeaderVIPL.SETRANGE("Source No.", DimCode);
                if not InterfaceLogHeaderVIPL.ISEMPTY then
                    ParkedErrorL := true;
            end;
        end;
        if not ParkedErrorL and (HeaderEntryNo <> 0) and (LineEntryNo <> 0) then begin
            AssignedLineCount += 1;
            if MaxNoOfRecord <> 0 then begin
                if (MaxNoOfRecord * Created) = AssignedLineCount then
                    Counted += 1;
            end else begin
                Counted += 1;
            end;
        end;
        //HEI.01<<
    end;

    local procedure SendVendorCreateOrUpdate_Zycus(InterfaceCode: Code[20]);
    var
        VendRecL: Record Vendor;
        InterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIPL1: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIPL2: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIPL: Record "Interface Entry Line VIP INT";
        InterfaceLogHeaderVIPL: Record "Interface Log Header VIP INT";
        HeaderEntryNoL: Integer;
        EntryNoL: Integer;
        NowL: DateTime;
        LoopCountL: Integer;
        iL: Integer;
        jL: Integer;
        ParkedErrorL: Boolean;
        ZycusInterfaceSetupL: Record "Zycus Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        InterfaceSetup: Record "Interface Setup INT";
    begin
        //HEI.02>>
        InterfaceSetup.GET(InterfaceCode);
        GeneralInterfaceSetup.GET(); //HEI.03
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        TempVendRec.RESET();
        if ZycusInterfaceSetup."Max. Vendor Per Interface" <> 0 then
            LoopCountL := ROUND((TempVendRec.COUNT / ZycusInterfaceSetup."Max. Vendor Per Interface"), 1, '>')
        else
            LoopCountL := 1;

        if TempVendRec.findset(false) then begin
            for iL := 1 to LoopCountL do begin
                InterfaceEntryHeaderVIPL.INIT();
                InterfaceEntryHeaderVIPL."Interface Code" := InterfaceCode;
                InterfaceEntryHeaderVIPL.Direction := InterfaceEntryHeaderVIPL.Direction::Outbound;
                InterfaceEntryHeaderVIPL.Status := InterfaceEntryHeaderVIPL.Status::Pending;
                //InterfaceEntryHeaderVIPL."Legal Entity" := CompanyInformation."Legal Entity Code"; //HEI.03
                InterfaceEntryHeaderVIPL."Company Code ID" := GeneralInterfaceSetup."Company Code ID"; //HEI.03
                InterfaceEntryHeaderVIPL."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderVIPL."Source Type" := DATABASE::Vendor;
                InterfaceEntryHeaderVIPL."Source Subtype" := InterfaceEntryHeaderVIPL."Source Subtype"::"0";
                InterfaceEntryHeaderVIPL."Source No." := InterfaceCode;
                InterfaceEntryHeaderVIPL."Message Name" := Text020;
                InterfaceEntryHeaderVIPL.ApproverID := ExecutedBy;
                if iL > 1 then
                    InterfaceEntryHeaderVIPL."Entry No." += 1;
                InterfaceEntryHeaderVIPL.INSERT(true);
                HeaderEntryNoL := InterfaceEntryHeaderVIPL."Entry No.";
                InterfaceEntryHeaderVIPL1.GET(HeaderEntryNoL);
                InterfaceEntryHeaderVIPL1."Message Creation DateTime" := CURRENTDATETIME;
                InterfaceEntryHeaderVIPL1."Sell-to Customer No." := FORMAT(CURRENTDATETIME, 0, '<Month,2>/<Day,2>/<Year> <Hours12,2>:<Minutes,2> <AM/PM>');
                InterfaceEntryHeaderVIPL1.MODIFY(true);

                repeat
                    CLEAR(jL);
                    InterfaceEntryLineVIPL.INIT();
                    InterfaceEntryLineVIPL."Header Entry No." := HeaderEntryNoL;
                    EntryNoL += 1;
                    InterfaceEntryLineVIPL."Entry No." := EntryNoL;
                    InterfaceEntryLineVIPL.Flag := Text020;
                    InterfaceEntryLineVIPL."No." := TempVendRec."No.";
                    InterfaceEntryLineVIPL."No. 2" := TempVendRec."Global Vendor Number FND";
                    InterfaceEntryLineVIPL.Description := COPYSTR(TempVendRec.Name, 1, 50);
                    InterfaceEntryLineVIPL."Description 2" := COPYSTR(TempVendRec."Name 2", 1, 50);
                    if TempVendRec.Blocked = TempVendRec.Blocked::All then
                        InterfaceEntryLineVIPL.Blocked := true; //Posting Blocked
                    if TempVendRec.Blocked = TempVendRec.Blocked::Order then
                        InterfaceEntryLineVIPL.Closed := true; //Purchasing Blocked
                    InterfaceEntryLineVIPL."Currency Code" := TempVendRec."Currency Code";
                    InterfaceEntryLineVIPL."Payment Terms Code" := TempVendRec."Payment Terms Code";
                    InterfaceEntryLineVIPL."Shipment Method Code" := TempVendRec."Shipment Method Code";
                    InterfaceEntryLineVIPL.INSERT(true);
                until (TempVendRec.NEXT() = 0) or (EntryNoL = (ZycusInterfaceSetup."Max. Vendor Per Interface" * iL));

                if (HeaderEntryNoL <> 0) or (not ParkedErrorL) then begin
                    InterfaceEntryHeaderVIPL2.RESET();
                    InterfaceEntryHeaderVIPL2.SETCURRENTKEY("Entry No.", Status, "Source No.");
                    InterfaceEntryHeaderVIPL2.SETRANGE("Entry No.", HeaderEntryNoL);
                    InterfaceEntryHeaderVIPL2.SETRANGE(Status, InterfaceEntryHeaderVIPL2.Status::Error);
                    InterfaceEntryHeaderVIPL2.SETRANGE("Source No.", InterfaceCode);
                    if not InterfaceEntryHeaderVIPL2.ISEMPTY then
                        ParkedErrorL := true
                    else if not ParkedErrorL then begin
                        InterfaceLogHeaderVIPL.RESET();
                        InterfaceLogHeaderVIPL.SETCURRENTKEY("Interface Entry No.", Status, "Source No.");
                        InterfaceLogHeaderVIPL.SETRANGE("Interface Entry No.", HeaderEntryNoL);
                        InterfaceLogHeaderVIPL.SETRANGE(Status, InterfaceLogHeaderVIPL.Status::Error);
                        InterfaceLogHeaderVIPL.SETRANGE("Source No.", InterfaceCode);
                        if not InterfaceLogHeaderVIPL.ISEMPTY then
                            ParkedErrorL := true;
                    end;
                end;
            end;
        end;

        //HEI.02<<
    end;

    local procedure SendGLAccCreateOrUpdate_Zycus(InterfaceCode: Code[20]);
    var
        GLAccRecL: Record "G/L Account";
        InterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIPL1: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIPL2: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIPL: Record "Interface Entry Line VIP INT";
        InterfaceLogHeaderVIPL: Record "Interface Log Header VIP INT";
        HeaderEntryNoL: Integer;
        EntryNoL: Integer;
        NowL: DateTime;
        LoopCountL: Integer;
        iL: Integer;
        jL: Integer;
        ParkedErrorL: Boolean;
        ZycusInterfaceSetupL: Record "Zycus Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        InterfaceSetup: Record "Interface Setup INT";
    begin
        //HEI.02>>
        InterfaceSetup.GET(InterfaceCode);
        GeneralInterfaceSetup.GET(); //HEI.03
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        TempGLAccRec.RESET();
        if ZycusInterfaceSetup."Max. Account Per Interface" <> 0 then
            LoopCountL := ROUND((TempGLAccRec.COUNT / ZycusInterfaceSetup."Max. Account Per Interface"), 1, '>')
        else
            LoopCountL := 1;

        if TempGLAccRec.findset(false) then begin
            for iL := 1 to LoopCountL do begin
                InterfaceEntryHeaderVIPL.INIT();
                InterfaceEntryHeaderVIPL."Interface Code" := InterfaceCode;
                InterfaceEntryHeaderVIPL.Direction := InterfaceEntryHeaderVIPL.Direction::Outbound;
                InterfaceEntryHeaderVIPL.Status := InterfaceEntryHeaderVIPL.Status::Pending;
                //InterfaceEntryHeaderVIPL."Legal Entity" := CompanyInformation."Legal Entity Code"; //HEI.03
                InterfaceEntryHeaderVIPL."Company Code ID" := GeneralInterfaceSetup."Company Code ID"; //HEI.03
                InterfaceEntryHeaderVIPL."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderVIPL."Source Type" := DATABASE::"G/L Account";
                InterfaceEntryHeaderVIPL."Source Subtype" := InterfaceEntryHeaderVIPL."Source Subtype"::"0";
                InterfaceEntryHeaderVIPL."Source No." := InterfaceCode;
                InterfaceEntryHeaderVIPL."Message Name" := Text020;
                InterfaceEntryHeaderVIPL.ApproverID := ExecutedBy;
                if iL > 1 then
                    InterfaceEntryHeaderVIPL."Entry No." += 1;
                InterfaceEntryHeaderVIPL.INSERT(true);
                HeaderEntryNoL := InterfaceEntryHeaderVIPL."Entry No.";
                InterfaceEntryHeaderVIPL1.GET(HeaderEntryNoL);
                InterfaceEntryHeaderVIPL1."Message Creation DateTime" := CURRENTDATETIME;
                InterfaceEntryHeaderVIPL1."Sell-to Customer No." := FORMAT(CURRENTDATETIME, 0, '<Month,2>/<Day,2>/<Year> <Hours12,2>:<Minutes,2> <AM/PM>');
                InterfaceEntryHeaderVIPL1.MODIFY(true);

                repeat
                    CLEAR(jL);
                    InterfaceEntryLineVIPL.INIT();
                    InterfaceEntryLineVIPL."Header Entry No." := HeaderEntryNoL;
                    EntryNoL += 1;
                    InterfaceEntryLineVIPL."Entry No." := EntryNoL;
                    InterfaceEntryLineVIPL.Flag := Text020;
                    InterfaceEntryLineVIPL."No." := TempGLAccRec."No.";
                    InterfaceEntryLineVIPL."No. 2" := TempGLAccRec."No. 2";
                    InterfaceEntryLineVIPL.Description := COPYSTR(TempGLAccRec.Name, 1, 50);
                    if TempGLAccRec."Income/Balance" = TempGLAccRec."Income/Balance"::"Balance Sheet" then
                        InterfaceEntryLineVIPL."Business Segment Name" := 'Balance Sheet Account'
                    else
                        InterfaceEntryLineVIPL."Business Segment Name" := 'Profit & Loss Account';
                    if TempGLAccRec.Blocked then
                        InterfaceEntryLineVIPL.Blocked := true;
                    if TempGLAccRec."Direct Posting" then
                        InterfaceEntryLineVIPL.Closed := true;//Direct Posting
                    InterfaceEntryLineVIPL.INSERT(true);
                until (TempGLAccRec.NEXT() = 0) or (EntryNoL = (ZycusInterfaceSetup."Max. Account Per Interface" * iL));

                if (HeaderEntryNoL <> 0) or (not ParkedErrorL) then begin
                    InterfaceEntryHeaderVIPL2.RESET();
                    InterfaceEntryHeaderVIPL2.SETCURRENTKEY("Entry No.", Status, "Source No.");
                    InterfaceEntryHeaderVIPL2.SETRANGE("Entry No.", HeaderEntryNoL);
                    InterfaceEntryHeaderVIPL2.SETRANGE(Status, InterfaceEntryHeaderVIPL2.Status::Error);
                    InterfaceEntryHeaderVIPL2.SETRANGE("Source No.", InterfaceCode);
                    if not InterfaceEntryHeaderVIPL2.ISEMPTY then
                        ParkedErrorL := true
                    else if not ParkedErrorL then begin
                        InterfaceLogHeaderVIPL.RESET();
                        InterfaceLogHeaderVIPL.SETCURRENTKEY("Interface Entry No.", Status, "Source No.");
                        InterfaceLogHeaderVIPL.SETRANGE("Interface Entry No.", HeaderEntryNoL);
                        InterfaceLogHeaderVIPL.SETRANGE(Status, InterfaceLogHeaderVIPL.Status::Error);
                        InterfaceLogHeaderVIPL.SETRANGE("Source No.", InterfaceCode);
                        if not InterfaceLogHeaderVIPL.ISEMPTY then
                            ParkedErrorL := true;
                    end;
                end;
            end;
        end;
        //HEI.02<<
    end;

    local procedure CheckForValidGLAcc(GLAccRecLP: Record "G/L Account"): Boolean;
    var
        CMGMappingRecL: Record "CMG Mapping FND";
    begin
        //HEI.02>>
        ZycusInterfaceSetup.GET();
        CMGMappingRecL.RESET();
        CMGMappingRecL.SETRANGE(CMGMappingRecL."C&TP CODE", GLAccRecLP."C&TP CODE FND");
        CMGMappingRecL.SETRANGE(CMGMappingRecL."Dimension Code", 'CMG');
        CMGMappingRecL.SETFILTER(CMGMappingRecL."Dimension Value Code", '<>%1', '');
        if CMGMappingRecL.FINDFIRST() then begin
            if (ZycusInterfaceSetup."G/L Account Position" <> 0) and (ZycusInterfaceSetup."G/L Account Position Value" <> '') then begin
                if COPYSTR(GLAccRecLP."No.", ZycusInterfaceSetup."G/L Account Position", 1) <> ZycusInterfaceSetup."G/L Account Position Value" then
                    exit(true)
                else
                    exit(false);
            end else
                exit(true);
        end else
            exit(false);
        //HEI.02<<
    end;

    local procedure CreationOfValidGLAcc();
    var
        GLAccRecL: Record "G/L Account";
        ZycusMasterTimestampLV: Record "Zycus Master Timestamp FND";
        GLAccRecLV: Record "G/L Account";
    begin
        //HEI.02>>
        ZycusInterfaceSetup.GET();
        CLEAR(TempGLAccRec);
        if (("G/L Account"."Account Type" = "G/L Account"."Account Type"::Posting) and ("G/L Account"."C&TP CODE FND" <> '')) then begin
            if CheckForValidGLAcc("G/L Account") then begin
                TempGLAccRec.INIT();
                TempGLAccRec := "G/L Account";
                TempGLAccRec.INSERT()
            end;
        end;
        //HEI.02<<
    end;
}

