tableextension 50224 CALTestSuiteExtFND extends "CAL Test Suite"
{
    // version NAVW19.00

    //   HEI.01 RITM2822071 IBM BULIMC01 07/10/2021 #new object created for HNK license
    // HEI.02 RITM2964345 IBM SAXENA03 25/03/2022
    //   # Added new field "RT Pack" in Table.
    // HEI.03 CHG2185291 IBM SAXENA03 15.05.2023
    //   # Added code for Consolidation of Test Script objects

    //BC UPGRADE KAPOOV01 # Added new field - "RT Pack" created under HEI.02 



    fields
    {
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify(Export)
        {
            CaptionML = ENU = 'Export', FRA = 'Exporter';
        }
        modify(Attachment)
        {
            CaptionML = ENU = 'Attachment', FRA = 'Document joint';
        }
        //BC UPGRADE KAPOOV01 >>
        field(50001; "RT Pack FND"; Boolean)
        {
            Caption = 'RT Pack';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        //BC UPGRADE KAPOOV01 <<
    }
}

