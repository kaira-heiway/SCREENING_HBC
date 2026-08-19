tableextension 50111 InventoryPostingSetupExtFND extends "Inventory Posting Setup"
{
    // version NAVW18.00,DITW110.00.11,HEI.04
    // DITW110.00.11 SFI 30/08/2017 BL#14417 New fields
    //                                        2013610 Deposit Value Acc.
    //                                        2013611 Deposit Value Acc. (Interim)

    // HEI.01 RFC-CHG0270789 IBM.LS 18.02.2019
    //   # New Fields created: 50000 - "WIP Consumption"
    //                         50001 - "Apply WIP Consumption"
    // HEI.02 RFC-CHG2058828 IBM.NANDIS01 19.06.2020
    //   # New Fields created: 50002 - "WriteOff Account"

    // Hei.03 Change Accrual WIP registration CHG2060993- FCE - IBM
    //   # Added the fields: 50010 and 50011
    // HEI.04 CHG2193490 IBM SISUM01 26/07/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # New field created: 50012 PPV Inv. Adjmt. Account
    fields
    {
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Invt. Posting Group Code")
        {
            CaptionML = ENU = 'Invt. Posting Group Code', FRA = 'Code groupe compta. stock';
        }
        modify("Inventory Account")
        {
            CaptionML = ENU = 'Inventory Account', FRA = 'Compte stocks';
        }
        modify("Inventory Account (Interim)")
        {
            CaptionML = ENU = 'Inventory Account (Interim)', FRA = 'Compte stocks (attente)';
        }
        modify("WIP Account")
        {
            CaptionML = ENU = 'WIP Account', FRA = 'Compte en-cours';
        }
        modify("Material Variance Account")
        {
            CaptionML = ENU = 'Material Variance Account', FRA = 'Compte écart matière';
        }
        modify("Capacity Variance Account")
        {
            CaptionML = ENU = 'Capacity Variance Account', FRA = 'Compte écart opératoire';
        }
        modify("Mfg. Overhead Variance Account")
        {
            CaptionML = ENU = 'Mfg. Overhead Variance Account', FRA = 'Cpte écart frais gén. matière';
        }
        modify("Cap. Overhead Variance Account")
        {
            CaptionML = ENU = 'Cap. Overhead Variance Account', FRA = 'Cpte écart frais gén. op.';
        }
        modify("Subcontracted Variance Account")
        {
            CaptionML = ENU = 'Subcontracted Variance Account', FRA = 'Compte écart sous-traitance';
        }
        field(50000; "WIP Consumption FND"; Code[20])
        {
            caption = 'WIP Consumption';
            Description = 'HEI.01';
            TableRelation = "G/L Account";

            trigger OnValidate();
            begin
                //HEI.01>>
                if "WIP Consumption FND" <> xRec."WIP Consumption FND" then
                    CLEAR("Apply WIP Consumption FND");
                //HEI.01<<
            end;
        }
        field(50001; "Apply WIP Consumption FND"; Boolean)
        {
            caption = 'Apply WIP Consumption';
            Description = 'HEI.01';

            trigger OnValidate();
            begin
                //HEI.01>>
                if "Apply WIP Consumption FND" then
                    TESTFIELD("WIP Consumption FND");
                //HEI.01<<
            end;
        }
        field(50002; "WriteOff Account FND"; Code[20])
        {
            caption = 'WriteOff Account';
            Description = 'HEI.02';
            TableRelation = "G/L Account";
        }
        field(50010; "Accrual WIP Account FND"; Code[20])
        {
            Caption = 'Accrual WIP Account';
            Description = 'Hei.03_CHG2060993';
            TableRelation = "G/L Account"."No.";
        }
        field(50011; "Accrual WIP Bal.Account FND"; Code[20])
        {
            Caption = 'Accrual WIP Bal.Account';
            Description = 'Hei.03_CHG2060993';
            TableRelation = "G/L Account"."No.";
        }
        field(50012; "PPV Inv. Adjmt. Account FND"; Code[20])
        {
            Caption = 'PPV Inventory Adjustment Account';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            TableRelation = "G/L Account"."No.";
        }
        // field(2013610; "Deposit Value Acc."; Code[20])
        // {
        //     Caption = 'Deposit Value Account';
        //     Description = 'DITW110.00.11 BL#14417';
        //     TableRelation = "G/L Account";

        //     trigger OnValidate();
        //     begin
        //         CheckGLAcc("Deposit Value Acc.");
        //     end;
        // }
        // field(2013611; "Deposit Value Acc. (Interim)"; Code[20])
        // {
        //     Caption = 'Deposit Value Account (Interim)';
        //     Description = 'DITW110.00.11 BL#14417';
        //     TableRelation = "G/L Account";

        //     trigger OnValidate();
        //     begin
        //         CheckGLAcc("Deposit Value Acc. (Interim)");
        //     end;
        // }  // BC Upgrade NANDIS03
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

