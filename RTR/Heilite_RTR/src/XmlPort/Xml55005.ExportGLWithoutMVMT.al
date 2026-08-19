xmlport 55005 "Export GL Without MVMT"
{

    // version NAVW17.10

    // INC4141858 IBM ISYED01 05/23/2019
    //   # New XML port created to extract the GL entries for entries with out MVMT dimenssion code

    //BC Upgrade GUNREM01 Old ID-50028
    //BC Upgrade COmmented DIT fields

    CaptionML = ENU = 'Export Contact',
                FRA = 'Exporter contact';
    Direction = Export;
    FileName = 'GLEntries.csv';
    Format = VariableText;
    Permissions = TableData "G/L Entry" = rimd;
    TableSeparator = '<NewLine>';
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                XmlName = 'ContactHeader';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));
                textelement(EntryNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        EntryNoTitle := "G/L Entry".FIELDCAPTION("Entry No.");
                    end;
                }
                textelement(GLAccountNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        GLAccountNoTitle := "G/L Entry".FIELDCAPTION("G/L Account No.");
                    end;
                }
                textelement(PostingDateTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        PostingDateTitle := "G/L Entry".FIELDCAPTION("Posting Date");
                    end;
                }
                textelement(DocumentNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        DocumentNoTitle := "G/L Entry".FIELDCAPTION("Document No.");
                    end;
                }
                textelement(BalAccountNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        BalAccountNoTitle := "G/L Entry".FIELDCAPTION("Bal. Account No.");
                    end;
                }
                textelement(AmountTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        AmountTitle := "G/L Entry".FIELDCAPTION(Amount);
                    end;
                }
                textelement(SourceCodeTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        SourceCodeTitle := "G/L Entry".FIELDCAPTION("Source Code");
                    end;
                }
                textelement(SystemCreatedEntryTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        SystemCreatedEntryTitle := "G/L Entry".FIELDCAPTION("System-Created Entry");
                    end;
                }
                textelement(PriorYearEntryTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        PriorYearEntryTitle := "G/L Entry".FIELDCAPTION("Prior-Year Entry");
                    end;
                }
                textelement(JobNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        JobNoTitle := "G/L Entry".FIELDCAPTION("Job No.");
                    end;
                }
                textelement(QuantityTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        QuantityTitle := "G/L Entry".FIELDCAPTION(Quantity);
                    end;
                }
                textelement(VATAmountTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        VATAmountTitle := "G/L Entry".FIELDCAPTION("VAT Amount");
                    end;
                }
                textelement(BusinessUnitCodeTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        BusinessUnitCodeTitle := "G/L Entry".FIELDCAPTION("Business Unit Code");
                    end;
                }
                textelement(JournalBatchNameTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        JournalBatchNameTitle := "G/L Entry".FIELDCAPTION("Journal Batch Name");
                    end;
                }
                textelement(ReasonCodeTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        ReasonCodeTitle := "G/L Entry".FIELDCAPTION("Reason Code");
                    end;
                }
                textelement(GenPostingTypeTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        GenPostingTypeTitle := "G/L Entry".FIELDCAPTION("Gen. Posting Type");
                    end;
                }
                textelement(GenBusPostingGroupTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        GenBusPostingGroupTitle := "G/L Entry".FIELDCAPTION("Gen. Bus. Posting Group");
                    end;
                }
                textelement(GenProdPostingGroupTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        GenPostingTypeTitle := "G/L Entry".FIELDCAPTION("Gen. Prod. Posting Group");
                    end;
                }
                textelement(BalAccountTypeTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        BalAccountNoTitle := "G/L Entry".FIELDCAPTION("Bal. Account Type");
                    end;
                }
                textelement(TransactionNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        TransactionNoTitle := "G/L Entry".FIELDCAPTION("Transaction No.");
                    end;
                }
                textelement(DebitAmountTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        DebitAmountTitle := "G/L Entry".FIELDCAPTION("Debit Amount");
                    end;
                }
                textelement(CreditAmountTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        CreditAmountTitle := "G/L Entry".FIELDCAPTION("Credit Amount");
                    end;
                }
                textelement(DocumentDateTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        DocumentDateTitle := "G/L Entry".FIELDCAPTION("Document Date");
                    end;
                }
                textelement(ExternalDocumentNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        ExternalDocumentNoTitle := "G/L Entry".FIELDCAPTION("External Document No.");
                    end;
                }
                textelement(SourceTypeTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        SourceTypeTitle := "G/L Entry".FIELDCAPTION("Source Type");
                    end;
                }
                textelement(SourceNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        SourceNoTitle := "G/L Entry".FIELDCAPTION("Source No.");
                    end;
                }
                textelement(NoSeriesTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        NoSeriesTitle := "G/L Entry".FIELDCAPTION("No. Series");
                    end;
                }
                textelement(TaxAreaCodeTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        TaxAreaCodeTitle := "G/L Entry".FIELDCAPTION("Tax Area Code");
                    end;
                }
                textelement(TaxLiableTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        TaxLiableTitle := "G/L Entry".FIELDCAPTION("Tax Liable");
                    end;
                }
                textelement(TaxGroupCodeTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        TaxGroupCodeTitle := "G/L Entry".FIELDCAPTION("Tax Group Code");
                    end;
                }
                textelement(UseTaxTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        UseTaxTitle := "G/L Entry".FIELDCAPTION("Use Tax");
                    end;
                }
                textelement(VATBusPostingGroupTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        VATBusPostingGroupTitle := "G/L Entry".FIELDCAPTION("VAT Bus. Posting Group");
                    end;
                }
                textelement(VATProdPostingGroupTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        VATProdPostingGroupTitle := "G/L Entry".FIELDCAPTION("VAT Prod. Posting Group");
                    end;
                }
                textelement(AdditionalCurrencyAmountTitle)
                {
                }
                textelement(AddCurrencyDebitAmountTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        AddCurrencyDebitAmountTitle := "G/L Entry".FIELDCAPTION("Add.-Currency Debit Amount");
                    end;
                }
                textelement(AddCurrencyCreditAmountTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        AddCurrencyCreditAmountTitle := "G/L Entry".FIELDCAPTION("Add.-Currency Credit Amount");
                    end;
                }
                textelement(CloseIncomeStatementTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        CloseIncomeStatementTitle := "G/L Entry".FIELDCAPTION("Close Income Statement Dim. ID");
                    end;
                }
                textelement(DimIDTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        DimIDTitle := "G/L Entry".FIELDCAPTION("IC Partner Code");
                    end;
                }
                textelement(ReversedTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        ReversedTitle := "G/L Entry".FIELDCAPTION(Reversed);
                    end;
                }
                textelement(ReversedbyEntryNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        ReversedEntryNoTitle := "G/L Entry".FIELDCAPTION("Reversed by Entry No.");
                    end;
                }
                textelement(ReversedEntryNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        ReversedbyEntryNoTitle := "G/L Entry".FIELDCAPTION("Reversed Entry No.");
                    end;
                }
                textelement(GLAccountNameTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        GLAccountNameTitle := "G/L Entry".FIELDCAPTION("G/L Account Name");
                    end;
                }
                textelement(ProdOrderNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        ProdOrderNoTitle := "G/L Entry".FIELDCAPTION("Prod. Order No.");
                    end;
                }
                textelement(FAEntryTypeTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        FAEntryTypeTitle := "G/L Entry".FIELDCAPTION("FA Entry Type");
                    end;
                }
                textelement(FAEntryNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        FAEntryNoTitle := "G/L Entry".FIELDCAPTION("FA Entry No.");
                    end;
                }
                textelement(CVDetailedEntryNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        CVDetailedEntryNoTitle := "G/L Entry".FIELDCAPTION("CV Detailed Entry No. FND");
                    end;
                }
                textelement(AdjExchangeRateTypeTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        AdjExchangeRateTypeTitle := "G/L Entry".FIELDCAPTION("Adj. Exchange Rate Type FND");
                    end;
                }
                textelement(CurrencyCodeTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        CurrencyCodeTitle := "G/L Entry".FIELDCAPTION("Currency Code FND");
                    end;
                }
                textelement(SourceCurrencyAmountTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        SourceCurrencyAmountTitle := "G/L Entry".FIELDCAPTION("Source Currency Amount");
                    end;
                }
                textelement(JournalTemplateNameTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        JournalTemplateNameTitle := "G/L Entry".FIELDCAPTION("Journal Template Name FND");
                    end;
                }
                textelement(OpenTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        OpenTitle := "G/L Entry".FIELDCAPTION("Open FND");
                    end;
                }
                textelement(RemainingAmountTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        RemainingAmountTitle := "G/L Entry".FIELDCAPTION("Remaining Amount FND");
                    end;
                }
                textelement(ClosedbyEntryNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        ClosedbyEntryNoTitle := "G/L Entry".FIELDCAPTION("Closed by Entry No. FND");
                    end;
                }
                textelement(ClosedatDateTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        ClosedatDateTitle := "G/L Entry".FIELDCAPTION("Closed at Date FND");
                    end;
                }
                textelement(ClosedbyAmountTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        ClosedbyAmountTitle := "G/L Entry".FIELDCAPTION("Closed by Amount FND");
                    end;
                }
                textelement(AppliestoIDTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        AppliestoIDTitle := "G/L Entry".FIELDCAPTION("Applies-to ID FND");
                    end;
                }
                textelement(ForecastLineTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        ForecastLineTitle := "G/L Entry".FIELDCAPTION("Forecast Line FND");
                    end;
                }
                textelement(CommentTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        CommentTitle := "G/L Entry".FIELDCAPTION(Comment);
                    end;
                }
                textelement(InterfaceCodeTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        InterfaceCodeTitle := "G/L Entry".FIELDCAPTION("Interface Code FND");
                    end;
                }
                textelement(CPVendorInvoiceNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        CPVendorInvoiceNoTitle := "G/L Entry".FIELDCAPTION("CP Vendor Invoice No. FND");
                    end;
                }
                textelement(ContractLineNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        //  ContractLineNoTitle:= "G/L Entry".FIELDCAPTION("Service Contract Line No." ); //BC Upgrade GUNREM01 -Blocked DIT Field
                    end;
                }
                textelement(FinancialContractNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        // FinancialContractNoTitle := "G/L Entry".FIELDCAPTION("Financial Contract No.");//BC Upgrade GUNREM01 -Blocked DIT Field
                    end;
                }
                textelement(SubContractTypeTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        //  SubContractTypeTitle := "G/L Entry".FIELDCAPTION("DIT Sub-Contract Type");//BC Upgrade GUNREM01 -Blocked DIT Field
                    end;
                }
                textelement(ContractGroupCodeTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        //   ContractGroupCodeTitle := "G/L Entry".FIELDCAPTION("Contract Group Code");//BC Upgrade GUNREM01 -Blocked DIT Field
                    end;
                }
                textelement(ServiceContractNoTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        // ServiceContractNoTitle := "G/L Entry".FIELDCAPTION("Service Contract No.");//BC Upgrade GUNREM01 -Blocked DIT Field
                    end;
                }
                textelement(ContractTypeTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        //ContractTypeTitle := "G/L Entry".FIELDCAPTION("Contract Type");//BC Upgrade GUNREM01 -Blocked DIT Field
                    end;
                }
                textelement(DimensionSetIDTitle)
                {

                    trigger OnBeforePassVariable();
                    begin
                        ContractTypeTitle := "G/L Entry".FIELDCAPTION("G/L Entry"."Dimension Set ID");
                    end;
                }
            }
            tableelement("G/L Entry"; "G/L Entry")
            {
                RequestFilterFields = "G/L Account No.", "Entry No.";
                XmlName = 'GLEntry';
                fieldelement(EntryNo; "G/L Entry"."Entry No.")
                {
                }
                fieldelement(GLAccountNo; "G/L Entry"."G/L Account No.")
                {
                }
                fieldelement(PostingDate; "G/L Entry"."Posting Date")
                {
                }
                fieldelement(DocumentNo; "G/L Entry"."Document No.")
                {
                }
                fieldelement(BalAccountNo; "G/L Entry"."Bal. Account No.")
                {
                }
                fieldelement(Amount; "G/L Entry".Amount)
                {
                }
                fieldelement(SourceCode; "G/L Entry"."Source Code")
                {
                }
                fieldelement(SystemCreatedEntry; "G/L Entry"."System-Created Entry")
                {
                }
                fieldelement(PriorYearEntry; "G/L Entry"."Prior-Year Entry")
                {
                }
                fieldelement(JobNo; "G/L Entry"."Job No.")
                {
                }
                fieldelement(Quantity; "G/L Entry".Quantity)
                {
                }
                fieldelement(VATAmount; "G/L Entry"."VAT Amount")
                {
                }
                fieldelement(BusinessUnitCode; "G/L Entry"."Business Unit Code")
                {
                }
                fieldelement(JournalBatchName; "G/L Entry"."Journal Batch Name")
                {
                }
                fieldelement(ReasonCode; "G/L Entry"."Reason Code")
                {
                }
                fieldelement(GenPostingType; "G/L Entry"."Gen. Posting Type")
                {
                }
                fieldelement(GenBusPostingGroup; "G/L Entry"."Gen. Bus. Posting Group")
                {
                }
                fieldelement(GenProdPostingGroup; "G/L Entry"."Gen. Prod. Posting Group")
                {
                }
                fieldelement(BalAccountType; "G/L Entry"."Bal. Account Type")
                {
                }
                fieldelement(TransactionNo; "G/L Entry"."Transaction No.")
                {
                }
                fieldelement(DebitAmount; "G/L Entry"."Debit Amount")
                {
                }
                fieldelement(CreditAmount; "G/L Entry"."Credit Amount")
                {
                }
                fieldelement(DocumentDate; "G/L Entry"."Document Date")
                {
                }
                fieldelement(ExternalDocumentNo; "G/L Entry"."External Document No.")
                {
                }
                fieldelement(SourceType; "G/L Entry"."Source Type")
                {
                }
                fieldelement(SourceNo; "G/L Entry"."Source No.")
                {
                }
                fieldelement(NoSeries; "G/L Entry"."No. Series")
                {
                }
                fieldelement(TaxAreaCode; "G/L Entry"."Tax Area Code")
                {
                }
                fieldelement(TaxLiable; "G/L Entry"."Tax Liable")
                {
                }
                fieldelement(TaxGroupCode; "G/L Entry"."Tax Group Code")
                {
                }
                fieldelement(UseTax; "G/L Entry"."Use Tax")
                {
                }
                fieldelement(VATBusPostingGroup; "G/L Entry"."VAT Bus. Posting Group")
                {
                }
                fieldelement(VATProdPostingGroup; "G/L Entry"."VAT Prod. Posting Group")
                {
                }
                fieldelement(AdditionalCurrencyAmount; "G/L Entry"."Additional-Currency Amount")
                {
                }
                fieldelement(AddCurrencyDebitAmount; "G/L Entry"."Add.-Currency Debit Amount")
                {
                }
                fieldelement(AddCurrencyCreditAmount; "G/L Entry"."Add.-Currency Credit Amount")
                {
                }
                fieldelement(CloseIncomeStatement; "G/L Entry"."Close Income Statement Dim. ID")
                {
                }
                fieldelement(DimID; "G/L Entry"."IC Partner Code")
                {
                }
                fieldelement(ICPartnerCode; "G/L Entry".Reversed)
                {
                }
                fieldelement(Reversed; "G/L Entry"."Reversed by Entry No.")
                {
                }
                fieldelement(ReversedbyEntryNo; "G/L Entry"."Reversed Entry No.")
                {
                }
                fieldelement(ReversedEntryNo; "G/L Entry"."G/L Account Name")
                {
                }
                fieldelement(GLAccountName; "G/L Entry"."Dimension Set ID")
                {
                }
                fieldelement(ProdOrderNo; "G/L Entry"."Prod. Order No.")
                {
                }
                fieldelement(FAEntryType; "G/L Entry"."FA Entry Type")
                {
                }
                fieldelement(FAEntryNo; "G/L Entry"."FA Entry No.")
                {
                }
                fieldelement(CVDetailedEntryNo; "G/L Entry"."CV Detailed Entry No. FND")
                {
                }
                fieldelement(AdjExchangeRateType; "G/L Entry"."Adj. Exchange Rate Type FND")
                {
                }
                fieldelement(CurrencyCode; "G/L Entry"."Currency Code FND")
                {
                }
                fieldelement(SourceCurrencyAmount; "G/L Entry"."Source Currency Amount")
                {
                }
                fieldelement(JournalTemplateName; "G/L Entry"."Journal Template Name FND")
                {
                }
                fieldelement(Open; "G/L Entry"."Open FND")
                {
                }
                fieldelement(RemainingAmount; "G/L Entry"."Remaining Amount FND")
                {
                }
                fieldelement(ClosedbyEntryNo; "G/L Entry"."Closed by Entry No. FND")
                {
                }
                fieldelement(ClosedatDate; "G/L Entry"."Closed at Date FND")
                {
                }
                fieldelement(ClosedbyAmount; "G/L Entry"."Closed by Amount FND")
                {
                }
                fieldelement(AppliestoID; "G/L Entry"."Applies-to ID FND")
                {
                }
                fieldelement(ForecastLine; "G/L Entry"."Forecast Line FND")
                {
                }
                fieldelement(Comment; "G/L Entry".Comment)
                {
                }
                fieldelement(InterfaceCode; "G/L Entry"."Interface Code FND")
                {
                }
                fieldelement(CPVendorInvoiceNo; "G/L Entry"."CP Vendor Invoice No. FND")
                {
                }
                //BC Upgrade GUNREM01 -Blocked DIT Fields >>
                // fieldelement(ContractLineNo; "G/L Entry"."Service Contract Line No.")
                // {
                // }
                // fieldelement(FinancialContractNo; "G/L Entry"."Financial Contract No.")
                // {
                // }
                // fieldelement(SubContractType; "G/L Entry"."DIT Sub-Contract Type")
                // {
                // }
                // fieldelement(ContractGroupCode; "G/L Entry"."Contract Group Code")
                // {
                // }
                // fieldelement(ServiceContractNo; "G/L Entry"."Service Contract No.")
                // {
                // }
                // fieldelement(ContractType; "G/L Entry"."Contract Type")
                // {
                // }
                //BC Upgrade GUNREM01 -Blocked DIT Fields <<
                fieldelement(DimensionSettID; "G/L Entry"."Dimension Set ID")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    DimensionSetEntry.SETRANGE("Dimension Set ID", "G/L Entry"."Dimension Set ID");
                    if DimensionSetEntry.FINDSET then begin
                        repeat
                            if DimensionSetEntry."Dimension Code" = 'MVMT' then
                                currXMLport.SKIP;
                        until DimensionSetEntry.NEXT = 0;
                    end;
                end;
            }
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

    var
        DimensionSetEntry: Record "Dimension Set Entry";
        Text2Remove: array[4] of Integer;
}

