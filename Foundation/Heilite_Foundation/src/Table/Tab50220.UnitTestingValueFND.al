table 50220 "Unit Testing Value FND"
{
    // version TS,HEI.04

    // HEI.01 RITM2693916 IBM NASTAA02 21.04.2021 # Automation MTC Test Scripts
    //   # New Table created to store the Unit Testing Default Values
    // HEI.02 RITM2693916 IBM GHOSHS05 21.10.2021 Increased length of Table Name to 50
    // HEI.03 RITM2822071 IBM BHATTA09 16.08.2022 # Automation RTR Test Scripts- Bug fix for Value 3 length
    // HEI.04 CHG2185291 IBM SAXENA03 10.05.2023 # Automation Test Scripts
    //   # Added code for Consolidation of Test Script objects
    //********************************************************************************************************************
    //BC UPGRADE PATHAA02-18.02.26
    //Old Function-SkipTestScriptExecutionPROD Commented as Table "Server Instance" is not accessible in SaaS & Table "Server Instance Detail" is on-prem only, 
    //Function-SkipTestScriptExecutionPROD modified to fit SaaS

    // BC Upgrade MISHRS14 >>
    // Changed Text data type length from 50 to 249 in field - 15 "Table Name" due to warning.
    // BC Upgrade MISHRS14 <<

    Caption = 'Unit Testing Value';

    fields
    {
        field(1; "Test Script Code"; Code[20])
        {
            Caption = 'Test Script Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            DataClassification = ToBeClassified;
            TableRelation = Company;
        }
        field(3; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            DataClassification = ToBeClassified;
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Table));
        }
        field(10; "Test Script Description"; Text[100])
        {
            Caption = 'Test Script Description';
            DataClassification = ToBeClassified;
        }

        // BC Upgrade MISHRS14 >>
        //field(15; "Table Name"; Text[50])
        // Changed Text data type length from 50 to 249 due to warning.
        field(15; "Table Name"; Text[249])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Table),
                                                                           "Object ID" = FIELD("Table ID")));
            Caption = 'Table Name';
            Description = 'HEI.02';
            Editable = false;
            FieldClass = FlowField;
        }
        // BC Upgrade MISHRS14 <<

        field(20; Value; Code[20])
        {
            Caption = 'Value';
            DataClassification = ToBeClassified;
        }
        field(21; "Value 2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Value 3"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
    }

    keys
    {
        key(Key1; "Test Script Code", "Company Name", "Table ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        //HEI.04>>
        SkipTestScriptExecutionPROD();
        //HEI.04<<
    end;

    var
        TestScriptError: Label 'Test Script execution is not allowed into Production System';

    //BC UPGRADE PATHAA02-Commented as it is not compatible for SaaS>>
    // procedure SkipTestScriptExecutionPROD();
    // var
    //     ServerDetails: Record "Server Instance Detail";
    //     ServerInstance: Record "Server Instance";
    // begin
    //     //HEI.04>>
    //     ServerInstance.GET(SERVICEINSTANCEID);
    //     ServerDetails.RESET;
    //     ServerDetails.SETCURRENTKEY("Server Computer Name", "Server Instance Name");
    //     ServerDetails.SETRANGE("Server Computer Name", ServerInstance."Server Computer Name");
    //     ServerDetails.SETRANGE("Environment Code", ServerDetails."Environment Code"::P);
    //     if ServerDetails.FINDFIRST then begin
    //         ERROR(TestScriptError);
    //     end;
    //     //HEI.04<<
    // end;
    //BC UPGRADE PATHAA02-Commented as it is not compatible for SaaS<<


    //BC UPGRADE PATHAA02-Function modified to fit SaaS>>
    procedure SkipTestScriptExecutionPROD()
    var
        EnvironmentInformation: Codeunit "Environment Information";
    begin
        // HEI.04 >>
        if EnvironmentInformation.IsProduction() then //Returns TRUE when environment type is Production & FALSE for Sandbox,Preview & Test
            Error(TestScriptError);
        // HEI.04 <<
    end;
    //BC UPGRADE PATHAA02-Function modified to fit SaaS<<
}

