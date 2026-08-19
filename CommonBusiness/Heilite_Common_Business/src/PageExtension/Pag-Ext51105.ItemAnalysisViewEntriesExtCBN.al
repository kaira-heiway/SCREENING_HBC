pageextension 51105 ItemAnalysisViewEntriesExtCBN extends "Item Analysis View Entries"
{
    // DITW15.00.00.01 DDR 12/03/2008 Added Drink-It Item Charges functionnalities
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.20 DDR 06/06/2008 Certification rules
    // DITW15.00.00.23 DDR 22/07/2008 Upgrade DrillDown function to specify the field to show
    //                                Added columns "Item Charge Type","Item Charge No.","Empty Goods Item No."
    // DITW15.00.00.24 DDR 14/08/2008 Changed column "Quantity in HL" property Width & function DrillDow()
    // DITW15.00.00.25 DDR 10/10/2008 Removed column "Valued Quantity in HL"
    //                                Added columns
    //                                  "Internal Tax Amount (Actual)"
    //                                  "Invoiced Quantity in HL"
    // DITW15.00.00.38 DDR 17/12/2010 issue 703 Added column "Tax Item No.","Tracking Item No." (on item charges)
    //                                          Modified column non-visible "Empty Goods Item No."

    // DITW17.10.03 MSF 10/04/2014 DIT-770 #240 : Use the Value Entry - Item Ledger Entrys Source No for analysis, deposits,..
    //                                             Added field "Item Ledger Entry source No."
    //                                                          "Source No."
    //                                                          "Source Type"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-HB1425 BULIMC01 IBM 03.06.2020 #new fields added: "Shortcut 1 Value Code", "Shortcut 2 Value Code"

    // HEI.02 IBM YADAVM09 12/10/23 CHG2218600_HB3954 DRC Interredional transfer exclusion from WIS MSV
    // #Added new field Reporting Type

    layout
    {
        modify("Item Ledger Entry Type")
        {
            ToolTipML = ENU = 'Specifies which type of transaction that the entry is created from.', FRA = 'Spécifie le type de transaction à partir duquel l''écriture est créée.';
        }
        modify("Entry Type")
        {
            ToolTipML = ENU = 'Specifies the value entry type for an analysis view entry.', FRA = 'Spécifie le type d''écriture valeur d''une écriture vue d''analyse.';
        }
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the item number to which the item ledger entry in an analysis view entry was posted.', FRA = 'Spécifie le numéro article sur lequel l''écriture comptable article d''une écriture vue d''analyse a été validée.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code of the location to which the item ledger entry in an analysis view entry was posted.', FRA = 'Spécifie le code du magasin dans lequel l''écriture comptable article d''une écriture vue d''analyse a été validée.';
        }
        modify("Dimension 1 Value Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value you selected for the analysis view dimension that you defined as Dimension 1 on the analysis view card.', FRA = 'Spécifie la section analytique sélectionnée pour l''axe vue d''analyse que vous avez défini en tant qu''axe 1 dans la fiche vue d''analyse.';
        }
        modify("Dimension 2 Value Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value you selected for the analysis view dimension that you defined as Dimension 2 on the analysis view card.', FRA = 'Spécifie la section analytique sélectionnée pour l''axe vue d''analyse que vous avez défini en tant qu''axe 2 dans la fiche vue d''analyse.';
        }
        modify("Dimension 3 Value Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value you selected for the analysis view dimension that you defined as Dimension 3 on the analysis view card.', FRA = 'Spécifie la section analytique sélectionnée pour l''axe vue d''analyse que vous avez défini en tant qu''axe 3 dans la fiche vue d''analyse.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the date when the item ledger entry in an analysis view entry was posted.', FRA = 'Spécifie la date à laquelle l''écriture comptable article d''une écriture vue d''analyse a été validée.';
        }
        modify("Sales Amount (Actual)")
        {
            ToolTipML = ENU = 'Specifies the sum of the actual sales amounts posted for the item ledger entries included in the analysis view entry.', FRA = 'Spécifie le total des montants vente réalisés validés des écritures comptables article incluses dans l''écriture vue d''analyse.';
        }
        modify("Sales Amount (Expected)")
        {
            ToolTipML = ENU = 'Specifies the sum of the expected sales amounts posted for the item ledger entries, included in the analysis view entry.', FRA = 'Spécifie le total des montants vente prévus validés des écritures comptables article incluses dans l''écriture vue d''analyse.';
        }
        modify("Cost Amount (Actual)")
        {
            ToolTipML = ENU = 'Specifies the sum of the actual cost amounts posted for the item ledger entries included in the analysis view entry.', FRA = 'Spécifie le total des montants coût réalisés validés des écritures comptables article incluses dans l''écriture vue d''analyse.';
        }
        modify("Cost Amount (Expected)")
        {
            ToolTipML = ENU = 'Specifies the sum of the expected cost amounts posted for the item ledger entries included in the analysis view entry.', FRA = 'Spécifie le total des montants coût prévus validés des écritures comptables article incluses dans l''écriture vue d''analyse.';
        }
        modify("Cost Amount (Non-Invtbl.)")
        {
            ToolTipML = ENU = 'Specifies the sum of the non-inventoriable cost amounts posted for the item ledger entries included in the analysis view entry.', FRA = 'Spécifie le total des montants coût non valorisables validés des écritures comptables article incluses dans l''écriture vue d''analyse.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the sum of the quantity for the item ledger entries included in the analysis view entry.', FRA = 'Spécifie le total de la quantité des écritures comptables article incluses dans l''écriture vue d''analyse.';
        }
        modify("Invoiced Quantity")
        {
            ToolTipML = ENU = 'Specifies the sum of the quantity invoiced for the item ledger entries included in the analysis view entry.', FRA = 'Spécifie le total de la quantité facturée pour les écritures comptables article incluses dans l''écriture vue d''analyse.';
        }

        //Unsupported feature: PropertyDeletion on "Control1900000001(Control 1900000001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Item Ledger Entry Type"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Item Ledger Entry Type"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Entry Type"(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Entry Type"(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Item No."(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Item No."(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Dimension 1 Value Code"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Dimension 1 Value Code"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Dimension 2 Value Code"(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Dimension 2 Value Code"(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Dimension 3 Value Code"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Dimension 3 Value Code"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 16)". Please convert manually.


        //Unsupported feature: CodeModification on ""Sales Amount (Actual)"(Control 18).OnDrillDown". Please convert manually.

        //trigger OnDrillDown();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DrillDown;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.23 DDR 22/07/2008
        DrillDown(FIELDNO("Sales Amount (Actual)"));
        // >>DITW15.00.00.23 DDR
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Sales Amount (Actual)"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sales Amount (Actual)"(Control 18)". Please convert manually.



        //Unsupported feature: CodeModification on ""Sales Amount (Expected)"(Control 2).OnDrillDown". Please convert manually.

        //trigger OnDrillDown();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DrillDown;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.23 DDR 22/07/2008
        DrillDown(FIELDNO("Cost Amount (Expected)"));
        // >>DITW15.00.00.23 DDR
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Sales Amount (Expected)"(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Sales Amount (Expected)"(Control 2)". Please convert manually.



        //Unsupported feature: CodeModification on ""Cost Amount (Actual)"(Control 20).OnDrillDown". Please convert manually.

        //trigger OnDrillDown();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DrillDown;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.23 DDR 22/07/2008
        DrillDown(FIELDNO("Cost Amount (Actual)"));
        // >>DITW15.00.00.23 DDR
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Cost Amount (Actual)"(Control 20)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Cost Amount (Actual)"(Control 20)". Please convert manually.



        //Unsupported feature: CodeModification on ""Cost Amount (Expected)"(Control 14).OnDrillDown". Please convert manually.

        //trigger OnDrillDown();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DrillDown;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.23 DDR 22/07/2008
        DrillDown(FIELDNO("Cost Amount (Expected)"));
        // >>DITW15.00.00.23 DDR
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Cost Amount (Expected)"(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Cost Amount (Expected)"(Control 14)". Please convert manually.



        //Unsupported feature: CodeModification on ""Cost Amount (Non-Invtbl.)"(Control 28).OnDrillDown". Please convert manually.

        //trigger )"(Control 28)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DrillDown;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.23 DDR 22/07/2008
        DrillDown(FIELDNO("Cost Amount (Non-Invtbl.)"));
        // >>DITW15.00.00.23 DDR
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Cost Amount (Non-Invtbl.)"(Control 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Cost Amount (Non-Invtbl.)"(Control 28)". Please convert manually.



        //Unsupported feature: CodeModification on "Quantity(Control 22).OnDrillDown". Please convert manually.

        //trigger OnDrillDown();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DrillDown;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.23 DDR 22/07/2008
        DrillDown(FIELDNO(Quantity));
        // >>DITW15.00.00.23 DDR
        */
        //end;

        //Unsupported feature: PropertyDeletion on "Quantity(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Quantity(Control 22)". Please convert manually.



        //Unsupported feature: CodeModification on ""Invoiced Quantity"(Control 33).OnDrillDown". Please convert manually.

        //trigger OnDrillDown();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DrillDown;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.23 DDR 22/07/2008
        DrillDown(FIELDNO("Invoiced Quantity"));
        // >>DITW15.00.00.23 DDR
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Invoiced Quantity"(Control 33)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Invoiced Quantity"(Control 33)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900000007(Control 1900000007)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900383207(Control 1900383207)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1905767507(Control 1905767507)". Please convert manually.
        //BC Upgrade KAPOOV01 Drink-it>>
        // addafter("Item No.")
        // {
        //     field("Item Charge Type"; "Item Charge Type")
        //     {
        //     }
        //     field("Item Charge No."; "Item Charge No.")
        //     {
        //     }
        // }

        addafter("Location Code")
        {
            //BC Upgrade KAPOOV01 Drink-it>>
            // field("Tax Item No."; "Tax Item No.")
            // {
            //     Visible = false;
            // }
            // field("Empty Goods Item No."; "Empty Goods Item No.")
            // {
            //     Visible = false;
            // }
            // field(GetTrackingItemNo(); GetTrackingItemNo())
            // {
            //     CaptionML = ENU='Tracking Item No. (Item Charge)',
            //                 FRA='N° article traçable (Frais annexes)';
            //     DrillDownPageID = "Item List";
            //     LookupPageID = "Item List";
            //     TableRelation = IF (Item Charge Type=CONST(Tax)) Item WHERE (No.=FIELD(Tax Item No.))
            //                     else IF (Item Charge Type=CONST(Deposit)) Item WHERE (No.=FIELD(Empty Goods Item No.));

            //     trigger OnLookup(Text: Text): Boolean;
            //     begin
            //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
            //         Text := GetTrackingItemNo();
            //         LookupItemNo(Text);
            //         EXIT(FALSE);
            //     end;
            // }
            //BC Upgrade KAPOOV01 Drink-it<<
        }
        addafter("Dimension 3 Value Code")
        {
            field("Reporting Type"; Rec."Reporting Type FND")
            {
                ApplicationArea = All;   // BC Upgrade SHUKLP03 <<
                Caption = 'Reporting Type';
                ToolTip = 'Specifies the value of the Reporting Type field.';
            }
            field("Shortcut 1 Value Code"; Rec."Shortcut 1 Value Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut 1 Value Code field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Shortcut 1 Value Code field.';

            }
            field("Shortcut 2 Value Code"; Rec."Shortcut 2 Value Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut 2 Value Code field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Shortcut 2 Value Code field.';

            }
        }
        addafter(Quantity)
        {
            //BC Upgrade KAPOOV01 Drink-it>>
            //     field("Quantity in HL"; "Quantity in HL")
            //     {

            //         trigger OnDrillDown();
            //         begin
            //             // <<DITW15.00.00.23 DDR 22/07/2008
            //             DrillDown(FIELDNO("Quantity in HL"));
            //             // >>DITW15.00.00.23 DDR
            //         end;
            //     }
            // }
            // addafter("Invoiced Quantity")
            // {
            //     field("Invoiced Quantity in HL"; "Invoiced Quantity in HL")
            //     {

            //         trigger OnDrillDown();
            //         begin
            //             // <<DITW15.00.00.25 DDR 10/10/2008
            //             DrillDown(FIELDNO("Invoiced Quantity in HL"));
            //             // >>DITW15.00.00.25 DDR
            //         end;
            //     }
            //     field("Discount Amount"; "Discount Amount")
            //     {

            //         trigger OnDrillDown();
            //         begin
            //             // <<DITW15.00.00.23 DDR 22/07/2008
            //             DrillDown(FIELDNO("Discount Amount"));
            //             // >>DITW15.00.00.23 DDR
            //         end;
            //     }
            //     field("Sales Deposit Amount (Actual)"; "Sales Deposit Amount (Actual)")
            //     {

            //         trigger OnDrillDown();
            //         begin
            //             // <<DITW15.00.00.23 DDR 22/07/2008
            //             DrillDown(FIELDNO("Sales Deposit Amount (Actual)"));
            //             // >>DITW15.00.00.23 DDR
            //         end;
            //     }
            //     field("Purchase Deposit Amt. (Actual)"; "Purchase Deposit Amt. (Actual)")
            //     {

            //         trigger OnDrillDown();
            //         begin
            //             // <<DITW15.00.00.23 DDR 22/07/2008
            //             DrillDown(FIELDNO("Purchase Deposit Amt. (Actual)"));
            //             // >>DITW15.00.00.23 DDR
            //         end;
            //     }
            //     field("Sales Tax Amount (Actual)"; "Sales Tax Amount (Actual)")
            //     {

            //         trigger OnDrillDown();
            //         begin
            //             // <<DITW15.00.00.23 DDR 22/07/2008
            //             DrillDown(FIELDNO("Sales Tax Amount (Actual)"));
            //             // >>DITW15.00.00.23 DDR
            //         end;
            //     }
            //     field("Purchase Tax Amount (Actual)"; "Purchase Tax Amount (Actual)")
            //     {

            //         trigger OnDrillDown();
            //         begin
            //             // <<DITW15.00.00.23 DDR 22/07/2008
            //             DrillDown(FIELDNO("Purchase Tax Amount (Actual)"));
            //             // >>DITW15.00.00.23 DDR
            //         end;
            //     }
            //     field("Internal Tax Amount (Actual)"; "Internal Tax Amount (Actual)")
            //     {

            //         trigger OnDrillDown();
            //         begin
            //             // <<DITW15.00.00.25 DDR 10/10/2008
            //             DrillDown(FIELDNO("Internal Tax Amount (Actual)"));
            //             // >>DITW15.00.00.25 DDR
            //         end;
            //     }
            //BC Upgrade KAPOOV01 Drink-it>>
            field("Source Type"; Rec."Source Type")
            {
                Description = 'DIT-770 #240';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Source Type field.';
            }
            field("Source No."; Rec."Source No.")
            {
                Description = 'DIT-770 #240';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Source No. field.';
            }

            // field("Item Ledger Entry source No."; "Item Ledger Entry source No.")
            // {
            //     Description = 'DIT-770 #240';
            // }
        }
    }


    //Unsupported feature: PropertyModification on "SetAnalysisViewEntry(PROCEDURE 2).ItemAViewEntryToValueEntries(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SetAnalysisViewEntry : ItemAViewEntryToValueEntries;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SetAnalysisViewEntry : 7151;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "TempValueEntry(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //TempValueEntry : "Value Entry";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TempValueEntry : 5802;
    //Variable type has not been exported.


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if "Analysis View Code" <> xRec."Analysis View Code" then;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "Analysis View Code" <> xRec."Analysis View Code" THEN;
    */
    //end;

    procedure pFieldNo();
    begin
    end;


    //Unsupported feature: CodeModification on "DrillDown(PROCEDURE 1)". Please convert manually.

    //procedure DrillDown();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetAnalysisViewEntry(Rec);
    TempValueEntry.FILTERGROUP(DATABASE::"Item Analysis View Entry"); // Trick: FILTERGROUP is used to transfer an integer value
    PAGE.RUNMODAL(PAGE::"Value Entries",TempValueEntry);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW15.00.00.23 DDR 22/07/2008 Added parameter 'pFieldNo'
    SetAnalysisViewEntry(Rec);
    TempValueEntry.FILTERGROUP(DATABASE::"Item Analysis View Entry"); // Trick: FILTERGROUP is used to transfer an integer value
    // <<DITW15.00.00.23 DDR 22/07/2008
    //PAGE.RUNMODAL(PAGE::"Value Entries",TempValueEntry);
    CASE pFieldNo OF
      FIELDNO("Invoiced Quantity"):
        PAGE.RUNMODAL(PAGE::"Value Entries",TempValueEntry,TempValueEntry."Invoiced Quantity");
      FIELDNO("Sales Amount (Actual)"):
        PAGE.RUNMODAL(PAGE::"Value Entries",TempValueEntry,TempValueEntry."Sales Amount (Actual)");
      FIELDNO("Cost Amount (Actual)"):
        PAGE.RUNMODAL(PAGE::"Value Entries",TempValueEntry,TempValueEntry."Cost Amount (Actual)");
      FIELDNO("Cost Amount (Non-Invtbl.)"):
        PAGE.RUNMODAL(PAGE::"Value Entries",TempValueEntry,TempValueEntry."Cost Amount (Non-Invtbl.)");
      FIELDNO(Quantity):
        PAGE.RUNMODAL(PAGE::"Value Entries",TempValueEntry,TempValueEntry."Item Ledger Entry Quantity");
      FIELDNO("Sales Amount (Expected)"):
        PAGE.RUNMODAL(PAGE::"Value Entries",TempValueEntry,TempValueEntry."Sales Amount (Expected)");
      FIELDNO("Cost Amount (Expected)"):
        PAGE.RUNMODAL(PAGE::"Value Entries",TempValueEntry,TempValueEntry."Cost Amount (Expected)");
      FIELDNO("Sales Deposit Amount (Actual)"):
        PAGE.RUNMODAL(PAGE::"Value Entries",TempValueEntry,TempValueEntry."Sales Deposit Amount (Actual)");
      FIELDNO("Sales Deposit Amount (Exp)"):
        PAGE.RUNMODAL(PAGE::"Value Entries",TempValueEntry,TempValueEntry."Sales Deposit Amount (Exp)");
      FIELDNO("Purchase Deposit Amt. (Actual)"):
        PAGE.RUNMODAL(PAGE::"Value Entries",TempValueEntry,TempValueEntry."Purchase Deposit Amt. (Actual)");
      FIELDNO("Purchase Deposit Amt. (Exp)"):
        PAGE.RUNMODAL(PAGE::"Value Entries",TempValueEntry,TempValueEntry."Purchase Deposit Amt. (Exp)");
      FIELDNO("Sales Tax Amount (Actual)"):
        PAGE.RUNMODAL(PAGE::"Value Entries",TempValueEntry,TempValueEntry."Sales Tax Amount (Actual)");
      FIELDNO("Sales Tax Amount (Expected)"):
        PAGE.RUNMODAL(PAGE::"Value Entries",TempValueEntry,TempValueEntry."Sales Tax Amount (Expected)");
      FIELDNO("Purchase Tax Amount (Actual)"):
        PAGE.RUNMODAL(PAGE::"Value Entries",TempValueEntry,TempValueEntry."Purchase Tax Amount (Actual)");
      FIELDNO("Purchase Tax Amount (Expected)"):
        PAGE.RUNMODAL(PAGE::"Value Entries",TempValueEntry,TempValueEntry."Purchase Tax Amount (Expected)");
      // <<DITW15.00.00.23 DDR 14/08/2008 - DITW15.00.00.25 DDR 10/10/2008
      FIELDNO("Internal Tax Amount (Actual)"):
        PAGE.RUNMODAL(PAGE::"Value Entries",TempValueEntry,TempValueEntry."Internal Tax Amount (Actual)");
      FIELDNO("Internal Tax Amount (Exp)"):
        PAGE.RUNMODAL(PAGE::"Value Entries",TempValueEntry,TempValueEntry."Internal Tax Amount (Exp)");
      FIELDNO("Quantity in HL"):
        PAGE.RUNMODAL(PAGE::"Value Entries",TempValueEntry,TempValueEntry."Item Ledger Entry Quantity HL");
      FIELDNO("Invoiced Quantity in HL"):
        PAGE.RUNMODAL(PAGE::"Value Entries",TempValueEntry,TempValueEntry."Invoiced Quantity in HL");
      FIELDNO("Discount Amount"):
        PAGE.RUNMODAL(PAGE::"Value Entries",TempValueEntry,TempValueEntry."Discount Amount");
      else
        PAGE.RUNMODAL(PAGE::"Value Entries",TempValueEntry);
    end;
    // >>DITW15.00.00.25 DDR
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

