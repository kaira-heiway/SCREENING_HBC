page 58119 "CP Interface Log Lines"
{
    // version HEI.01

    // HEI.01 FDD-BA-SLSGAP01 IBM NASTAA02 22.01.2019 # Counterpoint Interface
    //   # Copied Page 50012 and made the changes according to Counterpoint Interface

    // BC UPGRADE PATELS08 >>
    //    # old object id - 50259
    //    # added application area and usage category at page level
    //    # in all fields added Rec. before field name as per new syntax change in BC upgrade
    //    # added Rec. before ShowNotes in ShowDescription action
    //    # added Rec. before the CALCFIELDS in OnAfterGetRecord trigger
    // BC UPGRADE PATELS08 <<

    Caption = 'Counterpoint Interface Log Lines';
    Editable = false;
    PageType = List;
    SourceTable = "Interface Log Line INT";

    // BC UPGRADE PATELS08 >> added application area and usage category at page level
    ApplicationArea = All;
    UsageCategory = Lists;
    // BC UPGRADE PATELS08 <<


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
                    Caption = 'References';
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
                    RunObject = Page "Interface Log Components";
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
                        // BC UPGRADE PATELS08 >> added Rec. before ShowNotes
                        // ShowNotes;
                        Rec.ShowNotes();
                        // BC UPGRADE PATELS08 <<
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        CounterpointInterfaceSetup.GET();

        // BC UPGRADE PATELS08 >> added Rec. before the CALCFIELDS
        // CALCFIELDS("HeiLite Item No.");
        // CALCFIELDS("HeiLite Location Code");
        // CALCFIELDS("HeiLite Vendor No.");
        Rec.CALCFIELDS("HeiLite Item No.");
        Rec.CALCFIELDS("HeiLite Location Code");
        Rec.CALCFIELDS("HeiLite Vendor No.");
        // BC UPGRADE PATELS08 <<


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
        BlobIsEmpty: Label 'The entry does not contain any description data.';
        InterfaceEntryLine: Record "Interface Entry Line INT";
        CounterpointInterfaceSetup: Record "Counterpoint Interf. Stp INT";
        Item: Record Item;
        Vendor: Record Vendor;
        ItemDescription: Text[50];
        VendorName: Text[50];
}

