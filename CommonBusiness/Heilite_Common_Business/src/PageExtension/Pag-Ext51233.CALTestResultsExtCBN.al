pageextension 51233 CALTestResultsExtCBN extends "CAL Test Results"
{
    // version NAVW110.0
    // HEI.01 RITM2822071 IBM BULIMC01 07/10/2021 #new object created for HNK license
    // HEI.02 RITM2923302 IBM SAXENA03 11/02/2022
    //   # Added new column "Suite Name" & "Document Reference No." in Page.
    // HEI.03 CHG2185291 IBM SAXENA03 15.05.2023
    //   # Added code for Consolidation of Test Script objects

    // BC Upgrade PATELS08 >>
    // # Added Tags HEI.01, HEI.02 and HEI.03 in documentation.
    // # Added new column "Suite Name" & "Document Reference No." in Page.
    // Blcked modify("Container") as "Container" is not present in Base Page in BC.
    // BC Upgrade PATELS08 <<

    // BC Upgrade PATELS08 >>
    // HEI.02 >>
    layout
    {
        addbefore("No.")
        {
            field("Suite Name"; Rec."Suite Name FND")
            {
                ApplicationArea = All;
                Description = 'HEI.02';
            }

            field("Document Reference No."; Rec."Document Reference No. FND")
            {
                ApplicationArea = All;
                Description = 'HEI.02';
            }
        }
    }
    // HEI.02 <<
    // BC Upgrade PATELS08 <<

    actions
    {
        // BC Upgrade PATELS08 >> Blocked as "Container" is not present in Base Page in BC."
        // modify(Container)
        // {
        //     CaptionML = ENU='Container',FRA='Conteneur';
        // }
        // BC Upgrade PATELS08 <<

        modify("Call Stack")
        {
            CaptionML = ENU = 'Call Stack', FRA = 'Pile d''appels';
        }
        modify(Export)
        {
            CaptionML = ENU = 'E&xport', FRA = 'E&xporter';
        }
    }
}

