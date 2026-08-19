report 54029 "Update ILE Expiry Date Qty Per"
{
    // version HEI.02

    // HEI.01 INC4673725/CHG2205488 IBM PRASAA03 22.05.2023 lot with multiple expiration date L3131180F3 in Kinshasa.
    //   # New Report created to update expiry date in item ledger entry.
    // HEI.02 INC4991283/CHG2234608 IBM PRASAA03 09.01.2023 Issue of Posted Transfer shipment Reversal - Wrong Qty per Unit of Measure
    //   # New logic added to update Qty Per UOM.


    //BC Upgrade KAPOOV01 >>
    // 1. Add ApplicationArea and UsageCategory property in Report.
    // 2. Old Report Id-50599
    //BC Upgrade KAPOOV01 <<

    Permissions = TableData "Item Ledger Entry" = rm;
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            RequestFilterFields = "Entry No.";

            trigger OnAfterGetRecord();
            begin
                //HEI.02>>
                //"Item Ledger Entry"."Expiration Date" := NewExpDate;
                if SelectType = SelectType::ExpiryDate then
                    "Item Ledger Entry"."Expiration Date" := NewExpDate;
                if SelectType = SelectType::QtyPerUOM then
                    "Item Ledger Entry"."Qty. per Unit of Measure" := QtyPerUOMValue;
                //HEI.02<<
                "Item Ledger Entry".MODIFY();
                MESSAGE('Entry No. %1 is Updated', "Item Ledger Entry"."Entry No.");
            end;

            trigger OnPreDataItem();
            begin
                if "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Entry No.") = '' then
                    ERROR('Please select Entry No.');
                //HEI.02>>
                /*
                IF NewExpDate = 0D THEN
                  ERROR('New Expiry Date Must have a value');
                */
                if SelectType = SelectType::ExpiryDate then
                    if NewExpDate = 0D then
                        ERROR(Text002);
                if SelectType = SelectType::QtyPerUOM then
                    if QtyPerUOMValue = 0 then
                        ERROR(Text003);
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
                group(Control55001)
                {
                    field(SelectType; SelectType)
                    {
                        ApplicationArea = All;
                    }
                    field("New Expiry Date"; NewExpDate)
                    {
                        ApplicationArea = All;

                        trigger OnValidate();
                        begin
                            //HEI.02>>
                            if SelectType = SelectType::QtyPerUOM then
                                ERROR(Text001, SelectType::ExpiryDate);
                            CLEAR(QtyPerUOMValue);
                            //HEI.02<<
                        end;
                    }
                    field(QtyPerUOMValue; QtyPerUOMValue)
                    {
                        ApplicationArea = All;

                        trigger OnValidate();
                        begin
                            //HEI.02>>
                            if SelectType = SelectType::ExpiryDate then
                                ERROR(Text001, SelectType::QtyPerUOM);
                            CLEAR(NewExpDate);
                            //HEI.02<<
                        end;
                    }
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

    var
        NewExpDate: Date;
        SelectType: Option ExpiryDate,QtyPerUOM;
        QtyPerUOMValue: Decimal;
        Text001: Label 'Selection must be %1';
        Text002: Label 'New Expiry Date Must have a value';
        Text003: Label 'Qty Per UOM value Must have a value';
}

