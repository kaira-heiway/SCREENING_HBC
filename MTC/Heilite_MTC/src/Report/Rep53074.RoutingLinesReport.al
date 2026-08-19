report 53074 "Routing Lines Report"
{
    // HEI.01 CHG2131294 HB2542 IBM BHANDS01 30.12.2021
    //   # New report developed
    // BC Upgrade BHARDA11 >>
    // 1. OLD Report ID - 50528.
    // 2. Add layout path and change layout extension RDLC to RDL.
    // 3. Add ApplicationArea Property in Report.
    // 4. Remove Drink-IT Field("Routing Line"."Line Speed") in the dataset column and pass blank in the place of "Routing Line"."Line Speed".
    // BC Upgrade BHARAD11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Routing Lines Report.rdl'; // BC Upgrade BHARDA11 ---Add layout path and Change extension RDLC to RDL.


    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            column(Name_Company; COMPANYNAME)
            {
            }
            column(ReportFilter; ReportFilter)
            {
            }
            dataitem("Routing Line"; "Routing Line")
            {
                DataItemTableView = SORTING("Routing No.", "Version Code", "Operation No.");
                RequestFilterFields = "Routing No.", "Version Code";
                column(RoutingNo_RoutingLine; "Routing Line"."Routing No.")
                {
                }
                column(VersionCode_RoutingLine; "Routing Line"."Version Code")
                {
                }
                column(SetupTime_RoutingLine; "Routing Line"."Setup Time")
                {
                }
                column(BatchSize_RoutingLine; "Routing Line"."Batch Size FND")
                {
                }
                column(SetupTimeUnitofMeasCode_RoutingLine; "Routing Line"."Setup Time Unit of Meas. Code")
                {
                }
                column(LineSpeed_RoutingLine; "Routing Line"."Line Speed FND") // BC Upgrade SHUKLP03 ----Drink-IT Field("Routing Line"."Line Speed")
                {
                }
                column(RunTime_RoutingLine; "Routing Line"."Run Time")
                {
                }
                column(RunTimeUnitofMeasCode_RoutingLine; "Routing Line"."Run Time Unit of Meas. Code")
                {
                }
                column(LotSize_RoutingLine; "Routing Line"."Lot Size")
                {
                }
                column(WorkCenterNo_RoutingLine; "Routing Line"."Work Center No.")
                {
                }
                column(Description_RoutingLine; "Routing Line".Description)
                {
                }
                column(ZoneCode_RoutingLine; "Routing Line"."Zone Code FND")
                {
                }
                column(BinCode_RoutingLine; "Routing Line"."Bin Code FND")
                {
                }
                column(RoutingLinkCode_RoutingLine; "Routing Line"."Routing Link Code")
                {
                }
                column(WorkCenter_WorkCenterUnitCost; WorkCenterUnitCost)
                {
                }
                column(Description_RoutingHeader; RoutingDescription)
                {
                }
                column(LinkedSKU_RoutingHeader; LinkedSKU)
                {
                }
                column(LinkedItem_RoutingHeader; LinkedItem)
                {
                }
                column(Status_RoutingVersion; RoutingStatus)
                {
                }
                column(Active_RoutingVersion; RoutingActive)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    RoutingDescription := '';
                    LinkedSKU := '';
                    LinkedItem := '';
                    WorkCenterUnitCost := 0;

                    RoutingVersion.RESET;
                    if RoutingVersion.GET("Routing Line"."Routing No.", "Routing Line"."Version Code") then begin
                        RoutingStatus := RoutingVersion.Status.AsInteger();
                        RoutingActive := RoutingVersion."Active FND";
                    end;

                    RoutingHeader.RESET;
                    if RoutingHeader.GET("Routing Line"."Routing No.") then begin
                        RoutingDescription := RoutingHeader.Description;
                        LinkedSKU := RoutingHeader."Linked SKU FND";
                        LinkedItem := RoutingHeader."Linked Item No. FND";
                    end;
                    WorkCenter.GET("Routing Line"."Work Center No.");
                    WorkCenterUnitCost := WorkCenter."Direct Unit Cost";
                end;
            }
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
        LblRoutingNo = 'Routing No.'; LblRoutingDescription = 'Routing Description'; LblVersionCode = 'Version Code'; LblStatus = 'Status'; LblActive = 'Active'; LblSetupTime = 'Setup Time'; LblBatchSize = 'Batch Size'; LblSetupTimeUOM = 'Setup Time Unit of Measure'; LblLineSpeed = 'Line Speed'; LblRunTime = 'Run Time'; LblRunTimeUOM = 'Run Time Unit of Measure'; LblLotSize = 'Lot Size'; LblWorkCenterNo = 'Work Center No.'; LblWorkCenterDesc = 'Work Center Description'; LblWorkCenterUnitCost = 'Work Center Unit Cost'; LblZoneCode = 'Zone Code'; LblBinCode = 'Bin Code'; LblRoutingLinkCode = 'Routing Link Code'; LblLinkedSKU = 'Location'; LblLinkedItem = 'SKU';
    }

    trigger OnPreReport();
    begin
        ReportFilter := "Routing Line".GETFILTERS;
    end;

    var
        WorkCenter: Record "Work Center";
        RoutingHeader: Record "Routing Header";
        RoutingVersion: Record "Routing Version";
        WorkCenterUnitCost: Decimal;
        ReportFilter: Text;
        RoutingDescription: Text;
        LinkedSKU: Code[20];
        LinkedItem: Code[20];
        RoutingStatus: Option New,Certified,"Under Development",Closed;
        RoutingActive: Boolean;
}

