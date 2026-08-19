page 58008 "EBMS Inferface"
{
    // Heilite Navision Old Id - 50160
    // version HEI.04

    // HEI.01 CHG2151260-HB2788 COSTES04 23.12.2022 Page created
    // HEI.02 CHG2151260 HB2788 BHANDS01 30.12.2022 # Burundi Fiscal Invoice
    //   # Field Added
    // HEI.03 CHG2151260 HB2788 COSTES04 02.01.2023 # Burundi Fiscal Invoice
    //   # Field Added
    // HEI.04 CHG2151260 HB2788 COSTES04 06.01.2023 # Burundi Fiscal Invoice
    //   # Field Added

    Caption = 'EBMS Inferface';
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "EBMS Interface Setup INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Administration;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Send Invoice Interface"; Rec."Send Invoice Interface")
                {
                    Caption = 'Invoice Request Interface';
                    ToolTip = 'Specifies the value of the Invoice Request Interface field.';
                }
                field("Sales Confirmation Interface"; Rec."Sales Confirmation Interface")
                {
                    Caption = 'Invoice Response Interface';
                    ToolTip = 'Specifies the value of the Invoice Response Interface field.';
                }
                field("Send Invoice Interface Res."; Rec."Send Invoice Interface Res.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Send Invoice Interface Response field.';
                }
                field("No. of Confirmation Attempts"; Rec."No. of Confirmation Attempts")
                {
                    ToolTip = 'Specifies the value of the No. of Confirmation Attempts field.';
                }
                field("Customer Account Group Filter"; Rec."Customer Account Group Filter")
                {
                    ToolTip = 'Specifies the value of the Customer Account Group Filter field.';
                }
                field("Item Category Code Filter"; Rec."Item Category Code Filter")
                {
                    ToolTip = 'Specifies the value of the Item Category Code Filter field.';
                }
                field("Taxpayer System ID"; Rec."Taxpayer System ID")
                {
                    ToolTip = 'Specifies the value of the Taxpayer System ID field.';
                }
                field("CT Gen. Prod. Posting Gr."; Rec."CT Gen. Prod. Posting Gr.")
                {
                    ToolTip = 'Specifies the value of the CT Gen. Prod. Posting Gr. field.';
                }
                field("TL Gen. Prod. Posting Gr."; Rec."TL Gen. Prod. Posting Gr.")
                {
                    ToolTip = 'Specifies the value of the TL Gen. Prod. Posting Gr. field.';
                }
                field("Shipping Cost Item Charge No."; Rec."Shipping Cost Item Charge No.")
                {
                    ToolTip = 'Specifies the value of the Shipping Cost Item Charge No. field.';
                }
                field("VAT Cust. Gen. Prod. P. Gr."; Rec."VAT Cust. Gen. Prod. P. Gr.")
                {
                    ToolTip = 'Specifies the value of the VAT Cust. Gen. Prod. Posting Gr. field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(DocumentTypes)
            {
                Caption = 'Document Types';
                Image = Documents;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "EBMS Document Types";
                ToolTip = 'Executes the Document Types action.';
            }
        }
    }

    trigger OnOpenPage();
    begin
        Rec.RESET();
        if not Rec.GET() then begin
            Rec.INIT();
            Rec.INSERT();
        end;
    end;
}

