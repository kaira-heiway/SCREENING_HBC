pageextension 51154 WhseReceiptSubformExtCBN extends "Whse. Receipt Subform"
{
    // version NAVW110.0,QXL9.00.001,DITW110.00.11,HEI.08
    //     DITW15.00.00.21 DDR 18/06/2008 added function PutWhsereceivementLines() using with button from Header form
    //                                added columns "Weight" and "Cubage"
    // DITW15.00.00.23.04 DDR£ 12/09/2008
    //                                added columns "Cubage to receive","Weight to receive"
    // DITW15.00.00.33 DDR 13/05/2009 Added columns
    //                                 "Source Line No.","Item DTax Group Code","Src. DTax Group Code" (non-visible/non-editable)
    // DITW15.00.00.36 DDR 06/11/2009 issue 777 Added functions ShowCommentLines(),HasComments(),CalcSourceTotalWV()
    // DITW15.00.00.37 DDR 10/06/2010 issue 1061 Added fields "Physical Location Group Code"
    // DITW15.00.00.39 DDR 12/04/2011 issue 1296 Added AAD/ARC functionnality
    //                                  Added fields "AAD No.","ARC No.","Packaging Type Code"
    //                                  Added function ShowGetARCNoEDI()
    //                                  Added text constant Text2014260
    //                     11/07/2011 issue 1369 Added fields "Applies-to AAD Trck. Entry No."
    // DITW15.00.00.39 DDR 22/08/2011 #1399 New Batch to post warehouse shipment (based on report 269 workflow)
    // DITW16.00.00.40 DDR 02/01/2012 DIT-715 #185 Added refresh subform on "Qty. to Receive" field
    //                                             Added non-editable when existing "Attached to line no." on fields
    //                                               "Qty. to Receive","Qty. to Receive (Base)",
    //                                               "Qty. to Cross-Dock","Qty. to Cross-Dock (Base)"
    // DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
    //                                Added shortcut (warehouse) fields
    //                                  Control1100079000 Shortcut Unit of Measure1 Code
    //                                  Control1100079001 Shortcut Unit of Measure2 Code
    //                                  Control1100079002 Shortcut Unit of Measure3 Code
    //                                Added Standard Global Dimension Lookup (see from 53 as reference)
    //                     17/02/2012 DIT-715 #246
    //                                Removed call parameter function PutWhseReceiptLines()
    //                     01/03/2012 DIT-715 #246 Bugfix RTC to show columns SourceTotalWeight,SourceTotalVolume
    //                                             Removed all depending of HasColumnTotVW global variable
    //                                             Removed 'Name' property columns SourceTotalWeight,SourceTotalVolume
    // DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    //                                             Added functions OpenSSCCTrackingLines()
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0013.1
    //                             added return reason code
    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW18.00.07 VSC 19/02/2016 DIT-770 #1703 New _AllItemsAvailability
    // DITW18.00.07 VSC 19/02/2016 DIT-770 #1703 New Page Actions

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // DITW110.00.09 DDR 10/04/2017 NRQ#13065 Added "ARC No. Mandatory"
    // DITW110.00.11 VSC 03/10/2017 NRQ#33755 New Field Backorder Type
    // DITW110.00.11 MSF 04/10/2017 NRQ#39012 : Added Action GetPostedDocumentLinesToReverse

    // HEI.01 FDD LOGGAP08 IBM POSTOI01 29.05.2018
    //   # show new field Source Original Quantity
    // HEI.02 FDD-RW-GAPLOG10 IBM ISYED01 30-10-2018 RPM Breakages
    //   #Added new Page to the action Items Customer diff RPM.
    // HEI.03 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new fields added "Load No." & "Sequence No."
    // HEI.04 FDD-HB899 - CHG2093015 IBM NASTAA02  22.01.2021 # LSR - Sales And Payments
    //   # Code added on 'OnDelete' trigger
    // HEI.05 CHG2155847 HB2821 IBM NANDIS01 11.08.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Shown the field - "Astro Integration" in General tab
    // HEI.06 CHG2155847 HB2821 IBM NANDIS01 08.09.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Removed the field - "Astro Integration" in General tab
    // HEI.07 CHG2162715 HB3020 NORRIQ KOROLA04 07.11.2022
    //   # SPL Code, SPL Name - fields created
    // HEI.08 CHG2155847 HB2821 IBM NANDIS01 24.11.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # New field added - "Astro Unique ID"
    // DITW114.00.15 DDR 24/04/2020 NRQ#102424 Fix remove non-editable on source promotion lines
    // HEI.09 CHG2188015 DEBUSD01 10.01.2023 Qty to Ship behavior on promotionline partialShipments
    //   # merge NRQ#102424

    // BC Upgrade SHUKLP03 >>
    // DrinkIT code, fields, actions and procedures are blocked.
    // HEI.02 => Whole action("Customer Differences (RPM)") is blocked, because dependency on procedure InsertRPMCustomerDifferences of codeunit Heineken Global.
    // BC Upgrade SHUKLP03 <<

    layout
    {
        addafter("Source No.")
        {
            field("Source Line No."; Rec."Source Line No.")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the line number of the source document that the entry originates from.';
            }


            // BC Upgrade SHUKLP03 >> DrinkIT field is blocked.

            // field("Src. DTax Group Code";"Src. DTax Group Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field(SourceTotalWeight;SourceTotalWeight)
            // {
            //     CaptionML = ENU='Source Header Total Weight',
            //                 FRA='Origine entête poids total';
            //     Editable = false;
            //     Visible = false;

            //     trigger OnDrillDown();
            //     begin
            //         // <<DITW15.00.00.36 DDR 06/11/2009
            //         DrillDownTotalHeaderVolWeight(0);
            //         // >>DITW15.00.00.36 DDR
            //     end;
            // }
            // field(SourceTotalVolume;SourceTotalVolume)
            // {
            //     CaptionML = ENU='Source Header Total Volume (Cubage)',
            //                 FRA='Origine entête volume total (cubage)';
            //     Editable = false;
            //     Visible = false;

            //     trigger OnDrillDown();
            //     begin
            //         // <<DITW15.00.00.36 DDR 06/11/2009
            //         DrillDownTotalHeaderVolWeight(1);
            //         // >>DITW15.00.00.36 DDR
            //     end;
            // }
            // field(CSrcCommentHdr;HasSourceCommentHeader)
            // {
            //     CaptionML = ENU='Header Comment ',
            //                 FRA='Entête commentaire ';
            //     Editable = false;
            //     OptionCaptionML = ENU='Boolean',
            //                       FRA='Booléen';

            //     trigger OnValidate();
            //     begin
            //         HasSourceCommentHeaderOnPush;
            //     end;
            // }
            // field(CSrcCommentLine;HasSourceCommentLine)
            // {
            //     CaptionML = ENU='Line Comment',
            //                 FRA='Commentaire ligne';
            //     Editable = false;
            //     OptionCaptionML = ENU='Boolean',
            //                       FRA='Booléen';
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         HasSourceCommentLineOnPush;
            //     end;
            // }
        }
        // BC Upgrade SHUKLP03 << DrinkIT field is blocked.

        // BC Upgrade SHUKLP03 >> DrinkIT field is blocked.
        // addafter("Item No.")
        // {
        //     field("Item DTax Group Code";"Item DTax Group Code")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        // }
        // addafter(Description)
        // {
        //     field("Physical Location Group Code";"Physical Location Group Code")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //}
        // BC Upgrade SHUKLP03 << DrinkIT field is blocked.

        addafter("Bin Code")
        {
            field(LotNo; LotNoText)
            {
                CaptionML = ENU = 'Lot No.',
                            FRA = 'N° lot';
                Editable = false;
                Style = Attention;
                StyleExpr = LotNocolor;
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the value of the LotNoText field.';

                trigger OnLookup(var Text: Text): Boolean;
                begin
                    // BC Upgrade SHUKLP03 << DrinkIT code is blocked.
                    // //<<QXL9.00.001 DAT 23/03/2016
                    // OpenItemTrackingLines;
                    // if QualitySetup.READPERMISSION and ("Item No." <> '') then begin
                    //     case "Source Type" of
                    //         DATABASE::"Purchase Line":
                    //             begin
                    //                 QualityManagement.CheckQualityMeasuresStatus("Item No.", "Variant Code", DATABASE::"Purchase Line");
                    //                 LotNo :=
                    //                   QualityManagement.GetLotNos(DATABASE::"Purchase Line", "Source Subtype", "Source No.", '', 0, "Source Line No.", "Item No.",
                    //                   10, Quantity >= 0);
                    //             end;
                    //         DATABASE::"Sales Line":
                    //             begin
                    //                 LotNo :=
                    //                   QualityManagement.GetLotNos(DATABASE::"Sales Line", "Source Subtype", "Source No.", '', 0, "Source Line No.", "Item No.",
                    //                   10, Quantity >= 0);
                    //             end;
                    //         DATABASE::"Transfer Line":
                    //             begin
                    //                 Direction := Direction::Inbound;
                    //                 if TransferLine.GET("Source No.", "Source Line No.") then
                    //                     LotNo :=
                    //                       QualityManagement.GetLotNos(DATABASE::"Transfer Line",
                    //                         Direction, "Source No.", '', TransferLine."Derived From Line No.", "Source Line No.", "Item No.",
                    //                         10, Quantity >= 0);
                    //             end;
                    //     end;
                    // end;
                    // //>>QXL9.00.001 DAT 23/03/2016
                    // BC Upgrade SHUKLP03 << DrinkIT code is blocked.

                end;
            }
            // BC Upgrade SHUKLP03 >> DrinkIT field is blocked.
            // field("No. of Quality Tests"; Rec."No. of Quality Tests")
            // {
            //     Visible = false;
            // }
            // BC Upgrade SHUKLP03 << DrinkIT field is blocked.
        }
        // BC Upgrade SHUKLP03 >> DrinkIT field is blocked.
        // addafter(Quantity)
        // {
        //     field("Return Reason Code"; "Return Reason Code")
        //     {
        //         Description = 'DITW17.00.02 DIT-770 #144';
        //     }
        // }
        // BC Upgrade SHUKLP03 << DrinkIT field is blocked.

        addafter("Qty. Outstanding (Base)")
        {
            field("Source Original Quantity"; Rec."Source Original Quantity FND")
            {
                CaptionML = ENU = 'Source Original Quantity',
                            FRA = 'Quantité';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Source Original Quantity field.';
            }

            // BC Upgrade SHUKLP03 >> DrinkIT field is blocked.

            // field("Backorder Type"; Rec."Backorder Type")
            // {
            //     Description = 'DITW110.00.11 NRQ#33755';
            // }
            // BC Upgrade SHUKLP03 << DrinkIT field is blocked.

        }
        addafter("Qty. per Unit of Measure")
        {
            // BC Upgrade SHUKLP03 >> DrinkIT field is blocked.
            // field("Weight to Receive"; "Weight to Receive")
            // {
            //     Editable = false;
            // }
            // field(Weight; Weight)
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Cubage to Receive"; "Cubage to Receive")
            // {
            //     Editable = false;
            // }
            // field(Cubage; Cubage)
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("AAD No."; "AAD No.")
            // {
            //     Visible = false;
            // }
            // field("ARC No."; "ARC No.")
            // {
            //     Visible = false;

            //     trigger OnLookup(Text: Text): Boolean;
            //     begin
            //         // <<DITW15.00.00.39 DDR 12/04/2011 DIT-712 #1296
            //         exit(
            //           EDILookupExtTrackingARC(Text));
            //     end;
            // }
            // field("SAD No."; "SAD No.")
            // {
            //     Visible = false;
            // }
            // field("ARC No. Mandatory"; "ARC No. Mandatory")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Packaging Type Code"; "Packaging Type Code")
            // {
            //     Visible = false;
            // }
            // field("Applies-to AAD Trck. Entry No."; "Applies-to AAD Trck. Entry No.")
            // {
            //     Description = 'DITW15.00.00.39 #1369';
            //     Visible = false;
            // }
            // field("ShortcutQtyUomValue[1]"; ShortcutQtyUomValue[1])
            // {
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassUom(1);
            //     DecimalPlaces = 0 : 5;
            //     Description = 'DIT-715 #244';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("ShortcutQtyUomValue[2]"; ShortcutQtyUomValue[2])
            // {
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassUom(2);
            //     DecimalPlaces = 0 : 5;
            //     Description = 'DIT-715 #244';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("ShortcutQtyUomValue[3]"; ShortcutQtyUomValue[3])
            // {
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassUom(3);
            //     DecimalPlaces = 0 : 5;
            //     Description = 'DIT-715 #244';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Posting Error Line"; "Posting Error Line")
            // {
            //     Editable = false;
            // }
            // BC Upgrade SHUKLP03 << DrinkIT field is blocked.

            field("Load No."; Rec."Load No. FND")
            {
                Description = 'HEI.03';
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Load No. field.';
            }
            field("Sequence No."; Rec."Sequence No. FND")
            {
                Description = 'HEI.03';
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sequence No. field.';
            }
            field("SPL Code"; Rec."SPL Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SPL Code field.';
            }
            field("SPL Name"; Rec."SPL Name FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SPL Name field.';
            }
            // BC Upgrade SHUKLP03 >> Astro field is blocked.
            // field("Astro Unique ID"; "Astro Unique ID")
            // {
            // }
            // BC Upgrade SHUKLP03 >> Astro field is blocked.

        }
    }
    actions
    {
        // BC Upgrade SHUKLP03 >> DrinkIT actions are blocked.
        // group("F&unctions")
        // {
        //     CaptionML = ENU = 'F&unctions',
        //                 FRA = 'Fonction&s';
        //     action("Get EMCS ARC No. to Apply")
        //     {
        //         CaptionML = ENU = 'Get EMCS ARC No. to Apply',
        //                     FRA = 'Extraire N°ARC EMCS à affecter';

        //         trigger OnAction();
        //         begin
        //             // <<DITW15.00.00.39 DDR 12/04/2011 DIT-712 #1296
        //             //This functionality was copied from page #5768. Unsupported part was commented. Please check it.
        //             /*CurrPage.WhseReceiptLines.PAGE.*/
        //             _ShowGetARCNoEDI();

        //         end;
        //     }
        //     action("&Move Whse. Receipt Line")
        //     {
        //         CaptionML = ENU = '&Move Whse. Receipt Line',
        //                     FRA = 'Déplacer lignes réception entrepôt';
        //         Ellipsis = true;
        //         ShortCutKey = 'Ctrl+M';

        //         trigger OnAction();
        //         begin
        //             // <<DITW15.00.00.21 DDR 19/06/2008
        //             //This functionality was copied from page #5768. Unsupported part was commented. Please check it.
        //             /*CurrPage.WhseReceiptLines.PAGE.*/
        //             PutWhseReciptLines;
        //             // >>DITW15.00.00.21 DDR

        //         end;
        //     }
        //     action(GetPostedDocumentLinesToReverse)
        //     {
        //         Caption = 'Get Posted Doc&ument Lines to Reverse';
        //         Description = 'NRQ#39012 ';
        //         Ellipsis = true;
        //         Image = ReverseLines;
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         PromotedIsBig = true;
        //         Visible = VisibleSaleReturnOrder;

        //         trigger OnAction();
        //         begin
        //             //<<DITW110.00.11 MSF 04/10/2017 NRQ#39012
        //             GetPstdDocLinesToRevere;
        //         end;
        //     }
        // BC Upgrade SHUKLP03 << DrinkIT actions are blocked.

        // BC Upgrade SHUKLP03 << Dependency on procedure InsertRPMCustomerDifferences, because this is blocked.
        // addbefore("&Line")
        // {

        //     action("Customer Differences (RPM)")
        //     {
        //         Caption = 'Customer Differences (RPM)';

        //         trigger OnAction();
        //         var
        //             CustomerDifferencesRPM: Record "Customer Differences RPM FND";
        //             CustomerDifferencesRPMPage: Page "Customer Differences (RPM)";
        //             SalesLine: Record "Sales Line";
        //         begin
        //             //HEI.02>>
        //             /*
        //             CustomerDifferencesRPM.RESET;
        //             CustomerDifferencesRPM.SETFILTER("Sales return order no.",Rec."Source No.");
        //             IF CustomerDifferencesRPM.findset THEN
        //             CustomerDifferencesRPMPage.SETTABLEVIEW(CustomerDifferencesRPM);
        //             CustomerDifferencesRPMPage.SETRECORD(CustomerDifferencesRPM);
        //             CustomerDifferencesRPMPage.RUN;
        //             */

        //             SalesLine.SETRANGE("Document No.", Rec."Source No.");
        //             SalesLine.SETFILTER("Document Type", '%1', SalesLine."Document Type"::"Return Order");
        //             if SalesLine.FINDFIRST then
        //                 HeinekenGlobal.InsertRPMCustomerDifferences(SalesLine);
        //             //HEI.02>>

        //         end;
        //     }
        // }
        // BC Upgrade SHUKLP03 << Dependency on procedure InsertRPMCustomerDifferences, because this is blocked.

    }
    // BC Upgrade SHUKLP03 << DrinkIT actions are blocked.
    // addafter("&Bin Contents List")
    // {
    //     action("Items by Period")
    //     {
    //         CaptionML = ENU = 'Items by Period',
    //                     FRA = 'Articles par période';
    //         Description = 'DIT-715 #338';

    //         trigger OnAction();
    //         begin
    //             //<< DITW18.00.07 VSC 19/02/2016 DIT-770 #1703
    //             _AllItemsAvailability(1);
    //         end;
    //     }
    // }
    // addafter(ItemTrackingLines)
    // {
    //     action("SSCC Tracking Lines")
    //     {
    //         CaptionML = ENU = 'SSCC Tracking Lines',
    //                     FRA = 'Lignes Traçabilité SSCC';
    //         Description = 'DIT-715 #745';
    //         Image = ItemTrackingLines;

    //         trigger OnAction();
    //         begin
    //             // <<DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745
    //             //This functionality was copied from page #5768. Unsupported part was commented. Please check it.
    //             /*CurrPage.WhseReceiptLines.FORM.*/
    //             _OpenSSCCTrackingLines;

    //         end;
    //     }
    //     action("Source &Comment Lines (header)")
    //     {
    //         CaptionML = ENU = 'Source &Comment Lines (header)',
    //                     FRA = 'Ligne origine commentaire (Entête)';

    //         trigger OnAction();
    //         begin
    //             // <<DITW15.00.00.36 DDR 06/11/2009
    //             //This functionality was copied from page #5768. Unsupported part was commented. Please check it.
    //             /*CurrPage.WhseReceiptLines.PAGE.*/
    //             _ShowCommentLines(0);
    //             // >>DITW15.00.00.36 DDR

    //         end;
    //     }
    //     action("Source &Comment Lines")
    //     {
    //         CaptionML = ENU = 'Source &Comment Lines',
    //                     FRA = 'Lignes origine &commentaire';

    //         trigger OnAction();
    //         begin
    //             // <<DITW15.00.00.36 DDR 06/11/2009
    //             //This functionality was copied from page #5768. Unsupported part was commented. Please check it.
    //             /*CurrPage.WhseReceiptLines.PAGE.*/
    //             _ShowCommentLines(1);
    //             // >>DITW15.00.00.36 DDR

    //         end;
    //     }
    //     action("Quality Tests")
    //     {
    //         CaptionML = ENU = 'Quality Tests',
    //                     FRA = 'Tests qualité';

    //         trigger OnAction();
    //         begin
    //             //<<QXL9.00.001 DAT 23/03/2016
    //             //This functionality was copied from page #5768. Unsupported part was commented. Please check it.
    //             /*CurrPage.WhseReceiptLines.PAGE.*/
    //             _ShowQualityTests();
    //             //>>QXL9.00.001 DAT 23/03/2016

    //         end;
    //     }
    // }
    // BC Upgrade SHUKLP03 << DrinkIT actions are blocked.




    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=Cross-docking has been disabled for item %1 or location %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=Cross-docking has been disabled for item %1 or location %2.;FRA=Le transbordement a été désactivé pour l'article %1 et/ou le magasin %2.;
    //Variable type has not been exported.

    var
        PurchHeader: Record "Purchase Header";
        SalesHeader: Record "Sales Header";
        //QualitySetup: Record "Quality Setup";  // BC Upgrade SHUKLP03 DrinkIT variable are blocked
        TransferLine: Record "Transfer Line";
        HeinekenGlobal: Codeunit "Heineken Global";
        //QualityManagement: Codeunit "Quality Management";  // BC Upgrade SHUKLP03 DrinkIT variable are blocked
        HasSourceCommentHeader: Boolean;
        HasSourceCommentLine: Boolean;

        LotNocolor: Boolean;

        "Qty. to Cross-DockEditable": Boolean;

        "Qty. to Receive (Base)Editable": Boolean;

        "Qty. to ReceiveEditable": Boolean;

        QtytoCrossDockBaseEditable: Boolean;
        VisibleSaleReturnOrder: Boolean;
        LotNo: Code[20];
        ShortcutQtyUomValue: array[3] of Decimal;
        SourceTotalVolume: Decimal;
        SourceTotalWeight: Decimal;
        Direction: Option Outbound,Inbound;

        LotNoText: Text[1024];
        Text2014260: TextConst ENU = 'There are no valid lines to use this function.', FRA = 'Il n''a pas de lignes valide pour utiliser cette fonction';

    trigger OnDeleteRecord(): Boolean
    var
        myInt: Integer;

    begin
        //HEI.04>>
        IF SalesHeader2.GET(SalesHeader2."Document Type"::"Return Order", rec."Source No.") THEN
            IF SourceSystemIdentifierAPI.GET(SalesHeader2."Source System Identifier FND") THEN
                IF SourceSystemIdentifierAPI."Automatic SO Posting" THEN
                    ERROR(CantDeleteErr, SalesHeader."Source System Identifier FND");
        //HEI.04<<
    end;

    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //begin
    /*
    /// DITW16.00.00.40 DDR 02/01/2012 DIT-715 #185 - DITW114.00.15 DDR 24/04/2020 NRQ#102424
    //<<DITW110.00.11 MSF 04/10/2017 NRQ#39012
    VisibleSaleReturnOrder := "Source Document"="Source Document"::"Sales Return Order";
    //>>DITW110.00.11 MSF 04/10/2017 NRQ#39012
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //begin
    /*
    // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
    ShowShortcutUomValue(ShortcutQtyUomValue);
    // >>DITW16.00.00.40 DDR DIT-715 #244
    //<<QXL9.00.001 DAT 23/03/2016
    if QualitySetup.READPERMISSION and ("Item No." <> '') then begin
      case "Source Type" of
        DATABASE::"Purchase Line":
          begin
            LotNo :=
              QualityManagement.GetWhseLotNo(
                DATABASE::"Purchase Line","Source Subtype","Source No.",'',0,"Source Line No.","Item No.",Quantity >= 0);
          end;
        DATABASE::"Sales Line":
          begin
            LotNo :=
              QualityManagement.GetWhseLotNo(
                DATABASE::"Sales Line","Source Subtype","Source No.",'',0,"Source Line No.","Item No.",Quantity >= 0);
          end;
        DATABASE::"Transfer Line":
          begin
            Direction := Direction::Inbound;
            if TransferLine.GET("Source No.","Source Line No.") then
              LotNo :=
                QualityManagement.GetWhseLotNo(DATABASE::"Transfer Line",
                  Direction,"Source No.",'',TransferLine."Derived From Line No.","Source Line No.","Item No.",Quantity >= 0);
          end
      end;
    end else
      LotNo := '';
    // <<DITW15.00.00.36 DDR 06/11/2009
    HasSourceCommentHeader := HasComments(0);
    HasSourceCommentLine := HasComments(1);
    CalcSourceTotalWV();
    // >>DITW15.00.00.36 DDR
    LotNoText := FORMAT(LotNo);
    LotNoTextOnFormat(LotNoText);
    //>>QXL9.00.001 DAT 23/03/2016
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnDeleteRecord". Please convert manually.

    //trigger OnDeleteRecord() : Boolean;
    var
        SalesHeader2: Record "Sales Header";
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        CantDeleteErr: Label 'You can not delete a Receipt Line for a Return Order sent by %1.';
    //begin
    /*
    //HEI.04>>
    if SalesHeader2.GET(SalesHeader2."Document Type"::"Return Order","Source No.") then
      if SourceSystemIdentifierAPI.GET(SalesHeader2."Source System Identifier") then
        if SourceSystemIdentifierAPI."Automatic SO Posting" then
          ERROR(CantDeleteErr,SalesHeader."Source System Identifier");
    //HEI.04<<
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    QtytoCrossDockBaseEditable := true;
    "Qty. to Cross-DockEditable" := true;
    "Qty. to Receive (Base)Editable" := true;
    "Qty. to ReceiveEditable" := true;
    //<<DITW110.00.11 MSF 04/10/2017 NRQ#39012
    VisibleSaleReturnOrder := false;
    //>>DITW110.00.11 MSF 04/10/2017 NRQ#39012
    */
    //end;


    //Unsupported feature: CodeModification on "QtytoReceiveOnAfterValidate(PROCEDURE 19059245)". Please convert manually.

    //procedure QtytoReceiveOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.SAVERECORD;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.SAVERECORD;
    // <<DITW16.00.00.40 DDR 02/01/2012 DIT-715 #185
    CurrPage.UPDATE(false);
    // >>DITW16.00.00.40 DDR DIT-715 #185
    */
    //end;

    // BC Upgrade SHUKLP03 << DrinkIT Procedures are blocked.
    // procedure PutWhseReciptLines();
    // var
    //     lrWhseRcptLine: Record "Warehouse Receipt Line";
    //     lcduWhseTranspMgt: Codeunit "Warehouse & Transport Mgt.";
    // begin
    //     // <<DITW15.00.00.21 DDR 19/06/2008
    //     CurrPage.SAVERECORD;
    //     COMMIT;

    //     with lrWhseRcptLine do begin
    //         COPY(Rec);
    //         MARKEDONLY(true);
    //         if ISEMPTY then begin
    //             CLEAR(lrWhseRcptLine);
    //             CurrPage.SETSELECTIONFILTER(lrWhseRcptLine);
    //             SETRANGE("No.", Rec."No.");
    //         end;
    //     end;
    //     // <<DITW16.00.00.40 DDR 17/02/2012 DIT-715 #246
    //     lcduWhseTranspMgt.PutWhseReceiptLines(lrWhseRcptLine);
    //     RESET;
    //     SETCURRENTKEY("No.", "Sorting Sequence No.");
    //     CurrPage.UPDATE(false);
    // end;

    // procedure _ShowCommentLines(FromType: Option Header,Line);
    // begin
    //     // <<DITW15.00.00.36 DDR 06/11/2009
    //     Rec.ShowCommentLines(FromType);
    // end;

    // procedure ShowCommentLines(FromType: Option Header,Line);
    // begin
    //     // <<DITW15.00.00.36 DDR 06/11/2009
    //     Rec.ShowCommentLines(FromType);
    // end;

    // procedure HasComments(FromType: Option Header,Line): Boolean;
    // begin
    //     // <<DITW15.00.00.36 DDR 06/11/2009
    //     exit(not Rec.HasComments(FromType));
    // end;

    // local procedure CalcSourceTotalWV();
    // begin
    //     // <<DITW15.00.00.36 DDR 06/11/2009
    //     case "Source Type" of
    //         "Source Type"::"37":
    //             begin
    //                 if (SalesHeader."Document Type" <> "Source Subtype") or
    //                   (SalesHeader."No." <> "Source No.")
    //                 then
    //                     SalesHeader.GET("Source Subtype", "Source No.");
    //                 SalesHeader.CALCFIELDS("Total Weight", "Total Cubage");
    //                 SourceTotalWeight := SalesHeader."Total Weight";
    //                 SourceTotalVolume := SalesHeader."Total Cubage";
    //             end;
    //         "Source Type"::"39":
    //             begin
    //                 if (PurchHeader."Document Type" <> "Source Subtype") or
    //                   (PurchHeader."No." <> "Source No.")
    //                 then
    //                     PurchHeader.GET("Source Subtype", "Source No.");
    //                 PurchHeader.CALCFIELDS("Total Weight", "Total Cubage");
    //                 SourceTotalWeight := PurchHeader."Total Weight";
    //                 SourceTotalVolume := PurchHeader."Total Cubage";
    //             end;
    //     end;
    // end;

    // procedure _ShowQualityTests();
    // var
    //     QualityTestHeader: Record "Quality Test Header";
    // begin
    //     // <<DITW15.00.00.38 PRODW14.00.00.17 DDR 10/02/2011 #1273
    //     QualityTestHeader.SETCURRENTKEY(
    //       "Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
    //     QualityTestHeader.FILTERGROUP(2);
    //     QualityTestHeader.SETRANGE("Source ID", "Source No.");
    //     QualityTestHeader.SETRANGE("Source Type", "Source Type");
    //     QualityTestHeader.SETRANGE("Source Subtype", "Source Subtype");
    //     QualityTestHeader.SETRANGE("Source Ref. No.", "Source Line No.");
    //     QualityTestHeader.FILTERGROUP(0);
    //     QualityTestHeader.SETRANGE("Item No.", "Item No.");
    //     PAGE.RUNMODAL(0, QualityTestHeader);
    // end;

    // procedure ShowQualityTests();
    // var
    //     QualityTestHeader: Record "Quality Test Header";
    // begin
    //     //<<QXL9.00.001 DAT 23/03/2016
    //     QualityTestHeader.SETCURRENTKEY(
    //       "Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
    //     QualityTestHeader.FILTERGROUP(2);
    //     QualityTestHeader.SETRANGE("Source ID", "Source No.");
    //     QualityTestHeader.SETRANGE("Source Type", "Source Type");
    //     QualityTestHeader.SETRANGE("Source Subtype", "Source Subtype");
    //     QualityTestHeader.SETRANGE("Source Ref. No.", "Source Line No.");
    //     QualityTestHeader.FILTERGROUP(0);
    //     QualityTestHeader.SETRANGE("Item No.", "Item No.");
    //     PAGE.RUNMODAL(0, QualityTestHeader);
    //     //>>QXL9.00.001 DAT 23/03/2016
    // end;

    // procedure _ShowGetARCNoEDI();
    // var
    //     SelectedWhseRcptLines: Record "Warehouse Receipt Line";
    //     NewARCNo: Code[30];
    //     NewText: Text[1024];
    // begin
    //     // <<DITW15.00.00.39 DDR 12/04/2011 DIT-712 #1296
    //     CLEAR(SelectedWhseRcptLines);
    //     CurrPage.SETSELECTIONFILTER(SelectedWhseRcptLines);
    //     SelectedWhseRcptLines.SETFILTER("No.", '<>%1', '');
    //     SelectedWhseRcptLines.SETRANGE("ARC No. Mandatory", true);
    //     if SelectedWhseRcptLines.findset then begin
    //         repeat
    //             SelectedWhseRcptLines.TESTFIELD("ARC No.", '');
    //         until SelectedWhseRcptLines.NEXT = 0;
    //     end else
    //         ERROR(Text2014260);

    //     if SelectedWhseRcptLines.EDILookupExtTrackingARC(NewText) then begin
    //         NewARCNo := NewText;
    //         if SelectedWhseRcptLines.findset(true) then
    //             repeat
    //                 SelectedWhseRcptLines.VALIDATE("ARC No.", NewARCNo);
    //                 SelectedWhseRcptLines.MODIFY(true);
    //             until SelectedWhseRcptLines.NEXT = 0;
    //         Rec := SelectedWhseRcptLines;
    //         CurrPage.UPDATE(false);
    //     end;
    // end;

    // procedure ShowGetARCNoEDI();
    // var
    //     SelectedWhseRcptLines: Record "Warehouse Receipt Line";
    //     NewARCNo: Code[30];
    //     NewText: Text[1024];
    // begin
    //     // <<DITW15.00.00.39 DDR 12/04/2011 DIT-712 #1296
    //     CLEAR(SelectedWhseRcptLines);
    //     CurrPage.SETSELECTIONFILTER(SelectedWhseRcptLines);
    //     SelectedWhseRcptLines.SETFILTER("No.", '<>%1', '');
    //     SelectedWhseRcptLines.SETRANGE("ARC No. Mandatory", true);
    //     if SelectedWhseRcptLines.findset then begin
    //         repeat
    //             SelectedWhseRcptLines.TESTFIELD("ARC No.", '');
    //         until SelectedWhseRcptLines.NEXT = 0;
    //     end else
    //         ERROR(Text2014260);

    //     if SelectedWhseRcptLines.EDILookupExtTrackingARC(NewText) then begin
    //         NewARCNo := NewText;
    //         if SelectedWhseRcptLines.findset(true) then
    //             repeat
    //                 SelectedWhseRcptLines.VALIDATE("ARC No.", NewARCNo);
    //                 SelectedWhseRcptLines.MODIFY(true);
    //             until SelectedWhseRcptLines.NEXT = 0;
    //         Rec := SelectedWhseRcptLines;
    //         CurrPage.UPDATE(false);
    //     end;
    // end;

    // procedure _OpenSSCCTrackingLines();
    // begin
    //     // <<DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745
    //     Rec.OpenSSCCTrackingLines;
    // end;

    // procedure OpenSSCCTrackingLines();
    // begin
    //     // <<DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745
    //     Rec.OpenSSCCTrackingLines;
    // end;

    // local procedure QtytoReceiveBaseOnAfterValidat();
    // begin
    //     // <<DITW16.00.00.40 DDR 02/01/2012 DIT-715 #185
    //     CurrPage.UPDATE(true);
    //     // >>DITW16.00.00.40 DDR DIT-715 #185
    // end;

    // local procedure HasSourceCommentHeaderOnPush();
    // begin
    //     // <<DITW15.00.00.36 DDR 06/11/2009
    //     ShowCommentLines(0);
    //     // >>DITW15.00.00.36 DDR
    // end;

    // local procedure HasSourceCommentLineOnPush();
    // begin
    //     // <<DITW15.00.00.36 DDR 06/11/2009
    //     ShowCommentLines(1);
    //     // >>DITW15.00.00.36 DDR
    // end;

    // local procedure LotNoTextOnFormat(var Text: Text[1024]);
    // begin
    //     //<<QXL9.00.001 DAT 23/03/2016
    //     if QualitySetup.READPERMISSION then begin
    //         LotNocolor := QualityManagement.IsRequired(Text);
    //     end;
    //     //>>QXL9.00.001 DAT 23/03/2016
    // end;

    // procedure _AllItemsAvailability(AvailabilityType: Option Date2,Date3);
    // begin
    //     //<< DITW18.00.07 VSC 19/02/2016 DIT-770 #1703
    //     Rec.AllItemsAvailability(AvailabilityType);
    // end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    // BC Upgrade SHUKLP03 << DrinkIT Procedures are blocked.


}

