page 58117 "CP Inbound Interface Entries"
{
    // version HEI.01

    // HEI.01 FDD-BA-SLSGAP01 IBM NASTAA02 22.01.2019 # Counterpoint Interface
    //   # Copied Page 50007 and made the changes according to Counterpoint Interface
    //BC Upgrade MISHRS14  >>
    // #Old object id-50255
    // #new object id-58117
    //BC Upgrade MISHRS14  <<


    Caption = 'Counterpoint Inbound Interface Entries';
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Interface Entry Header INT";
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTableView = SORTING(Direction, Status)
                      WHERE(Direction = CONST(Inbound),
                            Status = FILTER(Pending | Processed),
                            "Interface Code" = FILTER('CP-PAYMENTS|CP-PAYOUTS|CP-PURCHASE-NC|CP-RTV-NC|CP-SALES|CP-STKADJST|CP-STKTRF'));// BC Upgrade By-MISHRS14 - added single quote

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
                field("InterfaceEntryLine.""Posting Date"""; InterfaceEntryLine."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field("InterfaceEntryLine.""No."""; InterfaceEntryLine."No.")
                {
                    Caption = 'CP Item No.';
                }
                field("InterfaceEntryLine.""HeiLite Item No."""; InterfaceEntryLine."HeiLite Item No.")
                {
                    Caption = 'Heilite Item No.';
                }
                field(ItemDescription; ItemDescription)
                {
                    Caption = 'Heilite Item Description';
                }
                field("InterfaceEntryLine.""Location Code"""; InterfaceEntryLine."Location Code")
                {
                    Caption = 'CP Store No.';
                }
                field("InterfaceEntryLine.""HeiLite Location Code"""; InterfaceEntryLine."HeiLite Location Code")
                {
                    Caption = 'Heilite Location Code';
                }
                field("InterfaceEntryLine.Quantity"; InterfaceEntryLine.Quantity)
                {
                    Caption = 'Quantity';
                }
                field("CounterpointInterfaceSetup.""Item UoM Retail"""; CounterpointInterfaceSetup."Item UoM Retail")
                {
                    Caption = 'Unit of Measure';
                }
                field("InterfaceEntryLine.""External Document No."""; InterfaceEntryLine."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field("InterfaceEntryLine.""Buy-from Vendor No."""; InterfaceEntryLine."Buy-from Vendor No.")
                {
                    Caption = 'CP Vendor No.';
                }
                field("InterfaceEntryLine.""HeiLite Vendor No."""; InterfaceEntryLine."HeiLite Vendor No.")
                {
                    Caption = 'Heilite Vendor No.';
                }
                field(VendorName; VendorName)
                {
                    Caption = 'Heilite Vendor Name';
                }
                field("InterfaceEntryLine.""Payment Terms Code"""; InterfaceEntryLine."Payment Terms Code")
                {
                    Caption = 'Pay Code';
                }
                field("InterfaceEntryLine.""Unit Amount"""; InterfaceEntryLine."Unit Amount")
                {
                    Caption = 'Unit Price';
                }
                field("InterfaceEntryLine.""Line Amount"""; InterfaceEntryLine."Line Amount")
                {
                    Caption = 'Amount';
                }
                field("InterfaceEntryLine.""Tax Code"""; InterfaceEntryLine."Tax Code")
                {
                    Caption = 'Tax Code';
                }
                field("InterfaceEntryLine.""VAT Amount"""; InterfaceEntryLine."VAT Amount")
                {
                    Caption = 'VAT Amount';
                }
                field("InterfaceEntryLine.""Amount Incl. VAT"""; InterfaceEntryLine."Amount Incl. VAT")
                {
                    Caption = 'Amount Incl. VAT';
                }
                field("InterfaceEntryLine.""Loyalty Amount"""; InterfaceEntryLine."Loyalty Amount")
                {
                    Caption = 'Loyalty';
                }
                field("InterfaceEntryLine.""Discount %"""; InterfaceEntryLine."Discount %")
                {
                    Caption = 'Discount';
                }
                field("InterfaceEntryLine.""Event Date"""; InterfaceEntryLine."Event Date")
                {
                    Caption = 'Event Date';
                }
                field("InterfaceEntryLine.Reference"; InterfaceEntryLine.Reference)
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
            group(Header)
            {
                Caption = 'Header';
                Image = "Action";
                action(Lines)
                {
                    Caption = 'Lines';
                    Image = AllLines;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "CP Interface Entry Lines";
                    RunPageLink = "Header Entry No." = FIELD("Entry No.");
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
                action(Process)
                {
                    Caption = 'Process';
                    Image = Process;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Process manually the selected entry.';

                    trigger OnAction();
                    begin
                        Rec.ProcessManually();
                    end;
                }
                action(MoveToLog)
                {
                    Caption = 'Move To Log';
                    Image = Log;
                    Promoted = true;
                    PromotedIsBig = true;
                    ToolTip = 'Move entry to log.';
                    Visible = false;

                    trigger OnAction();
                    var
                        InterfaceEntryHeader: Record "Interface Entry Header INT";
                        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
                    begin
                        CurrPage.SETSELECTIONFILTER(InterfaceEntryHeader);
                        InterfaceFrameworkMgt.LogErrorInterfaceEntries(InterfaceEntryHeader);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Manual Master Data")
                {
                    Caption = 'Manual Master Data';
                    Image = DataEntry;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Interface Manual Master Data";
                    ToolTip = 'Insert Mendix related data manually';
                }
                action("Manual Entries")
                {
                    Caption = 'Manual Entries';
                    Image = ExtendedDataEntry;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Manual Interface Entries";
                    ToolTip = 'Insert SRM related data manually';
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        CounterpointInterfaceSetup.GET();
        InterfaceEntryLine.SETRANGE("Header Entry No.", Rec."Entry No.");
        if InterfaceEntryLine.FINDFIRST() then begin
            InterfaceEntryLine.CALCFIELDS("HeiLite Item No.");
            InterfaceEntryLine.CALCFIELDS("HeiLite Location Code");
            InterfaceEntryLine.CALCFIELDS("HeiLite Vendor No.");
            if Item.GET(InterfaceEntryLine."HeiLite Item No.") then
                ItemDescription := Item.Description
            else
                ItemDescription := '';
            if Vendor.GET(InterfaceEntryLine."HeiLite Vendor No.") then
                VendorName := Vendor.Name
            else
                VendorName := '';
        end;
    end;

    var
        InterfaceEntryLine: Record "Interface Entry Line INT";
        CounterpointInterfaceSetup: Record "Counterpoint Interf. Stp INT";
        Item: Record Item;
        Vendor: Record Vendor;
        ItemDescription: Text[50];
        VendorName: Text[50];
}

