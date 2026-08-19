tableextension 50234 PayableVendorledgerEntryFND extends "Payable Vendor Ledger Entry"
{
    // version NAVW16.00,DITW110.00.11
    // DITW16.00.00.43 DDR 09/08/2013 DIT-715 #714 Added fields
    //                                                 2014310 Service Contract Line No.
    //                                                 2014311 Service Contract Type
    //                                                 2034840 Building No.
    //                                                 2034850 DIT Sub-Contract Type
    //                                                 2034872 Contract Group Code
    //                                                 2034915 Service Contract No.

    //   DITW17.00.02 DDR 09/08/2013 DIT-715 #714 merge
    //   DITW17.10.03 MSF 06/05/2014 DIT-770 #340 :Variable "Customer posting Group"
    //                                             2034916  "Posting Group"
    //   DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract
    //                                             Added field "Financial Contract No."
    //                                             Rename Caption Contract No. by Service contract No.
    //                                             Change ID of field Contract Type to Foundation layer 2035393
    //                                             Added blank Option to Contract Type
    //   DITW110.00.11 MSF 15/11/2017 NRQ#45760 Added fields Financial Contract No.

    //   HEI.01 CHG2024918 IBM POENAB02 16.09.2019 La R‚union_France Fiscal Year Closing
    //     # New fields added
    //       # 10800 Due Date
    //     # New key added: "Vendor No.,Due Date"
    //   HEI.02 FDD-1874 - CHG2092996 IBM NANDIS01 19.02.2021 - Bank Details payment slip La Reunion
    //     # Added new field - 50000 - "Vend Bank Account No"
    //     # Added new key - Vendor No.,Vend Bank Account No,Due Date

    fields
    {
        modify(Priority)
        {
            CaptionML = ENU = 'Priority', FRA = 'Priorité';
        }
        modify("Vendor No.")
        {
            CaptionML = ENU = 'Vendor No.', FRA = 'N° fournisseur';
        }
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("Vendor Ledg. Entry No.")
        {
            CaptionML = ENU = 'Vendor Ledg. Entry No.', FRA = 'N° séquence fournisseur';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Amount (LCY)")
        {
            CaptionML = ENU = 'Amount (LCY)', FRA = 'Montant DS';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify(Positive)
        {
            CaptionML = ENU = 'Positive', FRA = 'Positif';
        }
        modify(Future)
        {
            CaptionML = ENU = 'Future', FRA = 'Echéance à venir';
        }
        // field(10800; "Due Date"; Date)
        // {
        //     CaptionML = ENU = 'Due Date',
        //                 FRA = 'Date d''échéance';
        //     Description = 'HEI.01';
        // } //BC Upgrade GUNREM01 Not applicable
        field(50000; "Vend Bank Account No FND"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            Caption = 'Vend Bank Account No';
        }
        // field(2014310;"Service Contract Line No.";Integer)
        // {
        //     CaptionML = ENU='Contract Line No.',
        //                 FRA='N° ligne contrat';
        //     Description = 'DITW16.00.00.43 DIT-715 #714';
        // }
        // field(2034840;"Building No.";Code[20])
        // {
        //     CaptionML = ENU='Building No.',
        //                 FRA='N° immeuble';
        //     Description = 'DITW16.00.00.43 DIT-715 #714';
        //     TableRelation = Building;
        // }
        // field(2034850;"DIT Sub-Contract Type";Option)
        // {
        //     CaptionML = ENU='Sub Contract Type',
        //                 FRA='Sous type contrat';
        //     Description = 'DITW16.00.00.43 DIT-715 #714';
        //     OptionCaptionML = ENU=' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
        //                       FRA=' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
        //     OptionMembers = " ",Rent,Loan,"Loan in use",Maintenance,Other,PlantMaintenance;
        // }
        // field(2034872;"Contract Group Code";Code[10])
        // {
        //     CaptionML = ENU='Contract Group Code',
        //                 FRA='Code groupe contrat';
        //     Description = 'DITW16.00.00.43 DIT-715 #714';
        //     TableRelation = IF ("Contract Type"=CONST(Service),
        //                         "DIT Sub-Contract Type"=FILTER(<>" ")) "Contract Group".Code WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"))
        //                         ELSE IF ("Contract Type"=CONST(Service),
        //                                  "DIT Sub-Contract Type"=CONST(" ")) "Contract Group".Code
        //                                  ELSE IF ("Contract Type"=CONST(Financial)) "Financial Contract Group".Code WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));
        // }
        // field(2034915;"Service Contract No.";Code[20])
        // {
        //     CaptionML = ENU='Service Contract No.',
        //                 FRA='N° contrat de service';
        //     Description = 'DITW16.00.00.43 DIT-715 #714';
        //     TableRelation = "Service Purch. Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract));
        // }
        // field(2034916;"Posting Group";Code[10])
        // {
        //     CaptionML = ENU='Posting Group',
        //                 FRA='Groupe comptabilisation';
        //     Description = 'DIT-770 #340';
        // }
        // field(2034917;"Financial Contract No.";Code[20])
        // {
        //     Caption = 'Financial Contract No.';
        //     Description = 'NRQ#45760';
        //     TableRelation = "Financial Contract Header"."Contract No.";
        // }
        // field(2035393;"Contract Type";Option)
        // {
        //     CaptionML = ENU='Contract Type',
        //                 FRA='Type contrat';
        //     Description = 'DITW16.00.00.43 DIT-715 #714 - DITW18.00.06 DIT-770 #1368';
        //     OptionCaptionML = ENU=' ,Service,Financial',
        //                       FRA=' ,Service,Financier';
        //     OptionMembers = " ",Service,Financial;
        // }
    }
    keys
    {
        //BC upgrade GUNREM01 >> Commented keys. Used Due date field its not required.
        // key(50000; "Due Date"; "Vendor No.")
        // {
        // }
        // key(50001; "Vendor No."; "Vend Bank Account No", "Due Date")
        // {
        // }
        //BC upgrade GUNREM01 << Commented keys. Used Due date field its not required.

    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

