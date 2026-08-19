page 51024 "FA Dep Books Subform1 CBN"
{
    // version NAVW110.0,HEI.01

    // HEI.01 FDD RTRGAP057 IBM HORTOC01 27.07.2017
    //   # new page based on standard page Fa depreciastion books subform

    //BC Upgrade MISHRS14 >>
    // Changed Page Type from ListPart to ListPlus to remove warning and DepreciationsBooks to DepreciationBook to remove warning
    // BC Upgrade MISHRS14 <<

    Caption = 'Lines';
    DataCaptionFields = "FA No.", "Depreciation Book Code";
    DelayedInsert = true;
    LinksAllowed = false;

    PageType = ListPart; //#BCUP0-25 BC Upgrade KAIRAR01 -Defect Fix

    //BC Upgrade MISHRS14 >>
    // Changed Page Type to remove warning in-action(Statistics) as Promoted and PromotedCategory is not supported in ListPart
    // PageType = ListPlus; //#BCUP0-25 BC Upgrade KAIRAR01
    // BC Upgrade MISHRS14 <<

    RefreshOnActivate = true;
    SourceTable = "FA Depreciation Book";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)//BC Upgrade KAPOOV01 Control1 keyword inside brackets.
            {
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    ApplicationArea = FixedAssets;
                    Editable = EditPage;
                    ToolTip = 'Specifies the depreciation book that is assigned to the fixed asset.';
                }
                field("FA Posting Group"; Rec."FA Posting Group")
                {
                    ApplicationArea = FixedAssets;
                    Editable = EditPage;
                    ToolTip = 'Specifies which posting group is used for the depreciation book when posting fixed asset transactions.';
                }
                field("Depreciation Method"; Rec."Depreciation Method")
                {
                    ApplicationArea = FixedAssets;
                    Editable = EditPage;
                    ToolTip = 'Specifies how depreciation is calculated for the depreciation book.';
                }
                field("Depreciation Starting Date"; Rec."Depreciation Starting Date")
                {
                    ApplicationArea = FixedAssets;
                    Editable = EditPage;
                    ToolTip = 'Specifies the date on which depreciation of the fixed asset starts.';
                }
                field("No. of Depreciation Years"; Rec."No. of Depreciation Years")
                {
                    ApplicationArea = FixedAssets;
                    Editable = EditPage;
                    ToolTip = 'Specifies the length of the depreciation period, expressed in years.';
                }
                field("Depreciation Ending Date"; Rec."Depreciation Ending Date")
                {
                    ApplicationArea = FixedAssets;
                    Editable = EditPage;
                    ToolTip = 'Specifies the date on which depreciation of the fixed asset ends.';
                }
                field("No. of Depreciation Months"; Rec."No. of Depreciation Months")
                {
                    ApplicationArea = FixedAssets;
                    Editable = EditPage;
                    ToolTip = 'Specifies the length of the depreciation period, expressed in months.';
                    Visible = true;
                }
                field("Book Value"; Rec."Book Value")
                {
                    ApplicationArea = FixedAssets;
                    Editable = false;
                    ToolTip = 'Specifies the book value for the fixed asset as a FlowField.';

                    trigger OnDrillDown();
                    var
                        FALedgEntry: Record "FA Ledger Entry";
                    begin
                        IF Rec."Disposal Date" > 0D THEN
                            Rec.ShowBookValueAfterDisposal()
                        else BEGIN
                            Rec.SetBookValueFiltersOnFALedgerEntry(FALedgEntry);
                            PAGE.RUN(0, FALedgEntry);
                        end;
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Depr. Book")
            {
                Caption = '&Depr. Book';
                //Image = DepreciationsBooks;

                // BC Upgrade MISHRS14 >>
                // Changed DepreciationsBooks to DepreciationBook to remove warning
                Image = DepreciationBooks;
                // BC Upgrade MISHRS14 <<

                action("Ledger E&ntries")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Ledger E&ntries';
                    Image = CustomerLedger;
                    ToolTip = 'View the ledger entries for the fixed asset.';

                    trigger OnAction();
                    begin
                        ShowFALedgEntries();
                    end;
                }
                action("Error Ledger Entries")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Error Ledger Entries';
                    Image = ErrorFALedgerEntries;
                    ToolTip = 'View the entries that have been posted as a result of you using the Cancel function to cancel an entry.';

                    trigger OnAction();
                    begin
                        ShowFAErrorLedgEntries();
                    end;
                }
                action("Maintenance Ledger Entries")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Maintenance Ledger Entries';
                    Image = MaintenanceLedgerEntries;
                    ToolTip = 'View the maintenance ledger entries for the fixed asset.';

                    trigger OnAction();
                    begin
                        ShowMaintenanceLedgEntries();
                    end;
                }
                action(Statistics)
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Statistics';
                    Image = Statistics;
                    // Promoted = true;
                    // PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ToolTip = 'View detailed historical information about the fixed asset.';

                    trigger OnAction();
                    begin
                        ShowStatistics();
                    end;
                }
                action("Main &Asset Statistics")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Main &Asset Statistics';
                    Image = StatisticsDocument;
                    ToolTip = '"View statistics for all the components that make up the main asset for the selected book. "';

                    trigger OnAction();
                    begin
                        ShowMainAssetStatistics();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        Rec.UpdateBookValue();
    end;

    trigger OnOpenPage();
    begin
        EditPage := AllowChangeFa();
    end;

    var
        FADeprBook: Record "FA Depreciation Book";
        FALedgEntry: Record "FA Ledger Entry";
        GLSetup: Record "General Ledger Setup";
        MaintenanceLedgEntry: Record "Maintenance Ledger Entry";
        DepreciationCalc: Codeunit "Depreciation Calculation";
        ChangeExchangeRate: Page "Change Exchange Rate";
        AddCurrCodeIsFound: Boolean;
        EditPage: Boolean;

    local procedure GetAddCurrCode(): Code[10];
    begin
        IF NOT AddCurrCodeIsFound THEN
            GLSetup.GET();
        EXIT(GLSetup."Additional Reporting Currency");
    end;

    local procedure ShowFALedgEntries();
    begin
        DepreciationCalc.SetFAFilter(FALedgEntry, Rec."FA No.", Rec."Depreciation Book Code", FALSE);
        PAGE.RUN(PAGE::"FA Ledger Entries", FALedgEntry);
    end;

    local procedure ShowFAErrorLedgEntries();
    begin
        FALedgEntry.RESET();
        FALedgEntry.SETCURRENTKEY(FALedgEntry."Canceled from FA No.");
        FALedgEntry.SETRANGE(FALedgEntry."Canceled from FA No.", Rec."FA No.");
        FALedgEntry.SETRANGE(FALedgEntry."Depreciation Book Code", Rec."Depreciation Book Code");
        PAGE.RUN(PAGE::"FA Error Ledger Entries", FALedgEntry);
    end;

    local procedure ShowMaintenanceLedgEntries();
    begin
        MaintenanceLedgEntry.SETCURRENTKEY(MaintenanceLedgEntry."FA No.", MaintenanceLedgEntry."Depreciation Book Code");
        MaintenanceLedgEntry.SETRANGE(MaintenanceLedgEntry."FA No.", Rec."FA No.");
        MaintenanceLedgEntry.SETRANGE(MaintenanceLedgEntry."Depreciation Book Code", Rec."Depreciation Book Code");
        PAGE.RUN(PAGE::"Maintenance Ledger Entries", MaintenanceLedgEntry);
    end;

    local procedure ShowStatistics();
    begin
        FADeprBook.SETRANGE(FADeprBook."FA No.", Rec."FA No.");
        FADeprBook.SETRANGE(FADeprBook."Depreciation Book Code", Rec."Depreciation Book Code");
        PAGE.RUN(PAGE::"Fixed Asset Statistics", FADeprBook);
    end;

    local procedure ShowMainAssetStatistics();
    begin
        FADeprBook.SETRANGE(FADeprBook."FA No.", Rec."FA No.");
        FADeprBook.SETRANGE(FADeprBook."Depreciation Book Code", Rec."Depreciation Book Code");
        PAGE.RUN(PAGE::"Main Asset Statistics", FADeprBook);
    end;

    local procedure AllowChangeFa(): Boolean;
    var
        UserSetup: Record "User Setup";
    begin
        IF UserSetup.GET(USERID) THEN BEGIN
            EXIT(UserSetup."Allow Change FA FND");
        end else BEGIN
            EXIT(FALSE);
        end;
    end;
}

