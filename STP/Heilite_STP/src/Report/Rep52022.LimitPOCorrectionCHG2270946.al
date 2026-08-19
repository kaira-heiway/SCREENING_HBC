report 52022 "Limit PO Correction CHG2270946"
{
    // version HEI.01

    // #HEI.01 CHG2270946 SHARMP16 30.09.2024 Limit PO Remaining Amount Issue
    //         #Create new report to rectify Limit PO cases.

    //BC Upgrade KAPOOV01  >>
    // 1. Add ApplicationArea and UsageCategory property in Report.
    // 2. Old Report ID- 50603.
    //BC Upgrade KAPOOV01  <<

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = WHERE("Document Type" = FILTER(Order));
            RequestFilterFields = "Document Type", "No.";

            trigger OnAfterGetRecord();
            begin
                //#HEI.01>>
                CLEAR(Statusvaroption);
                if RectifyRec then begin
                    Statusvaroption := "Purchase Header".Status;
                    "Purchase Header".Status := "Purchase Header".Status::Open;
                    "Purchase Header".MODIFY();
                end;
                PurchaseHeaderAdditional.GET("Purchase Header"."Document Type", "Purchase Header"."No.");
                if PurchaseHeaderAdditional."Limit PO" then begin
                    OrignalPL.RESET();
                    OrignalPL.SETRANGE("Document Type", "Purchase Header"."Document Type"::Order);
                    OrignalPL.SETRANGE("Document No.", "Purchase Header"."No.");
                    OrignalPL.SETFILTER("SRM Order Line No. FND", '<>%1', '');
                    if OrignalPL.FINDFIRST() then begin
                        repeat
                            if OrignalPL."Outstanding Qty. (Base)" = 0 then begin
                                ChildPL.RESET();
                                ChildPL.SETRANGE("Document Type", "Purchase Header"."Document Type"::Order);
                                ChildPL.SETRANGE("Document No.", "Purchase Header"."No.");
                                ChildPL.SETRANGE("Additional Description FND", OrignalPL."SRM Order Line No. FND");
                                ChildPL.SETFILTER(ChildPL."Outstanding Qty. (Base)", '<>%1', 0);
                                if ChildPL.FINDLAST() then begin
                                    CLEAR(Deletevar);
                                    PurchaseLine1.RESET();
                                    PurchaseLine1.SETRANGE("Document Type", "Purchase Header"."Document Type"::Order);
                                    PurchaseLine1.SETRANGE("Document No.", "Purchase Header"."No.");
                                    PurchaseLine1.SETFILTER("Line No.", '<%1', ChildPL."Line No.");
                                    PurchaseLine1.SETFILTER("Outstanding Qty. (Base)", '<>%1', 0);
                                    PurchaseLine1.SETRANGE("Additional Description FND", ChildPL."Additional Description FND");
                                    if PurchaseLine1.FINDSET(false) then begin
                                        TotalPO += FORMAT(PurchaseLine1."Document No.") + '|';
                                        repeat
                                            if RectifyRec then begin
                                                ChildPL.VALIDATE("Direct Unit Cost", ChildPL."Direct Unit Cost" + PurchaseLine1."Direct Unit Cost");
                                                ChildPL."Initial Amount FND" := ChildPL.Amount;

                                                Deletevar += FORMAT(PurchaseLine1."Line No.") + '|';

                                                ChildPL.MODIFY();
                                                PurchaseLineOriginal.RESET();
                                                PurchaseLineOriginal.SETRANGE("Document Type", "Purchase Header"."Document Type"::Order);
                                                PurchaseLineOriginal.SETRANGE("Document No.", "Purchase Header"."No.");
                                                PurchaseLineOriginal.SETRANGE("SRM Order No. FND", "Purchase Header"."No.");
                                                PurchaseLineOriginal.SETRANGE("SRM Order Line No. FND", ChildPL."Additional Description FND");
                                                PurchaseLineOriginal.SETFILTER("Outstanding Qty. (Base)", '%1', 0);
                                                PurchaseLineOriginal.FINDFIRST();
                                                PurchaseLineOriginal."Remaining Amount FND" := ChildPL.Amount;
                                                PurchaseLineOriginal.MODIFY();
                                            end;
                                        until PurchaseLine1.NEXT() = 0;
                                    end;
                                    if (Deletevar <> '') and (RectifyRec) then begin
                                        DeletedLinevar := COPYSTR(Deletevar, 1, STRLEN(Deletevar) - 1);
                                        PurchaseLine1.RESET();
                                        PurchaseLine1.SETRANGE("Document Type", "Purchase Header"."Document Type"::Order);
                                        PurchaseLine1.SETRANGE("Document No.", "Purchase Header"."No.");
                                        PurchaseLine1.SETFILTER("Line No.", DeletedLinevar);
                                        PurchaseLine1.SETFILTER("Outstanding Qty. (Base)", '<>%1', 0);
                                        PurchaseLine1.SETRANGE("Additional Description FND", ChildPL."Additional Description FND");
                                        if PurchaseLine1.FINDSET(false) then begin
                                            repeat
                                                PurchaseLine1.DELETEALL();
                                            until PurchaseLine1.NEXT() = 0;
                                        end;
                                    end;

                                end;
                            end;
                        until OrignalPL.NEXT() = 0;
                    end;
                end;


                if RectifyRec then begin
                    "Purchase Header".Status := Statusvaroption;
                    "Purchase Header".MODIFY();
                end;
                //#HEI.01>>
            end;

            trigger OnPostDataItem();
            begin
                ////#HEI.01>>
                if GUIALLOWED then begin
                    if RectifyRec then
                        MESSAGE(Txt001 + '' + TotalPO)
                    else
                        MESSAGE(TotalPO);
                end;
                //#HEI.01<<
            end;

            trigger OnPreDataItem();
            begin
                if ("Purchase Header".GETFILTER("No.") = '') and (RectifyRec) then
                    ERROR('Document No. must be selected');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(RectifyRec; RectifyRec)
                {
                    Caption = 'Rectify PO';
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        PurchaseLine: Record "Purchase Line";
        PurchaseLine1: Record "Purchase Line";
        Statusvaroption: Enum "Purchase Document Status";
        MergeTxt001: Label 'Line no. %1 merged with Line No. %2 successfully.';
        DeleteTxt001: Label 'Line No. %1 is deleted.';
        DeleteNotFound01: Label 'Line to delete not found.Please check Additional Description , Line No. and Outstanding Qty.';
        MergeNotFound01: Label 'Line to merge not found.Please check Additional Description , Line No. and Outstanding Qty.';
        Request001: Label 'Kindly Select "Merge with Line No." where you want to merge values after deletion.';
        Request002: Label 'Kindly Select single or multiple line using pipe(|) in "Delete Line No. Filter" option which you want to delete after merging.';
        PurchaseLineOriginal: Record "Purchase Line";
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        OrignalPL: Record "Purchase Line";
        ChildPL: Record "Purchase Line";
        Deletevar: Text;
        DeletedLinevar: Text;
        TotalPO: Text;
        RectifyRec: Boolean;
        Txt001: Label 'Below Po''s are corrected.';
}

