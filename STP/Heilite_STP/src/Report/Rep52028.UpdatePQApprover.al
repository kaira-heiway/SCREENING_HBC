report 52028 "Update PQ Approver"
{
    // version HEI.02

    // HEI.01 CHG0255725 IBM GAVANM01 16.04.2019
    //   # Check the highest version of the PQ archive, pick the requester ID, check the approver of the Requester and use it as the “PQ approver”
    // HEI.02 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # Replaced Field "Payment User" from Purchase Header with "PQ Approver" from Purchase Header Additional
    //   # Code added to create extension Purchase Header with "PQ Approver"
    //   # Code added to insert Additional Purchase Header, Purch. Rcpt. Header, Purch. Inv. Header and Purch. Cr. Memo. Header
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID - 50210.
    // 2. Add layout path and Change extension RDLC to RDL.
    // 3. Add ApplicationArea and UsageCategory Property in REport.
    // 4. Remove Drink-IT Field and related code("Requester ID")
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Update PQ Approver.rdl'; // BC Upgrade BHARDA11 ---Add layout path and Change extension RDLC to RDL.


    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.");
            RequestFilterFields = "Document Type", "No.";
            column(PurchaserCode; PurchaserCode)
            {
            }
            column(PurchaseHeader_No; "Purchase Header"."No.")
            {
            }

            trigger OnAfterGetRecord();
            var
                PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
            begin
                CLEAR(PurchaserCode);
                //HEI.02>>
                if not PurchaseHeaderAdditional.GET("Document Type", "No.") then begin
                    PurchaseHeaderAdditional.INIT;
                    PurchaseHeaderAdditional.VALIDATE("Document Type", "Document Type");
                    PurchaseHeaderAdditional.VALIDATE("No.", "No.");
                    PurchaseHeaderAdditional.INSERT(true);
                end;
                //HEI.02<<

                case "Purchase Header"."Document Type" of
                    "Purchase Header"."Document Type"::Quote:
                        begin
                            //HEI.02
                            //IF ("Purchase Header"."Payment User" = '') AND ("Purchase Header"."Maximo Requisition No." <> '') THEN BEGIN
                            //"Purchase Header".VALIDATE("Payment User",DefaultUserId);
                            //"Purchase Header".MODIFY;
                            if (PurchaseHeaderAdditional."PQ Approver" = '') and ("Maximo Requisition No. FND" <> '') then begin
                                PurchaseHeaderAdditional.VALIDATE("PQ Approver", DefaultUserId);
                                PurchaseHeaderAdditional.MODIFY(true);
                                //HEI.02<<
                                NoOfEntries += 1;
                                CurrReport.SKIP;  //HEI.01
                            end;
                            //HEI.02>>
                            //IF ("Purchase Header"."Payment User" = '') AND
                            if (PurchaseHeaderAdditional."PQ Approver" = '') and
                               //HEI.02<<
                               ("Purchase Header"."Maximo Requisition No. FND" = '') and
                               ("Purchase Header".Status = "Purchase Header".Status::Released)
                            then begin
                                ApprovalEntry.RESET;
                                ApprovalEntry.SETRANGE("Table ID", 38);
                                ApprovalEntry.SETRANGE("Document Type", ApprovalEntry."Document Type"::Quote);
                                ApprovalEntry.SETRANGE("Document No.", "Purchase Header"."No.");
                                if ApprovalEntry.FINDLAST then begin
                                    //HEI.02>>
                                    //"Purchase Header".VALIDATE("Payment User",ApprovalEntry."Approver ID");
                                    //"Purchase Header".MODIFY;
                                    PurchaseHeaderAdditional.VALIDATE("PQ Approver", ApprovalEntry."Approver ID");
                                    PurchaseHeaderAdditional.MODIFY(true);
                                    //HEI.02<<
                                    NoOfEntries += 1;
                                    CurrReport.SKIP;  //HEI.01
                                end;
                            end else
                                CurrReport.SKIP;  //HEI.01
                        end;
                    "Purchase Header"."Document Type"::Order:
                        begin
                            //HEI.02>>
                            //IF ("Purchase Header"."Payment User" = '') AND ("Purchase Header"."Maximo Requisition No." <> '') THEN BEGIN
                            //"Purchase Header".VALIDATE("Payment User",DefaultUserId);
                            //"Purchase Header".MODIFY;
                            if (PurchaseHeaderAdditional."PQ Approver" = '') and ("Maximo Requisition No. FND" <> '') then begin
                                PurchaseHeaderAdditional.VALIDATE("PQ Approver", DefaultUserId);
                                PurchaseHeaderAdditional.MODIFY(true);
                                //HEI.02<<
                                NoOfEntries += 1;
                                CurrReport.SKIP;  //HEI.01
                            end;

                            //HEI.02>>
                            //IF ("Purchase Header"."Payment User" = '') AND
                            // BC Upgrade BHARDA11 >> ----Drink-IT Field("Requester ID")
                            // if (PurchaseHeaderAdditional."PQ Approver" = '') and
                            //    //HEI.02<<
                            //    ("Purchase Header"."Maximo Requisition No." = '') and
                            //    ("Purchase Header"."SRM Order No." = '') and
                            //    ("Purchase Header"."SRM Contract No." = '')
                            // then begin
                            //     if "Purchase Header"."Quote No." <> '' then begin   //HEI.01
                            //         PurchaseHeaderArchive.SETCURRENTKEY("Document Type", "No.", "Doc. No. Occurrence", "Version No.");
                            //         PurchaseHeaderArchive.RESET;
                            //         PurchaseHeaderArchive.SETRANGE("Document Type", PurchaseHeaderArchive."Document Type"::Quote);
                            //         PurchaseHeaderArchive.SETRANGE("No.", "Purchase Header"."Quote No.");
                            //         if PurchaseHeaderArchive.FINDLAST then begin
                            //             //HEI.01>>
                            //             if ApprovalUserSetup.GET(PurchaseHeaderArchive."Requester ID") and (ApprovalUserSetup."Approver ID" <> '') then
                            //                 //HEI.02>>
                            //                 //"Purchase Header".VALIDATE("Payment User",ApprovalUserSetup."Approver ID")
                            //                 PurchaseHeaderAdditional.VALIDATE("PQ Approver", ApprovalUserSetup."Approver ID")
                            //             //HEI.02<<
                            //             else
                            //                 //HEI.01<<
                            //                 //HEI.02>>
                            //                 //"Purchase Header".VALIDATE("Payment User",PurchaseHeaderArchive."Requester ID");
                            //                 PurchaseHeaderAdditional.VALIDATE("PQ Approver", PurchaseHeaderArchive."Requester ID");
                            //             //"Purchase Header".MODIFY;
                            //             PurchaseHeaderAdditional.MODIFY(true);
                            //             //HEI.02<<
                            //             NoOfEntries += 1;
                            //             CurrReport.SKIP;  //HEI.01
                            //         end;
                            //     end else
                            //         PurchaserCode := "Purchase Header"."Purchaser Code";
                            // end else
                            //     CurrReport.SKIP;  //HEI.01
                            // BC Upgrade BHARDA11 << ----Drink-IT Field("Requester ID")
                        end;
                end;
            end;
        }
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);

            trigger OnAfterGetRecord();
            var
                PurchRcptHeaderAdditional: Record "Purch. Rcpt. Header Add FND";
            begin
                //HEI.02>>
                if not PurchRcptHeaderAdditional.GET("No.") then begin
                    PurchRcptHeaderAdditional.INIT;
                    PurchRcptHeaderAdditional.VALIDATE("No.", "No.");
                    PurchRcptHeaderAdditional.INSERT(true);
                end;
                //HEI.02<<
            end;
        }
        dataitem("Sales Ship. Header Add FND"; "Sales Ship. Header Add FND")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);

            trigger OnAfterGetRecord();
            var
                SalesShipHeaderAdditional: Record "Sales Ship. Header Add FND";
            begin
                //HEI.02>>
                if not SalesShipHeaderAdditional.GET("No.") then begin
                    SalesShipHeaderAdditional.INIT;
                    SalesShipHeaderAdditional.VALIDATE("No.", "No.");
                    SalesShipHeaderAdditional.INSERT(true);
                end;
                //HEI.02<<
            end;
        }
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);

            trigger OnAfterGetRecord();
            var
                PurchInvHeaderAdditional: Record "Purch. Inv. Header Add FND";
            begin
                //HEI.02>>
                if not PurchInvHeaderAdditional.GET("No.") then begin
                    PurchInvHeaderAdditional.INIT;
                    PurchInvHeaderAdditional.VALIDATE("No.", "No.");
                    PurchInvHeaderAdditional.INSERT(true);
                end;
                //HEI.02<<
            end;
        }
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);

            trigger OnAfterGetRecord();
            var
                PurchCrMEmoHdrAdditional: Record "Purch. Cr. Memo Hdr. Add FND";
            begin
                //HEI.02>>
                if not PurchCrMEmoHdrAdditional.GET("No.") then begin
                    PurchCrMEmoHdrAdditional.INIT;
                    PurchCrMEmoHdrAdditional.VALIDATE("No.", "No.");
                    PurchCrMEmoHdrAdditional.INSERT(true);
                end;
                //HEI.02<<
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(DefaultUserId; DefaultUserId)
                {
                    ApplicationArea = All;
                    Caption = '" Default User ID"';
                    TableRelation = "User Setup"."User ID";
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

    trigger OnPostReport();
    begin
        MESSAGE('A number of %1 entries were modified', NoOfEntries)
    end;

    var
        DefaultUserId: Code[50];
        ApprovalEntry: Record "Approval Entry";
        PurchaserCode: Code[50];
        PurchaseHeaderArchive: Record "Purchase Header Archive";
        NoOfEntries: Integer;
        ApprovalUserSetup: Record "User Setup";
}

