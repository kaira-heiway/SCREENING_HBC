report 55031 "Reopen Closed G/L Entries"
{
    // version HEI.01

    // HEI.01 CHG2277569 SAHAL01 06.02.2025 Not able to apply Entries
    //   # Created New Report: 50606 - Reopen Closed G/L Entries

    //Bc Upgrade YADAVM09 Old ID-50606

    Caption = 'Reopen Closed G/L Entries';
    Permissions = TableData "G/L Entry" = rm;
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;//Bc Upgrade YADAVM09

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("Entry No.") ORDER(Ascending) WHERE("Open FND" = CONST(false), "Remaining Amount FND" = FILTER(<> 0));
            RequestFilterFields = "Entry No.", "Document No.";
            //ReqFilterHeading = 'Filter Options';//Bc Upgrade YADAVM09<<

            trigger OnAfterGetRecord();
            var
                GLEntryL: Record "G/L Entry";
                FoundEntryL: Boolean;
            begin
                //HEI.01>>
                TESTFIELD("G/L Account No.");
                if "Closed by Entry No. FND" <> 0 then begin
                    GLEntryL.SETCURRENTKEY("G/L Account No.", "Open FND", "Entry No.");
                    GLEntryL.SETRANGE("G/L Account No.", "G/L Account No.");
                    GLEntryL.SETRANGE("Open FND", false);
                    GLEntryL.SETRANGE("Entry No.", "Closed by Entry No. FND");
                    if GLEntryL.FINDSET(false) then begin
                        repeat
                            UpdateAppliedGLEntry(GLEntryL."Entry No.", "Entry No.", GLEntryL."Entry No.");
                        until GLEntryL.NEXT = 0;
                    end;
                end else begin
                    GLEntryL.SETCURRENTKEY("G/L Account No.", "Open FND", "Closed by Entry No. FND");
                    GLEntryL.SETRANGE("G/L Account No.", "G/L Account No.");
                    GLEntryL.SETRANGE("Open FND", false);
                    GLEntryL.SETRANGE("Closed by Entry No. FND", "Entry No.");
                    if GLEntryL.FINDSET(false) then begin
                        repeat
                            UpdateAppliedGLEntry(GLEntryL."Entry No.", "Entry No.", GLEntryL."Entry No.");
                            if not FoundEntryL then
                                FoundEntryL := true;
                        until GLEntryL.NEXT = 0;
                    end;

                    if not FoundEntryL then begin
                        GLEntryL.RESET;
                        GLEntryL.SETCURRENTKEY("G/L Account No.", "Open FND", "Transaction No.");
                        GLEntryL.SETRANGE("G/L Account No.", "G/L Account No.");
                        GLEntryL.SETRANGE("Open FND", false);
                        GLEntryL.SETRANGE("Transaction No.", "Transaction No.");
                        if GLEntryL.FINDSET(false) then begin
                            repeat
                                UpdateAppliedGLEntry(GLEntryL."Entry No.", "Entry No.", GLEntryL."Entry No.");
                            until GLEntryL.NEXT = 0;
                        end;
                    end;
                end;

                UpdateAppliedGLEntry("Entry No.", "Entry No.", 0);
                Counter += 1;
                if not Updated and (Counter = 1) then
                    Updated := true;

                if ShowMsg then begin
                    if Counter >= NoOfRecProgress then begin
                        NoOfProgresed := NoOfProgresed + Counter;
                        ProgressWindow.UPDATE(1, ROUND(NoOfProgresed / NoOfRecords * 10000, 1));
                    end;
                end;
                //HEI.01<<
            end;

            trigger OnPreDataItem();
            begin
                //HEI.01>>
                CLEAR(Counter);
                CLEAR(NoOfProgresed);

                if ShowMsg then begin
                    NoOfRecords := COUNT;
                    NoOfRecProgress := NoOfRecords div 100;
                end;
                //HEI.01<<
            end;
        }
    }

    requestpage
    {
        Caption = 'Reopen Closed G/L Entries';
        SaveValues = false;

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

    trigger OnPostReport();
    begin
        //HEI.01>>
        if ShowMsg then begin
            ProgressWindow.CLOSE;
            if Updated then
                MESSAGE(Text003)
            else
                MESSAGE(Text004);
        end;
        //HEI.01<<
    end;

    trigger OnPreReport();
    begin
        //HEI.01>>
        User.SETCURRENTKEY("User Name");
        User.SETRANGE("User Name", USERID);
        User.FINDFIRST;
        UserSetup.GET(USERID);
        if not UserSetup."Allow to Reopen G/L Entry FND" then
            ERROR(Text000);

        if "G/L Entry".GETFILTERS = '' then
            ERROR(Text001);

        if GUIALLOWED then begin
            ShowMsg := true;
            ProgressWindow.OPEN(Text002);
        end;
        //HEI.01<<
    end;

    var
        User: Record User;
        UserSetup: Record "User Setup";
        ShowMsg: Boolean;
        ProgressWindow: Dialog;
        Updated: Boolean;
        Text000: Label 'You don''t have the permission to execute this report.';
        Text001: Label 'Please apply at least one filter on the Filter Options.';
        Counter: Integer;
        NoOfRecords: Integer;
        NoOfRecProgress: Integer;
        NoOfProgresed: Integer;
        Text002: Label '"G/L Entries..       @1@@@@@@@@@@@ "';
        Text003: Label 'G/L Entries have been successfully updated.';
        Text004: Label 'There is no G/L Entry within the filters. No update done.';

    local procedure UpdateAppliedGLEntry(var EntryNo: Integer; var ParentNo: Integer; ChildNo: Integer);
    var
        GLEntryL: Record "G/L Entry";
        GLUpdateLogL: Record "G/L Update Log RTR";
    begin
        //HEI.01>>
        GLEntryL.GET(EntryNo);

        GLUpdateLogL.INIT;
        GLUpdateLogL."Parent G/L Entry No." := ParentNo;
        GLUpdateLogL."Child G/L Entry No." := ChildNo;
        GLUpdateLogL."Posting Date" := GLEntryL."Posting Date";
        GLUpdateLogL.Amount := GLEntryL.Amount;
        GLUpdateLogL.Open := GLEntryL."Open FND";
        GLUpdateLogL."Remaining Amount" := GLEntryL."Remaining Amount FND";
        GLUpdateLogL."Closed by Entry No." := GLEntryL."Closed by Entry No. FND";
        GLUpdateLogL."Closed at Date" := GLEntryL."Closed at Date FND";
        GLUpdateLogL."Closed by Amount" := GLEntryL."Closed by Amount FND";
        GLUpdateLogL.Reversed := GLEntryL.Reversed;
        GLUpdateLogL."Reversed by Entry No." := GLEntryL."Reversed by Entry No.";
        GLUpdateLogL."Reversed Entry No." := GLEntryL."Reversed Entry No.";
        GLUpdateLogL.INSERT(true);

        GLEntryL."Open FND" := true;
        if GLEntryL."Remaining Amount FND" <> GLEntryL.Amount then
            GLEntryL."Remaining Amount FND" := GLEntryL.Amount;
        GLEntryL."Closed by Entry No. FND" := 0;
        GLEntryL."Closed at Date FND" := 0D;
        GLEntryL."Closed by Amount FND" := 0;
        GLEntryL.Reversed := false;
        GLEntryL."Reversed by Entry No." := 0;
        GLEntryL."Reversed Entry No." := 0;
        GLEntryL.MODIFY(false);
        //HEI.01<<
    end;
}

