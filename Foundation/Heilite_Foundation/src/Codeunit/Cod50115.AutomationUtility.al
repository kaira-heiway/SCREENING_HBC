codeunit 50115 "Automation Utility"
{
    // version HEI.01

    // HEI.01 CHG2010375 IBM.LS 23.01.2020
    //   # New Codeunit created and code added.
    // HEI.02 CHG2010375 IBM.LS 26.02.2020
    //   # Code added.

    // BC Upgrade PATELP08 >>
    // Changed the DocumentType parameter datatype from option to Enum ("Sales Document Type") to align with the calling functions where an enum value is passed, resolving the warning, and enum values were matching with enum for following procedure - 
    // 1. LogisticsEmailInvoice, 2. EmailInvoice, 3. PrintInvoice, 4. LogisticsEmailCrMemo, 5. EmailCrMemo, 6. PrintCrMemo, 7. AutoEmailAndOrPrintFromBlockedChain, 8. UpdateJQLogEntryFromBlockedChain
    // Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
    // BC Upgrade PATELP08 <<

    // BC Upgrade SHUKLP03 >> Refactored SMTP code of proceduers EmailInvoice,EmailCrMemo, LogisticsEmailInvoice, LogisticsEmailCrMemo.

    Permissions = TableData "Sales Invoice Header" = rm,
                  TableData "Sales Cr.Memo Header" = rm;

    trigger OnRun();
    begin
        //HEI.01>>
        //WARNING!!
        //Avoid to write code under the OnRun() trigger in this Codeunit.
        //Leave this space for thread utility testing.
        //HEI.01<<
    end;

    procedure AutoEmailAndOrPrint(var SalesHeader: Record "Sales Header"; IsEmail: Boolean; IsPrint: Boolean; IsLogisticsEmail: Boolean);
    var
        PostedSalesCMNoL: Code[20];
        PostedSalesInvNoL: Code[20];
    begin
        //BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
        //HEI.01>>
        // with SalesHeader do begin
        //     case "Document Type" of
        //         "Document Type"::Order:
        //             begin
        //                 PostedSalesInvNoL := GetPostedDocumentNo(SalesHeader);
        //                 if Invoice then begin
        //                     if IsLogisticsEmail then
        //                         if LogisticsEmailInvoice(PostedSalesInvNoL, "Document Type", "No.") then
        //                             UpdateJQLogEntry(SalesHeader, true, false, false, IsLogisticsEmail);
        //                     if IsEmail then
        //                         if EmailInvoice(PostedSalesInvNoL, "Document Type", "No.") then
        //                             UpdateJQLogEntry(SalesHeader, true, IsEmail, false, false);
        //                     if IsPrint then
        //                         if PrintInvoice(PostedSalesInvNoL, "Document Type", "No.") then
        //                             UpdateJQLogEntry(SalesHeader, true, false, IsPrint, false);
        //                 end;
        //             end;

        //         "Document Type"::Invoice:
        //             begin
        //                 PostedSalesInvNoL := GetPostedDocumentNo(SalesHeader);
        //                 if IsLogisticsEmail then
        //                     if LogisticsEmailInvoice(PostedSalesInvNoL, "Document Type", "No.") then
        //                         UpdateJQLogEntry(SalesHeader, true, false, false, IsLogisticsEmail);
        //                 if IsEmail then
        //                     if EmailInvoice(PostedSalesInvNoL, "Document Type", "No.") then
        //                         UpdateJQLogEntry(SalesHeader, true, IsEmail, false, false);
        //                 if IsPrint then
        //                     if PrintInvoice(PostedSalesInvNoL, "Document Type", "No.") then
        //                         UpdateJQLogEntry(SalesHeader, true, false, IsPrint, false);
        //             end;

        //         "Document Type"::"Return Order":
        //             begin
        //                 PostedSalesCMNoL := GetPostedDocumentNo(SalesHeader);
        //                 if Invoice then begin
        //                     if IsLogisticsEmail then
        //                         if LogisticsEmailCrMemo(PostedSalesCMNoL, "Document Type", "No.") then
        //                             UpdateJQLogEntry(SalesHeader, true, false, false, IsLogisticsEmail);
        //                     if IsEmail then
        //                         if EmailCrMemo(PostedSalesCMNoL, "Document Type", "No.") then
        //                             UpdateJQLogEntry(SalesHeader, true, IsEmail, false, false);
        //                     if IsPrint then
        //                         if PrintCrMemo(PostedSalesCMNoL, "Document Type", "No.") then
        //                             UpdateJQLogEntry(SalesHeader, true, false, IsPrint, false);
        //                 end;
        //             end;

        //         "Document Type"::"Credit Memo":
        //             begin
        //                 PostedSalesCMNoL := GetPostedDocumentNo(SalesHeader);
        //                 if IsLogisticsEmail then
        //                     if LogisticsEmailCrMemo(PostedSalesCMNoL, "Document Type", "No.") then
        //                         UpdateJQLogEntry(SalesHeader, true, false, false, IsLogisticsEmail);
        //                 if IsEmail then
        //                     if EmailCrMemo(PostedSalesCMNoL, "Document Type", "No.") then
        //                         UpdateJQLogEntry(SalesHeader, true, IsEmail, false, false);
        //                 if IsPrint then
        //                     if PrintCrMemo(PostedSalesCMNoL, "Document Type", "No.") then
        //                         UpdateJQLogEntry(SalesHeader, true, false, IsPrint, false);
        //             end;
        //     end;
        // end;
        //HEI.01<<
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::Order:
                begin
                    PostedSalesInvNoL := GetPostedDocumentNo(SalesHeader);
                    if SalesHeader.Invoice then begin
                        if IsLogisticsEmail then
                            if LogisticsEmailInvoice(PostedSalesInvNoL, SalesHeader."Document Type", SalesHeader."No.") then
                                UpdateJQLogEntry(SalesHeader, true, false, false, IsLogisticsEmail);
                        if IsEmail then
                            if EmailInvoice(PostedSalesInvNoL, SalesHeader."Document Type", SalesHeader."No.") then
                                UpdateJQLogEntry(SalesHeader, true, IsEmail, false, false);
                        if IsPrint then
                            if PrintInvoice(PostedSalesInvNoL, SalesHeader."Document Type", SalesHeader."No.") then
                                UpdateJQLogEntry(SalesHeader, true, false, IsPrint, false);
                    end;
                end;

            SalesHeader."Document Type"::Invoice:
                begin
                    PostedSalesInvNoL := GetPostedDocumentNo(SalesHeader);
                    if IsLogisticsEmail then
                        if LogisticsEmailInvoice(PostedSalesInvNoL, SalesHeader."Document Type", SalesHeader."No.") then
                            UpdateJQLogEntry(SalesHeader, true, false, false, IsLogisticsEmail);
                    if IsEmail then
                        if EmailInvoice(PostedSalesInvNoL, SalesHeader."Document Type", SalesHeader."No.") then
                            UpdateJQLogEntry(SalesHeader, true, IsEmail, false, false);
                    if IsPrint then
                        if PrintInvoice(PostedSalesInvNoL, SalesHeader."Document Type", SalesHeader."No.") then
                            UpdateJQLogEntry(SalesHeader, true, false, IsPrint, false);
                end;

            SalesHeader."Document Type"::"Return Order":
                begin
                    PostedSalesCMNoL := GetPostedDocumentNo(SalesHeader);
                    if SalesHeader.Invoice then begin
                        if IsLogisticsEmail then
                            if LogisticsEmailCrMemo(PostedSalesCMNoL, SalesHeader."Document Type", SalesHeader."No.") then
                                UpdateJQLogEntry(SalesHeader, true, false, false, IsLogisticsEmail);
                        if IsEmail then
                            if EmailCrMemo(PostedSalesCMNoL, SalesHeader."Document Type", SalesHeader."No.") then
                                UpdateJQLogEntry(SalesHeader, true, IsEmail, false, false);
                        if IsPrint then
                            if PrintCrMemo(PostedSalesCMNoL, SalesHeader."Document Type", SalesHeader."No.") then
                                UpdateJQLogEntry(SalesHeader, true, false, IsPrint, false);
                    end;
                end;

            SalesHeader."Document Type"::"Credit Memo":
                begin
                    PostedSalesCMNoL := GetPostedDocumentNo(SalesHeader);
                    if IsLogisticsEmail then
                        if LogisticsEmailCrMemo(PostedSalesCMNoL, SalesHeader."Document Type", SalesHeader."No.") then
                            UpdateJQLogEntry(SalesHeader, true, false, false, IsLogisticsEmail);
                    if IsEmail then
                        if EmailCrMemo(PostedSalesCMNoL, SalesHeader."Document Type", SalesHeader."No.") then
                            UpdateJQLogEntry(SalesHeader, true, IsEmail, false, false);
                    if IsPrint then
                        if PrintCrMemo(PostedSalesCMNoL, SalesHeader."Document Type", SalesHeader."No.") then
                            UpdateJQLogEntry(SalesHeader, true, false, IsPrint, false);
                end;
        end;
        // BC Upgrade PATELP08 <<
    end;

    procedure UpdateJQLogEntry(var SalesHeader: Record "Sales Header"; IsPosted: Boolean; IsEmailed: Boolean; IsPrinted: Boolean; IsLogisticsEmailed: Boolean);
    var
        JobQueueEntryL: Record "Job Queue Entry";
        SalesCMHeaderL: Record "Sales Cr.Memo Header";
        SalesCrMemoHeaderL: Record "Sales Cr.Memo Header";
        SalesInvHeaderL: Record "Sales Invoice Header";
        SalesInvoiceHeaderL: Record "Sales Invoice Header";
        PostedSalesCMNoL: Code[20];
        PostedSalesInvNoL: Code[20];
    begin
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
        //HEI.01>>
        // with SalesHeader do begin
        //     if not ISNULLGUID("Job Queue Entry ID") then begin
        //         JobQueueEntryL.GET("Job Queue Entry ID");
        //         case "Document Type" of
        //             "Document Type"::Order, "Document Type"::Invoice:
        //                 begin
        //                     PostedSalesInvNoL := GetPostedDocumentNo(SalesHeader);
        //                     SalesInvoiceHeaderL.SETRANGE("No.", PostedSalesInvNoL);
        //                     if SalesInvoiceHeaderL.FINDFIRST() then begin
        //                         if IsPosted and (not JobQueueEntryL."JQ Posted" or (JobQueueEntryL."Posted Document No." = '')) then begin
        //                             JobQueueEntryL."JQ Posted" := true;
        //                             JobQueueEntryL."Posted Document No." := SalesInvoiceHeaderL."No.";
        //                         end;
        //                         if IsEmailed then begin
        //                             JobQueueEntryL."JQ Mail Sent" := true;
        //                             //SalesInvoiceHeaderL."Mail Sent" := true;  // BC Upgrade NANDIS03 - Dependednt on SalesInvHdr compilation
        //                         end;
        //                         if IsPrinted then
        //                             JobQueueEntryL."JQ Printed" := true;
        //                         if IsLogisticsEmailed then
        //                             JobQueueEntryL."JQ Logistics Mail Sent" := true;
        //                         JobQueueEntryL.MODIFY();
        //                         if IsEmailed then
        //                             SalesInvoiceHeaderL.MODIFY();
        //                         COMMIT();
        //                         CLEAR(PostedSalesInvNoL);
        //                     end;
        //                 end;

        //             "Document Type"::"Credit Memo", "Document Type"::"Return Order":
        //                 begin
        //                     PostedSalesCMNoL := GetPostedDocumentNo(SalesHeader);
        //                     SalesCrMemoHeaderL.SETRANGE("No.", PostedSalesCMNoL);
        //                     if SalesCrMemoHeaderL.FINDFIRST() then begin
        //                         if IsPosted and (not JobQueueEntryL."JQ Posted" or (JobQueueEntryL."Posted Document No." = '')) then begin
        //                             JobQueueEntryL."JQ Posted" := true;
        //                             JobQueueEntryL."Posted Document No." := SalesCrMemoHeaderL."No.";
        //                         end;
        //                         if IsEmailed then begin
        //                             JobQueueEntryL."JQ Mail Sent" := true;
        //                             //SalesCrMemoHeaderL."Mail Sent" := true;  // BC Upgrade NANDIS03 - Dependednt on SalesCrMemo compilation
        //                         end;
        //                         if IsPrinted then
        //                             JobQueueEntryL."JQ Printed" := true;
        //                         if IsLogisticsEmailed then
        //                             JobQueueEntryL."JQ Logistics Mail Sent" := true;
        //                         JobQueueEntryL.MODIFY();
        //                         if IsEmailed then
        //                             SalesCrMemoHeaderL.MODIFY();
        //                         COMMIT();
        //                     end;
        //                 end;
        //         end;
        //     end;
        // end;
        //HEI.01<<
        if not ISNULLGUID(SalesHeader."Job Queue Entry ID") then begin
            JobQueueEntryL.GET(SalesHeader."Job Queue Entry ID");
            case SalesHeader."Document Type" of
                SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice:
                    begin
                        PostedSalesInvNoL := GetPostedDocumentNo(SalesHeader);
                        SalesInvoiceHeaderL.SETRANGE("No.", PostedSalesInvNoL);
                        if SalesInvoiceHeaderL.FINDFIRST() then begin
                            if IsPosted and (not JobQueueEntryL."JQ Posted FND" or (JobQueueEntryL."Posted Document No. FND" = '')) then begin
                                JobQueueEntryL."JQ Posted FND" := true;
                                JobQueueEntryL."Posted Document No. FND" := SalesInvoiceHeaderL."No.";
                            end;
                            if IsEmailed then begin
                                JobQueueEntryL."JQ Mail Sent FND" := true;
                                //SalesInvoiceHeaderL."Mail Sent" := true;  // BC Upgrade NANDIS03 - Dependednt on SalesInvHdr compilation
                            end;
                            if IsPrinted then
                                JobQueueEntryL."JQ Printed FND" := true;
                            if IsLogisticsEmailed then
                                JobQueueEntryL."JQ Logistics Mail Sent FND" := true;
                            JobQueueEntryL.MODIFY();
                            if IsEmailed then
                                SalesInvoiceHeaderL.MODIFY();
                            COMMIT();
                            CLEAR(PostedSalesInvNoL);
                        end;
                    end;

                SalesHeader."Document Type"::"Credit Memo", SalesHeader."Document Type"::"Return Order":
                    begin
                        PostedSalesCMNoL := GetPostedDocumentNo(SalesHeader);
                        SalesCrMemoHeaderL.SETRANGE("No.", PostedSalesCMNoL);
                        if SalesCrMemoHeaderL.FINDFIRST() then begin
                            if IsPosted and (not JobQueueEntryL."JQ Posted FND" or (JobQueueEntryL."Posted Document No. FND" = '')) then begin
                                JobQueueEntryL."JQ Posted FND" := true;
                                JobQueueEntryL."Posted Document No. FND" := SalesCrMemoHeaderL."No.";
                            end;
                            if IsEmailed then begin
                                JobQueueEntryL."JQ Mail Sent FND" := true;
                                //SalesCrMemoHeaderL."Mail Sent" := true;  // BC Upgrade NANDIS03 - Dependednt on SalesCrMemo compilation
                            end;
                            if IsPrinted then
                                JobQueueEntryL."JQ Printed FND" := true;
                            if IsLogisticsEmailed then
                                JobQueueEntryL."JQ Logistics Mail Sent FND" := true;
                            JobQueueEntryL.MODIFY();
                            if IsEmailed then
                                SalesCrMemoHeaderL.MODIFY();
                            COMMIT();
                        end;
                    end;
            end;
        end;
        // BC Upgrade PATELP08 <<
    end;
    // BC Upgrade PATELP08 >> Changed the DocumentType parameter datatype from option to Enum ("Sales Document Type") to align with the calling functions where an enum value is passed, resolving the warning, and enum values were matching with enum for following procedure - 
    // procedure AutoEmailAndOrPrintFromBlockedChain(var JobQueueEntry: Record "Job Queue Entry"; DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; PostedDocumentNo: Code[20]; IsEmail: Boolean; IsPrint: Boolean; IsLogisticsEmail: Boolean);
    procedure AutoEmailAndOrPrintFromBlockedChain(var JobQueueEntry: Record "Job Queue Entry"; DocumentType: Enum "Sales Document Type"; PostedDocumentNo: Code[20]; IsEmail: Boolean; IsPrint: Boolean; IsLogisticsEmail: Boolean);
    // BC Upgrade PATELP08 <<
    var
        TextL001: Label 'Incorrect "Document Type" was updated in this "Job Queue Entry" - %1.';
        TextL002: Label '"""Posted Document No."" not be blank for this ""Job Queue Entry"" - %1."';
        TextL003: Label '"""Posted Document No."" - %1 is not matching with Job Queue ""Posted Document No."" - %2 for this ""Job Queue Entry"" - %3."';
        TextL004: Label '"""Document Type"" - %1 is not matching with Job Queue ""Document Type"" - %2 for this ""Job Queue Entry"" - %3."';
    begin
        //HEI.01>>
        if not ISNULLGUID(JobQueueEntry.ID) then begin
            JobQueueEntry.GET(JobQueueEntry.ID);
            if not JobQueueEntry."JQ Posted FND" then
                exit;
            if not (DocumentType in [DocumentType::Order, DocumentType::Invoice, DocumentType::"Credit Memo", DocumentType::"Return Order"]) then
                ERROR(TextL001, JobQueueEntry.ID);
            if PostedDocumentNo = '' then
                ERROR(TextL002, JobQueueEntry.ID);
            if PostedDocumentNo <> JobQueueEntry."Posted Document No. FND" then
                ERROR(TextL003, PostedDocumentNo, JobQueueEntry."Posted Document No. FND", JobQueueEntry.ID);
            if DocumentType <> JobQueueEntry."Document Type FND" then
                ERROR(TextL004, FORMAT(DocumentType), FORMAT(JobQueueEntry."Document Type FND"), JobQueueEntry.ID);
            case DocumentType of
                DocumentType::Order, DocumentType::Invoice:
                    begin
                        if IsLogisticsEmail and not JobQueueEntry."JQ Logistics Mail Sent FND" then
                            if LogisticsEmailInvoice(PostedDocumentNo, JobQueueEntry."Document Type FND", JobQueueEntry."Document No. FND") then
                                UpdateJQLogEntryFromBlockedChain(JobQueueEntry, DocumentType, PostedDocumentNo, true, false, false, IsLogisticsEmail);
                        if IsEmail then
                            if EmailInvoice(PostedDocumentNo, JobQueueEntry."Document Type FND", JobQueueEntry."Document No. FND") then
                                UpdateJQLogEntryFromBlockedChain(JobQueueEntry, DocumentType, PostedDocumentNo, true, IsEmail, false, false);
                        if IsPrint then
                            if PrintInvoice(PostedDocumentNo, JobQueueEntry."Document Type FND", JobQueueEntry."Document No. FND") then
                                UpdateJQLogEntryFromBlockedChain(JobQueueEntry, DocumentType, PostedDocumentNo, true, false, IsPrint, false);
                    end;

                DocumentType::"Return Order", DocumentType::"Credit Memo":
                    begin
                        if IsLogisticsEmail and not JobQueueEntry."JQ Logistics Mail Sent FND" then
                            if LogisticsEmailCrMemo(PostedDocumentNo, JobQueueEntry."Document Type FND", JobQueueEntry."Document No. FND") then
                                UpdateJQLogEntryFromBlockedChain(JobQueueEntry, DocumentType, PostedDocumentNo, true, false, false, IsLogisticsEmail);
                        if IsEmail then
                            if EmailCrMemo(PostedDocumentNo, JobQueueEntry."Document Type FND", JobQueueEntry."Document No. FND") then
                                UpdateJQLogEntryFromBlockedChain(JobQueueEntry, DocumentType, PostedDocumentNo, true, IsEmail, false, false);
                        if IsPrint then
                            if PrintCrMemo(PostedDocumentNo, JobQueueEntry."Document Type FND", JobQueueEntry."Document No. FND") then
                                UpdateJQLogEntryFromBlockedChain(JobQueueEntry, DocumentType, PostedDocumentNo, true, false, IsPrint, false);
                    end;
            end;
        end;
        //HEI.01<<
    end;
    // BC Upgrade PATELP08 >> Changed the DocumentType parameter datatype from option to Enum ("Sales Document Type") to align with the calling functions where an enum value is passed, resolving the warning, and enum values were matching with enum for following procedure - 
    // local procedure UpdateJQLogEntryFromBlockedChain(var JobQueueEntry: Record "Job Queue Entry"; DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; PostedDocumentNo: Code[20]; IsPosted: Boolean; IsEmailed: Boolean; IsPrinted: Boolean; IsLogisticsEmailed: Boolean);
    local procedure UpdateJQLogEntryFromBlockedChain(var JobQueueEntry: Record "Job Queue Entry"; DocumentType: Enum "Sales Document Type"; PostedDocumentNo: Code[20]; IsPosted: Boolean; IsEmailed: Boolean; IsPrinted: Boolean; IsLogisticsEmailed: Boolean);
    // BC Upgrade PATELP08 <<
    var
        SalesCrMemoHeaderL: Record "Sales Cr.Memo Header";
        SalesInvoiceHeaderL: Record "Sales Invoice Header";
        TextL000: Label '"""Document Type"" - %1 is not matching with Job Queue ""Document Type"" - %2 for this ""Job Queue Entry"" - %3."';
    begin
        //HEI.01>>
        if not ISNULLGUID(JobQueueEntry.ID) then begin
            JobQueueEntry.GET(JobQueueEntry.ID);
            if DocumentType <> JobQueueEntry."Document Type FND" then
                ERROR(TextL000, FORMAT(DocumentType), FORMAT(JobQueueEntry."Document Type FND"), JobQueueEntry.ID);
            case DocumentType of
                DocumentType::Order, DocumentType::Invoice:
                    begin
                        SalesInvoiceHeaderL.SETRANGE("No.", PostedDocumentNo);
                        SalesInvoiceHeaderL.FINDFIRST();
                        if IsPosted and (not JobQueueEntry."JQ Posted FND" or (JobQueueEntry."Posted Document No. FND" = '')) then begin
                            JobQueueEntry."JQ Posted FND" := true;
                            JobQueueEntry."Posted Document No. FND" := SalesInvoiceHeaderL."No.";
                        end;
                        if IsEmailed then begin
                            JobQueueEntry."JQ Mail Sent FND" := true;
                            //SalesInvoiceHeaderL."Mail Sent" := true;  // BC Upgrade NANDIS03 - Dependednt on SalesInvHdr compilation
                        end;
                        if IsPrinted then
                            JobQueueEntry."JQ Printed FND" := true;
                        if IsLogisticsEmailed then
                            JobQueueEntry."JQ Logistics Mail Sent FND" := true;
                        JobQueueEntry.MODIFY();
                        if IsEmailed then
                            SalesInvoiceHeaderL.MODIFY();
                        COMMIT();
                    end;

                DocumentType::"Return Order", DocumentType::"Credit Memo":
                    begin
                        SalesCrMemoHeaderL.SETRANGE("No.", PostedDocumentNo);
                        SalesCrMemoHeaderL.FINDFIRST();
                        if IsPosted and (not JobQueueEntry."JQ Posted FND" or (JobQueueEntry."Posted Document No. FND" = '')) then begin
                            JobQueueEntry."JQ Posted FND" := true;
                            JobQueueEntry."Posted Document No. FND" := SalesCrMemoHeaderL."No.";
                        end;
                        if IsEmailed then begin
                            JobQueueEntry."JQ Mail Sent FND" := true;
                            //SalesCrMemoHeaderL."Mail Sent" := true; // BC Upgrade NANDIS03 - Dependednt on SalesInvHdr compilation
                        end;
                        if IsPrinted then
                            JobQueueEntry."JQ Printed FND" := true;
                        if IsLogisticsEmailed then
                            JobQueueEntry."JQ Logistics Mail Sent FND" := true;
                        JobQueueEntry.MODIFY();
                        if IsEmailed then
                            SalesCrMemoHeaderL.MODIFY();
                        COMMIT();
                    end;
            end;
        end;
        //HEI.01<<
    end;

    local procedure GetPostedDocumentNo(var SalesHeader: Record "Sales Header") PostedDocNo: Code[20];
    var
        ReturnRcptHeaderL: Record "Return Receipt Header";
        ReturnReceiptHeaderL: Record "Return Receipt Header";
        SalesCMHeaderL: Record "Sales Cr.Memo Header";
        SalesCrMemoHeaderL: Record "Sales Cr.Memo Header";
        SalesInvHeaderL: Record "Sales Invoice Header";
        SalesInvoiceHeaderL: Record "Sales Invoice Header";
    begin
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
        //HEI.01>>
        // with SalesHeader do begin
        //     case "Document Type" of
        //         "Document Type"::Order, "Document Type"::Invoice:
        //             begin
        //                 if SalesHeader."Last Posting No." = '' then
        //                     SalesInvHeaderL."No." := SalesHeader."No."
        //                 else
        //                     SalesInvHeaderL."No." := SalesHeader."Last Posting No.";
        //                 SalesInvHeaderL.FIND();
        //                 SalesInvHeaderL.SETRECFILTER();
        //                 SalesInvoiceHeaderL.SETRANGE("No.", SalesInvHeaderL."No.");
        //                 SalesInvoiceHeaderL.FINDFIRST();
        //                 PostedDocNo := SalesInvoiceHeaderL."No.";
        //                 exit(PostedDocNo);
        //             end;

        //         "Document Type"::"Return Order":
        //             begin
        //                 if SalesHeader."Last Return Receipt No." <> '' then begin
        //                     ReturnRcptHeaderL."No." := SalesHeader."Last Return Receipt No.";
        //                     ReturnRcptHeaderL.FIND();
        //                     ReturnRcptHeaderL.SETRECFILTER();
        //                     ReturnReceiptHeaderL.SETRANGE("No.", ReturnRcptHeaderL."No.");
        //                     ReturnReceiptHeaderL.FINDFIRST();
        //                     SalesCrMemoHeaderL.SETRANGE("Return Order No.", ReturnReceiptHeaderL."Return Order No.");
        //                 end else
        //                     SalesCrMemoHeaderL.SETRANGE("Return Order No.", SalesHeader."No.");
        //                 SalesCrMemoHeaderL.FINDFIRST();
        //                 PostedDocNo := SalesCrMemoHeaderL."No.";
        //                 exit(PostedDocNo);
        //             end;

        //         "Document Type"::"Credit Memo":
        //             begin
        //                 if SalesHeader."Last Posting No." = '' then
        //                     SalesCMHeaderL."No." := SalesHeader."No."
        //                 else
        //                     SalesCMHeaderL."No." := SalesHeader."Last Posting No.";
        //                 SalesCMHeaderL.FIND();
        //                 SalesCMHeaderL.SETRECFILTER();
        //                 SalesCrMemoHeaderL.SETRANGE("No.", SalesCMHeaderL."No.");
        //                 SalesCrMemoHeaderL.FINDFIRST();
        //                 PostedDocNo := SalesCrMemoHeaderL."No.";
        //                 exit(PostedDocNo);
        //             end;
        //     end;
        // end;
        //HEI.01<<
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice:
                begin
                    if SalesHeader."Last Posting No." = '' then
                        SalesInvHeaderL."No." := SalesHeader."No."
                    else
                        SalesInvHeaderL."No." := SalesHeader."Last Posting No.";
                    SalesInvHeaderL.FIND();
                    SalesInvHeaderL.SETRECFILTER();
                    SalesInvoiceHeaderL.SETRANGE("No.", SalesInvHeaderL."No.");
                    SalesInvoiceHeaderL.FINDFIRST();
                    PostedDocNo := SalesInvoiceHeaderL."No.";
                    exit(PostedDocNo);
                end;

            SalesHeader."Document Type"::"Return Order":
                begin
                    if SalesHeader."Last Return Receipt No." <> '' then begin
                        ReturnRcptHeaderL."No." := SalesHeader."Last Return Receipt No.";
                        ReturnRcptHeaderL.FIND();
                        ReturnRcptHeaderL.SETRECFILTER();
                        ReturnReceiptHeaderL.SETRANGE("No.", ReturnRcptHeaderL."No.");
                        ReturnReceiptHeaderL.FINDFIRST();
                        SalesCrMemoHeaderL.SETRANGE("Return Order No.", ReturnReceiptHeaderL."Return Order No.");
                    end else
                        SalesCrMemoHeaderL.SETRANGE("Return Order No.", SalesHeader."No.");
                    SalesCrMemoHeaderL.FINDFIRST();
                    PostedDocNo := SalesCrMemoHeaderL."No.";
                    exit(PostedDocNo);
                end;

            SalesHeader."Document Type"::"Credit Memo":
                begin
                    if SalesHeader."Last Posting No." = '' then
                        SalesCMHeaderL."No." := SalesHeader."No."
                    else
                        SalesCMHeaderL."No." := SalesHeader."Last Posting No.";
                    SalesCMHeaderL.FIND();
                    SalesCMHeaderL.SETRECFILTER();
                    SalesCrMemoHeaderL.SETRANGE("No.", SalesCMHeaderL."No.");
                    SalesCrMemoHeaderL.FINDFIRST();
                    PostedDocNo := SalesCrMemoHeaderL."No.";
                    exit(PostedDocNo);
                end;
        end;
        // BC Upgrade PATELP08 <<
    end;

    procedure GetPostedDocumentNoForUpdate(var DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; var DocumentNo: Code[20]) PostedDocNo: Code[20];
    var
        SalesCrMemoHeaderL: Record "Sales Cr.Memo Header";
        SalesHeaderL: Record "Sales Header";
        SalesInvoiceHeaderL: Record "Sales Invoice Header";
    begin
        //HEI.01>>
        SalesHeaderL.SETRANGE("Document Type", DocumentType);
        SalesHeaderL.SETRANGE("No.", DocumentNo);
        if SalesHeaderL.ISEMPTY then begin
            case DocumentType of
                DocumentType::Order, DocumentType::Invoice:
                    begin
                        SalesInvoiceHeaderL.SETRANGE("Order No.", DocumentNo);
                        SalesInvoiceHeaderL.FINDLAST();
                        PostedDocNo := SalesInvoiceHeaderL."No.";
                        exit(PostedDocNo);
                    end;

                DocumentType::"Return Order":
                    begin
                        SalesCrMemoHeaderL.SETRANGE("Return Order No.", DocumentNo);
                        SalesCrMemoHeaderL.FINDLAST();
                        PostedDocNo := SalesCrMemoHeaderL."No.";
                        exit(PostedDocNo);
                    end;

                DocumentType::"Credit Memo":
                    begin
                        SalesCrMemoHeaderL.SETRANGE("Pre-Assigned No.", DocumentNo);
                        SalesCrMemoHeaderL.FINDLAST();
                        PostedDocNo := SalesCrMemoHeaderL."No.";
                        exit(PostedDocNo);
                    end;
            end;
        end;
        //HEI.01<<
    end;

    procedure GetPostedDocumentSubtypeCode(var DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; var DocumentNo: Code[20]; var PostedDocumentNo: Code[20]) PostedDocSubtypeCode: Code[10];
    var
        SalesCrMemoHeaderL: Record "Sales Cr.Memo Header";
        SalesHeaderL: Record "Sales Header";
        SalesInvoiceHeaderL: Record "Sales Invoice Header";
    begin
        //HEI.01>>
        SalesHeaderL.SETRANGE("Document Type", DocumentType);
        SalesHeaderL.SETRANGE("No.", DocumentNo);
        if SalesHeaderL.ISEMPTY then begin
            case DocumentType of
                DocumentType::Order, DocumentType::Invoice:
                    begin
                        SalesInvoiceHeaderL.SETRANGE("No.", PostedDocumentNo);
                        SalesInvoiceHeaderL.SETRANGE("Order No.", DocumentNo);
                        SalesInvoiceHeaderL.FINDLAST();
                        PostedDocSubtypeCode := SalesInvoiceHeaderL."Document Subtype Code FND";  // BC Upgrade SHUKLP03
                        exit(PostedDocSubtypeCode);
                    end;

                DocumentType::"Return Order":
                    begin
                        SalesCrMemoHeaderL.SETRANGE("No.", PostedDocumentNo);
                        SalesCrMemoHeaderL.SETRANGE("Return Order No.", DocumentNo);
                        SalesCrMemoHeaderL.FINDLAST();
                        PostedDocSubtypeCode := SalesCrMemoHeaderL."Document Subtype Code FND";  // BC Upgrade SHUKLP03
                        exit(PostedDocSubtypeCode);
                    end;

                DocumentType::"Credit Memo":
                    begin
                        SalesCrMemoHeaderL.SETRANGE("No.", PostedDocumentNo);
                        SalesCrMemoHeaderL.SETRANGE("Pre-Assigned No.", DocumentNo);
                        SalesCrMemoHeaderL.FINDLAST();
                        PostedDocSubtypeCode := SalesCrMemoHeaderL."Document Subtype Code FND";  // BC Upgrade SHUKLP03
                        exit(PostedDocSubtypeCode);
                    end;
            end;
        end;
        //HEI.01<<
    end;
    // BC Upgrade PATELP08 >> Changed the DocumentType parameter datatype of procedure "EmailInvoice" from option to Enum ("Sales Document Type") to align with the calling functions where an enum value is passed, resolving the warning, and enum values were matching with options.
    // local procedure EmailInvoice(var PostedSalesInvNo: Code[20]; var DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; var DocumentNo: Code[20]): Boolean;
    local procedure EmailInvoice(var PostedSalesInvNo: Code[20]; var DocumentType: Enum "Sales Document Type"; var DocumentNo: Code[20]): Boolean;
    // BC Upgrade PATELP08 <<
    var
        //SMTPMailSetupL: Record "SMTP Mail Setup";  // BC Upgrade NANDIS03
        CompanyInformationL: Record "Company Information";
        CustomerL: Record Customer;
        ReportSelectionsL: Record "Report Selections";
        SalesInvoiceHeaderL: Record "Sales Invoice Header";
        FileManagementL: Codeunit "File Management";
        ReportIDL: Integer;
        TextL000: Label 'There is no Sender E-Mail address available neither on "SMTP Mail Setup", nor "Company Information" page. Please add it before sending the E-Mail.';
        TextL001: Label 'There is no E-Mail address available for this %1 - %2 on "Customer Card" page. Please add it before sending the E-Mail.';
        TextL002: Label 'Automatic E-Mail - %1 (%2 - %3)';
        TextL004: Label 'Sales Invoice No. - %1';
        TextL005: Label 'This E-Mail was automatically generated, please do not reply.';
        TextL006: Label 'There is no Report defined on "Report Selection" page to print the Posted Sales Invoice.';
        TextL007: Label 'There is no Posted Sales Invoice found to E-Mail.';
        RecipientsL: Text;
        //SMTPMailL: Codeunit "SMTP Mail";  // BC Upgrade NANDIS03
        SenderEmailL: Text[100];
        FileNamePdfL: Text[250];
        Email: Codeunit Email; // BC Upgrade SHUKLP03 Added<<
        EmailMessage: Codeunit "Email Message";// BC Upgrade SHUKLP03 Added<<
        TempBlob: Codeunit "Temp Blob"; // BC Upgrade SHUKLP03 Added<<
        OutStr: OutStream; // BC Upgrade SHUKLP03 Added<<
        InStr: InStream; // BC Upgrade SHUKLP03 Added<<
        RecRef: RecordRef; // BC Upgrade SHUKLP03 Added<<
    begin
        //HEI.01>>
        // SMTPMailSetupL.GET;
        // CompanyInformationL.GET;
        // if SMTPMailSetupL."User ID" <> '' then
        //     SenderEmailL := SMTPMailSetupL."User ID"
        // else
        //     SenderEmailL := CompanyInformationL."E-Mail";
        // if SenderEmailL = '' then
        //     ERROR(TextL000);

        SalesInvoiceHeaderL.SETRANGE("No.", PostedSalesInvNo);
        SalesInvoiceHeaderL.SETRANGE("Order No.", DocumentNo);
        if SalesInvoiceHeaderL.FINDFIRST() then begin
            ReportSelectionsL.SETRANGE(Usage, ReportSelectionsL.Usage::"S.Invoice");
            ReportSelectionsL.SETFILTER("Report ID", '<>0');
            ReportSelectionsL.SETRANGE("Document Subtype Code FND", SalesInvoiceHeaderL."Document Subtype Code FND");
            if ReportSelectionsL.FINDFIRST() then begin
                ReportIDL := ReportSelectionsL."Report ID";
                CustomerL.GET(SalesInvoiceHeaderL."Bill-to Customer No.");
                RecipientsL := CustomerL."E-Mail";
                if RecipientsL = '' then
                    ERROR(TextL001, CustomerL.FIELDCAPTION("No."), SalesInvoiceHeaderL."Bill-to Customer No.");
                // FileNamePdfL := COPYSTR(FileManagementL.ServerTempFileName('pdf'), 1, 240);
                // REPORT.SAVEASPDF(ReportIDL, FileNamePdfL, SalesInvoiceHeaderL);
                // SMTPMailL.CreateMessage('',
                //                         SenderEmailL,
                //                         RecipientsL,
                //                         STRSUBSTNO(TextL002, SalesInvoiceHeaderL."No.", FORMAT(DocumentType), DocumentNo),
                //                         '',
                //                         true);
                // SMTPMailL.AddAttachment(FileNamePdfL, STRSUBSTNO(TextL004, SalesInvoiceHeaderL."No.") + '_' + FORMAT(TODAY, 0, '<Day,2>-<Month,2>-<Year4>') + '.pdf');
                // SMTPMailL.AppendBody(TextL005);
                // SMTPMailL.AppendBody('<br><br>');
                // SMTPMailL.Send;
                Clear(TempBlob);
                TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
                RecRef.GetTable(SalesInvoiceHeaderL);
                Report.SaveAs(ReportIDL, '', ReportFormat::Pdf, OutStr, RecRef);
                TempBlob.CreateInStream(InStr);
                EmailMessage.Create(RecipientsL,
                                        STRSUBSTNO(TextL002, SalesInvoiceHeaderL."No.", FORMAT(DocumentType), DocumentNo),
                                        '',
                                        true);
                FileNamePdfL := STRSUBSTNO(TextL004, SalesInvoiceHeaderL."No.") + '_' + FORMAT(TODAY, 0, '<Day,2>-<Month,2>-<Year4>') + '.pdf';
                EmailMessage.AddAttachment(FileNamePdfL, 'PDF', InStr);
                EmailMessage.AppendToBody(TextL005);
                EmailMessage.AppendToBody('<br><br>');
                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

                exit(true);
            end else
                ERROR(TextL006);
        end else
            ERROR(TextL007);
        //HEI.01<<  // BC Upgrade NANDIS03
    end;
    // BC Upgrade PATELP08 >> Changed the DocumentType parameter datatype from option to Enum ("Sales Document Type") to align with the calling functions where an enum value is passed, resolving the warning, and enum values were matching with options.
    // local procedure EmailCrMemo(var PostedSalesCMNo: Code[20]; var DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; var DocumentNo: Code[20]): Boolean;
    local procedure EmailCrMemo(var PostedSalesCMNo: Code[20]; var DocumentType: Enum "Sales Document Type"; var DocumentNo: Code[20]): Boolean;
    // BC Upgrade PATELP08 <<
    var
        //SMTPMailSetupL: Record "SMTP Mail Setup";  // BC Upgrade NANDIS03
        CompanyInformationL: Record "Company Information";
        CustomerL: Record Customer;
        ReportSelectionsL: Record "Report Selections";
        SalesCrMemoHeaderL: Record "Sales Cr.Memo Header";
        FileManagementL: Codeunit "File Management";
        ReportIDL: Integer;
        TextL000: Label 'There is no Sender E-Mail address available neither on "SMTP Mail Setup", nor "Company Information" page. Please add it before sending the E-Mail.';
        TextL001: Label 'There is no E-Mail address available for this %1 - %2 on "Customer Card" page. Please add it before sending the E-Mail.';
        TextL002: Label 'Automatic E-Mail - %1 (%2 - %3)';
        TextL004: Label 'Sales Credit Memo No. - %1';
        TextL005: Label 'This E-Mail was automatically generated, please do not reply.';
        TextL006: Label 'There is no Report defined on "Report Selection" page to print the Posted Sales Credit Memo.';
        TextL007: Label 'There is no Posted Sales Credit Memo found to E-Mail.';
        RecipientsL: Text;
        //SMTPMailL: Codeunit "SMTP Mail";  // BC Upgrade NANDIS03
        SenderEmailL: Text[100];
        FileNamePdfL: Text[250];
        Email: Codeunit Email; // BC Upgrade SHUKLP03 Added<<
        EmailMessage: Codeunit "Email Message";// BC Upgrade SHUKLP03 Added<<
        TempBlob: Codeunit "Temp Blob"; // BC Upgrade SHUKLP03 Added<<
        OutStr: OutStream; // BC Upgrade SHUKLP03 Added<<
        InStr: InStream; // BC Upgrade SHUKLP03 Added<<
        RecRef: RecordRef; // BC Upgrade SHUKLP03 Added<<
    begin
        // //HEI.01>>
        // SMTPMailSetupL.GET;
        // CompanyInformationL.GET;
        // if SMTPMailSetupL."User ID" <> '' then
        //     SenderEmailL := SMTPMailSetupL."User ID"
        // else
        //     SenderEmailL := CompanyInformationL."E-Mail";
        // if SenderEmailL = '' then
        //     ERROR(TextL000);

        SalesCrMemoHeaderL.SETRANGE("No.", PostedSalesCMNo);
        if DocumentType = DocumentType::"Return Order" then
            SalesCrMemoHeaderL.SETRANGE("Return Order No.", DocumentNo);
        if SalesCrMemoHeaderL.FINDFIRST() then begin
            ReportSelectionsL.SETRANGE(Usage, ReportSelectionsL.Usage::"S.Cr.Memo");
            ReportSelectionsL.SETFILTER("Report ID", '<>0');
            ReportSelectionsL.SETRANGE("Document Subtype Code FND", SalesCrMemoHeaderL."Document Subtype Code FND");
            if ReportSelectionsL.FINDFIRST() then begin
                ReportIDL := ReportSelectionsL."Report ID";
                CustomerL.GET(SalesCrMemoHeaderL."Bill-to Customer No.");
                RecipientsL := CustomerL."E-Mail";
                if RecipientsL = '' then
                    ERROR(TextL001, CustomerL.FIELDCAPTION("No."), SalesCrMemoHeaderL."Bill-to Customer No.");
                // FileNamePdfL := COPYSTR(FileManagementL.ServerTempFileName('pdf'), 1, 240);
                // REPORT.SAVEASPDF(ReportIDL, FileNamePdfL, SalesCrMemoHeaderL);
                // SMTPMailL.CreateMessage('',
                //                         SenderEmailL,
                //                         RecipientsL,
                //                         STRSUBSTNO(TextL002, SalesCrMemoHeaderL."No.", FORMAT(DocumentType), DocumentNo),
                //                         '',
                //                         true);
                // SMTPMailL.AddAttachment(FileNamePdfL, STRSUBSTNO(TextL004, SalesCrMemoHeaderL."No.") + '_' + FORMAT(TODAY, 0, '<Day,2>-<Month,2>-<Year4>') + '.pdf');
                // SMTPMailL.AppendBody(TextL005);
                // SMTPMailL.AppendBody('<br><br>');
                // SMTPMailL.Send;
                Clear(TempBlob);
                TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
                RecRef.GetTable(SalesCrMemoHeaderL);
                Report.SaveAs(ReportIDL, '', ReportFormat::Pdf, OutStr, RecRef);
                TempBlob.CreateInStream(InStr);
                EmailMessage.Create(RecipientsL,
                                        STRSUBSTNO(TextL002, SalesCrMemoHeaderL."No.", FORMAT(DocumentType), DocumentNo),
                                        '',
                                        true);
                FileNamePdfL := STRSUBSTNO(TextL004, SalesCrMemoHeaderL."No.") + '_' + FORMAT(TODAY, 0, '<Day,2>-<Month,2>-<Year4>') + '.pdf';
                EmailMessage.AddAttachment(FileNamePdfL, 'PDF', InStr);
                EmailMessage.AppendToBody(TextL005);
                EmailMessage.AppendToBody('<br><br>');
                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

                exit(true);
            end else
                ERROR(TextL006);
        end else
            ERROR(TextL007);
        //HEI.01<<  // BC Upgrade NANDIS03
    end;
    // BC Upgrade PATELP08 >> Changed the DocumentType parameter datatype from option to Enum ("Sales Document Type") to align with the calling functions where an enum value is passed, resolving the warning, and enum values were matching with options.
    // local procedure PrintInvoice(var PostedSalesInvNo: Code[20]; var DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; var DocumentNo: Code[20]): Boolean;
    local procedure PrintInvoice(var PostedSalesInvNo: Code[20]; var DocumentType: Enum "Sales Document Type"; var DocumentNo: Code[20]): Boolean;
    // BC Upgrade PATELP08 <<
    var
        LocationL: Record Location;
        ReportSelectionsL: Record "Report Selections";
        SalesInvoiceHeaderL: Record "Sales Invoice Header";
        InitServerPrinterTableL: Codeunit "Init. Server Printer Table";
        RecRef: RecordRef;
        TextL000: Label 'There is no Printer selected on Location Card - %1.';
        TextL001: Label 'There is no Report defined on "Report Selection" page to print the Posted Sales Invoice.';
        TextL002: Label 'There is no Posted Sales Invoice found to Print.';
    begin
        //HEI.01>>
        SalesInvoiceHeaderL.SETRANGE("No.", PostedSalesInvNo);
        SalesInvoiceHeaderL.SETRANGE("Order No.", DocumentNo);
        if SalesInvoiceHeaderL.FINDFIRST() then begin
            LocationL.GET(SalesInvoiceHeaderL."Location Code");
            RecRef.GETTABLE(SalesInvoiceHeaderL);
            if LocationL."Printer Name FND" = '' then
                ERROR(TextL000, LocationL.Code)
            else
                InitServerPrinterTableL.ValidatePrinterName(LocationL."Printer Name FND");
            ReportSelectionsL.SETRANGE(Usage, ReportSelectionsL.Usage::"S.Invoice");
            ReportSelectionsL.SETFILTER("Report ID", '<>0');
            ReportSelectionsL.SETRANGE("Document Subtype Code FND", SalesInvoiceHeaderL."Document Subtype Code FND");  // BC Upgrade SHUKLP03
            if ReportSelectionsL.FINDFIRST() then begin
                REPORT.PRINT(ReportSelectionsL."Report ID", '', LocationL."Printer Name FND", RecRef);
                exit(true);
            end else
                ERROR(TextL001);
        end else
            ERROR(TextL002);
        //HEI.01<<
    end;
    // BC Upgrade PATELP08 >> Changed the DocumentType parameter datatype from option to Enum ("Sales Document Type") to align with the calling functions where an enum value is passed, resolving the warning, and enum values were matching with options.
    // local procedure PrintCrMemo(var PostedSalesCMNo: Code[20]; var DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; var DocumentNo: Code[20]): Boolean;
    local procedure PrintCrMemo(var PostedSalesCMNo: Code[20]; var DocumentType: Enum "Sales Document Type"; var DocumentNo: Code[20]): Boolean;
    // BC Upgrade PATELP08 <<
    var
        LocationL: Record Location;
        ReportSelectionsL: Record "Report Selections";
        SalesCrMemoHeaderL: Record "Sales Cr.Memo Header";
        InitServerPrinterTableL: Codeunit "Init. Server Printer Table";
        RecRef: RecordRef;
        TextL000: Label 'There is no Printer selected on Location Card - %1.';
        TextL001: Label 'There is no Report defined on "Report Selection" page to print the Posted Sales Credit Memo.';
        TextL002: Label 'There is no Posted Sales Credit Memo found to Print.';
    begin
        //HEI.01>>
        SalesCrMemoHeaderL.SETRANGE("No.", PostedSalesCMNo);
        if DocumentType = DocumentType::"Return Order" then
            SalesCrMemoHeaderL.SETRANGE("Return Order No.", DocumentNo);
        if SalesCrMemoHeaderL.FINDFIRST() then begin
            LocationL.GET(SalesCrMemoHeaderL."Location Code");
            RecRef.GETTABLE(SalesCrMemoHeaderL);
            if LocationL."Printer Name FND" = '' then
                ERROR(TextL000, LocationL.Code)
            else
                InitServerPrinterTableL.ValidatePrinterName(LocationL."Printer Name FND");
            ReportSelectionsL.SETRANGE(Usage, ReportSelectionsL.Usage::"S.Cr.Memo");
            ReportSelectionsL.SETFILTER("Report ID", '<>0');
            ReportSelectionsL.SETRANGE("Document Subtype Code FND", SalesCrMemoHeaderL."Document Subtype Code FND");  // BC Upgrade SHUKLP03
            if ReportSelectionsL.FINDFIRST() then begin
                REPORT.PRINT(ReportSelectionsL."Report ID", '', LocationL."Printer Name FND", RecRef);
                exit(true);
            end else
                ERROR(TextL001);
        end else
            ERROR(TextL002);
        //HEI.01<<
    end;
    // BC Upgrade PATELP08 >> Changed the DocumentType parameter datatype from option to Enum ("Sales Document Type") to align with the calling functions where an enum value is passed, resolving the warning, and enum values were matching with options.
    // local procedure LogisticsEmailInvoice(var PostedSalesInvNo: Code[20]; var DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; var DocumentNo: Code[20]): Boolean;
    local procedure LogisticsEmailInvoice(var PostedSalesInvNo: Code[20]; var DocumentType: Enum "Sales Document Type"; var DocumentNo: Code[20]): Boolean;
    // BC Upgrade PATELP08 <<
    var
        //SMTPMailSetupL: Record "SMTP Mail Setup";  // BC Upgrade NANDIS03
        CompanyInformationL: Record "Company Information";
        LocationL: Record Location;
        ReportSelectionsL: Record "Report Selections";
        SalesInvoiceHeaderL: Record "Sales Invoice Header";
        FileManagementL: Codeunit "File Management";
        ReportIDL: Integer;
        TextL000: Label 'There is no Sender E-Mail address available neither on "SMTP Mail Setup", nor "Company Information" page. Please add it before sending the E-Mail.';
        TextL001: Label 'There is no Logistics E-Mail address available for this Location Code - %1 on "Location Card" page. Please add it before sending the E-Mail.';
        TextL002: Label 'Automatic Logistics E-Mail - %1 (%2 - %3)';
        TextL004: Label 'Sales Invoice No. - %1';
        TextL005: Label 'This E-Mail was automatically generated, please do not reply.';
        TextL006: Label 'There is no Report defined on "Report Selection" page to print the Posted Sales Invoice.';
        TextL007: Label 'There is no Posted Sales Invoice found to E-Mail.';
        RecipientsL: Text;
        //SMTPMailL: Codeunit "SMTP Mail";  // BC Upgrade NANDIS03
        Email: Codeunit Email; // BC Upgrade SHUKLP03 Added<<
        EmailMessage: Codeunit "Email Message";// BC Upgrade SHUKLP03 Added<<
        TempBlob: Codeunit "Temp Blob"; // BC Upgrade SHUKLP03 Added<<
        OutStr: OutStream; // BC Upgrade SHUKLP03 Added<<
        InStr: InStream; // BC Upgrade SHUKLP03 Added<<
        RecRef: RecordRef; // BC Upgrade SHUKLP03 Added<<
        SenderEmailL: Text[100];
        FileNamePdfL: Text[250];
    begin
        //HEI.01>>
        // SMTPMailSetupL.GET;
        // CompanyInformationL.GET();
        // if SMTPMailSetupL."User ID" <> '' then
        //     SenderEmailL := SMTPMailSetupL."User ID"
        // else
        //     SenderEmailL := CompanyInformationL."E-Mail";
        // if SenderEmailL = '' then
        //     ERROR(TextL000);

        SalesInvoiceHeaderL.SETRANGE("No.", PostedSalesInvNo);
        SalesInvoiceHeaderL.SETRANGE("Order No.", DocumentNo);
        if SalesInvoiceHeaderL.FINDFIRST() then begin
            ReportSelectionsL.SETRANGE(Usage, ReportSelectionsL.Usage::"S.Invoice");
            ReportSelectionsL.SETFILTER("Report ID", '<>0');
            ReportSelectionsL.SETRANGE("Document Subtype Code FND", SalesInvoiceHeaderL."Document Subtype Code FND");
            if ReportSelectionsL.FINDFIRST() then begin
                ReportIDL := ReportSelectionsL."Report ID";
                LocationL.GET(SalesInvoiceHeaderL."Location Code");
                if LocationL."Logistics E-Mail FND" = '' then
                    ERROR(TextL001, LocationL.Code)
                else
                    RecipientsL := LocationL."Logistics E-Mail FND";

                Clear(TempBlob);
                TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
                RecRef.GetTable(SalesInvoiceHeaderL);
                Report.SaveAs(ReportIDL, '', ReportFormat::Pdf, OutStr, RecRef);
                //Report.SaveAs(ReportIDL, FileNamePdfL, SalesInvoiceHeaderL);
                TempBlob.CreateInStream(InStr);

                // FileNamePdfL := COPYSTR(FileManagementL.ServerTempFileName('pdf'), 1, 240);
                // REPORT.SAVEASPDF(ReportIDL, FileNamePdfL, SalesInvoiceHeaderL);
                EmailMessage.Create(RecipientsL,
                                        STRSUBSTNO(TextL002, SalesInvoiceHeaderL."No.", FORMAT(DocumentType), DocumentNo),
                                        '',
                                        true);
                FileNamePdfL := STRSUBSTNO(TextL004, SalesInvoiceHeaderL."No.") + '_' + FORMAT(TODAY, 0, '<Day,2>-<Month,2>-<Year4>') + '.pdf';
                EmailMessage.AddAttachment(FileNamePdfL, 'PDF', InStr);
                EmailMessage.AppendToBody(TextL005);
                EmailMessage.AppendToBody('<br><br>');
                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

                exit(true);
            end else
                ERROR(TextL006);
        end else
            ERROR(TextL007);
        //HEI.01<<  
    end;
    // BC Upgrade PATELP08 >> Changed the DocumentType parameter datatype from option to Enum ("Sales Document Type") to align with the calling functions where an enum value is passed, resolving the warning, and enum values were matching with options.
    // local procedure LogisticsEmailCrMemo(var PostedSalesCMNo: Code[20]; var DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; var DocumentNo: Code[20]): Boolean;
    local procedure LogisticsEmailCrMemo(var PostedSalesCMNo: Code[20]; var DocumentType: Enum "Sales Document Type"; var DocumentNo: Code[20]): Boolean;
    // BC Upgrade PATELP08 <<
    var
        //SMTPMailSetupL: Record "SMTP Mail Setup";  // BC Upgrade NANDIS03
        CompanyInformationL: Record "Company Information";
        LocationL: Record Location;
        ReportSelectionsL: Record "Report Selections";
        SalesCrMemoHeaderL: Record "Sales Cr.Memo Header";
        FileManagementL: Codeunit "File Management";
        ReportIDL: Integer;
        TextL000: Label 'There is no Sender E-Mail address available neither on "SMTP Mail Setup", nor "Company Information" page. Please add it before sending the E-Mail.';
        TextL001: Label 'There is no Logistics E-Mail address available for this Location Code - %1 on "Location Card" page. Please add it before sending the E-Mail.';
        TextL002: Label 'Automatic Logistics E-Mail - %1 (%2 - %3)';
        TextL004: Label 'Sales Credit Memo No. - %1';
        TextL005: Label 'This E-Mail was automatically generated, please do not reply.';
        TextL006: Label 'There is no Report defined on "Report Selection" page to print the Posted Sales Credit Memo.';
        TextL007: Label 'There is no Posted Sales Credit Memo found to E-Mail.';
        RecipientsL: Text;
        //SMTPMailL: Codeunit "SMTP Mail";  // BC Upgrade NANDIS03
        SenderEmailL: Text[100];
        FileNamePdfL: Text[250];
        Email: Codeunit Email; // BC Upgrade SHUKLP03 Added<<
        EmailMessage: Codeunit "Email Message";// BC Upgrade SHUKLP03 Added<<
        TempBlob: Codeunit "Temp Blob"; // BC Upgrade SHUKLP03 Added<<
        OutStr: OutStream; // BC Upgrade SHUKLP03 Added<<
        InStr: InStream; // BC Upgrade SHUKLP03 Added<<
        RecRef: RecordRef; // BC Upgrade SHUKLP03 Added<<

    begin
        // //HEI.01>>
        // SMTPMailSetupL.GET;
        // CompanyInformationL.GET;
        // if SMTPMailSetupL."User ID" <> '' then
        //     SenderEmailL := SMTPMailSetupL."User ID"
        // else
        //     SenderEmailL := CompanyInformationL."E-Mail";
        // if SenderEmailL = '' then
        //     ERROR(TextL000);

        SalesCrMemoHeaderL.SETRANGE("No.", PostedSalesCMNo);
        if DocumentType = DocumentType::"Return Order" then
            SalesCrMemoHeaderL.SETRANGE("Return Order No.", DocumentNo);
        if SalesCrMemoHeaderL.FINDFIRST() then begin
            ReportSelectionsL.SETRANGE(Usage, ReportSelectionsL.Usage::"S.Cr.Memo");
            ReportSelectionsL.SETFILTER("Report ID", '<>0');
            ReportSelectionsL.SETRANGE("Document Subtype Code FND", SalesCrMemoHeaderL."Document Subtype Code FND");
            if ReportSelectionsL.FINDFIRST() then begin
                ReportIDL := ReportSelectionsL."Report ID";
                LocationL.GET(SalesCrMemoHeaderL."Location Code");
                if LocationL."Logistics E-Mail FND" = '' then
                    ERROR(TextL001, LocationL.Code)
                else
                    RecipientsL := LocationL."Logistics E-Mail FND";
                //FileNamePdfL := COPYSTR(FileManagementL.ServerTempFileName('pdf'), 1, 240);
                // REPORT.SAVEASPDF(ReportIDL, FileNamePdfL, SalesCrMemoHeaderL);
                // SMTPMailL.CreateMessage('',
                //                         SenderEmailL,
                //                         RecipientsL,
                //                         STRSUBSTNO(TextL002, SalesCrMemoHeaderL."No.", FORMAT(DocumentType), DocumentNo),
                //                         '',
                //                         true);
                // SMTPMailL.AddAttachment(FileNamePdfL, STRSUBSTNO(TextL004, SalesCrMemoHeaderL."No.") + '_' + FORMAT(TODAY, 0, '<Day,2>-<Month,2>-<Year4>') + '.pdf');
                // SMTPMailL.AppendBody(TextL005);
                // SMTPMailL.AppendBody('<br><br>');
                // SMTPMailL.Send;
                Clear(TempBlob);
                TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
                RecRef.GetTable(SalesCrMemoHeaderL);
                Report.SaveAs(ReportIDL, '', ReportFormat::Pdf, OutStr, RecRef);
                TempBlob.CreateInStream(InStr);
                EmailMessage.Create(RecipientsL,
                                        STRSUBSTNO(TextL002, SalesCrMemoHeaderL."No.", FORMAT(DocumentType), DocumentNo),
                                        '',
                                        true);
                FileNamePdfL := STRSUBSTNO(TextL004, SalesCrMemoHeaderL."No.") + '_' + FORMAT(TODAY, 0, '<Day,2>-<Month,2>-<Year4>') + '.pdf';
                EmailMessage.AddAttachment(FileNamePdfL, 'pdf', InStr);
                EmailMessage.AppendToBody(TextL005);
                EmailMessage.AppendToBody('<br><br>');
                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                exit(true);
            end else
                ERROR(TextL006);
        end else
            ERROR(TextL007);
        // //HEI.01<<  // BC Upgrade NANDIS03
    end;

    procedure UpdateJQEntryAfterManualPrint(DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocumentNo: Code[20]; PostedDocumentNo: Code[20]; xPrintCount: Integer; PrintCount: Integer);
    var
        JobQueueEntryL: Record "Job Queue Entry";
        SalesReceivablesSetupL: Record "Sales & Receivables Setup";
    begin
        //HEI.02>>
        if (xPrintCount = PrintCount) or (xPrintCount > PrintCount) then
            exit;
        SalesReceivablesSetupL.GET();
        if not SalesReceivablesSetupL."Enable OTC Billing Auto. FND" then
            exit;
        JobQueueEntryL.SETRANGE("Object Type to Run", JobQueueEntryL."Object Type to Run"::Codeunit);
        JobQueueEntryL.SETRANGE("Object ID to Run", CODEUNIT::"Sales Post via Job Queue");
        JobQueueEntryL.SETRANGE("Document Type FND", DocumentType);
        JobQueueEntryL.SETRANGE("Document No. FND", DocumentNo);
        JobQueueEntryL.SETRANGE("Posted Document No. FND", PostedDocumentNo);
        JobQueueEntryL.SETRANGE("JQ Posted FND", true);
        JobQueueEntryL.SETRANGE("JQ Logistics Mail Sent FND", true);
        JobQueueEntryL.SETRANGE("JQ Printed FND", false);
        JobQueueEntryL.SETRANGE("Recurring Job", false);
        JobQueueEntryL.SETFILTER(Status, '%1|%2', JobQueueEntryL.Status::Error, JobQueueEntryL.Status::"On Hold");
        JobQueueEntryL.SETFILTER("Error Message", '<>%1', '');
        JobQueueEntryL.SETFILTER("Send Document FND", '%1|%2', JobQueueEntryL."Send Document FND"::"Mail & Print", JobQueueEntryL."Send Document FND"::Print);
        if JobQueueEntryL.FINDFIRST() then begin
            if JobQueueEntryL."Send Document FND" = JobQueueEntryL."Send Document FND"::"Mail & Print" then
                JobQueueEntryL.SETRANGE("JQ Mail Sent FND", true);
            if JobQueueEntryL.FINDFIRST() then
                JobQueueEntryL.DELETE();
        end;
        //HEI.02<<
    end;
}

