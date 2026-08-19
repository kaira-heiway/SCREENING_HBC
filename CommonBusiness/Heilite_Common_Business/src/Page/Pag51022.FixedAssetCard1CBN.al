page 51022 "Fixed Asset Card 1 CBN"
{
    // version NAVW110.0,FINXL9.00.000.01,DITW110.00.08,HEI.01

    // DITW15.00.00.35 DDR 24/04/2009 Added 'Drink-It' tab
    //                                Added field "FA Template Code" into 'Drink-It' tab
    //                     31/08/2009 Added fields into 'Drink-It' tab
    //                                  "Depreciation Starting Date","Exist Service Items","Fixed Asset on Inventory"
    //                                Added fields "Description 2" into 'General' tab
    //                                Added 'Service Item List' menu into 'Fixed Asset' button
    //                                Added standard field 9 "Location Code"  !! (never used in Standard Navision)
    //                                  indicate a real location for Drink-it field "Fixed Asset on Inventory"
    // DITW15.00.00.39 DDR 14/07/2011 issue 1258 Added fields "Item No. (Service Item)" into 'Drink-It' tab
    // DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327 Added fields  "DIT Contract No.","Customer No."
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename Field  "DIT Contract No." => Financial Contract No.
    // FINXL9.00.001 DAT 07/03/2016 : Extend Master Property functionalities
    // DITW18.00.07 AKH 22/03/2016 DIT-770 #1805 Merge FINXL extended master data properties
    // DITW19.00.08 SFI 18/08/2016 BL#10868  (DIT-770 #2141) Added field 2014411 "Allow Invoice Disc." to Group "Drink-IT"
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // 
    // HEI.01 FDD RTRGAP057 IBM HORTOC01 27.07.2017
    //   # New page based on standard page Fixet asset
    // BC Upgrade BHARDA11 ---- Whenever the base report “Copy Fixed Asset” is run, the report “Copy Fixed Asset 2” will be executed instead, as it has been configured in the OnSubstituteReport event. This substitution was required due to existing customizations in the base report.
    // BC Upgrade BHARDA11 >>
    // 1. Standard report "Fixed Asset - Book Value 01" is substituted via OnAfterSubstituteReport event.Custom report "Fixed Asset - Book Value 01New" will run instead.
    // 2. Standard report "Fixed Asset - Book Value 02" is substituted via OnAfterSubstituteReport event.Custom report "Fixed Asset - Book Value 02New" will run instead.
    // BC Upgrade BHARDA11 <<
    Caption = 'Fixed Asset Card';
    PageType = Document;
    Permissions = TableData "FA Depreciation Book" = rim;
    RefreshOnActivate = true;
    SourceTable = "Fixed Asset";
    ApplicationArea = ALL;
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = ALL;
                    Editable = EditPage;
                    Importance = Promoted;
                    ToolTip = 'Specifies a number for the fixed asset.';
                    Visible = DocNoVisible;

                    trigger OnAssistEdit();
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;

                    trigger OnValidate();
                    begin
                        ShowAcquireNotification()
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = ALL;
                    Editable = EditPage;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies a description of the fixed asset.';

                    trigger OnValidate();
                    begin
                        ShowAcquireNotification()
                    end;
                }
                field("Description 2"; Rec."Description 2")
                {
                    Editable = EditPage;
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Description 2 field.';
                }
                field("FA Class Code"; Rec."FA Class Code")
                {
                    Editable = EditPage;
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the class that the fixed asset belongs to.';
                }
                field("FA Subclass Code"; Rec."FA Subclass Code")
                {
                    Editable = EditPage;
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the subclass of the class that the fixed asset belongs to.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = EditPage;
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Responsible Employee"; Rec."Responsible Employee")
                {
                    Editable = EditPage;
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies which employee is responsible for the fixed asset.';
                }
                field("FA Posting Group"; Rec."FA Posting Group")
                {
                    Editable = EditPage;
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the FA Posting Group field.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    Editable = EditPage;
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the number of the vendor from which you purchased this fixed asset.';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    Editable = EditPage;
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the fixed asset''s serial number.';
                }
                field("Asset Indicator"; Rec."Asset Indicator FND")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Asset Indicator field.';
                }
            }
            part(DepreciationBook; "FA Dep Books Subform1 CBN")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Depreciation Books';
                SubPageLink = "FA No." = FIELD("No.");
                Visible = NOT Simple;
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Fixed &Asset")
            {
                Caption = 'Fixed &Asset';
                Image = FixedAssets;
                action("Depreciation &Books")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Depreciation &Books';
                    Image = DepreciationBooks;
                    RunObject = Page "FA Depreciation Books";
                    RunPageLink = "FA No." = FIELD("No.");
                    ToolTip = 'View or edit the depreciation book or books that must be used for each of the fixed assets. Here you also specify the way depreciation must be calculated.';
                }
                action(Statistics)
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Fixed Asset Statistics";
                    RunPageLink = "FA No." = FIELD("No.");
                    ShortCutKey = 'F7';
                    ToolTip = 'View detailed historical information about the fixed asset.';
                }
                action(Dimensions)
                {
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(5600),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
                action("Maintenance &Registration")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Maintenance &Registration';
                    Image = MaintenanceRegistrations;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Maintenance Registration";
                    RunPageLink = "FA No." = FIELD("No.");
                    ToolTip = 'View or edit maintenance codes for the various types of maintenance, repairs, and services performed on your fixed assets. You can then enter the code in the Maintenance Code field on journals.';
                }
                action(Picture)
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Picture';
                    Image = Picture;
                    RunObject = Page "Fixed Asset Picture";
                    RunPageLink = "No." = FIELD("No.");
                    ToolTip = 'Add or view a picture of the fixed asset.';
                }
                action("FA Posting Types Overview")
                {
                    Caption = 'FA Posting Types Overview';
                    Image = ShowMatrix;
                    RunObject = Page "FA Posting Types Overview";
                    ToolTip = 'View accumulated amounts for each field, such as book value, acquisition cost, and depreciation, and for each fixed asset. For every fixed asset, a separate line is shown for each depreciation book linked to the asset.';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Fixed Asset"),
                                  "No." = FIELD("No.");
                    ToolTip = 'Executes the Co&mments action.';
                }
                action(Properties)
                {
                    Caption = 'Properties';
                    Description = 'FINXL9.00';
                    Image = Category;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Properties action.';
                    //BC Upgrade KAPOOV01 Drink-it>>
                    // RunObject = Page "Master Data Properties";
                    // RunPageLink = "Table ID" = CONST(5600),
                    //               Code = FIELD("No.");
                    //BC Upgrade KAPOOV01 Drink-it<<
                }
            }
            group("Main Asset")
            {
                Caption = 'Main Asset';
                action("M&ain Asset Components")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'M&ain Asset Components';
                    Image = Components;
                    RunObject = Page "Main Asset Components";
                    RunPageLink = "Main Asset No." = FIELD("No.");
                    ToolTip = 'View or edit fixed asset components of the main fixed asset that is represented by the fixed asset card.';
                }
                action("Ma&in Asset Statistics")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Ma&in Asset Statistics';
                    Image = StatisticsDocument;
                    RunObject = Page "Main Asset Statistics";
                    RunPageLink = "FA No." = FIELD("No.");
                    ToolTip = 'View detailed historical information about the fixed asset.';
                }
                separator(Separator39)
                {
                    Caption = '""';
                }
            }
            group(Insurance)
            {
                Caption = 'Insurance';
                Image = TotalValueInsured;
                action("Total Value Ins&ured")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Total Value Ins&ured';
                    Image = TotalValueInsured;
                    RunObject = Page "Total Value Insured";
                    RunPageLink = "No." = FIELD("No.");
                    ToolTip = 'View the amounts that you posted to each insurance policy for the fixed asset. The amounts shown can be more or less than the actual insurance policy coverage. The amounts shown can differ from the actual book value of the asset.';
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                action("Ledger E&ntries")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Ledger E&ntries';
                    Image = FixedAssetLedger;
                    RunObject = Page "FA Ledger Entries";
                    RunPageLink = "FA No." = FIELD("No.");
                    RunPageView = sorting("FA No.")
                                  ORDER(Descending);
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View detailed information about transactions made for the fixed asset.';
                }
                action("Error Ledger Entries")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Error Ledger Entries';
                    Image = ErrorFALedgerEntries;
                    RunObject = Page "FA Error Ledger Entries";
                    RunPageLink = "Canceled from FA No." = FIELD("No.");
                    RunPageView = sorting("Canceled from FA No.")
                                  ORDER(Descending);
                    ToolTip = 'View the entries that have been posted as a result of you using the Cancel function to cancel an entry.';
                }
                action("Main&tenance Ledger Entries")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Main&tenance Ledger Entries';
                    Image = MaintenanceLedgerEntries;
                    RunObject = Page "Maintenance Ledger Entries";
                    RunPageLink = "FA No." = FIELD("No.");
                    RunPageView = sorting("FA No.");
                    ToolTip = 'View all the maintenance ledger entries for a fixed asset.';
                }
                separator(Separator1100083008)
                {
                }
                action("Service Item List")
                {
                    Caption = 'Service Item List';
                    Image = ServiceAgreement;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Service Item List";
                    ToolTip = 'Executes the Service Item List action.';
                    //RunPageLink = "FA No." = FIELD("No.");//BC Upgrade KAPOOV01 Drink-it
                }
            }
        }
        area(processing)
        {
            action(Acquire)
            {
                ApplicationArea = FixedAssets;
                Caption = 'Acquire';
                Enabled = Acquirable;
                Image = ValidateEmailLoggingSetup;
                RunPageMode = Create;
                ToolTip = 'Acquire the fixed asset.';

                trigger OnAction();
                var
                    FixedAssetAcquisitionWizard: Codeunit "Fixed Asset Acquisition Wizard";
                begin
                    FixedAssetAcquisitionWizard.RunAcquisitionWizard(Rec."No.");
                end;
            }
            action("C&opy Fixed Asset")
            {
                ApplicationArea = FixedAssets;
                Caption = 'C&opy Fixed Asset';
                Ellipsis = true;
                Image = CopyFixedAssets;
                ToolTip = 'View or edit fixed asset components of the main fixed asset that is represented by the fixed asset card.';

                trigger OnAction();
                var
                    CopyFA: Report "Copy Fixed Asset";
                begin
                    // BC Upgrade BHARDA11 ---- Whenever the base report “Copy Fixed Asset” is run, the report “Copy Fixed Asset 2” will be executed instead, as it has been configured in the OnSubstituteReport event. This substitution was required due to existing customizations in the base report.
                    CopyFA.SetFANo(Rec."No.");
                    CopyFA.RUNMODAL();
                end;
            }
        }
        area(reporting)
        {
            action(Details)
            {
                ApplicationArea = FixedAssets;
                Caption = 'Details';
                Image = View;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Fixed Asset - Details";
                ToolTip = 'View detailed information about the fixed asset ledger entries that have been posted to a specified depreciation book for each fixed asset.';
            }
            action("FA Book Value")
            {
                ApplicationArea = FixedAssets;
                Caption = 'FA Book Value';
                Image = "Report";
                RunObject = Report "Fixed Asset - Book Value 01";
                ToolTip = 'View detailed information about acquisition cost, depreciation and book value for both individual fixed assets and groups of fixed assets. For each of these three amount types, amounts are calculated at the beginning and at the end of a specified period as well as for the period itself.';
            }
            action("FA Book Val. - Appr. & Write-D")
            {
                ApplicationArea = FixedAssets;
                Caption = 'FA Book Val. - Appr. & Write-D';
                Image = "Report";
                RunObject = Report "Fixed Asset - Book Value 02";
                ToolTip = 'View detailed information about acquisition cost, depreciation, appreciation, write-down and book value for both individual fixed assets and groups of fixed assets. For each of these categories, amounts are calculated at the beginning and at the end of a specified period, as well as for the period itself.';
            }
            action(Analysis)
            {
                ApplicationArea = FixedAssets;
                Caption = 'Analysis';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Fixed Asset - Analysis";
                ToolTip = 'View an analysis of your fixed assets with various types of data for both individual fixed assets and groups of fixed assets.';
            }
            action("Projected Value")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Projected Value';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Fixed Asset - Projected Value";
                ToolTip = 'View the calculated future depreciation and book value. You can print the report for one depreciation book at a time.';
            }
            action("G/L Analysis")
            {
                ApplicationArea = FixedAssets;
                Caption = 'G/L Analysis';
                Image = "Report";
                RunObject = Report "Fixed Asset - G/L Analysis";
                ToolTip = 'View an analysis of your fixed assets with various types of data for individual fixed assets and/or groups of fixed assets.';
            }
            action(Register)
            {
                ApplicationArea = FixedAssets;
                Caption = 'Register';
                Image = Confirm;
                RunObject = Report "Fixed Asset Register";
                ToolTip = 'View registers containing all the fixed asset entries that are created. Each register shows the first and last entry number of its entries.';
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        if Rec."No." <> xRec."No." then
            SaveSimpleDepriciationBook(xRec."No.");

        LoadDepreciationBooks();
        // CurrPage.UPDATE(false); //#BCUP0-25 BC Upgrade KAIRAR01
        FADepreciationBook.COPY(FADepreciationBookOld);
        ShowAcquireNotification();
        FADepreciationBook.UpdateBookValue();
    end;

    trigger OnClosePage();
    begin
        //HEI.01>>
        //FinancialUtils.ChangeFaIndicator(Rec);//BC Upgrade KAPOOV01 Codeunit
        // CurrPage.SAVERECORD();
        // CurrPage.UPDATE(true);  //#BCUP0-25 BC Upgrade KAIRAR01 -BC auto-refreshes & auto-saves
        //HEI.01<<
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        // << DITW19.00.08 SFI 18/08/2016 BL#10868
        //SetupNewRec();//BC Upgrade KAPOOV01 Drink-it
        // >> DITW19.00.08 SFI 18/08/2016
    end;

    trigger OnOpenPage();
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        Simple := true;
        DocNoVisible := DocumentNoVisibility.FixedAssetNoIsVisible();

        //EditPage := AllowChangeFa

        EditPage := true;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        SaveSimpleDepriciationBook(Rec."No.");
    end;

    var
        FADepreciationBook: Record "FA Depreciation Book";
        FADepreciationBookOld: Record "FA Depreciation Book";
        Acquirable: Boolean;
        DocNoVisible: Boolean;
        EditPage: Boolean;
        ShowAddMoreDeprBooksLbl: Boolean;
        Simple: Boolean;
        FAAcquireWizardNotificationId: Guid;
        AddMoreDeprBooksLbl: Label 'Add More Depreciation Books';
    //FinancialUtils: Codeunit "Financial-Utils";//BC Upgrade KAPOOV01 Codeunit

    local procedure ShowAcquireNotification();
    var
        ShowAcquireNotification: Boolean;
    begin
        ShowAcquireNotification :=
          (not Rec.Acquired) and Rec.FieldsForAcquitionInGeneralGroupAreCompleted() and AtLeastOneDepreciationLineIsComplete();
        if ShowAcquireNotification and ISNULLGUID(FAAcquireWizardNotificationId) then begin
            Acquirable := true;
            REC.ShowAcquireWizardNotification();//BC Upgrade SHUKLP03 << Codeunit function ShowAcquireWizardNotification() is not available in Base CD 5550 and moved in Table Fixed Asset.
        end;
    end;

    local procedure AtLeastOneDepreciationLineIsComplete(): Boolean;
    var
        FADepreciationBookMultiline: Record "FA Depreciation Book";
    begin
        if Simple then
            exit(FADepreciationBook.RecIsReadyForAcquisition());

        exit(FADepreciationBookMultiline.LineIsReadyForAcquisition(Rec."No."));
    end;

    local procedure SaveSimpleDepriciationBook(FixedAssetNo: Code[20]);
    var
        FixedAsset: Record "Fixed Asset";
    begin
        if not SimpleDepreciationBookHasChanged() then
            exit;

        if Simple and FixedAsset.GET(FixedAssetNo) then begin
            if FADepreciationBook."Depreciation Book Code" <> '' then
                if FADepreciationBook."FA No." = '' then begin
                    FADepreciationBook.VALIDATE("FA No.", FixedAssetNo);
                    FADepreciationBook.INSERT(true)
                end else
                    FADepreciationBook.MODIFY(true)
        end;
    end;

    local procedure SetDefaultDepreciationBook();
    var
        FASetup: Record "FA Setup";
    begin
        if FADepreciationBook."Depreciation Book Code" = '' then begin
            FASetup.GET();
            FADepreciationBook.VALIDATE("Depreciation Book Code", FASetup."Default Depr. Book");
            SaveSimpleDepriciationBook(Rec."No.");
            LoadDepreciationBooks();
        end;
    end;

    local procedure SetDefaultPostingGroup();
    var
        FASubclass: Record "FA Subclass";
    begin
        if FASubclass.GET(Rec."FA Subclass Code") then;
        FADepreciationBook.VALIDATE("FA Posting Group", FASubclass."Default FA Posting Group");
        SaveSimpleDepriciationBook(Rec."No.");
    end;

    local procedure SimpleDepreciationBookHasChanged(): Boolean;
    begin
        exit(FORMAT(FADepreciationBook) <> FORMAT(FADepreciationBookOld));
    end;

    local procedure LoadDepreciationBooks();
    begin
        CLEAR(FADepreciationBookOld);
        FADepreciationBookOld.SETRANGE("FA No.", Rec."No.");
        if FADepreciationBookOld.COUNT <= 1 then begin
            if FADepreciationBookOld.FINDFIRST() then begin
                FADepreciationBookOld.CALCFIELDS("Book Value");
                ShowAddMoreDeprBooksLbl := true
            end;
            Simple := true;
        end else
            Simple := false;
    end;

    local procedure FATemplateCodeOnAfterValidate();
    begin
        // <<DITW15.00.00.35 DDR 24/04/2009
        CurrPage.UPDATE(true);
    end;

    local procedure AllowChangeFa(): Boolean;
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.GET(USERID) then begin
            exit(UserSetup."Allow Change FA FND");
        end else begin
            exit(false);
        end;
    end;
}

