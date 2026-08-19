report 53067 "Cash Collection Order"
{

    //BC Upgrade GUNREM01 Old ID-50005
    // version NAVW110.0

    // HEI.01 FDD OTCGAP022 Heilite BASE IBM ISYED01 28/06/2017
    //   # Cash Collection order

    //BC Upgrade GUNREM01
    //# Changed RequestFilterHeading property
    //# Commented one option field -In NAV we can use any numbers, but in BC we cannot use the numbers, and in the type field we have only one option >>


    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Cash Collection Order.rdl';

    Caption = 'Cash Collection Order';
    ApplicationArea = All;


    dataset
    {
        dataitem("Cash Collection Header"; "Cash Collection Header FND")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            // ReqFilterHeading = 'Cash Collection';
            RequestFilterHeading = 'Cash Collection'; //BC Upgrade GUNREM01 
            column(Reminder_Header_No_;
            "No.")
            {
            }
            dataitem(PageCounter; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(COMPANYNAME; COMPANYNAME)
                {
                }
                column(TextPage; TextPageLbl)
                {
                }
                column(STRSUBSTNO_Text008_ReminderHeaderFilter_; STRSUBSTNO(Text008, ReminderHeaderFilter))
                {
                }
                column(ReminderHeaderFilter; ReminderHeaderFilter)
                {
                }
                column(STRSUBSTNO___1__2___Reminder_Header___No___Cust_Name_; STRSUBSTNO('%1 %2', "Cash Collection Header"."No.", Cust.Name))
                {
                }
                column(CustAddr_8_; CustAddr[8])
                {
                }
                column(CustAddr_7_; CustAddr[7])
                {
                }
                column(CustAddr_6_; CustAddr[6])
                {
                }
                column(CustAddr_5_; CustAddr[5])
                {
                }
                column(CustAddr_4_; CustAddr[4])
                {
                }
                column(CustAddr_3_; CustAddr[3])
                {
                }
                column(CustAddr_2_; CustAddr[2])
                {
                }
                column(CustAddr_1_; CustAddr[1])
                {
                }
                column(Reminder_Header___Reminder_Terms_Code_; "Cash Collection Header"."Cash Collection Terms Code")
                {
                }
                column(Reminder_Header___Reminder_Level_; "Cash Collection Header"."Cash Collection Level")
                {
                }
                column(Reminder_Header___Document_Date_; FORMAT("Cash Collection Header"."Document Date"))
                {
                }
                column(Reminder_Header___Posting_Date_; FORMAT("Cash Collection Header"."Posting Date"))
                {
                }
                column(Reminder_Header___Post_Interest_; FORMAT("Cash Collection Header"."Post Interest"))
                {
                }
                column(Reminder_Header___VAT_Registration_No__; "Cash Collection Header"."VAT Registration No.")
                {
                }
                column(Reminder_Header___Your_Reference_; "Cash Collection Header"."Your Reference")
                {
                }
                column(Reminder_Header___Post_Additional_Fee_; FORMAT("Cash Collection Header"."Post Additional Fee"))
                {
                }
                column(Reminder_Header___Post_Additional_Fee_per_Line; FORMAT("Cash Collection Header"."Post Add. Fee per Line"))
                {
                }
                column(Reminder_Header___Fin__Charge_Terms_Code_; "Cash Collection Header"."Fin. Charge Terms Code")
                {
                }
                column(Reminder_Header___Due_Date_; FORMAT("Cash Collection Header"."Due Date"))
                {
                }
                column(Reminder_Header___Customer_No__; "Cash Collection Header"."Customer No.")
                {
                }
                column(ReferenceText; ReferenceText)
                {
                }
                column(VATNoText; VATNoText)
                {
                }
                column(Reminder___TestCaption; Reminder___TestCaptionLbl)
                {
                }
                column(Reminder_Header___Reminder_Terms_Code_Caption; "Cash Collection Header".FIELDCAPTION("Cash Collection Terms Code"))
                {
                }
                column(Reminder_Header___Reminder_Level_Caption; "Cash Collection Header".FIELDCAPTION("Cash Collection Level"))
                {
                }
                column(Reminder_Header___Document_Date_Caption; Reminder_Header___Document_Date_CaptionLbl)
                {
                }
                column(Reminder_Header___Posting_Date_Caption; Reminder_Header___Posting_Date_CaptionLbl)
                {
                }
                column(Reminder_Header___Post_Interest_Caption; CAPTIONCLASSTRANSLATE("Cash Collection Header".FIELDCAPTION("Post Interest")))
                {
                }
                column(Reminder_Header___Post_Additional_Fee_Caption; CAPTIONCLASSTRANSLATE("Cash Collection Header".FIELDCAPTION("Post Additional Fee")))
                {
                }
                column(Reminder_Header___Post_Additional_Fee_per_Line_Caption; CAPTIONCLASSTRANSLATE("Cash Collection Header".FIELDCAPTION("Post Add. Fee per Line")))
                {
                }
                column(Reminder_Header___Fin__Charge_Terms_Code_Caption; "Cash Collection Header".FIELDCAPTION("Fin. Charge Terms Code"))
                {
                }
                column(Reminder_Header___Due_Date_Caption; Reminder_Header___Due_Date_CaptionLbl)
                {
                }
                column(Reminder_Header___Customer_No__Caption; "Cash Collection Header".FIELDCAPTION("Customer No."))
                {
                }
                column(Cash_Collection_Header_Truck_Code; "Cash Collection Header"."Truck Code")
                {
                }
                column(Cash_Collection_Header_Driver_Code; "Cash Collection Header"."Driver Code")
                {
                }
                column(Cash_Collection_Header_Shipping_Agent_Name; ShippingAgentName)
                {
                }
                dataitem(DimensionLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                    column(DimText; DimText)
                    {
                    }
                    column(Header_DimensionsCaption; Header_DimensionsCaptionLbl)
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
                        repeat
                            OldDimText := DimText;
                            if DimText = '' then
                                DimText := STRSUBSTNO('%1 - %2', DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code")
                            else
                                DimText :=
                                  STRSUBSTNO(
                                    '%1; %2 - %3', DimText, DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code");
                            if STRLEN(DimText) > MAXSTRLEN(OldDimText) then begin
                                DimText := OldDimText;
                                exit;
                            end;
                        until DimSetEntry.NEXT = 0;
                    end;

                    trigger OnPreDataItem();
                    begin
                        //HEI.01>>
                        if not ShowDim then
                            CurrReport.BREAK;
                        DimSetEntry.SETRANGE("Dimension Set ID", "Cash Collection Header"."Dimension Set ID");
                        //HEI.01<<
                    end;
                }
                dataitem(HeaderErrorCounter; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(ErrorText_Number_; ErrorText[Number])
                    {
                    }
                    column(ErrorText_Number_Caption; ErrorText_Number_CaptionLbl)
                    {
                    }

                    trigger OnPostDataItem();
                    begin
                        ErrorCounter := 0;
                    end;

                    trigger OnPreDataItem();
                    begin
                        SETRANGE(Number, 1, ErrorCounter);
                    end;
                }
                dataitem("Cash Collection Line FND"; "Cash Collection Line FND")
                {
                    DataItemLink = "Cash Collection No." = FIELD("No.");
                    DataItemLinkReference = "Cash Collection Header";
                    DataItemTableView = SORTING("Cash Collection No.", "Line No.") WHERE("Line Type" = FILTER(<> "Not Due"));
                    column(Reminder_Line_Description; Description)
                    {
                    }
                    column(Reminder_Line__Type; Type)
                    {
                    }
                    column(Reminder_Line__Document_No__; "Document No.")
                    {
                    }
                    column(Reminder_Line__Original_Amount_; "Original Amount")
                    {
                    }
                    column(Reminder_Line__Remaining_Amount_; "Remaining Amount")
                    {
                        AutoFormatExpression = GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(Reminder_Line__Document_Date_; FORMAT("Document Date"))
                    {
                    }
                    column(Reminder_Line__Due_Date_; FORMAT("Due Date"))
                    {
                    }
                    column(Reminder_Line__Document_Type_; "Document Type")
                    {
                    }
                    column(NNC_TotalLCYVATAmount; NNC_TotalLCYVATAmount)
                    {
                    }
                    column(NNC_VATAmount; NNC_VATAmount)
                    {
                    }
                    column(NNC_TotalLCY; NNC_TotalLCY)
                    {
                    }
                    column(NNC_Interest; NNC_Interest)
                    {
                    }
                    column(Reminder_Line__No__; "No.")
                    {
                    }
                    column(Text009; Text009Lbl)
                    {
                    }
                    column(Reminder_Header_Additional_Fee_AddFeeInclVAT_VATInterest_100__1; (ReminderInterestAmount + "VAT Amount" + "Cash Collection Header"."Additional Fee" - AddFeeInclVAT) / (VATInterest / 100 + 1))
                    {
                        AutoFormatExpression = GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(Remaining_Amount_VATInterest_100____Reminder_Header___Additional_Fee____AddFeeInclVAT; "Remaining Amount" + ReminderInterestAmount)
                    {
                        AutoFormatExpression = GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(TotalText; TotalText)
                    {
                    }
                    column(Reminder_Header___Additional_Fee_; "VAT Amount")
                    {
                        AutoFormatExpression = GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(TotalInclVATText; TotalInclVATText)
                    {
                    }
                    column(Remaining_Amount____ReminderInterestAmount____VAT_Amount_; "Remaining Amount" + ReminderInterestAmount + "VAT Amount")
                    {
                        AutoFormatExpression = GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(Reminder_Line_Line_No_; "Line No.")
                    {
                    }
                    column(Reminder_Line__Original_Amount_Caption; FIELDCAPTION("Original Amount"))
                    {
                    }
                    column(Reminder_Line__Remaining_Amount_Caption; FIELDCAPTION("Remaining Amount"))
                    {
                    }
                    column(Reminder_Line__Due_Date_Caption; Reminder_Line__Due_Date_CaptionLbl)
                    {
                    }
                    column(Reminder_Line__Document_No__Caption; FIELDCAPTION("Document No."))
                    {
                    }
                    column(Reminder_Line__Document_Date_Caption; Reminder_Line__Document_Date_CaptionLbl)
                    {
                    }
                    column(Reminder_Line__Document_Type_Caption; FIELDCAPTION("Document Type"))
                    {
                    }
                    column(Text009Caption; Text009CaptionLbl)
                    {
                    }
                    column(ReminderInterestAmount_VATInterest_100__1_Caption; ReminderInterestAmount_VATInterest_100__1_CaptionLbl)
                    {
                    }
                    column(VAT_AmountCaption; VAT_AmountCaptionLbl)
                    {
                    }
                    column(Interest; Interest)
                    {
                    }
                    dataitem(LineErrorCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(ErrorText_Number__Control97; ErrorText[Number])
                        {
                        }
                        column(ErrorText_Number__Control97Caption; ErrorText_Number__Control97CaptionLbl)
                        {
                        }

                        trigger OnPostDataItem();
                        begin
                            ErrorCounter := 0;
                        end;

                        trigger OnPreDataItem();
                        begin
                            SETRANGE(Number, 1, ErrorCounter);
                        end;
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
                        VATAmountLine.InsertLine;

                        case Type of
                            Type::"Customer Ledger Entry":
                                "Remaining Amount" := Amount;
                        //BC Upgrade GUNREM01 -In NAV we can use any numbers, but in BC we cannot use the numbers, and in the type field we have only one option >>
                        // Type::"3":
                        //     "Remaining Amount" := Amount;
                        // Type::"2":
                        //     ReminderInterestAmount := Amount;
                        //BC Upgrade GUNREM01 -In NAV we can use any numbers, but in BC we cannot use the numbers, and in the type field we have only one option <<

                        end;

                        TotalVATAmount += "VAT Amount";

                        NNC_RemAmtTotal += "Remaining Amount";
                        NNC_VatAmtTotal += "VAT Amount";
                        NNC_ReminderInterestAmt += ReminderInterestAmount;

                        NNC_Interest :=
                          (NNC_ReminderInterestAmt + NNC_VatAmtTotal + "Cash Collection Header"."Additional Fee" - AddFeeInclVAT +
                          "Cash Collection Header"."Add. Fee per Line" - AddFeePerLineInclVAT) /
                          (VATInterest / 100 + 1);

                        NNC_TotalLCY := NNC_RemAmtTotal + NNC_ReminderInterestAmt;

                        NNC_VATAmount := NNC_VatAmtTotal;

                        NNC_TotalLCYVATAmount := NNC_RemAmtTotal + NNC_VatAmtTotal + NNC_ReminderInterestAmt;
                        //HEI.01<<
                    end;

                    trigger OnPreDataItem();
                    begin
                        TotalVATAmount := 0;

                        if FIND('+') then
                            repeat
                                Continue := "No. of Reminders" = 0;
                            until ((NEXT(-1) = 0) or not Continue);

                        VATAmountLine.DELETEALL;
                        CurrReport.CREATETOTALS("Remaining Amount", "VAT Amount", ReminderInterestAmount);
                    end;
                }
                dataitem("Not Due"; "Cash Collection Line FND")
                {
                    DataItemLink = "Cash Collection No." = FIELD("No.");
                    DataItemLinkReference = "Cash Collection Header";
                    DataItemTableView = SORTING("Cash Collection No.", "Line No.") WHERE("Line Type" = CONST("Not Due"));
                    column(Not_Due__Document_Date_; FORMAT("Document Date"))
                    {
                    }
                    column(Not_Due__Document_Type_; "Document Type")
                    {
                    }
                    column(Not_Due__Document_No__; "Document No.")
                    {
                    }
                    column(Not_Due__Due_Date_; FORMAT("Due Date"))
                    {
                    }
                    column(Not_Due__Original_Amount_; "Original Amount")
                    {
                    }
                    column(Not_Due__Remaining_Amount_; "Remaining Amount")
                    {
                        AutoFormatExpression = "Cash Collection Line FND".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(Not_Due__Type; Type)
                    {
                    }
                    column(Not_Due__Document_Type_Caption; FIELDCAPTION("Document Type"))
                    {
                    }
                    column(Not_Due__Document_No__Caption; FIELDCAPTION("Document No."))
                    {
                    }
                    column(Not_Due__Due_Date_Caption; Not_Due__Due_Date_CaptionLbl)
                    {
                    }
                    column(Not_Due__Original_Amount_Caption; FIELDCAPTION("Original Amount"))
                    {
                    }
                    column(Not_Due__Remaining_Amount_Caption; FIELDCAPTION("Remaining Amount"))
                    {
                    }
                    column(Not_Due__Document_Date_Caption; Not_Due__Document_Date_CaptionLbl)
                    {
                    }
                    column(Open_Entries_Not_DueCaption; Open_Entries_Not_DueCaptionLbl)
                    {
                    }
                }
                dataitem(VATCounter; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(VALVATAmount; VALVATAmount)
                    {
                        AutoFormatExpression = "Cash Collection Line FND".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(VALVATBase; VALVATBase)
                    {
                        AutoFormatExpression = "Cash Collection Line FND".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(VATAmountLine__VAT_Amount_; VATAmountLine."VAT Amount")
                    {
                        AutoFormatExpression = "Cash Collection Line FND".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(VATAmountLine__VAT_Base_; VATAmountLine."VAT Base")
                    {
                        AutoFormatExpression = "Cash Collection Line FND".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(VATAmountLine__VAT___; VATAmountLine."VAT %")
                    {
                    }
                    column(VATAmountLine__Amount_Including_VAT_; VATAmountLine."Amount Including VAT")
                    {
                        AutoFormatExpression = "Cash Collection Line FND".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(VATAmountLine__VAT_Amount__Control51; VATAmountLine."VAT Amount")
                    {
                        AutoFormatExpression = "Cash Collection Line FND".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(VATAmountLine__VAT_Base__Control52; VATAmountLine."VAT Base")
                    {
                        AutoFormatExpression = "Cash Collection Line FND".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(VATAmountLine__Amount_Including_VAT__Control78; VATAmountLine."Amount Including VAT")
                    {
                        AutoFormatExpression = "Cash Collection Line FND".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(VALVATBase_Control49; VALVATBase)
                    {
                        AutoFormatExpression = "Cash Collection Line FND".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(VATAmountLine__VAT_Amount_Caption; VATAmountLine__VAT_Amount_CaptionLbl)
                    {
                    }
                    column(VATAmountLine__VAT_Base_Caption; VATAmountLine__VAT_Base_CaptionLbl)
                    {
                    }
                    column(VAT_Amount_SpecificationCaption; VAT_Amount_SpecificationCaptionLbl)
                    {
                    }
                    column(VATAmountLine__VAT___Caption; VATAmountLine__VAT___CaptionLbl)
                    {
                    }
                    column(VATAmountLine__Amount_Including_VAT_Caption; VATAmountLine__Amount_Including_VAT_CaptionLbl)
                    {
                    }
                    column(VALVATBase_Control49Caption; VALVATBase_Control49CaptionLbl)
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
                        if TotalVATAmount = 0 then
                            CurrReport.BREAK;
                        SETRANGE(Number, 1, VATAmountLine.COUNT);
                        CurrReport.CREATETOTALS(VALVATBase, VALVATAmount);
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
                    column(VALVATAmountLCY_Control114; VALVATAmountLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(VALVATBaseLCY_Control115; VALVATBaseLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(VATAmountLine__VAT____Control116; VATAmountLine."VAT %")
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(VALVATAmountLCY_Control121; VALVATAmountLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(VALVATBaseLCY_Control122; VALVATBaseLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(VALVATAmountLCY_Control114Caption; VALVATAmountLCY_Control114CaptionLbl)
                    {
                    }
                    column(VALVATBaseLCY_Control115Caption; VALVATBaseLCY_Control115CaptionLbl)
                    {
                    }
                    column(VATAmountLine__VAT____Control116Caption; VATAmountLine__VAT____Control116CaptionLbl)
                    {
                    }
                    column(VALVATBaseLCY_Control122Caption; VALVATBaseLCY_Control122CaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        //HEI.01>>
                        VATAmountLine.GetLine(Number);

                        VALVATBaseLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                             "Cash Collection Header"."Posting Date", "Cash Collection Header"."Currency Code",
                              VALVATBase, CurrFactor));
                        VALVATAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                              "Cash Collection Header"."Posting Date", "Cash Collection Header"."Currency Code",
                              VALVATAmount, CurrFactor));
                        //HEI.01<<
                    end;

                    trigger OnPreDataItem();
                    begin
                        //HEI.01>>
                        if (not GLSetup."Print VAT specification in LCY") or
                           ("Cash Collection Header"."Currency Code" = '') or
                           (VATAmountLine.GetTotalVATAmount = 0)
                        then
                            CurrReport.BREAK;

                        SETRANGE(Number, 1, VATAmountLine.COUNT);
                        CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                        if GLSetup."LCY Code" = '' then
                            VALSpecLCYHeader := Text011 + Text012
                        else
                            VALSpecLCYHeader := Text011 + FORMAT(GLSetup."LCY Code");

                        CurrExchRate.FindCurrency("Cash Collection Header"."Posting Date", "Cash Collection Header"."Currency Code", 1);
                        VALExchRate := STRSUBSTNO(Text013, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        CurrFactor := CurrExchRate.ExchangeRate("Cash Collection Header"."Posting Date",
                            "Cash Collection Header"."Currency Code");
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
                CALCFIELDS("Remaining Amount");
                if "Customer No." = '' then
                    AddError(STRSUBSTNO(Text000, FIELDCAPTION("Customer No.")))
                else begin
                    if Cust.GET("Customer No.") then begin
                        if Cust.Blocked = Cust.Blocked::All then
                            AddError(
                              STRSUBSTNO(
                                Text010,
                                Cust.FIELDCAPTION(Blocked), Cust.Blocked, Cust.TABLECAPTION, "Customer No."));
                    end else
                        AddError(
                          STRSUBSTNO(
                            Text003,
                            Cust.TABLECAPTION, "Customer No."));
                end;

                GLSetup.GET;

                if "Posting Date" = 0D then
                    AddError(STRSUBSTNO(Text000, FIELDCAPTION("Posting Date")))
                else begin
                    if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
                        if USERID <> '' then
                            if UserSetup.GET(USERID) then begin
                                AllowPostingFrom := UserSetup."Allow Posting From";
                                AllowPostingTo := UserSetup."Allow Posting To";
                            end;
                        if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
                            AllowPostingFrom := GLSetup."Allow Posting From";
                            AllowPostingTo := GLSetup."Allow Posting To";
                        end;
                        if AllowPostingTo = 0D then
                            AllowPostingTo := DMY2DATE(31, 12, 9999);
                    end;
                    if ("Posting Date" < AllowPostingFrom) or ("Posting Date" > AllowPostingTo) then
                        AddError(
                          STRSUBSTNO(
                            Text004, FIELDCAPTION("Posting Date")));
                end;
                if "Document Date" = 0D then
                    AddError(STRSUBSTNO(Text000, FIELDCAPTION("Document Date")));
                if "Due Date" = 0D then
                    AddError(STRSUBSTNO(Text000, FIELDCAPTION("Due Date")));
                if "Customer Posting Group" = '' then
                    AddError(STRSUBSTNO(Text000, FIELDCAPTION("Customer Posting Group")));
                if "Currency Code" = '' then begin
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text005, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text006, GLSetup."LCY Code");
                end else begin
                    TotalText := STRSUBSTNO(Text005, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text006, "Currency Code");
                end;
                //FormatAddr."CashCollection"(CustAddr,"Cash Collection Header FND");
                if "Your Reference" = '' then
                    ReferenceText := ''
                else
                    ReferenceText := FIELDCAPTION("Your Reference");
                if "VAT Registration No." = '' then
                    VATNoText := ''
                else
                    VATNoText := FIELDCAPTION("VAT Registration No.");

                if not DimMgt.CheckDimIDComb("Dimension Set ID") then
                    AddError(DimMgt.GetDimCombErr);

                TableID[1] := DATABASE::Customer;
                No[1] := "Customer No.";
                if not DimMgt.CheckDimValuePosting(TableID, No, "Dimension Set ID") then
                    AddError(DimMgt.GetDimValuePostingErr);

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

                NNC_Interest := 0;
                NNC_TotalLCY := 0;
                NNC_VATAmount := 0;
                NNC_TotalLCYVATAmount := 0;
                NNC_RemAmtTotal := 0;
                NNC_VatAmtTotal := 0;
                NNC_ReminderInterestAmt := 0;


                ShippingAgent.RESET;
                ShippingAgent.GET("Cash Collection Header"."Shipping Agent Code");
                if ShippingAgent.FINDFIRST then
                    ShippingAgentName := ShippingAgent.Name;
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
                    Caption = 'Options';
                    field(ShowDimensions; ShowDim)
                    {
                        Caption = 'Show Dimensions';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        lblTruckCode = 'Truck Code'; lblDrivercode = 'Driver Code'; lblShipingAgentCode = 'Shipping Agent Code';
    }

    trigger OnInitReport();
    begin
        GLSetup.GET;
    end;

    trigger OnPreReport();
    begin
        //HEI.01>>
        ReminderHeaderFilter := "Cash Collection Header".GETFILTERS;
        //HEI.01<<
    end;

    var
        Text000: Label '%1 must be specified.';
        Text003: Label '%1 %2 does not exist.';
        Text004: Label '%1 is not within your allowed range of posting dates.';
        Text005: Label 'Total %1';
        Text006: Label 'Total %1 Incl. VAT';
        Text008: Label 'Cash Collection: %1';
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        Cust: Record Customer;
        VATAmountLine: Record "VAT Amount Line" temporary;
        DimSetEntry: Record "Dimension Set Entry";
        CurrExchRate: Record "Currency Exchange Rate";
        DimMgt: Codeunit DimensionManagement;
        FormatAddr: Codeunit "Format Address";
        CustAddr: array[8] of Text[50];
        ReminderHeaderFilter: Text;
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        ReminderInterestAmount: Decimal;
        Continue: Boolean;
        VATNoText: Text[30];
        ReferenceText: Text[30];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        ErrorCounter: Integer;
        ErrorText: array[99] of Text[250];
        DimText: Text[120];
        OldDimText: Text[75];
        ShowDim: Boolean;
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        Text010: Label '%1 must not be %2 for %3 %4.';
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        Text011: Label '"VAT Amount Specification in "';
        Text012: Label 'Local Currency';
        Text013: Label 'Exchange rate: %1/%2';
        CurrFactor: Decimal;
        TotalVATAmount: Decimal;
        AddFeeInclVAT: Decimal;
        AddFeePerLineInclVAT: Decimal;
        VATInterest: Decimal;
        Interest: Decimal;
        VALVATBase: Decimal;
        VALVATAmount: Decimal;
        NNC_Interest: Decimal;
        NNC_TotalLCY: Decimal;
        NNC_VATAmount: Decimal;
        NNC_TotalLCYVATAmount: Decimal;
        NNC_RemAmtTotal: Decimal;
        NNC_VatAmtTotal: Decimal;
        NNC_ReminderInterestAmt: Decimal;
        TextPageLbl: Label 'Page';
        Reminder___TestCaptionLbl: Label 'Cash Collection Order';
        Reminder_Header___Document_Date_CaptionLbl: Label 'Document Date';
        Reminder_Header___Posting_Date_CaptionLbl: Label 'Posting Date';
        Reminder_Header___Due_Date_CaptionLbl: Label 'Due Date';
        Header_DimensionsCaptionLbl: Label 'Header Dimensions';
        ErrorText_Number_CaptionLbl: Label 'Warning!';
        Text009Lbl: Label 'Interests must be positive or 0.';
        Reminder_Line__Due_Date_CaptionLbl: Label 'Due Date';
        Reminder_Line__Document_Date_CaptionLbl: Label 'Document Date';
        Text009CaptionLbl: Label 'Warning!';
        ReminderInterestAmount_VATInterest_100__1_CaptionLbl: Label 'Interest Amount';
        VAT_AmountCaptionLbl: Label 'VAT Amount';
        ErrorText_Number__Control97CaptionLbl: Label 'Warning!';
        Not_Due__Due_Date_CaptionLbl: Label 'Due Date>';
        Not_Due__Document_Date_CaptionLbl: Label 'Document Date';
        Open_Entries_Not_DueCaptionLbl: Label 'Open Entries Not Due';
        VATAmountLine__VAT_Amount_CaptionLbl: Label 'VAT Amount';
        VATAmountLine__VAT_Base_CaptionLbl: Label 'VAT Base';
        VAT_Amount_SpecificationCaptionLbl: Label 'VAT Amount Specification';
        VATAmountLine__VAT___CaptionLbl: Label 'VAT %';
        VATAmountLine__Amount_Including_VAT_CaptionLbl: Label 'Amount Including VAT';
        VALVATBase_Control49CaptionLbl: Label 'Total';
        VALVATAmountLCY_Control114CaptionLbl: Label 'VAT Amount';
        VALVATBaseLCY_Control115CaptionLbl: Label 'VAT Base';
        VATAmountLine__VAT____Control116CaptionLbl: Label 'VAT %';
        VALVATBaseLCY_Control122CaptionLbl: Label 'Total';
        ShippingAgent: Record "Shipping Agent";
        ShippingAgentName: Text[50];

    local procedure AddError(Text: Text[250]);
    begin
        ErrorCounter := ErrorCounter + 1;
        ErrorText[ErrorCounter] := Text;
    end;

    procedure InitializeRequest(NewShowDim: Boolean);
    begin
        ShowDim := NewShowDim;
    end;
}

