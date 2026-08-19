report 51095 "Update Std Aging Info CBN"
{
    // version HEI.02

    // HEI.01 CHG2237893 PRASAA03 27.03.2024 Std cost aging info / add new filters
    //   # Created New report to update old std cost aging data.
    // HEI.02 CHG2237893 PRASAA03 03.04.2024 Std cost aging info / add new filters
    //   # Report is no more required and can be replace with new report.

    //BC Upgrade KAPOOV01 >>
    // 1. Add ApplicationArea and UsageCategory property in Report.
    //BC Upgrade KAPOOV01 <<


    Permissions = TableData "Standard Cost Aging Info FND" = rm;
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Standard Cost Aging Info FND"; "Standard Cost Aging Info FND")
        {
            DataItemTableView = SORTING("Location Code", "Item No.") WHERE("User ID" = FILTER(''));
            RequestFilterFields = "Item No.", "Location Code";

            trigger OnAfterGetRecord();
            begin
                //HEI.01>>
                WindDialog.UPDATE(1, "Standard Cost Aging Info FND"."Item No.");
                WindDialog.UPDATE(2, "Standard Cost Aging Info FND"."Location Code");
                ChangeLogEntry.RESET();
                ChangeLogEntry.SETCURRENTKEY("Table No.", "Field No.", "Primary Key Field 1 Value", "Primary Key Field 2 Value");
                ChangeLogEntry.SETRANGE("Table No.", 5700);
                ChangeLogEntry.SETRANGE("Field No.", 24);
                ChangeLogEntry.SETRANGE("Primary Key Field 1 Value", "Standard Cost Aging Info FND"."Location Code");
                ChangeLogEntry.SETRANGE("Primary Key Field 2 Value", "Standard Cost Aging Info FND"."Item No.");
                if ChangeLogEntry.FINDLAST() then begin
                    EVALUATE("Standard Cost Aging Info FND"."Old Standard Cost", ChangeLogEntry."Old Value");
                    EVALUATE("Standard Cost Aging Info FND"."New Standard Cost", ChangeLogEntry."New Value");
                    "Standard Cost Aging Info FND"."User ID" := ChangeLogEntry."User ID";
                    "Standard Cost Aging Info FND".MODIFY();
                end else begin
                    ChangelogEntryArchive.RESET();
                    ChangelogEntryArchive.SETCURRENTKEY(ChangelogEntryArchive."Table No.", ChangelogEntryArchive."Field No.", ChangelogEntryArchive."Primary Key Field 1 Value", ChangelogEntryArchive."Primary Key Field 2 Value");
                    ChangelogEntryArchive.SETRANGE(ChangelogEntryArchive."Table No.", 5700);
                    ChangelogEntryArchive.SETRANGE(ChangelogEntryArchive."Field No.", 24);
                    ChangelogEntryArchive.SETRANGE(ChangelogEntryArchive."Primary Key Field 1 Value", "Standard Cost Aging Info FND"."Location Code");
                    ChangelogEntryArchive.SETRANGE(ChangelogEntryArchive."Primary Key Field 2 Value", "Standard Cost Aging Info FND"."Item No.");
                    if ChangelogEntryArchive.FINDLAST() then begin
                        EVALUATE("Standard Cost Aging Info FND"."Old Standard Cost", ChangelogEntryArchive."Old Value");
                        EVALUATE("Standard Cost Aging Info FND"."New Standard Cost", ChangelogEntryArchive."New Value");
                        "Standard Cost Aging Info FND"."User ID" := ChangelogEntryArchive."User ID";
                        "Standard Cost Aging Info FND".MODIFY();
                    end;
                end;
            end;

            trigger OnPostDataItem();
            begin
                WindDialog.CLOSE();//HEI.01
            end;

            trigger OnPreDataItem();
            begin
                WindDialog.OPEN('Processing Item #1#################\Location #2###########');//HEI.01
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
    }

    trigger OnInitReport();
    begin
        ERROR(Text001);//HEI.02
    end;

    var
        ChangeLogEntry: Record "Change Log Entry";
        WindDialog: Dialog;
        ChangelogEntryArchive: Record "Change log Entry Archive FND";
        Text001: Label 'Report is not in use';
}

