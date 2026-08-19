pageextension 51044 InventoryPostingSetupExtCBN extends "Inventory Posting Setup"
{
    // version NAVW110.0,DITW110.00.11,HEI.04
    // DITW110.00.11 SFI 30/08/2017 BL#14417 New fields
    //                                        2013610 Deposit Value Acc.
    //                                        2013611 Deposit Value Acc. (Interim)

    // HEI.01 RFC-CHG0270789 IBM.LS 18.02.2019
    //   # New Fields added: "WIP Consumption"
    //                       "Apply WIP Consumption"
    // HEI.02 RFC-CHG2058828 IBM.NANDIS01 19.06.2020
    //   # New Fields created: 50002 - "WriteOff Account"

    // Hei.03 CHG2060993 FCE  09072020 (DDMMYYYY) Added fields
    //        "Accrual WIP Account" and "Accrual WIP Bal.Account"
    // HEI.04 CHG2193490 IBM SISUM01 26/07/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # Added field PPV Inv. Adjmt. Account
    layout
    {
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location code for setting up posting groups of inventory to general ledger.', FRA = 'Spécifie le code magasin permettant de paramétrer les groupes comptabilisation stock dans la comptabilité.';
        }
        modify("Invt. Posting Group Code")
        {
            ToolTipML = ENU = 'Specifies the code for the inventory posting group, in the combination of location and inventory posting group, that you are setting up.', FRA = 'Spécifie le code du groupe comptabilisation stock pour la combinaison magasin/groupe comptabilisation stock que vous configurez.';
        }
        modify("Inventory Account")
        {
            ToolTipML = ENU = 'Specifies the number of the G/L account that item transactions with this combination of location and inventory posting group are posted to.', FRA = 'Spécifie le numéro du compte général dans lequel sont validées les transactions avec cette combinaison magasin/groupe comptabilisation stock.';
        }
        modify("Inventory Account (Interim)")
        {
            ToolTipML = ENU = 'Specifies the number of the general ledger account to which to post transactions with the expected cost for items in this combination.', FRA = 'Spécifie le numéro du compte général sur lequel enregistrer les transactions avec le coût prévu des articles pour la combinaison magasin/groupe comptabilisation stock.';
        }
        modify("WIP Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which to post transactions for items in WIP inventory in this combination.', FRA = 'Spécifie le numéro du compte général sur lequel valider les transactions des articles du stock en-cours dans cette combinaison.';
        }
        modify("Material Variance Account")
        {
            ToolTipML = ENU = 'Specifies the number of the general ledger account to which to post material variance transactions for items in this combination.', FRA = 'Spécifie le numéro du compte général sur lequel valider les transactions écart matière des articles dans cette combinaison.';
        }
        modify("Capacity Variance Account")
        {
            ToolTipML = ENU = 'Specifies the number of the general ledger account to which to post capacity variance transactions for items in this combination.', FRA = 'Spécifie le numéro du compte général sur lequel valider les transactions écart opératoires des articles dans cette combinaison.';
        }
        modify("Subcontracted Variance Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which to post subcontracted variance transactions for items in this combination.', FRA = 'Spécifie le numéro du compte général sur lequel valider les transactions écart sous-traitance des articles dans cette combinaison.';
        }
        modify("Cap. Overhead Variance Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which to post capacity overhead variance transactions for items in this combination.', FRA = 'Spécifie le numéro du compte général sur lequel valider les transactions écart frais généraux opératoires des articles dans cette combinaison.';
        }
        modify("Mfg. Overhead Variance Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which to post manufacturing overhead variance transactions for items in this combination.', FRA = 'Spécifie le numéro du compte général sur lequel valider les transactions écart frais généraux matière des articles dans cette combinaison.';
        }
        // modify("Location Code2")
        // {
        //     ToolTipML = ENU='Specifies the location code for setting up posting groups of inventory to general ledger.',FRA='Spécifie le code magasin permettant de paramétrer les groupes comptabilisation stock dans la comptabilité.';
        // }
        // modify("Invt. Posting Group Code2")
        // {
        //     ToolTipML = ENU='Specifies the code for the inventory posting group, in the combination of location and inventory posting group, that you are setting up.',FRA='Spécifie le code du groupe comptabilisation stock pour la combinaison magasin/groupe comptabilisation stock que vous configurez.';
        // }  // BC Upgrade NANDIS03
        // addafter("Inventory Account (Interim)")
        // {
        //     field("Deposit Value Acc."; "Deposit Value Acc.")
        //     {
        //     }
        //     field("Deposit Value Acc. (Interim)"; "Deposit Value Acc. (Interim)")
        //     {
        //     }
        // }  // BC Upgrade NANDIS03
        addafter("Mfg. Overhead Variance Account")
        {
            field("WIP Consumption"; REC."WIP Consumption FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the WIP Consumption field.';
            }
            field("Apply WIP Consumption"; REC."Apply WIP Consumption FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Apply WIP Consumption field.';
            }
            field("WriteOff Account"; REC."WriteOff Account FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the WriteOff Account field.';
            }
            field("Accrual WIP Account"; REC."Accrual WIP Account FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Accrual WIP Account field.';
            }
            field("Accrual WIP Bal.Account"; REC."Accrual WIP Bal.Account FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Accrual WIP Bal.Account field.';
            }
            field("PPV Inv. Adjmt. Account"; REC."PPV Inv. Adjmt. Account FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the PPV Inventory Adjustment Account field.';
            }
        }  // BC Upgrade NANDIS03
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

