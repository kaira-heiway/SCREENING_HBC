tableextension 50177 CustomerTemplExtFND extends "Customer Templ."
{
    //BC UPGRADE PATHAA02 13.11.25-->Fields 50010 & 50011 commented -->Already available in Standard table 1381-Customer Templ.
    //New Enum Extension created to add Payment value to standard Enum 139
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
        modify("Territory Code")
        {
            CaptionML = ENU = 'Territory Code', FRA = 'Code secteur';
        }
        modify("Global Dimension 1 Code")
        {
            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {
            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }
        modify("Customer Posting Group")
        {
            CaptionML = ENU = 'Customer Posting Group', FRA = 'Groupe compta. client';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Customer Price Group")
        {
            CaptionML = ENU = 'Customer Price Group', FRA = 'Groupe prix client';
        }
        modify("Payment Terms Code")
        {
            CaptionML = ENU = 'Payment Terms Code', FRA = 'Code conditions paiement';
        }
        modify("Shipment Method Code")
        {
            CaptionML = ENU = 'Shipment Method Code', FRA = 'Code condition livraison';
        }
        modify("Invoice Disc. Code")
        {
            CaptionML = ENU = 'Invoice Disc. Code', FRA = 'Code remise facture';
        }
        modify("Customer Disc. Group")
        {
            CaptionML = ENU = 'Customer Disc. Group', FRA = 'Groupe rem. client';
        }
        modify("Country/Region Code")
        {
            CaptionML = ENU = 'Country/Region Code', FRA = 'Code pays/région';
        }
        modify("Payment Method Code")
        {
            CaptionML = ENU = 'Payment Method Code', FRA = 'Code mode de règlement';
        }
        modify("Gen. Bus. Posting Group")
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group', FRA = 'Groupe compta. marché';
        }
        modify("VAT Bus. Posting Group")
        {
            CaptionML = ENU = 'VAT Bus. Posting Group', FRA = 'Groupe compta. marché TVA';
        }
        modify("Allow Line Disc.")
        {
            CaptionML = ENU = 'Allow Line Disc.', FRA = 'Autoriser remise ligne';
        }

        field(50000; "Account Group FND"; Code[20])
        {
            Caption = 'Account Group';
            Description = 'HEI.02';
            TableRelation = "Account Group FND";
        }
        field(50001; "Credit Limit FND"; Boolean)
        {
            CaptionML = ENU = 'Credit Limit',
                        FRA = 'Credit Limit';
            Description = 'HEI.04';
        }
        field(50002; "Risk Category FND"; Code[20])
        {
            Caption = 'Risk Category';
            Description = 'HEI.04';
            TableRelation = "Risk Grade FND".Code;
        }
        field(50003; "Invoice Method FND"; Option)
        {
            CaptionML = ENU = 'Invoice Method',
                        FRA = 'Méthode de facturation';
            Description = 'HEI.04';
            OptionCaptionML = ENU = ' ,Shipment,Order,Combine Shipments,Combine Shipments Per Sell-to',
                              FRA = ' ,Expédition,Commande,Combiner expeditions,Combiner les expeditions par donneur d''ordre';
            OptionMembers = " ",Shipment,"Order","Combine Shipments","Combine Shipments Per Sell-to";

        }
        field(50004; "Customer DDeposit Grp Code FND"; Code[10])
        {
            CaptionML = ENU = 'Customer Deposit Group Code',
                        FRA = 'Code groupe consigne client';
            Description = 'HEI.04';
            // TableRelation = "Drink Deposit Group".Code where("Source Type" = CONST(Customer));
        }
        field(50005; "Gen. Bus. Posting Free Grp FND"; Code[10])
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group Free item',
                        FRA = 'Groupe article gratuit compta. marché';
            Description = 'HEI.04';
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate();
            begin
                if "Gen. Bus. Posting Free Grp FND" = '' then
                    "Free Item Posting Type FND" := "Free Item Posting Type FND"::" ";
            end;
        }
        field(50006; "Free Item Posting Type FND"; Option)
        {
            CaptionML = ENU = 'Calculate Price on Free',
                        FRA = 'Calculer Prix sur gratuit';
            Description = 'HEI.04';
            OptionCaptionML = ENU = ' ,Price 0,Discount 100%',
                              FRA = ' ,Prix 0,Remise 100%';
            OptionMembers = " ",Price,Amount;

            trigger OnValidate();
            begin
                if "Free Item Posting Type FND" = "Free Item Posting Type FND"::" " then
                    "Gen. Bus. Posting Free Grp FND" := '';
            end;
        }
        field(50007; "WHT Business Posting Group FND"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            Description = 'HEI.04';
            TableRelation = "WHT Business Posting Group FND".Code;
        }
        field(50008; "Risk Score FND"; Integer)
        {
            Caption = 'Risk Score';
            Description = 'HEI.04';
            TableRelation = "Risk Score FND".Code;

            trigger OnValidate();
            var
                RiskGrade: Record "Risk Grade FND";
                SalesSetup: Record "Sales & Receivables Setup";
            begin

                //HEI.22>>
                SalesSetup.GET();
                if "Risk Score FND" = SalesSetup."Default Risk Score FND" then
                    "Risk Category FND" := SalesSetup."Default Risk Grade FND"
                else begin
                    if RiskGrade.findset() then
                        repeat
                            if (("Risk Score FND" >= RiskGrade."Lower Margin") and ("Risk Score FND" <= RiskGrade."Upper Margin")) or
                                (("Risk Score FND" >= RiskGrade."Lower Margin") and (RiskGrade."Upper Margin" = 0))
                            then
                                "Risk Category FND" := RiskGrade.Code;
                        until RiskGrade.NEXT() = 0;
                end;
                //HEI.22<<
            end;
        }
        field(50009; "RPM Exposure FND"; Decimal)
        {
            Caption = 'RPM Exposure';
            Description = 'HEI.04';
        }

        //BC UPGRADE PATHAA02 -Already available in Standard table 1381-Customer Templ.<<
        // field(50010; "Credit Limit (LCY)"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     CaptionML = ENU = 'Credit Limit (LCY)',
        //                 FRA = 'Crédit autorisé DS';
        //     Description = 'HEI.04';
        // } 

        // field(50011; Blocked; Option)
        // {
        //     Description = 'HEI.05';
        //     OptionCaptionML = ENU = ' ,Ship,Invoice,All,Payment',
        //                       FRA = ' ,Livrer,Facturer,Tous,Paiement';
        //     OptionMembers = " ",Ship,Invoice,All,Payment;
        // }
        //BC UPGRADE PATHAA02 -Already available in Standard table 1381-Customer Templ.<<

    }

}

