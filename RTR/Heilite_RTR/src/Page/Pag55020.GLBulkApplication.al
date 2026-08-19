page 55020 "GL Bulk Application RTR"
{

    // HEI.01 CHG2317671 IBM POENAB02 07.10.2025 HB2428 Excel Mapping Report IBM tool for closing GL entries for GL Account with big volume of data
    //   # Object created

    // BC UPGRADE MISHRS14 >>
    // # Created Page
    // # Nav ID : 50606
    // BC UPGRADE MISHRS14 <<

    ApplicationArea = All;
    Caption = 'GL Bulk Application';
    PageType = List;
    SourceTable = "GL Bulk Application FND";
    UsageCategory = Lists;

    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No. PK"; Rec."Entry No. PK")
                {
                    visible = false;
                    ToolTip = 'Entry No.';
                }
                field("Application Combination"; Rec."Application Combination")
                {
                    ToolTip = 'Displays the combination of applications associated with this record';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'General Ledger Entry No.';
                }
                field(Amount; Rec.Amount)
                {

                }
                field("Entry No. To Apply To"; Rec."Entry No. To Apply To")
                {
                }
                field("Amount To Apply To"; Rec."Amount To Apply To")
                {
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                }
                field("Amount From GL Entry (HeiLite)"; Rec."Amount From GL Entry (HeiLite)")
                {
                }
                field("Apply with G/L Account No."; Rec."Apply with G/L Account No.")
                {
                }
                field("Amount To Apply To (HeiLite)"; Rec."Amount To Apply To (HeiLite)")
                {
                }
                field("Difference (HeiLite)"; Rec."Difference (HeiLite)")
                {
                }
                field("Entry No. - Open (HeiLite)"; Rec."Entry No. - Open (HeiLite)")
                {
                }
                field("Entry No.ToApply-Open(HeiLite)"; Rec."Entry No.ToApply-Open(HeiLite)")
                {
                }
                field("Error Message"; Rec."Error Message")
                {
                }
                field("Error Message 2"; Rec."Error Message 2")
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(ImportAndPost)
            {


                action(ImportDataFromExcel)
                {
                    Caption = 'Import data from Excel';
                    Image = ImportExcel;
                    Promoted = true;
                    RunObject = Report "GL Bulk Application Import CBN";

                    trigger OnAction()
                    begin
                    end;
                }

                action(PostApplication)
                {
                    Caption = 'Post Application';
                    Image = PostApplication;
                    Promoted = true;
                    ShortcutKey = 'F9';

                    trigger OnAction()
                    begin
                        GLBulkApplicationPost.Run();
                    end;
                }
            }
        }
    }




    var
        GLBulkApplicationPost: Codeunit "GL Bulk Application Post CBN";
}
