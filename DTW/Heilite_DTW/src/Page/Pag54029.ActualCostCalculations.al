page 54029 "Actual Cost Calculations"
{
    // version HEI.01

    // HEI.01 FDD-BPMGAP BRD HB398 IBM NASTAA02 20.11.2019 # Actual Product Costing
    //   # New Page created to store Actual Product Cost Calculations
    // HEI.02 FDD-BPMGAP BRD HB398 IBM BULIMC01 22.01.2020 # Actual Product Costing
    //   # New fields displayed "Description", "Type"
    // BC Upgrade KUMARS145 Nav ID Page 50434 "Actual Cost Calculations"

    Caption = 'Actual Cost Calculations';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Actual Cost Calculation DTW";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Entry No." DTW Ext Imformation';
                    Visible = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Item No." DTW Ext Imformation';
                    Style = Strong;
                    StyleExpr = TotalLine;
                }
                field("Item No. of Source No."; Rec."Item No. of Source No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Item No. of Source No." DTW Ext Imformation';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Location Code" DTW Ext Imformation';
                    Style = Strong;
                    StyleExpr = TotalLine;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Starting Date" DTW Ext Imformation';
                    Style = Standard;
                    StyleExpr = TotalLine;
                    Visible = false;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Ending Date" DTW Ext Imformation';
                    Style = Strong;
                    StyleExpr = TotalLine;
                    Visible = false;
                }
                field("Calculation Type"; Rec."Calculation Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Calculation Type" DTW Ext Imformation';
                    Visible = false;
                }
                field("Description ILE"; Rec."Description ILE")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Description ILE" DTW Ext Imformation';
                    Style = Strong;
                    StyleExpr = TotalLine;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes Description DTW Ext Imformation';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes Type DTW Ext Imformation';
                }
                field("Calculated Actual Cost"; Rec."Calculated Actual Cost")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Calculated Actual Cost" DTW Ext Imformation';
                    Style = Unfavorable;
                    StyleExpr = TotalLine;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes Quantity DTW Ext Imformation';
                    Style = Strong;
                    StyleExpr = TotalLine;
                }
                field("Cost Amount (Actual) VE"; Rec."Cost Amount (Actual) VE")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Cost Amount (Actual) VE" DTW Ext Imformation';
                }
                field("Cost Amount (Purchase) VE"; Rec."Cost Amount (Purchase) VE")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Cost Amount (Purchase) VE" DTW Ext Imformation';
                }
                field("Previous Actual Cost BUoM"; Rec."Previous Actual Cost BUoM")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Previous Actual Cost BUoM" DTW Ext Imformation';
                }
                field("Std. Cost (BUoM)"; Rec."Std. Cost (BUoM)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Std. Cost (BUoM)" DTW Ext Imformation';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Posting Date" DTW Ext Imformation';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Entry Type" DTW Ext Imformation';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Document Type" DTW Ext Imformation';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Document No." DTW Ext Imformation';
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Item Category Code" DTW Ext Imformation';
                }
                field("Item Ledger Entry Type"; Rec."Item Ledger Entry Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Item Ledger Entry Type" DTW Ext Imformation';
                }
                field("Item Ledger Entry No."; Rec."Item Ledger Entry No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Item Ledger Entry No." DTW Ext Imformation';
                }
                field("Order Type Value Entry"; Rec."Order Type Value Entry")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Order Type Value Entry" DTW Ext Imformation';
                }
                field("Entry Type Value Entry"; Rec."Entry Type Value Entry")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Entry Type Value Entry" DTW Ext Imformation';
                }
                field("Source Type Value Entry"; Rec."Source Type Value Entry")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Source Type Value Entry" DTW Ext Imformation';
                }
                field("Source No. Value Entry"; Rec."Source No. Value Entry")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Source No. Value Entry" DTW Ext Imformation';
                }
                field("Related Value Entry No."; Rec."Related Value Entry No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Related Value Entry No." DTW Ext Imformation';
                }
                field("Valued Quantity VE"; Rec."Valued Quantity VE")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Valued Quantity VE" DTW Ext Imformation';
                }
                field("Capacity Ledg Entry No. VE"; Rec."Capacity Ledg Entry No. VE")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Capacity Ledg Entry No. VE" DTW Ext Imformation';
                }
                field("Use Std Cost SKU"; Rec."Use Std Cost SKU")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Use Std Cost SKU" DTW Ext Imformation';
                }
                field("Calculation Corrected"; Rec."Calculation Corrected")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes "Calculation Corrected" DTW Ext Imformation';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        TotalLine := Rec."Total Actual Product Cost Line";
        if Rec."Total Actual Product Cost Line" then
            if Rec.Quantity <> 0 then
                TotalQuantity := true
            else
                if Rec."Cost Amount (Actual) VE" <> 0 then
                    TotalQuantity := true
                else
                    if Rec."Cost Amount (Purchase) VE" <> 0 then
                        TotalQuantity := true;
    end;

    var
        TotalLine: Boolean;
        TotalQuantity: Boolean;
}

