page 58124 "CP Interface Log"
{
    // version HEI.01

    // HEI.01 FDD-BA-SLSGAP01 IBM NASTAA02 22.01.2019 # Counterpoint Interface
    //   # Copied Page 50011 and made the changes according to Counterpoint Interface

    //BC Upgrade SHIKHD02  >>
    // old object ID - 50258
    // new object ID - 58124
    // added application area and usage category
    // added Rec for fields
    // Wrapped each filter value in quotes -> FILTER 'CP-PAYMENTS'|'CP-PAYOUTS'|'CP-PURCHASE-NC'|'CP-RTV-NC'|'CP-SALES'|'CP-STKADJST'|'CP-STKTRF'
    //BC Upgrade SHIKHD02  <<

    Caption = 'Counterpoint Interface Log';
    Editable = false;
    PageType = List;
    SourceTable = "Interface Log Header INT";
    //BC Upgrade SHIKHD02  >>  Blocked because single quote was missing for filter and was showing error. 
    // SourceTableView = SORTING("Entry No.")
    //                   ORDER(Descending)
    //                   WHERE("Interface Code"=FILTER(CP-PAYMENTS|CP-PAYOUTS|CP-PURCHASE-NC|CP-RTV-NC|CP-SALES|CP-STKADJST|CP-STKTRF));
    SourceTableView = SORTING("Entry No.")
                      ORDER(Descending)
                      WHERE("Interface Code" = FILTER('CP-PAYMENTS' | 'CP-PAYOUTS' | 'CP-PURCHASE-NC' | 'CP-RTV-NC' | 'CP-SALES' | 'CP-STKADJST' | 'CP-STKTRF'));
    //BC Upgrade SHIKHD02  <<

    //BC Upgrade SHIKHD02  >> added application area and usage category
    ApplicationArea = All;
    UsageCategory = Lists;
    //BC Upgrade SHIKHD02  <<
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Interface Code"; Rec."Interface Code")
                {
                }
                field("Sync. Date"; Rec."Sync. Date")
                {
                }
                field("Archive Date"; Rec."Archive Date")
                {
                }
                field("InterfaceLogLine.""Posting Date"""; InterfaceLogLine."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field("InterfaceLogLine.""No."""; InterfaceLogLine."No.")
                {
                    Caption = 'CP Item No.';
                }
                field("InterfaceLogLine.""HeiLite Item No."""; InterfaceLogLine."HeiLite Item No.")
                {
                    Caption = 'Heilite Item No.';
                }
                field(ItemDescription; ItemDescription)
                {
                    Caption = 'Heilite Item Description';
                }
                field("InterfaceLogLine.""Location Code"""; InterfaceLogLine."Location Code")
                {
                    Caption = 'CP Store No.';
                }
                field("InterfaceLogLine.""HeiLite Location Code"""; InterfaceLogLine."HeiLite Location Code")
                {
                    Caption = 'Heilite Location Code';
                }
                field("InterfaceLogLine.Quantity"; InterfaceLogLine.Quantity)
                {
                    Caption = 'Quantity';
                }
                field("CounterpointInterfaceSetup.""Item UoM Retail"""; CounterpointInterfaceSetup."Item UoM Retail")
                {
                    Caption = 'Unit of Measure';
                }
                field("InterfaceLogLine.""External Document No."""; InterfaceLogLine."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field("InterfaceLogLine.""Buy-from Vendor No."""; InterfaceLogLine."Buy-from Vendor No.")
                {
                    Caption = 'CP Vendor No.';
                }
                field("InterfaceLogLine.""HeiLite Vendor No."""; InterfaceLogLine."HeiLite Vendor No.")
                {
                    Caption = 'Heilite Vendor No.';
                }
                field(VendorName; VendorName)
                {
                    Caption = 'Heilite Vendor Name';
                }
                field("InterfaceLogLine.""Payment Terms Code"""; InterfaceLogLine."Payment Terms Code")
                {
                    Caption = 'Pay Code';
                }
                field("InterfaceLogLine.""Unit Amount"""; InterfaceLogLine."Unit Amount")
                {
                    Caption = 'Unit Price';
                }
                field("InterfaceLogLine.""Line Amount"""; InterfaceLogLine."Line Amount")
                {
                    Caption = 'Amount';
                }
                field("InterfaceLogLine.""Tax Code"""; InterfaceLogLine."Tax Code")
                {
                    Caption = 'Tax Code';
                }
                field("InterfaceLogLine.""VAT Amount"""; InterfaceLogLine."VAT Amount")
                {
                    Caption = 'VAT Amount';
                }
                field("InterfaceLogLine.""Amount Incl. VAT"""; InterfaceLogLine."Amount Incl. VAT")
                {
                    Caption = 'Amount Incl. VAT';
                }
                field("InterfaceLogLine.""Loyalty Amount"""; InterfaceLogLine."Loyalty Amount")
                {
                    Caption = 'Loyalty';
                }
                field("InterfaceLogLine.""Discount %"""; InterfaceLogLine."Discount %")
                {
                    Caption = 'Discount';
                }
                field("InterfaceLogLine.""Event Date"""; InterfaceLogLine."Event Date")
                {
                    Caption = 'Event Date';
                }
                field("InterfaceLogLine.Reference"; InterfaceLogLine.Reference)
                {
                    Caption = 'Reference';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control50025; Links)
            {
            }
            systempart(Control50026; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Header)
            {
                Caption = 'Header';
                Image = "Action";
                action(Lines)
                {
                    Caption = 'Lines';
                    Image = AllLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "CP Interface Log Lines";
                    RunPageLink = "Header Entry No." = FIELD("Entry No.");
                }
                action("Open Record")
                {
                    Caption = 'Open Record';
                    Image = Open;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Open the related record from the database.';

                    trigger OnAction();
                    begin
                        Rec.OpenRecord();
                    end;
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
                action(ShowXML)
                {
                    Caption = 'Show XML';
                    Image = XMLFile;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction();
                    begin
                        Rec.ShowXmlDocument();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        CounterpointInterfaceSetup.GET();
        InterfaceLogLine.SETRANGE("Header Entry No.", Rec."Entry No.");
        if InterfaceLogLine.FINDFIRST() then begin
            InterfaceLogLine.CALCFIELDS("HeiLite Item No.");
            InterfaceLogLine.CALCFIELDS("HeiLite Location Code");
            InterfaceLogLine.CALCFIELDS("HeiLite Vendor No.");
            if Item.GET(InterfaceLogLine."HeiLite Item No.") then
                ItemDescription := Item.Description
            else
                ItemDescription := '';
            if Vendor.GET(InterfaceLogLine."HeiLite Vendor No.") then
                VendorName := Vendor.Name
            else
                VendorName := '';
        end;
    end;

    var
        BlobIsEmpty: Label 'The entry does not contain any description data.';
        InterfaceLogLine: Record "Interface Log Line INT";
        CounterpointInterfaceSetup: Record "Counterpoint Interf. Stp INT";
        Item: Record Item;
        Vendor: Record Vendor;
        ItemDescription: Text[50];
        VendorName: Text[50];
}

