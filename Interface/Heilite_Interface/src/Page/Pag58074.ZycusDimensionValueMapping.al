page 58074 "Zycus Dimension Value Mapping"
{
    // Heilite Navision Old Id - 50648

    // version HEI.02

    // HEI.01 CHG2210794 SAHAL01 02.04.2024 Zycus - BASE HL Integration Master Dimension
    //   # Created New Page: 50648 - Zycus Dimension Value Mapping
    // HEI.02 CHG2307002 SAHAL01 13.06.2025 Include Additional Alphabetical Special Characters for Zycus
    //   # Added New Field - Locked

    //BC UPGRADE ATHUKS01 Added Page properties InsertAllowed, ModifyAllowed, DeleteAllowed and ToolTips to fields and actions.   
    Caption = 'Zycus Dimension Value Mapping';
    PageType = List;
    SourceTable = "Zycus Dim Value Mapping INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Dimension Code HeiLite"; Rec."Dimension Code HeiLite")
                {
                    ToolTip = 'Specifies the value of the Dimension Code HeiLite field.';
                }
                field("Dimension Value Code HeiLite"; Rec."Dimension Value Code HeiLite")
                {
                    ToolTip = 'Specifies the value of the Dimension Value Code HeiLite field.';
                }
                field("Dimension Value Code Zycus"; Rec."Dimension Value Code Zycus")
                {
                    ToolTip = 'Specifies the value of the Dimension Value Code Zycus field.';
                }
                field(Locked; Rec.Locked)
                {
                    ToolTip = 'Specifies the value of the Locked field.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                }
                field("Last Time Modified"; Rec."Last Time Modified")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Last Time Modified field.';
                }
                field("Last Modified By User"; Rec."Last Modified By User")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Last Modified By User field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Setup)
            {
                Caption = 'Setup';
                action("Zycus Special Character List")
                {
                    Caption = 'Zycus Special Character List';
                    Image = SetupList;
                    RunObject = Page "Zycus Special Character";
                    ToolTip = 'Executes the Zycus Special Character List action.';
                }
            }
            group(Process)
            {
                Caption = 'Process';
                Image = Process;
                action("Update Zycus Dimension Value")
                {
                    Caption = 'Update Zycus Dimension Value';
                    Image = "Report";
                    ToolTip = 'Executes the Update Zycus Dimension Value action.';
                    // RunObject = Report "Zycus Dimension Value Update";  // BC Upgrade NANDIS03 - Blocked as report is yet to be compiled
                }
                action("Lock Selected")
                {
                    Caption = 'Lock Selected';
                    Image = Lock;
                    ToolTip = 'Executes the Lock Selected action.';

                    trigger OnAction();
                    begin
                        //HEI.02>>
                        CurrPage.SETSELECTIONFILTER(Rec);
                        Rec.MODIFYALL(Locked, true, true);
                        Rec.RESET();
                        //HEI.02<<
                    end;
                }
            }
        }
    }
}

