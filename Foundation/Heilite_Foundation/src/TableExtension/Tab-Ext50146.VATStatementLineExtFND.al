tableextension 50146 VATStatementLineExtFND extends "VAT Statement Line"
{
    //   HEI.01 FDD-SLSGAP001 IBM NASTAA02 08.09.2017 # MDM Customer Card
    //   # Increased "Src. DTax Group Code" field length from 10 to 20 characters
    // version NAVW110.0,DITW110.00.08,HEI.01

    fields
    {
        modify("Statement Template Name")
        {
            CaptionML = ENU = 'Statement Template Name', FRA = 'Nom modèle déclaration';
        }
        modify("Statement Name")
        {
            CaptionML = ENU = 'Statement Name', FRA = 'Nom de la déclaration';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify("Row No.")
        {
            CaptionML = ENU = 'Row No.', FRA = 'N° ligne totalisation';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            // OptionCaptionML = ENU = 'Account Totaling,VAT Entry Totaling,Row Totaling,Description,,,,Tax Value Entry Totaling', FRA = 'Compte totalisation,Totalisation écriture TVA,Totalisation rangée,Description,,,,Totalisation écriture valeur taxe';

            //Unsupported feature: Change OptionString on "Type(Field 6)". Please convert manually.


            //Unsupported feature: Change Description on "Type(Field 6)". Please convert manually.

        }
        modify("Account Totaling")
        {
            CaptionML = ENU = 'Account Totaling', FRA = 'Totalisation comptes';
        }
        modify("Gen. Posting Type")
        {
            CaptionML = ENU = 'Gen. Posting Type', FRA = 'Type compta. TVA';
            // OptionCaptionML = ENU = ' ,Purchase,Sale,Settlement', FRA = ' ,Achat,Vente,Règlement';
        }
        modify("VAT Bus. Posting Group")
        {
            CaptionML = ENU = 'VAT Bus. Posting Group', FRA = 'Groupe compta. marché TVA';
        }
        modify("VAT Prod. Posting Group")
        {
            CaptionML = ENU = 'VAT Prod. Posting Group', FRA = 'Groupe compta. produit TVA';
        }
        modify("Row Totaling")
        {
            CaptionML = ENU = 'Row Totaling', FRA = 'Total de lignes';
        }
        modify("Amount Type")
        {
            CaptionML = ENU = 'Amount Type', FRA = 'Type montant';
            // OptionCaptionML = ENU = ' ,Amount,Base,Unrealized Amount,Unrealized Base,,,,,Due Amount,,,,,Quantity,Quantity /Unit', FRA = ' ,Montant,Base,Montant non réalisé,Base non réalisée,,,,,Montant dû,,,,,Quantité,Quantité/Unité';

            //Unsupported feature: Change OptionString on ""Amount Type"(Field 12)". Please convert manually.


            //Unsupported feature: Change Description on ""Amount Type"(Field 12)". Please convert manually.

        }
        modify("Calculate with")
        {
            CaptionML = ENU = 'Calculate with', FRA = 'Signe calcul';
            OptionCaptionML = ENU = 'Sign,Opposite Sign', FRA = 'Normal,Opposé';
        }
        modify(Print)
        {
            CaptionML = ENU = 'Print', FRA = 'Imprimer';
        }
        modify("Print with")
        {
            CaptionML = ENU = 'Print with', FRA = 'Signe impression';
            OptionCaptionML = ENU = 'Sign,Opposite Sign', FRA = 'Normal,Opposé';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify("New Page")
        {
            CaptionML = ENU = 'New Page', FRA = 'Nouvelle page';
        }
        modify("Tax Jurisdiction Code")
        {
            CaptionML = ENU = 'Tax Jurisdiction Code', FRA = 'USA code autorités recouvrem.';
        }
        modify("Use Tax")
        {
            CaptionML = ENU = 'Use Tax', FRA = 'Use Tax';
        }

        //Unsupported feature: CodeModification on ""Account Totaling"(Field 7).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Account Totaling" <> '' then begin
          GLAcc.SETFILTER("No.","Account Totaling");
          GLAcc.SETFILTER("Account Type",'<> 0');
          if GLAcc.FINDFIRST then
            GLAcc.TESTFIELD("Account Type",GLAcc."Account Type"::Posting);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.30 27/01/2009
        if ("Account Totaling" <> '') and (Type = Type::"Tax Value Entry Totaling") then
          FIELDERROR(Type,STRSUBSTNO(Text000,Type));
        // >>DITW15.00.00.30

        #1..6
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Gen. Posting Type"(Field 8)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.30 DDR 19/01/2009
        if xRec."Gen. Posting Type" <> "Gen. Posting Type" then
          "Src. DTax Group Code" := '';

        "Value Entry Type Filter" := '';
        "Item Ledger Entry Type Filter" := '';
        // >>DITW15.00.00.30 DDR
        */
        //end;


        //Unsupported feature: CodeInsertion on ""VAT Bus. Posting Group"(Field 9)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.01 27/12/2007
        if ("VAT Bus. Posting Group" <> '') and (Type = Type::"Tax Value Entry Totaling") then
          FIELDERROR(Type,STRSUBSTNO(Text000,Type));
        // >>DITW15.00.00.01
        */
        //end;


        //Unsupported feature: CodeInsertion on ""VAT Prod. Posting Group"(Field 10)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.01 27/12/2007
        if ("VAT Prod. Posting Group" <> '') and (Type = Type::"Tax Value Entry Totaling") then
          FIELDERROR(Type,STRSUBSTNO(Text000,Type));
        // >>DITW15.00.00.01
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Amount Type"(Field 12)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.01 27/12/2008 - DITW15.00.00.30 DDR 20/01/2009 - DITW15.00.00.31 DDR 20/02/2009
        if not
          ("Amount Type" in
            ["Amount Type"::" ","Amount Type"::Amount,"Amount Type"::"Due Amount","Amount Type"::Quantity,"Amount Type"::QuantityHL]) and
          (Type = Type::"Tax Value Entry Totaling")
        then
          FIELDERROR(Type,STRSUBSTNO(Text000,Type));
        // >>DITW15.00.00.31 DDR
        */
        //end;
        //BC Upgrade KAPOOV01 Drink-it Start>>
        // field(2013651; "Src. DTax Group Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Source Tax Group',
        //                 FRA = 'Groupe origine taxe';
        //     Description = 'DITW15.00.00.30,HEI.01';
        //     TableRelation = IF (Type = CONST("Tax Value Entry Totaling"),
        //                         "Gen. Posting Type" = CONST(" ")) "Drink Tax Group".Code where("Source Type" = CONST(" "))
        //     else IF (Type = CONST("Tax Value Entry Totaling"),
        //                                  "Gen. Posting Type" = CONST(Purchase)) "Drink Tax Group".Code where("Source Type" = CONST(Vendor))
        //     else IF (Type = CONST("Tax Value Entry Totaling"),
        //                                           "Gen. Posting Type" = CONST(Sale)) "Drink Tax Group".Code where("Source Type" = CONST(Customer))
        //     else IF (Type = CONST("Tax Value Entry Totaling"),
        //                                                    "Gen. Posting Type" = CONST(Settlement)) "Drink Tax Group".Code where("Source Type" = FILTER(Customer | Vendor));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.30 DDR 19/01/2009
        //         if ("Src. DTax Group Code" <> '') and (Type <> Type::"Tax Value Entry Totaling") then
        //             FIELDERROR(Type, STRSUBSTNO(Text000, Type));
        //     end;
        // }
        // field(2013697; "Item Charge No. Filter"; Code[20])
        // {
        //     CaptionML = ENU = 'Item Charge No. Filter',
        //                 FRA = 'Filtre n° frais annexes';
        //     Description = 'DITW15.00.00.30';
        //     TableRelation = IF (Type = CONST("Tax Value Entry Totaling")) "Item Charge" where("Item Charge Type" = FILTER(Tax));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.30 DDR 19/01/2009
        //         if ("Item Charge No. Filter" <> '') and (Type <> Type::"Tax Value Entry Totaling") then
        //             FIELDERROR(Type, STRSUBSTNO(Text000, Type));
        //     end;
        // }
        // field(2013702; "Gen. Bus. Posting Group"; Code[10])
        // {
        //     CaptionML = ENU = 'Gen. Bus. Posting Group',
        //                 FRA = 'Groupe compta. marché';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = IF (Type = CONST("Tax Value Entry Totaling")) "Gen. Business Posting Group";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.01 27/12/2007
        //         if ("Gen. Bus. Posting Group" <> '') and (Type <> Type::"Tax Value Entry Totaling") then
        //             FIELDERROR(Type, STRSUBSTNO(Text000, Type));
        //     end;
        // }
        // field(2013703; "Gen. Prod. Posting Group"; Code[10])
        // {
        //     CaptionML = ENU = 'Gen. Prod. Posting Group',
        //                 FRA = 'Groupe compta. produit';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = IF (Type = CONST("Tax Value Entry Totaling")) "Gen. Product Posting Group";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.01 27/12/2007
        //         if ("Gen. Prod. Posting Group" <> '') and (Type <> Type::"Tax Value Entry Totaling") then
        //             FIELDERROR(Type, STRSUBSTNO(Text000, Type));
        //     end;
        // }
        // field(2013720; "Tax Specification Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Tax Specification Code',
        //                 FRA = 'Code spécification taxe';
        //     Description = 'DITW15.00.00.24';
        //     TableRelation = "Tax Specification";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.24 DDR 24/09/2008
        //         if ("Tax Specification Code" <> '') and (Type <> Type::"Tax Value Entry Totaling") then
        //             FIELDERROR(Type, STRSUBSTNO(Text000, Type));
        //     end;
        // }
        // field(2013749; "Value Entry Type Filter"; Text[100])
        // {
        //     CaptionML = ENU = 'Value Entry Type Filter',
        //                 FRA = 'Filtre type écriture valeur';
        //     Description = 'DITW15.00.00.30';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.30 DDR 19/01/2009
        //         if ("Value Entry Type Filter" <> '') and (Type <> Type::"Tax Value Entry Totaling") then
        //             FIELDERROR(Type, STRSUBSTNO(Text000, Type));

        //         cduTaxSettMgt.ValidateFilter(
        //           "Value Entry Type Filter", DATABASE::"VAT Statement Line",
        //           FIELDNO("Value Entry Type Filter"), true);
        //     end;
        // }
        // field(2013750; "Item Ledger Entry Type Filter"; Text[100])
        // {
        //     CaptionML = ENU = 'Item Ledger Entry Type Filter',
        //                 FRA = 'Filtre type écr. article';
        //     Description = 'DITW15.00.00.30';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.30 DDR 19/01/2009
        //         if ("Item Ledger Entry Type Filter" <> '') and (Type <> Type::"Tax Value Entry Totaling") then
        //             FIELDERROR(Type, STRSUBSTNO(Text000, Type));

        //         cduTaxSettMgt.ValidateFilter(
        //           "Item Ledger Entry Type Filter", DATABASE::"VAT Statement Line",
        //           FIELDNO("Item Ledger Entry Type Filter"), true);

        //         if ("Item Ledger Entry Type Filter" <> '') then
        //             TESTFIELD("Gen. Posting Type", "Gen. Posting Type"::" ")
        //         else begin
        //             if Type = Type::"Tax Value Entry Totaling" then
        //                 "Gen. Posting Type" := "Gen. Posting Type"::Sale;
        //         end;
        //     end;
        // }
        // field(2013752; "Return Reason Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Return Reason Code',
        //                 FRA = 'Code motif retour';
        //     Description = 'DITW15.00.00.31';
        //     TableRelation = "Return Reason";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.31 DDR 18/02/2009
        //         if ("Return Reason Code" <> '') and (Type <> Type::"Tax Value Entry Totaling") then
        //             FIELDERROR(Type, STRSUBSTNO(Text000, Type));
        //     end;
        // }
        // field(2013767; "Item DTax Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Tax Group',
        //                 FRA = 'Groupe article taxe';
        //     Description = 'DITW15.00.00.30';
        //     TableRelation = IF (Type = CONST("Tax Value Entry Totaling")) "Drink Tax Group".Code where("Source Type" = CONST(Item));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.30 DDR 19/01/2009
        //         if ("Item DTax Group Code" <> '') and (Type <> Type::"Tax Value Entry Totaling") then
        //             FIELDERROR(Type, STRSUBSTNO(Text000, Type));
        //     end;
        // }
        // field(2014441; "Location Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Location Code',
        //                 FRA = 'Code magasin';
        //     Description = 'DITW15.00.00.30';
        //     TableRelation = IF (Type = CONST("Tax Value Entry Totaling"),
        //                         "Location Group Type" = CONST(" ")) Location
        //     else IF (Type = CONST("Tax Value Entry Totaling"),
        //                                  "Location Group Type" = CONST(Group)) "Location Group";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.30 DDR 19/01/2009
        //         if ("Location Code" <> '') and (Type <> Type::"Tax Value Entry Totaling") then
        //             FIELDERROR(Type, STRSUBSTNO(Text000, Type));
        //     end;
        // }
        // field(2014442; "Location Group Type"; Option)
        // {
        //     CaptionML = ENU = 'Location Tax Group Type',
        //                 FRA = 'Type groupe magasin taxe';
        //     Description = 'DITW15.00.00.30';
        //     OptionCaptionML = ENU = ' ,Group',
        //                       FRA = ' ,Groupe';
        //     OptionMembers = " ",Group;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.30 DDR 19/01/2009
        //         if ("Location Group Type" > 0) and (Type <> Type::"Tax Value Entry Totaling") then
        //             FIELDERROR(Type, STRSUBSTNO(Text000, Type));

        //         if xRec."Location Group Type" <> "Location Group Type" then
        //             "Location Code" := '';
        //     end;
        // }
        //BC Upgrade KAPOOV01 Drink-it End<<
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=must not be %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=must not be %1;FRA=ne doit pas être %1;
    //Variable type has not been exported.

    var
        //rTaxGroup: Record "Drink Tax Group";//BC Upgrade KAPOOV01 Drink-it
        rTempValueEntry: Record "Value Entry" temporary;
    //cduTaxSettMgt: Codeunit "Tax Settlement Mgt";//BC Upgrade KAPOOV01 Drink-it
}

