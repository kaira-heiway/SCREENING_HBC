report 53020 "Cashier Order"
{
    // version HEI.01

    // HEI.01 FDD-PTPGAP072 IBM NASTAA02 02.02.2018 # Cashier Order Creation
    //   # New Report created to print the Cashier Order
    //   # Changed layout to use a template paper when printing the report
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID is - 50097.
    // 2. Add layout path and Change extension RDLC to RDL.
    // 3. Add ApplicationArea property in Report.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Cashier Order.rdl'; // BC Upgrade BHARDA11 ---Add layout path and Change extension RDLC to RDL.

    Caption = 'Cashier Order';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Line No.")
                                ORDER(Ascending)
                                WHERE("Account Type" = CONST(Vendor));
            RequestFilterFields = "Journal Template Name", "Journal Batch Name";
            column(JournalTemplateName; "Journal Template Name")
            {
            }
            column(JournalBatchName; "Journal Batch Name")
            {
            }
            column(JournalLineNo; "Line No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_PostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyInfo_Country; Country.Name)
            {
            }
            column(CompanyInfo_BankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(Amount; Amount)
            {
            }
            column(AmountInLetters; AmountLetter)
            {
            }
            column(PrintingDate; TODAY)
            {
            }
            column(VendorName; Vendor.Name)
            {
            }

            trigger OnAfterGetRecord()
            begin
                PaymentMethod.GET("Payment Method Code");
                IF NOT PaymentMethod."Cashier Order FND" THEN
                    ERROR(CashOrderPayNotAllowedErr);

                CLEAR(AmountLetter);
                HeinekenGlobal.AmountInLetter(AmountLetter, ROUND(Amount, 0.01, '='));

                Vendor.GET("Account No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        AlgerLbl = 'Alger,';
        ReportTitleLbl = 'Request for Bank Check';
        BankNameLbl = 'Name / Social Reasons';
        AddressLbl = 'Address / seat';
        AccountNoLbl = 'Account No.';
        InNumbersLbl = 'In numbers';
        InLettersLbl = 'In letters';
        MrDirectorLbl = 'Mr. Director,';
        MrDirector2Lbl = 'By debiting my account, please send me a bank check of an amount in DA:';
        WordingLbl = 'Wording to the order of:';
        DischargeLbl = 'It is understood that I discharge you the consequences that could result from this operation.';
        SignatureLbl = 'Stamp and Signature';
        AcknowReceiptLbl = 'Acknowledgment of receipt';
        CheckNumberLbl = 'Check Number';
        DateLbl = 'Date';
        ReceiverSignatureLbl = 'Signature of Receiver';
    }

    trigger OnInitReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
        IF Country.GET(CompanyInfo."Country/Region Code") THEN;
    end;

    var
        HeinekenGlobal: Codeunit "Heineken Global";
        CompanyInfo: Record "Company Information";
        PaymentMethod: Record "Payment Method";
        AmountLetter: Text[1024];
        CashOrderPayNotAllowedErr: Label 'Payment Method does not allow Cashier Order Print.';
        Country: Record "Country/Region";
        Vendor: Record Vendor;
}

