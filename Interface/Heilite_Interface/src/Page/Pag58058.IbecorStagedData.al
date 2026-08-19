page 58058 "Ibecor Staged Data"
{
    // Heilite Navision Old Id - 50453

    // version HEI.02

    // HEI.01 FDD-HB2174 CHG2104952 IBM NANDIS01 23.06.2021 Ibecor - PO API
    //   # New Page created for Ibecor Interface
    // HEI.02 CHG2167376 HB3082 IBM NANDIS01 01.02.2023 # Ibecor-HL Integration, adding Import license and inspection codes in POs
    //   # New fields shown - "License Required" and "Credit Info Required"
    ApplicationArea = All;
    Editable = false;
    PageType = List;
    SourceTable = "Ibecor PO Staging Data INT";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Entry No field.';
                }
                field("Sending Version"; Rec."Sending Version")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Archive Version';
                    ToolTip = 'Specifies the value of the Archive Version field.';
                }
                field("Movement Status"; Rec."Movement Status")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Status';
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Source Document';
                    ToolTip = 'Specifies the value of the Source Document field.';
                }
                field("Buy from Vendor No."; Rec."Buy from Vendor No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Buy from Vendor No. field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("Ibecor Doc No."; Rec."Ibecor Doc No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'PFI No.';
                    ToolTip = 'Specifies the value of the PFI No. field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Logistics Officer"; Rec."Logistics Officer")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'LO User ID';
                    ToolTip = 'Specifies the value of the LO User ID field.';
                }
                field("Delivery Date"; Rec."Delivery Date")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Expected Delivery Date';
                    ToolTip = 'Specifies the value of the Expected Delivery Date field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Total Amount Incl. VAT';
                    ToolTip = 'Specifies the value of the Total Amount Incl. VAT field.';
                }
                field(Requestor; Rec.Requestor)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Created By';
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field(Approver; Rec.Approver)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved By';
                    ToolTip = 'Specifies the value of the Approved By field.';
                }
                field("Comment with Date"; Rec."Comment with Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Comment with Date field.';
                }
                field("Last Send Date"; Rec."Last Send Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Last Send Date field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("External Doc No"; Rec."External Doc No")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the External Doc No field.';
                }
                field("Bill to Customer ID"; Rec."Bill to Customer ID")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Bill to Customer ID field.';
                }
                field("Opco Code"; Rec."Opco Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Opco Code field.';
                }
                field("Bill to Customer GID"; Rec."Bill to Customer GID")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Bill to Customer GID field.';
                }
                field("Ibecor Dossier No"; Rec."Ibecor Dossier No")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Ibecor Dossier No field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Your Reference field.';
                }
                field("Licence Number"; Rec."Licence Number")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Licence Number field.';
                }
                field("Bank Of Organism License"; Rec."Bank Of Organism License")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Bank Of Organism License field.';
                }
                field("License Expiration Date"; Rec."License Expiration Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the License Expiration Date field.';
                }
                field("Credit Number"; Rec."Credit Number")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Credit Number field.';
                }
                field("Credit amount Of Supplier"; Rec."Credit amount Of Supplier")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Credit amount Of Supplier field.';
                }
                field("Credit Validity Of Supplier"; Rec."Credit Validity Of Supplier")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Credit Validity Of Supplier field.';
                }
                field("Last Date Of Shipment"; Rec."Last Date Of Shipment")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Last Date Of Shipment field.';
                }
                field("Bank Of Organism Supplier"; Rec."Bank Of Organism Supplier")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Bank Of Organism Supplier field.';
                }
                field("Credit Info Required"; Rec."Credit Info Required")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Credit Info Required field.';
                }
                field("License Required"; Rec."License Required")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the License Required field.';
                }
            }
        }
    }

    actions
    {
    }
}

