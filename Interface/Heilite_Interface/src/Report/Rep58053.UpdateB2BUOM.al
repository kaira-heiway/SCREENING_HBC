report 58053 "Update B2B UOM"
{
    // version HEI.01

    // HEI.01 CHG2174122 HB3137 BHANDS01 13.02.2023 # Control for which UOM prices sent to B2B
    //   # New process only report to populate the B2B UOM Setup table

    //Bc Upgrade YADAVM09 old id is 50138.
    
    // BC Upgrade PATELP08>>
    // Changed name of table from "B2B Item Units of Measure" to "B2B Item Units of Measure FND"
    // BC Upgrade PATELP08<<

    ProcessingOnly = true;
    ApplicationArea = all;//Bc Upgrade YADAVM09<<
    UsageCategory = ReportsAndAnalysis;//Bc Upgrade YADAVM09<<

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Item Category Code", "Gen. Prod. Posting Group";
            dataitem("Item Unit of Measure"; "Item Unit of Measure")
            {
                DataItemLink = "Item No." = FIELD("No.");
                RequestFilterFields = "Code";

                trigger OnAfterGetRecord();
                begin
                    if GUIALLOWED then begin
                        ProgressWindow.UPDATE(1, Item."No.");
                        cnt := cnt + 1;
                    end;

                    B2BItemUnitsofMeasure.RESET;
                    B2BItemUnitsofMeasure.SETRANGE("Item No.", Item."No.");
                    B2BItemUnitsofMeasure.SETRANGE(Code, "Item Unit of Measure".Code);
                    if B2BItemUnitsofMeasure.ISEMPTY then begin
                        B2BItemUnitsofMeasure.INIT;
                        B2BItemUnitsofMeasure."Item No." := Item."No.";
                        B2BItemUnitsofMeasure.Code := "Item Unit of Measure".Code;
                        B2BItemUnitsofMeasure."B2B UOM" := true;
                        B2BItemUnitsofMeasure."Modified By" := USERID;
                        B2BItemUnitsofMeasure."Modified On" := TODAY;
                        B2BItemUnitsofMeasure.INSERT;
                    end;
                    if GUIALLOWED then
                        ProgressWindow.UPDATE(2, ROUND(cnt / Totcnt * 10000, 1));
                end;

                trigger OnPreDataItem();
                begin
                    if SalesUOM then
                        "Item Unit of Measure".SETRANGE(Code, Item."Sales Unit of Measure");
                end;
            }

            trigger OnPreDataItem();
            begin
                Totcnt := Item.COUNT;
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
                    Caption = 'Options';
                    field(SalesUOM; SalesUOM)
                    {
                        Caption = 'Update Sales UOM';
                        ApplicationArea = All;
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

    trigger OnInitReport();
    begin
        SalesUOM := true;
    end;

    trigger OnPostReport();
    begin
        if GUIALLOWED then begin
            ProgressWindow.CLOSE;
            if cnt <> 0 then
                MESSAGE(Text004, cnt)
            else
                MESSAGE(Text005);
        end;
        CLEARALL;
    end;

    trigger OnPreReport();
    begin
        CLEAR(cnt);
        CLEAR(Totcnt);
        if GUIALLOWED then
            ProgressWindow.OPEN(
              Text001 +
              Text002 +
              Text003);
    end;

    var
        B2BItemUnitsofMeasure: Record "B2B Item Units of Measure FND";
        cnt: Integer;
        Totcnt: Integer;
        ProgressWindow: Dialog;
        Text001: Label 'Information\';
        Text002: Label '" Item     #1#######################\"';
        Text003: Label '"  Progress    @2@@@@@@@@@@@@@@@@@@@@@@@\"';
        SalesUOM: Boolean;
        Text004: Label '%1 records have been updated';
        Text005: Label 'Nothing is updated';
}

