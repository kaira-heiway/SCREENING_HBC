page 51010 "Apply Gen Ledger Entries CBN"
{
    // version HIT1.0,HEI1.00.07,EDD025,IBM 1001,HEI.15

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
    // 
    // HEI.01 FDD-HT667 IBM SURYAS01 12-07-2019
    //   # Added code in Apply Function -To block the application of GL entries related to not extracted periods
    // HEI.03 CHG2047407 IBM PANDES01 01/04/20
    //  # Added new Field "Entries Posted By".
    // HEI.04 CHG2047407 IBM PANDES01 28/04/20
    //  # Added Code Related to "Entries Posted By".
    // HEI.05 CHG2070961/CHG2088483 IBM POENAB02 31.07.2020 Panama -  Suspense account issue related to BI
    //  # Modified functions SetAllEntries, Undo
    //  # Added field Reversed in Repeated Group
    // HEI.06 CHG2065276 BULIMC01 IBM 29.09.2020
    //   #new field added to Repeated Group - "Comment"
    //   #new specific criteria added - "BComment"
    //   #paramter added to the page action "Automatic application"
    // HEI.07 Defect 6226 IBM BULIMC01 27/04/2021 #code added to "PostApplication" action to post all the selected entries with Applies-to id
    // HEI.08 CHG2114248 IBM BULIMC01 29/05/2021 #adjustments done in HEI.07
    // HEI.09 CHG2116048 IBM POENAB02 28/06/2021 Application issue for the GL
    //   # Code added in "Post Application" action
    // HEI.10 CHG2173019 IBM SISUM01 15/09/2022 #Change the page property SourceTableTemporary to Yes and the caption for followings controls:
    //   #ShowAmount,ShowAppliedAmount,BAmount,BRemmainingAmount,BExternalDocNo, BDocumentNo,BComment because there were several controls with the same caption and diff data type and for excel was confunsing
    // HEI.11 CHG2169924 IBM SISUM01 16/01/2023 #Add Letter and Letter Date
    //   #Add 2 new input paramters for functions UpdateTempTable and UpdateRealTable - LetterNoSeries and LetterDate
    // HEI.12 CHG2198381 IBM YADAVM05 20/04/2023 #Change in page property SourceTableTemporary to No
    //   #Applies to ID field not updated on selection of all entries
    // HEI.13 CHG2208499 - HB1699 IBM SRIVAS07 03.07.2023 - Enhancement to HB1057 to include FA
    //   # Added Code in Action - &Automatic application
    // HEI.14 CHG2208499 - HB1699 IBM SRIVAS07 11.07.2023 - Enhancement to HB1057 to include FA
    //   # Added Code in Action - &Automatic application
    // HEI.15 CHG2208499 - HB1699 IBM SRIVAS07 19.07.2023 - Enhancement to HB1057 to include FA
    //   # Added Code in Action - &Automatic application

    //--------------------------------------------------------------------------------------------
    //BC Upgrade KAPOOV01 18.12.2025 #Commented code related to French Localization fields.

    // BC Upgrade PATELP08 >>
    // # Replaced deprecated "with" statement in following 6 procedures with explicit record reference to prevent future compilation errors in BC.
    // # 1. Apply, 2. Undo, 3. SetApplId, 4. RealEntryChanged, 5. UpdateTempTable , 6. UpdateRealTable
    // BC Upgrade PATELP08 <<

    CaptionML = ENU = 'General Ledger Entries',
                FRB = 'Ecritures comptables',
                NLB = 'Grootboekposten';
    DataCaptionExpression = Header;
    PageType = List;
    Permissions = TableData "G/L Entry" = rm,
                  TableData "G/L Entry Application Bffr FND" = rim;
    SourceTable = "G/L Entry Application Bffr FND";
    SourceTableTemporary = false;
    ApplicationArea = All;

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
                    Caption = 'By Amount';
                    Editable = Option = Option::"Selection Criteria";
                    Enabled = AuthorizedChange;
                    ToolTip = 'Specifies the value of the By Amount field.';
                }
                field("BRemaining Amount"; BRemmainingAmount)
                {
                    Caption = 'By Remaining Amount';
                    Editable = Option = Option::"Selection Criteria";
                    Enabled = AuthorizedChange;
                    ToolTip = 'Specifies the value of the By Remaining Amount field.';
                }
                field("BDocument No"; BDocumentNo)
                {
                    Caption = 'By Document No';
                    Editable = Option = Option::"Selection Criteria";
                    Enabled = AuthorizedChange;
                    ToolTip = 'Specifies the value of the By Document No field.';
                }
                field("BExternal Doc No"; BExternalDocNo)
                {
                    Caption = 'By External Doc No';
                    Editable = Option = Option::"Selection Criteria";
                    Enabled = AuthorizedChange;
                    ToolTip = 'Specifies the value of the By External Doc No field.';
                }
                field(BComment; BComment)
                {
                    Caption = 'By Comment';
                    Editable = Option = Option::"Selection Criteria";
                    Enabled = AuthorizedChange;
                    ToolTip = 'Specifies the value of the By Comment field.';
                }
            }
            repeater(Control1)
            {
                Editable = false;
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the G/L Account No. field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field("Source Type"; Rec."Source Type")
                {
                    ToolTip = 'Specifies the value of the Source Type field.';
                }
                field("Source No."; Rec."Source No.")
                {
                    ToolTip = 'Specifies the value of the Source No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Job No."; Rec."Job No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Job No. field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field("Gen. Posting Type"; Rec."Gen. Posting Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Gen. Posting Type field.';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Debit Amount field.';
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Credit Amount field.';
                }
                field("Additional-Currency Amount"; Rec."Additional-Currency Amount")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Additional-Currency Amount field.';
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the VAT Amount field.';
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Bal. Account Type field.';
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Bal. Account No. field.';
                }
                field("User ID"; Rec."User ID")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Source Code"; Rec."Source Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Source Code field.';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Reason Code field.';
                }
                field("FA Entry Type"; Rec."FA Entry Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the FA Entry Type field.';
                }
                field("FA Entry No."; Rec."FA Entry No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the FA Entry No. field.';
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ToolTip = 'Specifies the value of the Remaining Amount field.';
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ToolTip = 'Specifies the value of the Applies-to ID field.';
                }
                field(Open; Rec.Open)
                {
                    ToolTip = 'Specifies the value of the Open field.';
                }
                field("Closed by Entry No."; Rec."Closed by Entry No.")
                {
                    ToolTip = 'Specifies the value of the Closed by Entry No. field.';
                }
                field("Closed at Date"; Rec."Closed at Date")
                {
                    ToolTip = 'Specifies the value of the Closed at Date field.';
                }
                field("Closed by Amount"; Rec."Closed by Amount")
                {
                    ToolTip = 'Specifies the value of the Closed by Amount field.';
                }
                field(Letter; Rec.Letter)
                {
                    ToolTip = 'Specifies the value of the Letter field.';
                }
                field("Letter Date"; Rec."Letter Date")
                {
                    ToolTip = 'Specifies the value of the Letter Date field.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Prod. Order No. field.';
                }
                field("Entries Posted By"; Rec."Entries Posted By")
                {
                    ToolTip = 'Specifies the value of the Entries Posted By field.';
                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies the value of the Reversed field.';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                }
            }

            group(Control02)
            {
                Editable = false;
                ShowCaption = false;

                field(ShowAmount; ShowAmount)
                {
                    AutoFormatType = 1;
                    CaptionML = ENU = 'Show Amount',
                                FRB = 'Montant',
                                NLB = 'Bedrag';
                    Editable = false;
                    ToolTip = 'Specifies the value of the ShowAmount field.';
                }
                field(ShowAppliedAmount; ShowAppliedAmount)
                {
                    AutoFormatType = 1;
                    CaptionML = ENU = 'Show Applied Amount',
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
                        if GLEntry.GET(Rec."Entry No.") then
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
                    ShortCutKey = 'F7';
                    Promoted = true;
                    PromotedCategory = Process;
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
                    ShortCutKey = 'F9';
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Post Application action.';

                    trigger OnAction();
                    begin
                        //HEI.09>>
                        /*
                        //HEI.07>>
                        TempGLEntryBuf3.RESET;
                        TempGLEntryBuf3.DELETEALL;
                        
                        TempGLEntryBuf.RESET;
                        TempGLEntryBuf.SETFILTER("Applies-to ID",'<>%1','');
                        //TempGLEntryBuf.SETFILTER(Amount,'>%1',0); //HEI.08 commented
                        IF TempGLEntryBuf.findset THEN REPEAT
                         // IF NOT TempGLEntryBuf3.GET(TempGLEntryBuf."Entry No.") THEN BEGIN //HEI.08 commented
                          //HEI.08<<
                          TempGLEntryBuf3.RESET;
                          TempGLEntryBuf3.SETRANGE("Applies-to ID",TempGLEntryBuf."Applies-to ID");
                          IF NOT TempGLEntryBuf3.FINDFIRST THEN BEGIN
                          //HEI.08>>
                            TempGLEntryBuf3.TRANSFERFIELDS(TempGLEntryBuf);
                            TempGLEntryBuf3.INSERT;
                          end;
                        UNTIL TempGLEntryBuf.NEXT = 0;
                        
                        
                        TempGLEntryBuf3.RESET;
                        CurrPage.SETSELECTIONFILTER(TempGLEntryBuf3);
                        IF TempGLEntryBuf3.findset THEN REPEAT
                        //HEI.07<<
                          // TempGLEntryBuf.COPY(Rec); //HEI.07 commented
                          TempGLEntryBuf.COPY(TempGLEntryBuf3); //HEI.07
                          Apply(TempGLEntryBuf);
                        UNTIL TempGLEntryBuf3.NEXT = 0; //HEI.07
                        */
                        //HEI.09<<

                        //HEI.09>>
                        TempGLEntryBuf.RESET();
                        TempGLEntryBuf.SETFILTER("Applies-to ID", '<>%1', '');
                        if TempGLEntryBuf.FINDFIRST() then
                            repeat
                                TempGLEntryBuf3.RESET();
                                TempGLEntryBuf3.SETRANGE("Applies-to ID", TempGLEntryBuf."Applies-to ID");
                                if not TempGLEntryBuf3.FINDFIRST() then begin
                                    TempGLEntryBuf3.TRANSFERFIELDS(TempGLEntryBuf);
                                    if TempGLEntryBuf3.INSERT() then;
                                end;
                            until TempGLEntryBuf.NEXT() = 0;

                        if TempGLEntryBuf3.COUNT = 1 then begin
                            TempGLEntryBuf.COPY(Rec);
                            Apply(TempGLEntryBuf);
                        end;

                        if TempGLEntryBuf3.COUNT > 1 then
                            repeat
                                TempGLEntryBuf.RESET();
                                TempGLEntryBuf.COPY(TempGLEntryBuf3);
                                Apply(TempGLEntryBuf);
                            until TempGLEntryBuf3.NEXT() = 0;
                        //HEI.09<<

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
                        TempGLEntryBuf1: Record "G/L Entry Application Bffr FND" temporary;
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
                            6://HEI.13>>
                                begin
                                    TempGLEntryBuf1.COPY(TempGLEntryBuf, true); //HEI.14
                                    GLEntryApplyPostedEntries."SetApplyIDWithGR/IRAccountsPayable"(TempGLEntryBuf);
                                    GLEntryApplyPostedEntries.SetApplyIDWithGRIRAccountsPayableFA(TempGLEntryBuf1); //HEI.14
                                end;
                            //HEI.13<<
                            // 7: GLEntryApplyPostedEntries.SetApplyIDWithSepcialCriteria(TempGLEntryBuf,BAmount,BRemmainingAmount,BDocumentNo,BExternalDocNo); HEI.06 commented
                            7:
                                GLEntryApplyPostedEntries.SetApplyIDWithSepcialCriteria(TempGLEntryBuf, BAmount, BRemmainingAmount, BDocumentNo, BExternalDocNo, BComment); //HEI.06
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
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the &Navigate action.';

                    trigger OnAction();
                    begin
                        Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
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
            BComment := GLAcc."Same Comment FND"; //HEI.06
            AuthorizedChange := GLAcc."Authorize other App. Modes FND";
            //<<FDD-HNK-Auto Clear HNK 10/10/16
        end;
        CurrPage.CAPTION := DynamicCaption;
        SetIncludeEntryFilter();
        GLSetup.GET(); //HEI.11
    end;

    var
        TempGLEntryBuf: Record "G/L Entry Application Bffr FND" temporary;
        TempGLEntryBuf2: Record "G/L Entry Application Bffr FND" temporary;
        TempGLEntryBuf3: Record "G/L Entry Application Bffr FND" temporary;
        GLSetup: Record "General Ledger Setup";
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
        //GLABPage: Page "DDE Interface Setup";
        Text50000: Label 'You cannot undo application for G/L entry No. %1 because the entry has already been reversed!';
        TXT50000: Label 'Partial application  isn''t allowed';
        TXT50001: Label 'You cannot apply the G/L entries because the final reporting isn''t extracted yet.';
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

    // BC Upgrade PATELP08 >> # Replaced deprecated "with" statement with explicit record reference to prevent future compilation errors in BC.
    procedure Apply(var GLEntryBuf: Record "G/L Entry Application Bffr FND");
    var
        AccountingPeriod: Record "Accounting Period";
        GLEntry: Record "G/L Entry";
        GLEntryBufBalanced: Record "G/L Entry Application Bffr FND" temporary;
        GeneralLedSetup: Record "General Ledger Setup";
        //NoSeriesMgt: Codeunit NoSeriesManagement;  // BC Upgrade NANDIS03 - Blocked
        NoSeriesMgt: Codeunit "No. Series";  // BC Upgrade NANDIS03 - Blocked
        LetterDate: Date;
        AppliedAmount: Decimal;
        RemainingAmount: Decimal;
        TotalAppliedAmount: Decimal;
        TotalBalanced: Decimal;
        BaseEntryNo: Integer;
        LoopReturn: Integer;
        LetterNoSeries: Text[20];
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

                //>>HEI.01  12-07-2019
                GeneralLedSetup.GET();
                if GeneralLedSetup."Final Reporting Extracted FND" = true then begin
                    if AccountingPeriod.GET(CALCDATE('<CM+1D-2M>', TODAY)) and (not AccountingPeriod."Final Reporting Extracted FND") then begin
                        ERROR(TXT50001);
                    end;
                end;
                //<<HEI.01  12-07-2019

                TotalBalanced += GLEntryBufBalanced."Remaining Amount";
            until GLEntryBufBalanced.NEXT() = 0;
        end;
        if (not AllowPartialApplication) and (TotalBalanced <> 0) then
            ERROR(TXT50000);
        //<<FDD-HNK-Auto Clear HNK 10/10/16

        //HEI.11>>
        GLSetup.TESTFIELD("G/L Application No. Series FND");
        LetterNoSeries := NoSeriesMgt.GetNextNo(GLSetup."G/L Application No. Series FND", TODAY(), true);
        LetterDate := TODAY();
        //HEI.11<<

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
                //HEI.11>>
                /*
                UpdateTempTable(GLEntryBuf,0,FALSE,BaseEntryNo,"Posting Date",-AppliedAmount,'');
                UpdateRealTable(GLEntry,0,FALSE,BaseEntryNo,"Posting Date",-AppliedAmount,'');
                */
                UpdateTempTable(GLEntryBuf, 0, false, BaseEntryNo, Rec."Posting Date", -AppliedAmount, '', LetterNoSeries, LetterDate);
                UpdateRealTable(GLEntry, 0, false, BaseEntryNo, Rec."Posting Date", -AppliedAmount, '', LetterNoSeries, LetterDate);
            //HEI.11<<
            until GLEntryBuf.NEXT() = 0;
        end else
            exit;

        // Update entry where cursor is on
        // Update real Table

        // BC Upgrade PATELP08 >> # Replaced deprecated "with" statement with explicit record reference to prevent future compilation errors in BC.
        // with GLEntry do begin
        //     GET(BaseEntryNo);
        //     //HEI.11>>
        //     /*
        //     UpdateRealTable(
        //       GLEntry,"Remaining Amount" - TotalAppliedAmount,
        //       ("Remaining Amount" - TotalAppliedAmount) <> 0,0,0D,0,'');
        //     */
        //     UpdateRealTable(
        //       GLEntry, "Remaining Amount" - TotalAppliedAmount,
        //       ("Remaining Amount" - TotalAppliedAmount) <> 0, 0, 0D, 0, '', LetterNoSeries, LetterDate);
        //     //HEI.11<<
        // end;

        GLEntry.GET(BaseEntryNo);
        UpdateRealTable(
            GLEntry, GLEntry."Remaining Amount FND" - TotalAppliedAmount,
            (GLEntry."Remaining Amount FND" - TotalAppliedAmount) <> 0, 0, 0D, 0, '', LetterNoSeries, LetterDate);
        // BC Upgrade PATELP08 >>

        // Update Temporary Table

        // BC Upgrade PATELP08 >> # Replaced deprecated "with" statement with explicit record reference to prevent future compilation errors in BC.
        // with TempGLEntryBuf do begin
        //     GET(BaseEntryNo);
        //     //HEI.11>>
        //     /*
        //     UpdateTempTable(
        //       TempGLEntryBuf,"Remaining Amount" - TotalAppliedAmount,
        //       ("Remaining Amount" - TotalAppliedAmount) <> 0,0,0D,0,'');
        //     */
        //     UpdateTempTable(
        //       TempGLEntryBuf, "Remaining Amount" - TotalAppliedAmount,
        //       ("Remaining Amount" - TotalAppliedAmount) <> 0, 0, 0D, 0, '', LetterNoSeries, LetterDate);
        //     //HEI.11<<
        // end;

        TempGLEntryBuf.GET(BaseEntryNo);
        UpdateTempTable(
            TempGLEntryBuf, TempGLEntryBuf."Remaining Amount" - TotalAppliedAmount,
            (TempGLEntryBuf."Remaining Amount" - TotalAppliedAmount) <> 0, 0, 0D, 0, '', LetterNoSeries, LetterDate);
        // BC Upgrade PATELP08 >>

        ShowTotalAppliedAmount := 0;

    end;
    // BC Upgrade PATELP08 >>

    // BC Upgrade PATELP08 >> # Replaced deprecated "with" statement with explicit record reference to prevent future compilation errors in BC.
    procedure Undo(var GLEntryBuf: Record "G/L Entry Application Bffr FND");
    var
        GLEntry: Record "G/L Entry";
        OrgGLEntry: Record "G/L Entry";
        UndoGLEntry: Record "G/L Entry";
        BaseEntryNo: Integer;
    begin
        // 'Real' G/L Entry changed whilst undoing ?
        RealEntryChanged(GLEntryBuf, GLEntry);
        // BC Upgrade PATELP08 >> # Replaced deprecated "with" statement with explicit record reference to prevent future compilation errors in BC.
        // with GLEntryBuf do begin
        //     RESET();
        //     //HEI.05>>
        //     if ((GLEntryBuf.Open = false) and (GLEntryBuf."Remaining Amount" = 0) and (GLEntryBuf.Reversed = true)) then
        //         ERROR(Text50000, GLEntryBuf."Entry No.");
        //     if (GLEntryBuf.Reversed = true) then
        //         ERROR(Text50000, GLEntryBuf."Entry No.");
        //     //HEI.05<<
        //     if GLEntryBuf."Closed by Entry No." <> 0 then begin
        //         OrgGLEntry.GET(GLEntryBuf."Closed by Entry No.");
        //         OrgGLEntry.TESTFIELD("Closed by Entry No.", 0);
        //     end else
        //         OrgGLEntry.GET(GLEntryBuf."Entry No.");
        //     BaseEntryNo := OrgGLEntry."Entry No.";

        //     UndoGLEntry.SETCURRENTKEY("Closed by Entry No.");
        //     UndoGLEntry.SETRANGE("Closed by Entry No.", OrgGLEntry."Entry No.");
        //     if UndoGLEntry.findset() then
        //         repeat
        //             RealEntryChanged(GLEntryBuf, GLEntry);
        //             if GLEntryBuf.GET(UndoGLEntry."Entry No.") then
        //                 //HEI.11>>
        //                 //UpdateTempTable(GLEntryBuf,GLEntryBuf."Closed by Amount",TRUE,0,0D,0,'');
        //                 UpdateTempTable(GLEntryBuf, GLEntryBuf."Closed by Amount", true, 0, 0D, 0, '', '', 0D);
        //             //HEI.11<<

        //             //HEI.11>>
        //             //UpdateRealTable(UndoGLEntry,UndoGLEntry."Closed by Amount",TRUE,0,0D,0,'');
        //             UpdateRealTable(UndoGLEntry, UndoGLEntry."Closed by Amount", true, 0, 0D, 0, '', '', 0D);
        //         //HEI.11<<
        //         until UndoGLEntry.NEXT() = 0;

        //     GLEntry.GET(BaseEntryNo);
        //     //HEI.11>>
        //     //UpdateRealTable(GLEntry,GLEntry.Amount,TRUE,0,0D,0,'');
        //     UpdateRealTable(GLEntry, GLEntry.Amount, true, 0, 0D, 0, '', '', 0D);
        //     //HEI.11<<

        //     if TempGLEntryBuf.GET(BaseEntryNo) then
        //         //HEI.11>>
        //         //UpdateTempTable(TempGLEntryBuf,TempGLEntryBuf.Amount,TRUE,0,0D,0,'');
        //         UpdateTempTable(TempGLEntryBuf, TempGLEntryBuf.Amount, true, 0, 0D, 0, '', '', 0D);
        //     //HEI.11<<
        //     SETRANGE("Closed by Entry No.");
        //     SETCURRENTKEY("G/L Account No.", "Posting Date", "Entry No.", Open);
        // end;

        GLEntryBuf.RESET();

        if ((GLEntryBuf.Open = false) and (GLEntryBuf."Remaining Amount" = 0) and (GLEntryBuf.Reversed = true)) then
            ERROR(Text50000, GLEntryBuf."Entry No.");
        if (GLEntryBuf.Reversed = true) then
            ERROR(Text50000, GLEntryBuf."Entry No.");

        if GLEntryBuf."Closed by Entry No." <> 0 then begin
            OrgGLEntry.GET(GLEntryBuf."Closed by Entry No.");
            OrgGLEntry.TESTFIELD("Closed by Entry No. FND", 0);
        end else
            OrgGLEntry.GET(GLEntryBuf."Entry No.");

        BaseEntryNo := OrgGLEntry."Entry No.";

        UndoGLEntry.SETCURRENTKEY("Closed by Entry No. FND");
        UndoGLEntry.SETRANGE("Closed by Entry No. FND", OrgGLEntry."Entry No.");

        if UndoGLEntry.FINDSET() then
            repeat
                RealEntryChanged(GLEntryBuf, GLEntry);

                if GLEntryBuf.GET(UndoGLEntry."Entry No.") then
                    UpdateTempTable(GLEntryBuf, GLEntryBuf."Closed by Amount", true, 0, 0D, 0, '', '', 0D);
                UpdateRealTable(UndoGLEntry, UndoGLEntry."Closed by Amount FND", true, 0, 0D, 0, '', '', 0D);

            until UndoGLEntry.NEXT() = 0;

        GLEntry.GET(BaseEntryNo);
        UpdateRealTable(GLEntry, GLEntry.Amount, true, 0, 0D, 0, '', '', 0D);
        if TempGLEntryBuf.GET(BaseEntryNo) then
            UpdateTempTable(TempGLEntryBuf, TempGLEntryBuf.Amount, true, 0, 0D, 0, '', '', 0D);

        GLEntryBuf.SETRANGE("Closed by Entry No.");
        GLEntryBuf.SETCURRENTKEY("G/L Account No.", "Posting Date", "Entry No.", Open);
    end;
    // BC Upgrade PATELP08 <<
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
        GLEntry.SETCURRENTKEY("G/L Account No.");
        GLEntry.SETRANGE("G/L Account No.", GLAccNo);
        //>>HEI:RWA260114:1:1
        GLEntry.SETFILTER("Posting Date", PostingDateFilter);
        //<<HEI:RWA260114:1:1
        //>>HEI:301844:1:1
        //HEI.05>>
        //GLEntry.SETRANGE(Reversed,FALSE);
        //HEI.05<<
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
        Rec.SETCURRENTKEY(Rec."G/L Account No.", Rec."Posting Date", Rec."Entry No.", Rec.Open);
        Rec.SETRANGE(Open, true);
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
        Rec.SETCURRENTKEY(Rec."Closed by Entry No.");
        IncludeEntryFilter := IncludeEntryFilter::All;
    end;

    procedure SetIncludeEntryFilter();
    begin
        Rec.SETCURRENTKEY("G/L Account No.", "Posting Date", "Entry No.", Open);
        case IncludeEntryFilter of
            IncludeEntryFilter::All:
                Rec.SETRANGE(Open);
            IncludeEntryFilter::Open:
                Rec.SETRANGE(Open, true);
            IncludeEntryFilter::Closed:
                Rec.SETRANGE(Open, false);
        end;
    end;

    procedure UpdateAmounts();
    begin
        ShowAppliedAmount := 0;
        ShowAmount := 0;
        if Rec."Applies-to ID" <> '' then begin
            ShowAmount := TempGLEntryBuf."Remaining Amount";
            ShowAppliedAmount := ShowTotalAppliedAmount - TempGLEntryBuf."Remaining Amount";
        end;
    end;

    // BC Upgrade PATELP08 >> # Replaced deprecated "with" statement with explicit record reference to prevent future compilation errors in BC.
    procedure RealEntryChanged(TempEntry: Record "G/L Entry Application Bffr FND"; var GlEntry: Record "G/L Entry");
    begin
        // 'Real' G/L Entry changed whilst application ?
        // BC Upgrade PATELP08 >> # Replaced deprecated "with" statement with explicit record reference to prevent future compilation errors in BC.
        // with GlEntry do begin
        //     LOCKTABLE();
        //     GET(TempEntry."Entry No.");
        //     if ("Remaining Amount" <> TempEntry."Remaining Amount") or
        //        (Open <> TempEntry.Open) or
        //        ("Closed by Entry No." <> TempEntry."Closed by Entry No.") or
        //        ("Closed at Date" <> TempEntry."Closed at Date") or
        //        ("Closed by Amount" <> TempEntry."Closed by Amount")
        //      then
        //         ERROR(Text11301, GlEntry.TABLECAPTION);
        // end;

        GlEntry.LOCKTABLE();
        GlEntry.GET(TempEntry."Entry No.");

        if (GlEntry."Remaining Amount FND" <> TempEntry."Remaining Amount") or
           (GlEntry."Open FND" <> TempEntry.Open) or
           (GlEntry."Closed by Entry No. FND" <> TempEntry."Closed by Entry No.") or
           (GlEntry."Closed at Date FND" <> TempEntry."Closed at Date") or
           (GlEntry."Closed by Amount FND" <> TempEntry."Closed by Amount")
         then
            ERROR(Text11301, GlEntry.TABLECAPTION);
        // BC Upgrade PATELP08 <<
    end;
    // BC Upgrade PATELP08 <<

    // BC Upgrade PATELP08 >> # Replaced deprecated "with" statement with explicit record reference to prevent future compilation errors in BC.
    procedure UpdateTempTable(var TempEntry: Record "G/L Entry Application Bffr FND"; RemainingAmt: Decimal; IsOpen: Boolean; ClosedbyEntryNo: Integer; ClosedbyDate: Date; ClosedbyAmt: Decimal; AppliesToID: Code[50]; LetterNoSeries: Text[20]; LetterDate: Date);
    begin
        // Update Temporary Table
        // BC Upgrade PATELP08 >> # Replaced deprecated "with" statement with explicit record reference to prevent future compilation errors in BC.
        // with TempEntry do begin
        //     "Remaining Amount" := RemainingAmt;
        //     Open := IsOpen;
        //     "Closed by Entry No." := ClosedbyEntryNo;
        //     "Closed at Date" := ClosedbyDate;
        //     "Closed by Amount" := ClosedbyAmt;
        //     "Applies-to ID" := AppliesToID;
        //     "Entries Posted By" := USERID; //HEI.04
        //     //HEI.11>>
        //     Letter := LetterNoSeries;
        //     "Letter Date" := LetterDate;
        //     //HEI.11<<
        //     MODIFY();
        // end;

        TempEntry."Remaining Amount" := RemainingAmt;
        TempEntry.Open := IsOpen;
        TempEntry."Closed by Entry No." := ClosedbyEntryNo;
        TempEntry."Closed at Date" := ClosedbyDate;
        TempEntry."Closed by Amount" := ClosedbyAmt;
        TempEntry."Applies-to ID" := AppliesToID;
        TempEntry."Entries Posted By" := USERID;
        TempEntry.Letter := LetterNoSeries;
        TempEntry."Letter Date" := LetterDate;
        TempEntry.MODIFY();
        // BC Upgrade PATELP08 <<
    end;
    // BC Upgrade PATELP08 <<

    // BC Upgrade PATELP08 >> # Replaced deprecated "with" statement with explicit record reference to prevent future compilation errors in BC.
    procedure UpdateRealTable(RealEntry: Record "G/L Entry"; RemainingAmt: Decimal; IsOpen: Boolean; ClosedbyEntryNo: Integer; ClosedbyDate: Date; ClosedbyAmt: Decimal; AppliesToID: Code[50]; LetterNoSeries: Text[20]; LetterDate: Date);
    begin
        // Update Temporary Table
        // BC Upgrade PATELP08 >> # Replaced deprecated "with" statement with explicit record reference to prevent future compilation errors in BC.
        // with RealEntry do begin
        //     "Remaining Amount" := RemainingAmt;
        //     Open := IsOpen;
        //     "Closed by Entry No." := ClosedbyEntryNo;
        //     "Closed at Date" := ClosedbyDate;
        //     "Closed by Amount" := ClosedbyAmt;
        //     "Applies-to ID" := AppliesToID;
        //     "Entries Posted By" := USERID; //HEI.04

        //     //BC Upgrade KAPOOV01 >>French Localization fields 
        //     //HEI.11>> 
        //     // Letter := LetterNoSeries;
        //     // "Letter Date" := LetterDate;
        //     //HEI.11<<
        //     // end;
        //     //BC Upgrade KAPOOV01 <<French Localization fields 
        //     MODIFY();
        // end;

        RealEntry."Remaining Amount FND" := RemainingAmt;
        RealEntry."Open FND" := IsOpen;
        RealEntry."Closed by Entry No. FND" := ClosedbyEntryNo;
        RealEntry."Closed at Date FND" := ClosedbyDate;
        RealEntry."Closed by Amount FND" := ClosedbyAmt;
        RealEntry."Applies-to ID FND" := AppliesToID;
        RealEntry."Entries Posted By FND" := USERID; //HEI.04

        //BC Upgrade KAPOOV01 >>French Localization fields 
        //HEI.11>> 
        // RealEntry.Letter := LetterNoSeries;
        // RealEntry."Letter Date" := LetterDate;
        //HEI.11<<
        //BC Upgrade KAPOOV01 <<French Localization fields 

        // BC FR Upgrade KAIRAR01 -Added Letter & Letter Date in General_NonFR>>
        //HEI.11>> 
        RealEntry.LetterFND := LetterNoSeries;
        RealEntry."Letter Date FND" := LetterDate;
        //HEI.11<<
        // BC FR Upgrade KAIRAR01 -Added in General_NonFR<<
        RealEntry.MODIFY();

        // BC Upgrade PATELP08 <<
    end;
    // BC Upgrade PATELP08 <<
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
        GLEntryBuf.Comment := GLEntry.Comment; //HEI.06
        GLEntryBuf.INSERT();
    end;

    procedure SetDateFilter(p_PostingDateFilter: Text[100]);
    begin
        //>>HEI:RWA260114:1:1
        PostingDateFilter := p_PostingDateFilter;
        //<<HEI:RWA260114:1:1
    end;
}

