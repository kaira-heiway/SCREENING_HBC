page 53001 "Update Actual Delivery Date"
{
    // version HEI.01

    // HEI.01 HB1582 IBM NASTAA02 02.09.2020 # Actual Delivery Date for Case Fill Rate - CHG2071900
    //   # New Page created to update value of Field "Actual Delivery Date"
    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea in page and actions.
    // 2. Remove Drink-IT Fields("Order Type",Route, "Route Planning No.", "Driver Code", "Truck Code")
    // 3. Old Page id is 50146
    // BC Upgrade BHARAD11 <<
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Update Actual Delivery Date';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    Permissions = TableData 110 = rm;
    SourceTable = "Sales Shipment Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Starting Date Filter"; StartDate)
                {

                    trigger OnValidate();
                    begin
                        IF StartDate = 0D THEN
                            StartDate := WORKDATE;

                        IF (EndDate = WORKDATE) AND (StartDate <> WORKDATE) AND (WORKDATE - StartDate > 7) THEN
                            EndDate := StartDate + 7;

                        IF (StartDate = WORKDATE) AND (EndDate - StartDate > 7) THEN
                            EndDate := WORKDATE;

                        IF EndDate < StartDate THEN
                            ERROR(StartDateErr);

                        IF EndDate <> WORKDATE THEN
                            IF EndDate - StartDate > 7 THEN
                                ERROR(MaxAllowedIntervalErr);

                        CurrPage.SAVERECORD;
                        SetRecFilters;
                    end;
                }
                field("Ending Date Filter"; EndDate)
                {

                    trigger OnValidate();
                    begin
                        IF EndDate = 0D THEN
                            EndDate := WORKDATE;

                        IF (EndDate = WORKDATE) AND (EndDate - StartDate > 7) THEN
                            StartDate := WORKDATE;

                        IF EndDate < StartDate THEN
                            ERROR(EndDateErr);

                        IF EndDate <> WORKDATE THEN
                            IF EndDate - StartDate > 7 THEN
                                ERROR(MaxAllowedIntervalErr);

                        CurrPage.SAVERECORD;
                        SetRecFilters;
                    end;
                }
            }
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Actual Delivery Date"; Rec."Actual Delivery Date FND")
                {
                    ApplicationArea = All;
                }

                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Order Type",Route, "Route Planning No.", "Driver Code", "Truck Code")
                // field("Order Type"; Rec."Order Type")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field(Route; Rec.Route)
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field("Route Planning No."; Rec."Route Planning No.")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field("Driver Code"; Rec."Driver Code")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field("Truck Code"; Rec."Truck Code")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Fields("Order Type",Route, "Route Planning No.", "Driver Code", "Truck Code")
                field("Whse. Shipment No."; Rec."Whse. Shipment No. FND")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posted Warehouse Shipment No."; Rec."Posted Whse. Shipment No. FND")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Process")
            {
                Caption = '&Process';
                Image = Transactions;
                action(MassUpdate)
                {
                    ApplicationArea = All;
                    Caption = 'Mass Update';
                    Image = ShowSelected;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction();
                    var
                        SalesShipmentHeader: Record "Sales Shipment Header";
                        MassUpdateActualDelDate: Report "Mass Update Actual Del Date";
                    begin
                        SalesShipmentHeader.COPYFILTERS(Rec);

                        MassUpdateActualDelDate.SetStartEndDate(StartDate, EndDate);
                        MassUpdateActualDelDate.SETTABLEVIEW(SalesShipmentHeader);
                        MassUpdateActualDelDate.RUNMODAL();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        StartDate := WORKDATE();
        EndDate := WORKDATE();
        SetRecFilters();
    end;

    var
        StartDate: Date;
        EndDate: Date;
        EndDateErr: Label 'Ending Date cannot be before Starting Date.';
        StartDateErr: Label 'Starting Date cannot be after Ending Date.';
        MaxAllowedIntervalErr: Label 'Date Filter should be setup for a maximum period of 7 days.';

    local procedure SetRecFilters();
    begin
        Rec.SETRANGE("Posting Date", StartDate, EndDate);

        CurrPage.UPDATE(FALSE);
    end;
}

