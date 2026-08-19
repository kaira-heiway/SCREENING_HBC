tableextension 50225 CALTestLineExtFND extends "CAL Test Line"
{
    // version NAVW19.00
    //HEI.01 RITM2822071 IBM BULIMC01 07/10/2021 #new object created for HNK license
    // HEI.02 RITM2738652 IBM BHATTA09 21.12.2022   
    //   # New fields added RT Pack
    // HEI.03 RITM2923302 IBM SAXENA03 11/02/2022
    //   # Added new field "Document Reference No." in Table.
    // HEI.04 CHG2185291 IBM SAXENA03 15.05.2023
    //   # Added code for Consolidation of Test Script objects

    // BC Upgrade PATELP08 >> 
    // # Changed extension name OLD - tableextension50161, NEW - CALTestLineExt
    // # Added Documentation as compared to NAV object - HEI.01, HEI.02, HEI.03, HEI.04
    // # Added Fields "RT Pack" and "Document Reference No." according to HEI.02 and HEI.03 tag.
    // BC Upgrade PATELP08 <<

    // BC Upgrade KAPOOV01 Changed field ID of field- "RT Pack" from 14 to 50001  
    // BC Upgrade KAPOOV01 Changed field ID of field- "Document Reference No." from 14 to 50002  

    fields
    {
        // BC Upgrade PATELP08 >> Added Fields "RT Pack" and "Document Reference No." according to HEI.02 and HEI.03 tag.

        // BC Upgrade KAPOOV01 Changed field ID of field- "RT Pack" from 14 to 50001  >>
        //field(14; "RT Pack"; Boolean)
        field(50001; "RT Pack FND"; Boolean)
        // BC Upgrade KAPOOV01 Changed field ID of field- "RT Pack" from 14 to 50001  <<
        {
            Caption = 'RT Pack';
            Description = 'HEI.02';
            DataClassification = ToBeClassified;
        }

        // BC Upgrade KAPOOV01 Changed field ID of field- "Document Reference No." from 14 to 50002  >>
        //field(15; "Document Reference No."; Text[50])
        field(50002; "Document Reference No. FND"; Text[50])
        // BC Upgrade KAPOOV01 Changed field ID of field- "Document Reference No." from 14 to 50002  <<
        {
            Caption = 'Document Reference No.';
            Description = 'HEI.03';
            DataClassification = ToBeClassified;
        }
        // BC Upgrade PATELP08 <<
        modify("Test Suite")
        {
            CaptionML = ENU = 'Test Suite', FRA = 'Suite du test';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify("Line Type")
        {
            CaptionML = ENU = 'Line Type', FRA = 'Type ligne';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Function")
        {
            CaptionML = ENU = 'Function', FRA = 'Fonction';
        }
        modify(Run)
        {
            CaptionML = ENU = 'Run', FRA = 'E&xécuter';
        }
        modify(Result)
        {
            CaptionML = ENU = 'Result', FRA = 'Résultat';
        }
        modify("Start Time")
        {
            CaptionML = ENU = 'Start Time', FRA = 'Heure début';
        }
        modify(Level)
        {
            CaptionML = ENU = 'Level', FRA = 'Niveau';
        }
    }
}

