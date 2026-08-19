page 51098 "Applied Entries CBN"
{
    // version HIT1.0,HEI1.00.07,EDD025,IBM 1001,HEI.02

    // HEI.01 CHG2094186 IBM BULIMC01 03.02.2020 #new page created to see the applied Entries
    // HEI.02 CHG2169924 IBM SISUM01  31/01/2023 #add to page fields Letter and Letter Date

    Caption = 'Applied Entries';
    DataCaptionExpression = Header;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    Permissions = TableData "G/L Entry" = rm,
                  TableData "G/L Entry Application Bffr FND" = rim;
    SourceTable = "G/L Entry Application Bffr FND";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
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
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
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
                    Visible = false;
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
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Prod. Order No. field.';
                }
                field("Entries Posted By"; Rec."Entries Posted By")
                {
                    ToolTip = 'Specifies the value of the Entries Posted By field.';
                }
                field(Positive; Rec.Positive)
                {
                    ToolTip = 'Specifies the value of the Positive field.';
                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies the value of the Reversed field.';
                }
                field(Comment; Rec.Comment)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Comment field.';
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
    end;

    var
        TempGLEntryBuf: Record "G/L Entry Application Bffr FND" temporary;
        TempGLEntryBuf2: Record "G/L Entry Application Bffr FND" temporary;
        Navigate: Page Navigate;
        AllowPartialApplication: Boolean;
        AuthorizedChange: Boolean;
        //GLEntryApplyPostedEntries: Codeunit "GLEntry-Apply Posted Entries"; //BC Upgrade KAPOOV01-Codeunit
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

    procedure SetAppliedEntries(OrgGLEntry: Record "G/L Entry") Found: Boolean;
    var
        GLEntry: Record "G/L Entry";
    begin
        if OrgGLEntry."Closed by Entry No. FND" <> 0 then begin
            FindGLEntry(OrgGLEntry);
            FindClosedGLEntry(OrgGLEntry);
            Found := true;
        end else begin
            if FindClosedGLEntry(OrgGLEntry) then
                Found := true;
        end;
    end;

    local procedure TransferGLEntry(var GLEntryBuf: Record "G/L Entry Application Bffr FND"; GLEntry: Record "G/L Entry");
    begin
        if not GLEntryBuf.GET(GLEntry."Entry No.") then begin
            GLEntryBuf.TRANSFERFIELDS(GLEntry);
            GLEntryBuf.Positive := GLEntry.Amount > 0;
            GLEntryBuf.Comment := GLEntry.Comment;
            GLEntryBuf.INSERT();
        end;
    end;

    local procedure FindClosedGLEntry(OrgGLEntry: Record "G/L Entry") Found: Boolean;
    var
        GLEntry: Record "G/L Entry";
    begin
        GLEntry.SETCURRENTKEY("Closed by Entry No. FND");
        GLEntry.SETRANGE("Closed by Entry No. FND", OrgGLEntry."Entry No.");
        if GLEntry.findset() then
            repeat
                if GLEntry."Entry No." <> OrgGLEntry."Entry No." then begin
                    TransferGLEntry(TempGLEntryBuf, GLEntry);
                    Found := true;
                end;
            until GLEntry.NEXT() = 0;
    end;

    local procedure FindGLEntry(OrgGLEntry: Record "G/L Entry");
    var
        GLEntry: Record "G/L Entry";
    begin
        GLEntry.GET(OrgGLEntry."Closed by Entry No. FND");
        TransferGLEntry(TempGLEntryBuf, GLEntry);
    end;
}

