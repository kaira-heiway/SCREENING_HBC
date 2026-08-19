tableextension 50010 ReasoCodeExtFND extends "Reason Code"
{
    // version NAVW19.00
    // BC Upgrade SHUKLP03 >> OTC221: Add 50000 to 50007 fields.

    fields
    {
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify("Contract Gain/Loss Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Contract Gain/Loss Amount"(Field 5901)". Please convert manually.

            CaptionML = ENU = 'Contract Gain/Loss Amount', FRA = 'Montant gain/perte contrat';
        }
        // BC Upgrade SHUKLP03 >> OTC221
        field(50000; "Allow VAT Calculation FND"; boolean)
        {
            CaptionML = ENU = 'Allow VAT Calculation', FRA = 'Autoriser le calcul de la TVA';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //<< NRQ151359 AKH 17/07/2020
                IF "Allow VAT Calculation FND" <> xRec."Allow VAT Calculation FND" THEN
                    IF "Allow VAT Calculation FND" THEN
                        Rec.TESTFIELD("Free Item Posting Type FND", "Free Item Posting Type FND"::" ");
                //>> NRQ151359 AKH 17/07/2020
            end;
        }
        field(50001; "Gen. Bus. Posting Group FND"; Code[10])
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group',
                        FRA = 'Groupe compta. marché';
            Description = 'HEI.02';
            TableRelation = "Gen. Business Posting Group";
        }
        field(50002; "Free Item Posting Type FND"; Enum "Free Item Posting Type FND")
        {
            CaptionML = ENU = 'Free Item Posting Type', FRA = 'Type de comptabilisation des articles gratuits';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //<< NRQ151359 AKH 17/07/2020
                IF "Free Item Posting Type FND" <> xRec."Free Item Posting Type FND" THEN
                    IF "Free Item Posting Type FND" IN ["Free Item Posting Type FND"::FullAmount, "Free Item Posting Type FND"::Amount] THEN
                        "Allow VAT Calculation FND" := FALSE;
                //>> NRQ151359 AKH 17/07/2020
            end;
        }
        field(50003; "Customer Price Group FND"; Code[10])
        {
            CaptionML = ENU = 'Customer Price Group',
                        FRA = 'Groupe prix client';
            Description = 'NRQ151359';
            TableRelation = "Customer Price Group";
        }
        field(50004; "Customer Disc. Group FND"; Code[20])
        {
            CaptionML = ENU = 'Customer Disc. Group',
                        FRA = 'Groupe rem. client';
            Description = 'NRQ151359';
            TableRelation = "Customer Discount Group";
        }
        field(50005; "Calculate on Free (Tax) FND"; Option)
        {
            CaptionML = ENU = 'Calculate Price on Free (Tax)',
                        FRA = 'Calculer Prix sur gratuit (Taxe)';
            Description = 'NRQ152558';
            OptionCaptionML = ENU = ' ,None,Discount 100%,Full Amount',
                              FRA = ' ,Aucun,Remise 100%,Montant';
            OptionMembers = " ","None","Discount 100%",FullAmount;
        }
        field(50006; "Calculate on Free (Depo) FND"; Option)
        {
            CaptionML = ENU = 'Calculate Price on Free (Deposit)',
                        FRA = 'Calculer Prix sur gratuit (Consigne)';
            Description = 'NRQ152558';
            OptionCaptionML = ENU = ' ,None,Discount 100%,Full Amount',
                              FRA = ' ,Aucun,Remise 100%,Montant';
            OptionMembers = " ","None","Discount 100%",FullAmount;
        }
        field(50007; "Calculate on Free (Disc) FND"; Option)
        {
            CaptionML = ENU = 'Calculate Price on Free (Discount)',
                        FRA = 'Calculer Prix sur gratuit (Remise)';
            Description = 'NRQ152558';
            OptionCaptionML = ENU = ' ,None,Discount 100%,Full Amount',
                              FRA = ' ,Aucun,Remise 100%,Montant';
            OptionMembers = " ","None","Discount 100%",FullAmount;
        }
        // BC Upgrade SHUKLP03 << OTC221


    }

    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

