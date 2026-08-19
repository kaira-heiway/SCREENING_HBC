report 52034 "Purchase retained VAT"
{
    // BC Upgrade BHARDA11 >>
    // 1. OLD Report ID - 50123.
    // 2. Add layout path and change layout extension RDLC to RDL.
    // 3. Add ApplicationArea property in Report and Requestpage field.
    // BC Upgrade BHARAD11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Purchase retained VAT.rdl'; // BC Upgrade BHARDA11 ----Add layout path and change layout extension RDLC to RDL.

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(CompanyInformationName; CompanyInformation.Name)
            {
            }
            column(CompanyInformationVATRegistrationNo; CompanyInformation."VAT Registration No.")
            {
            }
            column(CompanyInfoPicture; CompanyInformation.Picture)
            {
            }
            column(Name_Vendor; Vendor.Name)
            {
            }
            column(VATRegistrationNo_Vendor; Vendor."VAT Registration No.")
            {
            }
            column(No_Vendor; Vendor."No.")
            {
            }
            column(TodayVal; TODAY)
            {
            }
            column(TaxNumber2_Vendor; Vendor."Tax Number 2 FND")
            {
            }
            column(CompanyInformationCheckDigit; CompanyInformation."Check Digit FND")
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = FIELD("No.");
                // DataItemTableView = SORTING("Vendor No.", "Posting Date", "Currency Code", "Item Charge Type", "DIT Sub-Contract Type", "Service Contract No."); // BC Upgrade BHARDA11 ----Drink-IT Fields("Item Charge Type", "DIT Sub-Contract Type", "Service Contract No.")
                DataItemTableView = SORTING("Vendor No.", "Posting Date", "Currency Code");
                column(FilterDate; FilterDate)
                {
                }
                column(ExternalDocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."External Document No.")
                {
                }
                column(PostingDate_VendorLedgerEntry; FORMAT("Vendor Ledger Entry"."Posting Date"))
                {
                }
                column(DocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(DocBase; DocBase)
                {
                }
                column(DocAmt; DocAmt)
                {
                }
                column(RevCBase; RevCBase)
                {
                }

                trigger OnAfterGetRecord();
                var
                    VATEntry: Record "VAT Entry";
                begin
                    DocAmt := 0;
                    DocBase := 0;
                    RevCBase := 0;
                    VATEntry.RESET;
                    VATEntry.SETCURRENTKEY("Document No.");
                    VATEntry.SETRANGE("Bill-to/Pay-to No.", "Vendor Ledger Entry"."Vendor No.");
                    VATEntry.SETRANGE("Document No.", "Document No.");
                    VATEntry.SETRANGE("External Document No.", "External Document No.");
                    VATEntry.SETRANGE("VAT Retention Base FND", true);
                    if not VATEntry.FINDFIRST then
                        CurrReport.SKIP
                    else
                        repeat
                            RevCBase += VATEntry.Amount;
                        until VATEntry.NEXT = 0;

                    VATEntry.RESET;
                    VATEntry.SETCURRENTKEY("Document No.");
                    VATEntry.SETRANGE("Bill-to/Pay-to No.", "Vendor Ledger Entry"."Vendor No.");
                    VATEntry.SETRANGE("Document No.", "Document No.");
                    VATEntry.SETRANGE("External Document No.", "External Document No.");
                    VATEntry.SETRANGE("VAT Calculation Type", VATEntry."VAT Calculation Type"::"Reverse Charge VAT");
                    if VATEntry.FINDFIRST then
                        repeat
                            DocAmt += VATEntry.Amount;
                            DocBase += VATEntry.Base;
                            RevCBase += VATEntry.Amount;
                        until VATEntry.NEXT = 0;
                end;

                trigger OnPreDataItem();
                var
                    VATEntry: Record "VAT Entry";
                begin
                    StartingDate := DMY2DATE(1, MonthFilter, YearFilter);
                    EndingDate := CALCDATE('<CM>', StartingDate);
                    SETRANGE("Posting Date", StartingDate, EndingDate);
                end;
            }

            trigger OnPreDataItem();
            begin
                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS(Picture);
                FilterDate := FORMAT(MonthFilter) + ' ' + FORMAT(YearFilter);
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
                    CaptionML = ENU = 'Options',
                                FRA = 'Options';
                    field(Year; YearFilter)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Year',
                                    FRA = 'Date début';
                        NotBlank = true;
                        ToolTipML = ENU = 'Specifies the date from which the report or batch job processes information.',
                                    FRA = 'Spécifie la date à partir de laquelle l''état ou le traitement par lots traite les informations.';
                    }
                    field(Month; MonthFilter)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            YearFilter := DATE2DMY(TODAY, 3);
            MonthFilter := DATE2DMY(TODAY, 2);
        end;
    }

    labels
    {
    }

    var
        DocBase: Decimal;
        DocAmt: Decimal;
        RevCBase: Decimal;
        CompanyInformation: Record "Company Information";
        FilterDate: Text;
        YearFilter: Integer;
        MonthFilter: Option " ",Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Nobiembre,Diciembre;
        StartingDate: Date;
        EndingDate: Date;
}

