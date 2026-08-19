page 58134 "Proforma Invoice List"
{
    // version HEI.01

    // HEI.01 FDD-HB2174 CHG2104952 IBM NANDIS01 25.06.2021 Ibecor - PO API
    //   # New Page created for Ibecor PFI Interface

    //BC Upgrade KAPOOV01  >>
    // 1. Add ApplicationArea and UsageCategory property in Report.
    // 2. Old Page ID-50454
    //BC Upgrade KAPOOV01  <<

    CardPageID = "Proforma Invoice Header";
    PageType = List;
    SourceTable = "PFI Header INT";
    ApplicationArea = All;   //BC Upgrade KAPOOV01
    UsageCategory = Lists;  //BC Upgrade KAPOOV01

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("PFI Document No."; Rec."PFI Document No.")
                {
                }
                field("PFI Status"; Rec."PFI Status")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("PQ Number"; Rec."PQ Number")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                }
                field("Payment Terms Description"; Rec."Payment Terms Description")
                {
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                }
                field("Payment Method Description"; Rec."Payment Method Description")
                {
                }
                field("IBECOR Dossier No."; Rec."IBECOR Dossier No.")
                {
                }
                field("Logistics Officer"; Rec."Logistics Officer")
                {
                }
                field("Logistics Officer Email"; Rec."Logistics Officer Email")
                {
                }
                field("Total Amount(Incl. VAT)"; Rec."Total Amount(Incl. VAT)")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field(Amend; Rec.Amend)
                {
                }
                field("PFI Expiration Date"; Rec."PFI Expiration Date")
                {
                }
                field("PFI Version No"; Rec."PFI Version No")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean;
    begin
        ERROR(Text50001);
    end;

    var
        Text50001: Label 'The PFI Documents are not allowed to be deleted';
}

