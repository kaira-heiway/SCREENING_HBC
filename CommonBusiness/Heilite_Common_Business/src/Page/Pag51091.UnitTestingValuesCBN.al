page 51091 "Unit Testing Values CBN"
{
    // version TS,HEI.02

    // HEI.01 RITM2693916 IBM NASTAA02 21.04.2021 # Automation MTC Test Scripts
    //   # New Page created to store the Unit Testing Default Values
    // HEI.02 CHG2185291 IBM SAXENA03 10.05.2023 # Automation Test Scripts
    //   # Added code for Consolidation of Test Script objects
    //****************************************************************************************
    //BC UPGRADE PATHAA02-23.02.26

    // BC UPGRADE PATELS08 >>
    // # Added UsageCategory property to the page level.
    // BC UPGRADE PATELS08 <<

    Caption = 'Unit Testing Values';
    PageType = List;
    SourceTable = "Unit Testing Value FND";
    ApplicationArea = All;
    // BC UPGRADE PATELS08 >>
    UsageCategory = Administration;
    // BC UPGRADE PATELS08 <<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Test Script Code"; Rec."Test Script Code")
                {
                }
                field("Test Script Description"; Rec."Test Script Description")
                {
                }
                field("Company Name"; Rec."Company Name")
                {
                }
                field("Table ID"; Rec."Table ID")
                {
                }
                field("Table Name"; Rec."Table Name")
                {
                }
                field(Value; Rec.Value)
                {
                }
                field("Value 2"; Rec."Value 2")
                {
                }
                field("Value 3"; Rec."Value 3")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit();
    begin
        //HEI.02>>
        UnitTestingValue.SkipTestScriptExecutionPROD();
        //HEI.02<<
    end;

    var
        UnitTestingValue: Record "Unit Testing Value FND";
}

