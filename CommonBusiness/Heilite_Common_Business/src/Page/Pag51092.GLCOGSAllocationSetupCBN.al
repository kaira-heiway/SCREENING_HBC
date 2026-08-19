page 51092 "G/L COGS Allocation Setup CBN"
{
    // version HEI.02

    // HEI.01 CHG2132673 IBM.LS      01.03.2022
    //   # Created New Page - G/L COGS Allocation Setup
    // HEI.02 CHG2132673 IBM BULIMC01 04/03/2022 #fields deleted

    Caption = 'G/L COGS Allocation Setup';
    PageType = List;
    SourceTable = "G/L COGS Allocation Setup FND";
    SourceTableView = sorting("COGS Allocation", "G/L Account Range for SCOA L3")
                      ORDER(Ascending);
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("G/L Account Range for SCOA L3"; Rec."G/L Account Range for SCOA L3")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the G/L Account Range for SCOA L3 field.';
                }
                field("Ccc Code Dim. Filter"; Rec."Ccc Code Dim. Filter")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Ccc Code Dim. Filter field.';
                }
                field("COGS Allocation"; Rec."COGS Allocation")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the COGS Allocation field.';
                }
            }
        }
    }

    actions
    {
    }
}

