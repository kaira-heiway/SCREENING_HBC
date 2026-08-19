page 53008 "Gate Entry Subform"
{
    // version HEI.03
    //BC Upgrade GUNREM01 -Old page ID 50223

    // HEI:EDD001:1:1 12/11/14 TECTURA-HKH
    //   # New Form Created for Gate Entry
    // HEI:EDD151:1:1 17/08/11 NJ
    //   # Added new field 80000 'Location Code' [Code 20]
    // 
    // FDD-HNK-BRA-0036 - 06/30/2017 - CiprianH
    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Copied Page from HEI2.0
    // HEI.02 Bugfixing RW IBM NASTAA02 17.10.2018 # Bugfining Gate Entry RW
    //   # Added Zone Code
    // HEI.03 Bugfixing RW IBM NASTAA02 02.11.2018 # Bugfining Gate Entry RW
    //   # "Quantity on Arrival" should be editable for Inbound entries

    // BC Upgrade MISHRS14 >>
    // Changed name from OnAfterGetCurrRecord to OnAfterGetCurrRecordProcedure as that is only valid for trigger name, in procedure name and in OnAfterGetRecord and OnNewRecord triggers.
    // BC Upgrade MISHRS14 <<

    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = CardPart;
    SourceTable = "Gate Entry Line FND";
    SourceTableView = SORTING("Gate Entry Document No.", "Line No.");

    layout
    {
        area(content)
        {
            repeater(Control1000000000)

            {
                ShowCaption = false; //BC Upgrade GUNREM01
                field("Gate Entry Document No."; Rec."Gate Entry Document No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                    ApplicationArea = all;

                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;

                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;

                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;

                }
                field("Zone Code"; Rec."Zone Code")
                {
                    Editable = false;
                    ApplicationArea = all;

                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ApplicationArea = all;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;

                }
                field("Quantity on Arrival"; Rec."Quantity on Arrival")
                {
                    Editable = "Quantity on ArrivalEditable";
                    ApplicationArea = all;

                }
                field("Quantity on Departure"; Rec."Quantity on Departure")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    // actions
    // {
    // }

    trigger OnAfterGetRecord();
    begin

        // BC Upgrade MISHRS14 >>
        //OnAfterGetCurrRecord();
        // Changed call as procedure name changed due to warning.
        OnAfterGetCurrRecordProcedure;
        // BC Upgrade MISHRS14 <<
    end;

    trigger OnInit();
    begin
        "Quantity on ArrivalEditable" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin

        // BC Upgrade MISHRS14 >>
        //OnAfterGetCurrRecord();
        // Changed call as procedure name changed due to warning.
        OnAfterGetCurrRecordProcedure;
        // BC Upgrade MISHRS14 <<
    end;

    trigger OnOpenPage();
    begin
        //FDD-HNK-BRA-0036>>
        WhseSetup.GET;
        if WhseSetup."Allow Collect Lines FND" = true then begin
            if WhseSetup."Auto Insert Qty.CollectLin FND" = true then
                AllowQtyShipment := true
            else
                AllowQtyShipment := false;
        end else
            AllowQtyShipment := false
        //FDD-HNK-BRA-0036<<
    end;

    var
        GateEntryHeader: Record "Gate Entry Header FND";
        //  [InDataSet]
        "Quantity on ArrivalEditable": Boolean;
        WhseSetup: Record "Warehouse Setup";
        AllowQtyShipment: Boolean;

    procedure UpdateEditableField();
    begin
        if GateEntryHeader.GET(Rec."Gate Entry Document No.") then begin
            if GateEntryHeader.Status = GateEntryHeader.Status::Released then begin
                if GateEntryHeader."Gate Entry Type" <> GateEntryHeader."Gate Entry Type"::Inbound then //HEI.03
                    "Quantity on ArrivalEditable" := false;
            end else begin
                "Quantity on ArrivalEditable" := true;
            end;
        end;
    end;

    // BC Upgrade MISHRS14 >>
    // Changed procedure name due to warning as OnAfterGetCurrRecord is only valid for trigger name
    //local procedure OnAfterGetCurrRecord
    local procedure OnAfterGetCurrRecordProcedure();
    begin
        xRec := Rec;
        UpdateEditableField
    end;
    // BC Upgrade MISHRS14 <<
}

