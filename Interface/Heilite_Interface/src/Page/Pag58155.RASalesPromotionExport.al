page 58155 "RA Sales Promotion Export"
{
    // HEI.01 FDD-LC-HT736 IBM.GUNERE01 02.10.2019 # Object created
    // BC Upgrade SHUKLP03 >> Restructured code according to BC new ways.
    // FIX >> This page is now READ-ONLY against the real, persisted
    //        table. It no longer builds/rebuilds any data itself.
    //        Data is built separately by codeunit 58156
    //        "RA Sales Promotion Export Bld", triggered via codeunit
    //        58157 "RA Sales Promotion Export Trg" (StartRebuild).
    //        This keeps this page's webservice calls fast and immune
    //        to BC's non-configurable 8-10 minute web service timeout,
    //        no matter how large the underlying data volume is.

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTable = "RASalesPromotionExport int";
    SourceTableTemporary = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;

    layout
    {
        area(content)
        {
            repeater(Control55001)
            {
                field(CustomerNo; Rec."Source No.")
                {
                    CaptionML = ENU = 'CustomerNo',
                                FRA = 'Code vente';
                }
                field(ItemNo; Rec."Item No.")
                {
                    CaptionML = ENU = 'ItemNo',
                                FRA = 'N° origine';
                }
                field(FreeItem; Rec."Free Item No.")
                {
                    CaptionML = ENU = 'FreeItemNo',
                                FRA = 'N° article gratuit';
                }
                field(StartDate; Rec."Starting Date")
                {
                    CaptionML = ENU = 'StartDate',
                                FRA = 'Date début';
                }
                field(EndDate; Rec."Ending Date")
                {
                    Caption = 'EndDate';
                }
                field(TierUnitLevel1; Rec."Tier Level 1")
                {
                }
                field(TierUnitLevel2; Rec."Tier Level 2")
                {
                }
                field(TierUnitLevel3; Rec."Tier Level 3")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(RebuildNow)
            {
                ApplicationArea = All;
                Caption = 'Rebuild Now';
                Image = Refresh;
                ToolTip = 'Starts a background rebuild of the promotion export data. Reopen this page in a few minutes to see refreshed data.';
                trigger OnAction()
                begin
                    StartRebuild();
                    Message('Rebuild started in the background. Reopen this page in a few minutes to see refreshed data.');
                end;
            }
        }
    }


    trigger OnOpenPage();
    begin
        StartRebuild();
    end;

    procedure StartRebuild()
    var
        SessionId: Integer;
    begin
        Session.StartSession(SessionId, Codeunit::"RA Sales Promotion Export Bld", CompanyName());
    end;

    // Public (non-local) procedure -> callable directly via this page's
    // own SOAP web service endpoint, alongside the standard CRUD calls,
    // so no separate codeunit web service is needed. Starts the build
    // in a background session and returns immediately -- safe from the
    // 8-10 minute web service timeout regardless of data volume.
    // procedure StartRebuild(): Boolean
    // var
    //     ExportTrigger: Codeunit "RA Sales Promotion Export Trg";
    // begin
    //     exit(ExportTrigger.StartRebuild());
    // end;

}
