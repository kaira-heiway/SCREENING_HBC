report 58008 "Update Zycus Vendor Inv/Cr No."
{
    // version HEI.01

    // HEI.01 CHG2210794 SAHAL01 03.09.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Created New Report: 50609 - Update Zycus Vendor Inv/Cr No.
    //   # Added Code

    //Bc Upgrade YADAVM09 Report property changes.

    Caption = 'Update Zycus Vendor Inv/Cr No.';
    Permissions = TableData "Vendor Ledger Entry" = rm,
                  TableData "Purch. Inv. Header" = rm,
                  TableData "Purch. Cr. Memo Hdr." = rm;
    ProcessingOnly = true;
    ApplicationArea = All;//BC Upgrade YADAVM09<<
    UsageCategory = ReportsAndAnalysis;//BC Upgrade YADAVM09<<

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE("Vendor Invoice No." = CONST('CHG2210794_INV'));
            RequestFilterFields = "No.";
            dataitem(VendorLedgerEntry1; "Vendor Ledger Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.") ORDER(Ascending) WHERE("External Document No." = CONST('CHG2210794_INV'));

                trigger OnAfterGetRecord();
                begin
                    //HEI.01>>
                    if Allowed then begin
                        if NewInvoiceNo = '' then
                            "External Document No." := "External Document No." + Text003
                        else
                            "External Document No." := NewInvoiceNo;
                        MODIFY(false);
                    end;
                    //HEI.01<<
                end;
            }

            trigger OnAfterGetRecord();
            begin
                //HEI.01>>
                if Allowed then begin
                    if NewInvoiceNo = '' then
                        "Vendor Invoice No." := "Vendor Invoice No." + Text003
                    else
                        "Vendor Invoice No." := NewInvoiceNo;
                    ValueUpdate += 1;
                    MODIFY(false);
                end;
                //HEI.01<<
            end;
        }
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE("Vendor Cr. Memo No." = CONST('CHG2210794_CRMEMO'));
            RequestFilterFields = "No.";
            dataitem(VendorLedgerEntry2; "Vendor Ledger Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.") ORDER(Ascending) WHERE("External Document No." = CONST('CHG2210794_CRMEMO'));

                trigger OnAfterGetRecord();
                begin
                    //HEI.01>>
                    if Allowed then begin
                        if NewCrMemoNo = '' then
                            "External Document No." := "External Document No." + Text003
                        else
                            "External Document No." := NewCrMemoNo;
                        MODIFY(false);
                    end;
                    //HEI.01<<
                end;
            }

            trigger OnAfterGetRecord();
            begin
                //HEI.01>>
                if Allowed then begin
                    if NewCrMemoNo = '' then
                        "Vendor Cr. Memo No." := "Vendor Cr. Memo No." + Text003
                    else
                        "Vendor Cr. Memo No." := NewCrMemoNo;
                    ValueUpdate += 1;
                    MODIFY(false);
                end;
                //HEI.01<<
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(NewInvoiceNo; NewInvoiceNo)
                    {
                        Caption = 'New Vendor Invoice No.';
                        ToolTip = 'Update the invoice Number';//Bc Upgrade YADAVM09<<
                        ApplicationArea = ALl;//Bc Upgrade YADAVM09<<

                    }
                    field(NewCrMemoNo; NewCrMemoNo)
                    {
                        Caption = 'New Vendor Cr. Memo No.';
                        ToolTip = 'Update the Vendor Credit Memo No';//Bc Upgrade YADAVM09<<
                        ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            //HEI.01>>
            CLEAR(NewInvoiceNo);
            CLEAR(NewCrMemoNo);
            //HEI.01<<
        end;
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        //HEI.01>>
        if GUIALLOWED then begin
            if ValueUpdate <> 0 then
                MESSAGE(Text001, ValueUpdate)
            else
                MESSAGE(Text002);
        end;
        //HEI.01<<
    end;

    trigger OnPreReport();
    begin
        //HEI.01>>
        CLEAR(Allowed);
        CLEAR(ValueUpdate);
        if ZycusInterfaceSetup.GET and ZycusInterfaceSetup."Enabled Zycus Integration" then begin
            if not ZycusInterfaceSetup."Activate PO Interface" then
                ERROR(Text000, ZycusInterfaceSetup."Activate PO Interface", ZycusInterfaceSetup.TABLECAPTION);
            if not ZycusInterfaceSetup."Activate GR Interface" then
                ERROR(Text000, ZycusInterfaceSetup."Activate GR Interface", ZycusInterfaceSetup.TABLECAPTION);
            Allowed := true;
        end;
        if not Allowed then
            CurrReport.QUIT;
        if (NewInvoiceNo <> '') and (NewCrMemoNo <> '') then
            ERROR(Text004);
        //HEI.01<<
    end;

    var
        ZycusInterfaceSetup: Record "Zycus Interface Setup INT";
        Allowed: Boolean;
        ValueUpdate: Integer;
        Text000: Label 'You cannot execute this report as the ''%1'' is not activated in %2.';
        Text001: Label 'Total record %1 updated.';
        Text002: Label 'No record found to update.';
        Text003: Label '_1';
        NewInvoiceNo: Code[20];
        NewCrMemoNo: Code[20];
        Text004: Label 'You cannot execute this report with both these value of New Invoice No. and New Cr. Memo No.';
}

