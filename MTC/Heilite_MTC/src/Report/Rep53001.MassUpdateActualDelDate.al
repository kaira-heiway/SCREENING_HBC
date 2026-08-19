report 53001 "Mass Update Actual Del Date"
{
    // version HEI.01

    // HEI.01 HB1582 IBM NASTAA02 02.09.2020 # Actual Delivery Date for Case Fill Rate - CHG2071900
    //   # New Report created to update value of Field "Actual Delivery Date"
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID is 50413.
    // 2. Add ApplicationArea property in report and Requestpage property. 
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Mass Update Actual Delivery Date';
    Permissions = TableData 110 = rm;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);

            trigger OnAfterGetRecord();
            begin
                IF ActualDeliveryDate <> 0D THEN BEGIN
                    VALIDATE("Actual Delivery Date FND", ActualDeliveryDate);
                    MODIFY;
                    NoOfRecUpdated += 1;
                END;
            end;

            trigger OnPreDataItem();
            begin
                NoOfRecUpdated := 0;
                SETFILTER("Actual Delivery Date FND", '%1', 0D);
                IF FINDFIRST AND (ActualDeliveryDate <> 0D) THEN
                    IF NOT CONFIRM(UpdateActDelDateConf + "Sales Shipment Header".FIELDCAPTION("Actual Delivery Date FND") + ' as ' + FORMAT(ActualDeliveryDate) + '?') THEN
                        ERROR('');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                // Caption = 'Options';
                field(ActualDeliveryDate; ActualDeliveryDate)
                {
                    ApplicationArea = All;
                    Caption = 'Actual Delivery Date';

                    trigger OnValidate();
                    var
                        SalesShipmentHeader: Record 110;
                        MaxPostingDate: Date;
                    begin
                        SalesShipmentHeader.COPYFILTERS("Sales Shipment Header");
                        IF SalesShipmentHeader.FINDSET THEN BEGIN
                            MaxPostingDate := SalesShipmentHeader."Posting Date";
                            REPEAT
                                IF SalesShipmentHeader."Posting Date" > MaxPostingDate THEN
                                    MaxPostingDate := SalesShipmentHeader."Posting Date";
                            UNTIL SalesShipmentHeader.NEXT = 0;
                        END;

                        IF ActualDeliveryDate < MaxPostingDate THEN
                            ERROR(AfterActDelDateErr2, "Sales Shipment Header".FIELDCAPTION("Actual Delivery Date FND"), "Sales Shipment Header".FIELDCAPTION("Posting Date"), MaxPostingDate);

                        //IF ActualDeliveryDate < EndingDate THEN
                        //ERROR(AfterActDelDateErr,"Sales Shipment Header".FIELDCAPTION("Actual Delivery Date"),EndingDate);
                    end;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        IF ActualDeliveryDate <> 0D THEN
            IF NoOfRecUpdated > 0 THEN
                MESSAGE(NoOfRecUpdatedMsg, "Sales Shipment Header".FIELDCAPTION("Actual Delivery Date FND"), NoOfRecUpdated)
            ELSE
                MESSAGE(NotUpdatedRecUpdatedMsg);
    end;

    trigger OnPreReport();
    begin
        IF ActualDeliveryDate = 0D THEN
            ERROR(EmptyActualDelDateErr);
    end;

    var
        ActualDeliveryDate: Date;
        NoOfRecUpdated: Integer;
        NoOfRecUpdatedMsg: Label '%1 was updated for %2 Sales Shipments.';
        StartingDate: Date;
        EndingDate: Date;
        NotUpdatedRecUpdatedMsg: Label 'There are no Sales Shipments to be updated.';
        PriorActDelDateErr: Label '%1 cannot be prior to Starting Date %2.';
        AfterActDelDateErr: Label '%1 cannot be prior to Ending Date %2.';
        AfterActDelDateErr2: Label '%1 cannot be prior to highest %2 %3.';
        UpdateActDelDateConf: Label '"Do you want to update selected Shipments with "';
        EmptyActualDelDateErr: Label 'Actual Delivery Date should be filled-in.';

    procedure SetStartEndDate(StartDate: Date; EndDate: Date);
    begin
        StartingDate := StartDate;
        EndingDate := EndDate;
    end;
}

