page 51023 "Fixed Asset List 1 CBN"
{
    // version NAVW110.0,FINXL9.00.000.01,DITW110.00.08,HEI.03

    // DITW15.00.00.35 DDR 01/09/2009 Added fields
    //                                  "Created by Service Item No.","Description 2","FA Template Code",
    //                                  "Exist Service Items"
    //                                Added 'Service Item List' menu into 'Fixed Asset' button
    // DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327 Added fields  "DIT Contract No.","Customer No."
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename Field  "DIT Contract No." => Financial Contract No.
    // FINXL9.00.001 DAT 07/03/2016 : Extend Master Property functionalities
    // DITW18.00.07 AKH 22/03/2016 DIT-770 #1805 Merge FINXL extended master data properties
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // 
    // HEI.01 FDD RTRGAP057 IBM HORTOC01 27.07.2017
    //   # New page based on standard page fixet asset list
    // 
    // HEI.02 FDD RTRGAP057 IBM POENAB01 08.08.2017
    //   # Changed page caption to "Fixed Assets Indicator"
    //   # New fields added to the page:"FA Class Code", "FA Subclass Code", "Location Code", "Responsible Employee",
    //       "FA Posting Group", "Depreciation Starting Date"
    // HEI.03 DefectID 742 IBM HORTOC01 27.10.2017
    //   # check Fa. Indicator when getting a new record
    // BC Upgrade BHARDA11 ---- Whenever the base report “Copy Fixed Asset” is run, the report “Copy Fixed Asset 2” will be executed instead, as it has been configured in the OnSubstituteReport event. This substitution was required due to existing customizations in the base report.
    // BC Upgrade BHARDA11 >>
    // 1. Standard report "Fixed Asset - Book Value 01" is substituted via OnAfterSubstituteReport event.Custom report "Fixed Asset - Book Value 01New" will run instead.
    // 2. Standard report "Fixed Asset - Book Value 02" is substituted via OnAfterSubstituteReport event.Custom report "Fixed Asset - Book Value 02New" will run instead.
    // BC Upgrade BHARDA11 <<
    //Bc upgrade YADAVM09 BCUP0-200 On action calculate Depriciation Custom Report is added.
    Caption = 'Fixed Assets Indicator';
    CardPageID = "Fixed Asset Card 1 CBN";
    Editable = false;
    PageType = List;
    SourceTable = "Fixed Asset";
    ApplicationArea = All;  // BC Upgrade KAPOOV01
    UsageCategory = Lists;  // BC Upgrade KAPOOV01

    layout
    {
        area(content)
        {
            repeater(Control1)//BC Upgrade KAPOOV01 added Control1 keyword inside brackets.
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies a number for the fixed asset.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies a description of the fixed asset.';
                }
                field("Asset Indicator"; Rec."Asset Indicator FND")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Asset Indicator field.';
                }
                field("FA Class Code"; Rec."FA Class Code")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the class that the fixed asset belongs to.';
                }
                field("FA Subclass Code"; Rec."FA Subclass Code")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the subclass of the class that the fixed asset belongs to.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Responsible Employee"; Rec."Responsible Employee")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies which employee is responsible for the fixed asset.';
                }
                field("FA Posting Group"; Rec."FA Posting Group")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the FA Posting Group field.';
                }
                // field("Depreciation Starting Date"; "Depreciation Starting Date")
                // {
                // }//BC Upgrade KAPOOV01 Drink-it
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)//BC Upgrade KAPOOV01 added Links keyword inside brackets.
            {
                Visible = false;
            }
            systempart(Notes; Notes)//BC Upgrade KAPOOV01 added Notes keyword inside brackets.
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
                    RunObject = Page "FA Depreciation Books";//BC Upgrade KAPOOV01
                    RunPageLink = "FA No." = FIELD("No.");//BC Upgrade KAPOOV01
                    ToolTip = 'View or edit the depreciation book or books that must be used for each of the fixed assets. Here you also specify the way depreciation must be calculated.';
                }
                action(Statistics)
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Fixed Asset Statistics";//BC Upgrade KAPOOV01
                    RunPageLink = "FA No." = FIELD("No.");//BC Upgrade KAPOOV01
                    ShortCutKey = 'F7';
                    ToolTip = 'View detailed historical information about the fixed asset.';
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    action("Dimensions-Single")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Dimensions-Single';
                        Image = Dimensions;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Default Dimensions";//BC Upgrade KAPOOV01
                        RunPageLink = "Table ID" = CONST(5600),//BC Upgrade KAPOOV01
                                      "No." = FIELD("No.");//BC Upgrade KAPOOV01
                        ShortCutKey = 'Shift+Ctrl+D';
                        ToolTip = 'View or edit the single set of dimensions that are set up for the selected record.';
                    }
                    action("Dimensions-&Multiple")
                    {
                        AccessByPermission = TableData 348 = R;
                        ApplicationArea = Suite;
                        Caption = 'Dimensions-&Multiple';
                        Image = DimensionSets;
                        Promoted = true;
                        PromotedCategory = Process;
                        ToolTip = 'View or edit dimensions for a group of records. You can assign dimension codes to transactions to distribute costs and analyze historical information.';

                        trigger OnAction();
                        var
                            FA: Record "Fixed Asset";//BC Upgrade KAPOOV01
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";//BC Upgrade KAPOOV01
                        begin
                            CurrPage.SETSELECTIONFILTER(FA);
                            DefaultDimMultiple.SetMultiRecord(FA, Rec.FieldNo("No."));//BC Upgrade SHUKLPO3 << SetMultiFA function is not found in base page because function name is changed to SetMultiRecord().
                            DefaultDimMultiple.RUNMODAL();
                        end;
                    }
                }
                action("Main&tenance Ledger Entries")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Main&tenance Ledger Entries';
                    Image = MaintenanceLedgerEntries;
                    RunObject = Page 5641;
                    RunPageLink = "FA No." = FIELD("No.");//BC Upgrade KAPOOV01
                    RunPageView = sorting("FA No.");//BC Upgrade KAPOOV01
                    ToolTip = '"View all the maintenance ledger entries for a fixed asset. "';
                }
                action(Picture)
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Picture';
                    Image = Picture;
                    RunObject = Page 5620;
                    RunPageLink = "No." = FIELD("No.");//BC Upgrade KAPOOV01
                    ToolTip = 'Add or view a picture of the fixed asset.';
                }
                action("FA Posting Types Overview")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'FA Posting Types Overview';
                    Image = ShowMatrix;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 5662;
                    ToolTip = 'View accumulated amounts for each field, such as book value, acquisition cost, and depreciation, and for each fixed asset. For every fixed asset, a separate line is shown for each depreciation book linked to the asset.';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 124;
                    RunPageLink = "Table Name" = CONST("Fixed Asset"),//BC Upgrade KAPOOV01
                                  "No." = FIELD("No.");
                    ToolTip = 'Executes the Co&mments action.';
                    //BC Upgrade KAPOOV01                    ToolTip = 'Executes the Co&mments action.';

                }
                action(Properties)
                {
                    Caption = 'Properties';
                    Description = 'FINXL9.00';
                    Image = Category;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Properties action.';
                    // RunObject = Page 2029637;
                    // RunPageLink = Table ID=CONST(5600),
                    //               Code=FIELD(No.);//BC Upgrade KAPOOV01 Drink-it
                }
            }
            group("Main Asset")
            {
                Caption = 'Main Asset';
                Image = Components;
                action("M&ain Asset Components")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'M&ain Asset Components';
                    Image = Components;
                    RunObject = Page 5658;
                    RunPageLink = "Main Asset No." = FIELD("No.");//BC Upgrade KAPOOV01
                    ToolTip = 'View or edit fixed asset components of the main fixed asset that is represented by the fixed asset card.';
                }
                action("Ma&in Asset Statistics")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Ma&in Asset Statistics';
                    Image = StatisticsDocument;
                    RunObject = Page 5603;
                    RunPageLink = "FA No." = FIELD("No.");//BC Upgrade KAPOOV01
                    ToolTip = 'View detailed historical information about all the components that make up the main asset.';
                }
                // separator()
                // {
                // }
                action(separator)
                {
                    Caption = '';
                    ToolTip = 'Executes the separator action.';
                }//BC Upgrade KAPOOV01
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
                    RunObject = Page 5604;
                    RunPageLink = "FA No." = FIELD("No.");//BC Upgrade KAPOOV01
                    RunPageView = sorting("FA No.")//BC Upgrade KAPOOV01
                                  ORDER(Descending);
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View detailed information about transactions made for the fixed asset.';
                }
                action("Error Ledger Entries")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Error Ledger Entries';
                    Image = ErrorFALedgerEntries;
                    RunObject = Page 5605;
                    RunPageLink = "Canceled from FA No." = FIELD("No.");//BC Upgrade KAPOOV01
                    RunPageView = sorting("Canceled from FA No.")//BC Upgrade KAPOOV01
                                  ORDER(Descending);
                    ToolTip = 'View the entries that have been posted as a result of you using the Cancel function to cancel an entry.';
                }
                action("Maintenance &Registration")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Maintenance &Registration';
                    Image = MaintenanceRegistrations;
                    RunObject = Page 5625;
                    RunPageLink = "FA No." = FIELD("No.");//BC Upgrade KAPOOV01
                    ToolTip = 'View or edit maintenance codes for the various types of maintenance, repairs, and services performed on your fixed assets. You can then enter the code in the Maintenance Code field on journals.';
                }
                // separator()
                // {
                // }
                action("Service Item List")
                {
                    Caption = 'Service Item List';
                    Image = ServiceAgreement;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 5981;
                    ToolTip = 'Executes the Service Item List action.';
                    //RunPageLink = FA No.=FIELD(No.);//BC Upgrade KAPOOV01 Drink-it
                }
            }
        }
        area(processing)
        {
            action("Fixed Asset Journal")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Fixed Asset Journal';
                Image = Journal;
                RunObject = Page 5629;
                ToolTip = '"Post fixed asset transactions with a depreciation book that is not integrated with the general ledger, for internal management. Only fixed asset ledger entries are created. "';
            }
            action("Fixed Asset G/L Journal")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Fixed Asset G/L Journal';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 5628;
                ToolTip = '"Post fixed asset transactions with a depreciation book that is integrated with the general ledger, for financial reporting. Both fixed asset ledger entries are general ledger entries are created. "';
            }
            action("Fixed Asset Reclassification Journal")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Fixed Asset Reclassification Journal';
                Image = Journal;
                RunObject = Page 5636;
                ToolTip = 'Transfer, split, or combine fixed assets.';
            }
            action("Recurring Fixed Asset Journal")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Recurring Fixed Asset Journal';
                Image = Journal;
                RunObject = Page 5634;
                ToolTip = 'Post recurring entries to a depreciation book without integration with general ledger.';
            }
            action(CalculateDepreciation)
            {
                ApplicationArea = FixedAssets;
                Caption = 'Calculate Depreciation';
                Ellipsis = true;
                Image = CalculateDepreciation;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Calculate depreciation according to conditions that you specify. If the related depreciation book is set up to integrate with the general ledger, then the calculated entries are transferred to the fixed asset general ledger journal. Otherwise, the calculated entries are transferred to the fixed asset journal. You can then review the entries and post the journal.';

                trigger OnAction();
                begin
                    REPORT.RUNMODAL(REPORT::"Calculate Depreciation-RtR", TRUE, FALSE, Rec);//Bc Upgrade YADAVM09 BCUP0-200<<
                end;
            }
            action("C&opy Fixed Asset")
            {
                ApplicationArea = FixedAssets;
                Caption = 'C&opy Fixed Asset';
                Ellipsis = true;
                Image = CopyFixedAssets;
                ToolTip = 'Create one or more new fixed assets by copying from an existing fixed asset that has similar information.';

                trigger OnAction();
                var
                    CopyFA: Report "Copy Fixed Asset";//BC Upgrade KAPOOV01
                begin
                    // BC Upgrade BHARDA11 ---- Whenever the base report “Copy Fixed Asset” is run, the report “Copy Fixed Asset 2” will be executed instead, as it has been configured in the OnSubstituteReport event. This substitution was required due to existing customizations in the base report.
                    CopyFA.SetFANo(Rec."No.");
                    CopyFA.RUNMODAL();
                end;
            }
        }
        area(reporting)
        {
            action("Fixed Assets List")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Fixed Assets List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 5601;
                ToolTip = 'View the list of fixed assets that exist in the system .';
            }
            action("Acquisition List")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Acquisition List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 5608;
                ToolTip = 'View the related acquisitions.';
            }
            action(Details)
            {
                ApplicationArea = FixedAssets;
                Caption = 'Details';
                Image = View;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 5604;
                ToolTip = 'View detailed information about the fixed asset ledger entries that have been posted to a specified depreciation book for each fixed asset.';
            }
            action("FA Book Value")
            {
                ApplicationArea = FixedAssets;
                Caption = 'FA Book Value';
                Image = "Report";
                RunObject = Report 5605;
                ToolTip = 'View detailed information about acquisition cost, depreciation and book value for both individual assets and groups of assets. For each of these three amount types, amounts are calculated at the beginning and at the end of a specified period as well as for the period itself.';
            }
            action("FA Book Val. - Appr. & Write-D")
            {
                ApplicationArea = FixedAssets;
                Caption = 'FA Book Val. - Appr. & Write-D';
                Image = "Report";
                RunObject = Report 5606;
                ToolTip = 'View detailed information about acquisition cost, depreciation, appreciation, write-down and book value for both individual assets and groups of assets. For each of these categories, amounts are calculated at the beginning and at the end of a specified period, as well as for the period itself.';
            }
            action(Analysis)
            {
                ApplicationArea = FixedAssets;
                Caption = 'Analysis';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 5600;
                ToolTip = 'View an analysis of your fixed assets with various types of data for both individual assets and groups of fixed assets.';
            }
            action("Projected Value")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Projected Value';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 5607;
                ToolTip = 'View the calculated future depreciation and book value. You can print the report for one depreciation book at a time.';
            }
            action("G/L Analysis")
            {
                ApplicationArea = FixedAssets;
                Caption = 'G/L Analysis';
                Image = "Report";
                RunObject = Report 5610;
                ToolTip = 'View an analysis of your fixed assets with various types of data for individual assets and/or groups of fixed assets.';
            }
            action(Register)
            {
                ApplicationArea = FixedAssets;
                Caption = 'Register';
                Image = Confirm;
                RunObject = Report 5603;
                ToolTip = 'View registers containing all the fixed asset entries that are created. Each register shows the first and last entry number of its entries.';
            }
        }
    }

    trigger OnAfterGetRecord();
    var
    //FinancialUtils: Codeunit "50012";//BC Upgrade KAPOOV01
    begin
    end;

    trigger OnOpenPage();
    begin
        Rec.FILTERGROUP(2);

        Rec.SETFILTER("Asset Indicator FND", '%1|%2', Rec."Asset Indicator FND"::"1", Rec."Asset Indicator FND"::"2");
        Rec.FILTERGROUP(0);
    end;

    var
        AllowEditPage: Boolean;
}

