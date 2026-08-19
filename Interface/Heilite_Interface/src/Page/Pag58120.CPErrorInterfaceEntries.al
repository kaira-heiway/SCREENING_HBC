page 58120 "CP Error Interface Entries"
{
    // version HEI.01

    // HEI.01 FDD-BA-SLSGAP01 IBM NASTAA02 22.01.2019 # Counterpoint Interface
    //   # Copied Page 50008 and made the changes according to Counterpoint Interface

    //BC Upgrade SHIKHD02  >>
    // old object ID -50256
    // new object ID -58120
    //BC Upgrade SHIKHD02  <<

    Caption = 'Counterpoint Error Interface Entries';
    Editable = false;
    PageType = List;
    SourceTable = "Interface Entry Header INT";
    SourceTableView = SORTING(Direction, Status)
                      WHERE(Status = CONST(Error),
                            "Interface Code" = FILTER('CP-PAYMENTS|CP-PAYOUTS|CP-PURCHASE-NC|CP-RTV-NC|CP-SALES|CP-STKADJST|CP-STKTRF'));
    ApplicationArea = All; //BC Upgrade SHIKHD02  <<
    UsageCategory = Lists; //BC Upgrade SHIKHD02  <<

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
                field("Error Message"; Rec."Error Message")
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
        area(factboxes)
        {
            systempart(Control50026; Links)
            {
            }
            systempart(Control50027; Notes)
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
                    PromotedIsBig = true;
                    RunObject = Page "CP Interface Entry Lines";
                    RunPageLink = "Header Entry No." = FIELD("Entry No.");
                }
                action(ShowErrorMessage)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Error Message';
                    Image = Error;
                    Promoted = true;
                    PromotedIsBig = true;
                    ToolTip = 'Show the error message that has stopped the entry.';

                    trigger OnAction();
                    begin
                        Rec.ShowErrorMessage();
                    end;
                }
                action(ClearError)
                {
                    Caption = 'Clear Error';
                    Image = ResetStatus;
                    Promoted = true;
                    PromotedIsBig = true;
                    ToolTip = 'Reset the status of the selected entry in order to reprocess it.';

                    trigger OnAction();
                    var
                        InterfaceEntryHeader: Record "Interface Entry Header INT";
                    begin
                        CurrPage.SETSELECTIONFILTER(InterfaceEntryHeader);
                        InterfaceEntryHeader.MARKEDONLY(true);
                        if InterfaceEntryHeader.FINDSET() then
                            repeat
                                InterfaceEntryHeader.ClearError();
                            until InterfaceEntryHeader.NEXT() = 0;
                        CurrPage.UPDATE();
                    end;
                }
                action(Process)
                {
                    Caption = 'Process';
                    Image = Process;
                    Promoted = true;
                    PromotedIsBig = true;
                    ToolTip = 'Process manually the selected entry.';

                    trigger OnAction();
                    begin
                        Rec.ProcessErrorEntry();
                    end;
                }
                action(MoveToLog)
                {
                    Caption = 'Move To Log';
                    Image = Log;
                    Promoted = true;
                    PromotedIsBig = true;
                    ToolTip = 'Move entry to log.';

                    trigger OnAction();
                    var
                        InterfaceEntryHeader: Record "Interface Entry Header INT";
                        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
                    begin
                        CurrPage.SETSELECTIONFILTER(InterfaceEntryHeader);
                        InterfaceFrameworkMgt.LogErrorInterfaceEntries(InterfaceEntryHeader);
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
                action("Change Posting Date")
                {
                    Caption = 'Change Posting Date for Offline Transactions on Closed Month';
                    Image = ChangeDate;

                    trigger OnAction();
                    var
                        InterfaceEntryHeader2: Record "Interface Entry Header INT";
                        InterfaceEntryLine2: Record "Interface Entry Line INT";
                    begin
                        InterfaceEntryHeader2.SETFILTER("Interface Code", '%1|%2|%3|%4|%5|%6|%7',
                                                      'CP-PAYMENTS', 'CP-PAYOUTS', 'CP-PURCHASE-NC', 'CP-RTV-NC', 'CP-SALES', 'CP-STKADJST', 'CP-STKTRF');
                        InterfaceEntryHeader2.SETRANGE(Status, InterfaceEntryHeader2.Status::Error);
                        if InterfaceEntryHeader2.FINDSET() then begin
                            repeat
                                InterfaceEntryLine2.SETRANGE("Header Entry No.", InterfaceEntryHeader2."Entry No.");
                                InterfaceEntryLine2.SETFILTER("Event Date", '<>%1', 0D);
                                if InterfaceEntryLine2.FINDFIRST() then
                                    if DATE2DMY(InterfaceEntryLine2."Posting Date", 2) <> DATE2DMY(InterfaceEntryLine2."Event Date", 2) then begin
                                        //InterfaceEntryLine2."Posting Date" := CALCDATE('-CM',InterfaceEntryLine2."Event Date");
                                        InterfaceEntryLine2."Posting Date" := CALCDATE('-CM');
                                        InterfaceEntryLine2.MODIFY();
                                    end;
                            until InterfaceEntryHeader2.NEXT() = 0;
                            MESSAGE(PostingdateChangedMsg);
                        end;
                    end;
                }
                action("Change Posting Date2")
                {
                    Caption = 'Change Posting Date from Closed Month';
                    Image = ChangeDates;

                    trigger OnAction();
                    var
                        InterfaceEntryHeader2: Record "Interface Entry Header INT";
                        InterfaceEntryLine2: Record "Interface Entry Line INT";
                    begin
                        InterfaceEntryHeader2.SETFILTER("Interface Code", '%1|%2|%3|%4|%5|%6|%7',
                                                      'CP-PAYMENTS', 'CP-PAYOUTS', 'CP-PURCHASE-NC', 'CP-RTV-NC', 'CP-SALES', 'CP-STKADJST', 'CP-STKTRF');
                        InterfaceEntryHeader2.SETRANGE(Status, InterfaceEntryHeader2.Status::Error);
                        if InterfaceEntryHeader2.FINDSET() then
                            repeat
                                InterfaceEntryLine2.SETRANGE("Header Entry No.", InterfaceEntryHeader2."Entry No.");
                                InterfaceEntryLine2.SETFILTER("Event Date", '<>%1', 0D);
                                if InterfaceEntryLine2.FINDFIRST() then
                                    if DATE2DMY(InterfaceEntryLine2."Posting Date", 2) <> DATE2DMY(TODAY, 2) then begin
                                        //InterfaceEntryLine2."Posting Date" := CALCDATE('-CM',InterfaceEntryLine2."Event Date");
                                        InterfaceEntryLine2."Posting Date" := CALCDATE('-CM');
                                        InterfaceEntryLine2.MODIFY();
                                    end;
                            until InterfaceEntryHeader2.NEXT() = 0;
                    end;
                }
                action("Delete Discount")
                {
                    Caption = 'Delete Discount with 0 Amount';
                    Image = Delete;

                    trigger OnAction();
                    var
                        InterfaceEntryHeader2: Record "Interface Entry Header INT";
                        InterfaceEntryLine2: Record "Interface Entry Line INT";
                    begin
                        InterfaceEntryHeader2.SETRANGE("Entry No.", Rec."Entry No.");
                        InterfaceEntryHeader2.SETRANGE("Interface Code", 'CP-SALES');
                        InterfaceEntryHeader2.SETRANGE(Status, InterfaceEntryHeader2.Status::Error);
                        if InterfaceEntryHeader2.FINDFIRST() then begin
                            InterfaceEntryLine2.SETRANGE("Header Entry No.", InterfaceEntryHeader2."Entry No.");
                            InterfaceEntryLine2.SETFILTER("Discount %", '>%1', 0);
                            if InterfaceEntryLine2.FINDFIRST() then
                                if CONFIRM(STRSUBSTNO(ConfirmDeleteDialog, InterfaceEntryLine2."Discount %")) then begin
                                    InterfaceEntryLine2."Discount %" := 0;
                                    InterfaceEntryLine2.MODIFY();
                                end;
                        end;
                    end;
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
        NewPostingDateDialog: Label 'Enter Posting Date for Offline Transactions from Closed Month';
        PostingdateChangedMsg: Label 'Posting Date was changed for all lines!';
        ConfirmDeleteDialog: Label 'Do you want to delete the Discount of %1 ?';
}

