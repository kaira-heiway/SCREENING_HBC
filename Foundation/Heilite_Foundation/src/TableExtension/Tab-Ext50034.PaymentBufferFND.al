//tableextension 50034 PaymentBufferExt extends "Payment Buffer"  // BC Upgrade NANDIS03 - Payment Buffer is replaced by Vendor Payment Buffer
tableextension 50034 PaymentBufferExtFND extends "Vendor Payment Buffer"  // BC Upgrade NANDIS03
{
    // version NAVW17.10,DITW110.00.11,HEI.02
    //     DITW16.00.00.43 DDR 09/08/2013 DIT-715 #714 Added fields
    //                                               2014310 Service Contract Line No.
    //                                               2014311 Service Contract Type
    //                                               2034840 Building No.
    //                                               2034850 DIT Sub-Contract Type
    //                                               2034872 Contract Group Code
    //                                               2034915 Service Contract No.

    // DITW17.00.02 DDR 09/08/2013 DIT-715 #714 merge
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 MSF 06/05/2014 DIT-770 #340 :Variable "Customer posting Group"
    //                                           2034916  "Posting Group"
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract
    //                                           Added field "Financial Contract No."
    //                                           Rename Caption Contract No. by Service contract No.
    //                                           Change ID of field Contract Type to Foundation layer 2035393
    //                                           Added blank Option to Contract Type
    // DITW110.00.11 AKH 29/08/2017 NRQ#17902 Added new fields 2014109 "Route Planning No."
    //                                                         2014421 "Document Subtype Code"
    // DITW110.00.11 MSF 15/11/2017 NRQ#45760 Added fields Financial Contract No.
    // HEI.01 PTPGAP068 IBM COSTES02 18.08.2017 Payment Proposal grouping/archiving
    //   # New field Vendor Bank Account
    //   # Added Vendor Bank Account in primary key for grouping in report 393
    // HEI.02 PTPGAP083 IBM NASTAA02 05.03.2018 # Mark Reversed Rejected Payments
    //   # New Field created: 50001 - Reversed
    // HEI.03 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # New Field created: 50002 - Fixed Asset Acquisition

    // BC Upgrade SHUKLP03 >> 50066 Document Subtype code field added.

    fields
    {
        modify("Vendor No.")
        {
            CaptionML = ENU = 'Vendor No.', FRA = 'N° fournisseur';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Vendor Ledg. Entry No.")
        {
            CaptionML = ENU = 'Vendor Ledg. Entry No.', FRA = 'N° séquence fournisseur';
        }
        modify("Dimension Entry No.")
        {
            CaptionML = ENU = 'Dimension Entry No.', FRA = 'N° séquence analytique';
        }
        modify("Global Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Code"(Field 5)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Code"(Field 6)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Vendor Ledg. Entry Doc. Type")
        {
            CaptionML = ENU = 'Vendor Ledg. Entry Doc. Type', FRA = 'Type doc. écriture comptable fournisseur';
            // OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement';
        }
        modify("Vendor Ledg. Entry Doc. No.")
        {
            CaptionML = ENU = 'Vendor Ledg. Entry Doc. No.', FRA = 'N° doc. écriture comptable fournisseur';
        }
        modify("Creditor No.")
        {

            //Unsupported feature: Change TableRelation on ""Creditor No."(Field 170)". Please convert manually.

            CaptionML = ENU = 'Creditor No.', FRA = 'N° créditeur';
        }
        modify("Payment Reference")
        {

            //Unsupported feature: Change TableRelation on ""Payment Reference"(Field 171)". Please convert manually.

            CaptionML = ENU = 'Payment Reference', FRA = 'Référence paiement';
        }
        modify("Payment Method Code")
        {

            //Unsupported feature: Change TableRelation on ""Payment Method Code"(Field 172)". Please convert manually.

            CaptionML = ENU = 'Payment Method Code', FRA = 'Code mode de règlement';
        }
        modify("Applies-to Ext. Doc. No.")
        {
            CaptionML = ENU = 'Applies-to Ext. Doc. No.', FRA = 'N° ligne doc. ext. lettrage';
        }
        modify("Exported to Payment File")
        {
            CaptionML = ENU = 'Exported to Payment File', FRA = 'Exporté dans fichier paiement';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        field(50000; "Vendor Bank Account FND"; Code[10])
        {
            Caption = 'Vendor Bank Account';
            Description = 'HEI.01 PTPGAP068';
            Editable = false;
            TableRelation = "Vendor Bank Account".Code where("Vendor No." = FIELD("Vendor No."));
        }
        field(50001; "Reversed FND"; Boolean)
        {
            Caption = 'Reversed';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50002; "Fixed Asset Acquisition FND"; Boolean)
        {
            Description = 'HEI.03';
            Caption = 'Fixed Asset Acquisition';
        }
        field(50066; "Document Subtype Code FND"; Code[10])
        {
            Caption = 'Document Subtype Code';
            Description = 'DITW110.00.11 NRQ#17902';
            TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = FILTER(Purchase));
        }
        // field(2014109; "Route Planning No."; Code[20])
        // {
        //     Caption = 'Route Planning No.';
        //     Description = 'DITW110.00.11 NRQ#17902';
        //     TableRelation = "Route Planning Worksheet";
        // }
        // field(2014310; "Service Contract Line No."; Integer)
        // {
        //     CaptionML = ENU = 'Contract Line No.',
        //                 FRA = 'N° ligne contrat';
        //     Description = 'DITW16.00.00.43 DIT-715 #714';
        // }
        // field(2034840; "Building No."; Code[20])
        // {
        //     CaptionML = ENU = 'Building No.',
        //                 FRA = 'N° immeuble';
        //     Description = 'DITW16.00.00.43 DIT-715 #714';
        //     TableRelation = Building;
        // }
        // field(2034850; "DIT Sub-Contract Type"; Option)
        // {
        //     CaptionML = ENU = 'Sub Contract Type',
        //                 FRA = 'Sous type contrat';
        //     Description = 'DITW16.00.00.43 DIT-715 #714';
        //     OptionCaptionML = ENU = ' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
        //                       FRA = ' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
        //     OptionMembers = " ",Rent,Loan,"Loan in use",Maintenance,Other,PlantMaintenance;
        // }
        // field(2034872; "Contract Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Contract Group Code',
        //                 FRA = 'Code groupe contrat';
        //     Description = 'DITW16.00.00.43 DIT-715 #714';
        //     TableRelation = IF ("Contract Type" = CONST(Service),
        //                         "DIT Sub-Contract Type" = FILTER(<> " ")) "Contract Group".Code where("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"))
        //     else IF ("Contract Type" = CONST(Service),
        //                                  "DIT Sub-Contract Type" = CONST(" ")) "Contract Group".Code
        //     else IF ("Contract Type" = CONST(Financial)) "Financial Contract Group".Code where("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
        // }
        // field(2034915; "Service Contract No."; Code[20])
        // {
        //     CaptionML = ENU = 'Service Contract No.',
        //                 FRA = 'N° contrat de service';
        //     Description = 'DITW16.00.00.43 DIT-715 #714';
        //     TableRelation = "Service Purch. Contract Header"."Contract No." where("Contract Type" = CONST(Contract));
        // }
        // field(2034916; "Posting Group"; Code[10])
        // {
        //     CaptionML = ENU = 'Posting Group',
        //                 FRA = 'Groupe comptabilisation';
        //     Description = 'DIT-770 #340';
        // }
        // field(2034917; "Financial Contract No."; Code[20])
        // {
        //     Caption = 'Financial Contract No.';
        //     Description = 'NRQ#45760';
        //     TableRelation = "Financial Contract Header"."Contract No.";
        // }
        // field(2035393; "Contract Type"; Option)
        // {
        //     CaptionML = ENU = 'Contract Type',
        //                 FRA = 'Type contrat';
        //     Description = 'DITW16.00.00.43 DIT-715 #714 - DITW18.00.06 DIT-770 #1368';
        //     OptionCaptionML = ENU = ' ,Service,Financial',
        //                       FRA = ' ,Service,Financier';
        //     OptionMembers = " ",Service,Financial;
        // }  // BC Upgrade NANDIS03
    }
    keys
    {

        //Unsupported feature: Deletion on ""Vendor No.","Currency Code","Vendor Ledg. Entry No.","Dimension Entry No."(Key)". Please convert manually.

        // key(Key1; "Vendor No.", "Currency Code", "Vendor Ledg. Entry No.", "Dimension Entry No.", "Vendor Bank Account")
        // {
        // }  // BC Upgrade NANDIS03

    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

