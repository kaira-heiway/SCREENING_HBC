page 51011 "Apply Gen Ledger Entries_1 CBN"
{
    // version HEI.02

    // HEI:RWA260114:1:1 27/07/11 NJ
    //   # Added code to consider Posting Date filter while opening Application form
    // HEI:301844:1:1 01-10-12 DM
    //   # Filter added to Skip reversed Entries
    // 
    // HEI:EDD025:1:1 25/09/14 TECTURA.HKH
    //  # G/L Entry Application
    // 
    // HEI:CHG0147132:1:1 09/11/16 IBM
    //   # FDD-HNK-Auto Clear HNK 10/10/16
    //     : Added filterd Under "Option" Group
    //     : Added Action Button "Automatic Application"
    // HEI.01 Defect #747 IBM NASTAA02 20.12.2017 # HeiMatch Export Inv. & Balance
    //   # Replaced field "Remaining Amount." with "Remaining Amount"
    // HEI.02 CHG2133239 BHANDS01 11-17-2021
    //   # Added code for BComment on OnOpenPage() to resolve compilation error
    //   # Added parameter in function GLEntryApplyPostedEntries.SetApplyIDWithSepcialCriteria() on Action1100710008 to resolve compilation error


    // BC Upgrade MISHRS14 >>
    // Blocked with statement and prefixed variables with GLEntry, TempEntry, RealEntry, TempGLEntryBuf, GlEntry, GLEntryBuf
    // BC Upgrade MISHRS14 <<

    CaptionML = ENU = 'General Ledger Entries',
                FRB = 'Ecritures comptables',
                NLB = 'Grootboekposten';
    DataCaptionExpression = Header;
    PageType = List;
    Permissions = TableData "G/L Entry" = rm;
    // TableData TableData80024 = rim;//BC Upgrade Manisha Code commented for table 80024 not found in Q
    SourceTable = "G/L Entry Application Bffr FND";
    ApplicationArea = All;  // BC Upgrade Manisha
    UsageCategory = Administration;  // BC Upgrade Manisha

    layout
    {
        area(content)
        {
            group(Options)
            {
                CaptionML = ENU = 'Options',
                            FRB = 'Options',
                            NLB = 'Opties';
                field(IncludeEntryFilter; IncludeEntryFilter)
                {
                    CaptionML = ENU = 'Include Entries',
                                FRB = 'Inclure écritures',
                                NLB = 'Posten opnemen';
                    OptionCaptionML = ENU = 'All,Open,Closed',
                                      FRB = 'Toutes,Ouvertes,Clôturées',
                                      NLB = 'Alle,Open,Afgesloten';
                    ToolTip = 'Specifies the value of the IncludeEntryFilter field.';

                    trigger OnValidate();
                    begin
                        SetIncludeEntryFilter();
                        CurrPage.UPDATE();
                    end;
                }
                field("<Option>"; Option)
                {
                    CaptionML = ENU = 'Option',
                                FRB = 'Option',
                                NLB = 'Posten opnemen';
                    Editable = AuthorizedChange;
                    ToolTip = 'Specifies the value of the Option field.';
                }
                field(AllowPartialApplication; AllowPartialApplication)
                {
                    Caption = 'Allow Partial Application';
                    ToolTip = 'Specifies the value of the Allow Partial Application field.';
                }
            }
            group("Specific criteria")
            {
                field(BAmount; BAmount)
                {
                    Caption = 'Amount';
                    Editable = Option = Option::"Selection Criteria";
                    Enabled = AuthorizedChange;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("BRemaining Amount"; BRemmainingAmount)
                {
                    Caption = 'Remaining Amount';
                    Editable = Option = Option::"Selection Criteria";
                    Enabled = AuthorizedChange;
                    ToolTip = 'Specifies the value of the Remaining Amount field.';
                }
                field("BDocument No"; BDocumentNo)
                {
                    Caption = 'Document No';
                    Editable = Option = Option::"Selection Criteria";
                    Enabled = AuthorizedChange;
                    ToolTip = 'Specifies the value of the Document No field.';
                }
                field("BExternal Doc No"; BExternalDocNo)
                {
                    Caption = 'External Doc No';
                    Editable = Option = Option::"Selection Criteria";
                    Enabled = AuthorizedChange;
                    ToolTip = 'Specifies the value of the External Doc No field.';
                }
            }
            repeater(Control1)
            {
                Editable = false;
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ToolTip = 'Specifies the value of the Applies-to ID field.';
                }
                field("Posting Date"; REC."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Document Type"; REC."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Document No."; REC."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("G/L Account No."; REC."G/L Account No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the G/L Account No. field.';
                }
                field("External Document No."; REC."External Document No.")
                {
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field(Description; REC.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Job No."; REC."Job No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Job No. field.';
                }
                field("Global Dimension 1 Code"; REC."Global Dimension 1 Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; REC."Global Dimension 2 Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field("Gen. Posting Type"; REC."Gen. Posting Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Gen. Posting Type field.';
                }
                field("Gen. Bus. Posting Group"; REC."Gen. Bus. Posting Group")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.';
                }
                field("Gen. Prod. Posting Group"; REC."Gen. Prod. Posting Group")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
                }
                field(Amount; REC.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Debit Amount"; REC."Debit Amount")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Debit Amount field.';
                }
                field("Credit Amount"; REC."Credit Amount")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Credit Amount field.';
                }
                field("Additional-Currency Amount"; REC."Additional-Currency Amount")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Additional-Currency Amount field.';
                }
                field("VAT Amount"; REC."VAT Amount")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the VAT Amount field.';
                }
                field("Bal. Account Type"; REC."Bal. Account Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Bal. Account Type field.';
                }
                field("Bal. Account No."; REC."Bal. Account No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Bal. Account No. field.';
                }
                field("User ID"; REC."User ID")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Source Code"; REC."Source Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Source Code field.';
                }
                field("Reason Code"; REC."Reason Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Reason Code field.';
                }
                field("FA Entry Type"; REC."FA Entry Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the FA Entry Type field.';
                }
                field("FA Entry No."; REC."FA Entry No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the FA Entry No. field.';
                }
                field("Remaining Amount"; REC."Remaining Amount")
                {
                    ToolTip = 'Specifies the value of the Remaining Amount field.';
                }
                field(Open; REC.Open)
                {
                    ToolTip = 'Specifies the value of the Open field.';
                }
                field("Closed by Entry No."; REC."Closed by Entry No.")
                {
                    ToolTip = 'Specifies the value of the Closed by Entry No. field.';
                }
                field("Closed at Date"; REC."Closed at Date")
                {
                    ToolTip = 'Specifies the value of the Closed at Date field.';
                }
                field("Closed by Amount"; REC."Closed by Amount")
                {
                    ToolTip = 'Specifies the value of the Closed by Amount field.';
                }
                field("Entry No."; REC."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Prod. Order No."; REC."Prod. Order No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Prod. Order No. field.';
                }
            }
            group(Control1010001)
            {
                Editable = false;
                field(ShowAmount; ShowAmount)
                {
                    AutoFormatType = 1;
                    CaptionML = ENU = 'Amount',
                                FRB = 'Montant',
                                NLB = 'Bedrag';
                    Editable = false;
                    ToolTip = 'Specifies the value of the ShowAmount field.';
                }
                field(ShowAppliedAmount; ShowAppliedAmount)
                {
                    AutoFormatType = 1;
                    CaptionML = ENU = 'Applied Amount',
                                FRB = 'Montant lettré',
                                NLB = 'Vereffend bedrag';
                    Editable = false;
                    ToolTip = 'Specifies the value of the ShowAppliedAmount field.';
                }
                field(ShowTotalAppliedAmount; ShowTotalAppliedAmount)
                {
                    AutoFormatType = 1;
                    CaptionML = ENU = 'Balance',
                                FRB = 'Solde',
                                NLB = 'Saldo';
                    Editable = false;
                    ToolTip = 'Specifies the value of the ShowTotalAppliedAmount field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ent&ry")
            {
                CaptionML = ENU = 'Ent&ry',
                            FRB = 'E&criture',
                            NLB = '&Post';
                action(Dimensions)
                {
                    CaptionML = ENU = 'Dimensions',
                                FRB = 'Axes analytiques',
                                NLB = 'Dimensies';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Executes the Dimensions action.';

                    trigger OnAction();
                    var
                        GLEntry: Record "G/L Entry";
                    begin
                        if GLEntry.GET(REC."Entry No.") then
                            GLEntry.ShowDimensions();
                    end;
                }
            }
            group("&Application")
            {
                CaptionML = ENU = '&Application',
                            FRB = '&Lettrage',
                            NLB = 'V&ereffening';
                action("Set Applies-to ID")
                {
                    CaptionML = ENU = 'Set Applies-to ID',
                                FRB = 'Lettrer',
                                NLB = 'ID toekennen';
                    Image = SelectLineToApply;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ToolTip = 'Executes the Set Applies-to ID action.';

                    trigger OnAction();
                    begin
                        TempGLEntryBuf.COPY(Rec);
                        CurrPage.SETSELECTIONFILTER(TempGLEntryBuf);
                        SetApplId(TempGLEntryBuf);
                    end;
                }
                action("Post Application")
                {
                    CaptionML = ENU = 'Post Application',
                                FRB = 'Valider le lettrage',
                                NLB = 'Vereffening boeken';
                    Image = PostApplication;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F9';
                    ToolTip = 'Executes the Post Application action.';

                    trigger OnAction();
                    begin
                        TempGLEntryBuf.COPY(Rec);
                        Apply(TempGLEntryBuf);
                    end;
                }
                action("&Undo Application")
                {
                    CaptionML = ENU = '&Undo Application',
                                FRB = '&Annuler le lettrage',
                                NLB = 'V&ereffening ongedaan maken';
                    Image = Undo;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the &Undo Application action.';

                    trigger OnAction();
                    begin
                        TempGLEntryBuf.COPY(Rec);
                        CurrPage.SETSELECTIONFILTER(TempGLEntryBuf);
                        Undo(TempGLEntryBuf);
                    end;
                }
                action("&Automatic application")
                {
                    CaptionML = ENU = '&Automatic application',
                                FRA = '<Action1010003>',
                                FRB = '&Lettrage automatique';
                    Image = ApplyTemplate;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the &Automatic application action.';

                    trigger OnAction();
                    var
                        GLAccount: Record "G/L Account";
                    begin

                        //<<FDD-HNK-Auto Clear HNK 10/10/16
                        // ,Purchase Prepayment,Sales Prepayment,AR Control Account,AP Control Account,GS/IS Accounts Receivable,GR/IR Accounts Payable,Selection Criteria,Default Automatic Application Mode
                        if Option = Option::"Default Automatic Application Mode" then begin
                            GLAccount.RESET();
                            GLAccount.GET(TempGLEntryBuf."G/L Account No.");
                            GLAccount.TESTFIELD("Automatic application mode FND");
                            Option := GLAccount."Automatic application mode FND";
                        end;

                        case Option of
                            1:
                                GLEntryApplyPostedEntries.SetApplyIDWithPremaymentPurchaseInvoice(TempGLEntryBuf);
                            2:
                                GLEntryApplyPostedEntries.SetApplyIDWithPremaymentSalesInvoice(TempGLEntryBuf);
                            3:
                                GLEntryApplyPostedEntries.SetApplyIDCustomerEntry(TempGLEntryBuf);
                            4:
                                GLEntryApplyPostedEntries.SetApplyIDVendorEntry(TempGLEntryBuf);
                            5:
                                GLEntryApplyPostedEntries."SetApplyIDWithGR/IRAccountsReceiveble"(TempGLEntryBuf);
                            6:
                                GLEntryApplyPostedEntries."SetApplyIDWithGR/IRAccountsPayable"(TempGLEntryBuf);
                            // HEI.02 >>
                            //  7: GLEntryApplyPostedEntries.SetApplyIDWithSepcialCriteria(TempGLEntryBuf,BAmount,BRemmainingAmount,BDocumentNo,BExternalDocNo);
                            7:
                                GLEntryApplyPostedEntries.SetApplyIDWithSepcialCriteria(TempGLEntryBuf, BAmount, BRemmainingAmount, BDocumentNo, BExternalDocNo, BComment);
                            // HEI.02 <<
                            else
                                ERROR(Text11306);
                        end;
                        //<<FDD-HNK-Auto Clear HNK 10/10/16
                    end;
                }
            }
            group(ActionGroup1100710000)
            {
                action("&Navigate")
                {
                    CaptionML = ENU = '&Navigate',
                                FRB = 'Na&viguer',
                                NLB = '&Navigeren';
                    Image = Navigate;
                    ToolTip = 'Executes the &Navigate action.';

                    trigger OnAction();
                    begin
                        Navigate.SetDoc(Rec."Posting Date", REC."Document No.");
                        Navigate.RUN();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        UpdateAmounts();
    end;

    trigger OnFindRecord(Which: Text): Boolean;
    var
        Found: Boolean;
    begin
        TempGLEntryBuf.COPY(Rec);
        Found := TempGLEntryBuf.FIND(Which);
        if Found then
            Rec := TempGLEntryBuf;
        exit(Found);
    end;

    trigger OnNextRecord(Steps: Integer): Integer;
    var
        ResultSteps: Integer;
    begin
        TempGLEntryBuf.COPY(Rec);
        ResultSteps := TempGLEntryBuf.NEXT(Steps);
        if ResultSteps <> 0 then
            Rec := TempGLEntryBuf;
        exit(ResultSteps);
    end;

    trigger OnOpenPage();
    var
        GLAcc: Record "G/L Account";
        OriginalEntry: Record "G/L Entry";
    begin
        if TempGLEntryBuf."G/L Account No." <> '' then begin
            GLAcc.GET(TempGLEntryBuf."G/L Account No.");
            Header := GLAcc."No." + ' ' + GLAcc.Name;
            //<<FDD-HNK-Auto Clear HNK 10/10/16
            Option := GLAcc."Automatic application mode FND";
            BAmount := GLAcc."Same Amount FND";
            BRemmainingAmount := GLAcc."Same Remaining Amount FND";
            BDocumentNo := GLAcc."Same Document No. FND";
            BExternalDocNo := GLAcc."Same External Document No. FND";
            AuthorizedChange := GLAcc."Authorize other App. Modes FND";
            BComment := GLAcc."Same Comment FND";        // HEI.02 >>
                                                         //<<FDD-HNK-Auto Clear HNK 10/10/16
        end;
        CurrPage.CAPTION := DynamicCaption;
        SetIncludeEntryFilter();
    end;

    var
        TempGLEntryBuf: Record "G/L Entry Application Bffr FND" temporary;
        TempGLEntryBuf2: Record "G/L Entry Application Bffr FND" temporary;
        GLEntryApplyPostedEntries: Codeunit "GLEntry Apply Posted Entr. CBN";
        Navigate: Page Navigate;
        AllowPartialApplication: Boolean;
        AuthorizedChange: Boolean;
        BAmount: Boolean;
        BComment: Boolean;
        BDocumentNo: Boolean;
        BExternalDocNo: Boolean;
        BRemmainingAmount: Boolean;
        GLEntryApplID: Code[50];
        ShowAmount: Decimal;
        ShowAppliedAmount: Decimal;
        ShowTotalAppliedAmount: Decimal;
        Text11306: Label 'Option must have a value !';
        TXT50000: Label 'Partial application  isn''t allowed';
        Option: Option " ","Purchase Prepayment","Sales Prepayment","AR Control Account","AP Control Account","GS/IS Accounts Receivable","GR/IR Accounts Payable","Selection Criteria","Default Automatic Application Mode";
        IncludeEntryFilter: Option All,Open,Closed;
        DateFilter: Text[30];
        DynamicCaption: Text[100];
        PostingDateFilter: Text[100];
        Header: Text[250];
        Text11300: TextConst ENU = 'Preparing Entries      @1@@@@@@@@@@@@@', FRB = 'Préparation des écr.   @1@@@@@@@@@@@@@', NLB = 'Voorbereiden posten    @1@@@@@@@@@@@@@';
        Text11301: TextConst ENU = 'Another user has modified the record for this %1 after you retrieved it from the database.', FRB = 'Un autre utilisateur a modifié l''enregistrement de cette %1 alors que vous étiez en train de travailler dessus.', NLB = 'Een andere gebruiker heeft de record voor deze %1 gewijzigd nadat u het in de database hebt opgevraagd.';
        Text11302: TextConst ENU = 'Apply General Ledger Entries', FRB = 'Lettrer écritures comptables', NLB = 'Grootboekposten vereffenen';
        Text11303: TextConst ENU = 'Applied General Ledger Entries', FRB = 'Ecritures comptables lettrées', NLB = 'Vereffende grootboekposten';
        Text11304: TextConst ENU = 'You can apply multiple entries only if all entries being applied can be fully closed.', FRB = 'Vous ne pouvez lettrer plusieurs écritures que si toutes les écritures lettrées peuvent être entièrement clôturées.', NLB = 'U kunt alleen meerdere posten vereffenen als alle vereffende posten volledig kunnen worden gesloten.';
        Text11305: TextConst ENU = 'There are no general ledger entries to apply', FRB = 'Il n''y a aucune écriture comptable à lettrer', NLB = 'Er zijn grootboekposten te vereffenen';

    procedure Apply(var GLEntryBuf: Record "G/L Entry Application Bffr FND");
    var
        GLEntry: Record "G/L Entry";
        GLEntryBufBalanced: Record "G/L Entry Application Bffr FND" temporary;
        AppliedAmount: Decimal;
        RemainingAmount: Decimal;
        TotalAppliedAmount: Decimal;
        TotalBalanced: Decimal;
        BaseEntryNo: Integer;
    begin
        GLEntryBuf.TESTFIELD("Applies-to ID");
        BaseEntryNo := TempGLEntryBuf."Entry No.";
        RemainingAmount := GLEntryBuf."Remaining Amount";

        RealEntryChanged(TempGLEntryBuf, GLEntry);
        //<<FDD-HNK-Auto Clear HNK 10/10/16
        TotalBalanced := 0;
        GLEntryBufBalanced.COPY(GLEntryBuf, true);
        GLEntryBufBalanced.SETCURRENTKEY("Applies-to ID");
        GLEntryBufBalanced.SETRANGE("Applies-to ID", GLEntryBuf."Applies-to ID");
        if GLEntryBufBalanced.findset() then begin
            repeat
                TotalBalanced += GLEntryBufBalanced."Remaining Amount";
            until GLEntryBufBalanced.NEXT() = 0;
        end;
        if (not AllowPartialApplication) and (TotalBalanced <> 0) then
            ERROR(TXT50000);
        //<<FDD-HNK-Auto Clear HNK 10/10/16

        GLEntryBuf.SETCURRENTKEY("Applies-to ID");
        GLEntryBuf.SETRANGE("Applies-to ID", GLEntryBuf."Applies-to ID");
        GLEntryBuf.SETFILTER("Entry No.", '<> %1', GLEntryBuf."Entry No.");
        if GLEntryBuf.FIND('-') then begin
            repeat
                GLEntryBuf.TESTFIELD("G/L Account No.", GLEntryBuf."G/L Account No.");
                GLEntryBuf.TESTFIELD(Open, true);
                AppliedAmount := -GLEntryBuf."Remaining Amount";
                TotalAppliedAmount := TotalAppliedAmount + AppliedAmount;
                RealEntryChanged(GLEntryBuf, GLEntry);
                UpdateTempTable(GLEntryBuf, 0, false, BaseEntryNo, REC."Posting Date", -AppliedAmount, '');
                UpdateRealTable(GLEntry, 0, false, BaseEntryNo, REC."Posting Date", -AppliedAmount, '');
            until GLEntryBuf.NEXT() = 0;
        end else
            exit;

        // Update entry where cursor is on
        // Update real Table

        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variables with GLEntry 
        // with GLEntry do begin
        //     GET(BaseEntryNo);
        //     UpdateRealTable(
        //       GLEntry, "Remaining Amount" - TotalAppliedAmount,  //HEI.01
        //       ("Remaining Amount" - TotalAppliedAmount) <> 0, 0, 0D, 0, '');  //HEI.01
        // end;

        //with GLEntry do begin
        GLEntry.GET(BaseEntryNo);
        UpdateRealTable(
          GLEntry, GLEntry."Remaining Amount FND" - TotalAppliedAmount,  //HEI.01
          (GLEntry."Remaining Amount FND" - TotalAppliedAmount) <> 0, 0, 0D, 0, '');  //HEI.01
                                                                                  //end;
                                                                                  // BC Upgrade MISHRS14 <<

        // Update Temporary Table

        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variables with TempGLEntryBuf
        // with TempGLEntryBuf do begin
        //     GET(BaseEntryNo);
        //     UpdateTempTable(
        //       TempGLEntryBuf, "Remaining Amount" - TotalAppliedAmount,
        //       ("Remaining Amount" - TotalAppliedAmount) <> 0, 0, 0D, 0, '');
        // end;
        //with TempGLEntryBuf do begin
        TempGLEntryBuf.GET(BaseEntryNo);
        UpdateTempTable(
          TempGLEntryBuf, TempGLEntryBuf."Remaining Amount" - TotalAppliedAmount,
          (TempGLEntryBuf."Remaining Amount" - TotalAppliedAmount) <> 0, 0, 0D, 0, '');
        //end;
        // BC Upgrade MISHRS14 <<

        ShowTotalAppliedAmount := 0;
    end;

    procedure Undo(var GLEntryBuf: Record "G/L Entry Application Bffr FND");
    var
        GLEntry: Record "G/L Entry";
        OrgGLEntry: Record "G/L Entry";
        UndoGLEntry: Record "G/L Entry";
        BaseEntryNo: Integer;
    begin
        // 'Real' G/L Entry changed whilst undoing ?
        RealEntryChanged(GLEntryBuf, GLEntry);

        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variables with GLEntryBuf
        // with GLEntryBuf do begin
        GLEntryBuf.RESET();
        if GLEntryBuf."Closed by Entry No." <> 0 then begin
            OrgGLEntry.GET(GLEntryBuf."Closed by Entry No.");
            OrgGLEntry.TESTFIELD("Closed by Entry No. FND", 0);
        end else
            OrgGLEntry.GET(GLEntryBuf."Entry No.");
        BaseEntryNo := OrgGLEntry."Entry No.";

        UndoGLEntry.SETCURRENTKEY("Closed by Entry No. FND");
        UndoGLEntry.SETRANGE("Closed by Entry No. FND", OrgGLEntry."Entry No.");
        if UndoGLEntry.findset() then
            repeat
                RealEntryChanged(GLEntryBuf, GLEntry);
                if GLEntryBuf.GET(UndoGLEntry."Entry No.") then
                    UpdateTempTable(GLEntryBuf, GLEntryBuf."Closed by Amount", true, 0, 0D, 0, '');
                UpdateRealTable(UndoGLEntry, UndoGLEntry."Closed by Amount FND", true, 0, 0D, 0, '');
            until UndoGLEntry.NEXT() = 0;

        GLEntry.GET(BaseEntryNo);
        UpdateRealTable(GLEntry, GLEntry.Amount, true, 0, 0D, 0, '');
        if TempGLEntryBuf.GET(BaseEntryNo) then
            UpdateTempTable(TempGLEntryBuf, TempGLEntryBuf.Amount, true, 0, 0D, 0, '');

        //     SETRANGE("Closed by Entry No.");
        //     SETCURRENTKEY("G/L Account No.", "Posting Date", "Entry No.", Open);
        GLEntryBuf.SETRANGE("Closed by Entry No.");
        GLEntryBuf.SETCURRENTKEY("G/L Account No.", "Posting Date", "Entry No.", Open);
        //end;
        // BC Upgrade MISHRS14 <<

    end;

    procedure SetApplId(var GLEntryBuf: Record "G/L Entry Application Bffr FND");
    begin
        GLEntryBuf.TESTFIELD(Open, true);
        if GLEntryBuf.FIND('-') then begin
            // Make Applies-to ID
            if GLEntryBuf."Applies-to ID" <> '' then begin
                GLEntryApplID := '';
                ShowTotalAppliedAmount := ShowTotalAppliedAmount - GLEntryBuf."Remaining Amount";
            end else begin
                GLEntryApplID := USERID;
                if GLEntryApplID = '' then
                    GLEntryApplID := '***';
                ShowTotalAppliedAmount := ShowTotalAppliedAmount + GLEntryBuf."Remaining Amount";
            end;

            // Set Applies-to ID
            repeat
                GLEntryBuf.TESTFIELD(Open, true);
                GLEntryBuf."Applies-to ID" := GLEntryApplID;
                GLEntryBuf.MODIFY();
            until GLEntryBuf.NEXT() = 0;
        end;
    end;

    procedure SetAllEntries(GLAccNo: Code[20]);
    var
        GLEntry: Record "G/L Entry";
        Window: Dialog;
        LineCount: Integer;
        NoOfRecords: Integer;
    begin
        GLEntry.SETCURRENTKEY("G/L Account No.", "Posting Date");
        GLEntry.SETRANGE("G/L Account No.", GLAccNo);
        //>>HEI:RWA260114:1:1
        GLEntry.SETFILTER("Posting Date", PostingDateFilter);
        //<<HEI:RWA260114:1:1
        //>>HEI:301844:1:1
        GLEntry.SETRANGE(Reversed, false);
        //<<HEI:301844:1:1
        if GLEntry.FIND('-') then begin
            NoOfRecords := GLEntry.COUNT;
            Window.OPEN(Text11300);
            repeat
                TransferGLEntry(TempGLEntryBuf, GLEntry);
                LineCount := LineCount + 1;
                Window.UPDATE(1, ROUND(LineCount / NoOfRecords * 10000, 1));
            until GLEntry.NEXT() = 0;
            Window.CLOSE();
        end;

        DynamicCaption := Text11302;

        // By default only show open entries when applying
        REC.SETCURRENTKEY("G/L Account No.", "Posting Date", "Entry No.", Open);
        REC.SETRANGE(Open, true);
        IncludeEntryFilter := IncludeEntryFilter::Open;
    end;

    procedure SetAppliedEntries(OrgGLEntry: Record "G/L Entry");
    var
        GLEntry: Record "G/L Entry";
    begin
        if OrgGLEntry."Closed by Entry No. FND" <> 0 then begin
            GLEntry.GET(OrgGLEntry."Closed by Entry No. FND");
            TransferGLEntry(TempGLEntryBuf, GLEntry);
        end else begin
            GLEntry.SETCURRENTKEY("Closed by Entry No. FND");
            GLEntry.SETRANGE("Closed by Entry No. FND", OrgGLEntry."Entry No.");
            if GLEntry.findset() then
                repeat
                    if GLEntry."Entry No." <> OrgGLEntry."Entry No." then
                        TransferGLEntry(TempGLEntryBuf, GLEntry);
                until GLEntry.NEXT() = 0;
        end;

        DynamicCaption := Text11303;

        // By default only show open entries when applying
        REC.SETCURRENTKEY("Closed by Entry No.");
        IncludeEntryFilter := IncludeEntryFilter::All;
    end;

    procedure SetIncludeEntryFilter();
    begin
        Rec.SETCURRENTKEY("G/L Account No.", "Posting Date", "Entry No.", Open);
        case IncludeEntryFilter of
            IncludeEntryFilter::All:
                REC.SETRANGE(Open);
            IncludeEntryFilter::Open:
                REC.SETRANGE(Open, true);
            IncludeEntryFilter::Closed:
                REC.SETRANGE(Open, false);
        end;
    end;

    procedure UpdateAmounts();
    begin
        ShowAppliedAmount := 0;
        ShowAmount := 0;
        if REC."Applies-to ID" <> '' then begin
            ShowAmount := TempGLEntryBuf."Remaining Amount";
            ShowAppliedAmount := ShowTotalAppliedAmount - TempGLEntryBuf."Remaining Amount";
        end;
    end;

    procedure RealEntryChanged(TempEntry: Record "G/L Entry Application Bffr FND"; var GlEntry: Record "G/L Entry");
    begin
        // 'Real' G/L Entry changed whilst application ?

        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variables with GlEntry 
        // with GlEntry do begin
        //     LOCKTABLE();
        //     GET(TempEntry."Entry No.");
        //     if ("Remaining Amount" <> TempEntry."Remaining Amount") or  //HEI.01
        //        (Open <> TempEntry.Open) or
        //        ("Closed by Entry No." <> TempEntry."Closed by Entry No.") or
        //        ("Closed at Date" <> TempEntry."Closed at Date") or
        //        ("Closed by Amount" <> TempEntry."Closed by Amount")
        //      then
        //         ERROR(Text11301, GlEntry.TABLECAPTION);
        // end;

        //with GlEntry do begin
        GlEntry.LOCKTABLE();
        GlEntry.GET(TempEntry."Entry No.");
        if (GlEntry."Remaining Amount FND" <> TempEntry."Remaining Amount") or  //HEI.01
           (GlEntry."Open FND" <> TempEntry.Open) or
           (GlEntry."Closed by Entry No. FND" <> TempEntry."Closed by Entry No.") or
           (GlEntry."Closed at Date FND" <> TempEntry."Closed at Date") or
           (GlEntry."Closed by Amount FND" <> TempEntry."Closed by Amount")
         then
            ERROR(Text11301, GlEntry.TABLECAPTION);
        //end;
        // BC Upgrade MISHRS14 <<
    end;

    procedure UpdateTempTable(var TempEntry: Record "G/L Entry Application Bffr FND"; RemainingAmt: Decimal; IsOpen: Boolean; ClosedbyEntryNo: Integer; ClosedbyDate: Date; ClosedbyAmt: Decimal; AppliesToID: Code[50]);
    begin
        // Update Temporary Table

        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variables with TempEntry
        // with TempEntry do begin
        //     "Remaining Amount" := RemainingAmt;
        //     Open := IsOpen;
        //     "Closed by Entry No." := ClosedbyEntryNo;
        //     "Closed at Date" := ClosedbyDate;
        //     "Closed by Amount" := ClosedbyAmt;
        //     "Applies-to ID" := AppliesToID;
        //     MODIFY();
        // end;

        //with TempEntry do begin
        TempEntry."Remaining Amount" := RemainingAmt;
        TempEntry.Open := IsOpen;
        TempEntry."Closed by Entry No." := ClosedbyEntryNo;
        TempEntry."Closed at Date" := ClosedbyDate;
        TempEntry."Closed by Amount" := ClosedbyAmt;
        TempEntry."Applies-to ID" := AppliesToID;
        TempEntry.MODIFY();
        //end;
        // BC Upgrade MISHRS14 <<
    end;

    procedure UpdateRealTable(RealEntry: Record "G/L Entry"; RemainingAmt: Decimal; IsOpen: Boolean; ClosedbyEntryNo: Integer; ClosedbyDate: Date; ClosedbyAmt: Decimal; AppliesToID: Code[50]);
    begin
        // Update Temporary Table

        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variables with RealEntry
        // with RealEntry do begin
        //     "Remaining Amount" := RemainingAmt;  //HEI.01
        //     Open := IsOpen;
        //     "Closed by Entry No." := ClosedbyEntryNo;
        //     "Closed at Date" := ClosedbyDate;
        //     "Closed by Amount" := ClosedbyAmt;
        //     "Applies-to ID" := AppliesToID;
        //     MODIFY();
        // end;

        //with RealEntry do begin
        RealEntry."Remaining Amount FND" := RemainingAmt;  //HEI.01
        RealEntry."Open FND" := IsOpen;
        RealEntry."Closed by Entry No. FND" := ClosedbyEntryNo;
        RealEntry."Closed at Date FND" := ClosedbyDate;
        RealEntry."Closed by Amount FND" := ClosedbyAmt;
        RealEntry."Applies-to ID FND" := AppliesToID;
        RealEntry.MODIFY();
        //end;
        // BC Upgrade MISHRS14 <<
    end;

    procedure DemoDataTool();
    var
        Stop: Boolean;
        tmpAmt: Decimal;
        Window: Dialog;
    begin
        Window.OPEN('Applying G/L Ledger Entries');

        SetAllEntries('452000');
        TempGLEntryBuf.SETRANGE("Global Dimension 1 Code", '');
        TempGLEntryBuf.SETRANGE(Open, true);

        if TempGLEntryBuf.findset() then
            repeat
                TempGLEntryBuf2 := TempGLEntryBuf;
                TempGLEntryBuf2.INSERT();
            until TempGLEntryBuf.NEXT() = 0;

        if TempGLEntryBuf.findset() then
            repeat
                tmpAmt := TempGLEntryBuf.Amount;
                if TempGLEntryBuf2.findset() then
                    repeat
                        if TempGLEntryBuf2.Amount = -tmpAmt then
                            Stop := true;
                    until (TempGLEntryBuf2.NEXT() = 0) or (Stop = true);
            until (TempGLEntryBuf.NEXT() = 0) or (Stop = true);

        // setApplID
        if Stop = true then begin
            TempGLEntryBuf.SETRANGE(Amount, tmpAmt);
            SetApplId(TempGLEntryBuf);
            TempGLEntryBuf.SETRANGE(Amount);

            TempGLEntryBuf.SETRANGE(Amount, -tmpAmt);
            SetApplId(TempGLEntryBuf);
            TempGLEntryBuf.SETRANGE(Amount);

            // Appl
            Apply(TempGLEntryBuf);
        end;

        Window.CLOSE();
    end;

    local procedure IncludeEntryFilterOnAfterValid();
    begin
        CurrPage.UPDATE(false);
    end;

    local procedure TransferGLEntry(var GLEntryBuf: Record "G/L Entry Application Bffr FND"; GLEntry: Record "G/L Entry");
    begin
        GLEntryBuf.TRANSFERFIELDS(GLEntry);
        GLEntryBuf.Positive := GLEntry.Amount > 0;
        GLEntryBuf.INSERT();
    end;

    procedure SetDateFilter(p_PostingDateFilter: Text[100]);
    begin
        //>>HEI:RWA260114:1:1
        PostingDateFilter := p_PostingDateFilter;
        //<<HEI:RWA260114:1:1
    end;
}

