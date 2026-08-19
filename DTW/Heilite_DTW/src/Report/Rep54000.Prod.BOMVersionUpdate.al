report 54000 "Prod. BOM Version Update"
{
    // version HEI.13
    // BC Upgrade Kamnay01 Original(Heilite) Report id 50569
    // HEI.01 HB2817 - CHG2150741 IBM GOKULS01 15.06.2022 # Update Production Version
    // Allocation - new report created to Create Production version Data
    // 
    // HEI.02 HB2817 - CHG2150741 IBM GOKULS01 21.06.2022 # Update Production Version
    // #Commented code to fix active bom end date calculation.
    // #Added validation for setup feilds
    // HEI.03 HB2817 - CHG2150741 IBM GOKULS01 11.08.2022 # Update Production Version
    // #Code added for routing validation.
    // HEI.04 HB2817 - CHG2150741 IBM GOKULS01 17.08.2022 # Update Production Version
    // #Code added for routing validation.
    // HEI.05 HB2817 - CHG2150741 IBM GOKULS01 18.08.2022 # Update Production Version
    // #Code added for routing validation.
    // HEI.06 HB2817 - CHG2150741 IBM GOKULS01 24.08.2022 # Update Production Version
    // #Code added for filter error.
    // HEI.07 HB2817 - CHG2150741 IBM GOKULS01 28.08.2022 # Update Production Version
    // #Code added for filter error text.
    // HEI.08 HB2817 - CHG2150741 NORRIQ KOROLA04 05.10.2022
    //   # Report was reimplemented!!!
    // HEI.09 HB2817 - CHG2150741 NORRIQ KOROLA04 07.10.2022
    //   # CreateInterfaceEntries - changed
    //   # Root element SKU - added
    // HEI.10 HB2817 - CHG2150741 NORRIQ KOROLA04 18.10.2022
    //   # fix some logic
    // HEI.11 CHG2195346 PATHAA02 27.06.2023 # BOM interface Enhancement
    //   # Added No. in the Required Filter Fields Property -(Data Item-Production BOM Header)
    // HEI.12 CHG2261952 IBM.PATHAA02 17.10.24 # BOM Interface Enhancement
    //   # S&OP FIT_BOM interface adjustment - Prod BOM versions to be considered based on 'Ending Date'for (today minus one week and in the future)+active versions
    //   # Old Code commented and written new code using new temp table on 'OnPostReport'
    // HEI.13 CC-CHG2279741 IBM.PATHAA02 26.11.24 # Fix- Production BOM Interface
    //   # Delete the older existing Entries before creating new Entries on Production version data table for every run of Job 50569.

    // HEI.12, HEI.10 and HEI.08 => Changes made by SHUKLP03
    // # Some part of code blocked because DrinkIT field "Prod. Ver. No. Series" and "Prod. Ver. End Validity Date" is used and also blocked DrinkIT record variable "Periodic Template".    
    //BC UPGRADE PATHAA02- Fields added in 50K series in Manufacturing setup-code is uncommented

    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(SKU; "Stockkeeping Unit")
        {
            RequestFilterFields = "Item No.", "Location Code";
            dataitem("Production BOM Header"; "Production BOM Header")
            {
                DataItemLink = "Linked Item No. FND" = FIELD("Item No."), "Linked SKU FND" = FIELD("Location Code");
                RequestFilterFields = "No.";
                dataitem("Production BOM Version"; "Production BOM Version")
                {
                    DataItemLink = "Production BOM No." = FIELD("No.");
                    DataItemTableView = SORTING("Production BOM No.", "Starting Date") WHERE(Status = CONST(Certified));

                    trigger OnAfterGetRecord();
                    begin
                        //HEI.08 >>
                        TESTFIELD("Starting Date");
                        CreateInterfaceEntries("Production BOM Version");
                        //HEI.08 <<
                    end;
                }

                trigger OnAfterGetRecord();
                var
                    ProdVerData: Record "Production Version Data FND";
                begin
                    //HEI.10 >>
                    TempProdVerData.RESET();
                    TempProdVerData.SETRANGE("BOM Header Code", "No.");
                    if not TempProdVerData.ISEMPTY then
                        exit;
                    //HEI.10 <<
                    //HEI.08 >>
                    ProdVerData.SETRANGE("BOM Header Code", "No.");
                    if not ProdVerData.ISEMPTY then
                        ProdVerData.DELETEALL();
                    //HEI.08 <<
                end;
            }

            trigger OnAfterGetRecord();
            begin
                //HEI.10 >>
                if SKU."Routing No." = '' then
                    CurrReport.SKIP();

                if SKU."Production BOM No." = '' then
                    CurrReport.SKIP();
                //HEI.10 <<
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport();
    var
        Text001: Label 'BOM interface entries Created';
        ProdVerData: Record "Production Version Data FND";
        NextEntryNo: Integer;
        LastWeekNo: Code[10];
        ProdBOMVersoin: Record "Production BOM Version";
        DateVar: Date;
    begin
        /*//HEI.12>> Commented
        //HEI.08 >>
        IF ProdVerData.FINDLAST THEN;
        NextEntryNo := ProdVerData."Entry No." + 1;
        
        TempProdVerData.RESET;
        IF TempProdVerData.ISEMPTY THEN
          ERROR(Text006);
        
        TempProdVerData.SETCURRENTKEY("BOM Header Code","Routing Link Code","Start Validity Date");
        IF TempProdVerData.findset(false) THEN REPEAT
          //HEI.10 >>
          IF (ProdVerData."Routing Link Code" = TempProdVerData."Routing Link Code") AND
             (ProdVerData."BOM Header Code" = TempProdVerData."BOM Header Code") THEN BEGIN
             ProdBOMVersoin.GET(TempProdVerData."BOM Header Code", TempProdVerData."BOM Ver. Hdr. Code");
             DateVar := CALCDATE('<-7D>', ProdBOMVersoin."Starting Date");
             ProdVerData."End Validity Date" := GetWeekNo(DateVar);
             ProdVerData.MODIFY;
          END;
          //HEI.10 <<
        
          ProdVerData := TempProdVerData;
          ProdVerData."Entry No." := NextEntryNo;
          ProdVerData."Production Version" := NoSeries.GetNextNo(MFGSetup."Prod. Ver. No. Series",TODAY,TRUE);
          ProdVerData.INSERT;
        
          NextEntryNo += 1;
        UNTIL TempProdVerData.NEXT = 0;
        //HEI.08 <<
        *///HEI.12<< Commented


        //HEI.12>>
        if TempProdVerData2.FINDLAST() then;
        NextEntryNo := TempProdVerData2."Entry No." + 1;

        TempProdVerData.RESET();
        if TempProdVerData.ISEMPTY then
            ERROR(Text006);

        TempProdVerData.SETCURRENTKEY("BOM Header Code", "Routing Link Code", "Start Validity Date");
        if TempProdVerData.findset(false) then
            repeat
                if (TempProdVerData2."Routing Link Code" = TempProdVerData."Routing Link Code") and
                (TempProdVerData2."BOM Header Code" = TempProdVerData."BOM Header Code") then begin
                    ProdBOMVersoin.GET(TempProdVerData."BOM Header Code", TempProdVerData."BOM Ver. Hdr. Code");
                    DateVar := CALCDATE('<-7D>', ProdBOMVersoin."Starting Date");
                    TempProdVerData2."End Validity Date" := GetWeekNo(DateVar);
                    TempProdVerData2.MODIFY();
                end;
                TempProdVerData2 := TempProdVerData;
                TempProdVerData2."Entry No." := NextEntryNo;
                TempProdVerData2."Production Version" := NoSeries.GetNextNo(MFGSetup."Prod. Ver. No. Series FND", TODAY, true); // BC Upgrade PATHAA02
                TempProdVerData2.INSERT();
                NextEntryNo += 1;
            until TempProdVerData.NEXT() = 0;

        if ProdVerData.FINDLAST() then;
        NextEntryNo := ProdVerData."Entry No." + 1;

        TempProdVerData2.RESET();
        TempProdVerData2.SETCURRENTKEY("BOM Header Code", "Routing Link Code", "Start Validity Date");
        if TempProdVerData2.findset(false) then
            repeat
                ProdBOMVersoin.GET(TempProdVerData2."BOM Header Code", TempProdVerData2."BOM Ver. Hdr. Code");
                if (ProdBOMVersoin."Active FND") or (TempProdVerData2."End Validity Date" > GetWeekNo(TODAY - 7)) then begin
                    ProdVerData := TempProdVerData2;
                    ProdVerData.INSERT();
                end;
            until TempProdVerData2.NEXT() = 0;
        //HEI.12<<

        MESSAGE(Text001);

    end;

    trigger OnPreReport();
    begin
        //HEI.08 >>
        if not TempProdVerData.ISTEMPORARY then ERROR('');
        MFGSetup.GET();
        MFGSetup.TESTFIELD("Prod. Ver. No. Series FND"); // BC Upgrade PATHAA02
        MFGSetup.TESTFIELD("Prod. Ver. End Valid Date FND"); // BC Upgrade PATHAA02 
        //HEI.08 <<

        ProdVerDataG.DELETEALL(); //HEI.13
    end;

    var
        Text001: TextConst ENU = 'You cannot rename the %1 when %2 is %3.', FRA = 'Vous ne pouvez pas renommer l''enregistrement %1 lorsque la valeur %2 est %3.';
        Text002: Label 'A Routing link code %1 exists for more than one Routing version. Every Routing version should have its own Routing link code';
        Text003: Label 'Production BOM No. %1, Routing Link Code %2 doesn''t exists in any routing versions';
        Text004: Label 'Production BOM No. %1, Doesn''t have Routing Link Code';
        Text005: Label 'There is already one Active Production BOM %1 available for the Routing Link Code %2';
        MFGSetup: Record "Manufacturing Setup";
        NoSeries: Codeunit "No. Series"; //PATHAA02
        TempProdVerData: Record "Production Version Data FND" temporary;
        Text006: Label 'Nothing to process!';
        //PeriodDate : Record "Periodic Template"; // BC Upgrade SHUKLP03 << Blocked because DrinkIT record "Periodic Template" is used.
        TempProdVerData2: Record "Production Version Data FND" temporary;
        ProdVerDataG: Record "Production Version Data FND";

    local procedure CreateInterfaceEntries(var ProductionBOMVersion: Record "Production BOM Version");
    var
        ProdBOMLines: Record "Production BOM Line";
        ProdRoutLine: Record "Routing Line";
        RoutingLinkCode: Code[20];
        ProdVerInter: Record "Production Version Data FND";
        RoutingVersion: Record "Routing Version";
        RoutingNo: Code[20];
        RoutingVersionCode: Code[20];
        ProdBOMHeader: Record "Production BOM Header";
        NextEntryNo: Integer;
        DateVar: Date;
    begin
        //HEI.08 >>
        ProdBOMHeader.GET(ProductionBOMVersion."Production BOM No.");
        ProductionBOMVersion.ValidateData();

        ProdBOMLines.SETRANGE("Production BOM No.", ProductionBOMVersion."Production BOM No.");
        ProdBOMLines.SETRANGE("Version Code", ProductionBOMVersion."Version Code");
        ProdBOMLines.SETFILTER("Routing Link Code", '<>%1', '');
        if not ProdBOMLines.FINDFIRST() then exit;
        RoutingLinkCode := ProdBOMLines."Routing Link Code";

        ProdRoutLine.SETRANGE("Routing No.", SKU."Routing No."); //HEI.10
        ProdRoutLine.SETRANGE("Routing Link Code", ProdBOMLines."Routing Link Code");
        ProdRoutLine.SETFILTER("Version Code", '<>%1', '');
        if ProdRoutLine.findset(false) then
            repeat
                if RoutingVersion.GET(ProdRoutLine."Routing No.", ProdRoutLine."Version Code") then
                    if RoutingVersion.Status = RoutingVersion.Status::Certified then begin
                        RoutingVersion.DataValidation();
                        if RoutingNo = '' then begin
                            RoutingNo := RoutingVersion."Routing No.";
                            RoutingVersionCode := RoutingVersion."Version Code";
                        end;
                    end;
            until ProdRoutLine.NEXT() = 0;

        //HEI.09 >>
        if RoutingNo = '' then
            exit;
        //HEI.09 <<

        //HEI.10 >>
        TempProdVerData.RESET();
        TempProdVerData.SETRANGE("Material Code", ProdBOMHeader."Linked Item No. FND");
        TempProdVerData.SETRANGE("BOM Header Code", ProdBOMHeader."No.");
        TempProdVerData.SETRANGE("BOM Ver. Hdr. Code", ProductionBOMVersion."Version Code");
        TempProdVerData.SETRANGE("Routing Header Code", RoutingNo);
        TempProdVerData.SETRANGE("Routing Ver. hdr. Code", RoutingVersionCode);
        TempProdVerData.SETRANGE("Routing Link Code", RoutingLinkCode);
        if not TempProdVerData.ISEMPTY then
            exit;
        //HEI.10 <<

        TempProdVerData.RESET();
        if TempProdVerData.FINDLAST() then;
        NextEntryNo := TempProdVerData."Entry No." + 1;

        TempProdVerData.INIT();
        TempProdVerData."Entry No." := NextEntryNo;
        TempProdVerData."Material Code" := ProdBOMHeader."Linked Item No. FND";
        TempProdVerData."Production Version" := '';//NoSeries.GetNextNo(MFGSetup."Prod. Ver. No. Series",TODAY,TRUE);
        TempProdVerData."BOM Header Code" := ProdBOMHeader."No.";
        TempProdVerData."BOM Ver. Hdr. Code" := ProductionBOMVersion."Version Code";
        TempProdVerData."Routing Header Code" := RoutingNo;
        TempProdVerData."Routing Ver. hdr. Code" := RoutingVersionCode;
        TempProdVerData."Routing Link Code" := RoutingLinkCode;
        TempProdVerData."Start Validity Date" := GetWeekNo(ProductionBOMVersion."Starting Date");//HEI.10
        TempProdVerData."End Validity Date" := GetWeekNo(MFGSetup."Prod. Ver. End Valid Date FND");//HEI.10 // BC Upgrade PATHAA02
        TempProdVerData."Entry Created Date" := CREATEDATETIME(TODAY, TIME);
        TempProdVerData."Location Code" := SKU."Location Code";//HEI.10
        TempProdVerData.INSERT();
        //HEI.08 <<
    end;

    local procedure GetWeekNo(InputDate: Date): Text[30];
    var
        YearStr: Text;
        MonthStr: Text;
    begin
        //HEI.10 >>
        YearStr := FORMAT(DATE2DWY(InputDate, 3));
        MonthStr := FORMAT(DATE2DWY(InputDate, 2));
        if STRLEN(MonthStr) = 1 then
            MonthStr := '0' + MonthStr;

        exit(YearStr + MonthStr);
        //HEI.10 <<
    end;
}

