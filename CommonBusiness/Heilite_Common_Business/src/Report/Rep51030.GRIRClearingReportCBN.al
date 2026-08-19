report 51030 "GR/IR Clearing Report CBN"
{
    // version HEI.01

    // # new Report-RFC 161 – GR/IR Clearing Report IBM PATHAA02 20.12.2017
    // BC Upgrade BHARDA11 >>
    // 1. Add layout path ad change layout extension rdlc to rdl.
    // 2. Add ApplicationArea property in report.
    // 3. Remove Drink-IT Field("Purch. Rcpt. Header"."Document Subtype Code")
    // BC Upgrade BHARDA11 <<
    //BC UPGRADE ATHUKS01>>
    //1.Report is not used in NAVISION Hence application area is not assigned to the report.
    //BC UPGRADE ATHUKS01<<

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\GRIR Clearing Report.rdl';// BC Upgrade BHARDA11 ---Add Path and change extension rdlc to rdl
    //ApplicationArea = ALl;
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            RequestFilterFields = "Posting Date", "No.", "Order No.";
            column(GRNoCaption; GRNoCaptionLbl)
            {
            }
            column(GRNoLineNoCaption; GRNoLineNoCaptionLbl)
            {
            }
            column(TypeCaption; TypeCaptionLbl)
            {
            }
            column(SupplierNameCaption; SupplierNameCaptionLbl)
            {
            }
            column(SupplierNumberCaption; SupplierNumberCaptionlbl)
            {
            }
            column(PONumberCaption; PONumberCaptionLbl)
            {
            }
            column(POType; POTypeLbl)
            {
            }
            column(GRIAccCaption; GRIAccCaptionLbl)
            {
            }
            column(AmtGRRecCaption; AmtGRRecCaptionLbl)
            {
            }
            column(AmtGRInvCaption; AmtGRInvCaptionLbl)
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(GRValueDomCurrCaption; GRValueDomCurrCaptionLbl)
            {
            }
            column(ValueInvDomCurrCaption; ValueInvDomCurrCaptionLbl)
            {
            }
            column(GRIRValDiffDomCurrCaption; GRIRValDiffDomCurrCaptionLbl)
            {
            }
            column(GRValueForeignCurrCaption; GRValueForeignCurrCaptionLbl)
            {
            }
            column(ValueInvForeignCurrCaption; ValueInvForeignCurrCaptionLbl)
            {
            }
            column(GRIRDiffForeignCurrCaption; GRIRDiffForeignCurrCaptionLbl)
            {
            }
            column(ForeignCurrCaption; ForeignCurrCaptionLbl)
            {
            }
            column(LocalCurrCaption; LocalCurrCaptionLbl)
            {
            }
            column(PorgBusinessUnitCaption; PorgBusinessUnitCaptionLbl)
            {
            }
            column(MaterialServiceDescCaption; MaterialServiceDescCaptionlbl)
            {
            }
            column(MaterialCodeCMGCaption; MaterialCodeCMGCaptionLbl)
            {
            }
            column(ItemNumCaption; ItemNumCaptionLbl)
            {
            }
            column(ExpectedDeliveryDateCaption; ExpectedDeliveryDateCaptionLbl)
            {
            }
            column(POCreationDateCaption; POCreationDateCaptionLbl)
            {
            }
            column(PlantCaption; PlantCaptionLbl)
            {
            }
            column(GoodreceiptPostingDateCaption; GoodreceiptPostingDateCaptionLbl)
            {
            }
            column(CompanyCodeCaption; CompanyCodeCaptionLbl)
            {
            }
            column(DayspastCaption; DayspastCaptionLbl)
            {
            }
            column(AgeingCaption; AgeingCaptionLbl)
            {
            }
            column(POCreatorCaption; POCreatorCaptionLbl)
            {
            }
            column(GRCreatorCaption; GRCreatorCaptionLbl)
            {
            }
            column(GRIRClearingReportCaption; GRIRClearingReportCaptionLbl)
            {
            }
            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(DocNo_PurchReceiptLine; "Purch. Rcpt. Line"."Document No.")
                {
                }
                column(Type_PurchReceiptLine; "Purch. Rcpt. Line".Type)
                {
                }
                column(BuyfromVendNo_PurchReceiptLine; "Purch. Rcpt. Line"."Buy-from Vendor No.")
                {
                }
                column(OrderNo_PurchReceiptLine; "Purch. Rcpt. Line"."Order No.")
                {
                }
                column(Quantity_PurchReceiptLine; "Purch. Rcpt. Line".Quantity)
                {
                }
                column(QtyInvoiced_PurchReceiptLine; "Purch. Rcpt. Line"."Quantity Invoiced")
                {
                }
                column(UOM_PurchReceiptLine; "Purch. Rcpt. Line"."Unit of Measure Code")
                {
                }
                column(Description_PurchReceiptLine; "Purch. Rcpt. Line".Description)
                {
                }
                column(No_PurchReceiptLine; "Purch. Rcpt. Line"."No.")
                {
                }
                column(ExpectedReceiptDate_PurchReceiptLine; "Purch. Rcpt. Line"."Expected Receipt Date")
                {
                }
                column(LocationCode_PurchReceiptLine; "Purch. Rcpt. Line"."Location Code")
                {
                }
                column(CurrencyCode_PurchReceiptHeader; "Purch. Rcpt. Header"."Currency Code")
                {
                }
                column(PostingDate_PurchReceiptHeader; "Purch. Rcpt. Header"."Posting Date")
                {
                }
                // column(DocSubtypecode_PurchReceiptHeader;"Purch. Rcpt. Header"."Document Subtype Code") // BC Upgrade BHARDA11 ----Drink-IT Field("Purch. Rcpt. Header"."Document Subtype Code")
                // {
                // }
                column(GRNo_LineNo_PurchReceiptLine; FORMAT("Purch. Rcpt. Line"."Document No.") + ' / ' + FORMAT("Purch. Rcpt. Line"."Line No."))
                {
                }
                column(VendName; VendName)
                {
                }
                column(SupplierName; "Purch. Rcpt. Header"."Buy-from Vendor Name")
                {
                }
                column(LegalEntityCode; CompanyInformation."Legal Entity Code FND")
                {
                }
                column(LCYcode; glsetup."LCY Code")
                {
                }
                column(GRValForCurr; GRValForCurr)
                {
                }
                column(ValueInvForCurr; ValueInvForCurr)
                {
                }
                column(GRIRValForCurr; GRIRValForCurr)
                {
                }
                column(GRValDomCurr; GRValDomCurr)
                {
                }
                column(ValueInvDomCurr; ValueInvDomCurr)
                {
                }
                column(GRIRValDomCurr; GRIRValDomCurr)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    CLEAR(GRValForCurr);
                    CLEAR(ValueInvForCurr);
                    CLEAR(GRValDomCurr);
                    CLEAR(ValueInvDomCurr);
                    CLEAR(GRIRValForCurr);
                    CLEAR(GRIRValDomCurr);
                    CLEAR(dimensionvaluecode);
                    /*
                    //Currencies from Purch Receipt Line using exchage rate tables>>
                    IF "Purch. Rcpt. Header"."Currency Code"<>'' THEN BEGIN
                      CurrencyExchangeRate.RESET;
                      CurrencyExchangeRate.SETRANGE("Currency Code","Purch. Rcpt. Line"."Currency Code");
                      CurrencyExchangeRate.SETFILTER("Starting Date",'%<=1',"Purch. Rcpt. Line"."Posting Date");
                      IF CurrencyExchangeRate.FINDFIRST THEN
                      GRValDomCurr := "Purch. Rcpt. Line".Quantity*"Purch. Rcpt. Line"."Unit Cost"*(CurrencyExchangeRate."Relational Adjmt Exch Rate Amt"/CurrencyExchangeRate."Exchange Rate Amount");
                    END ELSE BEGIN
                      GRValDomCurr := "Purch. Rcpt. Line".Quantity*"Purch. Rcpt. Line"."Unit Cost";
                    END;
                    //Currencies from Purch Receipt Line using exchange rate table<<
                    */

                    /*
                    //Currencies from Purch Inv Line using exchange rate tables>>
                    IF "Purch. Rcpt. Header"."Currency Code"<>'' THEN BEGIN
                      PurchInvLine.RESET;
                      PurchInvLine.SETRANGE("Receipt No.","Document No.");
                      PurchInvLine.SETRANGE("Receipt Line No.","Line No.");
                      IF PurchInvLine.FINDFIRST THEN BEGIN
                        CurrencyExchangeRate.RESET;
                        CurrencyExchangeRate.SETRANGE("Currency Code", "Currency Code");// currency code not available in purchinvline
                        CurrencyExchangeRate.SETFILTER("Starting Date",'%<=1', PurchInvLine."Posting Date");
                        IF CurrencyExchangeRate.FINDFIRST THEN
                        ValueInvForCurr := PurchInvLine.Quantity*PurchInvLine."Unit Cost"*(CurrencyExchangeRate."Relational Exch. Rate Amount"/CurrencyExchangeRate."Exchange Rate Amount");
                      END;
                    END ELSE BEGIN
                      PurchInvLine.RESET;
                      PurchInvLine.SETRANGE("Receipt No.","Document No.");
                      PurchInvLine.SETRANGE("Receipt Line No.","Line No.");
                      IF PurchInvLine.FINDFIRST THEN
                      ValueInvDomCurr:= PurchInvLine.Quantity*PurchInvLine."Unit Cost";
                    END;
                    //Currencies from Purch Inv Line using exchange rate tables>>
                    */

                    //Currencies from Purch Receipt Line>>
                    if "Purch. Rcpt. Header"."Currency Code" <> '' then begin
                        GRValDomCurr := "Purch. Rcpt. Line".Quantity * "Purch. Rcpt. Line"."Unit Cost" * "Purch. Rcpt. Header"."Currency Factor";
                    end else begin
                        GRValDomCurr := "Purch. Rcpt. Line".Quantity * "Purch. Rcpt. Line"."Unit Cost";
                    end;

                    GRValForCurr := "Purch. Rcpt. Line".Quantity * "Purch. Rcpt. Line"."Unit Cost";
                    //Currencies from Purch Receipt Line<<

                    //Currencies from Purch Inv Line using currency factor>>

                    if "Purch. Rcpt. Header"."Currency Code" <> '' then begin
                        PurchInvLine.RESET;
                        PurchInvLine.SETRANGE("Receipt No.", "Document No.");
                        PurchInvLine.SETRANGE("Receipt Line No.", "Line No.");
                        if PurchInvLine.FINDFIRST then
                            if PurchInvHeader.GET(PurchInvLine."Receipt No.") then
                                //currfactor := PurchInvHeader."Currency Factor";
                                ValueInvDomCurr := PurchInvLine.Quantity * PurchInvLine."Unit Cost" * PurchInvHeader."Currency Factor";
                    end else begin
                        PurchInvLine.RESET;
                        PurchInvLine.SETRANGE("Receipt No.", "Document No.");
                        PurchInvLine.SETRANGE("Receipt Line No.", "Line No.");
                        if PurchInvLine.FINDFIRST then
                            ValueInvDomCurr := PurchInvLine.Quantity * PurchInvLine."Unit Cost";
                    end;
                    //Currencies from Purch Inv Line using currency factor>>

                    GRIRValDomCurr := GRValDomCurr - ValueInvDomCurr;
                    GRIRValForCurr := GRValForCurr - ValueInvForCurr;

                    DimensionSetEntry.RESET;
                    DimensionSetEntry.SETRANGE("Dimension Set ID", "Dimension Set ID");
                    DimensionSetEntry.SETFILTER("Dimension Code", '%1', 'CMG');
                    if DimensionSetEntry.FINDFIRST then
                        dimensionvaluecode := DimensionSetEntry."Dimension Value Code";

                end;

                trigger OnPreDataItem();
                begin
                    SETFILTER(Type, '<>%1', Type::" ");
                end;
            }

            trigger OnAfterGetRecord();
            begin
                if Vendor.GET("Purch. Rcpt. Header"."Buy-from Vendor No.") then
                    VendName := Vendor.Name;
            end;

            trigger OnPreDataItem();
            begin
                if glsetup.GET then;
                if CompanyInformation.GET then;
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
    }

    var
        GRNoCaptionLbl: Label 'GR No.';
        GRNoLineNoCaptionLbl: Label 'GR No./Line No.';
        TypeCaptionLbl: Label 'Type';
        SupplierNameCaptionLbl: Label 'Supplier Name';
        SupplierNumberCaptionlbl: Label 'Supplier Number';
        PONumberCaptionLbl: Label 'PO Number';
        POTypeLbl: Label 'PO Type';
        GRIAccCaptionLbl: Label 'GR/I Account';
        AmtGRRecCaptionLbl: Label 'Amount of GR Received';
        AmtGRInvCaptionLbl: Label 'Amount of GR Invoiced';
        UOMCaptionLbl: Label 'Unit of Measure';
        GRValueDomCurrCaptionLbl: Label 'GR Value in Domestic Currecy';
        ValueInvDomCurrCaptionLbl: Label 'Value Invoiced in Domestic Currency';
        GRIRValDiffDomCurrCaptionLbl: Label 'GR IR Value Difference in Domestic Currency';
        GRValueForeignCurrCaptionLbl: Label 'GR Value in Foreign Currency';
        ValueInvForeignCurrCaptionLbl: Label 'Value Invoiced in foreign Currency';
        GRIRDiffForeignCurrCaptionLbl: Label 'GR IR Value Difference in Foreign Currency';
        ForeignCurrCaptionLbl: Label 'Foreign Currency';
        LocalCurrCaptionLbl: Label 'Local Currency';
        PorgBusinessUnitCaptionLbl: Label 'Porg/Business Unit';
        MaterialServiceDescCaptionlbl: Label 'Material/Service Description';
        MaterialCodeCMGCaptionLbl: Label 'Material Code (CMG Code)';
        ItemNumCaptionLbl: Label 'Item Number';
        ExpectedDeliveryDateCaptionLbl: Label 'Expected Delivery Date';
        POCreationDateCaptionLbl: Label 'PO Creation Date';
        PlantCaptionLbl: Label 'Plant';
        GoodreceiptPostingDateCaptionLbl: Label 'Good Receipt Posting Date';
        CompanyCodeCaptionLbl: Label 'Company Code';
        DayspastCaptionLbl: Label 'Days Past';
        AgeingCaptionLbl: Label 'Ageing';
        POCreatorCaptionLbl: Label 'PO Creator';
        GRCreatorCaptionLbl: Label 'GR Creator';
        GLEntry: Record "G/L Entry";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Dimension: Record Dimension;
        CompanyInformation: Record "Company Information";
        GRIRClearingReportCaptionLbl: Label 'GR/IR Clearing Report';
        VendName: Text;
        Vendor: Record Vendor;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        GRValForCurr: Decimal;
        ValueInvForCurr: Decimal;
        GRIRValForCurr: Decimal;
        GRValDomCurr: Decimal;
        ValueInvDomCurr: Decimal;
        GRIRValDomCurr: Decimal;
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchInvLine: Record "Purch. Inv. Line";
        glsetup: Record "General Ledger Setup";
        GRVal: Integer;
        DimensionSetEntry: Record "Dimension Set Entry";
        dimensionvaluecode: Code[10];
        currfactor: Decimal;
}

