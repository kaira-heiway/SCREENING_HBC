pageextension 51037 ValueEntriesExtCBN extends "Value Entries"
{
    // HEI.01 FDD-BPMGAP BRD HB398 IBM NASTAA02 03.09.2019 # Actual Product Costing
    //# New Field added: "Cost Amount (Purchase)"
    //HEI.02 HT1615 BULIMC01 IBM 16.09.2020 ##new fields added -"Zone Code","Bin Code"

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
            ToolTipML = ENU = 'Specifies the type of variance described in this entry.', FRA = 'Indique le type d''écart décrit dans cette écriture.';
        }
        modify(Adjustment)
        {
            ToolTipML = ENU = 'Specifies this field was inserted by the Adjust Cost - Item Entries batch job, if it contains a check mark.', FRA = 'Indique que ce champ a été inséré par le traitement par lots Ajuster coûts : Écr. article, s''il contient une coche.';
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
            ToolTipML = ENU = 'Specifies the item charge number of the value entry.', FRA = 'Indique le numéro de frais annexes de l''écriture valeur.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the entry.', FRA = 'Spécifie une description de l''écriture.';
        }
        modify("Return Reason Code")
        {
            ToolTipML = ENU = 'Specifies a code that explains why the item is returned.', FRA = 'Spécifie un code expliquant la raison du renvoi de l''article.';
        }
        modify("Sales Amount (Expected)")
        {
            ToolTipML = ENU = 'Specifies the expected price of the item for a sales entry, which means that it has not been invoiced yet.', FRA = 'Indique le prix prévu de l''article pour une écriture vente, ce qui signifie qu''elle n''a pas encore été facturée.';
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
            ToolTipML = ENU = 'Specifies the expected cost of the items in the additional reporting currency.', FRA = 'Spécifie le coût prévu des articles en devise report.';
        }
        modify("Cost Amount (Actual) (ACY)")
        {
            ToolTipML = ENU = 'Specifies the cost of the items that have been invoiced, if you post in an additional reporting currency.', FRA = 'Spécifie le coût des articles facturés, si vous validez dans une devise report.';
        }
        modify("Cost Amount (Non-Invtbl.)(ACY)")
        {
            ToolTipML = ENU = 'Specifies the non-inventoriable cost, that is an item charge assigned to an outbound entry in the additional reporting currency.', FRA = 'Spécifie le coût non valorisable ajusté, c''est-à-dire les frais annexes affectés à une écriture sortante en devise report.';
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
            ToolTipML = ENU = 'Specifies the code for the location of the item that the entry is linked to.', FRA = 'Indique le code magasin de l''article lié à l''écriture.';
        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the type of value entry when it relates to a capacity entry.', FRA = 'Spécifie le type d''écriture valeur lorsqu''elle est liée à une écriture capacité.';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of a work center or a machine center, depending on the entry in the Type field.', FRA = 'Indique le numéro du poste de charge ou du centre de charge correspondant à l''écriture du champ Type.';
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
            ToolTipML = ENU = 'Specifies the ID of the user who is associated with the entry.', FRA = 'Spécifie le code de l''utilisateur qui est associé à l''écriture.';
        }
        modify("Source Posting Group")
        {
            ToolTipML = ENU = 'Specifies the posting group for the item, customer, or vendor for the item entry that this value entry is linked to.', FRA = 'Indique le groupe comptabilisation de l''article, du client ou du fournisseur de l''écriture article qui est elle-même liée à cette écriture valeur.';
        }
        modify("Source Code")
        {
            ToolTipML = ENU = 'Specifies the source code that is linked to the entry.', FRA = 'Spécifie le code source lié à l''écriture.';
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
            ToolTipML = ENU = 'Specifies the dimension value code for the dimension that has been chosen as Global Dimension 1.', FRA = 'Spécifie le code section analytique de l''axe choisi comme axe principal 1.';
        }
        modify("Global Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code for the dimension that has been chosen as Global Dimension 2.', FRA = 'Spécifie le code section analytique de l''axe choisi comme axe principal 2.';
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
            ToolTipML = ENU = 'Specifies the date on the document that provides the basis for this value entry.', FRA = 'Spécifie la date du document servant de base à l''écriture valeur.';
        }
        modify("External Document No.")
        {
            ToolTipML = ENU = 'Specifies the external document number that provides the basis for this value entry.', FRA = 'Spécifie le numéro du document externe servant de base à l''écriture valeur.';
        }
        modify("Order Type")
        {
            ToolTipML = ENU = 'Specifies which type of order that the entry was created in.', FRA = 'Spécifie le type de commande dans laquelle l''écriture a été créée.';
        }
        modify("Order No.")
        {
            ToolTipML = ENU = 'Specifies the number of the order that created the entry.', FRA = 'Spécifie le numéro de la commande qui a créé l''écriture.';
        }
        modify("Valued By Average Cost")
        {
            ToolTipML = ENU = 'Specifies if the adjusted cost for the inventory decrease is calculated by the average cost of the item at the valuation date.', FRA = 'Spécifie le coût ajusté de la sortie du stock est calculé en fonction du coût moyen de l''article à la date d''évaluation.';
        }
        modify("Item Ledger Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item ledger entry that this value entry is linked to.', FRA = 'Spécifie le numéro de l''écriture comptable article auquel cette valeur est liée.';
        }
        modify("Capacity Ledger Entry No.")
        {
            ToolTipML = ENU = 'Specifies the entry number of the item ledger entry that this value entry is linked to.', FRA = 'Spécifie le numéro d''écriture de l''écriture comptable article auquel cette valeur est liée.';
        }
        modify("Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number that has been assigned to the entry.', FRA = 'Spécifie le numéro affecté à l''écriture.';
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
        //BC Upgrade PATHAA02-DIT>>
        // addafter("Document Line No.")
        // {
        //     field("Item Charge Type";Rec."Item Charge Type")
        //     {
        //     }
        // } 


        // addafter(Description)
        // {
        // field("Free Item"; Rec."Free Item")
        // {
        //     Visible = false;
        // }
        // field("Free Reason Code"; Rec."Free Reason Code")
        // {
        //     Visible = false;
        // }
        //}
        //BC Upgrade PATHAA02-DIT<<

        addafter("Sales Amount (Actual)")
        {
            //BC Upgrade PATHAA02-DIT>>

            // field("Initial Entry Due Date"; Rec."Initial Entry Due Date")
            // {
            //     Visible = false;
            // }
            // field("Sales Tax Amount (Expected)"; Rec."Sales Tax Amount (Expected)")
            // {
            //     Visible = false;
            // }
            // field("Sales Tax Amount (Actual)"; Rec."Sales Tax Amount (Actual)")
            // {
            // }
            // field("Internal Tax Amount (Actual)"; Rec."Internal Tax Amount (Actual)")
            // {
            // }
            // field("Internal Tax Amount (Exp)"; Rec."Internal Tax Amount (Exp)")
            // {
            //     Visible = false;
            // }
            // field("Expected Tax Posted to G/L"; Rec."Expected Tax Posted to G/L")
            // {
            //     Visible = false;
            // }
            // field("Tax Posted to G/L"; Rec."Tax Posted to G/L")
            // {
            // }
            // field("Sales Deposit Amount (Exp)"; Rec."Sales Deposit Amount (Exp)")
            // {
            //     Visible = false;
            // }
            // field("Sales Deposit Amount (Actual)"; Rec."Sales Deposit Amount (Actual)")
            // {
            // }    //BC Upgrade PATHAA02-DIT
            //BC Upgrade PATHAA02-DIT<<
            field("Purchase Amount (Expected)"; Rec."Purchase Amount (Expected)")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase Amount (Expected) field.';
            }
            field("Purchase Amount (Actual)"; Rec."Purchase Amount (Actual)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase Amount (Actual) field.';
            }
            //BC Upgrade PATHAA02-DIT>>

            // field("Purchase Tax Amount (Expected)"; "Purchase Tax Amount (Expected)")
            // {
            //     Visible = false;
            // }
            // field("Purchase Tax Amount (Actual)"; "Purchase Tax Amount (Actual)")
            // {
            // }
            // field("Purchase Deposit Amt. (Exp)"; "Purchase Deposit Amt. (Exp)")
            // {
            //     Visible = false;
            // }
            // field("Purchase Deposit Amt. (Actual)"; Rec."Purchase Deposit Amt. (Actual)")
            // {
            // }
            //BC Upgrade PATHAA02-DIT<<
        }
        //BC Upgrade PATHAA02-DIT>>

        // addafter("Item Ledger Entry Quantity")
        // {
        //     // field("Item Ledger Entry Quantity HL"; Rec."Item Ledger Entry Quantity HL")
        //     // {
        //     // } 
        // }


        // addafter("Valued Quantity")
        // {
        // field("Valued Quantity (Expected)"; Rec."Valued Quantity (Expected)")
        // {
        // }
        // field("Valued Quantity in HL"; Rec."Valued Quantity in HL")
        // {
        // }//BC Upgrade PATHAA02-DIT
        //}
        // addafter("Invoiced Quantity")
        // {
        // field("Invoiced Quantity in HL"; Rec."Invoiced Quantity in HL")
        // {
        // }
        // field("Deposit Amount (Expected)"; Rec."Deposit Amount (Expected)")
        // {
        // }
        // field("Expected Deposit Posted to G/L"; Rec."Expected Deposit Posted to G/L")
        // {
        // }
        // field("Deposit Amount (Actual)"; Rec."Deposit Amount (Actual)")
        // {
        // }
        // field("Deposit Amount Posted to GL"; Rec."Deposit Amount Posted to GL")
        // {
        // }
        // field("Due Tax"; Rec."Due Tax")
        // {
        // }
        // field("Duty Suspended"; Rec."Duty Suspended")
        // {
        // }
        // field("Item DTax Group Code"; Rec."Item DTax Group Code")
        // {
        // }
        // field("Item DDeposit Group Code"; Rec."Item DDeposit Group Code")
        // {
        // }
        // field("Item DDisc. Group Code";Rec."Item DDisc. Group Code")
        // {
        // }
        // field("Item DPromo. Group Code"; Rec."Item DPromo. Group Code")
        // {
        // }
        // field("Empty Goods Item No."; Rec."Empty Goods Item No.")
        // {
        //     Visible = false;
        // }
        // field("Tax Item No."; Rec."Tax Item No.")
        // {
        //     Visible = false;
        // } //BC Upgrade PATHAA02-DIT
        // field("GetTrackingItemNo()"; GetTrackingItemNo())
        // {
        //     CaptionML = ENU = 'Tracking Item No. (Item Charge)',
        //                 FRA = 'N° article traçable (Frais annexes)';
        //     DrillDownPageID = "Item List";
        //     LookupPageID = "Item List";
        //     TableRelation = IF ("Item Charge Type" = CONST(Tax)) Item where("No." = FIELD("Tax Item No."))
        //     else IF ("Item Charge Type" = CONST(Deposit)) Item where("No." = FIELD("Empty Goods Item No."));

        //     trigger OnLookup(Text: Text): Boolean;
        //     begin
        //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
        //         Text := GetTrackingItemNo();
        //         LookupItemNo(Text);
        //         exit(false);
        //     end;
        // }
        // field("Item Charge Value"; "Item Charge Value")
        // {
        //     Visible = false;
        // }
        // field("Tax Formula"; Rec."Tax Formula")
        // {
        //     Visible = false;
        // }
        // field("Unit Volume HL"; Rec."Unit Volume HL")
        // {
        //     Visible = false;
        // }
        // field("Strength Spec. Code"; Rec."Strength Spec. Code")
        // {
        //     Visible = false;
        // }
        // field("Strength Spec. Value"; Rec."Strength Spec. Value")
        // {
        // }
        // field("Vol-Strength Spec. Code"; Rec."Vol-Strength Spec. Code")
        // {
        //     Visible = false;
        // }
        // field("Vol-Strength Spec. Value"; Rec."Vol-Strength Spec. Value")
        // {
        // } 
        //}
        //BC Upgrade PATHAA02-DIT<<
        addafter("Gen. Prod. Posting Group")
        {
            field("Inventory Posting Group"; Rec."Inventory Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Inventory Posting Group field.';
            }
        }
        addafter("Source No.")
        {
            field(Name; TxtName)
            {
                CaptionML = ENU = 'Source Name',
                            FRA = 'Nom origine';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TxtName field.';
            }
            //BC Upgrade PATHAA02-DIT>>
            // field("Src. DTax Group Code"; "Src. DTax Group Code")
            // {
            // }
            // field("Src. Deposit Group Code"; "Src. Deposit Group Code")
            // {
            // }
            //BC Upgrade PATHAA02-DIT<<
        }
        //BC Upgrade PATHAA02-DIT>>
        // addafter("Item Ledger Entry No.")
        // {
        // field("Item Ledger Entry Source Type"; Rec."Item Ledger Entry Source Type")
        // {
        // }
        // field("Item Ledger Entry Source No."; Rec."Item Ledger Entry Source No.")
        // {
        // }
        //}
        // addafter("Capacity Ledger Entry No.")
        // {
        // field("Closed by Entry No."; Rec."Closed by Entry No.")
        // {
        //     Visible = false;
        // }
        // field("Closed by Document No."; Rec."Closed by Document No.")
        // {
        //     Visible = false;
        // }
        // field("Closed at Date"; Rec."Closed at Date")
        // {
        //     Visible = false;
        // }
        // field(Closed; Rec.Closed)
        // {
        //     Visible = false;
        // }
        //}
        //BC Upgrade PATHAA02-DIT<<
        addafter("Job Ledger Entry No.")
        {
            field("Item Type"; Rec."Item Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Type field.';
            }
            field("RPM Solution"; Rec."RPM Solution FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RPM Solution field.';
            }
            field("RPM Type"; Rec."RPM Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RPM Type field.';
            }
            field("Cost Amount (Purchase)"; Rec."Cost Amount (Purchase) FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Cost Amount (Purchase) field.';
            }
            field("Zone Code"; Rec."Zone Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zone Code field.';
            }
            field("Bin Code"; Rec."Bin Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bin Code field.';
            }
        }
        moveafter("Cost Posted to G/L (ACY)"; "Cost per Unit")
    }
    actions
    {
        modify("Ent&ry")
        {
            CaptionML = ENU = 'Ent&ry', FRA = 'É&criture';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("General Ledger")
        {
            CaptionML = ENU = 'General Ledger', FRA = 'Comptabilité';
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
        }
        addafter("General Ledger")
        {
            separator(Separator1100083048)
            {
            }
            //BC Upgrade PATHAA02-DIT>>
            // action("Specification-Tariff Entries")
            // {
            //     CaptionML = ENU = 'Specification-Tariff Entries',
            //                 FRA = 'Spécification - Ecritures tarif';
            //     Image = Worksheet;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Page "Ledger Entry Tax Spec. List";
            //     RunPageLink = "Table ID" = CONST(32),
            //                   "Entry No." = FIELD("Item Ledger Entry No.");
            // } BC Upgrade PATHAA02- DIT page 2013677/Table-2013669<<
        }
    }

    var
        TxtName: Text[80];


    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //begin
    /*
    // <<DITW19.00.08 DDR 17/08/2016 BL#10443
    SETFILTER("Tax Spec. Filter","Strength Spec. Code");
    // >>DITW19.00.08 DDR BL#10443
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    // var
    //     lrecCustomer: Record Customer;
    //     lrecVendor: Record Vendor;
    //begin
    /*
    //<<FINXL8.00.001 BSA 11/06/2015 #79
    if "Item Ledger Entry Type" = "Item Ledger Entry Type"::Sale then begin
      if lrecCustomer.GET("Source No.") then
        TxtName := lrecCustomer.Name;
      end else if  "Item Ledger Entry Type" = "Item Ledger Entry Type"::Purchase then
      if lrecVendor.GET("Source No.")then
        TxtName := lrecVendor.Name;
    //>>FINXL8.00.001 BSA 11/06/2015 #79
    */
    //end;


    //Unsupported feature: CodeModification on "GetCaption(PROCEDURE 3)". Please convert manually.

    //procedure GetCaption();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Description := '';

    CASE TRUE OF
      GETFILTER("Item Ledger Entry No.") <> '':
        BEGIN
          SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,32);
          SourceFilter := GETFILTER("Item Ledger Entry No.");
        end;
      GETFILTER("Capacity Ledger Entry No.") <> '':
        BEGIN
          SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,5832);
          SourceFilter := GETFILTER("Capacity Ledger Entry No.");
        end;
      GETFILTER("Item No.") <> '':
        BEGIN
          SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,27);
          SourceFilter := GETFILTER("Item No.");
          IF MAXSTRLEN(Item."No.") >= STRLEN(SourceFilter) THEN
            IF Item.GET(SourceFilter) THEN
              Description := Item.Description;
        end;
      (GETFILTER("Order No.") <> '') AND ("Order Type" = "Order Type"::Production):
        BEGIN
          SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,5405);
          SourceFilter := GETFILTER("Order No.");
          IF MAXSTRLEN(ProdOrder."No.") >= STRLEN(SourceFilter) THEN
            IF ProdOrder.GET(ProdOrder.Status::Released,SourceFilter) OR
               ProdOrder.GET(ProdOrder.Status::Finished,SourceFilter)
            THEN BEGIN
              SourceTableName := STRSUBSTNO('%1 %2',ProdOrder.Status,SourceTableName);
              Description := ProdOrder.Description;
            end;
        end;
      GETFILTER("Source No.") <> '':
        CASE "Source Type" OF
          "Source Type"::Customer:
            BEGIN
              SourceTableName :=
                ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,18);
              SourceFilter := GETFILTER("Source No.");
              IF MAXSTRLEN(Cust."No.") >= STRLEN(SourceFilter) THEN
                IF Cust.GET(SourceFilter) THEN
                  Description := Cust.Name;
            end;
          "Source Type"::Vendor:
            BEGIN
              SourceTableName :=
                ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,23);
              SourceFilter := GETFILTER("Source No.");
              IF MAXSTRLEN(Vend."No.") >= STRLEN(SourceFilter) THEN
                IF Vend.GET(SourceFilter) THEN
                  Description := Vend.Name;
            end;
        end;
      GETFILTER("Global Dimension 1 Code") <> '':
        BEGIN
          GLSetup.GET;
          Dimension.Code := GLSetup."Global Dimension 1 Code";
          SourceFilter := GETFILTER("Global Dimension 1 Code");
          SourceTableName := Dimension.GetMLName(GLOBALLANGUAGE);
          IF MAXSTRLEN(DimValue.Code) >= STRLEN(SourceFilter) THEN
            IF DimValue.GET(GLSetup."Global Dimension 1 Code",SourceFilter) THEN
              Description := DimValue.Name;
        end;
      GETFILTER("Global Dimension 2 Code") <> '':
        BEGIN
          GLSetup.GET;
          Dimension.Code := GLSetup."Global Dimension 2 Code";
          SourceFilter := GETFILTER("Global Dimension 2 Code");
          SourceTableName := Dimension.GetMLName(GLOBALLANGUAGE);
          IF MAXSTRLEN(DimValue.Code) >= STRLEN(SourceFilter) THEN
            IF DimValue.GET(GLSetup."Global Dimension 2 Code",SourceFilter) THEN
              Description := DimValue.Name;
        end;
      GETFILTER("Document Type") <> '':
        BEGIN
          SourceTableName := GETFILTER("Document Type");
          SourceFilter := GETFILTER("Document No.");
          Description := GETFILTER("Document Line No.");
        end;
      FilterGroupNo = DATABASE::"Item Analysis View Entry":
        BEGIN
          IF Item."No." <> "Item No." THEN
            IF NOT Item.GET("Item No.") THEN
              CLEAR(Item);
          SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,DATABASE::"Item Analysis View Entry");
          SourceFilter := Item."No.";
          Description := Item.Description;
        end;
    end;

    EXIT(STRSUBSTNO('%1 %2 %3',SourceTableName,SourceFilter,Description));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    Description := '';

    case true of
      GETFILTER("Item Ledger Entry No.") <> '':
        begin
          SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,32);
          SourceFilter := GETFILTER("Item Ledger Entry No.");
        end;
      GETFILTER("Capacity Ledger Entry No.") <> '':
        begin
          SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,5832);
          SourceFilter := GETFILTER("Capacity Ledger Entry No.");
        end;
      GETFILTER("Item No.") <> '':
        begin
          SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,27);
          SourceFilter := GETFILTER("Item No.");
          if MAXSTRLEN(Item."No.") >= STRLEN(SourceFilter) then
            if Item.GET(SourceFilter) then
              Description := Item.Description;
        end;
      (GETFILTER("Order No.") <> '') and ("Order Type" = "Order Type"::Production):
        begin
          SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,5405);
          SourceFilter := GETFILTER("Order No.");
          if MAXSTRLEN(ProdOrder."No.") >= STRLEN(SourceFilter) then
            if ProdOrder.GET(ProdOrder.Status::Released,SourceFilter) or
               ProdOrder.GET(ProdOrder.Status::Finished,SourceFilter)
            then begin
              SourceTableName := STRSUBSTNO('%1 %2',ProdOrder.Status,SourceTableName);
              Description := ProdOrder.Description;
            end;
        end;
      GETFILTER("Source No.") <> '':
        case "Source Type" of
          "Source Type"::Customer:
            begin
    #38..40
              if MAXSTRLEN(Cust."No.") >= STRLEN(SourceFilter) then
                if Cust.GET(SourceFilter) then
                  Description := Cust.Name;
            end;
          "Source Type"::Vendor:
            begin
    #47..49
              if MAXSTRLEN(Vend."No.") >= STRLEN(SourceFilter) then
                if Vend.GET(SourceFilter) then
                  Description := Vend.Name;
            end;
        end;
      GETFILTER("Global Dimension 1 Code") <> '':
        begin
    #57..60
          if MAXSTRLEN(DimValue.Code) >= STRLEN(SourceFilter) then
            if DimValue.GET(GLSetup."Global Dimension 1 Code",SourceFilter) then
              Description := DimValue.Name;
        end;
      GETFILTER("Global Dimension 2 Code") <> '':
        begin
    #67..70
          if MAXSTRLEN(DimValue.Code) >= STRLEN(SourceFilter) then
            if DimValue.GET(GLSetup."Global Dimension 2 Code",SourceFilter) then
              Description := DimValue.Name;
        end;
      GETFILTER("Document Type") <> '':
        begin
    #77..79
        end;
      FilterGroupNo = DATABASE::"Item Analysis View Entry":
        begin
          if Item."No." <> "Item No." then
            if not Item.GET("Item No.") then
    #85..88
        end;
    end;

    exit(STRSUBSTNO('%1 %2 %3',SourceTableName,SourceFilter,Description));
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

