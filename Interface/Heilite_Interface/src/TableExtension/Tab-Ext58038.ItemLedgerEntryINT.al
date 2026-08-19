namespace LocalBCHeiliteInterface.LocalBCHeiliteInterface;

using Microsoft.Inventory.Ledger;

tableextension 58038 "ItemLedgerEntry_INT" extends "Item Ledger Entry"
{
    // HEI.01 FDD PRDGAP038 IBM COSTES02 07.08.2017 # Added field Quality Status

    // HEI.02 FDD-KDD0TC001 IBM HORTOC01 26.09.2017
    //   # New fields
    // HEI.03 FDD-BA-PRDGAP01 IBM POSTOI01 12.07.2018
    //   # new field 50008 Project Code Code 20
    //   HEI.04 FDD-BA-SLSGAP01 IBM NASTAA02 11.12.2018 # Counterpoint Interface
    //   # New Fields created: 50009 - Interface Code
    //                         50012 - CP Vendor Invoice No.

    // HEI.05 CHG2025677 IBM KUMARN15 09.08.2019
    //   # Added key Item No.,Quality Status,Lot No.
    // HEI.06 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New field: 10800 Shipment Method Code
    // HEI.07 CHG2012342 IBM GAVANM01 19/11/2019 # Your Reference added
    // HEI.08 BRD HB398 IBM BULIMC01 14/02/2020 #new field created: 50013 - "Value Entry Source No."
    // HEI.10 CHG2065153 IBM KUMARN15 23.06.2020
    //   # Added field "Source System Identifier"
    // HEI.11 HT1615 BULIMC01 IBM 16.09.2020#new field added: 50061 - "Zone Code"
    // HEI.12 CHG2131272 IBM.LS      14.12.2021
    //   # Created New Field: 50025 - Reporting Type
    // HEI.13 CHG2156228 IBM PATHAA02 26.04.2022 Permissions added for ILE-RIMD in Properties
    //  # CU50153 Job has issue with the Permission on ILE-Modify
    // HEI.14 CHG2228022 IBM-PATHAA02/VORGIM01 14.11.2023
    //  # Optimization for Adjust Cost-Item Entries, Remove Table Locking

    //BC Upgrade GUNREM01 -Added Interface fields.
    fields
    {
        //HEI.04 BC Upgrade GUNREM01 added >>
        field(50009; "Interface Code INT"; Code[20])
        {
            Caption = 'Interface Code';
            Description = 'HEI.04';
            TableRelation = "Interface Setup INT";
        }
        field(50012; "CP Vendor Invoice No. INT"; Code[20])
        {
            caption ='CP Vendor Invoice No.';
            Description = 'HEI.04';
        }
        //HEI.04 BC Upgrade GUNREM01 added <<
    }
}
