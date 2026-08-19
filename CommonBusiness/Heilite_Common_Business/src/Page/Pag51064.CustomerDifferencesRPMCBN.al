page 51064 "Customer Differences (RPM) CBN"
{
    // HEI.01 FDD-RW-GAPLOG10 IBM ISYED01 30-10-2018 RPM Breakages
    //   #Created new Page created for RPM Breakages
    // HEI.02 FDD-HT88 IBM BULIMC01 27.11.2019
    //   #new adjustments for RPM Breakages:
    //     #new variable "TotalMissingChipped" and new function "TotalsRPM" created

    PageType = Document;
    SourceTable = "Customer Differences RPM FND";
    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
    UsageCategory = Documents; // BC Upgrade SHUKLP03 <<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sales return order no."; Rec."Sales return order no.")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Sales return order no. field.';
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = true;
                    Enabled = true;
                    Visible = true;
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Item Description field.';
                    ApplicationArea = All;
                }
                field("Deposit Price"; Rec."Deposit Price")
                {
                    Enabled = true;
                    ToolTip = 'Specifies the value of the Deposit Price field.';
                    ApplicationArea = All;
                }
                field("UOM Code"; Rec."UOM Code")
                {
                    ToolTip = 'Specifies the value of the UOM Code field.';
                    ApplicationArea = All;
                }
                field("Compensation RPM Diff."; Rec."Compensation RPM Diff.")
                {
                    ToolTip = 'Specifies the value of the Compensation RPM Diff. field.';
                    ApplicationArea = All;
                }
                field("RPM Missing Bottle"; Rec."RPM Missing Bottle")
                {
                    ToolTip = 'Specifies the value of the RPM Missing Bottle field.';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        //IF xRec."RPM Missing Bottle" <> Rec."RPM Missing Bottle" THEN
                        // TotalMissingBottle += Rec."RPM Missing Bottle";
                    end;
                }
                field("RPM Broken"; Rec."RPM Broken")
                {
                    ToolTip = 'Specifies the value of the RPM Broken field.';
                    ApplicationArea = All;
                }
                field("RPM Chipped"; Rec."RPM Chipped")
                {
                    ToolTip = 'Specifies the value of the RPM Chipped field.';
                    ApplicationArea = All;
                }
                field("RPM Missing crate"; Rec."RPM Missing crate")
                {
                    ToolTip = 'Specifies the value of the RPM Missing crate field.';
                    ApplicationArea = All;
                }
                field("Sell-to customer no."; Rec."Sell-to customer no.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Sell-to customer no. field.';
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Sell-to Customer Name field.';
                    ApplicationArea = All;
                }
            }
            group("RPM Total")
            {
                Caption = 'RPM Total';
                group(Control55016)
                {
                    field(TotalMissingBottle; TotalMissingBottle)
                    {
                        Caption = 'Missing Bottle';
                        ToolTip = 'Specifies the value of the Missing Bottle field.';
                        ApplicationArea = All;
                    }
                }
                group(Control55030)
                {
                    field(TotalBroken; TotalBroken)
                    {
                        Caption = 'Broken';
                        ToolTip = 'Specifies the value of the Broken field.';
                        ApplicationArea = All;
                    }
                }
                group(Control55017)
                {
                    field(TotalChipped; TotalChipped)
                    {
                        Caption = 'Chipped';
                        ToolTip = 'Specifies the value of the Chipped field.';
                        ApplicationArea = All;
                    }
                }
                group(Control55027)
                {
                    field(TotalMissingCrate; TotalMissingCrate)
                    {
                        Caption = 'Missing Crate';
                        ToolTip = 'Specifies the value of the Missing Crate field.';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord();
    begin
        TotalsRPM();
    end;

    trigger OnAfterGetRecord();
    begin
        StyleInitiated := false;
        ChangeStyle_difference := false;

        /*IF Rec."Compensation RPM Diff." <> 0 THEN BEGIN
          StyleInitiated := TRUE;
          UpdateStyle;
          end;*/

    end;

    trigger OnModifyRecord(): Boolean;
    begin
        //TotalsRPM;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        SalesReturnOrderFilter := Rec.GETFILTER("Sales return order no.");
        Rec.VALIDATE("Sales return order no.", SalesReturnOrderFilter);
    end;

    trigger OnOpenPage();
    begin
        TotalsRPM();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        //HEI.02<<
        CustomerDifferencesRPM.SETRANGE("Sales return order no.", Rec."Sales return order no.");
        if CustomerDifferencesRPM.findset() then
            repeat
                if (CustomerDifferencesRPM."Deposit Price" = 0) and (CustomerDifferencesRPM."RPM Chipped" <> 0) then
                    ERROR(Error001);
            until CustomerDifferencesRPM.NEXT() = 0;
        //HEI.02>>
    end;

    var
        CustomerDifferencesRPM: Record "Customer Differences RPM FND";
        ChangeStyle_difference: Boolean;
        StyleInitiated: Boolean;
        SalesReturnOrderFilter: Code[20];
        TotalBroken: Decimal;
        TotalChipped: Decimal;
        TotalMissingBottle: Decimal;
        TotalMissingCrate: Decimal;
        LastLineNo: Integer;
        Error001: Label 'Line with Deposit Price 0 should be deleted.';
        TextBroken: Label 'Broken';
        TextChipped: Label 'Chipped';
        TextMissingBottle: Label 'Missing Bottle';
        TextMissingCrate: Label 'Missing Crate';

    local procedure UpdateStyle();
    begin
        ChangeStyle_difference := false;
        if StyleInitiated then
            ChangeStyle_difference := true
        else
            ChangeStyle_difference := false;
    end;

    local procedure TotalsRPM();
    begin
        CLEAR(TotalMissingBottle);
        CLEAR(TotalBroken);
        CLEAR(TotalChipped);
        CLEAR(TotalMissingCrate);

        CustomerDifferencesRPM.SETRANGE("Sales return order no.", Rec."Sales return order no.");
        if CustomerDifferencesRPM.findset() then
            repeat
                TotalMissingBottle += CustomerDifferencesRPM."RPM Missing Bottle";
                TotalBroken += CustomerDifferencesRPM."RPM Broken";
                TotalChipped += CustomerDifferencesRPM."RPM Chipped";
                TotalMissingCrate += CustomerDifferencesRPM."RPM Missing crate";
            until CustomerDifferencesRPM.NEXT() = 0;
    end;
}

