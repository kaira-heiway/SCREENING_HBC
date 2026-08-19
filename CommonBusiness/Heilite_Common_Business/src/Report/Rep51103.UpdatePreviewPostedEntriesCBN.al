report 51103 "Update PreviewPostedEntriesCBN"
{
    // HEI.01 CHG2343884 IBM SAHAL01 13.03.2026 Preview posting blocked on the production
    // # Created New Report: 50626 - Update Preview Posted Entries

    // BC Upgrade PATES08 >>
    // # Object Created
    // # NAV ID : 50626
    // BC Upgrade PATES08 <<

    ApplicationArea = All;
    Caption = 'Update Preview Posted Entries';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    Permissions = TableData "G/L Entry"=rimd,TableData "Vendor Ledger Entry"=rimd,TableData "Purch. Inv. Header"=rimd,TableData "Purch. Inv. Line"=rimd,TableData "Purch. Cr. Memo Hdr."=rimd,TableData "Purch. Cr. Memo Line"=rimd,TableData "VAT Entry"=rimd,TableData "Detailed Vendor Ledg. Entry"=rimd,TableData "FA Ledger Entry"=rimd,TableData "Value Entry"=rimd,TableData "Purchase Additional Fields FND"=rimd,TableData "WHT Entry FND"=rimd,TableData "Purch. Inv. Header Add FND"=rimd,TableData "Purch. Cr. Memo Hdr. Add FND"=rimd;
    dataset
    {
        dataitem(PurchInvHeader; "Purch. Inv. Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);

            trigger OnPreDataItem()
            var
                PurchInvHeaderL	: Record "Purch. Inv. Header";
                PurchInvLineL : Record "Purch. Inv. Line";
                PurchInvHeaderAddL : Record	"Purch. Inv. Header Add FND";	
                NewPurchInvHeaderL : Record	"Purch. Inv. Header";
                NewPurchInvLineL : Record "Purch. Inv. Line";
                NewPurchInvHeaderAddL : Record	"Purch. Inv. Header Add FND";	
            begin
                //HEI.01>>
                IF ExecutedFor <> ExecutedFor::"Posted Invoice" THEN
                    CurrReport.BREAK;

                PurchInvHeaderL.SETFILTER("No.",'=%1',ExistingDocNo);
                PurchInvLineL.SETFILTER("Document No.",'=%1',ExistingDocNo);
                PurchInvHeaderAddL.SETFILTER("No.",'=%1',ExistingDocNo);

                IF CountOnly THEN BEGIN
                    IF PurchInvHeaderL.FINDFIRST THEN
                        MESSAGE('%1 %2',PurchInvHeaderL.COUNT,PurchInvHeaderL.TABLECAPTION);

                    IF PurchInvLineL.FINDSET(FALSE) THEN
                        MESSAGE('%1 %2',PurchInvLineL.COUNT,PurchInvLineL.TABLECAPTION);

                    IF PurchInvHeaderAddL.FINDFIRST THEN
                        MESSAGE('%1 %2',PurchInvHeaderAddL.COUNT,PurchInvHeaderAddL.TABLECAPTION);

                    CountInvoiceLedger;
                END ELSE BEGIN
                    UpdateInvoiceLedger;

                    IF PurchInvHeaderAddL.FINDFIRST THEN BEGIN
                        NewPurchInvHeaderAddL.INIT;
                        NewPurchInvHeaderAddL."No." := NewDocNo;
                        NewPurchInvHeaderAddL.TRANSFERFIELDS(PurchInvHeaderAddL);
                        NewPurchInvHeaderAddL."No." := NewDocNo;
                        NewPurchInvHeaderAddL.INSERT(FALSE);
                        PurchInvHeaderAddL.DELETE(TRUE);
                    END;

                    IF PurchInvLineL.FINDSET(TRUE) THEN BEGIN
                        REPEAT
                        NewPurchInvLineL.INIT;
                        NewPurchInvLineL."Document No." := NewDocNo;
                        NewPurchInvLineL.TRANSFERFIELDS(PurchInvLineL);
                        NewPurchInvLineL."Document No." := NewDocNo;
                        NewPurchInvLineL.INSERT(FALSE);
                        PurchInvLineL.DELETE(TRUE);
                        UNTIL PurchInvLineL.NEXT = 0;
                    END;

                    IF PurchInvHeaderL.FINDFIRST THEN BEGIN
                        NewPurchInvHeaderL.INIT;
                        NewPurchInvHeaderL."No." := NewDocNo;
                        NewPurchInvHeaderL.TRANSFERFIELDS(PurchInvHeaderL);
                        NewPurchInvHeaderL."No." := NewDocNo;
                        NewPurchInvHeaderL.INSERT(FALSE);
                        PurchInvHeaderL.DELETE(TRUE);
                    END;
                END;
                //HEI.01<<
            end;
        }

        dataitem(PurchCrMemoHdr; "Purch. Cr. Memo Hdr.")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);

                trigger OnPreDataItem()
                var 
                    PurchCrMemoHdrL	: Record "Purch. Cr. Memo Hdr.";	
                    PurchCrMemoLineL : Record "Purch. Cr. Memo Line";	
                    PurchCrMemoHdrAddL : Record "Purch. Cr. Memo Hdr. Add FND";	
                    NewPurchCrMemoHdrL : Record "Purch. Cr. Memo Hdr.";	
                    NewPurchCrMemoLineL : Record "Purch. Cr. Memo Line";	
                    NewPurchCrMemoHdrAddL : Record "Purch. Cr. Memo Hdr. Add FND";	
                begin
                    //HEI.01>>
                    IF ExecutedFor <> ExecutedFor::"Posted Cr. Memo" THEN
                        CurrReport.BREAK;

                    PurchCrMemoHdrL.SETFILTER("No.",'=%1',ExistingDocNo);
                    PurchCrMemoLineL.SETFILTER("Document No.",'=%1',ExistingDocNo);
                    PurchCrMemoHdrAddL.SETFILTER("No.",'=%1',ExistingDocNo);

                    IF CountOnly THEN BEGIN
                        IF PurchCrMemoHdrL.FINDFIRST THEN
                            MESSAGE('%1 %2',PurchCrMemoHdrL.COUNT,PurchCrMemoHdrL.TABLECAPTION);

                        IF PurchCrMemoLineL.FINDSET(FALSE) THEN
                            MESSAGE('%1 %2',PurchCrMemoLineL.COUNT,PurchCrMemoLineL.TABLECAPTION);

                        IF PurchCrMemoHdrAddL.FINDFIRST THEN
                            MESSAGE('%1 %2',PurchCrMemoHdrAddL.COUNT,PurchCrMemoHdrAddL.TABLECAPTION);

                        CountCrMemoLedger;
                    END ELSE BEGIN
                        UpdateCrMemoLedger;

                        IF PurchCrMemoHdrAddL.FINDFIRST THEN BEGIN
                            NewPurchCrMemoHdrAddL.INIT;
                            NewPurchCrMemoHdrAddL."No." := NewDocNo;
                            NewPurchCrMemoHdrAddL.TRANSFERFIELDS(PurchCrMemoHdrAddL);
                            NewPurchCrMemoHdrAddL."No." := NewDocNo;
                            NewPurchCrMemoHdrAddL.INSERT(FALSE);
                            PurchCrMemoHdrAddL.DELETE(TRUE);
                        END;

                        IF PurchCrMemoLineL.FINDSET(TRUE) THEN BEGIN
                            REPEAT
                            NewPurchCrMemoLineL.INIT;
                            NewPurchCrMemoLineL."Document No." := NewDocNo;
                            NewPurchCrMemoLineL.TRANSFERFIELDS(PurchCrMemoLineL);
                            NewPurchCrMemoLineL."Document No." := NewDocNo;
                            NewPurchCrMemoLineL.INSERT(FALSE);
                            PurchCrMemoLineL.DELETE(TRUE);
                            UNTIL PurchCrMemoLineL.NEXT = 0;
                        END;

                        IF PurchCrMemoHdrL.FINDFIRST THEN BEGIN
                            NewPurchCrMemoHdrL.INIT;
                            NewPurchCrMemoHdrL."No." := NewDocNo;
                            NewPurchCrMemoHdrL.TRANSFERFIELDS(PurchCrMemoHdrL);
                            NewPurchCrMemoHdrL."No." := NewDocNo;
                            NewPurchCrMemoHdrL.INSERT(FALSE);
                            PurchCrMemoHdrL.DELETE(TRUE);
                        END;
                    END;
                    //HEI.01<<
                end;

        }

    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(CountOnly; CountOnly)
                    {
                        ApplicationArea = All;
                        Caption = 'Count Only';
                    }

                    field(ExecutedFor; ExecutedFor)
                    {
                        ApplicationArea = All;
                        Caption = 'Executed For';

                        trigger OnValidate()
                        begin
                            //HEI.01>>
                            CLEAR(ExistingDocNo);
                            CLEAR(NewDocNo);
                            CLEAR(PostingDate);
                            CLEAR(ExternalDocNo);
                            //HEI.01<<
                        end;
                    }

                    field(ExistingDocNo; ExistingDocNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Existing Document No.';

                        trigger OnValidate()
                        var
                            PurchInvHeaderL : Record "Purch. Inv. Header";
                            PurchCrMemoHdrL : Record "Purch. Cr. Memo Hdr.";	
                        begin
                            //HEI.01>>
                            CLEAR(PostingDate);
                            CLEAR(ExternalDocNo);
                            NewDocNo := '***';
                            CASE ExecutedFor OF
                            ExecutedFor::"Posted Invoice" : BEGIN
                                PurchInvHeaderL.SETFILTER("No.",'=%1',NewDocNo);
                                IF PurchInvHeaderL.FINDFIRST THEN BEGIN
                                PostingDate := PurchInvHeaderL."Posting Date";
                                ExternalDocNo := PurchInvHeaderL."Vendor Invoice No.";
                                END;
                            END;
                            ExecutedFor::"Posted Cr. Memo" : BEGIN
                                PurchCrMemoHdrL.SETFILTER("No.",'=%1',NewDocNo);
                                IF PurchCrMemoHdrL.FINDFIRST THEN BEGIN
                                PostingDate := PurchCrMemoHdrL."Posting Date";
                                ExternalDocNo := PurchCrMemoHdrL."Vendor Cr. Memo No.";
                                END;
                            END;
                            END;
                            //HEI.01<<
                        end;
                    }

                    field(NewDocNo; NewDocNo)
                    {
                        ApplicationArea = All;
                        Caption = 'New Document No.';

                        trigger OnValidate()
                        var
                            PurchInvHeaderL : Record "Purch. Inv. Header";
                            PurchCrMemoHdrL : Record "Purch. Cr. Memo Hdr.";
                        begin
                            //HEI.01>>
                            CLEAR(PostingDate);
                            CLEAR(ExternalDocNo);
                            CASE ExecutedFor OF
                            ExecutedFor::"Posted Invoice" : BEGIN
                                PurchInvHeaderL.SETFILTER("No.",'=%1',NewDocNo);
                                IF PurchInvHeaderL.FINDFIRST THEN BEGIN
                                PostingDate := PurchInvHeaderL."Posting Date";
                                ExternalDocNo := PurchInvHeaderL."Vendor Invoice No.";
                                END;
                            END;
                            ExecutedFor::"Posted Cr. Memo" : BEGIN
                                PurchCrMemoHdrL.SETFILTER("No.",'=%1',NewDocNo);
                                IF PurchCrMemoHdrL.FINDFIRST THEN BEGIN
                                PostingDate := PurchCrMemoHdrL."Posting Date";
                                ExternalDocNo := PurchCrMemoHdrL."Vendor Cr. Memo No.";
                                END;
                            END;
                            END;
                            //HEI.01<<
                        end;
                    }

                    field(PostingDate; PostingDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Posting Date';
                    }

                    field(ExternalDocNo; ExternalDocNo)
                    {
                        ApplicationArea = All;
                        Caption = 'External Document No.';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }

        trigger OnInit()
        begin
            //HEI.01>>
            CLEAR(CountOnly);
            CLEAR(ExecutedFor);
            CLEAR(ExistingDocNo);
            CLEAR(NewDocNo);
            CLEAR(PostingDate);
            CLEAR(ExternalDocNo);
            //HEI.01<<
        end;

    }

   

    trigger OnPreReport()
    begin
        //HEI.01>>
        CASE ExecutedFor OF
            ExecutedFor::" " :
                ERROR(Text000,ExecutedFor::"Posted Invoice",ExecutedFor::"Posted Cr. Memo");
            ExecutedFor::"Posted Invoice" : BEGIN
                IF ExistingDocNo = NewDocNo THEN
                ERROR(Text001);
                IF (PostingDate = 0D) AND (ExternalDocNo = '') THEN
                ERROR(Text002);
                IF GUIALLOWED THEN
                IF NOT CONFIRM(Text003,TRUE,FORMAT(ExecutedFor),ExistingDocNo,NewDocNo) THEN
                    ERROR('');
            END;
            ExecutedFor::"Posted Cr. Memo" : BEGIN
                IF ExistingDocNo = NewDocNo THEN
                ERROR(Text001);
                IF (PostingDate = 0D) AND (ExternalDocNo = '') THEN
                ERROR(Text002);
                IF GUIALLOWED THEN
                IF NOT CONFIRM(Text003,TRUE,FORMAT(ExecutedFor),ExistingDocNo,NewDocNo) THEN
                    ERROR('');
            END;
        END;
        //HEI.01<<

    end;

    

 
    var
        CountOnly : Boolean;
        ExecutedFor : Option  " ","Posted Invoice","Posted Cr. Memo";
        ExistingDocNo : Code[20];
        NewDocNo : Code[20];
        PostingDate : Date;
        ExternalDocNo : Code[35];
        Text000 : Label 'Please select the report option to be executed for the "%1" Or "%2".';
        Text001 : Label 'Please enter a correct "Existing Document No." and "New Document No.". Both are not be same.';
        Text002 : Label 'Please enter a "Posting Date" and or an "External Document No." to update the correct data.';
        Text003 : Label 'Do you want to update this existing "%1 No." - ''%2'' to this new "%1 No." - ''%3''?';

    LOCAL procedure CountInvoiceLedger()
    var
        PurchaseAdditionalFieldsL : Record "Purchase Additional Fields FND";
        GLEntryL : Record "G/L Entry";        
        VATEntryL : Record	"VAT Entry";
        VendorLedgerEntryL : Record	"Vendor Ledger Entry";	
        DetailedVendorLedgEntryL : Record	"Detailed Vendor Ledg. Entry";
        WHTEntryL : Record	"WHT Entry FND";
        ValueEntryL : Record "Value Entry";
        FALedgerEntryL : Record	"FA Ledger Entry";
    begin
        //HEI.01>>
        IF ExecutedFor <> ExecutedFor::"Posted Invoice" THEN
            EXIT;

        PurchaseAdditionalFieldsL.SETCURRENTKEY("Document No.",TableID,"Document Type");
        PurchaseAdditionalFieldsL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        PurchaseAdditionalFieldsL.SETRANGE(TableID,DATABASE::"Purch. Inv. Header");
        PurchaseAdditionalFieldsL.SETRANGE("Document Type",PurchaseAdditionalFieldsL."Document Type"::"Posted Invoice");
        IF PurchaseAdditionalFieldsL.FINDFIRST THEN
            MESSAGE('%1 %2',PurchaseAdditionalFieldsL.COUNT,PurchaseAdditionalFieldsL.TABLECAPTION);

        GLEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        GLEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        GLEntryL.SETFILTER("Document Type",'<>%1',GLEntryL."Document Type"::"Credit Memo");
        IF PostingDate <> 0D THEN
            GLEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
            GLEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF GLEntryL.FINDSET(FALSE) THEN
            MESSAGE('%1 %2',GLEntryL.COUNT,GLEntryL.TABLECAPTION);

        VATEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        VATEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        VATEntryL.SETFILTER("Document Type",'<>%1',VATEntryL."Document Type"::"Credit Memo");
        IF PostingDate <> 0D THEN
            VATEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
            VATEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF VATEntryL.FINDSET(FALSE) THEN
            MESSAGE('%1 %2',VATEntryL.COUNT,VATEntryL.TABLECAPTION);

        VendorLedgerEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        VendorLedgerEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        VendorLedgerEntryL.SETFILTER("Document Type",'<>%1',VendorLedgerEntryL."Document Type"::"Credit Memo");
        IF PostingDate <> 0D THEN
            VendorLedgerEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
            VendorLedgerEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF VendorLedgerEntryL.FINDSET(FALSE) THEN
            MESSAGE('%1 %2',VendorLedgerEntryL.COUNT,VendorLedgerEntryL.TABLECAPTION);

        DetailedVendorLedgEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date");
        DetailedVendorLedgEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        DetailedVendorLedgEntryL.SETFILTER("Document Type",'<>%1',DetailedVendorLedgEntryL."Document Type"::"Credit Memo");
        IF PostingDate <> 0D THEN
            DetailedVendorLedgEntryL.SETRANGE("Posting Date",PostingDate);
        IF DetailedVendorLedgEntryL.FINDSET(FALSE) THEN
            MESSAGE('%1 %2',DetailedVendorLedgEntryL.COUNT,DetailedVendorLedgEntryL.TABLECAPTION);

        WHTEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        WHTEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        WHTEntryL.SETFILTER("Document Type",'<>%1',WHTEntryL."Document Type"::"Credit Memo");
        IF PostingDate <> 0D THEN
        WHTEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        WHTEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF WHTEntryL.FINDSET(FALSE) THEN
            MESSAGE('%1 %2',WHTEntryL.COUNT,WHTEntryL.TABLECAPTION);

        ValueEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        ValueEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        ValueEntryL.SETFILTER("Document Type",'<>%1',ValueEntryL."Document Type"::"Purchase Credit Memo");
        IF PostingDate <> 0D THEN
        ValueEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        ValueEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF ValueEntryL.FINDSET(FALSE) THEN
            MESSAGE('%1 %2',ValueEntryL.COUNT,ValueEntryL.TABLECAPTION);

        FALedgerEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        FALedgerEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        FALedgerEntryL.SETFILTER("Document Type",'<>%1',FALedgerEntryL."Document Type"::"Credit Memo");
        IF PostingDate <> 0D THEN
            FALedgerEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
            FALedgerEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF FALedgerEntryL.FINDSET(FALSE) THEN
            MESSAGE('%1 %2',FALedgerEntryL.COUNT,Text000);
        //HEI.01<<
    end;

    local procedure UpdateInvoiceLedger()
    var
        PurchaseAdditionalFieldsL : Record "Purchase Additional Fields FND";	
        GLEntryL : Record "G/L Entry";	
        VATEntryL : Record "VAT Entry";	
        VendorLedgerEntryL : Record "Vendor Ledger Entry";	
        DetailedVendorLedgEntryL : Record "Detailed Vendor Ledg. Entry";	
        WHTEntryL : Record "WHT Entry FND";	
        ValueEntryL : Record "Value Entry";	
        FALedgerEntryL : Record "FA Ledger Entry";	
    begin
        //HEI.01>>
        IF ExecutedFor <> ExecutedFor::"Posted Invoice" THEN
        EXIT;

        PurchaseAdditionalFieldsL.SETCURRENTKEY("Document No.",TableID,"Document Type");
        PurchaseAdditionalFieldsL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        PurchaseAdditionalFieldsL.SETRANGE(TableID,DATABASE::"Purch. Inv. Header");
        PurchaseAdditionalFieldsL.SETRANGE("Document Type",PurchaseAdditionalFieldsL."Document Type"::"Posted Invoice");
        IF PurchaseAdditionalFieldsL.FINDFIRST THEN
            PurchaseAdditionalFieldsL.RENAME(PurchaseAdditionalFieldsL.TableID,PurchaseAdditionalFieldsL."Document Type",NewDocNo);

        GLEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        GLEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        GLEntryL.SETFILTER("Document Type",'<>%1',GLEntryL."Document Type"::"Credit Memo");
        IF PostingDate <> 0D THEN
            GLEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
            GLEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF GLEntryL.FINDSET(TRUE) THEN
            GLEntryL.MODIFYALL("Document No.",NewDocNo);

        VATEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        VATEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        VATEntryL.SETFILTER("Document Type",'<>%1',VATEntryL."Document Type"::"Credit Memo");
        IF PostingDate <> 0D THEN
            VATEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
            VATEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF VATEntryL.FINDSET(TRUE) THEN
            VATEntryL.MODIFYALL("Document No.",NewDocNo);

        VendorLedgerEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        VendorLedgerEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        VendorLedgerEntryL.SETFILTER("Document Type",'<>%1',VendorLedgerEntryL."Document Type"::"Credit Memo");
        IF PostingDate <> 0D THEN
            VendorLedgerEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
            VendorLedgerEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF VendorLedgerEntryL.FINDSET(TRUE) THEN
            VendorLedgerEntryL.MODIFYALL("Document No.",NewDocNo);

        DetailedVendorLedgEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date");
        DetailedVendorLedgEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        DetailedVendorLedgEntryL.SETFILTER("Document Type",'<>%1',DetailedVendorLedgEntryL."Document Type"::"Credit Memo");
        IF PostingDate <> 0D THEN
            DetailedVendorLedgEntryL.SETRANGE("Posting Date",PostingDate);
        IF DetailedVendorLedgEntryL.FINDSET(TRUE) THEN
            DetailedVendorLedgEntryL.MODIFYALL("Document No.",NewDocNo);

        WHTEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        WHTEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        WHTEntryL.SETFILTER("Document Type",'<>%1',WHTEntryL."Document Type"::"Credit Memo");
        IF PostingDate <> 0D THEN
            WHTEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
            WHTEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF WHTEntryL.FINDSET(TRUE) THEN
            WHTEntryL.MODIFYALL("Document No.",NewDocNo);

        ValueEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        ValueEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        ValueEntryL.SETFILTER("Document Type",'<>%1',ValueEntryL."Document Type"::"Purchase Credit Memo");
        IF PostingDate <> 0D THEN
            ValueEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
            ValueEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF ValueEntryL.FINDSET(TRUE) THEN
            ValueEntryL.MODIFYALL("Document No.",NewDocNo);

        FALedgerEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        FALedgerEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        FALedgerEntryL.SETFILTER("Document Type",'<>%1',FALedgerEntryL."Document Type"::"Credit Memo");
        IF PostingDate <> 0D THEN
            FALedgerEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
            FALedgerEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF FALedgerEntryL.FINDSET(TRUE) THEN
            FALedgerEntryL.MODIFYALL("Document No.",NewDocNo);
        //HEI.01<<
    end;


    LOCAL procedure CountCrMemoLedger()
    var
        PurchaseAdditionalFieldsL : Record "Purchase Additional Fields FND";	
        GLEntryL : Record "G/L Entry";	
        VATEntryL : Record "VAT Entry";	
        VendorLedgerEntryL : Record "Vendor Ledger Entry";	
        DetailedVendorLedgEntryL : Record "Detailed Vendor Ledg. Entry";	
        WHTEntryL : Record "WHT Entry FND";	
        ValueEntryL : Record "Value Entry";	
        FALedgerEntryL : Record "FA Ledger Entry";	
    begin
        //HEI.01>>
        IF ExecutedFor <> ExecutedFor::"Posted Cr. Memo" THEN
            EXIT;
    
        PurchaseAdditionalFieldsL.SETCURRENTKEY("Document No.",TableID,"Document Type");
        PurchaseAdditionalFieldsL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        PurchaseAdditionalFieldsL.SETRANGE(TableID,DATABASE::"Purch. Cr. Memo Hdr.");
        PurchaseAdditionalFieldsL.SETRANGE("Document Type",PurchaseAdditionalFieldsL."Document Type"::"Posted Cr. Memo");
        IF PurchaseAdditionalFieldsL.FINDFIRST THEN
            MESSAGE('%1 %2',PurchaseAdditionalFieldsL.COUNT,PurchaseAdditionalFieldsL.TABLECAPTION);

        GLEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        GLEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        GLEntryL.SETFILTER("Document Type",'<>%1',GLEntryL."Document Type"::Invoice);
        IF PostingDate <> 0D THEN
            GLEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
            GLEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF GLEntryL.FINDSET(FALSE) THEN
            MESSAGE('%1 %2',GLEntryL.COUNT,GLEntryL.TABLECAPTION);

        VATEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        VATEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        VATEntryL.SETFILTER("Document Type",'<>%1',VATEntryL."Document Type"::Invoice);
        IF PostingDate <> 0D THEN
            VATEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
            VATEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF VATEntryL.FINDSET(FALSE) THEN
            MESSAGE('%1 %2',VATEntryL.COUNT,VATEntryL.TABLECAPTION);

        VendorLedgerEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        VendorLedgerEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        VendorLedgerEntryL.SETFILTER("Document Type",'<>%1',VendorLedgerEntryL."Document Type"::Invoice);
        IF PostingDate <> 0D THEN
            VendorLedgerEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
            VendorLedgerEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF VendorLedgerEntryL.FINDSET(FALSE) THEN
            MESSAGE('%1 %2',VendorLedgerEntryL.COUNT,VendorLedgerEntryL.TABLECAPTION);

        DetailedVendorLedgEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date");
        DetailedVendorLedgEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        DetailedVendorLedgEntryL.SETFILTER("Document Type",'<>%1',DetailedVendorLedgEntryL."Document Type"::Invoice);
        IF PostingDate <> 0D THEN
            DetailedVendorLedgEntryL.SETRANGE("Posting Date",PostingDate);
        IF DetailedVendorLedgEntryL.FINDSET(FALSE) THEN
            MESSAGE('%1 %2',DetailedVendorLedgEntryL.COUNT,DetailedVendorLedgEntryL.TABLECAPTION);

        WHTEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        WHTEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        WHTEntryL.SETFILTER("Document Type",'<>%1',WHTEntryL."Document Type"::Invoice);
        IF PostingDate <> 0D THEN
            WHTEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
            WHTEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF WHTEntryL.FINDSET(FALSE) THEN
            MESSAGE('%1 %2',WHTEntryL.COUNT,WHTEntryL.TABLECAPTION);

        ValueEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        ValueEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        ValueEntryL.SETFILTER("Document Type",'<>%1',ValueEntryL."Document Type"::"Purchase Invoice");
        IF PostingDate <> 0D THEN
            ValueEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
            ValueEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF ValueEntryL.FINDSET(FALSE) THEN
            MESSAGE('%1 %2',ValueEntryL.COUNT,ValueEntryL.TABLECAPTION);

        FALedgerEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        FALedgerEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        FALedgerEntryL.SETFILTER("Document Type",'<>%1',FALedgerEntryL."Document Type"::Invoice);
        IF PostingDate <> 0D THEN
            FALedgerEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
            FALedgerEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF FALedgerEntryL.FINDSET(FALSE) THEN
            MESSAGE('%1 %2',FALedgerEntryL.COUNT,Text000);
        //HEI.01<<
    end;

    LOCAL procedure UpdateCrMemoLedger()
    var
        PurchaseAdditionalFieldsL : Record "Purchase Additional Fields FND";	
        GLEntryL : Record "G/L Entry";	
        VATEntryL : Record "VAT Entry";	
        VendorLedgerEntryL : Record "Vendor Ledger Entry";	
        DetailedVendorLedgEntryL : Record "Detailed Vendor Ledg. Entry";	
        WHTEntryL : Record "WHT Entry FND";	
        ValueEntryL : Record "Value Entry";	
        FALedgerEntryL : Record "FA Ledger Entry";	

    begin
        //HEI.01>>
        IF ExecutedFor <> ExecutedFor::"Posted Cr. Memo" THEN
            EXIT;

        PurchaseAdditionalFieldsL.SETCURRENTKEY("Document No.",TableID,"Document Type");
        PurchaseAdditionalFieldsL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        PurchaseAdditionalFieldsL.SETRANGE(TableID,DATABASE::"Purch. Cr. Memo Hdr.");
        PurchaseAdditionalFieldsL.SETRANGE("Document Type",PurchaseAdditionalFieldsL."Document Type"::"Posted Cr. Memo");
        IF PurchaseAdditionalFieldsL.FINDFIRST THEN
        PurchaseAdditionalFieldsL.RENAME(PurchaseAdditionalFieldsL.TableID,PurchaseAdditionalFieldsL."Document Type",NewDocNo);

        GLEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        GLEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        GLEntryL.SETFILTER("Document Type",'<>%1',GLEntryL."Document Type"::Invoice);
            IF PostingDate <> 0D THEN
        GLEntryL.SETRANGE("Posting Date",PostingDate);
            IF ExternalDocNo <> '' THEN
        GLEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF GLEntryL.FINDSET(TRUE) THEN
            GLEntryL.MODIFYALL("Document No.",NewDocNo);

        VATEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        VATEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        VATEntryL.SETFILTER("Document Type",'<>%1',VATEntryL."Document Type"::Invoice);
        IF PostingDate <> 0D THEN
            VATEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
            VATEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF VATEntryL.FINDSET(TRUE) THEN
            VATEntryL.MODIFYALL("Document No.",NewDocNo);

        VendorLedgerEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        VendorLedgerEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        VendorLedgerEntryL.SETFILTER("Document Type",'<>%1',VendorLedgerEntryL."Document Type"::Invoice);
        IF PostingDate <> 0D THEN
            VendorLedgerEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
            VendorLedgerEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF VendorLedgerEntryL.FINDSET(TRUE) THEN
            VendorLedgerEntryL.MODIFYALL("Document No.",NewDocNo);

        DetailedVendorLedgEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date");
        DetailedVendorLedgEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        DetailedVendorLedgEntryL.SETFILTER("Document Type",'<>%1',DetailedVendorLedgEntryL."Document Type"::Invoice);
        IF PostingDate <> 0D THEN
            DetailedVendorLedgEntryL.SETRANGE("Posting Date",PostingDate);
        IF DetailedVendorLedgEntryL.FINDSET(TRUE) THEN
            DetailedVendorLedgEntryL.MODIFYALL("Document No.",NewDocNo);

        WHTEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        WHTEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        WHTEntryL.SETFILTER("Document Type",'<>%1',WHTEntryL."Document Type"::Invoice);
        IF PostingDate <> 0D THEN
            WHTEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
            WHTEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF WHTEntryL.FINDSET(TRUE) THEN
            WHTEntryL.MODIFYALL("Document No.",NewDocNo);

        ValueEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        ValueEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        ValueEntryL.SETFILTER("Document Type",'<>%1',ValueEntryL."Document Type"::"Purchase Invoice");
        IF PostingDate <> 0D THEN
        ValueEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
            ValueEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF ValueEntryL.FINDSET(TRUE) THEN
            ValueEntryL.MODIFYALL("Document No.",NewDocNo);

        FALedgerEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        FALedgerEntryL.SETFILTER("Document No.",'=%1',ExistingDocNo);
        FALedgerEntryL.SETFILTER("Document Type",'<>%1',FALedgerEntryL."Document Type"::Invoice);
        IF PostingDate <> 0D THEN
            FALedgerEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
            FALedgerEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF FALedgerEntryL.FINDSET(TRUE) THEN
            FALedgerEntryL.MODIFYALL("Document No.",NewDocNo);
        //HEI.01<<
    end;

}
