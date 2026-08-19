pageextension 55008 CostJournalExt extends "Cost Journal"
{
    // version NAVW110.0

    // HEI.02 FDD-BPMGAP BRD HB398 IBM NASTAA02 04.06.2019 # Actual Product Costing
    //   # New Page Action added: "Dimensions"
    //   # New Field added: "Dimension Set ID"
    // HEI.03 CHG2061485 IBM BULIMC01 16/05/2020  #CA Module
    //     #changes for "Allocate expenses" action:
    //     #replace the local variable "AllocatebySKU" with "AllocatebySKU2"
    //     #new action created: "CA Module Gaps"
    // HEI.04 CHG2068359 BULIMC01 IBM 08.10.2020 #new boolean field displayed - "Shipping Cost"
    // HEI.05 CHG2088211 BULIMC01 IBM 10/11/2020 #2 new page actions created:
    //   # "CA Module - Customer Missing Dimensions"
    //   # "CA Module - Item Missing Dimensions"
    //BC Upgrade KAPOOV01 >>
    //Moved action-"Allocate expenses" to DTW EXT >>
    //Added ApplicationArea Properties
    //BC Upgrade KAPOOV01 <<

    layout
    {
        modify("CostJnlBatchName")
        {
            CaptionML = ENU = 'Batch Name', FRA = 'Nom de la feuille';
        }
        modify("Cost Type Name")
        {
            CaptionML = ENU = 'Cost Type Name', FRA = 'Nom Type de coût';
        }
        modify("BalCostTypeName")
        {
            CaptionML = ENU = 'Bal. Cost Type Name', FRA = 'Nom type coût contrep.';
        }
        modify("Bal. Cost Type Name")
        {
            CaptionML = ENU = 'Bal. Cost Type Name', FRA = 'Nom type coût contrep.';
        }
        // modify("Control 27")
        // {
        //     CaptionML = ENU = 'Balance', FRA = 'Solde';
        // }//BC Upgrade Kapoov01 Commented to resolve compilation errors.
        modify(Balance)
        {
            CaptionML = ENU = 'Balance', FRA = 'Solde';
        }
        modify("Total Balance")
        {
            CaptionML = ENU = 'Total Balance', FRA = 'Solde final';
        }
        modify(TotalBalance)
        {
            CaptionML = ENU = 'Total Balance', FRA = 'Solde final';
        }
        addafter(LineBalance)
        {
            field(Brand; Rec."Brand FND")
            {
                ApplicationArea = All;
            }
            field(Line; Rec."Line FND")
            {
                ApplicationArea = All;
            }
            field("Shipping Cost"; Rec."Shipping Cost FND")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Source Code")
        {
            field("Dimension Set ID"; Rec."Dimension Set ID FND")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("P&ost")
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
        }
        modify(Post)
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
        }
        modify(TestReport)
        {
            CaptionML = ENU = 'Test Report', FRA = 'Impression test';
            ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';
        }
        modify(PostandPrint)
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
        }
        addafter(Post)
        {
            group(Allocation)
            {
                //BC Upgrade KAPOOV01 Moved action-"Allocate expenses" to DTW EXT >>
                // action("Allocate expenses")
                // {
                //     Image = Allocate;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     PromotedIsBig = true;
                //     PromotedOnly = true;
                //     ApplicationArea = All;

                //     trigger OnAction();
                //     var
                //         AllocatebySKU2: Report "Allocate by SKU V.2";
                //     begin
                //         //HEI.01>>
                //         //AllocatebySKU.SetDocNo(Rec); commented by HEI.03
                //         //AllocatebySKU.RUNMODAL; commented by HEI.03
                //         //HEI.03>>
                //         AllocatebySKU2.SetDocNo(Rec);
                //         AllocatebySKU2.RUNMODAL();
                //         //HEI.03<<
                //         CurrPage.UPDATE(FALSE);
                //         //HEI.01<<
                //     end;
                // }
                //BC Upgrade KAPOOV01 Moved action-"Allocate expenses" to DTW EXT <<
                action("CA Module Gaps")
                {
                    Caption = 'CA Module Gaps';
                    Image = Find;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        CAModuleFindGaps: Report "CA Module - Find Gaps";
                    begin
                        //HEI.03>>
                        CAModuleFindGaps.SetDocNo(Rec);
                        CAModuleFindGaps.RUNMODAL();
                        CurrPage.UPDATE(FALSE);
                        //HEI.03<<
                    end;
                }
            }
            group(Dimensions)
            {
                action(Dimension)
                {
                    AccessByPermission = TableData 348 = R;
                    CaptionML = ENU = 'Dimensions',
                                FRA = 'Axes analytiques';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.',
                                FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        DimSetEntry: Record "Dimension Set Entry";
                        DimSetEntries: Page "Dimension Set Entries";
                    begin
                        //HEI.02>>
                        DimSetEntry.RESET();
                        DimSetEntry.FILTERGROUP(2);
                        DimSetEntry.SETRANGE("Dimension Set ID", Rec."Dimension Set ID FND");
                        DimSetEntry.FILTERGROUP(0);
                        DimSetEntries.SETTABLEVIEW(DimSetEntry);
                        DimSetEntries.SetFormCaption(STRSUBSTNO('%1 %2', Rec.TABLECAPTION, Rec."Cost Entry No."));
                        DimSetEntry.RESET();
                        DimSetEntries.RUNMODAL();
                        //HEI.02<<
                    end;
                }
                action("Customer Missing Dimensions")
                {
                    Caption = 'Missing Customer Dimensions';
                    Image = CostAccountingDimensions;
                    RunObject = Report "CA Module - Cust. Dimensions";
                    ApplicationArea = All;
                }
                action("Item Missing Dimensions")
                {
                    Caption = 'Missing Item Dimensions';
                    Image = CostAccountingDimensions;
                    RunObject = Report "CA Module - Item Dimensions";
                    ApplicationArea = All;
                }
            }
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

