pageextension 51016 ItemLedgerEntriesExtCBN extends "Item Ledger Entries"
{
    //HEI.02 FDD-BA-SLSGAP01 IBM NASTAA02 10.12.2018 # Counterpoint Interface
    //   # Added Fields "External Document No.", "Vendor No.", "Vendor Name" and "CP Vendor Invoice No."
    // HEI.03 CHG2012342 IBM GAVANM01 19/11/2019 # Your Reference added
    // HEI.04 CHG2039137 IBM.LS 28.02.2020
    //   # New Field added - "Dimension Set ID"
    // HEI.05 CHG2065153 IBM KUMARN15 23.06.2020
    //   # Added field "Source System Identifier"
    // HEI.06 HT1615 BULIMC01 IBM 16.09.2020 #new field created: "Zone Code"
    // HEI.07 CHG2077659(SC+) IBM.AK 02.09.20
    //   # Changed the caption of "Quantity" field to "Quantity (Base UoM)"
    // HEI.08 CHG2131272 IBM.LS      14.12.2021
    //   # Added New Field - Reporting Type

    layout
    {
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the posting date for the entry.', FRA = 'Spécifie la date comptabilisation de l''écriture.';
        }
        modify("Entry Type")
        {
            ToolTipML = ENU = 'Specifies which type of transaction that the entry is created from.', FRA = 'Spécifie le type de transaction à partir duquel l''écriture est créée.';
        }
        modify("Document Type")
        {
            ToolTipML = ENU = 'Specifies what type of document was posted to create the item ledger entry.', FRA = 'Indique le type de document validé pour créer l''écriture comptable article.';
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies the document number on the entry. The document is the voucher that the entry was based on, for example, a receipt.', FRA = 'Spécifie le numéro de document de l''écriture. Le document est la pièce justificative sur laquelle l''écriture a été basée, par exemple, une réception.';
        }
        modify("Document Line No.")
        {
            ToolTipML = ENU = 'Specifies the number of the line on the posted document that corresponds to the item ledger entry.', FRA = 'Indique le numéro de la ligne sur le document validé qui correspond à l''écriture comptable article.';
        }
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item in the entry.', FRA = 'Spécifie le numéro de l''article dans l''écriture.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the variant code for the items.', FRA = 'Spécifie le code variante pour les articles.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the entry.', FRA = 'Spécifie une description de l''écriture.';
        }
        modify("Return Reason Code")
        {
            ToolTipML = ENU = 'Specifies a code that explains why the item is returned.', FRA = 'Spécifie un code expliquant la raison du renvoi de l''article.';
        }
        modify("Global Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code that the entry is linked to.', FRA = 'Spécifie le code section analytique lié à l''écriture.';
        }
        modify("Global Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code that the entry is linked to.', FRA = 'Spécifie le code section analytique lié à l''écriture.';
        }
        modify("Expiration Date")
        {
            ToolTipML = ENU = 'Specifies the last date that the item on the line can be used.', FRA = 'Spécifie la dernière date à laquelle l''article de la ligne peut être utilisé.';
        }
        modify("Serial No.")
        {
            ToolTipML = ENU = 'Specifies a serial number if the posted item carries such a number.', FRA = 'Spécifie un n° de série si l''article validé en porte un.';
        }
        modify("Lot No.")
        {
            ToolTipML = ENU = 'Specifies a lot number if the posted item carries such a number.', FRA = 'Spécifie un numéro de lot si l''article validé en porte un.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code for the location that the entry is linked to.', FRA = 'Spécifie le code du magasin lié à l''écriture.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the number of units of the item in the item entry.', FRA = 'Spécifie le nombre d''unités de l''article dans l''écriture article.';
            CaptionML = ENU = 'Quantity (Base UoM)', FRA = 'Quantité';
        }
        modify("Invoiced Quantity")
        {
            ToolTipML = ENU = 'Specifies how many units of the item on the line have been invoiced.', FRA = 'Spécifie le nombre d''unités de la ligne qui ont été facturées.';
        }
        modify("Remaining Quantity")
        {
            ToolTipML = ENU = 'Specifies the quantity that remains in inventory in the Quantity field if the entry is an increase (a purchase or positive adjustment).', FRA = 'Spécifie la quantité qui reste en stock dans le champ Quantité si l''écriture est une augmentation (un achat ou un ajustement positif).';
        }
        modify("Shipped Qty. Not Returned")
        {
            ToolTipML = ENU = 'Specifies the quantity for this item ledger entry that was shipped and has not yet been returned.', FRA = 'Spécifie la quantité de cette écriture comptable article qui a été expédiée et pas encore retournée.';
        }
        modify("Reserved Quantity")
        {
            ToolTipML = ENU = 'Specifies how many units of the item on the line have been reserved.', FRA = 'Spécifie le nombre d''unités de la ligne qui ont été réservées.';
        }
        modify("Qty. per Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the quantity per item unit of measure.', FRA = 'Spécifie la quantité par unité d''article.';
        }
        modify("Sales Amount (Expected)")
        {
            ToolTipML = ENU = 'Specifies the expected sales amount, in LCY.', FRA = 'Spécifie le montant des ventes attendu en devise société.';
        }
        modify("Sales Amount (Actual)")
        {
            ToolTipML = ENU = 'Specifies the sales amount, in LCY.', FRA = 'Spécifie le montant des ventes, en devise société.';
        }
        modify("Cost Amount (Expected)")
        {
            ToolTipML = ENU = 'Specifies the expected cost, in LCY, of the quantity posting.', FRA = 'Spécifie le coût prévu, en devise société, de la validation de la quantité.';
        }
        modify("Cost Amount (Actual)")
        {
            ToolTipML = ENU = 'Specifies the adjusted cost, in LCY, of the quantity posting.', FRA = 'Spécifie le coût ajusté, en devise société, de la validation de la quantité.';
        }
        modify("Cost Amount (Non-Invtbl.)")
        {
            ToolTipML = ENU = 'Specifies the adjusted non-inventoriable cost, that is an item charge assigned to an outbound entry.', FRA = 'Spécifie le coût non valorisable ajusté, c''est-à-dire les frais annexes affectés à une écriture sortante.';
        }
        modify("Cost Amount (Expected) (ACY)")
        {
            ToolTipML = ENU = 'Specifies the expected cost, in ACY, of the quantity posting.', FRA = 'Spécifie le coût prévu, en devise report, de la validation de la quantité.';
        }
        modify("Cost Amount (Actual) (ACY)")
        {
            ToolTipML = ENU = 'Specifies the adjusted cost of the entry, in the additional reporting currency.', FRA = 'Spécifie le coût ajusté de l''écriture dans la devise report supplémentaire.';
        }
        modify("Cost Amount (Non-Invtbl.)(ACY)")
        {
            ToolTipML = ENU = 'Specifies the adjusted non-inventoriable cost, that is, an item charge assigned to an outbound entry in the additional reporting currency.', FRA = 'Spécifie le coût non valorisable ajusté, c''est-à-dire les frais annexes affectés à une écriture sortante en devise report.';
        }
        modify("Completely Invoiced")
        {
            ToolTipML = ENU = 'Specifies if the entry has been fully invoiced or if more posted invoices are expected. Only completely invoiced entries can be revalued.', FRA = 'Indique si l''écriture a été entièrement facturée ou si d''autres factures validées sont prévues. Seules les écritures entièrement facturées peuvent être réévaluées.';
        }
        modify(Open)
        {
            ToolTipML = ENU = 'Specifies whether the entry has been fully applied to.', FRA = 'Spécifie si l''écriture a été totalement lettrée ou non.';
        }
        modify("Drop Shipment")
        {
            ToolTipML = ENU = 'Specifies whether the items on the line have been shipped directly to the customer.', FRA = 'Spécifie si les articles de la ligne ont été livrés directement au client.';
        }
        modify("Assemble to Order")
        {
            ToolTipML = ENU = 'Specifies if the posting represents an assemble-to-order sale.', FRA = 'Spécifie si la validation représente une vente Assembler pour commande.';
        }
        modify("Applied Entry to Adjust")
        {
            ToolTipML = ENU = 'Specifies whether there is one or more applied entries, which need to be adjusted.', FRA = 'Indique s''il existe des écritures lettrées qui nécessitent un ajustement.';
        }
        modify("Order Type")
        {
            ToolTipML = ENU = 'Specifies which type of order that the entry was created in.', FRA = 'Spécifie le type de commande dans laquelle l''écriture a été créée.';
        }
        modify("Order No.")
        {
            ToolTipML = ENU = 'Specifies the number of the order that created the entry.', FRA = 'Spécifie le numéro de la commande qui a créé l''écriture.';
        }
        modify("Order Line No.")
        {
            ToolTipML = ENU = 'Specifies the line number of the order that created the entry.', FRA = 'Spécifie le numéro de ligne ayant créé l''écriture.';
        }
        modify("Prod. Order Comp. Line No.")
        {
            ToolTipML = ENU = 'Specifies the line number of the production order component.', FRA = 'Spécifie le numéro de ligne du composant O.F.';
        }
        modify("Entry No.")
        {
            ToolTipML = ENU = 'Specifies the entry number for the entry.', FRA = 'Spécifie le numéro d''écriture de l''écriture.';
        }
        modify("Job No.")
        {
            ToolTipML = ENU = 'Specifies the number of the job associated with the entry.', FRA = 'Spécifie le numéro de la tâche associée à l''écriture comptable.';
        }
        modify("Job Task No.")
        {
            ToolTipML = ENU = 'Specifies the number of the job task associated with the entry.', FRA = 'Spécifie le numéro de la tâche projet associée à l''écriture.';
        }
        ////---BC Upgrade KAMNAY01>> --  modify the "Unit of Measure Code" and make it visible false 
        modify("Unit of Measure Code")
        {
            Visible = false;
        }
        ////---BC Upgrade KAMNAY01<< --  modify the "Unit of Measure Code" and make it visible false 
        addafter("Posting Date")
        {
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Document Date field.';
            }
        }
        //---BC Upgrade KAMNAY01>>
        // addafter(Description)
        // {
        //     field("Free Item";Rec."Free Item")
        //     {
        //     }
        //     field("Free Reason Code";Rec."Free Reason Code")
        //     {
        //         Visible = false;
        //     }
        //     field("Gyle No.";Rec."Gyle No.")
        //     {
        //         CaptionClass = '2035140,1';
        //     }
        // }
        // addafter("Global Dimension 2 Code")
        // {
        //     field("Source Type";Rec."Source Type")
        //     {
        //     }
        //     field("Source No.";Rec."Source No.")
        //     {
        //     }
        // }
        // addafter("Lot No.")
        // {
        //     field("Work Order No.";Rec."Work Order No.")
        //     {
        //         Description = 'DIT-715 #457';
        //     }
        // }
        // addafter("Location Code")
        // {
        //     field("Bin Code";Rec."Bin Code")
        //     {
        //     }
        // }
        // addafter(Quantity)
        // {
        //     field("Quantity in HL";Rec."Quantity in HL")
        //     {
        //     }
        // }
        ////---BC Upgrade KAMNAY01<<
        ////---BC Upgrade KAMNAY01>> -- code commented and modify the "Unit of Measure Code" and make it visible false 
        // addafter("Reserved Quantity")
        // {
        //     field("Unit of Measure Code"; Rec."Unit of Measure Code")
        //     {
        //         Visible = false;
        //     }
        // }
        ////---BC Upgrade KAMNAY01<< -- code commented and modify the "Unit of Measure Code" and make it visible false 
        //---BC Upgrade KAMNAY01>>
        // addafter("Qty. per Unit of Measure")
        // {
        //     field("Unit Volume HL";Rec."Unit Volume HL")
        //     {
        //         Visible = false;
        //     }
        //     field("Strength Spec. Code";Rec."Strength Spec. Code")
        //     {
        //         Visible = false;
        //     }
        //     field("Source Item Strength Spec. Value";Rec."Item Strength Spec. Value")
        //     {
        //     }
        //     field("Strength Spec. Value Actual";Rec."Strength Spec. Value")
        //     {
        //         Style = Standard;
        //         StyleExpr = TRUE;
        //         Visible = false;

        //         trigger OnDrillDown();
        //         var
        //             ValueEntry : Record "Value Entry";
        //         begin
        //             ValueEntry.SETCURRENTKEY("Item Ledger Entry No.");
        //             ValueEntry.SETRANGE("Item Ledger Entry No.",Rec."Entry No.");
        //             PAGE.RUN(PAGE::"Value Entries",ValueEntry,ValueEntry.Rec."Strength Spec. Value");
        //         end;
        //     }
        //     field("Vol-Strength Spec. Code";Rec."Vol-Strength Spec. Code")
        //     {
        //         Visible = false;
        //     }
        //     field("Vol-Strength Spec. Value";Rec."Vol-Strength Spec. Value")
        //     {
        //         Visible = false;

        //         trigger OnDrillDown();
        //         var
        //             ValueEntry : Record "Value Entry";
        //         begin
        //             ValueEntry.SETCURRENTKEY("Item Ledger Entry No.");
        //             ValueEntry.SETRANGE("Item Ledger Entry No.",Rec."Entry No.");
        //             PAGE.RUN(PAGE::"Value Entries",ValueEntry,ValueEntry."Vol-Strength Spec. Value");
        //         end;
        //     }


        //     field("Loss Vol-Strength Spec. Value";rec."Loss Vol-Strength Spec. Value")
        //     {
        //         Visible = false;
        //     }
        //     field(Reverse;rec.Reverse)
        //     {
        //         Description = 'DITW19.00.08A BL#10443';
        //         Visible = false;
        //     }
        //     field("Item DTax Group Code";rec."Item DTax Group Code")
        //     {
        //     }
        // }
        //---BC Upgrade KAMNAY01<<
        addafter("Sales Amount (Actual)")
        {  //---BC Upgrade KAMNAY01>>
           // field("Sales Tax Amount (Expected)"; rec."Sales Tax Amount (Expected)")
           // {
           //     Visible = false;
           // }
           // field("Sales Tax Amount (Actual)"; rec."Sales Tax Amount (Actual)")
           // {
           // }
           // field("Item DDeposit Group Code"; rec."Item DDeposit Group Code")
           // {
           // }
           // field("Sales Deposit Amount (Exp)"; "Sales Deposit Amount (Exp)")
           // {
           //     Visible = false;
           // }
           // field("Sales Deposit Amount (Actual)"; rec."Sales Deposit Amount (Actual)")
           // {
           // }
           //---BC Upgrade KAMNAY01<<
            field("Purchase Amount (Expected)"; rec."Purchase Amount (Expected)")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase Amount (Expected) field.';
            }
            field("Purchase Amount (Actual)"; rec."Purchase Amount (Actual)")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase Amount (Actual) field.';
            }
            //---BC Upgrade KAMNAY01>>
            // field("Purchase Tax Amount (Expected)"; "Purchase Tax Amount (Expected)")
            // {
            //     Visible = false;
            // }
            // field("Purchase Tax Amount (Actual)"; rec."Purchase Tax Amount (Actual)")
            // {
            // }
            // field("Purchase Deposit Amt. (Exp)"; rec."Purchase Deposit Amt. (Exp)")
            // {
            //     Visible = false;
            // }
            // field("Purchase Deposit Amt. (Actual)"; rec."Purchase Deposit Amt. (Actual)")
            // {
            // }
            // field("Item DDisc. Group Code"; rec."Item DDisc. Group Code")
            // {
            // }
            // field("Item DPromo. Group Code"; rec."Item DPromo. Group Code")
            // {
            // }
            //---BC Upgrade KAMNAY01<<
            field("Item Category Code"; rec."Item Category Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Category Code field.';
            }
            //---BC Upgrade KAMNAY01>>
            // field("Internal Tax Amount (Exp)"; rec."Internal Tax Amount (Exp)")
            // {
            //     Visible = false;
            // }
            // field("Internal Tax Amount (Actual)"; rec."Internal Tax Amount (Actual)")
            // {
            // }
            //---BC Upgrade KAMNAY01<<
        }
        //---BC Upgrade KAMNAY01>>
        // addafter("Cost Amount (Non-Invtbl.)(ACY)")
        // {
        //     field("Deposit Amount (Expected)"; rec."Deposit Amount (Expected)")
        //     {
        //         Visible = false;
        //     }
        //     field("Deposit Amount (Actual)"; Rec."Deposit Amount (Actual)")
        //     {
        //         Visible = false;
        //     }
        // }

        // addafter("Prod. Order Comp. Line No.")
        // {
        //     field("Scrap Code"; Rec."Scrap Code")
        //     {
        //         Visible = false;
        //     }
        //     field("Exist Loss Breakdown"; Rec."Exist Loss Breakdown")
        //     {
        //         Visible = false;
        //     }
        // }
        //---BC Upgrade KAMNAY01<<
        addafter("Job Task No.")
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
            //---BC Upgrade KAMNAY01>>
            // field("Driver Code"; Rec."Driver Code")
            // {
            // }
            // field("Your Reference"; Rec."Your Reference")
            // {
            // }
            //---BC Upgrade KAMNAY01<<
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the External Document No. field.';
            }
            field("Vendor No."; Rec."Vendor No. FND")
            {
                Description = 'HEI.02';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor No. field.';
            }
            field("Vendor Name"; Rec."Vendor Name FND")
            {
                Description = 'HEI.02';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Name field.';
            }
            //BC Upgrade GUNREM01 -Moved to interface extension >>
            // field("CP Vendor Invoice No."; Rec."CP Vendor Invoice No.")
            // {
            //     Description = 'HEI.02';
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the CP Vendor Invoice No. field.';
            // }
            //BC Upgrade GUNREM01 -Moved to interface extension >>
            // field("Dimension Set ID"; "Dimension Set ID")
            // {
            // }//---BC Upgrade KAMNAY01---- The field is already in the base extension.
            field("Quality Status"; Rec."Quality Status FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quality Status field.';
                Visible = false; //BC UPGRADE PATHAA02 08.06.26
            }
            field("Source System Identifier"; Rec."Source System Identifier FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Source System Identifier field.';
            }
            field("Zone Code"; Rec."Zone Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zone Code field.';
            }
            field("Reporting Type"; Rec."Reporting Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Reporting Type field.';
            }
        }
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
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("&Value Entries")
        {
            CaptionML = ENU = '&Value Entries', FRA = 'Écritures &valeur';
            ToolTipML = ENU = 'View all amounts relating to an item.', FRA = 'Affichez tous les montants associés à un article.';

            //Unsupported feature: Change RunPageView on ""&Value Entries"(Action 64)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""&Value Entries"(Action 64)". Please convert manually.

        }
        modify("&Application")
        {
            CaptionML = ENU = '&Application', FRA = '&Lettrage';
        }
        modify("Applied E&ntries")
        {
            CaptionML = ENU = 'Applied E&ntries', FRA = 'É&critures lettrées';
            ToolTipML = ENU = 'View the ledger entries that have been applied to this record.', FRA = 'Affichez les écritures comptables qui ont été lettrées avec cet enregistrement.';
        }
        modify("Reservation Entries")
        {
            CaptionML = ENU = 'Reservation Entries', FRA = 'Écritures réservation';
            ToolTipML = ENU = 'View the entries for every reservation that is made, either manually or automatically.', FRA = 'Affichez les écritures pour chaque réservation effectuée, soit manuellement, soit automatiquement.';
        }
        modify("Application Worksheet")
        {
            CaptionML = ENU = 'Application Worksheet', FRA = 'Feuille lettrage';
            ToolTipML = ENU = 'View item applications that are automatically created between item ledger entries during item transactions.', FRA = 'Affichez les lettrages article qui sont automatiquement créés entre les écritures comptables article pendant les transactions article.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Order &Tracking")
        {
            CaptionML = ENU = 'Order &Tracking', FRA = '&Chaînage';
            ToolTipML = ENU = 'Tracks the connection of a supply to its corresponding demand. This can help you find the original demand that created a specific production order or purchase order.', FRA = 'Suit la connexion d''un approvisionnement selon sa demande correspondante. Ceci peut vous aider à trouver la demande d''origine qui a créé un ordre de production ou un bon de commande spécifique.';
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
            ToolTipML = ENU = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.', FRA = 'Recherchez toutes les écritures et tous les documents qui existent pour le numéro de document et la date comptabilisation sur l''écriture ou le document.';
        }


        //Unsupported feature: CodeModification on ""Reservation Entries"(Action 56).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShowReservationEntries(TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ShowReservationEntries(true);
        */
        //end;
        addafter(Dimensions)
        {
            separator(Separator1100083024)
            {
            }
        }
        //---BC Upgrade KAMNAY01>>
        // addafter("&Value Entries")
        // {

        // action("SSCC Tracking Entries")
        // {
        //     CaptionML = ENU = 'SSCC Tracking Entries',
        //                 FRA = 'Ecritures traçablité SSCC';
        //     Image = ItemTrackingLedger;

        //     trigger OnAction();
        //     var
        //         SSCCTrackingMgt: Codeunit "SSCC Tracking Management";
        //     begin
        //         // <<DITW15.00.00.38 DDR 19/11/2010 #1139
        //         // <<DITW17.10.03 DDR 13/06/2014 DIT-770 #667
        //         SSCCTrackingMgt.CallSSCCTrackingEntryForm(0, '', "Item No.", '', '', "Lot No.", "Location Code", 0);
        //         // >>DITW17.10.03 DDR DIT-770 #667
        //     end;
        // }

        //     action("Specification-Tariff Entries")
        //     {
        //         CaptionML = ENU = 'Specification-Tariff Entries',
        //                     FRA = 'Spécification - Ecritures tarif';
        //         Image = Worksheet;
        //         RunObject = Page "Ledger Entry Tax Spec. List";
        //         RunPageLink = "Table ID" = CONST(32),
        //                       "Entry No." = FIELD("Entry No.");
        //     }
        //     action("&Loss Breakdown Entries")
        //     {
        //         CaptionML = ENU = '&Loss Breakdown Entries',
        //                     FRA = 'Perte Ventilation';
        //         Image = GainLossEntries;
        //         RunObject = Page "Loss Breakdown Entries";
        //         RunPageLink = "Item Ledger Entry No." = FIELD("Entry No.");
        //     }
        // }
        //---BC Upgrade KAMNAY01<<
    }


    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //begin
    /*
    // <<DITW19.00.08 DDR 17/08/2016 BL#10443
    SETFILTER("Tax Spec. Filter","Strength Spec. Code");
    // >>DITW19.00.08 DDR BL#10443
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF FINDFIRST THEN;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if FINDFIRST then;
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
    end;
    EXIT(STRSUBSTNO('%1 %2 %3',SourceTableName,SourceFilter,Description));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    Description := '';

    case true of
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
    #28..30
              if MAXSTRLEN(Cust."No.") >= STRLEN(SourceFilter) then
                if Cust.GET(SourceFilter) then
                  Description := Cust.Name;
            end;
          "Source Type"::Vendor:
            begin
    #37..39
              if MAXSTRLEN(Vend."No.") >= STRLEN(SourceFilter) then
                if Vend.GET(SourceFilter) then
                  Description := Vend.Name;
            end;
        end;
      GETFILTER("Global Dimension 1 Code") <> '':
        begin
    #47..50
          if MAXSTRLEN(DimValue.Code) >= STRLEN(SourceFilter) then
            if DimValue.GET(GLSetup."Global Dimension 1 Code",SourceFilter) then
              Description := DimValue.Name;
        end;
      GETFILTER("Global Dimension 2 Code") <> '':
        begin
    #57..60
          if MAXSTRLEN(DimValue.Code) >= STRLEN(SourceFilter) then
            if DimValue.GET(GLSetup."Global Dimension 2 Code",SourceFilter) then
              Description := DimValue.Name;
        end;
      GETFILTER("Document Type") <> '':
        begin
    #67..69
        end;
    end;
    exit(STRSUBSTNO('%1 %2 %3',SourceTableName,SourceFilter,Description));
    */
    //end;

    // procedure GetSelectionFilter(): Text;
    // var
    //     Bin: Record Bin;
    //     SelectionFilterManagement: Codeunit SelectionFilterManagement;
    // begin
    //     //HEI.syed$$>>
    //     CurrPage.SETSELECTIONFILTER(Rec);
    //     exit(SelectionFilterManagement.GetSelectionFilterForILE(Rec));
    //     //HEI.Syed$$<<
    // end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

