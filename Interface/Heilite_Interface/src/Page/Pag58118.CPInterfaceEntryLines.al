page 58118 "CP Interface Entry Lines"
{
    // version HEI.01

    // HEI.01 FDD-BA-SLSGAP01 IBM NASTAA02 22.01.2019 # Counterpoint Interface
    //   # Copied Page 50009 and made the changes according to Counterpoint Interface
    //BC Upgrade MISHRS14  >>
    // #Old object id-50257
    // #new object id-58118
    //BC Upgrade MISHRS14  <<

    Caption = 'Counterpoint Interface Entry Lines';
    Editable = false;
    PageType = List;
    SourceTable = "Interface Entry Line INT";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field("No."; Rec."No.")
                {
                    Caption = 'CP Item No.';
                }
                field("HeiLite Item No."; Rec."HeiLite Item No.")
                {
                    Caption = 'Heilite Item No.';
                }
                field(ItemDescription; ItemDescription)
                {
                    Caption = 'Heilite Item Description';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Caption = 'CP Store No.';
                }
                field("HeiLite Location Code"; Rec."HeiLite Location Code")
                {
                    Caption = 'Heilite Location Code';
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field("CounterpointInterfaceSetup.""Item UoM Retail"""; CounterpointInterfaceSetup."Item UoM Retail")
                {
                    Caption = 'Unit of Measure';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    Caption = 'CP Vendor No.';
                }
                field("HeiLite Vendor No."; Rec."HeiLite Vendor No.")
                {
                    Caption = 'Heilite Vendor No.';
                }
                field(VendorName; VendorName)
                {
                    Caption = 'Heilite Vendor Name';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Caption = 'Pay Code';
                }
                field("Unit Amount"; Rec."Unit Amount")
                {
                    Caption = 'Unit Price';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    Caption = 'Amount';
                }
                field("Tax Code"; Rec."Tax Code")
                {
                    Caption = 'Tax Code';
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    Caption = 'VAT Amount';
                }
                field("Amount Incl. VAT"; Rec."Amount Incl. VAT")
                {
                    Caption = 'Amount Incl. VAT';
                }
                field("Loyalty Amount"; Rec."Loyalty Amount")
                {
                    Caption = 'Loyalty';
                }
                field("Discount %"; Rec."Discount %")
                {
                    Caption = 'Discount';
                }
                field("Event Date"; Rec."Event Date")
                {
                    Caption = 'Event Date';
                }
                field(Reference; Rec.Reference)
                {
                    Caption = 'Reference';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Line)
            {
                Caption = 'Line';
                Image = "Action";
                action(Components)
                {
                    Caption = 'Components';
                    Image = AllLines;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Interface Entry Components";
                    RunPageLink = "Header Entry No." = FIELD("Header Entry No."),
                                  "Line Entry No." = FIELD("Entry No.");
                }
                action(ShowDescription)
                {
                    Caption = 'Show Description';
                    Image = Description;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction();
                    begin
                        Rec.ShowNotes();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        CounterpointInterfaceSetup.GET();
        Rec.CALCFIELDS("HeiLite Item No.");
        Rec.CALCFIELDS("HeiLite Location Code");
        Rec.CALCFIELDS("HeiLite Vendor No.");
        if Item.GET(Rec."HeiLite Item No.") then
            ItemDescription := Item.Description
        else
            ItemDescription := '';
        if Vendor.GET(Rec."HeiLite Vendor No.") then
            VendorName := Vendor.Name
        else
            VendorName := '';
    end;

    var
        InterfaceEntryLine: Record "Interface Entry Line INT";
        CounterpointInterfaceSetup: Record "Counterpoint Interf. Stp INT";
        Item: Record Item;
        Vendor: Record Vendor;
        ItemDescription: Text[50];
        VendorName: Text[50];
}

