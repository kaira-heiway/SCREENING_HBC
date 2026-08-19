pageextension 51231 CALTestSuitesExtCBN extends "CAL Test Suites"
{
    // version NAVW110.0
    // HEI.01 RITM2822071 IBM BULIMC01 07/10/2021 #new object created for HNK license
    // HEI.02 RITM2964345 IBM SAXENA03 25/03/2022
    //   # Added new field "RT Pack" in Table.
    // HEI.03 CHG2185291 IBM SAXENA03 15.05.2023
    //   # Added code for Consolidation of Test Script objects

    // BC Upgrade PATELS08 >>
    // # Added Tags HEI.01, HEI.02 and HEI.03 in documentation.
    // # Added new field "RT Pack".
    // BC Upgrade PATELS08 <<

    // BC Upgrade PATELS08 >> # Added new field "RT Pack" in Table.
    layout
    {
        addafter("Update Test Coverage Map")
        {
            field("RT Pack"; Rec."RT Pack FND")
            {
                ApplicationArea = All;
            }
        }
    }
    // BC Upgrade PATELS08 <<

    actions
    {
        modify("Test &Suite")
        {
            CaptionML = ENU = 'Test &Suite', FRA = 'Suite du test';
        }
        modify(Setup)
        {
            CaptionML = ENU = 'Setup', FRA = 'Configuration';
        }
        modify("E&xport")
        {
            CaptionML = ENU = 'E&xport', FRA = '&Exporter';
        }
        modify("I&mport")
        {
            CaptionML = ENU = 'I&mport', FRA = 'Importer';
        }
        modify(Separator)
        {
            CaptionML = ENU = 'Separator', FRA = 'Séparateur';
        }
        modify(Action16)
        {
            CaptionML = ENU = 'E&xport', FRA = 'E&xporter';
        }
        modify(Action24)
        {
            CaptionML = ENU = 'I&mport', FRA = 'Importer';
        }
    }
}

