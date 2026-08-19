report 51029 "GR/IR Clearing Report1 CBN"
{
    // version HEI.05

    // # new Report-RFC 161 – GR/IR Clearing Report IBM PATHAA02 20.12.2017
    // HEI.01 CHG2079503 IBM PANDES01 12-10-2020
    //  # Added Ccc code field in layout.
    // HEI.02 CHG2114834 IBM SHANKJ03 30.06.2021
    //   # Added Code in function Clear var and OnAfterGetRecord
    //   # Added datasource in data item
    //   # Changed code for calculating Domestic currency
    // HEI.03 FDD - HB2598 CHG2131845 IBM NANDIS01 22.12.2021 - Corrections to  GR-IR report (columns adjustment)
    //   # Added new source QtyRcvdNtInv for change of caption "Quanity of GR Invoiced"
    //   # New column added - "Quantity Receiveid not Invoiced"
    //   # Code modified for "Value Invoiced in Domestic Currency" and automatically "GR IR Value Difference in Domestic Currency" is fixed
    //   # Code added for "Value Invoiced in foreign Currency" and automatically "GR IR Value Difference in Foreign Currency" is fixed
    // HEI.04 FDD - HB2763 CHG2144429 IBM MAJUMS03 28-03-2022 - Corrections to GR-IR report (Days Past)
    // HEI.05 CHG2229933 HB3689 IBM SRIVAS07 25.04.2024 # SRM Reference Document Mapping - Development
    //   # Added column in Layout - "Vendor shipment No."()
    // HEI.06 CHG2320209 SHARMP16 25.09.2025 GR/IR Report Enhancement - Development
    //   # Added Filter if G/L Account No is balnk the skip those records
    //   # Change the GR Creator ID

    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea Property in Report and Requestpage fields.
    // 2. Add layout Path and change layout extension rdlc to rdl.
    // 3. Remove Drink-IT Fields and related code ("Document Subtype Code","Vendor Shipment No.","Created By","Creation Date/Time").
    // 4. Comment Dotnet variables (DateandTime,DayOfWeekInput,WeekOfYearInput) these dotnet variables calculate days difference between two dates , we write simple code for same.
    // BC Upgrade BHARDA11 <<

    // BC Upgrade MISHRS14 >>
    // Added Tag HEI.06 in documentation and related changes done in OnAfterGetRecord trigger of "Purch. Rcpt. Header" data item
    // BC Upgrade MISHRS14 <<
    //BC UPGRADE ATHUKS01>>
    //1.Comemnted Drink IT field "Document Subtype Code" and "Vendor Shipment No." and related code in OnAfterGetRecord trigger of "Purch. Rcpt. Line" data item.
    //2.Added new function GetUserNameFromSystemId to get user name from system id and used this function in OnAfterGetRecord trigger of "Purch. Rcpt. Header" data item to get PO Creator name instead of using Drink IT field "Created By" and also get PO Creation date from system field "Creation Date/Time" instead of using Drink IT field.
    //BC UPGRADE ATHUKS01<<

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\GRIR Clearing Report1.rdl';// BC Upgrade BHARDA11 ---Add Path and change extension rdlc to rdl
    Caption = 'GR/IR Clearing Report';
    Description = 'GR/IR Clearing Report';
    ApplicationArea = ALl;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Posting Date", "No.", "Order No.";
            column(GRIRAccountNo; GRIRAccountNo)
            {
            }
            column(dimensionvaluecode; dimensionvaluecode)
            {
            }
            column(POCreationDate; POCreationDate)
            {
            }
            column(POCREATOR; POCREATOR)
            {
            }
            column(GRCREATOR; GRCREATOR)
            {
            }
            column(DaysPast; DaysPast)
            {
            }
            column(Aging; Aging)
            {
            }
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
            column(ForCurrVisi; ForCurrVisi)
            {
            }
            column(QtyGRRecCaption; QtyGRRecCaptionLbl)
            {
            }
            column(AmtGRRecCaption; AmtGRRecCaptionLbl)
            {
            }
            column(AmtGRInvCaption; AmtGRInvCaptionLbl)
            {
            }
            column(QtyGRInvCaptionCaption; QtyGRInvCaptionLbl)
            {
            }
            column(QtyRcvdNtInvCaption; QtyRcvdNtInvLbl)
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
            column(CCCCodeCaption; CCCCodeLbl)
            {
            }
            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(LineNoPurchReceiptLine; "Purch. Rcpt. Line"."Line No.")
                {
                }
                column(Dimenssion_Line; "Purch. Rcpt. Line"."Shortcut Dimension 1 Code")
                {
                }
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
                column(DocSubtypecode_PurchReceiptHeader; "Purch. Rcpt. Header"."Document Subtype Code FND") // BC Upgrade SHUKLP03 ("Document Subtype Code")
                {
                }
                //BC UPGRADE SHUKLP03
                column(GRNo_LineNo_PurchReceiptLine; FORMAT("Purch. Rcpt. Line"."Document No.") + ' / ' + FORMAT("Purch. Rcpt. Line"."Line No."))
                {
                }
                column(VendName; VendName)
                {
                }
                column(Ccc_Code; "Purch. Rcpt. Line"."Shortcut Dimension 2 Code")
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
                // column(VendorShipmentNo_PurchRcptLine; "Purch. Rcpt. Line"."Vendor Shipment No.") // BC Upgrade BHARDA11 ----Drink-IT Field("Vendor Shipment No.")
                // {
                // }

                column(VendorShipmentNo_PurchRcptLine; '') { }//BC UPGRADE ATHUKS01>> Drink IT
                dataitem("Purchase Line"; "Purchase Line")
                {
                    DataItemLink = "Receipt No." = FIELD("Document No.");
                    DataItemTableView = WHERE("Document Type" = CONST("Return Order"), "Document Type" = CONST("Credit Memo"));
                    dataitem("Return Shipment Header"; "Return Shipment Header")
                    {
                        DataItemLink = "Return Order No." = FIELD("Document No.");
                        column(RSH_No; "Return Shipment Header"."No.")
                        {
                        }
                        dataitem("Return Shipment Line"; "Return Shipment Line")
                        {
                            DataItemLink = "Document No." = FIELD("No.");
                            DataItemTableView = WHERE(Type = FILTER(<> " "));
                            column(ReturnShmt_qty; "Return Shipment Line".Quantity)
                            {
                            }
                        }
                    }
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

                    if "Purch. Rcpt. Line".Quantity = "Purch. Rcpt. Line"."Quantity Invoiced" then
                        CurrReport.SKIP();

                    //Currencies from Purch Receipt Line>>
                    if "Purch. Rcpt. Header"."Currency Code" <> '' then
                        //GRValDomCurr := "Purch. Rcpt. Line".Quantity * "Purch. Rcpt. Line"."Unit Cost" * "Purch. Rcpt. Header"."Currency Factor"//HEI.02
                        GRValDomCurr := "Purch. Rcpt. Line".Quantity * "Purch. Rcpt. Line"."Unit Cost" / "Purch. Rcpt. Header"."Currency Factor"//HEI.02
                    else
                        GRValDomCurr := "Purch. Rcpt. Line".Quantity * "Purch. Rcpt. Line"."Unit Cost";

                    GRValForCurr := "Purch. Rcpt. Line".Quantity * "Purch. Rcpt. Line"."Unit Cost";
                    //Currencies from Purch Receipt Line<<

                    //Currencies from Purch Inv Line using currency factor>>

                    if "Purch. Rcpt. Header"."Currency Code" <> '' then begin
                        PurchInvLine.RESET();
                        PurchInvLine.SETRANGE("Receipt No.", "Document No.");
                        PurchInvLine.SETRANGE("Receipt Line No.", "Line No.");
                        //HEI.03>>
                        //IF PurchInvLine.FINDFIRST THEN
                        //  IF PurchInvHeader.GET(PurchInvLine."Receipt No.") THEN
                        //    //currfactor := PurchInvHeader."Currency Factor";
                        //    ValueInvDomCurr := PurchInvLine.Quantity * PurchInvLine."Unit Cost" * PurchInvHeader."Currency Factor";
                        if PurchInvLine.FINDSET() then
                            repeat
                                if PurchInvHeader.GET(PurchInvLine."Document No.") then begin
                                    ValueInvDomCurr += PurchInvLine.Quantity * PurchInvLine."Unit Cost" / PurchInvHeader."Currency Factor";
                                    ValueInvForCurr += PurchInvLine.Quantity * PurchInvLine."Unit Cost";
                                end;
                            until PurchInvLine.NEXT() = 0;
                        //HEI.03<<
                    end else begin
                        PurchInvLine.RESET();
                        PurchInvLine.SETRANGE("Receipt No.", "Document No.");
                        PurchInvLine.SETRANGE("Receipt Line No.", "Line No.");
                        //HEI.03>>
                        //IF PurchInvLine.FINDFIRST THEN
                        //   ValueInvDomCurr:= PurchInvLine.Quantity * PurchInvLine."Unit Cost";
                        if PurchInvLine.FINDFIRST() then
                            repeat
                                ValueInvDomCurr += PurchInvLine.Quantity * PurchInvLine."Unit Cost";
                            until PurchInvLine.NEXT() = 0;
                        //HEI.03<<
                    end;
                    //Currencies from Purch Inv Line using currency factor>>

                    GRIRValDomCurr := GRValDomCurr - ValueInvDomCurr;
                    GRIRValForCurr := GRValForCurr - ValueInvForCurr;

                    DimensionSetEntry.RESET();
                    DimensionSetEntry.SETRANGE("Dimension Set ID", "Dimension Set ID");
                    DimensionSetEntry.SETFILTER("Dimension Code", '%1', 'CMG');
                    if DimensionSetEntry.FINDFIRST() then
                        dimensionvaluecode := DimensionSetEntry."Dimension Value Code";
                end;

                trigger OnPreDataItem();
                begin
                    SETFILTER(Type, '<>%1', Type::" ");
                end;
            }

            trigger OnAfterGetRecord();
            begin
                ClearVar();

                if Vendor.GET("Purch. Rcpt. Header"."Buy-from Vendor No.") then
                    VendName := Vendor.Name;

                //below code to get the gl account numer posted from GL entries
                //ISYED01>>GRIRAccountNo
                //CLEAR(GRIRAccountNo);
                GLEntry.RESET();
                GLEntry.SETRANGE("Document No.", "Purch. Rcpt. Header"."No.");
                //GLEntry.SETRANGE(Open,FALSE);
                GLEntry.SETFILTER("G/L Account No.", '%1|%2', '14222001', '14522001');
                if GLEntry.FINDSET() then begin
                    repeat
                        if GLEntry."G/L Account No." <> '' then
                            GRIRAccountNo := GLEntry."G/L Account No.";
                    until GLEntry.NEXT() = 0;
                end;

                //ISYED01<<

                // BC Upgrade MISHRS14 >>
                //HEI.06>>
                IF GRIRAccountNo = '' THEN CurrReport.SKIP();
                // GRCREATOR := "Purch. Rcpt. Header"."Created By";  // BC Upgrade BHARDA11 ----Drink-IT Field("Created By")
                GRCREATOR := "Purch. Rcpt. Header"."User ID";
                //HEI.06<<
                // BC Upgrade MISHRS14 << 

                PurchaseHeader.RESET();
                PurchaseHeader.SETFILTER("No.", "Purch. Rcpt. Header"."Order No.");
                if PurchaseHeader.FINDFIRST() then begin
                    // BC Upgrade BHARDA11 >> ----Drink-IT Field("Created By","Creation Date/Time")
                    POCREATOR := GetUserNameFromSystemId(PurchaseHeader.SystemCreatedBy);
                    POCreationDate := PurchaseHeader.SystemCreatedAt;
                    // BC Upgrade BHARDA11 << ----Drink-IT Field("Created By","Creation Date/Time")

                    //HEI.02 >>
                    if PurchaseHeader."Currency Code" <> '' then
                        ForCurrVisi := true;
                    //HEI.02
                end;

                //DaysPast := DateandTime.DateDiff('D',"Purch. Rcpt. Header"."Creation Date/Time",TODAY,DayOfWeekInput,WeekOfYearInput);//HEI.04
                // DaysPast := DateandTime.DateDiff('D', "Purch. Rcpt. Header"."Posting Date", TODAY, DayOfWeekInput, WeekOfYearInput); //HEI.04 // BC Upgrade BHARDA11 ----Dotnet variable not working in Business central and this varable calculate days difference between two dates , here hw simple write the code for the same
                DaysPast := Today - "Purch. Rcpt. Header"."Posting Date"; // BC Upgrade BHARDA11 ---::Added (Comment Dotnet variable and write simple code to calculate days difference between two dates)
                if DaysPast < 30 then
                    Aging := '< 30 Days'
                else if (DaysPast >= 30) and (DaysPast < 60) then
                    Aging := '< 60 Days'
                else if (DaysPast >= 60) and (DaysPast < 90) then
                    Aging := '< 90 Days'
                else
                    Aging := '> 90 Days';
            end;

            trigger OnPreDataItem();
            begin
                if glsetup.GET() then;
                if CompanyInformation.GET() then;
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
        qtyreceivednotinvoiced = 'Qty Received Not Invoiced'; QtyReturnedlbl = 'Returned Shmt Qty'; RetrunshipmentNolbl = 'Retrun shipment No';
    }

    var
        GRNoCaptionLbl: Label 'GR No.';
        GRNoLineNoCaptionLbl: Label 'GR No./Line No.';
        TypeCaptionLbl: Label 'Type';
        SupplierNameCaptionLbl: Label 'Supplier Name';
        SupplierNumberCaptionlbl: Label 'Supplier Number';
        PONumberCaptionLbl: Label 'PO Number';
        POTypeLbl: Label 'PO Type';
        GRIAccCaptionLbl: Label 'GR/IR Account';
        QtyGRRecCaptionLbl: Label 'Quanity of GR Received';
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
        GRIRAccountNo: Code[10];
        GRCREATOR: Text[250];
        POCREATOR: Text[250];
        PurchaseHeader: Record "Purchase Header";
        DaysPast: Integer;
        // BC Upgrade BHARDA11 >> ----::Dotnet variables not working here, 
        // DateandTime: DotNet "'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.DateAndTime";
        // DayOfWeekInput: DotNet "'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.FirstDayOfWeek";
        // WeekOfYearInput: DotNet "'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.FirstWeekOfYear";
        // BC Upgrade BHARDA11 << ----Dotnet variables not working here, 
        Aging: Text[250];
        Item: Record Item;
        POCreationDate: DateTime;
        CCCCodeLbl: Label 'CCCCode';
        ForCurrVisi: Boolean;
        QtyRcvdNtInvLbl: Label 'Quantity Received Not Invoiced';
        QtyGRInvCaptionLbl: Label 'Quantity of GR Invoiced';

    local procedure ClearVar();
    begin
        CLEAR(POCREATOR);
        CLEAR(GRCREATOR);
        CLEAR(VendName);
        CLEAR(GRIRAccountNo);
        CLEAR(Aging);
        ForCurrVisi := false;// HEI.02
    end;

    procedure GetUserNameFromSystemId(UserSecurityId: Guid): Text
    var
        UserRec: Record User;
    begin
        if UserRec.Get(UserSecurityId) then
            exit(UserRec."User Name");

        exit('');
    end;
}

