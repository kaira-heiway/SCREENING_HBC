page 51004 "Vendor Local CBN"
{
    // version HEI.01

    // HEI.01 BA-PURGAP03IBM HORTOC01 22.01.2019 new fields "VendorCategory" and LocalVendorType
    // HEI.02 FDD-PURGAP033 BULIMC01 28.02.2019 new field Vendor Category with the changed datatype from Option to Code
    // HEI.03 CHG0246561 IBM HORTOC01 new field "send to maximo"
    // HEI.04 FDD-HT545 IBM POSTOI01 27.11.2019
    //   # new field Self-Billing Boolean type showed in Page Designer
    // HEI.05 CHG2036781 IBM.GUNERE01 18.02.2021 # Sensitive Payment Block changed to Sensitive Workflow Block

    // BC Upgrade PATELS08 >>
    // # Added AsInteger() to convert Enum Option to Integer, in 'OnAfterGetRecord' trigger.
    // BC Upgrade PATELS08 <<

    Editable = false;
    PageType = Card;
    SourceTable = Vendor;
    ApplicationArea = All; // BC Upgrade Priya
    UsageCategory = Documents;  // BC Upgrade Priya

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the vendor. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';
                }
                field(Blocked; BlockedAsInteger)
                {
                    CaptionML = ENU = 'Blocked',
                                FRA = 'Bloqué';
                    ToolTip = 'Specifies the value of the BlockedAsInteger field.';
                }
                field("Blocked Reason Code"; Rec."Blocked Reason Code FND")
                {
                    ToolTip = 'Specifies the value of the Blocked Reason Code field.';
                }
                field("Sensitive Workflow Block"; Rec."Sensitive Workflow Block FND")
                {
                    ToolTip = 'Specifies the value of the Sensitive Workflow Block field.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the vendor''s telephone number.';
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ToolTip = 'Specifies the vendor''s fax number.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the vendor''s email address.';
                }
                field("E-Mail 2"; Rec."E-Mail 2 FND")
                {
                    ToolTip = 'Specifies the value of the Email Finance field.';
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ToolTip = 'Specifies the vendor''s market type to link business transactions made for the vendor with the appropriate account in the general ledger.';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ToolTip = 'Specifies the vendor''s trade type to link transactions made for this vendor with the appropriate general ledger account according to the general posting setup.';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ToolTip = 'Specifies the VAT specification of the involved customer or vendor to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount.';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ToolTip = 'Specifies how to make payment, such as with bank transfer, cash, or check.';
                }
                field("Application Method"; ApplicationMethod)
                {
                    CaptionML = ENU = 'Application Method',
                                FRA = 'Mode de lettrage';
                    ToolTip = 'Specifies the value of the ApplicationMethod field.';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies the delivery conditions of the related shipment, such as free on board (FOB).';
                }
                field("Shipment Method Location"; Rec."Shipment Method Location FND")
                {
                    ToolTip = 'Specifies the value of the Shipment Method Location field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency code that is inserted by default when you create purchase documents or journal lines for the vendor.';
                }
                //BC Upgrade Priya>> DrinkIT
                // field("Vendor DDeposit Group Code";Rec."Vendor DDeposit Group Code")
                // {
                // }
                // field("Deposit Vendor Posting Group";Rec."Deposit Vendor Posting Group")
                // {
                // }
                // field("Deposit Payment Terms Code";Rec."Deposit Payment Terms Code")
                // {
                // }
                // field("Deposit Payment Method Code";Rec."Deposit Payment Method Code")
                // {
                // }
                // field("Split Deposit on Invoice";Rec."Split Deposit on Invoice")
                // {
                // }//BC Upgrade Priya<< DrinkIT
                field("Autom. Item Charge"; AutomItemCharge)
                {
                    CaptionML = ENU = 'Calculate Item Charges',
                                FRA = 'Calculer Frais annexes';
                    ToolTip = 'Specifies the value of the AutomItemCharge field.';
                }
                //BC Upgrade Priya>> DrinkIT
                // field("Gen. Bus. Posting Free Group";Rec."Gen. Bus. Posting Free Group")
                // {
                // }//BC Upgrade Priya<< DrinkIT
                field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
                {
                    ToolTip = 'Specifies the value of the WHT Business Posting Group field.';
                }
                field("Block Payment Tolerance"; Rec."Block Payment Tolerance")
                {
                    ToolTip = 'Specifies if the vendor allows payment tolerance.';
                }
                field("Send To Maximo"; Rec."Send To Maximo FND")
                {
                    ToolTip = 'Specifies the value of the Send To Maximo field.';
                }
                field("Vendor Category"; Rec."Vendor Category FND")
                {
                    ToolTip = 'Specifies the value of the Vendor Category field.';
                }
                field("Local Vendor Type"; Rec."Local Vendor Type FND")
                {
                    ToolTip = 'Specifies the value of the Local Vendor Type field.';
                }
                field("Self-Billing"; Rec."Self-Billing FND")
                {
                    ToolTip = 'Specifies the value of the Self-Billing field.';
                }
            }
            part(Control50050; "Vendor Local Order Address CBN")
            {
                SubPageLink = "Vendor No." = FIELD("No.");
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        if Rec."Currency Code" = '' then begin
            GLSetup.GET();
            Rec."Currency Code" := GLSetup."LCY Code";
        end;

        // BC Upgrade PATELS08 >> # Added AsInteger() to convert Option to Integer
        // BlockedAsInteger := Rec.Blocked;
        // ApplicationMethod := Rec."Application Method";
        BlockedAsInteger := Rec.Blocked.AsInteger();
        ApplicationMethod := Rec."Application Method".AsInteger();
        // BC Upgrade PATELS08 <<
        //AutomItemCharge := Rec."Autom. Item Charge"; //BC Upgrade Priya<< DrinkIT
    end;

    var
        GLSetup: Record "General Ledger Setup";
        ApplicationMethod: Integer;
        AutomItemCharge: Integer;
        BlockedAsInteger: Integer;
}

