page 51085 "JobQ Log Entries Detail CBN"
{
    // version HEI.01,SB

    // HEI.01 FDD-HD-545 IBM POSTOI01 22.10.2019 # Self-Billing
    //   # New Page

    // BC UPGRADE PATELP08 >>
    //    # Added application area and usage category
    //    # Added Rec. before field name as per new syntax change in BC upgrade
    //    # Added Rec. before FINDFIRST function
    // BC UPGRADE PATELP08 <<


    Caption = 'Self-Billing Entries';
    DeleteAllowed = true;
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Job Queue Log Entry Detail FND";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Descending);

    // BC UPGRADE PATELP08 >> added application area and usage category
    ApplicationArea = All;
    UsageCategory = Lists;
    // BC UPGRADE PATELP08 <<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                // BC UPGRADE PATELP08 >> Added Rec. before field names as per new syntax change in BC upgrade
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Execution Date/Time"; Rec."Execution Date/Time")
                {
                }
                field("Entry Type"; Rec."Entry Type")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Document No"; Rec."Document No")
                {
                }
                field("Document Status"; Rec."Document Status")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Message; Rec.Message)
                {
                }
                field("Message 1"; Rec."Message 1")
                {
                }
                field("Message 2"; Rec."Message 2")
                {
                }
                field("Message 3"; Rec."Message 3")
                {
                }
                field("Job Queue ID"; Rec."Job Queue ID")
                {
                }
                field("JQ Object Type to Run"; Rec."JQ Object Type to Run")
                {
                }
                field("JQ Object ID to Run"; Rec."JQ Object ID to Run")
                {
                }
                field("JQ Object Caption to Run"; Rec."JQ Object Caption to Run")
                {
                }
                // BC UPGRADE PATELP08 <<
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Header)
            {
                Caption = 'Header';
                Image = "Action";
                action("Show Document")
                {
                    Caption = 'Show Document';
                    Image = Open;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Open the related record from the database.';
                }
            }
        }
    }
    // BC UPGRADE PATELP08 >> Added Rec. before FINDFIRST function 
    trigger OnOpenPage();
    begin
        // BC UPGRADE PATELP08 >> Added Rec. before FINDFIRST function
        if Rec.FINDFIRST() then;
        // BC UPGRADE PATELP08 <<
    end;
    // BC UPGRADE PATELP08 <<
}

