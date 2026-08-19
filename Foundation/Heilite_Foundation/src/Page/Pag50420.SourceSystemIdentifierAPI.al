page 50420 "Source System Identifier API"
{
    // version HEI.09

    // HEI.01 CHG2065153 IBM KUMARN15 23.06.2020
    //   # New page created
    // HEI.02 FDD-HT678 IBM NASTAA02 09.11.2020 # DMS / DDE Integration
    //   # New field added: "Use Default S. Order Nos"
    // HEI.03 FDD-HB899 - CHG2093015 IBM NASTAA02  22.01.2021 # LSR - Sales And Payments
    //   # New Fields added: "Order Value Validation", "Order Val. Tolerance Amt", "Recalculate Sales Prices","Automatic SO Posting",
    //     "G/L Difference Account, "Post Diff to G/L Account", ,"Use Location - Dimension Mapping", "Automatic Payment Posting"
    // HEI.04 FDD-HB1234 - CHG2053453 IBM NASTAA02 11.03.2021 # B2B Order Status
    //   # New Fields added: "Enable SO Notifications" and "Stop Sales RO Status"
    // HEI.06 HB2469 - CHG2122312 IBM NASTAA02 17.11.2021 # Payment API with B2B DOT Interface into HL
    //   # New Field added: "Disable Default Pay Doc. No."
    // HEI.07 HB2427 - CHG2121928 IBM NASTAA02 20.11.2021 # B2B Invoice API
    //   # New Fields added: "Enable Invoicing"
    // HEI.08 CHG2188870 DEBUSD01 03.02.2023 Sales Order API Performance change flow
    //   # Add "field Split Response/ Processing"
    // HEI.09 CHG2174235 COSTES04 11.07.2023 Prices and Taxes
    //   # New field Stop Sales Quote Status

    Caption = 'Source System Identifier API';
    PageType = List;
    SourceTable = "Source Sys Identifier API FND";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Execute Checking"; Rec."Execute Checking")
                {
                    Caption = 'Split Response/ Processing';
                    ToolTip = 'Specifies the value of the Split Response/ Processing field.';
                }
                field("Use Default S. Order Nos"; Rec."Use Default S. Order Nos")
                {
                    ToolTip = 'Specifies the value of the Use Default Sales Order No. Series field.';
                }
                field("Apply Sales Condit Interface"; Rec."Apply Sales Condit Interface")
                {
                    ToolTip = 'Specifies the value of the Apply Sales Conditions from the Interface field.';
                }
                field("Automatic SO Posting"; Rec."Automatic SO Posting")
                {
                    ToolTip = 'Specifies the value of the Automatic Sales Order Posting field.';
                }
                field("Order Value Validation"; Rec."Order Value Validation")
                {
                    ToolTip = 'Specifies the value of the Order Value Validation field.';

                    trigger OnValidate();
                    begin
                        if not Rec."Order Value Validation" then
                            Rec."Order Val. Tolerance Amt" := 0;
                    end;
                }
                field("Order Val. Tolerance Amt"; Rec."Order Val. Tolerance Amt")
                {
                    Editable = Rec."Order Value Validation";
                    ToolTip = 'Specifies the value of the Order Value Validation Buffer Amount (+/-) field.';
                }
                field("Post Diff to G/L Account"; Rec."Post Diff to G/L Account")
                {
                    ToolTip = 'Specifies the value of the Post Difference to G/L Account field.';

                    trigger OnValidate();
                    begin
                        if not Rec."Post Diff to G/L Account" then
                            Rec."G/L Difference Account" := '';
                    end;
                }
                field("G/L Difference Account"; Rec."G/L Difference Account")
                {
                    Editable = Rec."Post Diff to G/L Account";
                    ToolTip = 'Specifies the value of the G/L Difference Account field.';
                }
                field("Use Location - Dim Mapping"; Rec."Use Location - Dim Mapping")
                {
                    ToolTip = 'Specifies the value of the Use Location - Dimension Mapping field.';
                }
                field("Disable Default Pay Doc. No."; Rec."Disable Default Pay Doc. No.")
                {
                    ToolTip = 'Specifies the value of the Disable Default Payment Document No. field.';
                }
                field("Automatic Payment Posting"; Rec."Automatic Payment Posting")
                {
                    ToolTip = 'Specifies the value of the Automatic Payment Posting field.';
                }
                field("Enable SO Notifications"; Rec."Enable SO Notifications")
                {
                    ToolTip = 'Specifies the value of the Enable Sales Order Notifications field.';

                    trigger OnValidate();
                    begin
                        if not Rec."Enable SO Notifications" then
                            Rec."Stop Sales RO Status" := false;
                    end;
                }
                field("Stop Sales RO Status"; Rec."Stop Sales RO Status")
                {
                    Editable = Rec."Enable SO Notifications";
                    ToolTip = 'Specifies the value of the Stop Sales Return Order Status field.';
                }
                field("Enable Invoicing"; Rec."Enable Invoicing")
                {
                    ToolTip = 'Specifies the value of the Enable Invoicing field.';
                }
                field("Skip Sales Quote Status"; Rec."Skip Sales Quote Status")
                {
                    ToolTip = 'Specifies the value of the Skip Sales Quote Status field.';
                }
            }
        }
    }

    actions
    {
    }
}

