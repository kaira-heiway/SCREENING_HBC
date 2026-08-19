report 53093 "Suggest Customer Payments NFR"
{
    // version DITW110.00.11,HEI.02

    // DITW110.00.11 MSF 25/08/2017 NRQ#17902 Route settlement - Order Payments, Suggest customer and vendor payments
    //                                        NEW Report Copy From Report 393
    // DITW110.00.11 AKH 29/08/2017 NRQ#17902 Bugfix when running the batch with filters on Customer Ledger entries
    //                                        Adjusted call to entry editing codeunit
    // DITW110.00.11 AKH 30/08/2017 NRQ#17902 Adjusted code (report had no output)
    // DITW110.00.11 MSF 15/11/2017 NRQ#45760 Added Field Financial Contrac No.
    // HEI.01 Defect #1066 IBM NASTAA02 23.11.2017 # bank sensitive details change
    //   # Filter added on Customer Dataitem by "Sensitive Block" Field
    // HEI.02 Defect #1603 IBM POSTOI01 08.03.2018
    //   # suggested payments for credit memos should have Document Type = Refund (instead of Payments)
    //   # Item Charge Type has to be filled in the journals lines

    //BC UPGRADE KUMARR78 >>
    //FDD No.-->   FDD-MTC-009
    //GAP Np. -->  IBM GAP MTC 49
    //Migration Object from NAV to BC
    //Old NAV Id- 2014065
    // Making Changes with Comments Based on Requirnment
    //Adding RequesField, Blocking DIT Fields and Blocking Report from DTW "Import Firm. Prod. Orders".
    //PID363-PID364(OTC152-OTC153)Suggest Customer Payments
    //BC UPGRADE KUMARR78 <<

    ApplicationArea = All;
    CaptionML = ENU = 'Suggest Customer Payments',
                FRA = 'Suggérer route de déclaration';
    ProcessingOnly = true;

    dataset
    {
        dataitem(CustLedgerEntryFilter; "Cust. Ledger Entry")
        {
            DataItemTableView = sorting("Entry No.");
            // RequestFilterFields = "Payment Method Code", "Route Planning No.", "Driver Code", "Document Subtype Code", "Item Charge Type", "DIT Sub-Contract Type", "Customer Posting Group";//BC UPGRADE KUMARR78 Blocking DIT Fields
            RequestFilterFields = "Payment Method Code", "Customer Posting Group", "Document Subtype Code FND";//BC UPGRADE KUMARR78 Adding ++

            trigger OnPreDataItem();
            begin
                CurrReport.Break();
            end;
        }
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.") where(Blocked = filter(= " "), "Sensitive Payment Block FND" = filter(false));
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord();
            begin
                Clear(CustomerBalance);
                CalcFields("Balance (LCY)");
                CustomerBalance := "Balance (LCY)";

                if StopPayments then
                    CurrReport.Break();
                Window.Update(1, "No.");
                if CustomerBalance > 0 then begin
                    GetCustLedgEntries(true, false);
                    GetCustLedgEntries(false, false);
                    CheckAmounts(false);
                    //ClearNegative;
                end;
            end;

            trigger OnPostDataItem();
            begin
                if UsePriority and not StopPayments then begin
                    Reset();
                    CopyFilters(Cust2);
                    SetCurrentKey(Priority);
                    SetRange(Priority, 0);
                    if Find('-') then
                        repeat
                            Clear(CustomerBalance);
                            CalcFields("Balance (LCY)");
                            CustomerBalance := "Balance (LCY)";
                            if CustomerBalance > 0 then begin
                                Window.Update(1, "No.");
                                GetCustLedgEntries(true, false);
                                GetCustLedgEntries(false, false);
                                CheckAmounts(false);
                                //ClearNegative;
                            end;
                        until (Next() = 0) or StopPayments;
                end;

                if UsePaymentDisc and not StopPayments then begin
                    Reset();
                    CopyFilters(Cust2);
                    Window2.Open(Text007);
                    if Find('-') then
                        repeat
                            Clear(CustomerBalance);
                            CalcFields("Balance (LCY)");
                            CustomerBalance := "Balance (LCY)";
                            Window2.Update(1, "No.");
                            PayableCustLedgEntry.SetRange("Customer No.", "No.");
                            if CustomerBalance > 0 then begin
                                GetCustLedgEntries(true, true);
                                GetCustLedgEntries(false, true);
                                CheckAmounts(true);
                                ///ClearNegative;
                            end;
                        until (Next() = 0) or StopPayments;
                    Window2.Close();
                end else
                    if Find('-') then
                        repeat
                        //ClearNegative;
                        until Next() = 0;

                DimSetEntry.LockTable();
                GenJnlLine.LockTable();
                GenJnlTemplate.Get(GenJnlLine."Journal Template Name");
                GenJnlBatch.Get(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
                GenJnlLine.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                GenJnlLine.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
                if GenJnlLine.FindLast() then begin
                    LastLineNo := GenJnlLine."Line No.";
                    GenJnlLine.Init();
                end;

                Window2.Open(Text008);

                PayableCustLedgEntry.Reset();
                PayableCustLedgEntry.SetRange(Priority, 1, 2147483647);
                MakeGenJnlLines();
                PayableCustLedgEntry.Reset();
                PayableCustLedgEntry.SetRange(Priority, 0);
                MakeGenJnlLines();
                PayableCustLedgEntry.Reset();
                PayableCustLedgEntry.DeleteAll();

                Window2.Close();
                Window.Close();
                ShowMessage(MessageText);
            end;

            trigger OnPreDataItem();
            begin
                if LastDueDateToPayReq = 0D then
                    Error(Text000);
                if (PostingDate = 0D) and (not UseDueDateAsPostingDate) then
                    Error(Text001);

                BankPmtType := GenJnlLine2."Bank Payment Type".AsInteger();
                BalAccType := GenJnlLine2."Bal. Account Type".AsInteger();
                BalAccNo := GenJnlLine2."Bal. Account No.";
                GenJnlLineInserted := false;
                SeveralCurrencies := false;
                MessageText := '';

                if ((BankPmtType = BankPmtType::" ") or
                    SummarizePerCust) and
                   (NextDocNo = '')
                then
                    Error(Text002);

                if ((BankPmtType = BankPmtType::"Manual Check") and
                    not SummarizePerCust and
                    not DocNoPerLine)
                then
                    Error(Text017, GenJnlLine2.FieldCaption("Bank Payment Type"), SelectStr(BankPmtType + 1, Text023));

                if UsePaymentDisc and (LastDueDateToPayReq < WorkDate()) then
                    if not Confirm(Text003, false, WorkDate()) then
                        Error(Text005);

                Cust2.CopyFilters(Customer);

                OriginalAmtAvailable := AmountAvailable;
                if UsePriority then begin
                    SetCurrentKey(Priority);
                    SetRange(Priority, 1, 2147483647);
                    UsePriority := true;
                end;
                Window.Open(Text006);

                SelectedDim.SetRange("User ID", UserId);
                SelectedDim.SetRange("Object Type", 3);
                // SelectedDim.SETRANGE("Object ID", Report::"Import Firm. Prod. Orders");//BC UPGRADE KUMARR78 -- TEMP
                SummarizePerDim := SelectedDim.Find('-') and SummarizePerCust;

                NextEntryNo := 1;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    CaptionML = ENU = 'Options',
                                FRA = 'Options';
                    group("Find Payments")
                    {
                        CaptionML = ENU = 'Find Payments',
                                    FRA = 'Montant disponible DS';
                        field(LastPaymentDate; LastDueDateToPayReq)
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Last Payment Date',
                                        FRA = 'Dernière date échéance';
                            ToolTip = 'Specifies the latest payment date that can appear on the Customer ledger entries to be included in the batch job. Only entries that have a due date or a payment discount date before or on this date will be included. If the payment date is earlier than the system date, a warning will be displayed.';
                        }
                        field(FindPaymentDiscounts; UsePaymentDisc)
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Find Payment Discounts',
                                        FRA = 'Rechercher les escomptes';
                            Importance = Additional;
                            MultiLine = true;
                            ToolTip = 'Specifies if you want the batch job to include Customer ledger entries for which you can receive a payment discount.';

                            trigger OnValidate();
                            begin
                                if UsePaymentDisc and UseDueDateAsPostingDate then
                                    Error(PmtDiscUnavailableErr);
                            end;
                        }
                        field(UseCustomerPriority; UsePriority)
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Use Customer Priority',
                                        FRA = 'Utliser priorité client';
                            Importance = Additional;
                            ToolTip = 'Specifies if the Priority field on the Customer cards will determine in which order Customer entries are suggested for payment by the batch job. The batch job always prioritizes Customers for payment suggestions if you specify an available amount in the Available Amount (LCY) field.';

                            trigger OnValidate();
                            begin
                                if not UsePriority and (AmountAvailable <> 0) then
                                    Error(Text011);
                            end;
                        }
                        field("Available Amount (LCY)"; AmountAvailable)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Available Amount (LCY)';
                            Importance = Additional;
                            ToolTip = 'Specifies a maximum amount (in LCY) that is available for payments. The batch job will then create a payment suggestion on the basis of this amount and the Use Customer Priority check box. It will only include Customer entries that can be paid fully.';

                            trigger OnValidate();
                            begin
                                if AmountAvailable <> 0 then
                                    UsePriority := true;
                            end;
                        }
                        field(SkipExportedPayments; SkipExportedPayments)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Skip Exported Payments';
                            Importance = Additional;
                            ToolTip = 'Specifies if you do not want the batch job to insert payment journal lines for documents for which payments have already been exported to a bank file.';
                        }
                    }
                    group("Summarize Results")
                    {
                        Caption = 'Summarize Results';
                        field(SummarizePerCust; SummarizePerCust)
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Summarize per Customer',
                                        FRA = 'Résumé par client';
                            ToolTip = 'Specifies if you want the batch job to make one line per Csutomer for each currency in which the Customer has ledger entries. If, for example, a Customer uses two currencies, the batch job will create two lines in the payment journal for this Customer. The batch job then uses the Applies-to ID field when the journal lines are posted to apply the lines to Customer ledger entries. If you do not select this check box, then the batch job will make one line per invoice.';

                            trigger OnValidate();
                            begin
                                if SummarizePerCust and UseDueDateAsPostingDate then
                                    Error(PmtDiscUnavailableErr);
                            end;
                        }
                        field(SummarizePerDimText; SummarizePerDimText)
                        {
                            ApplicationArea = Suite;
                            CaptionML = ENU = 'By Dimension',
                                        FRA = 'Par axe';
                            Editable = false;
                            Enabled = SummarizePerDimTextEnable;
                            Importance = Additional;
                            ToolTip = 'Specifies the dimensions that you want the batch job to consider.';

                            trigger OnAssistEdit();
                            var
                                DimSelectionBuf: Record "Dimension Selection Buffer";
                            begin
                                // DimSelectionBuf.SetDimSelectionMultiple(3, Report::"Import Firm. Prod. Orders", SummarizePerDimText);//BC UPGRADE KUMARR78 -- TEMP
                            end;
                        }
                    }
                    group("Fill in Journal Lines")
                    {
                        Caption = 'Fill in Journal Lines';
                        field(PostingDate; PostingDate)
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Posting Date',
                                        FRA = 'Date comptabilisation';
                            Editable = UseDueDateAsPostingDate = false;
                            Importance = Promoted;
                            ToolTip = 'Specifies the date for the posting of this batch job. By default, the working date is entered, but you can change it.';

                            trigger OnValidate();
                            begin
                                ValidatePostingDate();
                            end;
                        }
                        field(UseDueDateAsPostingDate; UseDueDateAsPostingDate)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Calculate Posting Date from Applies-to-Doc. Due Date';
                            Importance = Additional;
                            ToolTip = 'Specifies if the due date on the purchase invoice will be used as a basis to calculate the payment posting date.';

                            trigger OnValidate();
                            begin
                                if UseDueDateAsPostingDate and (SummarizePerCust or UsePaymentDisc) then
                                    Error(PmtDiscUnavailableErr);
                                if not UseDueDateAsPostingDate then
                                    Clear(DueDateOffset);
                            end;
                        }
                        field(DueDateOffset; DueDateOffset)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Applies-to-Doc. Due Date Offset';
                            Editable = UseDueDateAsPostingDate;
                            Enabled = UseDueDateAsPostingDate;
                            Importance = Additional;
                            ToolTip = 'Specifies a period of time that will separate the payment posting date from the due date on the invoice. Example 1: To pay the invoice on the Friday in the week of the due date, enter CW-2D (current week minus two days). Example 2: To pay the invoice two days before the due date, enter -2D (minus two days).';
                        }
                        field(StartingDocumentNo; NextDocNo)
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Starting Document No.',
                                        FRA = 'N° document début';
                            ToolTip = 'Specifies the next available number in the number series for the journal batch that is linked to the payment journal. When you run the batch job, this is the document number that appears on the first payment journal line. You can also fill in this field manually.';

                            trigger OnValidate();
                            var
                            // TextManagement: Codeunit TextManagement;//BC UPGRADE KUMARR78 >> Blocking to Replace with Local Function Created
                            begin
                                if NextDocNo <> '' then
                                    // TextManagement.EvaluateIncStr(NextDocNo, StartingDocumentNoErr);
                                    EvaluateIncStr(NextDocNo, StartingDocumentNoErr); //BC UPGRADE KUMARR78 >> Adding
                            end;
                        }
                        field(NewDocNoPerLine; DocNoPerLine)
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'New Doc. No. per Line',
                                        FRA = 'Nouveau n° document par ligne';
                            Importance = Additional;
                            ToolTip = 'Specifies if you want the batch job to fill in the payment journal lines with consecutive document numbers, starting with the document number specified in the Starting Document No. field.';

                            trigger OnValidate();
                            begin
                                if not UsePriority and (AmountAvailable <> 0) then
                                    Error(Text013);
                            end;
                        }
                        field(BalAccountType; GenJnlLine2."Bal. Account Type")
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Bal. Account Type',
                                        FRA = 'Type compte contrepartie';
                            Importance = Additional;
                            // OptionCaptionML = ENU = 'G/L Account,,,Bank Account',
                            //                   FRA = 'Compte général,,,Compte bancaire';
                            // ToolTip = 'Specifies the balancing account type that payments on the payment journal are posted to.';

                            trigger OnValidate();
                            begin
                                GenJnlLine2."Bal. Account No." := '';
                            end;
                        }
                        field(BalAccountNo; GenJnlLine2."Bal. Account No.")
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Bal. Account No.',
                                        FRA = 'N° compte contrepartie';
                            Importance = Additional;
                            ToolTip = 'Specifies the balancing account number that payments on the payment journal are posted to.';

                            trigger OnLookup(var Text: Text): Boolean;
                            begin
                                case GenJnlLine2."Bal. Account Type" of
                                    GenJnlLine2."Bal. Account Type"::"G/L Account":
                                        if Page.RunModal(0, GLAcc) = Action::LookupOK then
                                            GenJnlLine2."Bal. Account No." := GLAcc."No.";
                                    // GenJnlLine2."Bal. Account Type"::Customer, GenJnlLine2."Bal. Account Type"::Customer://BC UPGRADE KUMARR78 --
                                    GenJnlLine2."Bal. Account Type"::Customer:
                                        Error(Text009, GenJnlLine2.FieldCaption("Bal. Account Type"));
                                    GenJnlLine2."Bal. Account Type"::"Bank Account":
                                        if Page.RunModal(0, BankAcc) = Action::LookupOK then
                                            GenJnlLine2."Bal. Account No." := BankAcc."No.";
                                end;
                            end;

                            trigger OnValidate();
                            begin
                                if GenJnlLine2."Bal. Account No." <> '' then
                                    case GenJnlLine2."Bal. Account Type" of
                                        GenJnlLine2."Bal. Account Type"::"G/L Account":
                                            GLAcc.Get(GenJnlLine2."Bal. Account No.");
                                        // GenJnlLine2."Bal. Account Type"::Customer, GenJnlLine2."Bal. Account Type"::Customer://BC UPGRADE KUMARR78 --
                                        GenJnlLine2."Bal. Account Type"::Customer:
                                            Error(Text009, GenJnlLine2.FieldCaption("Bal. Account Type"));
                                        GenJnlLine2."Bal. Account Type"::"Bank Account":
                                            BankAcc.Get(GenJnlLine2."Bal. Account No.");
                                    end;
                            end;
                        }
                        field(BankPaymentType; GenJnlLine2."Bank Payment Type")
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Bank Payment Type',
                                        FRA = 'Mode émission paiement';
                            Importance = Additional;
                            // OptionCaptionML = ENU = ' ,Computer Check,Manual Check',
                            //                   FRA = ' ,Informatique,Manuel';
                            // ToolTip = 'Specifies the check type to be used, if you use Bank Account as the balancing account type.';

                            trigger OnValidate();
                            begin
                                if (GenJnlLine2."Bal. Account Type" <> GenJnlLine2."Bal. Account Type"::"Bank Account") and
                                   (GenJnlLine2."Bank Payment Type".AsInteger() > 0)
                                then
                                    Error(
                                      Text010,
                                      GenJnlLine2.FieldCaption("Bank Payment Type"),
                                      GenJnlLine2.FieldCaption("Bal. Account Type"));
                            end;
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit();
        begin
            SummarizePerDimTextEnable := true;
            SkipExportedPayments := true;
        end;

        trigger OnOpenPage();
        begin
            LastDueDateToPayReq := WorkDate();
            PostingDate := WorkDate();
            ValidatePostingDate();
            SetDefaults();
        end;
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        Commit();
        if not CustomerLedgEntryTemp.IsEmpty then
            if Confirm(Text024) then
                Page.RunModal(0, CustomerLedgEntryTemp);
    end;

    trigger OnPreReport();
    begin
        CompanyInformation.Get();
        CustomerLedgEntryTemp.DeleteAll();
        ShowPostingDateWarning := false;
    end;

    var
        BankAcc: Record "Bank Account";
        CompanyInformation: Record "Company Information";
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustomerLedgEntryTemp: Record "Cust. Ledger Entry" temporary;
        Cust2: Record Customer;
        OldTempPaymentBuffer: Record "Customer Payment Buffer FND" temporary;
        TempPaymentBuffer: Record "Customer Payment Buffer FND" temporary;
        DimSetEntry: Record "Dimension Set Entry";
        GLAcc: Record "G/L Account";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlTemplate: Record "Gen. Journal Template";
        PayableCustLedgEntry: Record "Payable Cust Ledger Entry FND" temporary;
        SelectedDim: Record "Selected Dimension";
        DimBufMgt: Codeunit "Dimension Buffer Management";

        DimMgt: Codeunit DimensionManagement;
        // NoSeriesMgt: Codeunit NoSeriesManagement;//BC UPGRADE KUMARR78 --
        NoSeriesMgt: Codeunit "No. Series"; //BC UPGRADE KUMARR78 ++
        DueDateOffset: DateFormula;
        DocNoPerLine: Boolean;
        GenJnlLineInserted: Boolean;
        SeveralCurrencies: Boolean;
        ShowPostingDateWarning: Boolean;
        SkipExportedPayments: Boolean;
        StopPayments: Boolean;
        SummarizePerCust: Boolean;
        SummarizePerDim: Boolean;
        SummarizePerDimTextEnable: Boolean;
        UseDueDateAsPostingDate: Boolean;
        UsePaymentDisc: Boolean;
        UsePriority: Boolean;
        BalAccNo: Code[20];
        ContractNo: Code[20];
        NextDocNo: Code[20];
        LastDueDateToPayReq: Date;
        PostingDate: Date;
        AmountAvailable: Decimal;
        CustomerBalance: Decimal;
        OriginalAmtAvailable: Decimal;
        Window: Dialog;
        Window2: Dialog;
        LastLineNo: Integer;
        NextEntryNo: Integer;
        MessageToRecipientMsg: Label '"Payment of %1 %2 "', Comment = '%1 document type, %2 Document No.';
        PmtDiscUnavailableErr: Label 'You cannot use Find Payment Discounts or Summarize per Customer together with Calculate Posting Date from Applies-to-Doc. Due Date, because the resulting posting date might not match the payment discount date.';
        ReplacePostingDateMsg: Label 'For one or more entries, the requested posting date is before the work date.\\These posting dates will use the work date.';
        Text025: Label 'The %1 with the number %2 has a %3 with the number %4.';
        BankPmtType: Option " ","Computer Check","Manual Check";
        BalAccType: Option "G/L Account",Customer,Vendor,"Bank Account";
        MessageText: Text;
        SummarizePerDimText: Text[250];
        StartingDocumentNoErr: TextConst ENU = 'Starting Document No.', FRA = 'Le champ N° document début doit contenir un numéro.';
        Text000: TextConst ENU = 'In the Last Payment Date field, specify the last possible date that payments must be made.', FRA = 'Veuillez entrer la date du dernier paiement';
        Text001: TextConst ENU = 'In the Posting Date field, specify the date that will be used as the posting date for the journal entries.', FRA = 'Veuillez entrer une date de comptabilisation.';
        Text002: TextConst ENU = 'In the Starting Document No. field, specify the first document number to be used.', FRA = 'Veuillez entrer un N° document de début';
        Text003: TextConst Comment = '%1 is a date', ENU = 'The payment date is earlier than %1.\\Do you still want to run the batch job?', FRA = 'La date de paiement est antérieure à %1.\\';
        Text005: TextConst ENU = 'The batch job was interrupted.', FRA = 'Le traitement par lots a été interrompu.';
        Text006: TextConst ENU = 'Processing Customers     #1##########', FRA = 'Traitement des clients      #1########';
        Text007: TextConst ENU = 'Processing Customers for payment discounts #1##########', FRA = 'Traitement des clients pour paiement remises  #1##########';
        Text008: TextConst ENU = 'Inserting payment journal lines #1##########', FRA = 'Insertion des lignes f. paiement        #1##########';
        Text009: TextConst ENU = '%1 must be G/L Account or Bank Account.', FRA = '%1 doit être un compte général ou un compte bancaire.';
        Text010: TextConst ENU = '%1 must be filled only when %2 is Bank Account.', FRA = '%1 ne doit être renseigné que lorsque %2 est un compte bancaire.';
        Text011: TextConst ENU = 'Use Customer Priority must be activated when the value in the Amount Available field is not 0.', FRA = 'Utiliser priorité client doit être activé lorsque la valeur dans le champ Montant disponible n''est pas 0.';
        Text013: TextConst ENU = 'Use Customer Priority must be activated when the value in the Amount Available Amount (LCY) field is not 0.', FRA = 'Utiliser priorité client doit être activé lorsque la valeur dans le champ Montant disponible DS n''est pas 0.';
        Text014: TextConst ENU = 'Payment to Customer %1', FRA = 'Paiement pour client %1';
        Text015: TextConst ENU = 'Payment of %1 %2', FRA = 'Paiement de %1 %2';
        Text017: TextConst Comment = 'If Bank Payment Type = Computer Check and you have not selected the Summarize per Customer field,\ then you must select the New Doc. No. per Line.', ENU = 'If %1 = %2 and you have not selected the Summarize per Customer field,\ then you must select the New Doc. No. per Line.', FRA = 'Lorsque %1 = %2 et vous n''avez pas placé une coche dans le champ "résumé par client",\';
        Text020: TextConst Comment = 'You have only created suggested Customer payment lines for the Currency Code EUR.\ However, there are other open Customer ledger entries in currencies other than EUR.', ENU = 'You have only created suggested Customer payment lines for the %1 %2.\ However, there are other open Customer ledger entries in currencies other than %2.\\', FRA = 'Il y a ,cependant, d''autres écritures comptables ouvertes client dans d''autres devises que %2.';
        Text021: TextConst Comment = 'You have only created suggested Customer payment lines for the Currency Code EUR\ There are no other open Customer ledger entries in other currencies.\\', ENU = 'You have only created suggested Customer payment lines for the %1 %2.\ There are no other open Customer ledger entries in other currencies.\\', FRA = 'Il n''y aucune écriture comptable ouverte client dans d''autres devises.';
        Text022: TextConst ENU = 'You have created suggested Customer payment lines for all currencies.\\', FRA = 'Vous avez suggéré des lignes de paiement client pour toutes les devises.\';
        Text023: TextConst ENU = ' ,Computer Check,Manual Check', FRA = ' ,Informatique,Manuel';
        Text024: TextConst ENU = 'There are one or more entries for which no payment suggestions have been made because the posting dates of the entries are later than the requested posting date. Do you want to see the entries?', FRA = 'Il y a une ou plusieurs entrées pour lesquelles aucune des suggestions de paiement n''ont été faites parce que les dates d''affichage des entrées sont au plus tard la date d''affichage de la fenêtre de demande de travail par lots de paiement fournisseur proposés. Voulez-vous voir les entrées?';

    procedure SetGenJnlLine(NewGenJnlLine: Record "Gen. Journal Line");
    begin
        GenJnlLine := NewGenJnlLine;
    end;

    local procedure ValidatePostingDate();
    begin
        GenJnlBatch.Get(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
        if GenJnlBatch."No. Series" = '' then
            NextDocNo := ''
        else begin
            NextDocNo := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", PostingDate, false);
            Clear(NoSeriesMgt);
        end;
    end;

    procedure InitializeRequest(LastPmtDate: Date; FindPmtDisc: Boolean; NewAvailableAmount: Decimal; NewSkipExportedPayments: Boolean; NewPostingDate: Date; NewStartDocNo: Code[20]; NewSummarizePerCust: Boolean; BalAccType: Option "G/L Account",Customer,Vendor,"Bank Account"; BalAccNo: Code[20]; BankPmtType: Option " ","Computer Check","Manual Check");
    begin
        LastDueDateToPayReq := LastPmtDate;
        UsePaymentDisc := FindPmtDisc;
        AmountAvailable := NewAvailableAmount;
        SkipExportedPayments := NewSkipExportedPayments;
        PostingDate := NewPostingDate;
        NextDocNo := NewStartDocNo;
        SummarizePerCust := NewSummarizePerCust;
        GenJnlLine2."Bal. Account Type" := BalAccType;
        GenJnlLine2."Bal. Account No." := BalAccNo;
        GenJnlLine2."Bank Payment Type" := BankPmtType;
    end;

    local procedure GetCustLedgEntries(Positive: Boolean; Future: Boolean);
    begin
        CustLedgEntry.Reset();
        //<< DITW110.00.11 AKH 29/08/2017 NRQ#17902
        if CustLedgerEntryFilter.GetFilters() <> '' then
            CustLedgEntry.CopyFilters(CustLedgerEntryFilter);
        //>> DITW110.00.11 AKH NRQ#17902
        CustLedgEntry.SetCurrentKey("Customer No.", Open, Positive, "Due Date");
        CustLedgEntry.SetRange("Customer No.", Customer."No.");
        CustLedgEntry.SetRange(Open, true);
        CustLedgEntry.SetRange(Positive, Positive);
        CustLedgEntry.SetRange("Applies-to ID", '');

        /// DITW110.00.11 AKH 29/08/2017 NRQ#17902

        //DITW17.00.02 SR 19/12/2013 DIT-770 #163
        //BC UPGRADE KUMARR78 >> Blocking
        // if Customer.GETFILTER("Customer Posting Group Filter") <> '' then
        //     CustLedgEntry.SETFILTER("Customer Posting Group", Customer.GETFILTER("Customer Posting Group Filter"));
        //BC UPGRADE KUMARR78 << Blocking

        //BC UPGRADE KUMARR78 >> Adding
        if Customer.GetFilter("Customer Posting Group") <> '' then
            CustLedgEntry.SetFilter("Customer Posting Group", Customer.GetFilter("Customer Posting Group"));
        //BC UPGRADE KUMARR78 << Adding

        //DITW17.00.02 SR DIT-770 #163
        if Future then begin
            CustLedgEntry.SetRange("Due Date", LastDueDateToPayReq + 1, DMY2Date(31, 12, 9999));
            CustLedgEntry.SetRange("Pmt. Discount Date", PostingDate, LastDueDateToPayReq);
            CustLedgEntry.SetFilter("Remaining Pmt. Disc. Possible", '<>0');
        end else
            CustLedgEntry.SetRange("Due Date", 0D, LastDueDateToPayReq);
        if SkipExportedPayments then
            CustLedgEntry.SetRange("Exported to Payment File", false);
        CustLedgEntry.SetRange("On Hold", '');
        CustLedgEntry.SetFilter("Currency Code", Customer.GetFilter("Currency Filter"));
        CustLedgEntry.SetFilter("Global Dimension 1 Code", Customer.GetFilter("Global Dimension 1 Filter"));
        CustLedgEntry.SetFilter("Global Dimension 2 Code", Customer.GetFilter("Global Dimension 2 Filter"));

        if CustLedgEntry.Find('-') then
            repeat
                SaveAmount();
                if CustLedgEntry."Accepted Pmt. Disc. Tolerance" or
                   (CustLedgEntry."Accepted Payment Tolerance" <> 0)
                then begin
                    CustLedgEntry."Accepted Pmt. Disc. Tolerance" := false;
                    CustLedgEntry."Accepted Payment Tolerance" := 0;
                    Codeunit.Run(Codeunit::"Cust. Entry-Edit", CustLedgEntry);
                end;
            until CustLedgEntry.Next() = 0;
    end;

    local procedure SaveAmount();
    var
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        enumvalue : Enum "General Posting Type";
    begin
        GenJnlLine.Init();
        SetPostingDate(GenJnlLine, CustLedgEntry."Due Date", PostingDate);
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        Cust2.Get(CustLedgEntry."Customer No.");
        Cust2.CheckBlockedCustOnJnls(Cust2, GenJnlLine."Document Type", false);
        GenJnlLine.Description := Cust2.Name;
        GenJnlLine."Posting Group" := Cust2."Customer Posting Group";
        GenJnlLine."Salespers./Purch. Code" := Cust2."Salesperson Code";
        GenJnlLine."Payment Terms Code" := Cust2."Payment Terms Code";
        GenJnlLine.Validate("Bill-to/Pay-to No.", GenJnlLine."Account No.");
        GenJnlLine.Validate("Sell-to/Buy-from No.", GenJnlLine."Account No.");
        GenJnlLine."Gen. Posting Type" := enumvalue::" ";
        GenJnlLine."Gen. Bus. Posting Group" := '';
        GenJnlLine."Gen. Prod. Posting Group" := '';
        GenJnlLine."VAT Bus. Posting Group" := '';
        GenJnlLine."VAT Prod. Posting Group" := '';
        GenJnlLine.Validate("Currency Code", CustLedgEntry."Currency Code");
        GenJnlLine.Validate("Payment Terms Code");
        CustLedgEntry.CalcFields("Remaining Amount");
        if PaymentToleranceMgt.CheckCalcPmtDiscGenJnlCust(GenJnlLine, CustLedgEntry, 0, false) then
            GenJnlLine.Amount := -(CustLedgEntry."Remaining Amount" - CustLedgEntry."Remaining Pmt. Disc. Possible")
        else
            GenJnlLine.Amount := -CustLedgEntry."Remaining Amount";
        GenJnlLine.Validate(Amount);
        // <<DITW16.00.00.43 DDR 09/08/2013 DIT-715 #714
        //BC UPGRADE KUMARR78 >> Blocking DIT Fields
        // "Contract Type" := CustLedgEntry."Contract Type";
        // "Service Contract Line No." := CustLedgEntry."Service Contract Line No.";
        // "DIT Sub-Contract Type" := CustLedgEntry."DIT Sub-Contract Type";
        // "Service Contract No." := CustLedgEntry."Service Contract No.";
        // //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        // "Financial Contract No." := CustLedgEntry."Financial Contract No.";
        // //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        // "Building No." := CustLedgEntry."Building No.";
        // "Contract Group Code" := CustLedgEntry."Contract Group Code";
        //BC UPGRADE KUMARR78 << Blocking DIT Fields
        //>>DITW17.10.03 MSF 06/05/2014 DIT-770 #340
        //IF "DIT Sub-Contract Type" <> 0 THEN
        //  "Posting Group" := ServPurchPostJnl.GetSourcePostGroupService(Cust2."No.","DIT Sub-Contract Type");
        // >>DITW16.00.00.43 DDR DIT-715 #714
        GenJnlLine."Posting Group" := CustLedgEntry."Customer Posting Group";
        //<<DITW17.10.03 MSF 06/05/2014 DIT-770 #340
        //BC UPGRADE KUMARR78 >> Blocking DIT Fields
        // "Route Planning No." := CustLedgEntry."Route Planning No.";
        //BC UPGRADE KUMARR78 << Blocking DIT Fields
        GenJnlLine."Document Subtype Code FND" := CustLedgEntry."Document Subtype Code FND";

        if UsePriority then
            PayableCustLedgEntry.Priority := Customer.Priority
        else
            PayableCustLedgEntry.Priority := 0;
        PayableCustLedgEntry."Customer No." := CustLedgEntry."Customer No.";
        PayableCustLedgEntry."Entry No." := NextEntryNo;
        PayableCustLedgEntry."Customer Ledg. Entry No." := CustLedgEntry."Entry No.";
        PayableCustLedgEntry.Amount := GenJnlLine.Amount;
        PayableCustLedgEntry."Amount (LCY)" := GenJnlLine."Amount (LCY)";
        PayableCustLedgEntry.Positive := (PayableCustLedgEntry.Amount > 0);
        PayableCustLedgEntry.Future := (CustLedgEntry."Due Date" > LastDueDateToPayReq);
        PayableCustLedgEntry."Currency Code" := CustLedgEntry."Currency Code";
        // <<DITW16.00.00.43 DDR 09/08/2013 DIT-715 #714

        //BC UPGRADE KUMARR78 >> Blocking DIT Fields
        // PayableCustLedgEntry."Contract Type" := CustLedgEntry."Contract Type";
        // PayableCustLedgEntry."Service Contract Line No." := CustLedgEntry."Service Contract Line No.";
        // PayableCustLedgEntry."DIT Sub-Contract Type" := CustLedgEntry."DIT Sub-Contract Type";
        // PayableCustLedgEntry."Service Contract No." := CustLedgEntry."Service Contract No.";
        // PayableCustLedgEntry."Building No." := CustLedgEntry."Building No.";
        // PayableCustLedgEntry."Contract Group Code" := CustLedgEntry."Contract Group Code";
        //BC UPGRADE KUMARR78 << Blocking DIT Fields

        // >>DITW16.00.00.43 DDR DIT-715 #714
        //<<DITW17.10.03 MSF 06/05/2014 DIT-770 #340
        PayableCustLedgEntry."Posting Group" := CustLedgEntry."Customer Posting Group";
        //>>DITW17.10.03 MSF 06/05/2014 DIT-770 #340
        //<<DITW110.00.11 MSF 15/11/2017 NRQ#45760

        // PayableCustLedgEntry."Financial Contract No." := CustLedgEntry."Financial Contract No.";//BC UPGRADE KUMARR78 << Blocking DIT Fields
        //>>DITW110.00.11 MSF 15/11/2017 NRQ#45760
        PayableCustLedgEntry.Insert();
        NextEntryNo := NextEntryNo + 1;
    end;

    local procedure CheckAmounts(Future: Boolean);
    var
        PrevCurrency: Code[10];
        CurrencyBalance: Decimal;
    begin
        PayableCustLedgEntry.SetRange("Customer No.", Customer."No.");
        PayableCustLedgEntry.SetRange(Future, Future);

        if PayableCustLedgEntry.Find('-') then begin
            repeat
                if PayableCustLedgEntry."Currency Code" <> PrevCurrency then begin
                    if CurrencyBalance > 0 then
                        AmountAvailable := AmountAvailable - CurrencyBalance;
                    CurrencyBalance := 0;
                    PrevCurrency := PayableCustLedgEntry."Currency Code";
                end;
                if (OriginalAmtAvailable = 0) or
                   (AmountAvailable >= CurrencyBalance + PayableCustLedgEntry."Amount (LCY)")
                then
                    CurrencyBalance := CurrencyBalance + PayableCustLedgEntry."Amount (LCY)"
                else
                    PayableCustLedgEntry.Delete();
            until PayableCustLedgEntry.Next() = 0;
            if OriginalAmtAvailable > 0 then
                AmountAvailable := AmountAvailable - CurrencyBalance;
            if (OriginalAmtAvailable > 0) and (AmountAvailable <= 0) then
                StopPayments := true;
        end;
        PayableCustLedgEntry.Reset();
    end;

    local procedure MakeGenJnlLines();
    var
        CustLedgEntryItemCharge: Record "Cust. Ledger Entry";
        Customer3: Record Customer;
        DimBuf: Record "Dimension Buffer";
        GenJnlLine1: Record "Gen. Journal Line";
        RemainingAmtAvailable: Decimal;
    begin
        TempPaymentBuffer.Reset();
        TempPaymentBuffer.DeleteAll();

        if BalAccType = BalAccType::"Bank Account" then begin
            CheckCurrencies(BalAccType, BalAccNo, PayableCustLedgEntry);
            SetBankAccCurrencyFilter(BalAccType, BalAccNo, PayableCustLedgEntry);
        end;

        if OriginalAmtAvailable <> 0 then begin
            RemainingAmtAvailable := OriginalAmtAvailable;
            RemovePaymentsAboveLimit(PayableCustLedgEntry, RemainingAmtAvailable);
        end;
        if PayableCustLedgEntry.Find('-') then
            repeat
                PayableCustLedgEntry.SetRange("Customer No.", PayableCustLedgEntry."Customer No.");
                PayableCustLedgEntry.FindSet();
                repeat
                    CustLedgEntry.Get(PayableCustLedgEntry."Customer Ledg. Entry No.");
                    SetPostingDate(GenJnlLine1, CustLedgEntry."Due Date", PostingDate);
                    if CustLedgEntry."Posting Date" <= GenJnlLine1."Posting Date" then begin
                        TempPaymentBuffer."Customer No." := CustLedgEntry."Customer No.";
                        TempPaymentBuffer."Currency Code" := CustLedgEntry."Currency Code";
                        TempPaymentBuffer."Payment Method Code" := CustLedgEntry."Payment Method Code";
                        //
                        //TempPaymentBuffer."Creditor No." := CustLedgEntry."Creditor No.";
                        //TempPaymentBuffer."Payment Reference" := CustLedgEntry."Payment Reference";
                        TempPaymentBuffer."Exported to Payment File" := CustLedgEntry."Exported to Payment File";
                        TempPaymentBuffer."Applies-to Ext. Doc. No." := CustLedgEntry."External Document No.";
                        // <<DITW16.00.00.43 DDR 09/08/2013 DIT-715 #714

                        //BC UPGRADE KUMARR78 >> Blocking DIT Fields
                        // TempPaymentBuffer."Contract Type" := CustLedgEntry."Contract Type";
                        // TempPaymentBuffer."Service Contract Line No." := CustLedgEntry."Service Contract Line No.";
                        // TempPaymentBuffer."DIT Sub-Contract Type" := CustLedgEntry."DIT Sub-Contract Type";
                        // TempPaymentBuffer."Service Contract No." := CustLedgEntry."Service Contract No.";
                        // TempPaymentBuffer."Building No." := CustLedgEntry."Building No.";
                        // TempPaymentBuffer."Contract Group Code" := CustLedgEntry."Contract Group Code";
                        //BC UPGRADE KUMARR78 << Blocking DIT Fields
                        // >>DITW16.00.00.43 DDR DIT-715 #714
                        //<<DITW17.10.03 MSF 06/05/2014 DIT-770 #340
                        TempPaymentBuffer."Posting Group" := CustLedgEntry."Customer Posting Group";
                        //>>DITW17.10.03 MSF 06/05/2014 DIT-770 #340
                        //<<DITW110.00.11 AKH 29/08/2017 NRQ#17902
                        //BC UPGRADE KUMARR78 >> Blocking DIT Fields
                        // TempPaymentBuffer."Route Planning No." := CustLedgEntry."Route Planning No.";
                        //BC UPGRADE KUMARR78 << Blocking DIT Fields
                        TempPaymentBuffer."Document Subtype Code" := CustLedgEntry."Document Subtype Code FND";
                        //>>DITW110.00.11 AKH NRQ#17902
                        //<<DITW110.00.11 MSF 15/11/2017 NRQ#45760
                        // TempPaymentBuffer."Financial Contract No." := CustLedgEntry."Financial Contract No.";//BC UPGRADE KUMARR78 << Blocking DIT Fields
                        //>>DITW110.00.11 MSF 15/11/2017 NRQ#45760
                        SetTempPaymentBufferDims(DimBuf);

                        CustLedgEntry.CalcFields("Remaining Amount");

                        if SummarizePerCust then begin
                            TempPaymentBuffer."Customer Ledg. Entry No." := 0;
                            if TempPaymentBuffer.Find() then begin
                                TempPaymentBuffer.Amount := TempPaymentBuffer.Amount + PayableCustLedgEntry.Amount;
                                // <<DITW16.00.00.43 DDR 09/08/2013 DIT-715 #714
                                //BC UPGRADE KUMARR78 >> Blocking DIT Fields
                                // if TempPaymentBuffer."Contract Type" <> CustLedgEntry."Contract Type" then
                                //     TempPaymentBuffer."Contract Type" := 0;
                                // if TempPaymentBuffer."Service Contract Line No." <> CustLedgEntry."Service Contract Line No." then
                                //     TempPaymentBuffer."Service Contract Line No." := 0;
                                // if TempPaymentBuffer."DIT Sub-Contract Type" <> CustLedgEntry."DIT Sub-Contract Type" then
                                //     TempPaymentBuffer."DIT Sub-Contract Type" := 0;
                                // if TempPaymentBuffer."Service Contract No." <> CustLedgEntry."Service Contract No." then
                                //     TempPaymentBuffer."Service Contract No." := '';
                                // //<<DITW110.00.11 MSF 15/11/2017 NRQ#45760
                                // if TempPaymentBuffer."Financial Contract No." <> CustLedgEntry."Financial Contract No." then
                                //     TempPaymentBuffer."Financial Contract No." := '';
                                // //>>DITW110.00.11 MSF 15/11/2017 NRQ#45760
                                // if TempPaymentBuffer."Building No." <> CustLedgEntry."Building No." then
                                //     TempPaymentBuffer."Building No." := '';
                                // if TempPaymentBuffer."Contract Group Code" <> CustLedgEntry."Contract Group Code" then
                                //     TempPaymentBuffer."Contract Group Code" := '';
                                //BC UPGRADE KUMARR78 << Blocking DIT Fields
                                // >>DITW16.00.00.43 DDR DIT-715 #714
                                //<<DITW17.10.03 MSF 06/05/2014 DIT-770 #340

                                if TempPaymentBuffer."Posting Group" <> CustLedgEntry."Customer Posting Group" then
                                    TempPaymentBuffer."Posting Group" := '';

                                //>>DITW17.10.03 MSF 06/05/2014 DIT-770 #340
                                //<<DITW110.00.11 AKH 29/08/2017 NRQ#17902
                                //BC UPGRADE KUMARR78 >> Blocking DIT Fields
                                // if TempPaymentBuffer."Route Planning No." <> CustLedgEntry."Route Planning No." then
                                //     TempPaymentBuffer."Route Planning No." := '';

                                //BC UPGRADE KUMARR78 << Blocking DIT 
                                if TempPaymentBuffer."Document Subtype Code" <> CustLedgEntry."Document Subtype Code FND" then
                                    TempPaymentBuffer."Document Subtype Code" := '';
                                //>>DITW110.00.11 AKH NRQ#17902
                                TempPaymentBuffer.Modify();
                            end else begin
                                TempPaymentBuffer."Document No." := NextDocNo;
                                NextDocNo := IncStr(NextDocNo);
                                TempPaymentBuffer.Amount := PayableCustLedgEntry.Amount;
                                Window2.Update(1, CustLedgEntry."Customer No.");
                                TempPaymentBuffer.Insert();
                            end;
                            CustLedgEntry."Applies-to ID" := TempPaymentBuffer."Document No.";
                        end else
                            if not IsEntryAlreadyApplied(GenJnlLine, CustLedgEntry) then begin
                                TempPaymentBuffer."Customer Ledg. Entry Doc. Type" := CustLedgEntry."Document Type".AsInteger();
                                TempPaymentBuffer."Customer Ledg. Entry Doc. No." := CustLedgEntry."Document No.";
                                TempPaymentBuffer."Global Dimension 1 Code" := CustLedgEntry."Global Dimension 1 Code";
                                TempPaymentBuffer."Global Dimension 2 Code" := CustLedgEntry."Global Dimension 2 Code";
                                TempPaymentBuffer."Dimension Set ID" := CustLedgEntry."Dimension Set ID";
                                TempPaymentBuffer."Customer Ledg. Entry No." := CustLedgEntry."Entry No.";
                                TempPaymentBuffer.Amount := PayableCustLedgEntry.Amount;
                                Window2.Update(1, CustLedgEntry."Customer No.");
                                TempPaymentBuffer.Insert();
                            end;

                        CustLedgEntry."Amount to Apply" := CustLedgEntry."Remaining Amount";
                        //<< DITW110.00.11 AKH 29/08/2017 NRQ#17902
                        Codeunit.Run(Codeunit::"Cust. Entry-Edit", CustLedgEntry);
                        //>> DITW110.00.11 AKH NRQ#17902
                    end else begin
                        CustomerLedgEntryTemp := CustLedgEntry;
                        CustomerLedgEntryTemp.Insert();
                    end;

                    PayableCustLedgEntry.Delete();
                    if OriginalAmtAvailable <> 0 then begin
                        RemainingAmtAvailable := RemainingAmtAvailable - PayableCustLedgEntry."Amount (LCY)";
                        RemovePaymentsAboveLimit(PayableCustLedgEntry, RemainingAmtAvailable);
                    end;

                until not PayableCustLedgEntry.FindSet();
                PayableCustLedgEntry.DeleteAll();
                PayableCustLedgEntry.SetRange("Customer No.");
            until not PayableCustLedgEntry.Find('-');

        Clear(OldTempPaymentBuffer);
        TempPaymentBuffer.SetCurrentKey("Document No.");
        TempPaymentBuffer.SetFilter(
          "Customer Ledg. Entry Doc. Type", '<>%1&<>%2', TempPaymentBuffer."Customer Ledg. Entry Doc. Type"::Refund,
          TempPaymentBuffer."Customer Ledg. Entry Doc. Type"::Payment);
        if TempPaymentBuffer.Find('-') then
            repeat
                GenJnlLine.Init();
                Window2.Update(1, TempPaymentBuffer."Customer No.");
                LastLineNo := LastLineNo + 10000;
                GenJnlLine."Line No." := LastLineNo;
                //HEI.02 "Document Type" := "Document Type"::Payment;
                //HEI.02+
                if TempPaymentBuffer."Customer Ledg. Entry Doc. Type" = TempPaymentBuffer."Customer Ledg. Entry Doc. Type"::"Credit Memo" then
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Refund
                else
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                //BC UPGRADE KUMARR78 >> Blocking DIT Fields
                // if CustLedgEntryItemCharge.GET(TempPaymentBuffer."Customer Ledg. Entry No.") then
                //     "Item Charge Type" := CustLedgEntryItemCharge."Item Charge Type";
                //BC UPGRADE KUMARR78 << Blocking DIT Fields
                //HEI.02-
                GenJnlLine."Posting No. Series" := GenJnlBatch."Posting No. Series";
                if SummarizePerCust then
                    GenJnlLine."Document No." := TempPaymentBuffer."Document No."
                else
                    if DocNoPerLine then begin
                        if TempPaymentBuffer.Amount < 0 then
                            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Refund;

                        GenJnlLine."Document No." := NextDocNo;
                        NextDocNo := IncStr(NextDocNo);
                    end else
                        if (TempPaymentBuffer."Customer No." = OldTempPaymentBuffer."Customer No.") and
                           (TempPaymentBuffer."Currency Code" = OldTempPaymentBuffer."Currency Code")
                        then
                            GenJnlLine."Document No." := OldTempPaymentBuffer."Document No."
                        else begin
                            GenJnlLine."Document No." := NextDocNo;
                            NextDocNo := IncStr(NextDocNo);
                            OldTempPaymentBuffer := TempPaymentBuffer;
                            OldTempPaymentBuffer."Document No." := GenJnlLine."Document No.";
                        end;
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                GenJnlLine.SetHideValidation(true);
                ShowPostingDateWarning := ShowPostingDateWarning or
                  SetPostingDate(GenJnlLine, GetApplDueDate(TempPaymentBuffer."Customer Ledg. Entry No."), PostingDate);
                GenJnlLine.Validate("Account No.", TempPaymentBuffer."Customer No.");
                Customer3.Get(TempPaymentBuffer."Customer No.");
                if (Customer3."Bill-to Customer No." <> '') and (Customer."Bill-to Customer No." <> GenJnlLine."Account No.") then
                    Message(Text025, Customer.TableCaption, Customer."No.", Customer3.FieldCaption("Bill-to Customer No."),
                      Customer3."Bill-to Customer No.");
                GenJnlLine."Bal. Account Type" := BalAccType;
                GenJnlLine.Validate("Bal. Account No.", BalAccNo);
                GenJnlLine.Validate("Currency Code", TempPaymentBuffer."Currency Code");
                GenJnlLine."Message to Recipient" := GetMessageToRecipient(SummarizePerCust);
                GenJnlLine."Bank Payment Type" := BankPmtType;
                if SummarizePerCust then begin
                    GenJnlLine."Applies-to ID" := GenJnlLine."Document No.";
                    GenJnlLine.Description := StrSubstNo(Text014, TempPaymentBuffer."Customer No.");
                end else
                    GenJnlLine.Description :=
                      StrSubstNo(
                        Text015,
                        TempPaymentBuffer."Customer Ledg. Entry Doc. Type",
                        TempPaymentBuffer."Customer Ledg. Entry Doc. No.");
                GenJnlLine."Source Line No." := TempPaymentBuffer."Customer Ledg. Entry No.";
                GenJnlLine."Shortcut Dimension 1 Code" := TempPaymentBuffer."Global Dimension 1 Code";
                GenJnlLine."Shortcut Dimension 2 Code" := TempPaymentBuffer."Global Dimension 2 Code";
                GenJnlLine."Dimension Set ID" := TempPaymentBuffer."Dimension Set ID";
                GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
                GenJnlLine."Reason Code" := GenJnlBatch."Reason Code";
                GenJnlLine.Validate(Amount, TempPaymentBuffer.Amount);
                GenJnlLine."Applies-to Doc. Type" := TempPaymentBuffer."Customer Ledg. Entry Doc. Type";
                GenJnlLine."Applies-to Doc. No." := TempPaymentBuffer."Customer Ledg. Entry Doc. No.";
                GenJnlLine."Payment Method Code" := TempPaymentBuffer."Payment Method Code";
                GenJnlLine."Creditor No." := TempPaymentBuffer."Creditor No.";
                GenJnlLine."Payment Reference" := TempPaymentBuffer."Payment Reference";
                GenJnlLine."Exported to Payment File" := TempPaymentBuffer."Exported to Payment File";
                GenJnlLine."Applies-to Ext. Doc. No." := TempPaymentBuffer."Applies-to Ext. Doc. No.";
                // <<DITW16.00.00.43 DDR 09/08/2013 DIT-715 #714
                //BC UPGRADE KUMARR78 >> Blocking DIT Fields
                // "Contract Type" := TempPaymentBuffer."Contract Type";
                // "Service Contract Line No." := TempPaymentBuffer."Service Contract Line No.";
                // "DIT Sub-Contract Type" := TempPaymentBuffer."DIT Sub-Contract Type";
                // "Service Contract No." := TempPaymentBuffer."Service Contract No.";
                // "Building No." := TempPaymentBuffer."Building No.";
                // "Contract Group Code" := TempPaymentBuffer."Contract Group Code";
                // //<<DITW110.00.11 MSF 15/11/2017 NRQ#45760
                // "Financial Contract No." := TempPaymentBuffer."Financial Contract No.";
                //BC UPGRADE KUMARR78 << Blocking DIT Fields
                //>>DITW110.00.11 MSF 15/11/2017 NRQ#45760
                //IF "DIT Sub-Contract Type" <> 0 THEN
                //   "Posting Group" := ServPurchPostJnl.GetSourcePostGroupService("Account No.","DIT Sub-Contract Type");
                // >>DITW16.00.00.43 DDR DIT-715 #714
                //<<DITW17.10.03 MSF 06/05/2014 DIT-770 #340
                GenJnlLine."Posting Group" := TempPaymentBuffer."Posting Group";
                //>>DITW17.10.03 MSF 06/05/2014 DIT-770 #340
                //<<DITW110.00.11 AKH 29/08/2017 NRQ#17902
                //BC UPGRADE KUMARR78 >> Blocking DIT Fields
                // "Route Planning No." := TempPaymentBuffer."Route Planning No.";
                //BC UPGRADE KUMARR78 << Blocking DIT Fields
                GenJnlLine."Document Subtype Code FND" := TempPaymentBuffer."Document Subtype Code";
                //>>DITW110.00.11 AKH NRQ#17902
                UpdateDimensions(GenJnlLine);
                GenJnlLine.Insert();
                GenJnlLineInserted := true;
            until TempPaymentBuffer.Next() = 0;
    end;

    local procedure UpdateDimensions(var GenJnlLine: Record "Gen. Journal Line");
    var
        DimBuf: Record "Dimension Buffer";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        TempDimSetEntry2: Record "Dimension Set Entry" temporary;
        DimVal: Record "Dimension Value";
        DimSetIDArr: array[10] of Integer;
        NewDimensionID: Integer;
    begin
        NewDimensionID := GenJnlLine."Dimension Set ID";
        if SummarizePerCust then begin
            DimBuf.Reset();
            DimBuf.DeleteAll();
            DimBufMgt.GetDimensions(TempPaymentBuffer."Dimension Entry No.", DimBuf);
            if DimBuf.FindSet() then
                repeat
                    DimVal.Get(DimBuf."Dimension Code", DimBuf."Dimension Value Code");
                    TempDimSetEntry."Dimension Code" := DimBuf."Dimension Code";
                    TempDimSetEntry."Dimension Value Code" := DimBuf."Dimension Value Code";
                    TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
                    TempDimSetEntry.Insert();
                until DimBuf.Next() = 0;
            NewDimensionID := DimMgt.GetDimensionSetID(TempDimSetEntry);
            GenJnlLine."Dimension Set ID" := NewDimensionID;
        end;
        //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //BC UPGRADE KUMARR78 >> Blocking DIT Fields
        // case "Contract Type" of
        //     "Contract Type"::Service:
        //         ContractNo := "Service Contract No.";
        //     "Contract Type"::Financial:
        //         ContractNo := "Financial Contract No.";
        // end;
        //BC UPGRADE KUMARR78 << Blocking DIT Fields
        //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //BC UPGRADE KUMARR78 >> Blocking DIT
        // CreateDim(
        //   DimMgt.TypeToTableID1("Account Type"), "Account No.",
        //   DimMgt.TypeToTableID1("Bal. Account Type"), "Bal. Account No.",
        //   Database::Job, "Job No.",
        //   Database::"Salesperson/Purchaser", "Salespers./Purch. Code",
        //   Database::Campaign, "Campaign No.",
        //   // <<DITW15.00.00.37 DDR 28/01/2010
        //   //   DATABASE::Building, "Building No.",//BC UPGRADE KUMARR78 << Blocking DIT Fields
        //   // >>DITW15.00.00.37 DDR
        //   // <<DITW16.00.00.41 AHU 06/08/2012 20/09/2012 DIT-715 #327
        //   //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //   DimMgt.TypeToTableID2034932(GetSourceType(), "Contract Type"), ContractNo);
        //BC UPGRADE KUMARR78 << Blocking DIT
        //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        // >>DITW16.00.00.41 AHU DIT-715 #327
        if NewDimensionID <> GenJnlLine."Dimension Set ID" then begin
            DimSetIDArr[1] := GenJnlLine."Dimension Set ID";
            DimSetIDArr[2] := NewDimensionID;
            GenJnlLine."Dimension Set ID" :=
              DimMgt.GetCombinedDimensionSetID(DimSetIDArr, GenJnlLine."Shortcut Dimension 1 Code", GenJnlLine."Shortcut Dimension 2 Code");
        end;

        if SummarizePerCust then begin
            DimMgt.GetDimensionSet(TempDimSetEntry, GenJnlLine."Dimension Set ID");
            if AdjustAgainstSelectedDim(TempDimSetEntry, TempDimSetEntry2) then
                GenJnlLine."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry2);
            DimMgt.UpdateGlobalDimFromDimSetID(GenJnlLine."Dimension Set ID", GenJnlLine."Shortcut Dimension 1 Code",
              GenJnlLine."Shortcut Dimension 2 Code");
        end;
    end;

    local procedure SetBankAccCurrencyFilter(BalAccType: Option "G/L Account",Customer,Vendor,"Bank Account"; BalAccNo: Code[20]; var TmpPayableCustLedgEntry: Record "Payable Cust Ledger Entry FND");
    var
        BankAcc: Record "Bank Account";
    begin
        if BalAccType = BalAccType::"Bank Account" then
            if BalAccNo <> '' then begin
                BankAcc.Get(BalAccNo);
                if BankAcc."Currency Code" <> '' then
                    TmpPayableCustLedgEntry.SetRange("Currency Code", BankAcc."Currency Code");
            end;
    end;

    local procedure ShowMessage(Text: Text);
    begin
        if GenJnlLineInserted then begin
            if ShowPostingDateWarning then
                Text += ReplacePostingDateMsg;
            if Text <> '' then
                Message(Text);
        end;
    end;

    local procedure CheckCurrencies(BalAccType: Option "G/L Account",Customer,Vendor,"Bank Account"; BalAccNo: Code[20]; var TmpPayableCustLedgEntry: Record "Payable Cust Ledger Entry FND");
    var
        BankAcc: Record "Bank Account";
        TmpPayableCustLedgEntry2: Record "Payable Cust Ledger Entry FND" temporary;
    begin
        if BalAccType = BalAccType::"Bank Account" then
            if BalAccNo <> '' then begin
                BankAcc.Get(BalAccNo);
                if BankAcc."Currency Code" <> '' then begin
                    TmpPayableCustLedgEntry2.Reset();
                    TmpPayableCustLedgEntry2.DeleteAll();
                    if TmpPayableCustLedgEntry.Find('-') then
                        repeat
                            TmpPayableCustLedgEntry2 := TmpPayableCustLedgEntry;
                            TmpPayableCustLedgEntry2.Insert();
                        until TmpPayableCustLedgEntry.Next() = 0;

                    TmpPayableCustLedgEntry2.SetFilter("Currency Code", '<>%1', BankAcc."Currency Code");
                    SeveralCurrencies := SeveralCurrencies or TmpPayableCustLedgEntry2.FindFirst();

                    if SeveralCurrencies then
                        MessageText :=
                          StrSubstNo(Text020, BankAcc.FieldCaption("Currency Code"), BankAcc."Currency Code")
                    else
                        MessageText :=
                          StrSubstNo(Text021, BankAcc.FieldCaption("Currency Code"), BankAcc."Currency Code");
                end else
                    MessageText := Text022;
            end;
    end;

    local procedure ClearNegative();
    var
        TempCurrency: Record Currency temporary;
        PayableCustLedgEntry2: Record "Payable Cust Ledger Entry FND" temporary;
        CurrencyBalance: Decimal;
    begin
        Clear(PayableCustLedgEntry);
        PayableCustLedgEntry.SetRange("Customer No.", Customer."No.");

        while PayableCustLedgEntry.Next() <> 0 do begin
            TempCurrency.Code := PayableCustLedgEntry."Currency Code";
            CurrencyBalance := 0;
            if TempCurrency.Insert() then begin
                PayableCustLedgEntry2 := PayableCustLedgEntry;
                PayableCustLedgEntry.SetRange("Currency Code", PayableCustLedgEntry."Currency Code");
                repeat
                    CurrencyBalance := CurrencyBalance + PayableCustLedgEntry."Amount (LCY)"
                until PayableCustLedgEntry.Next() = 0;
                //<< DITW110.00.11 AKH 30/08/2017 NRQ#17902
                if CurrencyBalance > 0 then begin
                    //>> DITW110.00.11 AKH NRQ#17902
                    PayableCustLedgEntry.DeleteAll();
                    AmountAvailable += CurrencyBalance;
                end;
                PayableCustLedgEntry.SetRange("Currency Code");
                PayableCustLedgEntry := PayableCustLedgEntry2;
            end;
        end;
        PayableCustLedgEntry.Reset();
    end;

    local procedure DimCodeIsInDimBuf(DimCode: Code[20]; DimBuf: Record "Dimension Buffer"): Boolean;
    begin
        DimBuf.Reset();
        DimBuf.SetRange("Dimension Code", DimCode);
        exit(not DimBuf.IsEmpty);
    end;

    local procedure RemovePaymentsAboveLimit(var PayableCustLedgEntry: Record "Payable Cust Ledger Entry FND"; RemainingAmtAvailable: Decimal);
    begin
        PayableCustLedgEntry.SetFilter("Amount (LCY)", '>%1', RemainingAmtAvailable);
        PayableCustLedgEntry.DeleteAll();
        PayableCustLedgEntry.SetRange("Amount (LCY)");
    end;

    local procedure InsertDimBuf(var DimBuf: Record "Dimension Buffer"; TableID: Integer; EntryNo: Integer; DimCode: Code[20]; DimValue: Code[20]);
    begin
        DimBuf.Init();
        DimBuf."Table ID" := TableID;
        DimBuf."Entry No." := EntryNo;
        DimBuf."Dimension Code" := DimCode;
        DimBuf."Dimension Value Code" := DimValue;
        DimBuf.Insert();
    end;

    local procedure GetMessageToRecipient(SummarizePerCust: Boolean): Text[140];
    begin
        if SummarizePerCust then
            exit(CompanyInformation.Name);
        exit(
          StrSubstNo(
            MessageToRecipientMsg,
            TempPaymentBuffer."Customer Ledg. Entry Doc. Type",
            TempPaymentBuffer."Applies-to Ext. Doc. No."));
    end;

    local procedure SetPostingDate(var GenJnlLine: Record "Gen. Journal Line"; DueDate: Date; PostingDate: Date): Boolean;
    begin
        if not UseDueDateAsPostingDate then begin
            GenJnlLine.Validate("Posting Date", PostingDate);
            exit(false);
        end;

        if DueDate = 0D then
            DueDate := GenJnlLine.GetAppliesToDocDueDate();
        exit(GenJnlLine.SetPostingDateAsDueDate(DueDate, DueDateOffset));
    end;

    local procedure GetApplDueDate(CustLedgEntryNo: Integer): Date;
    var
        AppliedCustLedgEntry: Record "Cust. Ledger Entry";
    begin
        if AppliedCustLedgEntry.Get(CustLedgEntryNo) then
            exit(AppliedCustLedgEntry."Due Date");

        exit(PostingDate);
    end;

    local procedure AdjustAgainstSelectedDim(var TempDimSetEntry: Record "Dimension Set Entry" temporary; var TempDimSetEntry2: Record "Dimension Set Entry" temporary): Boolean;
    begin
        if SelectedDim.FindSet() then begin
            repeat
                TempDimSetEntry.SetRange("Dimension Code", SelectedDim."Dimension Code");
                if TempDimSetEntry.FindFirst() then begin
                    TempDimSetEntry2.TransferFields(TempDimSetEntry, true);
                    TempDimSetEntry2.Insert();
                end;
            until SelectedDim.Next() = 0;
            exit(true);
        end;
        exit(false);
    end;

    local procedure SetTempPaymentBufferDims(var DimBuf: Record "Dimension Buffer");
    var
        GLSetup: Record "General Ledger Setup";
        EntryNo: Integer;
    begin
        if SummarizePerDim then begin
            DimBuf.Reset();
            DimBuf.DeleteAll();
            if SelectedDim.Find('-') then
                repeat
                    if DimSetEntry.Get(
                         CustLedgEntry."Dimension Set ID", SelectedDim."Dimension Code")
                    then
                        InsertDimBuf(DimBuf, Database::"Dimension Buffer", 0, DimSetEntry."Dimension Code",
                          DimSetEntry."Dimension Value Code");
                until SelectedDim.Next() = 0;
            EntryNo := DimBufMgt.FindDimensions(DimBuf);
            if EntryNo = 0 then
                EntryNo := DimBufMgt.InsertDimensions(DimBuf);
            TempPaymentBuffer."Dimension Entry No." := EntryNo;
            if TempPaymentBuffer."Dimension Entry No." <> 0 then begin
                GLSetup.Get();
                if DimCodeIsInDimBuf(GLSetup."Global Dimension 1 Code", DimBuf) then
                    TempPaymentBuffer."Global Dimension 1 Code" := CustLedgEntry."Global Dimension 1 Code"
                else
                    TempPaymentBuffer."Global Dimension 1 Code" := '';
                if DimCodeIsInDimBuf(GLSetup."Global Dimension 2 Code", DimBuf) then
                    TempPaymentBuffer."Global Dimension 2 Code" := CustLedgEntry."Global Dimension 2 Code"
                else
                    TempPaymentBuffer."Global Dimension 2 Code" := '';
            end else begin
                TempPaymentBuffer."Global Dimension 1 Code" := '';
                TempPaymentBuffer."Global Dimension 2 Code" := '';
            end;
            TempPaymentBuffer."Dimension Set ID" := CustLedgEntry."Dimension Set ID";
        end else begin
            TempPaymentBuffer."Dimension Entry No." := 0;
            TempPaymentBuffer."Global Dimension 1 Code" := '';
            TempPaymentBuffer."Global Dimension 2 Code" := '';
            TempPaymentBuffer."Dimension Set ID" := 0;
        end;
    end;

    local procedure IsEntryAlreadyApplied(GenJnlLine3: Record "Gen. Journal Line"; CustLedgEntry2: Record "Cust. Ledger Entry"): Boolean;
    var
        GenJnlLine4: Record "Gen. Journal Line";
    begin
        GenJnlLine4.SetRange("Journal Template Name", GenJnlLine3."Journal Template Name");
        GenJnlLine4.SetRange("Journal Batch Name", GenJnlLine3."Journal Batch Name");
        GenJnlLine4.SetRange("Account Type", GenJnlLine4."Account Type"::Customer);
        GenJnlLine4.SetRange("Account No.", CustLedgEntry2."Customer No.");
        GenJnlLine4.SetRange("Applies-to Doc. Type", CustLedgEntry2."Document Type");
        GenJnlLine4.SetRange("Applies-to Doc. No.", CustLedgEntry2."Document No.");
        exit(not GenJnlLine4.IsEmpty);
    end;

    local procedure SetDefaults();
    begin
        GenJnlBatch.Get(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
        GenJnlLine2."Bal. Account Type" := GenJnlBatch."Bal. Account Type";
        GenJnlLine2."Bal. Account No." := GenJnlBatch."Bal. Account No.";
    end;

    local procedure EvaluateIncStr(StringToIncrement: Code[20]; ErrorHint: Text)
    var
        UnincrementableStringError: Label '%1 contains no number and cannot be incremented.';
    begin
        IF INCSTR(StringToIncrement) = '' THEN
            ERROR(UnincrementableStringError, ErrorHint);
    end;
}

