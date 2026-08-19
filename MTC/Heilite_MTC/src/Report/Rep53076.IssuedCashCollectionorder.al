report 53076 "Issued Cash Collection Order"
{
    //BC Upgrade GUNREM01 Old ID-50008
    // version NAVW110.0

    // HEI.01 FDD OTCGAP022 Heilite BASE IBM ISYED01 28/06/2017
    //   # Cash Collection order

    //BC Upgrade GUNREM01 
    //# Commented one option field related code, becuase in NAV we can use any number but in BC we cannot use the numbers, and in the type field we have only one option.
    //# Commented DIT code
    //# DIT Columns updated with Empty
    //# IssuedCashCollection funtion added from HeinekenBCCustomFunctions codeunit

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Issued Cash Collection Order.rdl';

    Caption = 'Issued Cash Collection Order';
    UsageCategory = ReportsAndAnalysis;//BC UPGRDAE KUMARR78 ++01-07-2026
    ApplicationArea = All;

    dataset
    {
        dataitem("Issued Cash Collection Header"; "Issue Cash Collection Head FND")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            //  ReqFilterHeading = 'Issued Cash Collection';
            RequestFilterHeading = 'Issued Cash Collection'; //BC Upgrade GUNREM01
            column(No_IssuedReminderHeader; "No.")
            {
            }
            column(DueDateCaptiion; DueDateCaptiionLbl)
            {
            }
            column(VATAmountCaption; VATAmountCaptionLbl)
            {
            }
            column(VATBaseCaption; VATBaseCaptionLbl)
            {
            }
            column(VATPercentCaption; VATPercentCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(DocDateCaption; DocDateCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionLbl)
            {
            }
            column(EMailCaption; EMailCaptionLbl)
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(CompanyInfo1Picture; CompanyInfo1.Picture)
                {
                }
                column(CompanyInfo2Picture; CompanyInfo2.Picture)
                {
                }
                column(CompanyInfo3Picture; CompanyInfo3.Picture)
                {
                }
                column(DueDate_IssuedReminderHdr; FORMAT("Issued Cash Collection Header"."Due Date"))
                {
                }
                column(PostDate_IssuedReminderHdr; FORMAT("Issued Cash Collection Header"."Posting Date"))
                {
                }
                column(No1_IssuedReminderHdr; "Issued Cash Collection Header"."No.")
                {
                }
                column(YourRef_IssueReminderHdr; "Issued Cash Collection Header"."Your Reference")
                {
                }
                column(ReferenceText; ReferenceText)
                {
                }
                column(VatRegNo_IssueReminderHdr; "Issued Cash Collection Header"."VAT Registration No.")
                {
                }
                column(VATNoText; VATNoText)
                {
                }
                column(DocDate_IssueReminderHdr; FORMAT("Issued Cash Collection Header"."Document Date"))
                {
                }
                column(CustNo_IssueReminderHdr; "Issued Cash Collection Header"."Customer No.")
                {
                }
                column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                {
                }
                column(CompanyInfoBankName; CompanyInfo."Bank Name")
                {
                }
                column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                {
                }
                column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                {
                }
                column(CompanyInfoHomePage; CompanyInfo."Home Page")
                {
                }
                column(CompanyInfoEMail; CompanyInfo."E-Mail")
                {
                }
                column(CustAddr8; CustAddr[8])
                {
                }
                column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                {
                }
                column(CustAddr7; CustAddr[7])
                {
                }
                column(CustAddr6; CustAddr[6])
                {
                }
                column(CompanyAddr6; CompanyAddr[6])
                {
                }
                column(CustAddr5; CustAddr[5])
                {
                }
                column(CompanyAddr5; CompanyAddr[5])
                {
                }
                column(CustAddr4; CustAddr[4])
                {
                }
                column(CompanyAddr4; CompanyAddr[4])
                {
                }
                column(CustAddr3; CustAddr[3])
                {
                }
                column(CompanyAddr3; CompanyAddr[3])
                {
                }
                column(CustAddr2; CustAddr[2])
                {
                }
                column(CompanyAddr2; CompanyAddr[2])
                {
                }
                column(CustAddr1; CustAddr[1])
                {
                }
                column(CompanyAddr1; CompanyAddr[1])
                {
                }
                column(CurrReportPageNo; STRSUBSTNO(Text002, CurrReport.PAGENO))
                {
                }
                column(TextPage; TextPageLbl)
                {
                }
                column(PostingDateCaption; PostingDateCaptionLbl)
                {
                }
                column(ReminderNoCaption; ReminderNoCaptionLbl)
                {
                }
                column(BankAccNoCaption; BankAccNoCaptionLbl)
                {
                }
                column(BankNameCaption; BankNameCaptionLbl)
                {
                }
                column(GiroNoCaption; GiroNoCaptionLbl)
                {
                }
                column(VATRegNoCaption; VATRegNoCaptionLbl)
                {
                }
                column(PhoneNoCaption; PhoneNoCaptionLbl)
                {
                }
                column(ReminderCaption; ReminderCaptionLbl)
                {
                }
                column(CustNo_IssueReminderHdrCaption; "Issued Cash Collection Header".FIELDCAPTION("Customer No."))
                {
                }
                //BC Upgrade GUNREM01 -DIT fields replaced with null >>
                // column(Issued_Cash_Collection_Header_Truck_Code; "Issued Cash Collection Header"."Truck Code")
                // {
                // }
                // column(Issued_Cash_Collection_Header_Driver_Code; "Issued Cash Collection Header"."Driver Code")
                // {
                // }
                //BC Upgrade GUNREM01 -DIT fields replaced with null <<
                //BC UPGRADE KUMARR78 ++01-07-2026
                column(Issued_Cash_Collection_Header_Truck_Code; "Issued Cash Collection Header"."Truck Code")
                {
                }
                column(Issued_Cash_Collection_Header_Driver_Code; "Issued Cash Collection Header"."Driver Code")
                {
                }
                //BC UPGRADE KUMARR78 ++01-07-2026
                column(Issued_Cash_Collection_Header_Shipping_Agent_Name; ShippingAgentName)
                {
                }
                dataitem(DimensionLoop; "Integer")
                {
                    DataItemLinkReference = "Issued Cash Collection Header";
                    DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                    column(DimText; DimText)
                    {
                    }
                    column(Number_IntegerLine; Number)
                    {
                    }
                    column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        if Number = 1 then begin
                            if not DimSetEntry.FINDSET then
                                CurrReport.BREAK;
                        end else
                            if not Continue then
                                CurrReport.BREAK;

                        CLEAR(DimText);
                        Continue := false;
                        repeat
                            OldDimText := DimText;
                            if DimText = '' then
                                DimText := STRSUBSTNO('%1 - %2', DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code")
                            else
                                DimText :=
                                  STRSUBSTNO(
                                    '%1; %2 - %3', DimText,
                                    DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code");
                            if STRLEN(DimText) > MAXSTRLEN(OldDimText) then begin
                                DimText := OldDimText;
                                Continue := true;
                                exit;
                            end;
                        until DimSetEntry.NEXT = 0;
                    end;

                    trigger OnPreDataItem();
                    begin
                        if not ShowInternalInfo then
                            CurrReport.BREAK;
                    end;
                }
                dataitem("Issued Cash Collection Line"; "Issue Cash Collection Line FND")
                {
                    DataItemLink = "Cash Collection No." = FIELD("No.");
                    DataItemLinkReference = "Issued Cash Collection Header";
                    DataItemTableView = SORTING("Cash Collection No.", "Line No.");
                    column(Amount_To_Collect; Amount)
                    {
                    }
                    column(RemAmt_IssuedReminderLine; "Remaining Amount")
                    {
                        AutoFormatExpression = GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(Desc_IssuedReminderLine; Description)
                    {
                    }
                    column(Type_IssuedReminderLine; FORMAT(Type, 0, 1))
                    {
                    }
                    column(DocDate_IssuedReminderLine; FORMAT("Document Date"))
                    {
                    }
                    column(DocNo_IssuedReminderLine; "Document No.")
                    {
                    }
                    column(DocNoCaption_IssuedReminderLine; FIELDCAPTION("Document No."))
                    {
                    }
                    column(DueDate_IssuedReminderLine; FORMAT("Due Date"))
                    {
                    }
                    column(OriginalAmt_IssuedReminderLine; "Original Amount")
                    {
                        AutoFormatExpression = GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(DocType_IssuedReminderLine; "Document Type")
                    {
                    }
                    column(LineNo_IssuedReminderLine; "No.")
                    {
                    }
                    column(ShowInternalInfo; ShowInternalInfo)
                    {
                    }
                    column(NNCInterestAmt; NNC_InterestAmount)
                    {
                    }
                    column(TotalText; TotalText)
                    {
                    }
                    column(NNCTotal; NNC_Total)
                    {
                    }
                    column(TotalInclVATText; TotalInclVATText)
                    {
                    }
                    column(NNCVATAmt; NNC_VATAmount)
                    {
                    }
                    column(NNCTotalInclVAT; NNC_TotalInclVAT)
                    {
                    }
                    column(TotalVATAmt; TotalVATAmount)
                    {
                    }
                    column(RemNo_IssuedReminderLine; "Cash Collection No.")
                    {
                    }
                    column(DocumentDateCaption1; DocumentDateCaption1Lbl)
                    {
                    }
                    column(InterestAmountCaption; InterestAmountCaptionLbl)
                    {
                    }
                    column(RemAmt_IssuedReminderLineCaption; FIELDCAPTION("Remaining Amount"))
                    {
                    }
                    column(DocNo_IssuedReminderLineCaption; FIELDCAPTION("Document No."))
                    {
                    }
                    column(OriginalAmt_IssuedReminderLineCaption; FIELDCAPTION("Original Amount"))
                    {
                    }
                    column(DocType_IssuedReminderLineCaption; FIELDCAPTION("Document Type"))
                    {
                    }
                    column(Interest; Interest)
                    {
                    }
                    column(Description_IssuedCashCollectionLine; "Issued Cash Collection Line".Description)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        //HEI.01>>
                        VATAmountLine.INIT;
                        VATAmountLine."VAT Identifier" := "VAT Identifier";
                        VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                        VATAmountLine."Tax Group Code" := "Tax Group Code";
                        VATAmountLine."VAT %" := "VAT %";
                        VATAmountLine."VAT Base" := Amount;
                        VATAmountLine."VAT Amount" := "VAT Amount";
                        VATAmountLine."Amount Including VAT" := Amount + "VAT Amount";
                        VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                        VATAmountLine.InsertLine;

                        case Type of
                            Type::"Customer Ledger Entry":
                                //"Remaining Amount" := Amount;old change
                                "Remaining Amount" := "Remaining Amount";
                        //BC Upgrade GUNREM01 In NAV we can use numbers, but in BC we cant, in type option we have only option >>
                        // Type::"3":
                        //     //"Remaining Amount" := Amount;//old change
                        //     "Remaining Amount" := "Remaining Amount";
                        // Type::"2":
                        //     ReminderInterestAmount := Amount;
                        //BC Upgrade GUNREM01 In NAV we can use numbers, but in BC we cant, in type option we have only option <<
                        end;

                        NNC_InterestAmountTotal += ReminderInterestAmount;
                        NNC_RemainingAmountTotal += "Remaining Amount";
                        NNC_VATAmountTotal += "VAT Amount";

                        NNC_InterestAmount := (NNC_InterestAmountTotal + NNC_VATAmountTotal + "Issued Cash Collection Header"."Additional Fee" -
                                               AddFeeInclVAT + "Issued Cash Collection Header"."Add. Fee per Line" - AddFeePerLineInclVAT) /
                          (VATInterest / 100 + 1);
                        NNC_Total := NNC_RemainingAmountTotal + NNC_InterestAmountTotal;
                        NNC_VATAmount := NNC_VATAmountTotal;
                        NNC_TotalInclVAT := NNC_RemainingAmountTotal + NNC_InterestAmountTotal + NNC_VATAmountTotal;
                        //HEI.01<<
                    end;

                    trigger OnPreDataItem();
                    begin
                        //HEI.01>>
                        if FINDLAST then begin
                            EndLineNo := "Line No." + 1;
                            repeat
                                Continue :=
                                  not ShowNotDueAmounts and
                                  // ("No. of Reminders" = 0) AND ((Type = Type::"2") OR (Type = Type::"3")) OR (Type = Type::" ");
                                  ("No. of Reminders" = 0) and ((Type = Type::"Customer Ledger Entry")) or (Type = Type::" ");
                                if Continue then
                                    EndLineNo := "Line No.";
                            until (NEXT(-1) = 0) or not Continue;
                        end;

                        VATAmountLine.DELETEALL;
                        //SETFILTER("Line No.",'<%1',EndLineNo); Defect 1708
                        CurrReport.CREATETOTALS("Remaining Amount", "VAT Amount", ReminderInterestAmount);
                        //HEI.01<<
                    end;
                }
                dataitem(IssuedReminderLine2; "Issue Cash Collection Line FND")
                {
                    DataItemLink = "Cash Collection No." = FIELD("No.");
                    DataItemLinkReference = "Issued Cash Collection Header";
                    DataItemTableView = SORTING("Cash Collection No.", "Line No.");
                    column(Desc1_IssuedReminderLine; Description)
                    {
                    }
                    column(LineNo1_IssuedReminderLine; "Line No.")
                    {
                    }

                    trigger OnPreDataItem();
                    begin
                        //HEI.01>>
                        SETFILTER("Line No.", '>=%1', EndLineNo);
                        if not ShowNotDueAmounts then begin
                            SETFILTER(Type, '<>%1', Type::" ");
                            if FINDFIRST then
                                if "Line No." > EndLineNo then begin
                                    SETRANGE(Type);
                                    SETRANGE("Line No.", EndLineNo, "Line No." - 1); // find "Open Entries Not Due" line
                                    if FINDLAST then
                                        SETRANGE("Line No.", EndLineNo, "Line No." - 1);
                                end;
                            SETRANGE(Type);
                        end;
                        //HEI.01<<
                    end;
                }
                dataitem(VATCounter; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(VATAmtLineAmtIncludVAT; VATAmountLine."Amount Including VAT")
                    {
                        AutoFormatExpression = "Issued Cash Collection Line".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(VALVATAmount; VALVATAmount)
                    {
                        AutoFormatExpression = "Issued Cash Collection Line".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(VALVATBase; VALVATBase)
                    {
                        AutoFormatExpression = "Issued Cash Collection Line".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(VALVATBaseVALVATAmt; VALVATBase + VALVATAmount)
                    {
                        AutoFormatExpression = "Issued Cash Collection Line".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(VATAmtLineVAT; VATAmountLine."VAT %")
                    {
                    }
                    column(AmountIncVATCaption; AmountIncVATCaptionLbl)
                    {
                    }
                    column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
                    {
                    }
                    column(ContinuedCaption; ContinuedCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        VATAmountLine.GetLine(Number);
                        VALVATBase := VATAmountLine."Amount Including VAT" / (1 + VATAmountLine."VAT %" / 100);
                        VALVATAmount := VATAmountLine."Amount Including VAT" - VALVATBase;
                    end;

                    trigger OnPreDataItem();
                    begin
                        //HEI.01>>
                        if VATAmountLine.GetTotalVATAmount = 0 then
                            CurrReport.BREAK;

                        SETRANGE(Number, 1, VATAmountLine.COUNT);

                        VALVATBase := 0;
                        VALVATAmount := 0;
                        //HEI.01<<
                    end;
                }
                dataitem(VATClauseEntryCounter; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(VATClauseVATIdentifier; VATAmountLine."VAT Identifier")
                    {
                    }
                    column(VATClauseCode; VATAmountLine."VAT Clause Code")
                    {
                    }
                    column(VATClauseDescription; VATClause.Description)
                    {
                    }
                    column(VATClauseDescription2; VATClause."Description 2")
                    {
                    }
                    column(VATClauseAmount; VATAmountLine."VAT Amount")
                    {
                        AutoFormatExpression = "Issued Cash Collection Header"."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(VATClausesCaption; VATClausesCap)
                    {
                    }
                    column(VATClauseVATIdentifierCaption; VATIdentifierCap)
                    {
                    }
                    column(VATClauseVATAmtCaption; VATAmountCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        VATAmountLine.GetLine(Number);
                        if not VATClause.GET(VATAmountLine."VAT Clause Code") then
                            CurrReport.SKIP;
                        VATClause.TranslateDescription("Issued Cash Collection Header"."Language Code");
                    end;

                    trigger OnPreDataItem();
                    begin
                        CLEAR(VATClause);
                        SETRANGE(Number, 1, VATAmountLine.COUNT);
                        CurrReport.CREATETOTALS(VATAmountLine."VAT Amount");
                    end;
                }
                dataitem(VATCounterLCY; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(VALExchRate; VALExchRate)
                    {
                    }
                    column(VALSpecLCYHeader; VALSpecLCYHeader)
                    {
                    }
                    column(VALVATAmountLCY; VALVATAmountLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(VALVATBaseLCY; VALVATBaseLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(VATAmtLineVATCtrl107; VATAmountLine."VAT %")
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(ContinuedCaption1; ContinuedCaption1Lbl)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        VATAmountLine.GetLine(Number);

                        VALVATBaseLCY := ROUND(VATAmountLine."Amount Including VAT" / (1 + VATAmountLine."VAT %" / 100) / CurrFactor);
                        VALVATAmountLCY := ROUND(VATAmountLine."Amount Including VAT" / CurrFactor - VALVATBaseLCY);
                    end;

                    trigger OnPreDataItem();
                    begin
                        //HEI.01>>
                        if (not GLSetup."Print VAT specification in LCY") or
                           ("Issued Cash Collection Header"."Currency Code" = '') or
                           (VATAmountLine.GetTotalVATAmount = 0)
                        then
                            CurrReport.BREAK;

                        SETRANGE(Number, 1, VATAmountLine.COUNT);

                        VALVATBaseLCY := 0;
                        VALVATAmountLCY := 0;

                        if GLSetup."LCY Code" = '' then
                            VALSpecLCYHeader := Text011 + Text012
                        else
                            VALSpecLCYHeader := Text011 + FORMAT(GLSetup."LCY Code");

                        CurrExchRate.FindCurrency("Issued Cash Collection Header"."Posting Date", "Issued Cash Collection Header"."Currency Code", 1);
                        CustEntry.SETRANGE("Customer No.", "Issued Cash Collection Header"."Customer No.");
                        CustEntry.SETRANGE("Document Type", CustEntry."Document Type"::Reminder);
                        CustEntry.SETRANGE("Document No.", "Issued Cash Collection Header"."No.");
                        if CustEntry.FINDFIRST then begin
                            CustEntry.CALCFIELDS("Amount (LCY)", Amount);
                            CurrFactor := 1 / (CustEntry."Amount (LCY)" / CustEntry.Amount);
                            VALExchRate := STRSUBSTNO(Text013, ROUND(1 / CurrFactor * 100, 0.000001), CurrExchRate."Exchange Rate Amount");
                        end else begin
                            CurrFactor := CurrExchRate.ExchangeRate("Issued Cash Collection Header"."Posting Date", "Issued Cash Collection Header"."Currency Code");
                            VALExchRate := STRSUBSTNO(Text013, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                        //HEI.01<<
                    end;
                }
            }

            trigger OnAfterGetRecord();
            var
                GLAcc: Record "G/L Account";
                CustPostingGroup: Record "Customer Posting Group";
                VATPostingSetup: Record "VAT Posting Setup";
            begin
                //HEI.01>>
                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");

                DimSetEntry.SETRANGE("Dimension Set ID", "Dimension Set ID");
                // FormatAddr.IssuedCashCollection(CustAddr, "Issued Cash Collection Header"); 
                HeinekenBCCustomFunctions.IssuedCashCollection(CustAddr, "Issued Cash Collection Header");//BC Upgrade GUNREM01 -IssuedCashCollection function added in HeinekenBCCustomFunctions codeunit
                if "Your Reference" = '' then
                    ReferenceText := ''
                else
                    ReferenceText := FIELDCAPTION("Your Reference");
                if "VAT Registration No." = '' then
                    VATNoText := ''
                else
                    VATNoText := FIELDCAPTION("VAT Registration No.");
                if "Currency Code" = '' then begin
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text000, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                end else begin
                    TotalText := STRSUBSTNO(Text000, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text001, "Currency Code");
                end;
                CurrReport.PAGENO := 1;
                if not CurrReport.PREVIEW then begin
                    if LogInteraction then
                        SegManagement.LogDocument(
                          8, "No.", 0, 0, DATABASE::Customer, "Customer No.", '', '', "Posting Description", '');
                    IncrNoPrinted;
                end;
                CALCFIELDS("Additional Fee");
                CustPostingGroup.GET("Customer Posting Group");
                if GLAcc.GET(CustPostingGroup."Additional Fee Account") then begin
                    VATPostingSetup.GET("VAT Bus. Posting Group", GLAcc."VAT Prod. Posting Group");
                    AddFeeInclVAT := "Additional Fee" * (1 + VATPostingSetup."VAT %" / 100);
                end else
                    AddFeeInclVAT := "Additional Fee";

                CALCFIELDS("Add. Fee per Line");
                AddFeePerLineInclVAT := "Add. Fee per Line" + CalculateLineFeeVATAmount;

                CALCFIELDS("Interest Amount", "VAT Amount");
                if ("Interest Amount" <> 0) and ("VAT Amount" <> 0) then begin
                    GLAcc.GET(CustPostingGroup."Interest Account");
                    VATPostingSetup.GET("VAT Bus. Posting Group", GLAcc."VAT Prod. Posting Group");
                    VATInterest := VATPostingSetup."VAT %";
                    Interest :=
                      ("Interest Amount" +
                       "VAT Amount" + "Additional Fee" - AddFeeInclVAT + "Add. Fee per Line" - AddFeePerLineInclVAT) / (VATInterest / 100 + 1);
                end else begin
                    Interest := "Interest Amount";
                    VATInterest := 0;
                end;

                TotalVATAmount := "VAT Amount";
                NNC_InterestAmountTotal := 0;
                NNC_RemainingAmountTotal := 0;
                NNC_VATAmountTotal := 0;
                NNC_InterestAmount := 0;
                NNC_Total := 0;
                NNC_VATAmount := 0;
                NNC_TotalInclVAT := 0;

                //BC UPGRADE KUMARR78 ++01-07-2026
                Clear(ShippingAgentName);
                if ShippingAgent.Get("Issued Cash Collection Header"."Shipping Agent Code") then
                    ShippingAgentName := ShippingAgent.Name;
                //BC UPGRADE KUMARR78 ++01-07-2026
                //BC UPGRADE KUMARR78 --01-07-2026
                // ShippingAgent.RESET;
                // ShippingAgent.GET("Issued Cash Collection Header"."Shipping Agent Code");
                // if ShippingAgent.FINDFIRST then
                //     ShippingAgentName := ShippingAgent.Name;
                //BC UPGRADE KUMARR78 --01-07-2026
                //HEI.01<<
            end;

            trigger OnPreDataItem();
            begin
                CompanyInfo.GET;
                FormatAddr.Company(CompanyAddr, CompanyInfo);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowNotDueAmounts; ShowNotDueAmounts)
                    {
                        Caption = 'Show Not Due Amounts';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit();
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage();
        var
            enumvalue: Enum "Interaction Log Entry Document Type";
        begin
            //  LogInteraction := SegManagement.FindInteractTmplCode(8) <> '';
            LogInteraction := SegManagement.FindInteractionTemplateCode(enumvalue::"Sales Rmdr.") <> ''; //BC Upgrade GUNREM01 BC renamed the fucntion name 
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
        lblTruckCode = 'Truck Code'; lblDrivercode = 'Driver Code'; lblShipingAgentCode = 'Shipping Agent Code'; lblAmounttocollect = 'Amount To Collect';
    }

    trigger OnInitReport();
    begin
        //HEI.01>>
        GLSetup.GET;
        SalesSetup.GET;

        case SalesSetup."Logo Position on Documents" of
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                begin
                    CompanyInfo1.GET;
                    CompanyInfo1.CALCFIELDS(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Center:
                begin
                    CompanyInfo2.GET;
                    CompanyInfo2.CALCFIELDS(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Right:
                begin
                    CompanyInfo3.GET;
                    CompanyInfo3.CALCFIELDS(Picture);
                end;
        end;
    end;

    var
        Text000: Label 'Total %1';
        Text001: Label 'Total %1 Incl. VAT';
        Text002: Label 'Page %1';
        CustEntry: Record "Cust. Ledger Entry";
        GLSetup: Record "General Ledger Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        VATAmountLine: Record "VAT Amount Line" temporary;
        VATClause: Record "VAT Clause";
        DimSetEntry: Record "Dimension Set Entry";
        //Language: Record Language;
        LanguageG: Codeunit Language; //BC Upgrade GUNREM01 moved from record to codeunit
        HeinekenBCCustomFunctions: Codeunit "Heineken BC Custom Functions"; //BC Upgrade GUNREM01
        CurrExchRate: Record "Currency Exchange Rate";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        CustAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        VATNoText: Text[30];
        ReferenceText: Text[35];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        ReminderInterestAmount: Decimal;
        EndLineNo: Integer;
        Continue: Boolean;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        LogInteraction: Boolean;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        CurrFactor: Decimal;
        Text011: Label '"VAT Amount Specification in "';
        Text012: Label 'Local Currency';
        Text013: Label 'Exchange rate: %1/%2';
        AddFeeInclVAT: Decimal;
        AddFeePerLineInclVAT: Decimal;
        TotalVATAmount: Decimal;
        VATInterest: Decimal;
        Interest: Decimal;
        VALVATBase: Decimal;
        VALVATAmount: Decimal;
        NNC_InterestAmount: Decimal;
        NNC_Total: Decimal;
        NNC_VATAmount: Decimal;
        NNC_TotalInclVAT: Decimal;
        NNC_InterestAmountTotal: Decimal;
        NNC_RemainingAmountTotal: Decimal;
        NNC_VATAmountTotal: Decimal;
        // [InDataSet]
        LogInteractionEnable: Boolean;
        ShowNotDueAmounts: Boolean;
        TextPageLbl: Label 'Page';
        PostingDateCaptionLbl: Label 'Posting Date';
        ReminderNoCaptionLbl: Label 'Cash Collection No.';
        BankAccNoCaptionLbl: Label 'Account No.';
        BankNameCaptionLbl: Label 'Bank';
        GiroNoCaptionLbl: Label 'Giro No.';
        VATRegNoCaptionLbl: Label 'VAT Registration No.';
        PhoneNoCaptionLbl: Label 'Phone No.';
        ReminderCaptionLbl: Label 'Cash collection Order';
        HeaderDimensionsCaptionLbl: Label 'Header Dimensions';
        DocumentDateCaption1Lbl: Label 'Document Date';
        InterestAmountCaptionLbl: Label 'Interest Amount';
        AmountIncVATCaptionLbl: Label 'Amount Including VAT';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification';
        VATClausesCap: Label 'VAT Clause';
        VATIdentifierCap: Label 'VAT Identifier';
        ContinuedCaptionLbl: Label 'Continued';
        ContinuedCaption1Lbl: Label 'Continued';
        DueDateCaptiionLbl: Label 'Due Date';
        VATAmountCaptionLbl: Label 'VAT Amount';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATPercentCaptionLbl: Label 'VAT %';
        TotalCaptionLbl: Label 'Total';
        PageCaptionLbl: Label 'Page';
        DocDateCaptionLbl: Label 'Document Date';
        HomePageCaptionLbl: Label 'Home Page';
        EMailCaptionLbl: Label 'Email';
        ShippingAgentName: Text[50];
        ShippingAgent: Record "Shipping Agent";
}

