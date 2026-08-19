pageextension 51083 LotNoInformationCardExtCBN extends "Lot No. Information Card"
{
    // DITW15.00.00.38 25/10/2010 issue 1139 SSCC Functionnalities
    //                                       Added fields "SSCC Inventory" into tab 'Inventory'
    //                                       Added menu 'SSCC Tracking Entries' into button 'Lot no.'
    //                 19/11/2010            Added parameter function CallSSCCTrackingEntryForm()
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities (Temp test with TIF coderules.txt)
    //                                             Modified C/AL "CurrForm.Blocked.EDITABLE"

    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // DITW110.00.11 VSC 27/09/2017 NRQ#18377 Merge - QXL10.01 VSC 27/09/2017 NRQ#33079 : Failures in creating Quality tests (from Lot. No. Information Card, from Tracking page)
    //                                     User should be able to create a new test even if there is no inventory
    //                                     Move double code to New function CreateTest
    // DITW110.00.11 VSC 30/10/2017 NRQ#42348 Merge XL NRQ#43357
    // QXL11.01 MTR 13/09/2018 NRQ#24975 : Added fields "Your Reference","Expiration Date"

    // HEI.01 RFC-CHG0254800 IBM.AB 23.10.2018
    //   # Options in "Quality Status" field are changed

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies this number from the Tracking Specification table when a lot number information record is created.', FRA = 'Spécifie ce numéro à partir de la table Spécification traçabilité lorsqu''un enregistrement information numéro de lot est créé.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the content of this field from the Tracking Specification table when a lot no. information record is created.', FRA = 'Spécifie le contenu de ce champ à partir de la table Spécification traçabilité lorsqu''un enregistrement information numéro de lot est créé.';
        }
        modify("Lot No.")
        {
            ToolTipML = ENU = 'Specifies this number from the Tracking Specification table when a lot number information record is created.', FRA = 'Spécifie ce numéro à partir de la table Spécification traçabilité lorsqu''un enregistrement information numéro de lot est créé.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the lot no. information record.', FRA = 'Indique une description de l''enregistrement informations numéro de lot.';
        }
        modify("Test Quality")
        {
            ToolTipML = ENU = 'Specifies the quality of a given lot if you have inspected the items.', FRA = 'Spécifie la qualité d''un lot donné si vous avez contrôlé les articles.';
        }
        modify("Certificate Number")
        {
            ToolTipML = ENU = 'Specifies the number provided by the supplier to indicate that the batch or lot meets the specified requirements.', FRA = 'Spécifie le numéro de certificat fourni par le fournisseur pour indiquer que le lot répond aux exigences spécifiées.';
        }
        modify(Blocked)
        {
            ToolTipML = ENU = 'Specifies that a document or journal line carrying the specified lot number cannot be posted.', FRA = 'Spécifie qu''une ligne document ou feuille portant le numéro de lot spécifié ne peut pas être validée.';

            //Unsupported feature: Change Description on "Blocked(Control 15)". Please convert manually.


            //Unsupported feature: Change Editable on "Blocked(Control 15)". Please convert manually.

        }
        modify(Inventory)
        {
            CaptionML = ENU = 'Inventory', FRA = 'Stocks';
        }
        modify(InventoryField)
        {
            ToolTipML = ENU = 'Specifies the inventory quantity of the specified lot number.', FRA = 'Spécifie la quantité en stock portant le numéro de lot spécifié.';
        }//BC Upgrade KAPOOV01 changed field name to InventoryField as per defined in Base.
        modify("Expired Inventory")
        {
            ToolTipML = ENU = 'Specifies the inventory of the lot number with an expiration date before the posting date on the associated document.', FRA = 'Spécifie le stock d''articles portant le numéro de lot en question et dont la date d''expiration est antérieure à la date comptabilisation du document associé.';
        }

        //Unsupported feature: CodeInsertion on "Blocked(Control 15)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        CALCFIELDS(Comment);
        */
        //end;
        //BC Upgrade KAPOOV01 Drink-it>>
        // addafter("Lot No.")
        // {
        //     field("Gyle No."; "Gyle No.")
        //     {
        //         CaptionClass = '2035140,1';
        //     }
        // }
        // addafter(Description)
        // {
        //     field("Your Reference"; "Your Reference")
        //     {
        //         Description = 'QXL11.01';
        //     }
        //     field("Expiration Date"; "Expiration Date")
        //     {
        //         Description = 'QXL11.01';
        //         Editable = false;
        //     }
        // }
        // addafter("Certificate Number")
        // {
        //     field("Quality Status"; "Quality Status")
        //     {
        //         Editable = QualityStatusEditable;
        //         OptionCaptionML = ENU = 'Quality Hold,Unrestricted,Blocked',
        //                           FRA = 'Quarantaine,Bon,Mauvais';
        //     }
        // }
        // addafter("Expired Inventory")
        // {
        //     field("SSCC Inventory"; "SSCC Inventory")
        //     {
        //     }
        // }
        //BC Upgrade KAPOOV01 Drink-it<<
    }
    actions
    {
        modify("&Lot No.")
        {
            CaptionML = ENU = '&Lot No.', FRA = 'N° &lot';
        }
        modify("Item &Tracking Entries")
        {
            CaptionML = ENU = 'Item &Tracking Entries', FRA = '&Ecritures traçabilité';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify("&Item Tracing")
        {
            CaptionML = ENU = '&Item Tracing', FRA = 'Traçab&ilité';
        }
        modify(ButtonFunctions)
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(CopyInfo)
        {
            CaptionML = ENU = 'Copy &Info', FRA = '&Info copie';
        }
        modify(Navigate)
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
        }

        addfirst("&Lot No.")
        {
            action("Pallet Label")
            {
                Image = Lot;
                ApplicationArea = All;
                ToolTip = 'Executes the Pallet Label action.';

                trigger OnAction();
                begin
                    //HEI.02>>
                    CLEAR(PalletLabel);
                    PalletLabel.SetCalculationParameter(Rec."Item No.", Rec."Lot No.", false);
                    PalletLabel.RUNMODAL();
                    //HEI.02<<
                end;
            }
        }
        addafter("Item &Tracking Entries")
        {
            action("SSCC Tracking Entries")
            {
                CaptionML = ENU = 'SSCC Tracking Entries',
                            FRA = 'Ecritures traçablité SSCC';
                Image = ItemTrackingLedger;
                ApplicationArea = All;
                ToolTip = 'Executes the SSCC Tracking Entries action.';
                //BC Upgrade KAPOOV01 Drink-it>>
                // trigger OnAction();
                // var
                //     SSCCTrackingMgt: Codeunit "SSCC Tracking Management";
                // begin
                //     // <<DITW15.00.00.38 25/10/2010 - 19/11/2010 #1139
                //     SSCCTrackingMgt.CallSSCCTrackingEntryForm(0, '', "Item No.", "Variant Code", '', "Lot No.", '', 0);
                // end;
                //BC Upgrade KAPOOV01 Drink-it<<
            }
            action("&Quality Tracking Entries")
            {
                CaptionML = ENU = '&Quality Tracking Entries',
                            FRA = '&Ectitures Traçabilité qualité';
                Image = ItemTrackingLedger;
                ApplicationArea = All;
                ToolTip = 'Executes the &Quality Tracking Entries action.';
                //BC Upgrade KAPOOV01 Drink-it>>
                // trigger OnAction();
                // var
                //     QualityTrackingEntry: Record "Quality Tracking Entry";
                //     QualityTrackingEntries: Page "Quality Tracking Entries";
                // begin
                //     QualityTrackingEntries.SetFormRunMode(3);
                //     QualityTrackingEntry.SETRANGE("Lot No.", "Lot No.");
                //     QualityTrackingEntries.SETTABLEVIEW(QualityTrackingEntry);
                //     QualityTrackingEntries.RUNMODAL;
                //     CLEAR(QualityTrackingEntries);
                // end;
                //BC Upgrade KAPOOV01 Drink-it<<
            }
        }
        addafter("&Item Tracing")
        {
            action("Test History")
            {
                CaptionML = ENU = 'Test History',
                            FRA = 'Historique des test';
                Image = History;
                ApplicationArea = All;
                ToolTip = 'Executes the Test History action.';
                //BC Upgrade KAPOOV01 Drink-it>>
                // trigger OnAction();
                // var
                //     Item: Record Item;
                //     ItemTestHistory: Page "Item Test History";
                // begin
                //     ItemTestHistory.SetLotNoInfo(Rec);
                //     Item.GET("Item No.");
                //     ItemTestHistory.SETRECORD(Item);
                //     ItemTestHistory.RUNMODAL;
                // end;
                //BC Upgrade KAPOOV01 Drink-it<<
            }
        }
        addafter(ButtonFunctions)
        {
            group(Quality)
            {
                CaptionML = ENU = 'Quality',
                            FRA = 'Qualité';
                action("Create Quality Test")
                {
                    CaptionML = ENU = 'Create Quality Test',
                                FRA = 'Créer test qualité';
                    Image = TaskQualityMeasure;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Create Quality Test action.';
                    //BC Upgrade KAPOOV01 Drink-it>>
                    // trigger OnAction();
                    // var
                    //     TempTrackingSpecification: Record "Tracking Specification" temporary;
                    //     QualityTestHeader: Record "Quality Test Header";
                    //     CreateLotTestYesNo: Codeunit "Create Lot Test (Yes/No)";
                    //     CreateManualTestLotSN: Codeunit "Create Test Manual LotSn";
                    // begin
                    //     //<< QXL10.01 VSC 27/09/2017 NRQ#33079
                    //     CreateQualityTest(false);
                    //     //>> QXL10.01 VSC NRQ#33079
                    //     /// QXL10.01 VSC 27/09/2017 NRQ#33079 - QXL9.00.001 DAT 23/03/2016
                    // end;
                    //BC Upgrade KAPOOV01 Drink-it<<
                }
                action("Create Ad Hoc Quality Test")
                {
                    CaptionML = ENU = 'Create Ad Hoc Quality Test',
                                FRA = 'Créer test qualité Ad Hoc';
                    Image = TaskQualityMeasure;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Create Ad Hoc Quality Test action.';
                    //BC Upgrade KAPOOV01 Drink-it>>
                    // trigger OnAction();
                    // var
                    //     TempTrackingSpecification: Record "Tracking Specification" temporary;
                    //     QualityTestHeader: Record "Quality Test Header";
                    //     CreateAdHocLotTestYesNo: Codeunit "Create AdHoc Lot Test (Yes/No)";
                    //     CreateManualTestLotSN: Codeunit "Create Test Manual LotSn";
                    // begin
                    //     //<< QXL10.01 VSC 27/09/2017 NRQ#33079
                    //     CreateQualityTest(false);
                    //     //>> QXL10.01 VSC NRQ#33079

                    //     /// QXL10.01 VSC 27/09/2017 NRQ#33079 - QXL9.00.001 DAT 23/03/2016
                    // end;
                    //BC Upgrade KAPOOV01 Drink-it<<
                }
            }
        }
    }

    var
        //QualitySetup: Record "Quality Setup";//BC Upgrade KAPOOV01 Drink-it
        PalletLabel: Report "Pallet Label CBN";
        QualityStatusEditable: Boolean;


    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //begin
    /*
    //<< QXL10.01 VSC 30/10/2017 NRQ#43357
    UpdateEditable;
    //>> QXL10.01 VSC NRQ#43357
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //begin
    /*
    //<< QXL10.01 VSC 30/10/2017 NRQ#43357
    UpdateEditable;
    //>> QXL10.01 VSC NRQ#43357
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    ButtonFunctionsVisible := true;
    */
    //end;
    //BC Upgrade KAPOOV01 Drink-it>>
    // local procedure CreateQualityTest(AdHoc: Boolean);
    // var
    //     TempTrackingSpecification: Record "Tracking Specification" temporary;
    //     QualityTestHeader: Record "Quality Test Header";
    //     CreateLotTestYesNo: Codeunit "Create Lot Test (Yes/No)";
    //     CreateManualTestLotSN: Codeunit "Create Test Manual LotSn";
    // begin
    //     //<< QXL10.01 VSC 27/09/2017 NRQ#33079

    //     //<<QXL9.00.001 DAT 23/03/2016
    //     //<< QXL10.01 VSC 27/09/2017 NRQ#33079
    //     //TESTFIELD(Inventory);
    //     //>> QXL10.01 VSC NRQ#33079
    //     TempTrackingSpecification.INIT;
    //     TempTrackingSpecification."Entry No." := 1;
    //     TempTrackingSpecification."Item No." := "Item No.";
    //     TempTrackingSpecification."Variant Code" := "Variant Code";
    //     TempTrackingSpecification."Lot No." := "Lot No.";
    //     TempTrackingSpecification."Source Type" := 6505;
    //     TempTrackingSpecification."Source Subtype" := 0;
    //     TempTrackingSpecification."Quantity (Base)" := Inventory;
    //     TempTrackingSpecification."Qty. to Handle (Base)" := Inventory;
    //     TESTFIELD("Lot No.");
    //     QualityTestHeader.SETCURRENTKEY("Item No.", "Lot No.", "Serial No.", "Document Date");
    //     QualityTestHeader.SETRANGE("Item No.", "Item No.");
    //     QualityTestHeader.SETRANGE("Lot No.", "Lot No.");
    //     if QualityTestHeader.FINDLAST then begin
    //         TempTrackingSpecification."Location Code" := QualityTestHeader."Location Code";
    //         TempTrackingSpecification."Bin Code" := QualityTestHeader."Bin Code";
    //     end;
    //     TempTrackingSpecification.INSERT;
    //     CreateManualTestLotSN.CreateTestWithSelectEntries(TempTrackingSpecification, AdHoc);
    //     //>>QXL9.00.001 DAT 23/03/2016
    // end;

    // local procedure UpdateEditable();
    // var
    //     QualityUser: Record "Quality User";
    // begin
    //     //<< QXL10.01 VSC 30/10/2017 NRQ#43357
    //     if not QualitySetup.GET then begin
    //         QualityStatusEditable := false;
    //         exit;
    //     end;
    //     if not QualityUser.GET(USERID) then
    //         QualityUser.INIT;
    //     QualityStatusEditable := QualityUser."Block Quality Tracked Lots" or QualityUser."Unblock Quality Tracked Lots";
    // end;
    //BC Upgrade KAPOOV01 Drink-it<<
    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

    //BC UPGRADE PATHAA02 GAP014_DTW, IBM GAP DTW 43>>
    
    trigger OnAfterGetRecord()
    var
        WHSUTILS: Codeunit "WHS-UTILS";
    begin
        WHSUTILS.OnAfterValidateInspectionStatusLotNoInformation(Rec, xRec);
    end;
    //BC UPGRADE PATHAA02 GAP014_DTW, IBM GAP DTW 43<<


}

