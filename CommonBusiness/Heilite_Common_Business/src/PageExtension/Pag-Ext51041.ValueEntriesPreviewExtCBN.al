pageextension 51041 ValueEntriesPreviewExtCBN extends "Value Entries Preview"
{


    layout
    {
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the posting date of this entry.', FRA = 'Spécifie la date comptabilisation de cette écriture.';
        }
        modify("Valuation Date")
        {
            ToolTipML = ENU = 'Specifies the valuation date from which the entry is included in the average cost calculation.', FRA = 'Spécifie la date d''évaluation à partir de laquelle cette écriture est incluse dans le calcul du coût moyen.';
        }
        modify("Item Ledger Entry Type")
        {
            ToolTipML = ENU = 'Specifies the type of item ledger entry that caused this value entry.', FRA = 'Spécifie le type d''écriture comptable article à l''origine de cette écriture valeur.';
        }
        modify("Entry Type")
        {
            ToolTipML = ENU = 'Specifies the type of value described in this entry.', FRA = 'Indique le type de valeur décrite dans cette écriture.';
        }
        modify("Variance Type")
        {
            ToolTipML = ENU = 'Contains the type of variance described in this entry.', FRA = 'Contient le type d''écart décrit dans cette écriture.';
        }
        modify(Adjustment)
        {
            ToolTipML = ENU = 'Specifies if this entry has been cost adjusted.', FRA = 'Spécifie si le coût de cette écriture a été ajusté.';
        }
        modify("Document Type")
        {
            ToolTipML = ENU = 'Specifies what type of document was posted to create the value entry.', FRA = 'Indique quel type de document a été validé pour créer l''écriture valeur.';
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies the document number of the entry.', FRA = 'Spécifie le numéro du document de l''écriture.';
        }
        modify("Document Line No.")
        {
            ToolTipML = ENU = 'Specifies the line number of the line on the posted document that corresponds to the value entry.', FRA = 'Indique le numéro de la ligne sur le document validé qui correspond à l''écriture valeur.';
        }
        modify("Item Charge No.")
        {
            ToolTipML = ENU = 'Contains the item charge number of the value entry.', FRA = 'Contient le numéro de frais annexes de l''écriture valeur.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the entry.', FRA = 'Spécifie une description de l''écriture.';
        }
        modify("Return Reason Code")
        {
            ToolTipML = ENU = 'Contains a code that explains why the item is returned.', FRA = 'Contient un code expliquant la raison du renvoi de l''article.';
        }
        modify("Sales Amount (Expected)")
        {
            ToolTipML = ENU = 'Contains the expected price of the item for a sales entry, which means that it has not been invoiced yet.', FRA = 'Contient le prix prévu de l''article pour une écriture vente, ce qui signifie qu''elle n''a pas encore été facturée.';
        }
        modify("Sales Amount (Actual)")
        {
            ToolTipML = ENU = 'Specifies the price of the item for a sales entry.', FRA = 'Spécifie le prix unitaire de l''article pour une écriture vente.';
        }
        modify("Cost Amount (Expected)")
        {
            ToolTipML = ENU = 'Specifies the expected cost of the items, which is calculated by multiplying the Cost per Unit by the Valued Quantity.', FRA = 'Indique le coût prévu des articles, calculé en multipliant les valeurs des champs Coût par unité et Quantité valorisée.';
        }
        modify("Cost Amount (Actual)")
        {
            ToolTipML = ENU = 'Specifies the cost of invoiced items.', FRA = 'Indique le coût des articles facturés.';
        }
        modify("Cost Amount (Non-Invtbl.)")
        {
            ToolTipML = ENU = 'Specifies the non-inventoriable cost, that is an item charge assigned to an outbound entry.', FRA = 'Indique le coût non valorisable ajusté, c''est-à-dire les frais annexes affectés à une écriture sortante.';
        }
        modify("Cost Posted to G/L")
        {
            ToolTipML = ENU = 'Specifies the amount that has been posted to the general ledger.', FRA = 'Indique le montant validé dans le grand livre.';
        }
        modify("Expected Cost Posted to G/L")
        {
            ToolTipML = ENU = 'Specifies the expected cost amount that has been posted to the interim account in the general ledger.', FRA = 'Spécifie le montant coût prévu validé sur les comptes d''attente dans le grand livre.';
        }
        modify("Cost Amount (Expected) (ACY)")
        {
            ToolTipML = ENU = 'Contains the expected cost of the items in the additional reporting currency.', FRA = 'Contient le coût prévu des articles dans la devise report supplémentaire.';
        }
        modify("Cost Amount (Actual) (ACY)")
        {
            ToolTipML = ENU = 'Specifies the cost of the items that have been invoiced, if you post in an additional reporting currency.', FRA = 'Spécifie le coût des articles facturés, si vous validez dans une devise report.';
        }
        modify("Cost Amount (Non-Invtbl.)(ACY)")
        {
            ToolTipML = ENU = 'Contains the non-inventoriable cost, that is an item charge assigned to an outbound entry in the additional reporting currency.', FRA = 'Contient le coût non valorisable, c''est-à-dire les frais annexes affectés à une écriture sortante en devise report.';
        }
        modify("Cost Posted to G/L (ACY)")
        {
            ToolTipML = ENU = 'Specifies the amount that has been posted to the general ledger if you post in an additional reporting currency.', FRA = 'Indique le montant validé dans le grand livre si vous validez dans une devise report.';
        }
        modify("Item Ledger Entry Quantity")
        {
            ToolTipML = ENU = 'Specifies the average cost calculation.', FRA = 'Indique le calcul du coût moyen.';
        }
        modify("Valued Quantity")
        {
            ToolTipML = ENU = 'Specifies the quantity that the adjusted cost and the amount of the entry belongs to.', FRA = 'Indique la quantité à laquelle le coût ajusté et le montant de l''écriture appartiennent.';
        }
        modify("Invoiced Quantity")
        {
            ToolTipML = ENU = 'Specifies how many units of the item are invoiced by the posting that the value entry line represents.', FRA = 'Indique combien d''unités de l''article sont facturées par la validation représentée par la ligne écriture valeur.';
        }
        modify("Cost per Unit")
        {
            ToolTipML = ENU = 'Specifies the cost for one base unit of the item in the entry.', FRA = 'Spécifie le coût d''une unité de base de l''article de l''écriture.';
        }
        modify("Cost per Unit (ACY)")
        {
            ToolTipML = ENU = 'Specifies the cost of one unit of the item in the entry.', FRA = 'Spécifie le coût d''une unité de l''article de l''écriture.';
        }
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item that this value entry is linked to.', FRA = 'Spécifie le numéro de l''article auquel cette valeur est liée.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Contains the code for the location of the item that the entry is linked to.', FRA = 'Contient le code du magasin de l''article lié à l''écriture.';
        }
        modify(Type)
        {
            ToolTipML = ENU = 'Contains the type of value entry when it relates to a capacity entry.', FRA = 'Contient le type d''écriture valeur lorsqu''elle est liée à une écriture capacité.';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Contains the number of a work center or a machine center, depending on the entry in the Type field.', FRA = 'Contient le numéro du poste de charge ou du centre de charge correspondant à l''écriture du champ Type.';
        }
        modify("Discount Amount")
        {
            ToolTipML = ENU = 'Specifies the total discount amount of this value entry.', FRA = 'Indique le montant remise total de cette écriture valeur.';
        }
        modify("Salespers./Purch. Code")
        {
            ToolTipML = ENU = 'Specifies which salesperson or purchaser is linked to the entry.', FRA = 'Indique le code du vendeur ou de l''acheteur qui est lié à l''écriture.';
        }
        modify("User ID")
        {
            ToolTipML = ENU = 'Contains the ID of the user who is associated with the entry.', FRA = 'Contient le code de l''utilisateur qui est associé à l''écriture.';
        }
        modify("Source Posting Group")
        {
            ToolTipML = ENU = 'Specifies the posting group for the item, customer, or vendor for the item entry that this value entry is linked to.', FRA = 'Indique le groupe comptabilisation de l''article, du client ou du fournisseur de l''écriture article qui est elle-même liée à cette écriture valeur.';
        }
        modify("Source Code")
        {
            ToolTipML = ENU = 'Contains the source code that is linked to the entry.', FRA = 'Contient le code source lié à l''écriture.';
        }
        modify("Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the general business posting group that applies to the entry.', FRA = 'Spécifie le groupe comptabilisation marché qui s''applique à cette écriture.';
        }
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code for the general product posting group that applies to the entry.', FRA = 'Spécifie le code du groupe comptabilisation produit qui s''applique à cette écriture.';
        }
        modify("Global Dimension 1 Code")
        {
            ToolTipML = ENU = 'Contains the dimension value code for the dimension that has been chosen as Global Dimension 1.', FRA = 'Contient le code section analytique de l''axe choisi comme axe principal 1.';
        }
        modify("Global Dimension 2 Code")
        {
            ToolTipML = ENU = 'Contains the dimension value code for the dimension that has been chosen as Global Dimension 2.', FRA = 'Contient le code section analytique de l''axe choisi comme axe principal 2.';
        }
        modify("Source Type")
        {
            ToolTipML = ENU = 'Specifies the source type that applies to the source number that is shown in the Source No. field.', FRA = 'Spécifie le type source qui s''applique au numéro origine indiqué dans le champ N° origine.';
        }
        modify("Source No.")
        {
            ToolTipML = ENU = 'Specifies where the entry originated.', FRA = 'Affiche l''origine de l''écriture.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Contains the date on the document that provides the basis for this value entry.', FRA = 'Contient la date du document servant de base à l''écriture valeur.';
        }
        modify("External Document No.")
        {
            ToolTipML = ENU = 'Specifies the external document number that provides the basis for this value entry.', FRA = 'Spécifie le numéro du document externe servant de base à l''écriture valeur.';
        }
        modify("Order Type")
        {
            ToolTipML = ENU = 'Specifies which type of transaction the entry is created from.', FRA = 'Spécifie le type de transaction à partir duquel l''écriture est créée.';
        }
        modify("Order No.")
        {
            ToolTipML = ENU = 'Contains the number of the order that created the entry.', FRA = 'Contient le numéro de l''ordre ayant créé l''écriture.';
        }
        modify("Valued By Average Cost")
        {
            ToolTipML = ENU = 'Specifies if the adjusted cost for the inventory decrease is calculated by the average cost of the item at the valuation date.', FRA = 'Spécifie le coût ajusté de la sortie du stock est calculé en fonction du coût moyen de l''article à la date d''évaluation.';
        }
        modify("Job No.")
        {
            ToolTipML = ENU = 'Specifies the number of the job that the value entry relates to.', FRA = 'Spécifie le numéro du projet auquel l''écriture valeur est associée.';
        }
        modify("Job Task No.")
        {
            ToolTipML = ENU = 'Specifies the job task that is associated with the value entry.', FRA = 'Spécifie le numéro de la tâche projet associée à l''écriture valeur.';
        }
        modify("Job Ledger Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number of the job ledger entry that the value entry relates to.', FRA = 'Spécifie le numéro de l''écriture comptable projet à laquelle l''écriture valeur est associée.';
        }
    }

    //Unsupported feature: CodeModification on "Set(PROCEDURE 1)". Please convert manually.

    //procedure Set();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF TempValueEntry.FIND('-') THEN
      REPEAT
        Rec := TempValueEntry;
        INSERT;
      UNTIL TempValueEntry.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if TempValueEntry.FIND('-') then
      repeat
        Rec := TempValueEntry;
        INSERT;
      until TempValueEntry.NEXT = 0;
    */
    //end;

    //Unsupported feature: PropertyChange. Please convert manually.

}

