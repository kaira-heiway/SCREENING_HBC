report 55044 "Aged Accounts Receivable BdB1"
{
    // version HEI.01
    // DITW15.00.00.37 DDR 01/06/2010 issue 857 Added "DIT Sub-Contract type Filter","Contract Group Code Filter" to filter the entries
    // DITW16.00.00.37 CEL 20/08/2010 DIT-715 #1 RTC Report/Page functionnalities & Nav SQL performances
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields "Item Charge Type Filter","Service contract no. filter"
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 SR 19/12/2013 DIT-770 #163 : Few Filter Added & Removed in Show Result
    // DITW17.00.02 AT 22/01/2014 DIT-770 #163 : Setting a Customer Posting Group Filter does not influence the result
    // HNK100089 MRA-IBM 23/07/15: Added to ReqFilterFields fields in Customer "Item Charge Type Filter"
    // 
    // HNK100222 MRA-IBM 27/04/16: New report
    // 
    // HEI.01 IBM SURYAS01 Defect #5213
    //   #Created New Text Constanats variable= "TerritoryLbl" and added in the layout
    //   #Added "OriginalAmtCptn"  column in the layout if the report is to print without details
    // HEI.02 CHG2141996 HB2603 IBM GAVANM01 15.02.2022 #Aged account receivable Bdb
    //   #Filtering of the report is changed to Posting date
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID - 50374.
    // 2. Add layout path and change layout extension RDLC to RDL. 
    // 3. Remove Drink-IT Fields and Related code("Service Contract No. Filter","Contract Group Filter","DIT Sub-Contract Type Filter","Item Charge Type Filter","Customer Posting Group Filter","Driver Code")
    // 4. Remove Drink-IT Customization.
    // 5. Re-Structure Excel Buffer code.
    // BC Upgrade BHARDA11 <<

    //BC UPGRADE KUMARR78 >>
    //FDD No.-->   FDD-MTC-089
    //GAP Np. -->  IBM GAP MTC 56 
    //Generate aging report
    //Adding ApplicationArea and Usagecategory
    //BC UPGRADE KUMARR78 Replacing Customer Posting Group Filter field with Standard Customer Posting Group Field, Item Charge Type Filter with "CM Incl. EG. Lim. Warn APS".
    //BC UPGRADE KUMARR78 <<

    DefaultLayout = RDLC;
    ApplicationArea = all; //BC UPGRADE KUMARR78 Adding ApplicationArea 
    UsageCategory = ReportsAndAnalysis; //BC UPGRADE KUMARR78 Adding UsageCategory
    RDLCLayout = '.\src\ReportsLayout\Aged Accounts Receivable BdB1.rdl'; // BC Upgrade BHARDA11 ----Add layout path and change layout extension RDLC to RDL.

    CaptionML = ENU = 'Aged Accounts Receivable BdB',
                FRA = 'Comptabilité client âgée BdB';
    PreviewMode = Normal;

    dataset
    {
        dataitem(SalesPerson; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
            dataitem(Customer; Customer)
            {
                // RequestFilterFields = "No.", "Service Contract No. Filter", "Customer Posting Group Filter", "Item Charge Type Filter"; // BC Upgrade BHARDA11 ----Drink-IT Fields( "Service Contract No. Filter", "Customer Posting Group Filter", "Item Charge Type Filter")
                // RequestFilterFields = "No."; //BC UPGRADE KUMARR78 -- Blocking to Add Fields and Rewrite
                RequestFilterFields = "No.", "Customer Posting Group", "CM Incl. EG Limit Filter APS"; //BC UPGRADE KUMARR78 Adding Field

                column(TodayFormatted; FORMAT(TODAY, 0, 4))
                {
                }
                column(CompanyName; COMPANYNAME)
                {
                }
                column(FormatEndingDate; STRSUBSTNO(Text006, FORMAT(EndingDate, 0, 4)))
                {
                }
                column(PostingDate; STRSUBSTNO(Text007, SELECTSTR(AgingBy + 1, Text009)))
                {
                }
                column(PrintAmountInLCY; PrintAmountInLCY)
                {
                }
                column(TableCaptnCustFilter; TABLECAPTION + ': ' + CustFilter)
                {
                }
                column(CustFilter; CustFilter)
                {
                }
                column(AgingByDueDate; AgingBy = AgingBy::"Due Date")
                {
                }
                column(AgedbyDocumnetDate; STRSUBSTNO(Text004, SELECTSTR(AgingBy + 1, Text009)))
                {
                }
                column(HeaderText6; HeaderText[6])
                {
                }
                column(HeaderText5; HeaderText[5])
                {
                }
                column(HeaderText4; HeaderText[4])
                {
                }
                column(HeaderText3; HeaderText[3])
                {
                }
                column(HeaderText2; HeaderText[2])
                {
                }
                column(HeaderText1; HeaderText[1])
                {
                }
                column(PrintDetails; PrintDetails)
                {
                }
                column(GrandTotalCLE6RemAmt; GrandTotalCustLedgEntry[6]."Remaining Amt. (LCY)")
                {
                }
                column(GrandTotalCLE5RemAmt; GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)")
                {
                    AutoFormatType = 1;
                }
                column(GrandTotalCLE4RemAmt; GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)")
                {
                    AutoFormatType = 1;
                }
                column(GrandTotalCLE3RemAmt; GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)")
                {
                    AutoFormatType = 1;
                }
                column(GrandTotalCLE2RemAmt; GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)")
                {
                    AutoFormatType = 1;
                }
                column(GrandTotalCLE1RemAmt; GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)")
                {
                    AutoFormatType = 1;
                }
                column(GrandTotalCLEAmtLCY; GrandTotalCustLedgEntry[1]."Amount (LCY)")
                {
                    AutoFormatType = 1;
                }
                column(GrandTotalCLE1CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                {
                }
                column(GrandTotalCLE2CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                {
                }
                column(GrandTotalCLE3CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                {
                }
                column(GrandTotalCLE4CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                {
                }
                column(GrandTotalCLE5CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                {
                }
                column(GrandTotalCLE6CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[6]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                {
                }
                column(AgedAccReceivableCptn; AgedAccReceivableCptnLbl)
                {
                }
                column(CurrReportPageNoCptn; CurrReportPageNoCptnLbl)
                {
                }
                column(AllAmtinLCYCptn; AllAmtinLCYCptnLbl)
                {
                }
                column(AgedOverdueAmtCptn; AgedOverdueAmtCptnLbl)
                {
                }
                column(CLEEndDateAmtLCYCptn; CLEEndDateAmtLCYCptnLbl)
                {
                }
                column(CLEEndDateDueDateCptn; CLEEndDateDueDateCptnLbl)
                {
                }
                column(CLEEndDateDocNoCptn; CLEEndDateDocNoCptnLbl)
                {
                }
                column(CLEEndDatePstngDateCptn; CLEEndDatePstngDateCptnLbl)
                {
                }
                column(CLEEndDateDocTypeCptn; CLEEndDateDocTypeCptnLbl)
                {
                }
                column(OriginalAmtCptn; OriginalAmtCptnLbl)
                {
                }
                column(TotalLCYCptn; TotalLCYCptnLbl)
                {
                }
                column(NewPagePercustomer; NewPagePercustomer)
                {
                }
                column(PageGroupNo; PageGroupNo)
                {
                }
                column(SalesPersonCptn; SalesPersonLbl)
                {
                }
                column(PmtTermsCptn; PmtTermsLbl)
                {
                }
                column(PmtMethodCptn; PmtMethodLbl)
                {
                }
                column(DriverCodeCptn; DriverCodeLbl)
                {
                }
                column(TerritoryLbl; TerritoryLbl)
                {
                }
                dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
                {
                    // DataItemLink = "Customer No." = FIELD("No."), "Customer Posting Group" = FIELD("Customer Posting Group Filter"); // BC Upgrade BHARDA11 ----Drink-IT Field("Customer Posting Group Filter")
                    // DataItemLink = "Customer No." = FIELD("No.");//, "Customer Posting Group" = FIELD("Customer Posting Group Filter"); //BC UPGRADE KUMARR78 --Blocking to Add Field
                    DataItemLink = "Customer No." = FIELD("No."), "Customer Posting Group" = FIELD("Customer Posting Group"); //BC UPGRADE KUMARR78 ++ Adding Customer Posting Group to Add Field

                    DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code");

                    trigger OnAfterGetRecord();
                    var
                        CustLedgEntry: Record "Cust. Ledger Entry";
                    begin
                        CustLedgEntry.SETCURRENTKEY("Closed by Entry No.");
                        CustLedgEntry.SETRANGE("Closed by Entry No.", "Entry No.");
                        CustLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                        //<<DITW17.00.02 AT 22/01/2014 DIT-770 #163
                        // CustLedgEntry.SETRANGE("Customer Posting Group", Customer."Customer Posting Group Filter"); // BC Upgrade BHARDA11  ----Drink-IT Customization
                        CustLedgEntry.SETRANGE("Customer Posting Group", Customer."Customer Posting Group"); // BC UPGRADE KUMARR78 ++Adding Filter.

                        //>>DITW17.00.02 AT DIT-770 #163
                        if CustLedgEntry.FINDSET(false) then
                            repeat
                                InsertTemp(CustLedgEntry);
                            until CustLedgEntry.NEXT() = 0;

                        if "Closed by Entry No." <> 0 then begin
                            CustLedgEntry.SETRANGE("Closed by Entry No.", "Closed by Entry No.");
                            if CustLedgEntry.FINDSET(false) then
                                repeat
                                    InsertTemp(CustLedgEntry);
                                until CustLedgEntry.NEXT() = 0;
                        end;


                        CustLedgEntry.RESET();
                        CustLedgEntry.SETRANGE("Entry No.", "Closed by Entry No.");
                        CustLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                        //<<DITW17.00.02 AT 22/01/2014 DIT-770 #163

                        // CustLedgEntry.SETRANGE("Customer Posting Group", Customer."Customer Posting Group Filter"); // BC Upgrade BHARDA11  ----Drink-IT Customization
                        CustLedgEntry.SETRANGE("Customer Posting Group", Customer."Customer Posting Group"); // BC UPGRADE KUMARR78 ++Adding Filter.

                        //>>DITW17.00.02 AT DIT-770 #163
                        if CustLedgEntry.FINDSET(false) then
                            repeat
                                InsertTemp(CustLedgEntry);
                            until CustLedgEntry.NEXT() = 0;
                        CurrReport.SKIP();
                    end;

                    trigger OnPreDataItem();
                    begin
                        SETRANGE("Posting Date", EndingDate + 1, 99991231D);
                        // <<DITW15.00.00.37 DDR 01/06/2010
                        // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                        // Customer.COPYFILTER("DIT Sub-Contract Type Filter", "DIT Sub-Contract Type");
                        // Customer.COPYFILTER("Contract Group Filter", "Contract Group Code");
                        // // >>DITW15.00.00.37 DDR
                        // // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
                        // Customer.COPYFILTER("Service Contract No. Filter", "Service Contract No.");
                        // Customer.COPYFILTER("Item Charge Type Filter", "Item Charge Type");
                        // // >>DITW16.00.00.42 DDR DIT-715 #370
                        // //<<DITW17.00.02 AT 22/01/2014 DIT-770 #163
                        // Customer.COPYFILTER("Customer Posting Group Filter", "Customer Posting Group");
                        // BC Upgrade BHARDA11 << ----Drink-IT Customization
                        // CustLedgEntry.SETRANGE("Customer Posting Group", Customer."Customer Posting Group Filter"); // BC Upgrade BHARDA11  ----Drink-IT Customization
                        //BC UPGRADE KUMARR78 >> Adding Filter
                        Customer.COPYFILTER("CM Incl. EG Limit Filter APS", "CM Incl. EG. Lim. Warn APS");
                        Customer.COPYFILTER("Customer Posting Group", "Customer Posting Group");
                        //BC UPGRADE KUMARR78 << Adding Filter

                        //>>DITW17.00.02 AT DIT-770 #163
                    end;
                }
                dataitem(OpenCustLedgEntry; "Cust. Ledger Entry")
                {
                    // DataItemLink = "Customer No." = FIELD("No."), "Customer Posting Group" = FIELD("Customer Posting Group Filter"); // BC Upgrade BHARDA11 ----Drink-IT Field("Customer Posting Group Filter")
                    // DataItemLink = "Customer No." = FIELD("No.");//, "Customer Posting Group" = FIELD("Customer Posting Group Filter"); //BC UPGRADE KUMARR78 --Blocking to Add Field
                    DataItemLink = "Customer No." = FIELD("No."), "Customer Posting Group" = FIELD("Customer Posting Group"); //BC UPGRADE KUMARR78 ++ Adding Customer Posting Group to Add Field
                    DataItemTableView = SORTING("Customer No.", Open, Positive, "Due Date", "Currency Code");

                    trigger OnAfterGetRecord();
                    begin
                        if AgingBy = AgingBy::"Posting Date" then begin
                            CALCFIELDS("Remaining Amt. (LCY)");
                            if "Remaining Amt. (LCY)" = 0 then
                                CurrReport.SKIP();
                        end;

                        InsertTemp(OpenCustLedgEntry);
                        CurrReport.SKIP();
                    end;

                    trigger OnPreDataItem();
                    begin
                        //IF AgingBy = AgingBy::"Posting Date" THEN BEGIN  //HEI.02
                        SETRANGE("Posting Date", 0D, EndingDate);
                        SETRANGE("Date Filter", 0D, EndingDate);
                        //END;  //HEI.02

                        // <<DITW15.00.00.37 DDR 01/06/2010
                        // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                        // Customer.COPYFILTER("DIT Sub-Contract Type Filter", "DIT Sub-Contract Type");
                        // Customer.COPYFILTER("Contract Group Filter", "Contract Group Code");
                        // // >>DITW15.00.00.37 DDR
                        // // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
                        // Customer.COPYFILTER("Service Contract No. Filter", "Service Contract No.");
                        // Customer.COPYFILTER("Item Charge Type Filter", "Item Charge Type");
                        // // >>DITW16.00.00.42 DDR DIT-715 #370
                        // //<<DITW17.00.02 AT 22/01/2014 DIT-770 #163
                        // Customer.COPYFILTER("Customer Posting Group Filter", "Customer Posting Group");
                        // BC Upgrade BHARDA11 << ----Drink-IT Customization
                        //BC UPGRADE KUMARR78 >> Adding Filter
                        Customer.COPYFILTER("CM Incl. EG Limit Filter APS", "CM Incl. EG. Lim. Warn APS");
                        Customer.COPYFILTER("Customer Posting Group", "Customer Posting Group");
                        //BC UPGRADE KUMARR78 << Adding Filter


                        //>>DITW17.00.02 AT DIT-770 #163
                    end;
                }
                dataitem(CurrencyLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                    PrintOnlyIfDetail = true;
                    dataitem(TempCustLedgEntryLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(Name1_Cust; Customer.Name)
                        {
                            IncludeCaption = true;
                        }
                        column(No_Cust; Customer."No.")
                        {
                            IncludeCaption = true;
                        }
                        column(SalesPerson; Customer."Salesperson Code")
                        {
                        }
                        column(Territory; Customer."Territory Code")
                        {
                        }
                        column(CLEEndDateRemAmtLCY; CustLedgEntryEndingDate."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(AgedCLE1RemAmtLCY; AgedCustLedgEntry[1]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(AgedCLE2RemAmtLCY; AgedCustLedgEntry[2]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(AgedCLE3RemAmtLCY; AgedCustLedgEntry[3]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(AgedCLE4RemAmtLCY; AgedCustLedgEntry[4]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(AgedCLE5RemAmtLCY; AgedCustLedgEntry[5]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(AgedCLE6RemAmtLCY; AgedCustLedgEntry[6]."Remaining Amt. (LCY)")
                        {
                        }
                        column(CLEEndDateAmtLCY; CustLedgEntryEndingDate."Amount (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(CLEEndDueDate; FORMAT(CustLedgEntryEndingDate."Due Date"))
                        {
                        }
                        column(CLEEndDateDocNo; CustLedgEntryEndingDate."Document No.")
                        {
                        }
                        column(CLEDocType; FORMAT(CustLedgEntryEndingDate."Document Type"))
                        {
                        }
                        column(CLEPostingDate; FORMAT(CustLedgEntryEndingDate."Posting Date"))
                        {
                        }
                        column(AgedCLE6TempRemAmt; AgedCustLedgEntry[6]."Remaining Amount")
                        {
                        }
                        column(AgedCLE5TempRemAmt; AgedCustLedgEntry[5]."Remaining Amount")
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AgedCLE4TempRemAmt; AgedCustLedgEntry[4]."Remaining Amount")
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AgedCLE3TempRemAmt; AgedCustLedgEntry[3]."Remaining Amount")
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AgedCLE2TempRemAmt; AgedCustLedgEntry[2]."Remaining Amount")
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AgedCLE1TempRemAmt; AgedCustLedgEntry[1]."Remaining Amount")
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(RemAmt_CLEEndDate; CustLedgEntryEndingDate."Remaining Amount")
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(CLEEndDate; CustLedgEntryEndingDate.Amount)
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Name_Cust; STRSUBSTNO(Text005, Customer.Name))
                        {
                        }
                        column(TotalCLE1AmtLCY; TotalCustLedgEntry[1]."Amount (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE1RemAmtLCY; TotalCustLedgEntry[1]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE2RemAmtLCY; TotalCustLedgEntry[2]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE3RemAmtLCY; TotalCustLedgEntry[3]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE4RemAmtLCY; TotalCustLedgEntry[4]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE5RemAmtLCY; TotalCustLedgEntry[5]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE6RemAmtLCY; TotalCustLedgEntry[6]."Remaining Amt. (LCY)")
                        {
                        }
                        column(CurrrencyCode; CurrencyCode)
                        {
                            AutoFormatExpression = CurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalCLE6RemAmt; TotalCustLedgEntry[6]."Remaining Amount")
                        {
                        }
                        column(TotalCLE5RemAmt; TotalCustLedgEntry[5]."Remaining Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE4RemAmt; TotalCustLedgEntry[4]."Remaining Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE3RemAmt; TotalCustLedgEntry[3]."Remaining Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE2RemAmt; TotalCustLedgEntry[2]."Remaining Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE1RemAmt; TotalCustLedgEntry[1]."Remaining Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCLE1Amt; TotalCustLedgEntry[1].Amount)
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalCheck; CustFilterCheck)
                        {
                        }
                        column(GrandTotalCLE1AmtLCY; GrandTotalCustLedgEntry[1]."Amount (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(GrandTotalCLE6PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[6]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                        {
                        }
                        column(GrandTotalCLE5PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                        {
                        }
                        column(GrandTotalCLE3PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                        {
                        }
                        column(GrandTotalCLE2PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                        {
                        }
                        column(GrandTotalCLE1PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                        {
                        }
                        column(GrandTotalCLE6RemAmtLCY; GrandTotalCustLedgEntry[6]."Remaining Amt. (LCY)")
                        {
                        }
                        column(GrandTotalCLE5RemAmtLCY; GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(GrandTotalCLE4RemAmtLCY; GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(GrandTotalCLE3RemAmtLCY; GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(GrandTotalCLE2RemAmtLCY; GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(GrandTotalCLE1RemAmtLCY; GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(PmtTerms; CustLedgEntryEndingDate."Payment Method Code")
                        {
                        }
                        column(PmtMethod; CustLedgEntryEndingDate."Payment Method Code")
                        {
                        }
                        // column(DriverCode; CustLedgEntryEndingDate."Driver Code") // BC Upgrade BHARDA11 ----Drink-IT Field(CustLedgEntryEndingDate."Driver Code")
                        column(DriverCode; '')
                        {
                        }

                        trigger OnAfterGetRecord();
                        var
                            PeriodIndex: Integer;
                        begin
                            if Number = 1 then begin
                                if not TempCustLedgEntry.FINDSET(false) then
                                    CurrReport.BREAK();
                            end else
                                if TempCustLedgEntry.NEXT() = 0 then
                                    CurrReport.BREAK();

                            CustLedgEntryEndingDate := TempCustLedgEntry;
                            DetailedCustomerLedgerEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgEntryEndingDate."Entry No.");
                            if DetailedCustomerLedgerEntry.FINDSET(false) then
                                repeat
                                    if (DetailedCustomerLedgerEntry."Entry Type" =
                                        DetailedCustomerLedgerEntry."Entry Type"::"Initial Entry") and
                                       (CustLedgEntryEndingDate."Posting Date" > EndingDate) and
                                       (AgingBy <> AgingBy::"Posting Date")
                                    then
#pragma warning disable AA0005
#pragma warning disable AA0013
begin
                                        if CustLedgEntryEndingDate."Document Date" <= EndingDate then
                                            DetailedCustomerLedgerEntry."Posting Date" :=
                                              CustLedgEntryEndingDate."Document Date"
                                        else
                                            if (CustLedgEntryEndingDate."Due Date" <= EndingDate) and
                                               (AgingBy = AgingBy::"Due Date")
                                            then
                                                DetailedCustomerLedgerEntry."Posting Date" :=
                                                  CustLedgEntryEndingDate."Due Date"
                                    end;
#pragma warning restore AA0013
#pragma warning restore AA0005

                                    if (DetailedCustomerLedgerEntry."Posting Date" <= EndingDate) or
                                       (TempCustLedgEntry.Open and
                                        (AgingBy = AgingBy::"Due Date") and
                                        (CustLedgEntryEndingDate."Due Date" > EndingDate) and
                                        (CustLedgEntryEndingDate."Posting Date" <= EndingDate)) then begin
                                        if DetailedCustomerLedgerEntry."Entry Type" in
                                           [DetailedCustomerLedgerEntry."Entry Type"::"Initial Entry",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Unrealized Loss",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Unrealized Gain",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Realized Loss",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Realized Gain",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount (VAT Excl.)",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount (VAT Adjustment)",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance (VAT Excl.)",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance (VAT Adjustment)",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Excl.)",
                                            DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Adjustment)"]//,
                                                                                                                                    // DetailedCustomerLedgerEntry."Entry Type"::"18"] // BC Upgrade BHARDA11 ----"Entry Type"::"18" Does not exist in BC
                                        then begin
                                            CustLedgEntryEndingDate.Amount := CustLedgEntryEndingDate.Amount + DetailedCustomerLedgerEntry.Amount;
                                            CustLedgEntryEndingDate."Amount (LCY)" :=
                                              CustLedgEntryEndingDate."Amount (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
                                        end;
                                        if DetailedCustomerLedgerEntry."Posting Date" <= EndingDate then begin
                                            CustLedgEntryEndingDate."Remaining Amount" :=
                                              CustLedgEntryEndingDate."Remaining Amount" + DetailedCustomerLedgerEntry.Amount;
                                            CustLedgEntryEndingDate."Remaining Amt. (LCY)" :=
                                              CustLedgEntryEndingDate."Remaining Amt. (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
                                        end;
                                    end;
                                until DetailedCustomerLedgerEntry.NEXT() = 0;

                            if CustLedgEntryEndingDate."Remaining Amount" = 0 then
                                CurrReport.SKIP();

                            case AgingBy of
                                AgingBy::"Due Date":
                                    PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Due Date");
                                AgingBy::"Posting Date":
                                    PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Posting Date");
                                AgingBy::"Document Date":
                                    begin
                                        if CustLedgEntryEndingDate."Document Date" > EndingDate then begin
                                            CustLedgEntryEndingDate."Remaining Amount" := 0;
                                            CustLedgEntryEndingDate."Remaining Amt. (LCY)" := 0;
                                            CustLedgEntryEndingDate."Document Date" := CustLedgEntryEndingDate."Posting Date";
                                        end;
                                        PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Document Date");
                                    end;
                            end;
                            CLEAR(AgedCustLedgEntry);
                            AgedCustLedgEntry[PeriodIndex]."Remaining Amount" := CustLedgEntryEndingDate."Remaining Amount";
                            AgedCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" := CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                            TotalCustLedgEntry[PeriodIndex]."Remaining Amount" += CustLedgEntryEndingDate."Remaining Amount";
                            TotalCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                            TotalCLEperSP[PeriodIndex]."Remaining Amount" += CustLedgEntryEndingDate."Remaining Amount";
                            TotalCLEperSP[PeriodIndex]."Remaining Amt. (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                            GrandTotalCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                            TotalCustLedgEntry[1].Amount += CustLedgEntryEndingDate."Remaining Amount";
                            TotalCustLedgEntry[1]."Amount (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                            TotalCLEperSP[1].Amount += CustLedgEntryEndingDate."Remaining Amount";
                            TotalCLEperSP[1]."Amount (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                            GrandTotalCustLedgEntry[1]."Amount (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";

                            if PrintToExcel and PrintDetails then
                                MakeExcelDataBody();
                        end;

                        trigger OnPostDataItem();
                        begin
                            if not PrintAmountInLCY then
                                UpdateCurrencyTotals();

                            if PrintToExcel and not PrintDetails then
                                MakeExcelDataPerCust();

                            if PrintToExcel and PrintDetails then
                                MakeExcelDataTotalsPerCust();
                        end;

                        trigger OnPreDataItem();
                        begin
                            if not PrintAmountInLCY then
                                TempCustLedgEntry.SETRANGE("Currency Code", TempCurrency.Code);

                            PageGroupNo := NextPageGroupNo;
                            if NewPagePercustomer and (NumberOfCurrencies > 0) then
                                NextPageGroupNo := PageGroupNo + 1;

                            if PrintToExcel and PrintDetails then
                                MakeExcelDataHeaderCust();
                        end;
                    }

                    trigger OnAfterGetRecord();
                    begin
                        CLEAR(TotalCustLedgEntry);

                        if Number = 1 then begin
                            if not TempCurrency.FINDSET(false) then
                                CurrReport.BREAK();
                        end else
                            if TempCurrency.NEXT() = 0 then
                                CurrReport.BREAK();

                        if TempCurrency.Code <> '' then
                            CurrencyCode := TempCurrency.Code
                        else
                            CurrencyCode := GLSetup."LCY Code";

                        NumberOfCurrencies := NumberOfCurrencies + 1;
                    end;

                    trigger OnPreDataItem();
                    begin
                        NumberOfCurrencies := 0;
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    if NewPagePercustomer then
                        PageGroupNo += 1;
                    TempCurrency.RESET();
                    TempCurrency.DELETEALL();
                    TempCustLedgEntry.RESET();
                    TempCustLedgEntry.DELETEALL();
                end;

                trigger OnPostDataItem();
                begin
                    if PrintToExcel then
                        MakeExcelDataTotalsPerSalesPers();
                end;

                trigger OnPreDataItem();
                begin
                    SETRANGE("Salesperson Code", SalesPersTmp.Code);
                end;
            }

            trigger OnAfterGetRecord();
            begin
                CLEAR(TotalCLEperSP);

                if Number = 1 then begin
                    if not SalesPersTmp.FINDSET(false) then
                        CurrReport.BREAK();
                end else
                    if SalesPersTmp.NEXT() = 0 then
                        CurrReport.BREAK();
            end;

            trigger OnPreDataItem();
            begin
                if SalesPers.FINDSET() then
                    repeat
                        SalesPersTmp := SalesPers;
                        SalesPersTmp.INSERT();
                    until SalesPers.NEXT() = 0;

                SalesPersTmp.INIT();
                SalesPersTmp.Code := '';
                SalesPersTmp.INSERT();

                SalesPersTmp.FINDSET();

                SETRANGE(Number, 1, SalesPersTmp.COUNT);
            end;
        }
        dataitem(CurrencyTotals; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
            column(CurrNo; Number = 1)
            {
            }
            column(TempCurrCode; TempCurrency2.Code)
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE6RemAmt; AgedCustLedgEntry[6]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE1RemAmt; AgedCustLedgEntry[1]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE2RemAmt; AgedCustLedgEntry[2]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE3RemAmt; AgedCustLedgEntry[3]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE4RemAmt; AgedCustLedgEntry[4]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE5RemAmt; AgedCustLedgEntry[5]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(CurrSpecificationCptn; CurrSpecificationCptnLbl)
            {
            }

            trigger OnAfterGetRecord();
            begin
                if Number = 1 then begin
                    if not TempCurrency2.FINDSET(false) then
                        CurrReport.BREAK();
                end else
                    if TempCurrency2.NEXT() = 0 then
                        CurrReport.BREAK();

                CLEAR(AgedCustLedgEntry);
                TempCurrencyAmount.SETRANGE("Currency Code", TempCurrency2.Code);
                if TempCurrencyAmount.FINDSET(false) then
                    repeat
                        if TempCurrencyAmount.Date <> 99991231D then
                            AgedCustLedgEntry[GetPeriodIndex(TempCurrencyAmount.Date)]."Remaining Amount" :=
                              TempCurrencyAmount.Amount
                        else
                            AgedCustLedgEntry[6]."Remaining Amount" := TempCurrencyAmount.Amount;
                    until TempCurrencyAmount.NEXT() = 0;

                if PrintToExcel and not PrintAmountInLCY then
                    MakeExcelDataCurrencyTotals(Number);
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
                    CaptionML = ENU = 'Options',
                                FRA = 'Options';
                    grid(Control1100066012)
                    {
                        GridLayout = Columns;
                        group(Control1100066014)
                        {
                            field(PrintToExcel; PrintToExcel)
                            {
                                ApplicationArea = All;
                                ToolTip = 'Export data to Excel.';
                                CaptionML = ENU = 'Print to Excel',
                                            FRA = 'Imprimer dans Excel';
                            }
                            field(AgedAsOf; EndingDate)
                            {
                                ApplicationArea = All;
                                ToolTip = 'Defines the cutoff date for aging calculations of outstanding balances.';
                                CaptionML = ENU = 'Aged As Of',
                                            FRA = '†gée en date du';
                            }
                            field(Agingby; AgingBy)
                            {
                                ApplicationArea = All;
                                ToolTip = 'Specifies how entries are grouped for aging, such as by document date or posting date.';
                                CaptionML = ENU = 'Aging by',
                                            FRA = 'Agée par';
                                OptionCaptionML = ENU = 'Due Date,Posting Date,Document Date',
                                                  FRA = 'Date d''échéance,Date comptabilisation,Date document';
                            }
                            field(PeriodLength; PeriodLength)
                            {
                                ApplicationArea = All;
                                ToolTip = 'Set the length of each reporting period.';
                                CaptionML = ENU = 'Period Length',
                                            FRA = 'Base période';
                            }
                            field(AmountsinLCY; PrintAmountInLCY)
                            {
                                ApplicationArea = All;
                                ToolTip = 'Specifies whether amounts are shown and calculated in local currency.';
                                CaptionML = ENU = 'Print Amounts in LCY',
                                            FRA = 'Imprimer montants DS';
                            }
                            field(PrintDetails; PrintDetails)
                            {
                                ApplicationArea = All;
                                ToolTip = 'Include detailed information in the printed report.';
                                CaptionML = ENU = 'Print Details',
                                            FRA = 'Imprimer détails';
                            }
                            field(HeadingType; HeadingType)
                            {
                                ApplicationArea = All;
                                CaptionML = ENU = 'Heading Type',
                                            FRA = 'Type titre';
                                ToolTip = 'Select the type of heading for the report layout.';
                                OptionCaptionML = ENU = 'Date Interval,Number of Days',
                                                  FRA = 'Intervalle de dates,Nombre de jours';
                            }
                            field(perCustomer; NewPagePercustomer)
                            {
                                ApplicationArea = All;
                                ToolTip = 'Specifies whether each customer’s information starts on a new page when printing the report.';
                                CaptionML = ENU = 'New Page per Customer',
                                            FRA = 'Nouvelle page par client';
                            }
                            field(DateFilter1a; DateFilter1a)
                            {
                                ApplicationArea = All;
                                ToolTip = 'Defines the period for which data is included based on the selected dates.';
                                Caption = 'Date Filter 1';
                            }
                            field(DateFilter2a; DateFilter2a)
                            {
                                ApplicationArea = All;
                                ToolTip = 'Defines the period for which data is included based on the selected dates.';
                                Caption = 'Date Filter 2';
                            }
                            field(DateFilter3a; DateFilter3a)
                            {
                                ApplicationArea = All;
                                ToolTip = 'Defines the period for which data is included based on the selected dates.';
                                Caption = 'Date Filter 3';
                            }
                            field(DateFilter4a; DateFilter4a)
                            {
                                ApplicationArea = All;
                                ToolTip = 'Defines the period for which data is included based on the selected dates.';
                                Caption = 'Date Filter 4';
                            }
                        }
                        group(Control1100066006)
                        {
                            field(Empty; Empty)
                            {
                                ApplicationArea = All;
                                Visible = false;
                                Caption = 'Empty';
                                ToolTip = 'Empty';
                            }
                            field(Control1100066016; Empty)
                            {
                                ApplicationArea = All;
                                Visible = false;
                                Caption = 'Empty';
                                ToolTip = 'Empty';
                            }
                            field(Control1100066017; Empty)
                            {
                                ApplicationArea = All;
                                Visible = false;
                                Caption = 'Empty';
                                ToolTip = 'Empty';
                            }
                            field(Control1100066018; Empty)
                            {
                                ApplicationArea = All;
                                Visible = false;
                                Caption = 'Empty';
                                ToolTip = 'Empty';
                            }
                            field(Control1100066019; Empty)
                            {
                                ApplicationArea = All;
                                Visible = false;
                                Caption = 'Empty';
                                ToolTip = 'Empty';
                            }
                            field(Control1100066020; Empty)
                            {
                                ApplicationArea = All;
                                Visible = false;
                                Caption = 'Empty';
                                ToolTip = 'Empty';
                            }
                            field(Control1100066021; Empty)
                            {
                                ApplicationArea = All;
                                Visible = false;
                                Caption = 'Empty';
                                ToolTip = 'Empty';
                            }
                            field(Control1100066022; Empty)
                            {
                                ApplicationArea = All;
                                Visible = false;
                                Caption = 'Empty';
                                ToolTip = 'Empty';
                            }
                            field(DateFilter1b; DateFilter1b)
                            {
                                ApplicationArea = All;
                                ShowCaption = false;
                            }
                            field(DateFilter2b; DateFilter2b)
                            {
                                ApplicationArea = All;
                                ShowCaption = false;
                            }
                            field(DateFilter3b; DateFilter3b)
                            {
                                ApplicationArea = All;
                                ShowCaption = false;
                            }
                            field(DateFilter4b; DateFilter4b)
                            {
                                ApplicationArea = All;
                                ShowCaption = false;
                            }
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            if EndingDate = 0D then
                EndingDate := WORKDATE();
            PrintToExcel := false;
        end;
    }

    labels
    {
        label(BalanceCaption; ENU = 'Balance',
                             FRA = 'Solde')
        label(TerritoryCpn; ENU = 'Territory Code',
                           FRA = 'Code secteur')
    }

    trigger OnPostReport();
    begin
        if PrintToExcel and PrintAmountInLCY then
            MakeExcelDataGrandTotals();

        if PrintToExcel then
            CreateExcelbook();
    end;

    trigger OnPreReport();
    begin
        CustFilter := Customer.GETFILTERS;

        if HeadingType = HeadingType::"Date Interval" then begin
            if ((DateFilter1a = 0D) or (DateFilter1b = 0D)
              or (DateFilter2a = 0D) or (DateFilter2b = 0D)
              or (DateFilter3a = 0D) or (DateFilter3b = 0D)
              or (DateFilter4a = 0D) or (DateFilter4b = 0D)) then
                ERROR(Text55000);

            if (CALCDATE('<1D>', DateFilter1b) <> DateFilter2a) then
                ERROR(Text55002);
            if CALCDATE('<1D>', DateFilter2b) <> DateFilter3a then
                ERROR(Text55002);
            if CALCDATE('<1D>', DateFilter3b) <> DateFilter4a then
                ERROR(Text55002);

            if DateFilter4b <> EndingDate then
                ERROR(Text55001);

            CalcDates1();
            CreateHeadings();
        end;

        GLSetup.GET();

        if HeadingType = HeadingType::"Number of Days" then begin
            CalcDates();
            CreateHeadings();
        end;

        if PrintToExcel then
            MakeExcelInfo();

        PageGroupNo := 1;
        NextPageGroupNo := 1;
        CustFilterCheck := (CustFilter <> 'No.');
    end;

    var
        SalesPersTmp: Record "Salesperson/Purchaser" temporary;
        SalesPers: Record "Salesperson/Purchaser";
        GLSetup: Record "General Ledger Setup";
        TempCustLedgEntry: Record "Cust. Ledger Entry" temporary;
        CustLedgEntryEndingDate: Record "Cust. Ledger Entry";
        TotalCustLedgEntry: array[6] of Record "Cust. Ledger Entry";
        TotalCLEperSP: array[6] of Record "Cust. Ledger Entry";
        GrandTotalCustLedgEntry: array[6] of Record "Cust. Ledger Entry";
        AgedCustLedgEntry: array[6] of Record "Cust. Ledger Entry";
        TempCurrency: Record Currency temporary;
        TempCurrency2: Record Currency temporary;
        TempCurrencyAmount: Record "Currency Amount" temporary;
        ExcelBuf: Record "Excel Buffer" temporary;
        DetailedCustomerLedgerEntry: Record "Detailed Cust. Ledg. Entry";
        CustFilter: Text;
        PrintAmountInLCY: Boolean;
        EndingDate: Date;
        AgingBy: Option "Due Date","Posting Date","Document Date";
        PeriodLength: DateFormula;
        PrintDetails: Boolean;
        HeadingType: Option "Date Interval","Number of Days";
        NewPagePercustomer: Boolean;
        PeriodStartDate: array[6] of Date;
        PeriodEndDate: array[6] of Date;
        HeaderText: array[6] of Text[30];
        Text000: TextConst ENU = 'Not Due', FRA = 'Non échu';
        Text001: TextConst ENU = 'Before', FRA = 'Avant';
        CurrencyCode: Code[10];
        Text002: TextConst ENU = 'days', FRA = 'jours';
        Text003: TextConst ENU = 'More than', FRA = 'Plus de';
        Text004: TextConst ENU = 'Aged by %1', FRA = 'Agée par %1';
        Text005: TextConst ENU = 'Total for %1', FRA = 'Total de %1';
        Text006: TextConst ENU = 'Aged as of %1', FRA = 'Agée en date du %1';
        Text007: TextConst ENU = 'Aged by %1', FRA = 'Agée par %1';
        Text008: TextConst ENU = 'All Amounts in LCY', FRA = 'Tous les montants DS';
        NumberOfCurrencies: Integer;
        Text009: TextConst ENU = 'Due Date,Posting Date,Document Date', FRA = 'Date d''échéance,Date comptabilisation,Date document';
        Text010: TextConst ENU = 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.', FRA = 'La formule date %1 ne peut pas être utilisée. Veuillez la redéfinir en utilisant, par exemple, 1M+CM au lieu de CM+1M.';
        PageGroupNo: Integer;
        NextPageGroupNo: Integer;
        PrintToExcel: Boolean;
        Text011: TextConst ENU = 'Data', FRA = 'Données';
        Text012: TextConst ENU = 'Aged Accounts Receivable', FRA = 'Comptabilité client âgée';
        Text013: TextConst ENU = 'Company Name', FRA = 'Nom de la société';
        Text014: TextConst ENU = 'Report No.', FRA = 'N° état';
        Text015: TextConst ENU = 'Report Name', FRA = 'Nom état';
        Text016: TextConst ENU = 'User ID', FRA = 'Code utilisateur';
        Text017: TextConst ENU = 'Date', FRA = 'Date';
        Text018: TextConst ENU = 'Customer Filters', FRA = 'Filtres client';
        Text019: TextConst ENU = 'Cust. Ledger Entry Filters', FRA = 'Filtres écriture comptable client';
        CustFilterCheck: Boolean;
        Text032: TextConst Comment = 'Negating the period length: %1 is the period length', ENU = '-%1', FRA = '-%1';
        Text55000: TextConst ENU = 'All Datefilters should be filled', FRA = 'All Datefilters should be filled';
        Text55001: TextConst ENU = 'Last Datefilter and END Date should be same', FRA = 'Last Datefilter and END Date should be same';
        Text55002: Label 'All Datefilters should be continuous';
        AgedAccReceivableCptnLbl: TextConst ENU = 'Aged Accounts Receivable', FRA = 'Comptabilité client âgée';
        CurrReportPageNoCptnLbl: TextConst ENU = 'Page', FRA = 'Page';
        AllAmtinLCYCptnLbl: TextConst ENU = 'All Amounts in LCY', FRA = 'Tous les montants DS';
        AgedOverdueAmtCptnLbl: TextConst ENU = 'Aged Overdue Amounts', FRA = 'Montants échus âgés';
        CLEEndDateAmtLCYCptnLbl: TextConst ENU = 'Original Amount ', FRA = 'Montant initial ';
        CLEEndDateDueDateCptnLbl: TextConst ENU = 'Due Date', FRA = 'Date d''échéance';
        CLEEndDateDocNoCptnLbl: TextConst ENU = 'Document No.', FRA = 'N° document';
        CLEEndDatePstngDateCptnLbl: TextConst ENU = 'Posting Date', FRA = 'Date comptabilisation';
        CLEEndDateDocTypeCptnLbl: TextConst ENU = 'Document Type', FRA = 'Type document';
        OriginalAmtCptnLbl: TextConst ENU = 'Currency Code', FRA = 'Code devise';
        TotalLCYCptnLbl: TextConst ENU = 'Total (LCY)', FRA = 'Total DS';
        CurrSpecificationCptnLbl: TextConst ENU = 'Currency Specification', FRA = 'Détail devise';
        SalesPersonLbl: TextConst ENU = 'Salesperson Code', FRA = 'Code vendeur';
        PmtTermsLbl: TextConst ENU = 'Pmt. Terms', FRA = 'Pmt. Type';
        PmtMethodLbl: TextConst ENU = 'Pmt. Method', FRA = 'Pmt. Method';
        DriverCodeLbl: TextConst ENU = 'Driver Code', FRA = 'Code chauffeur';
#pragma warning disable AA0204
        DateFilter1a: Date;
#pragma warning restore AA0204
#pragma warning disable AA0204
        DateFilter2a: Date;
#pragma warning restore AA0204
#pragma warning disable AA0204
        DateFilter3a: Date;
#pragma warning restore AA0204
#pragma warning disable AA0204
        DateFilter4a: Date;
#pragma warning restore AA0204
#pragma warning disable AA0204
        DateFilter1b: Date;
#pragma warning restore AA0204
#pragma warning disable AA0204
        DateFilter2b: Date;
#pragma warning restore AA0204
#pragma warning disable AA0204
        DateFilter3b: Date;
#pragma warning restore AA0204
#pragma warning disable AA0204
        DateFilter4b: Date;
#pragma warning restore AA0204
#pragma warning disable AA0204
        Empty: Text[1];
#pragma warning restore AA0204
        TerritoryLbl: TextConst ENU = 'Territory Code', FRA = 'Sous Type de Client';

    local procedure CalcDates();
    var
        PeriodLength2: DateFormula;
        i: Integer;

    begin
        EVALUATE(PeriodLength2, STRSUBSTNO(Text032, PeriodLength));
        if AgingBy = AgingBy::"Due Date" then begin
            PeriodEndDate[1] := 99991231D;
            PeriodStartDate[1] := EndingDate + 1;
        end else begin
            PeriodEndDate[1] := EndingDate;
            PeriodStartDate[1] := CALCDATE(PeriodLength2, EndingDate + 1);
        end;
        for i := 2 to ARRAYLEN(PeriodEndDate) do begin
            PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
            PeriodStartDate[i] := CALCDATE(PeriodLength2, PeriodEndDate[i] + 1);
        end;
        PeriodStartDate[i] := 0D;

        for i := 1 to ARRAYLEN(PeriodEndDate) do
            if PeriodEndDate[i] < PeriodStartDate[i] then
                ERROR(Text010, PeriodLength);
    end;

    local procedure CreateHeadings();
    var
        i: Integer;
    begin
        if AgingBy = AgingBy::"Due Date" then begin
            HeaderText[1] := Text000;
            i := 2;
        end else
            i := 1;
        while i < ARRAYLEN(PeriodEndDate) do begin
            if HeadingType = HeadingType::"Date Interval" then
                HeaderText[i] := STRSUBSTNO('%1\..%2', PeriodStartDate[i], PeriodEndDate[i])
            else
                HeaderText[i] :=
                  STRSUBSTNO('%1 - %2 %3', EndingDate - PeriodEndDate[i] + 1, EndingDate - PeriodStartDate[i] + 1, Text002);
            i := i + 1;
        end;
        if HeadingType = HeadingType::"Date Interval" then
            HeaderText[i] := STRSUBSTNO('%1 %2', Text001, PeriodStartDate[i - 1])
        else
            HeaderText[i] := STRSUBSTNO('%1 \%2 %3', Text003, EndingDate - PeriodStartDate[i - 1] + 1, Text002);
    end;

    local procedure InsertTemp(var CustLedgEntry: Record "Cust. Ledger Entry");
    var
        Currency: Record Currency;
    begin
        if TempCustLedgEntry.GET(CustLedgEntry."Entry No.") then
            exit;
        TempCustLedgEntry := CustLedgEntry;
        TempCustLedgEntry.INSERT();
        if PrintAmountInLCY then begin
            CLEAR(TempCurrency);
            TempCurrency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
            if TempCurrency.INSERT() then;
            exit;
        end;
        if TempCurrency.GET(TempCustLedgEntry."Currency Code") then
            exit;
        if TempCustLedgEntry."Currency Code" <> '' then
            Currency.GET(TempCustLedgEntry."Currency Code")
        else begin
            CLEAR(Currency);
            Currency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
        end;
        TempCurrency := Currency;
        TempCurrency.INSERT();
    end;

    local procedure GetPeriodIndex(Date: Date): Integer;
    var
        i: Integer;
    begin
        for i := 1 to ARRAYLEN(PeriodEndDate) do
            if Date in [PeriodStartDate[i] .. PeriodEndDate[i]] then
                exit(i);
    end;

    local procedure Pct(a: Decimal; b: Decimal): Text[30];
    begin
        if b <> 0 then
            exit(FORMAT(ROUND(100 * a / b, 0.1), 0, '<Sign><Integer><Decimals,2>') + '%');
    end;

    local procedure UpdateCurrencyTotals();
    var
        i: Integer;
    begin
        TempCurrency2.Code := CurrencyCode;
        if TempCurrency2.INSERT() then;
        for i := 1 to ARRAYLEN(TotalCustLedgEntry) do begin
            TempCurrencyAmount."Currency Code" := CurrencyCode;
            TempCurrencyAmount.Date := PeriodStartDate[i];
            if TempCurrencyAmount.FIND() then begin
                TempCurrencyAmount.Amount := TempCurrencyAmount.Amount + TotalCustLedgEntry[i]."Remaining Amount";
                TempCurrencyAmount.MODIFY();
            end else begin
                TempCurrencyAmount."Currency Code" := CurrencyCode;
                TempCurrencyAmount.Date := PeriodStartDate[i];
                TempCurrencyAmount.Amount := TotalCustLedgEntry[i]."Remaining Amount";
                TempCurrencyAmount.INSERT();
            end;
        end;
        TempCurrencyAmount."Currency Code" := CurrencyCode;
        TempCurrencyAmount.Date := 99991231D;
        if TempCurrencyAmount.FIND() then begin
            TempCurrencyAmount.Amount := TempCurrencyAmount.Amount + TotalCustLedgEntry[1].Amount;
            TempCurrencyAmount.MODIFY();
        end else begin
            TempCurrencyAmount."Currency Code" := CurrencyCode;
            TempCurrencyAmount.Date := 99991231D;
            TempCurrencyAmount.Amount := TotalCustLedgEntry[1].Amount;
            TempCurrencyAmount.INSERT();
        end;
    end;

    procedure MakeExcelInfo();
    begin
        //ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddColumn(FORMAT(Text013), false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(COMPANYNAME, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(FORMAT(Text015), false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(Text012), false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(FORMAT(Text014), false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(REPORT::"Aged Accounts Receivable", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(FORMAT(Text016), false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(USERID, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(FORMAT(Text017), false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TODAY, false, '', false, false, false, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(FORMAT(Text018), false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.GETFILTERS, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(FORMAT(Text019), false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Cust. Ledger Entry".GETFILTERS, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        if PrintAmountInLCY then begin
            ExcelBuf.NewRow();
            ExcelBuf.AddColumn(FORMAT(Text008), false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(PrintAmountInLCY, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        end;
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(FORMAT(COPYSTR(Text004, 1, 7)), false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(SELECTSTR(AgingBy + 1, Text009)), false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        MakeExcelDataHeader();
    end;

    local procedure MakeExcelDataHeader();
    begin
        ExcelBuf.NewRow();

        if PrintDetails then begin
            ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        end;
        if not PrintAmountInLCY then
            ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Aged Overdue Amounts', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow();
        if PrintDetails then begin
            ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        end;
        if not PrintAmountInLCY then
            ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('..................', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('..................', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('..................', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('..................', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('..................', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow();
        if PrintDetails then begin
            ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Posting Date"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Document Type"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Document No."), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Due Date"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Salesperson Code"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Payment Method Code"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Payment Method Code"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            // ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Driver Code"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text); // BC Upgrade BHARDA11 ::Blocked for Drink-IT Field(TempCustLedgEntry."Driver Code")
            ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);// BC Upgrade BHARDA11 ::Added

            if not PrintAmountInLCY then begin
                ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Currency Code"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Original Amount"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Remaining Amount"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            end else begin
                ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Original Amt. (LCY)"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Remaining Amt. (LCY)"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            end;
        end else begin
            ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            if not PrintAmountInLCY then begin
                ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Currency Code"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Remaining Amount"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            end else
                ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Remaining Amt. (LCY)"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        end;

        ExcelBuf.AddColumn(HeaderText[1], false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(HeaderText[2], false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(HeaderText[3], false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(HeaderText[4], false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(HeaderText[5], false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(HeaderText[6], false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
    end;

    procedure MakeExcelDataHeaderCust();
    begin
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(Customer."No.", false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.Name, false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
    end;

    procedure MakeExcelDataPerCust();
    begin
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(Customer."No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.Name, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

        if PrintAmountInLCY then begin
            ExcelBuf.AddColumn(TotalCustLedgEntry[1]."Amount (LCY)", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(TotalCustLedgEntry[1]."Remaining Amt. (LCY)", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(TotalCustLedgEntry[2]."Remaining Amt. (LCY)", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(TotalCustLedgEntry[3]."Remaining Amt. (LCY)", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(TotalCustLedgEntry[4]."Remaining Amt. (LCY)", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(TotalCustLedgEntry[5]."Remaining Amt. (LCY)", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(TotalCustLedgEntry[6]."Remaining Amt. (LCY)", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        end else begin
            ExcelBuf.AddColumn(CurrencyCode, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TotalCustLedgEntry[1].Amount, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(TotalCustLedgEntry[1]."Remaining Amount", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(TotalCustLedgEntry[2]."Remaining Amount", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(TotalCustLedgEntry[3]."Remaining Amount", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(TotalCustLedgEntry[4]."Remaining Amount", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(TotalCustLedgEntry[5]."Remaining Amount", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(TotalCustLedgEntry[6]."Remaining Amount", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        end;
    end;

    procedure MakeExcelDataBody();
    begin
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(TempCustLedgEntry."Posting Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn(FORMAT(TempCustLedgEntry."Document Type"), false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TempCustLedgEntry."Document No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TempCustLedgEntry."Due Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn(Customer."Salesperson Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TempCustLedgEntry."Payment Method Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TempCustLedgEntry."Payment Method Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        // ExcelBuf.AddColumn(TempCustLedgEntry."Driver Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); // BC Upgrade BHARDA11 ::Blocked for Drink-IT Field(TempCustLedgEntry."Driver Code")
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);// BC Upgrade BHARDA11 ::Added

        if PrintAmountInLCY then begin
            ExcelBuf.AddColumn(CustLedgEntryEndingDate."Amount (LCY)", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(CustLedgEntryEndingDate."Remaining Amt. (LCY)", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(AgedCustLedgEntry[1]."Remaining Amt. (LCY)", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(AgedCustLedgEntry[2]."Remaining Amt. (LCY)", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(AgedCustLedgEntry[3]."Remaining Amt. (LCY)", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(AgedCustLedgEntry[4]."Remaining Amt. (LCY)", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(AgedCustLedgEntry[5]."Remaining Amt. (LCY)", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(AgedCustLedgEntry[6]."Remaining Amt. (LCY)", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        end else begin
            ExcelBuf.AddColumn(CurrencyCode, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(CustLedgEntryEndingDate.Amount, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(CustLedgEntryEndingDate."Remaining Amount", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(AgedCustLedgEntry[1]."Remaining Amount", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(AgedCustLedgEntry[2]."Remaining Amount", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(AgedCustLedgEntry[3]."Remaining Amount", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(AgedCustLedgEntry[4]."Remaining Amount", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(AgedCustLedgEntry[5]."Remaining Amount", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(AgedCustLedgEntry[6]."Remaining Amount", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        end;
    end;

    procedure MakeExcelDataTotalsPerCust();
    begin
        if TotalCustLedgEntry[1]."Amount (LCY)" <> 0 then begin
            ExcelBuf.NewRow();
            ExcelBuf.AddColumn('TOTAL FOR ' + Customer.Name, false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
            if PrintAmountInLCY then begin
                ExcelBuf.AddColumn(TotalCustLedgEntry[1]."Amount (LCY)", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCustLedgEntry[1]."Remaining Amt. (LCY)", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCustLedgEntry[2]."Remaining Amt. (LCY)", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCustLedgEntry[3]."Remaining Amt. (LCY)", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCustLedgEntry[4]."Remaining Amt. (LCY)", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCustLedgEntry[5]."Remaining Amt. (LCY)", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCustLedgEntry[6]."Remaining Amt. (LCY)", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);

            end else begin
                ExcelBuf.AddColumn(CurrencyCode, false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(TotalCustLedgEntry[1].Amount, false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCustLedgEntry[1]."Remaining Amount", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCustLedgEntry[2]."Remaining Amount", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCustLedgEntry[3]."Remaining Amount", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCustLedgEntry[4]."Remaining Amount", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCustLedgEntry[5]."Remaining Amount", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCustLedgEntry[6]."Remaining Amount", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
            end;
        end;
    end;

    procedure MakeExcelDataTotalsPerSalesPers();
    begin
        if TotalCLEperSP[1]."Amount (LCY)" <> 0 then begin
            ExcelBuf.NewRow();
            ExcelBuf.AddColumn('Salesperson ' + SalesPersTmp.Code, false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
            if PrintDetails then begin
                ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
            end;
            if PrintAmountInLCY then begin
                ExcelBuf.AddColumn(TotalCLEperSP[1]."Amount (LCY)", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCLEperSP[1]."Remaining Amt. (LCY)", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCLEperSP[2]."Remaining Amt. (LCY)", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCLEperSP[3]."Remaining Amt. (LCY)", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCLEperSP[4]."Remaining Amt. (LCY)", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCLEperSP[5]."Remaining Amt. (LCY)", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCLEperSP[6]."Remaining Amt. (LCY)", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);

            end else begin
                ExcelBuf.AddColumn(CurrencyCode, false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(TotalCLEperSP[1].Amount, false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCLEperSP[1]."Remaining Amount", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCLEperSP[2]."Remaining Amount", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCLEperSP[3]."Remaining Amount", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCLEperSP[4]."Remaining Amount", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCLEperSP[5]."Remaining Amount", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(TotalCLEperSP[6]."Remaining Amount", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
            end;
        end;
    end;

    procedure MakeExcelDataGrandTotals();
    begin
        if GrandTotalCustLedgEntry[1]."Amount (LCY)" <> 0 then begin
            ExcelBuf.NewRow();
            if PrintDetails then begin
                ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
            end;
            if not PrintAmountInLCY then
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('GRAND TOTAL LCY', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(GrandTotalCustLedgEntry[1]."Amount (LCY)", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(GrandTotalCustLedgEntry[6]."Remaining Amt. (LCY)", false, '', true, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);

            ExcelBuf.NewRow();
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
            if PrintDetails then begin
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
            end;

            if not PrintAmountInLCY then
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(Pct(GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"),
                               false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(Pct(GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"),
                               false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(Pct(GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"),
                               false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(Pct(GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"),
                               false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(Pct(GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"),
                               false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(Pct(GrandTotalCustLedgEntry[6]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"),
                               false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        end;
    end;

    procedure MakeExcelDataCurrencyTotals(RecordNumber: Integer);
    begin
        if RecordNumber = 1 then
            ExcelBuf.NewRow();
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('Currency Specification', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        if PrintDetails then begin
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        end;
        ExcelBuf.AddColumn(TempCurrency2.Code, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        if PrintDetails then
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(AgedCustLedgEntry[6]."Remaining Amount", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AgedCustLedgEntry[1]."Remaining Amount", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AgedCustLedgEntry[2]."Remaining Amount", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AgedCustLedgEntry[3]."Remaining Amount", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AgedCustLedgEntry[4]."Remaining Amount", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AgedCustLedgEntry[5]."Remaining Amount", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AgedCustLedgEntry[6]."Remaining Amount", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
    end;

    procedure CreateExcelbook();
    begin
        // BC Upgrade BHARDA11 >> ---Re-Structure this code 
        // ExcelBuf.CreateBookAndOpenExcel(Text011, Text012, '', COMPANYNAME, USERID);
        // ERROR('');
        ExcelBuf.CreateNewBook('Aged Accounts Receivable');
        ExcelBuf.WriteSheet('Data', CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename('AgedAccountsReceivable');
        ExcelBuf.OpenExcel();
        // BC Upgrade BHARDA11 << ---Re-Structure this code 
    end;

    procedure InitializeRequest(NewEndingDate: Date; NewAgingBy: Option; NewPeriodLength: DateFormula; NewPrintAmountInLCY: Boolean; NewPrintDetails: Boolean; NewHeadingType: Option; NewPagePercust: Boolean; NewPrintToExcel: Boolean);
    begin
        EndingDate := NewEndingDate;
        AgingBy := NewAgingBy;
        PeriodLength := NewPeriodLength;
        PrintAmountInLCY := NewPrintAmountInLCY;
        PrintDetails := NewPrintDetails;
        HeadingType := NewHeadingType;
        NewPagePercustomer := NewPagePercust;
        PrintToExcel := NewPrintToExcel;
    end;

    local procedure CalcDates1();
    var
        i: Integer;
        PeriodLength2: DateFormula;
    begin
        if AgingBy <> AgingBy::"Due Date" then
            EVALUATE(PeriodLength2, '-' + FORMAT(PeriodLength));

        if AgingBy = AgingBy::"Due Date" then begin
            PeriodStartDate[1] := DateFilter4b + 1;
            PeriodEndDate[1] := 99991231D;
        end else begin
            PeriodStartDate[1] := EndingDate;
            PeriodEndDate[1] := CALCDATE(PeriodLength2, EndingDate + 1);
        end;

        PeriodStartDate[2] := DateFilter4a;
        PeriodEndDate[2] := DateFilter4b;
        PeriodStartDate[3] := DateFilter3a;
        PeriodEndDate[3] := DateFilter3b;
        PeriodStartDate[4] := DateFilter2a;
        PeriodEndDate[4] := DateFilter2b;
        PeriodStartDate[5] := DateFilter1a;
        PeriodEndDate[5] := DateFilter1b;
        PeriodStartDate[6] := 0D;
        PeriodEndDate[6] := PeriodStartDate[5] - 1;
    end;
}

