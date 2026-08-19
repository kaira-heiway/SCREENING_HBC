pageextension 51160 PurchaseQuoteExtCBN extends "Purchase Quote"
{
    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    // DITW15.00.00.01 DDR 17/01/2008 some Captions
    //                                New calling functions to insert (item) charges
    // DITW15.00.00.01 DDR 21/01/2008 Remove unused textconst
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.24 DDR 07/10/2008 Added field2013722 Duty Tax Type into "Drink-It" tab
    // DITW15.00.00.25 DDR 21/10/2008 Deleted field2013722 Duty Tax Type
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW15.00.00.38 DDR 14/12/2010 issue 1245 Resize width form (fix import text merge?)
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #61 RTC Upgrade & Performances
    //                                           Added parameter line function RTCActionNewLine() into RTCNewLine button
    // DITW15.00.00.39 DDR 27/04/2011 issue 1323 NAVBE5.00 (SP1) functionnality to insert Customer Std. Sales Codes automatically
    //                                Added to call function StdVendPurchCode.AutoInsertPurchLines()
    //                                  from OnAfterValidate trigger field "Sell-to Customer No."
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade
    //                                              Added to insert first line automatically
    //                     19/08/2011 issue 1363 Added fields "Tax Date" into 'General' tab

    // FINXL7.00.001 KLU 25/09/2013 : Added actions for approve/reject (same functionality as approval entries form)

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0012.1
    //                             added requester id
    // DITW17.00.02 SR 12/09/2013 DIT-770 #153 : New Field "Linked Customer No." Added in General Tab
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added fields "Physical Location Group Code"
    // DITW18.00.06 DDR 25/02/2015 DIT-770 #1191 Multisite - Modified Resp. Center Filter OnOpenPage trigger
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 look & feel design/functional issues: part 1: ribbons
    // DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time","Created By" Importance Additional
    // DITW18.00.07 VSC 01/07/2016 DIT-770 #1282 Set fields to visible "Creation Date/Time","Created By"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4

    // HEI.01 HLSRM02 IBM LAZARE02 26.09.2017 # New tab SRM
    // HEI.02 FDD-PURGAP027 - Maximo POs approval flow, IBM.POENAB02 , 28.02.2019
    //   # New field added in "General" group - 50002 Payment User. Set EDITABLE property for this field to FALSE.
    // HEI.03 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # Removed Field "Payment User"
    //   # Added Field “PQ Approver”
    //   # Created new Page Action "Purchase Additional"
    // HEI.04 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # New Field added: "Fixed Asset Acquisition"
    // HEI.06 CHG2046174 IBM Shankj03
    //   # Field added "Lead Time Calculation.
    // HEI.07 FDD HT1136 CHG2055070 IBM Shankj03 16.06.2020
    //  # New Field Added License Code
    //  # Code added in triggers
    // HEI.08 FDD-HB1341 CHG2065548 IBM SHANKJ03  10.08.2020
    //  #Code Added in Archieve & Delete Action button
    // HEI.10 HT1136 CHG2084917 IBM.GUNERE01 11.03.2020 # Added Code in License Code Onvalidate trigger
    // HEI.11 CHG2088708 IBM PANDES01 23-12-2020
    //  # Added Action Purchase quote Approval.
    // HEI.12 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New field added in General tab: LSR Order No
    //   # code added in OnAfterGetRecord()
    // Hei.13  CHG2096764 IBM. PANDES01  12.03.2021
    //  # Added code for Requesters ID.
    // HEI.14 CHG2105495- Defect - 6206 IBM NANDIS01 07.04.2021 - Haiti fix for defect 6206 Location error when approving PO/PQ
    //   # Defect raised from Haiti opco - location code should be mandatory while sending the doc to approver
    // HEI.15 FDD-HB1195 CHG2070051 IBM GUNERE01 04.02.2021 # Import Identifier field added
    // HEI.16 CHG2123487 IBM BHATTA  20.10.2021
    //   # Code added for CMG Dimension mandatory for Shipping Cost type Item Charges
    //---------------------------------------------------------------------------------------------
    //BC Upgrade SHARMP16 end<<-----------Interface related fields shifted to Interface Ext


    // BC Upgrade SHUKLP03 >>
    // Added in the interface ext "LSR Order No.".
    // Made base action(MakeOrder) visible false and created custom action(MakeOrderCustom).
    // On custom action(MakeOrderCustom) added whole code of codeunit "Purch.-Quote to Order (Yes/No)" because event and REC variable of event was not found on that to add code and also created events OnAfterCreatePurchOrder and OnBeforePurchQuoteToOrder.
    // BC Upgrade SHUKLP03 <<
    //BC Upgrade SHARMP16-- page formatting changes
    //BC UPGRADE ATHUKS01 FDD_STP_005_GAP22<< 
    //1.To display fields on the page level Requestor IBM, Created By and creation date time .
    //BC UPGRADE ATHUKS01 FDD_STP_005_GAP22>>
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Buy-from Vendor Name")
        {
            CaptionML = ENU = 'Vendor', FRA = 'Fournisseur';
        }
        modify("Buy-from")
        {
            CaptionML = ENU = 'Buy-from', FRA = 'Fournisseur';
        }
        modify("Buy-from Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
        }
        modify("Buy-from Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';

            //Unsupported feature: Change ImplicitType on ""Buy-from Address 2"(Control 74)". Please convert manually.

        }
        modify("Buy-from Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
        }
        modify("Buy-from City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';

            //Unsupported feature: Change ImplicitType on ""Buy-from City"(Control 76)". Please convert manually.

        }
        modify("Buy-from Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
        }
        modify("Buy-from Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
        }
        modify("Invoice Details")
        {
            CaptionML = ENU = 'Invoice Details', FRA = 'Détails facture';
        }
        modify("Shipping and Payment")
        {
            CaptionML = ENU = 'Shipping and Payment', FRA = 'Expédition et paiement';
        }
        // modify("Ship-to")
        // {
        //     CaptionML = ENU = 'Ship-to', FRA = 'Destinataire';
        // }//BC Upgrade SHARMP16 field not found in table.
        modify("Order Address Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify("Ship-to Name")
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Ship-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';

            //Unsupported feature: Change ImplicitType on ""Ship-to Address"(Control 42)". Please convert manually.

        }
        modify("Ship-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';

            //Unsupported feature: Change ImplicitType on ""Ship-to Address 2"(Control 44)". Please convert manually.

        }
        modify("Ship-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
        }
        modify("Ship-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';

            //Unsupported feature: Change ImplicitType on ""Ship-to City"(Control 46)". Please convert manually.

        }
        modify("Ship-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
        }
        // modify("Pay-to")
        // {
        //     CaptionML = ENU = 'Pay-to', FRA = 'Paiement';
        // }//BC Upgrade SHARMP16 field not found in table.
        modify("Pay-to Name")
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Pay-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';

            //Unsupported feature: Change ImplicitType on ""Pay-to Address"(Control 24)". Please convert manually.

        }
        modify("Pay-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';

            //Unsupported feature: Change ImplicitType on ""Pay-to Address 2"(Control 26)". Please convert manually.

        }
        modify("Pay-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
        }
        modify("Pay-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';

            //Unsupported feature: Change ImplicitType on ""Pay-to City"(Control 28)". Please convert manually.

        }
        modify("Pay-to Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
        }
        modify("Pay-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
        }
        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade', FRA = 'International';
        }

        //Unsupported feature: CodeModification on ""Buy-from Vendor Name"(Control 6).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
          if "Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
            SETRANGE("Buy-from Vendor No.");

        CurrPage.UPDATE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5

         // <<DITW15.00.00.39 DDR 27/04/2011 #1323 (BE5.00.01)
         COMMIT;
         StdVendPurchCode.AutoInsertPurchLines(Rec);
         // >>DITW15.00.00.39 DDR #1323 (BE5.00.01)
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Document Date"(Control 19)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW17.00.01 DDR 21/03/2013 DIT-770 #001
        CurrPage.UPDATE(true);
        // >>DITW17.00.01 DDR DIT-770 #001
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Order Date"(Control 12)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW17.00.01 DDR 21/03/2013 DIT-770 #001
        CurrPage.UPDATE(true);
        // >>DITW17.00.01 DDR DIT-770 #001
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Requested Receipt Date"(Control 110)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW17.00.01 DDR 21/03/2013 DIT-770 #001
        CurrPage.UPDATE(true);
        // >>DITW17.00.01 DDR DIT-770 #001
        */
        //end;
        addafter("Payment Discount %")
        {
            field("Location Code_Gen"; Rec."Location Code")
            {
                Caption = 'Location Code';
                ApplicationArea = all;
            }
        }//BC Upgrade SHARMP16 -- Purchase Page formatting changes.
        addafter("Document Date")
        {
            // field("Tax Date"; Rec."Tax Date")
            // {

            //     trigger OnValidate();
            //     begin
            //         // <<DITW17.00.01 DDR 21/03/2013 DIT-770 #001
            //         CurrPage.UPDATE(true);
            //         // >>DITW17.00.01 DDR DIT-770 #001
            //     end;
            // }//BC Upgrade SHARMP16 Drink-IT field.
        }
        addafter("Assigned User ID")
        {
            // field("Requester ID"; Rec."Requester ID")
            // {
            //     Description = 'DITW17.00.02 DIT-770 #144';
            // }//BC Upgrade SHARMP16 Drink-IT field.
            //BC UPGRADE ATHUKS01 FDD_STP_005_GAP22>>  
            field("Requestor ID IBM"; Rec."Requester ID IBM FND")
            {
                ApplicationArea = all;
            }
            field("PQ Approver"; Rec."PQ Approver FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the PQ Approver field.';
            }
            //BC UPGRADE ATHUKS01 FDD_STP_005_GAP22<< 
        }
        addafter(Status)
        {
            // field("Creation Date/Time"; Rec."Creation Date/Time")
            // {
            //     Description = 'DITW18.00.07 DIT-770 #1282';
            //     Importance = Additional;
            // }
            // field("Created By"; Rec."Created By")
            // {
            //     Description = 'DITW18.00.07 DIT-770 #1282';
            //     Importance = Additional;
            // }//BC Upgrade SHARMP16 Drink-IT field.
            // field("Linked Customer No."; Rec."Linked Customer No.")
            // {
            // }//BC Upgrade SHARMP16 Drink-IT field.
            //BC UPGRADE ATHUKS01 FDD_STP_005_GAP22<< 
            field("Creation Date/Time IBM"; Rec."Creation Date/Time IBM FND")
            {
                ApplicationArea = all;
                Importance = Additional;

            }
            field("Created By IBM"; Rec."Created By IBM FND")
            {
                ApplicationArea = all;
                Importance = Additional;
            }
            //BC UPGRADE ATHUKS01 FDD_STP_005_GAP22>>

            field("Fixed Asset Acquisition"; Rec."Fixed Asset Acquisition FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Fixed Asset Acquisition field.';
            }
            field(LicenseCode; PurchaseHeaderAdditional."License Code")
            {
                ApplicationArea = Basic, Suite;

                CaptionML = ENU = 'License Code',
                            FRA = 'License Code';
                ToolTip = 'Specifies the value of the License Code field.';

                trigger OnDrillDown();
                begin
                    // HEI.07 >>
                    OldDimSetId := 0;
                    NewDImSetId := 0;
                    OldDimSetId := Rec."Dimension Set ID";
                    if Rec.Status <> Rec.Status::Released then begin
                        GenLedSetRec.RESET();
                        GenLedSetRec.GET();
                        if GenLedSetRec."License Dimension Code FND" = '' then
                            ERROR(Text000);
                        DimValRec.RESET();
                        DimValRec.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                        CLEAR(DimValPage);
                        DimValPage.SETRECORD(DimValRec);
                        DimValPage.SETTABLEVIEW(DimValRec);
                        DimValPage.LOOKUPMODE(true);
                        if DimValPage.RUNMODAL() = ACTION::LookupOK then begin
                            DimValPage.GETRECORD(DimValRec);
                            LicenseCode := DimValRec.Code;
                            PurchaseHeaderAdditional.RESET();
                            if PurchaseHeaderAdditional.GET(Rec."Document Type", Rec."No.") then begin
                                PurchaseHeaderAdditional."License Code" := DimValRec.Code;
                                PurchaseHeaderAdditional.MODIFY();
                            end;

                            DimValRec.GET(GenLedSetRec."License Dimension Code FND", LicenseCode);
                            DimMgt.GetDimensionSet(TempDimSetEntry, Rec."Dimension Set ID");
                            TempDimSetEntry.INIT();
                            TempDimSetEntry.VALIDATE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                            TempDimSetEntry.VALIDATE("Dimension Value Code", LicenseCode);
                            TempDimSetEntry."Dimension Value ID" := DimValRec."Dimension Value ID";
                            if not TempDimSetEntry.INSERT() then
                                TempDimSetEntry.MODIFY();

                            Rec."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);

                            Rec.MODIFY();
                            //VALIDATE("License Code", DimValRec.Code);
                            NewDImSetId := Rec."Dimension Set ID";
                            //VALIDATE("License Code", DimValRec.Code);
                            //Updating All Lines
                            PurchLineRec.RESET();
                            PurchLineRec.SETRANGE("Document Type", Rec."Document Type");
                            PurchLineRec.SETRANGE("Document No.", Rec."No.");
                            if PurchLineRec.FINDFIRST() then begin
                                if not GUIALLOWED then
                                    Rec.SetHideValidationDialog(true);
                                COMMIT();
                                UpdateAllLineDimNew(NewDImSetId, OldDimSetId);
                            end;
                        end;
                        CurrPage.UPDATE();
                    end else
                        ERROR(Text002);
                    // HEI.07 <<
                end;

                trigger OnValidate();
                var
                    locTempDimensionSetEntry: Record "Dimension Set Entry" temporary;
                    locPurchaseHeaderAdditional: Record "Purchase Header Additional FND";
                    locPurchaseLine: Record "Purchase Line";
                begin
                    //HEI.10 >>
                    if rec."License Code FND" = '' then begin
                        GenLedSetRec.RESET();
                        GenLedSetRec.GET();
                        //IF GenLedSetRec."License Dimension Code" = '' THEN BEGIN //HEI.10
                        //header
                        //>>HEI.10
                        locTempDimensionSetEntry.RESET();
                        DimSetEntryRec_2.RESET();
                        DimSetEntryRec_2.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
                        if DimSetEntryRec_2.findset() then begin
                            repeat
                                locTempDimensionSetEntry.INIT();
                                locTempDimensionSetEntry := DimSetEntryRec_2;
                                locTempDimensionSetEntry.INSERT();
                            until DimSetEntryRec_2.NEXT() = 0;
                        end;
                        locTempDimensionSetEntry.RESET();
                        locTempDimensionSetEntry.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                        if locTempDimensionSetEntry.FINDFIRST() then
                            locTempDimensionSetEntry.DELETE(true);

                        Rec."Dimension Set ID" := DimMgt.GetDimensionSetID(locTempDimensionSetEntry);
                        Rec.MODIFY();
                        locTempDimensionSetEntry.DELETEALL();

                        //lines
                        locPurchaseLine.SETRANGE("Document Type", Rec."Document Type");
                        locPurchaseLine.SETRANGE("Document No.", Rec."No.");
                        locPurchaseLine.findset();
                        repeat
                            locTempDimensionSetEntry.RESET();
                            DimSetEntryRec_2.RESET();
                            DimSetEntryRec_2.SETRANGE("Dimension Set ID", locPurchaseLine."Dimension Set ID");
                            if DimSetEntryRec_2.findset() then begin
                                repeat
                                    locTempDimensionSetEntry.INIT();
                                    locTempDimensionSetEntry := DimSetEntryRec_2;
                                    locTempDimensionSetEntry.INSERT();
                                until DimSetEntryRec_2.NEXT() = 0;
                            end;
                            locTempDimensionSetEntry.RESET();
                            locTempDimensionSetEntry.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                            if locTempDimensionSetEntry.FINDFIRST() then
                                locTempDimensionSetEntry.DELETE(true);

                            locPurchaseLine."Dimension Set ID" := DimMgt.GetDimensionSetID(locTempDimensionSetEntry);
                            locPurchaseLine.MODIFY();
                            locTempDimensionSetEntry.DELETEALL();
                        until locPurchaseLine.NEXT() = 0;


                        //   DimSetEntryRec_2.RESET;
                        //   DimSetEntryRec_2.SETRANGE("Dimension Code",GenLedSetRec."License Dimension Code");
                        //   IF DimSetEntryRec_2.FINDFIRST THEN BEGIN
                        //     DimSetEntryRec_2.DELETE;
                        //     Rec."Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntryRec_2);
                        //     Rec.MODIFY;
                        //   end;

                        if locPurchaseHeaderAdditional.GET(Rec."Document Type", Rec."No.") then begin
                            locPurchaseHeaderAdditional."License Code" := '';
                            locPurchaseHeaderAdditional.MODIFY();
                        end;
                        //<<HEI.10
                        //end;
                    end;
                    //HEI.10 <<
                    GenLedSetRec.RESET();
                    GenLedSetRec.GET();
                    if GenLedSetRec."License Dimension Code FND" = '' then
                        ERROR(Text000);
                    //>> HEI.10
                    // DimValRec.RESET;
                    // DimValRec.SETRANGE("Dimension Code",GenLedSetRec."License Dimension Code");
                    // DimValRec.SETRANGE(Code,LicenseCode);
                    // IF NOT DimValRec.FINDFIRST THEN
                    //  ERROR(Text001);
                    //<< HEI.10
                    //Hei.10 <<
                end;
            }
            // BC Upgrade SHUKLP03 >> Added in interface ext.
            // field("LSR Order No."; PurchaseHeaderAdditional."LSR Order No")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Editable = false;
            // }
            // BC Upgrade SHUKLP03 << Added in interface ext.
        }
        addafter("Expected Receipt Date")
        {
            field("Lead Time Calculation"; Rec."Lead Time Calculation")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies a date formula for the amount of time it takes to replenish the item.';
            }
        }
        // addafter("Ship-to")
        // {
        //     field("Physical Location Group Code"; Rec."Physical Location Group Code")
        //     {
        //         Importance = Additional;
        //         QuickEntry = false;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
        //             if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
        //                 CurrPage.UPDATE(true);
        //             // >>DITW18.00.06 DDR DIT-770 #1191
        //         end;
        //     }
        // }//BC Upgrade Sharmp16 Drink-IT fields and code.

        //BC Upgrade SHARMP16 BEGIN>>-----------Interface related fields
        // addafter("Foreign Trade")
        // {
        //     group(Maximo)
        //     {
        //         Caption = 'Maximo';
        //         field("Maximo Requisition No."; Rec."Maximo Requisition No.")
        //         {
        //             ApplicationArea = Basic, Suite;
        //         }
        //         field("Import Identifier"; PurchaseHeaderAdditional."Import Identifier")
        //         {
        //             Caption = 'Import Identifier';
        //             Editable = false;
        //             ApplicationArea = Basic, Suite;
        //         }
        //     }
        //     group(SRM)
        //     {
        //         Caption = 'SRM';
        //         field("SRM Contract No."; Rec."SRM Contract No.")
        //         {
        //             ApplicationArea = Basic, Suite;
        //         }
        //         field("SRM Contract Name"; Rec."SRM Contract Name")
        //         {
        //             ApplicationArea = Basic, Suite;
        //         }
        //         field("SRM Contract Type"; Rec."SRM Contract Type")
        //         {
        //             ApplicationArea = Basic, Suite;
        //         }
        //         field("Shipment Method Location"; Rec."Shipment Method Location")
        //         {
        //             ApplicationArea = Basic, Suite;
        //         }
        //         field("Valid From"; Rec."Valid From")
        //         {
        //             ApplicationArea = Basic, Suite;
        //         }
        //         field("Valid To"; Rec."Valid To")
        //         {
        //             ApplicationArea = Basic, Suite;
        //         }
        //         field(Channel; Rec.Channel)
        //         {
        //             ApplicationArea = Basic, Suite;
        //         }
        //         field("Target Value Amount"; Rec."Target Value Amount")
        //         {
        //             ApplicationArea = Basic, Suite;
        //         }
        //         field(Closed; Rec.Closed)
        //         {
        //             ApplicationArea = Basic, Suite;
        //         }
        //     }
        // }
        //BC Upgrade SHARMP16 end<<-----------Interface related fields
        addafter(Control1901138007)
        {
            // part(Control1907232107; "Purchase Line FactBox2")
            // {
            //     Provider = "58";
            //     SubPageLink = "Document Type" = FIELD("Document Type"),
            //                   "Document No." = FIELD("Document No."),
            //                   "Line No." = FIELD("Line No.");
            //     Visible = true;
            // }//BC Upgrade SHARMP16 Drink-IT
        }
    }
    actions
    {
        modify("&Quote")
        {
            CaptionML = ENU = '&Quote', FRA = '&Dem. prix';
        }

        modify(Vendor)
        {
            CaptionML = ENU = 'Vendor', FRA = 'Fournisseur';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(Approvals)
        {
            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
        }
        modify(Approval)
        {
            CaptionML = ENU = 'Approval', FRA = 'Approbation';
        }
        modify(Approve)
        {
            CaptionML = ENU = 'Approve', FRA = 'Approuver';
        }
        modify(Reject)
        {
            CaptionML = ENU = 'Reject', FRA = 'Rejeter';
        }
        modify(Delegate)
        {
            CaptionML = ENU = 'Delegate', FRA = 'Déléguer';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comments', FRA = 'Commentaires';
        }
        modify(Print)
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
        }

        modify(Release)
        {
            CaptionML = ENU = 'Re&lease', FRA = '&Lancer';
            //BC UPgrade SHARMP16 BEGIN>>
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                //HEI.16>>
                CheckCMGMandatory();
                //HEI.16<<
                //>>Hei.13
                PurchasesPSetup.GET();
                IF PurchasesPSetup."Requester ID Mandatory FND" THEN;
                //  Rec.TESTFIELD("Requester ID");//BC Upgrade SHARMP16--Drink-It field used
                //<<Hei.13
                //HEI.07 >>
                GenLedSetRec.RESET();
                GenLedSetRec.GET();
                IF GenLedSetRec."License Dimension Code FND" <> '' THEN BEGIN
                    CLEAR(LicenseCodeValue);

                    PurchHdrRec.RESET();
                    PurchHdrRec.SETRANGE("Document Type", Rec."Document Type");
                    PurchHdrRec.SETRANGE("No.", Rec."No.");
                    IF PurchHdrRec.FINDFIRST() THEN BEGIN
                        DimSetEntryRec.RESET();
                        DimSetEntryRec.SETRANGE("Dimension Set ID", PurchHdrRec."Dimension Set ID");
                        DimSetEntryRec.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                        IF DimSetEntryRec.FINDFIRST() THEN
                            LicenseCodeValue := DimSetEntryRec."Dimension Value Code"
                    end;

                    CLEAR(LicenseCodeValue_1);
                    PurchLineRec.RESET();
                    PurchLineRec.SETRANGE("Document Type", Rec."Document Type");
                    PurchLineRec.SETRANGE("Document No.", Rec."No.");
                    IF PurchLineRec.FINDFIRST() THEN BEGIN
                        REPEAT
                            DimSetEntryRec_1.RESET();
                            DimSetEntryRec_1.SETRANGE("Dimension Set ID", PurchLineRec."Dimension Set ID");
                            DimSetEntryRec_1.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                            IF DimSetEntryRec_1.FINDFIRST() THEN
                                LicenseCodeValue_1 := DimSetEntryRec_1."Dimension Value Code";

                            IF LicenseCodeValue_1 <> '' THEN BEGIN
                                IF LicenseCodeValue <> LicenseCodeValue_1 THEN
                                    ERROR(Text005);
                            end;
                        UNTIL PurchLineRec.NEXT() = 0;
                    end;
                end;
                //HEI.07 <<

            end;
            //BC Upgrade SHARMP16 end<<
        }
        modify(Reopen)
        {
            CaptionML = ENU = 'Re&open', FRA = 'R&ouvrir';
            ToolTipML = ENU = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed', FRA = 'Rouvrez le document pour le modifier après son approbation. Les documents approuvés ont le statut Lancé et doivent être ouverts pour pouvoir être modifiés.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(CalculateInvoiceDiscount)
        {
            CaptionML = ENU = 'Calculate &Invoice Discount', FRA = 'C&alculer remise facture';
        }
        modify("Get St&d. Vend. Purchase Codes")
        {
            CaptionML = ENU = 'Get St&d. Vend. Purchase Codes', FRA = 'Extraire codes &achat fourn. std';
        }
        modify(CopyDocument)
        {
            CaptionML = ENU = 'Copy Document', FRA = 'Copier document';
        }
        modify("Archive Document")
        {
            CaptionML = ENU = 'Archi&ve Document', FRA = 'Archi&ver document';
            //BC UPgrade SHARMP16 BEGIN>>
            trigger OnBeforeAction()
            var
                ArchiveManagement: Codeunit ArchiveManagement;
            begin
                //ArchiveManagement.ArchivePurchDocument(Rec);//HEI.08
                //CurrPage.UPDATE(FALSE);//HEi.08
                //HEi.08 >>
                UserSetupRec.RESET();
                UserSetupRec.SETRANGE("User ID", USERID);
                IF UserSetupRec.FINDFIRST() THEN begin
                    IF not UserSetupRec."Allow Delete/Archieve PQ FND" = TRUE THEN
                        //     ArchiveManagement.ArchivePurchDocument(Rec);//Bc Upgrade SHARMP16 GAPFitChanges>>
                        //     CurrPage.UPDATE(FALSE);//Bc Upgrade SHARMP16 GAPFitChanges>>


                        // end else //Bc Upgrade SHARMP16 GAPFitChanges >>

                        ERROR(Text004);
                    // end;//Bc Upgrade SHARMP16 GAPFitChanges>>

                    // HEI.08 <<

                end;
            end;
            //BC UPgrade SHARMP16 end<<
        }
        modify(IncomingDocument)
        {
            CaptionML = ENU = 'Incoming Document', FRA = 'Document entrant';
        }
        modify(IncomingDocCard)
        {
            CaptionML = ENU = 'View Incoming Document', FRA = 'Afficher le document entrant';
            ToolTipML = ENU = 'View any incoming document records and file attachments that exist for the entry or document, for example for auditing purposes', FRA = 'Affichez tous les fichiers joints et tous les enregistrements de document entrant qui existent pour l''écriture ou le document, par exemple à des fins d''audit.';
        }
        modify(SelectIncomingDoc)
        {
            CaptionML = ENU = 'Select Incoming Document', FRA = 'Sélectionner le document entrant';
        }
        modify(IncomingDocAttachFile)
        {
            CaptionML = ENU = 'Create Incoming Document from File', FRA = 'Créer un document entrant à partir d''un fichier';
        }
        modify(RemoveIncomingDoc)
        {
            CaptionML = ENU = 'Remove Incoming Document', FRA = 'Supprimer le document entrant';
        }
        modify("Request Approval")
        {
            CaptionML = ENU = 'Request Approval', FRA = 'Approbation demande achat';
        }
        modify(SendApprovalRequest)
        {
            CaptionML = ENU = 'Send A&pproval Request', FRA = 'Envoyer demande d''a&pprobation';
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                //HEI.16>>
                CheckCMGMandatory();
                //HEI.16<<
                //>>Hei.13
                PurchasesPSetup.GET();
                IF PurchasesPSetup."Requester ID Mandatory FND" THEN
                    //       Rec.TESTFIELD("Requester ID");//BC Upgrade SHARMP16-- Drink-IT field used.
                    //>>Hei.13

                    //HEI.14>>
                    grec_InventorySetup.GET();
                IF grec_InventorySetup."Location Mandatory" THEN BEGIN
                    PurchLineRec.RESET();
                    PurchLineRec.SETRANGE("Document Type", Rec."Document Type");
                    PurchLineRec.SETRANGE("Document No.", Rec."No.");
                    PurchLineRec.SETRANGE(Type, PurchLineRec.Type::Item);
                    IF PurchLineRec.findset() THEN
                        REPEAT
                            PurchLineRec.TESTFIELD("Location Code");
                        UNTIL PurchLineRec.NEXT() = 0;
                end;
                //HEI.14<<

                //HEI.07 >>
                GenLedSetRec.RESET();
                GenLedSetRec.GET();
                IF GenLedSetRec."License Dimension Code FND" <> '' THEN BEGIN
                    CLEAR(LicenseCodeValue);

                    PurchHdrRec.RESET();
                    PurchHdrRec.SETRANGE("Document Type", Rec."Document Type");
                    PurchHdrRec.SETRANGE("No.", Rec."No.");
                    IF PurchHdrRec.FINDFIRST() THEN BEGIN
                        DimSetEntryRec.RESET();
                        DimSetEntryRec.SETRANGE("Dimension Set ID", PurchHdrRec."Dimension Set ID");
                        DimSetEntryRec.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                        IF DimSetEntryRec.FINDFIRST() THEN
                            LicenseCodeValue := DimSetEntryRec."Dimension Value Code"
                    end;

                    CLEAR(LicenseCodeValue_1);
                    PurchLineRec.RESET();
                    PurchLineRec.SETRANGE("Document Type", Rec."Document Type");
                    PurchLineRec.SETRANGE("Document No.", Rec."No.");
                    IF PurchLineRec.FINDFIRST() THEN BEGIN
                        REPEAT
                            DimSetEntryRec_1.RESET();
                            DimSetEntryRec_1.SETRANGE("Dimension Set ID", PurchLineRec."Dimension Set ID");
                            DimSetEntryRec_1.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                            IF DimSetEntryRec_1.FINDFIRST() THEN
                                LicenseCodeValue_1 := DimSetEntryRec_1."Dimension Value Code";

                            IF LicenseCodeValue_1 <> '' THEN BEGIN
                                IF LicenseCodeValue <> LicenseCodeValue_1 THEN
                                    ERROR(Text005);
                            end;
                        UNTIL PurchLineRec.NEXT() = 0;
                    end;
                end;
                //HEI.07 <<

            end;
        }
        modify(CancelApprovalRequest)
        {
            CaptionML = ENU = 'Cancel Approval Re&quest', FRA = 'Annuler demande d''appro&bation';
        }



        //Unsupported feature: Codeodification on "Release(Action 118).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReleasePurchDoc.PerformManualRelease(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.16>>
        CheckCMGMandatory;
        //HEI.16<<
        //>>Hei.13
        PurchasesPSetup.GET;
        if PurchasesPSetup."Requester ID Mandatory" then
          Rec.TESTFIELD("Requester ID");
        //<<Hei.13
        //HEI.07 >>
        GenLedSetRec.RESET;
        GenLedSetRec.GET;
        if GenLedSetRec."License Dimension Code" <> '' then begin
          CLEAR(LicenseCodeValue);

          PurchHdrRec.RESET;
          PurchHdrRec.SETRANGE("Document Type",Rec."Document Type");
          PurchHdrRec.SETRANGE("No.",Rec."No.");
          if PurchHdrRec.FINDFIRST then begin
              DimSetEntryRec.RESET;
              DimSetEntryRec.SETRANGE("Dimension Set ID",PurchHdrRec."Dimension Set ID");
              DimSetEntryRec.SETRANGE("Dimension Code",GenLedSetRec."License Dimension Code");
              if DimSetEntryRec.FINDFIRST then
                LicenseCodeValue := DimSetEntryRec."Dimension Value Code"
          end;

          CLEAR(LicenseCodeValue_1);
          PurchLineRec.RESET;
          PurchLineRec.SETRANGE("Document Type",Rec."Document Type");
          PurchLineRec.SETRANGE("Document No.",Rec."No.");
          if PurchLineRec.FINDFIRST then begin
            repeat
              DimSetEntryRec_1.RESET;
              DimSetEntryRec_1.SETRANGE("Dimension Set ID",PurchLineRec."Dimension Set ID");
              DimSetEntryRec_1.SETRANGE("Dimension Code",GenLedSetRec."License Dimension Code");
              if DimSetEntryRec_1.FINDFIRST then
                LicenseCodeValue_1 := DimSetEntryRec_1."Dimension Value Code";

              if LicenseCodeValue_1 <>'' then begin
                if LicenseCodeValue <> LicenseCodeValue_1 then
                  ERROR(Text005);
              end;
            until PurchLineRec.NEXT = 0;
          end;
        end;
        //HEI.07 <<
        ReleasePurchDoc.PerformManualRelease(Rec);
        */
        //end;


        //Unsupported feature: CodeModification on ""Archive Document"(Action 138).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ArchiveManagement.ArchivePurchDocument(Rec);
        CurrPage.UPDATE(false);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //ArchiveManagement.ArchivePurchDocument(Rec);//HEI.08
        //CurrPage.UPDATE(FALSE);//HEi.08
        //HEi.08 >>
        UserSetupRec.RESET;
        UserSetupRec.SETRANGE("User ID",USERID);
        if UserSetupRec.FINDFIRST then begin
          if UserSetupRec."Allow Delete/Archieve PQ" = true then begin
            ArchiveManagement.ArchivePurchDocument(Rec);
            CurrPage.UPDATE(false);
          end else
            ERROR(Text004);
        end;
        // HEI.08 <<
        */
        //end;


        //Unsupported feature: CodeModification on "SendApprovalRequest(Action 153).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if  ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
          ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.16>>
        CheckCMGMandatory;
        //HEI.16<<
        //>>Hei.13
        PurchasesPSetup.GET;
        if PurchasesPSetup."Requester ID Mandatory" then
          Rec.TESTFIELD("Requester ID");
        //>>Hei.13

        //HEI.14>>
        grec_InventorySetup.GET;
        if grec_InventorySetup."Location Mandatory" then begin
          PurchLineRec.RESET;
          PurchLineRec.SETRANGE("Document Type",Rec."Document Type");
          PurchLineRec.SETRANGE("Document No.",Rec."No.");
          PurchLineRec.SETRANGE(Type,PurchLineRec.Type::Item);
          if PurchLineRec.findset then repeat
            PurchLineRec.TESTFIELD("Location Code");
          until PurchLineRec.NEXT = 0;
        end;
        //HEI.14<<

        //HEI.07 >>
        GenLedSetRec.RESET;
        GenLedSetRec.GET;
        if GenLedSetRec."License Dimension Code" <> '' then begin
          CLEAR(LicenseCodeValue);

          PurchHdrRec.RESET;
          PurchHdrRec.SETRANGE("Document Type",Rec."Document Type");
          PurchHdrRec.SETRANGE("No.",Rec."No.");
          if PurchHdrRec.FINDFIRST then begin
              DimSetEntryRec.RESET;
              DimSetEntryRec.SETRANGE("Dimension Set ID",PurchHdrRec."Dimension Set ID");
              DimSetEntryRec.SETRANGE("Dimension Code",GenLedSetRec."License Dimension Code");
              if DimSetEntryRec.FINDFIRST then
                LicenseCodeValue := DimSetEntryRec."Dimension Value Code"
          end;

          CLEAR(LicenseCodeValue_1);
          PurchLineRec.RESET;
          PurchLineRec.SETRANGE("Document Type",Rec."Document Type");
          PurchLineRec.SETRANGE("Document No.",Rec."No.");
          if PurchLineRec.FINDFIRST then begin
            repeat
              DimSetEntryRec_1.RESET;
              DimSetEntryRec_1.SETRANGE("Dimension Set ID",PurchLineRec."Dimension Set ID");
              DimSetEntryRec_1.SETRANGE("Dimension Code",GenLedSetRec."License Dimension Code");
              if DimSetEntryRec_1.FINDFIRST then
                LicenseCodeValue_1 := DimSetEntryRec_1."Dimension Value Code";

              if LicenseCodeValue_1 <>'' then begin
                if LicenseCodeValue <> LicenseCodeValue_1 then
                  ERROR(Text005);
              end;
            until PurchLineRec.NEXT = 0;
          end;
        end;
        //HEI.07 <<

        if  ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
          ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
        */
        //end;

        addafter(Approvals)
        {
            action("Purchase Quote Approvals CBN")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'PQ Approvals';
                RunObject = Page "Purchase Quote Approvals CBN";
                RunPageLink = "Document No." = FIELD("No.");
                RunPageView = sorting("Table ID", "Document Type", "Document No.", Status)
                              ORDER(Ascending)
                              where("Table ID" = FILTER(38),
                                    "Document Type" = FILTER(Quote));
                ToolTip = 'Executes the PQ Approvals action.';
            }
            action("Purchase Additional")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Additional';
                Image = Purchase;
                RunObject = Page "Purchase Additional";
                RunPageLink = "Document Type" = FIELD("Document Type"),
                              "No." = FIELD("No.");
                ToolTip = 'Executes the Purchase Additional action.';
            }
        }
        addafter("Request Approval")
        {
            group(ActionGroup1100710000)
            {
                CaptionML = ENU = 'Approval',
                            FRA = 'Approbation';
                Description = 'DITW18.00.06 GVC 19/05/2015  DIT-770  #1335';
                Image = Approval;
            }
        }
        //BCUpgrade SHARMP16>>--page formatting
        addafter(Approvals_Promoted)
        {
            actionref(PurchaseHeader_Additional; "Purchase Additional")
            {

            }
            actionref(PQApprovals; "Purchase Quote Approvals CBN")
            {

            }
            actionref(MakeOrder_Custom; MakeOrderCustom)
            {

            }//BC Upgrade SHARMP16 PurchProceschanges
        }
        //BCUpgrade SHARMP16<<--page formatting
        // BC Upgrade SHUKLP03 >>
        modify(MakeOrder)
        {
            Visible = false; // BC Upgrade SHUKLP03 << Made base action(MakeOrder) visible false and created custom action(MakeOrderCustom).
        }

        addfirst("Make Order")
        {
            action(MakeOrderCustom)
            {
                ApplicationArea = Suite;
                Caption = 'Make &Order';
                Image = MakeOrder;
                ToolTip = 'Convert the purchase quote to a purchase order.';

                trigger OnAction()
                var
                    PurchOrderHeader: Record "Purchase Header";
                    PurchasesPayablesSetup: Record "Purchases & Payables Setup";

                    UserSetup: Record "User Setup";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    ConfirmManagement: Codeunit "Confirm Management";
                    PurchQuoteToOrder: Codeunit "Purch.-Quote to Order";
                    PurchasesUtils: Codeunit "Purchases-Utils";
                    IsHandled: Boolean;
                    ConvertQuoteToOrderQst: Label 'Do you want to convert the quote to an order?';
                    OpenNewOrderQst: Label 'The quote has been converted to order number %1. Do you want to open the new order?', Comment = '%1 - No. of new purchase order.';
                    PQPOError: TextConst ENU = 'You are not allowed to convert Quotation into Order.';
                    PQwithNoValue: TextConst ENU = 'There is some line with no value in PQ, its cannot be converted into PO.';
                    Text000: TextConst ENU = 'Shipment method code is relevant for Import process. Do you want to convert the quote to an order?', FRA = 'Souhaitez-vous transformer la demande de prix en commande ?';
                    Text001: TextConst ENU = 'Quote number %1 has been converted to order number %2. Location Code in lines is updated to %3', FRA = 'La demande de prix %1 a été transformée en commande %2.';
                //Text002: TextConst ENU = 'Do you want to convert the quote to an order?', FRA = 'Souhaitez-vous transformer la demande de prix en commande ?';
                begin
                    if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then begin
                        // BC Upgrade Shuklp03 >> Added code of codeunit "Purch.-Quote to Order (Yes/No)" because event was not found on that to add below code.

                        PurchasesPayablesSetup.GET(); //HEI.01
                                                      //HEI.04>>
                        IF NOT PurchasesUtils.PQtoPOConditionCheck(Rec) OR NOT (Rec.PurchLinesExist()) THEN
                            ERROR(PQwithNoValue);
                        //HEI.04<<
                        //HEI.02>>
                        IF PurchasesPayablesSetup."Enable PQ to PO check FND" THEN BEGIN
                            UserSetup.GET(USERID);
                            //HEI.03>>
                            IF NOT UserSetup."Make PQ to PO FND" THEN
                                //IF UserSetup."Make PQ to PO" THEN
                                //HEI.03<<
                                ERROR(PQPOError);
                        end;
                        //HEI.02<<
                        Rec.TESTFIELD("Document Type", Rec."Document Type"::Quote);
                        //>>HEI.01
                        IF NOT PurchasesUtils.CheckShippingMethod(PurchasesPayablesSetup, Rec) THEN BEGIN
                            IF NOT CONFIRM(Text000, FALSE) THEN
                                EXIT
                        end else Begin
                            if not ConfirmManagement.GetResponseOrDefault(ConvertQuoteToOrderQst, true) then
                                exit;
                        end;
                        IsHandled := false;
                        OnBeforePurchQuoteToOrder(Rec, IsHandled);
                        if IsHandled then
                            exit;

                        PurchQuoteToOrder.Run(Rec);
                        PurchQuoteToOrder.GetPurchOrderHeader(PurchOrderHeader);

                        IsHandled := false;
                        OnAfterCreatePurchOrder(PurchOrderHeader, IsHandled);
                        if not IsHandled then
                            //>> HEI.01
                            IF NOT PurchasesUtils.CheckShippingMethod(PurchasesPayablesSetup, Rec) THEN BEGIN
                                MESSAGE(
                                    Text001,
                                    Rec."No.", PurchOrderHeader."No.", PurchasesPayablesSetup."Location Code Imp Proc. FND");
                            end else BEGIN
                                if ConfirmManagement.GetResponseOrDefault(StrSubstNo(OpenNewOrderQst, PurchOrderHeader."No."), true) then
                                    PAGE.Run(PAGE::"Purchase Order", PurchOrderHeader);

                                //CODEUNIT.Run(CODEUNIT::"Purch.-Quote to Order (Yes/No)", Rec)
                                //<<HEI.01
                                // BC Upgrade Shuklp03 >> Added code of codeunit "Purch.-Quote to Order (Yes/No)" because event was not found on that codeunit.

                            end;
                    end;

                end;
            }
        }
        // BC Upgrade SHUKLP03 <<
    }

    // BC Upgrade SHUKLP03 >>
    [IntegrationEvent(false, false)]
    local procedure OnAfterCreatePurchOrder(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePurchQuoteToOrder(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
    end;
    // BC Upgrade SHUKLP03 <<

    var

        DIM: Record 348;
        DimSetEntryRec: Record "Dimension Set Entry";
        DimSetEntryRec_1: Record "Dimension Set Entry";
        DimSetEntryRec_2: Record "Dimension Set Entry";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        DimValRec: Record "Dimension Value";
        GenLedSetRec: Record "General Ledger Setup";
        grec_InventorySetup: Record "Inventory Setup";
        PurchHdrRec: Record "Purchase Header";
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchHdrAddiRec: Record "Purchase Header Additional FND";
        PurchaseLine: Record "Purchase Line";
        PurchLineRec: Record "Purchase Line";
        PurchasesPayablesSetupL: Record "Purchases & Payables Setup";
        PurchasesPSetup: Record "Purchases & Payables Setup";
        StdVendPurchCode: Record "Standard Vendor Purchase Code";
        UserSetupRec: Record "User Setup";
        DimMgt: Codeunit DimensionManagement;
        HeinekenGlobal: Codeunit "Heineken Global";
        DimValPage: Page "Dimension Values";
        HideValidationDialog: Boolean;

        PayToCommentBtnVisible: Boolean;

        PayToCommentPictVisible: Boolean;

        PurchHistoryBtn1Visible: Boolean;

        PurchHistoryBtnVisible: Boolean;
        DimValue: Code[10];
        LicenseCode: Code[20];
        LicenseCodeValue: Code[20];
        LicenseCodeValue_1: Code[20];
        NewDImSetId: Integer;
        OldDimSetId: Integer;
        Text000: Label 'Please select the dimension for License Dimension in General Ledger Setup.';
        Text001: Label 'The seleced value cannot be found in the dimension value table.';
        Text002: Label 'You cannot edit the License code when the PQ is Released.';
        Text003: Label 'You don''t have  permission to delete the PQ.';
        Text004: Label 'You don''t have  permission to Archieve the PQ.';
        Text005: Label 'License Dimension Value should be same for all both header and lines.';
        Text051: TextConst ENU = 'You may have changed a dimension.\\Do you want to update the lines?', FRA = 'Vous avez probablement modifié un axe analytique.\\Souhaitez-vous mettre à jour les lignes ?';



    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetControlAppearance;
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(RECORDID);
    ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
    SETFILTER("Resp. Center Table Filter",
      UserMgt.GetRespCenterFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Phys. Location Table Filter",
      UserMgt.GetRespPhysLocationFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Location Table Filter",
      UserMgt.GetRespLocationFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
    // >>DITW18.00.06 DDR DIT-770 #1191

    #1..4
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //begin
    /*
    if PurchaseHeaderAdditional.GET("Document Type","No.") then; //HEI.12
    */
    //end;


    //Unsupported feature: CodeModification on "OnDeleteRecord". Please convert manually.

    //trigger OnDeleteRecord() : Boolean;
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.SAVERECORD;
    exit(ConfirmDeletion);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //CurrPage.SAVERECORD;//HEI.08
    //EXIT(ConfirmDeletion);//HEI.08
    //HEi.08 >>
    UserSetupRec.RESET;
    UserSetupRec.SETRANGE("User ID",USERID);
    if UserSetupRec.FINDFIRST then begin
      if UserSetupRec."Allow Delete/Archieve PQ" = true then begin
        CurrPage.SAVERECORD;
        exit(ConfirmDeletion);
      end else
        ERROR(Text003);
    end;
    // HEI.08 <<
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if UserMgt.GetPurchasesFilter <> '' then begin
      FILTERGROUP(2);
      SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
      FILTERGROUP(0);
    end;

    SetDocNoVisible;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1191
    //IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
    if UserMgt.GetPurchasesTextFilter <> '' then begin
      FILTERGROUP(2);
      //SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
      SETFILTER("Responsibility Center",UserMgt.GetPurchasesTextFilter);
      FILTERGROUP(0);
    end;
    // >>DITW18.00.06 DDR DIT-770 #1191

    SetDocNoVisible;
    */
    //end;

    local procedure UpdateAllLineDimNew(NewParentDimSetID: Integer; OldParentDimSetID: Integer);
    var
        PurchLine: Record "Purchase Line";
        ReceivedShippedItemLineDimChangeConfirmed: Boolean;
        NewDimSetID: Integer;
    begin
        // Update all lines with changed dimensions.
        //HEI.07 >>
        if NewParentDimSetID = OldParentDimSetID then
            exit;

        if not HideValidationDialog then
            if not CONFIRM(Text051) then
                exit;

        PurchLine.RESET();
        PurchLine.SETRANGE("Document Type", rec."Document Type");
        PurchLine.SETRANGE("Document No.", rec."No.");
        PurchLine.LOCKTABLE();
        if PurchLine.FIND('-') then
            repeat
                NewDimSetID := DimMgt.GetDeltaDimSetID(PurchLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                if PurchLine."Dimension Set ID" <> NewDimSetID then begin
                    PurchLine."Dimension Set ID" := NewDimSetID;

                    if not HideValidationDialog and GUIALLOWED then
                        VerifyReceivedShippedItemLineDimChange(ReceivedShippedItemLineDimChangeConfirmed);

                    DimMgt.UpdateGlobalDimFromDimSetID(
                      PurchLine."Dimension Set ID", PurchLine."Shortcut Dimension 1 Code", PurchLine."Shortcut Dimension 2 Code");
                    PurchLine.MODIFY();
                end;
            until PurchLine.NEXT() = 0;
        //HEI.07 <<
    end;

    //Blocked below procedure already defined in base.
    // procedure SetHideValidationDialog(NewHideValidationDialog: Boolean);
    // begin
    //     //HEI.07 >>
    //     HideValidationDialog := NewHideValidationDialog;
    //     //HEI.07 >>
    // end;

    local procedure VerifyReceivedShippedItemLineDimChange(var ReceivedShippedItemLineDimChangeConfirmed: Boolean);
    var
        PurchLine: Record "Purchase Line";
    begin
        //HEI.07 >>
        if PurchLine.IsReceivedShippedItemDimChanged() then
            if not ReceivedShippedItemLineDimChangeConfirmed then
                ReceivedShippedItemLineDimChangeConfirmed := PurchLine.ConfirmReceivedShippedItemDimChange();
        //HEI.07 <<
    end;

    local procedure CheckCMGMandatory();
    var
        lDimSetEntry: Record "Dimension Set Entry";
        lGenLedgSetup: Record "General Ledger Setup";
        lItemCharge: Record "Item Charge";
        lPurchLine: Record "Purchase Line";
        CMGMandatory: Label 'You must select a Dimension Value for Dimension Code %1 for Line No %2 in Purchase Order %3';
    begin
        //HEI.16>>
        lPurchLine.RESET();
        lPurchLine.SETRANGE("Document Type", rec."Document Type");
        lPurchLine.SETRANGE("Document No.", rec."No.");
        lPurchLine.SETRANGE(Type, lPurchLine.Type::"Charge (Item)");
        if lPurchLine.findset() then begin
            repeat
                // if (lItemCharge.GET(lPurchLine."No.")) and (lItemCharge."Item Charge Type" = lItemCharge."Item Charge Type"::ShippingCost) then begin//BC Upgrade SHARMP16 Drink-it field
                lGenLedgSetup.GET();
                lDimSetEntry.RESET();
                lDimSetEntry.SETRANGE(lDimSetEntry."Dimension Set ID", lPurchLine."Dimension Set ID");
                lDimSetEntry.SETRANGE(lDimSetEntry."Dimension Code", lGenLedgSetup."CMG Dimension Code FND");
                if not lDimSetEntry.FINDFIRST() then
                    ERROR(CMGMandatory, lGenLedgSetup."CMG Dimension Code FND", lPurchLine."Line No.", lPurchLine."Document No.");
            // end;
            until lPurchLine.NEXT() = 0;
        end;
        //HEI.16<<
    end;
    //BC Upgrade SHARMP16 Begin>>
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        IF PurchaseHeaderAdditional.GET(rec."Document Type", rec."No.") THEN; //HEI.12
    end;
    //BC Upgrade SHARMP16 end<<
    //BC Upgrade SHARMP16 BEGIN>>
    trigger OnDeleteRecord(): Boolean
    var
        myInt: Integer;
    begin
        //HEi.08 >>
        UserSetupRec.RESET();
        UserSetupRec.SETRANGE("User ID", USERID);
        IF UserSetupRec.FINDFIRST() THEN BEGIN
            IF UserSetupRec."Allow Delete/Archieve PQ FND" = TRUE THEN BEGIN
                CurrPage.SAVERECORD();
                EXIT(rec.ConfirmDeletion());
            end else
                ERROR(Text003);
        end;
        // HEI.08 <<
    end;
    //BC Upgrade SHARMP16 End<<

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

