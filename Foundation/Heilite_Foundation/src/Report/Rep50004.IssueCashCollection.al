report 50004 "Issue Cash Collection"
{
    // version NAVW110.0

    // HEI.01 FDD OTCGAP022 Heilite BASE IBM ISYED01 28/06/2017
    //   # Cash Collection order

    Caption = 'Issue Cash Collection';
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Cash Collection Header FND"; "Cash Collection Header FND")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Cash Collection';

            trigger OnAfterGetRecord();
            begin
                //HEI.01>>
                RecordNo := RecordNo + 1;
                CLEAR(IssuedCashCollectionHeader);
                CashCollectionIssue.Set("Cash Collection Header FND", ReplacePostingDate, PostingDateReq);
                if NoOfRecords = 1 then begin
                    CashCollectionIssue.RUN();
                    MARK := false;
                end else begin
                    NewTime := TIME;
                    if (NewTime - OldTime > 100) or (NewTime < OldTime) then begin
                        NewProgress := ROUND(RecordNo / NoOfRecords * 100, 1);
                        if NewProgress <> OldProgress then begin
                            Window.UPDATE(1, NewProgress * 100);
                            OldProgress := NewProgress;
                        end;
                        OldTime := TIME;
                    end;
                    COMMIT();
                    MARK := not CashCollectionIssue.RUN();
                end;

                if PrintDoc <> PrintDoc::" " then begin
                    CashCollectionIssue.GetIssuedReminder(IssuedCashCollectionHeader);
                    TempIssuedCashCollectionHeader := IssuedCashCollectionHeader;
                    TempIssuedCashCollectionHeader.INSERT();
                end;
                //HEI.01>>
            end;

            trigger OnPostDataItem();
            var
                IssuedCashCollectionHeaderPrint: Record "Issue Cash Collection Head FND";
            begin
                //HEI.01>>
                Window.CLOSE();
                COMMIT();
                if PrintDoc <> PrintDoc::" " then
                    if TempIssuedCashCollectionHeader.findset() then
                        repeat
                            IssuedCashCollectionHeaderPrint := TempIssuedCashCollectionHeader;
                            IssuedCashCollectionHeaderPrint.SETRECFILTER();
                            // IssuedCashCollectionHeaderPrint.PrintRecords(false, PrintDoc = PrintDoc::Email, HideDialog);//BC UPGRADE KUMARR78 --01-07-2026
                            IssuedCashCollectionHeaderPrint.NewPrintRecords(false, PrintDoc = PrintDoc::Email, HideDialog);//BC UPGRADE KUMARR78 ++01-07-2026
                        until TempIssuedCashCollectionHeader.NEXT() = 0;
                MARKEDONLY := true;
                if FIND('-') then
                    if CONFIRM(Text003, true) then
                        PAGE.RUNMODAL(0, "Cash Collection Header FND");
                //HEI.01>
            end;

            trigger OnPreDataItem();
            begin
                if ReplacePostingDate and (PostingDateReq = 0D) then
                    ERROR(Text000);
                NoOfRecords := COUNT;
                if NoOfRecords = 1 then
                    Window.OPEN(Text001)
                else begin
                    Window.OPEN(Text002);
                    OldTime := TIME;
                end;
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
                    field(PrintDoc; PrintDoc)
                    {
                        Caption = 'Print';
                        Enabled = NOT IsOfficeAddin;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Print field.';
                    }
                    field(ReplacePostingDate; ReplacePostingDate)
                    {
                        Caption = 'Replace Posting Date';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Replace Posting Date field.';
                    }
                    field(PostingDateReq; PostingDateReq)
                    {
                        Caption = 'Posting Date';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Posting Date field.';
                    }
                    field(HideEmailDialog; HideDialog)
                    {
                        Caption = 'Hide Email Dialog';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Hide Email Dialog field.';
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
    }

    trigger OnInitReport();
    var
        OfficeMgt: Codeunit "Office Management";
    begin
        IsOfficeAddin := OfficeMgt.IsAvailable();
        if IsOfficeAddin then
            PrintDoc := 2;
    end;

    var
        IssuedCashCollectionHeader: Record "Issue Cash Collection Head FND";
        TempIssuedCashCollectionHeader: Record "Issue Cash Collection Head FND" temporary;
        CashCollectionIssue: Codeunit "Cash Collection-Issue";
        HideDialog: Boolean;

        IsOfficeAddin: Boolean;
        ReplacePostingDate: Boolean;
        PostingDateReq: Date;
        Window: Dialog;
        NewProgress: Integer;
        NoOfRecords: Integer;
        OldProgress: Integer;
        RecordNo: Integer;
        Text000: Label 'Enter the posting date.';
        Text001: Label 'Issuing Cash Collections...';
        Text002: Label 'Issuing Cash Collections @1@@@@@@@@@@@@@';
        Text003: Label 'It was not possible to issue some of the selected Cash Collection.\Do you want to see these Cash Collections?';
        PrintDoc: Option " ",Print,Email;
        NewTime: Time;
        OldTime: Time;
}

