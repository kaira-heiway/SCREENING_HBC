tableextension 50065 DefaultDimensionExtFND extends "Default Dimension"
{
    // version NAVW110.0.00.16177,FINXL10.01,DITW110.00.11,HEI.03
    // HEI.BC.01 22.09.2025 SAHAL01 (Version Upgrade BC260)
    // Migrated Customizations in the Table(50065) extn.

    fields
    {
        modify("Table ID")
        {
            CaptionML = ENU = 'Table ID', FRA = 'ID table';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = CONST(Table));
        }
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
            TableRelation = IF ("Table ID" = CONST(13)) "Salesperson/Purchaser" else IF ("Table ID" = CONST(15)) "G/L Account" else IF ("Table ID" = CONST(18)) Customer else IF ("Table ID" = CONST(23)) Vendor else IF ("Table ID" = CONST(27)) Item else IF ("Table ID" = CONST(152)) "Resource Group" else IF ("Table ID" = CONST(156)) Resource else IF ("Table ID" = CONST(167)) Job else IF ("Table ID" = CONST(270)) "Bank Account" else IF ("Table ID" = CONST(413)) "IC Partner" else IF ("Table ID" = CONST(5071)) Campaign else IF ("Table ID" = CONST(5200)) Employee else IF ("Table ID" = CONST(5600)) "Fixed Asset" else IF ("Table ID" = CONST(5628)) Insurance else IF ("Table ID" = CONST(5903)) "Service Order Type" else IF ("Table ID" = CONST(5904)) "Service Item Group" else IF ("Table ID" = CONST(5940)) "Service Item" else IF ("Table ID" = CONST(5714)) "Responsibility Center" else IF ("Table ID" = CONST(5800)) "Item Charge" else IF ("Table ID" = CONST(99000754)) "Work Center" else IF ("Table ID" = CONST(5105)) "Customer Templ." else IF ("Table ID" = CONST(849)) "Cash Flow Manual Revenue" else IF ("Table ID" = CONST(850)) "Cash Flow Manual Expense";
            //else IF ("Table ID" = CONST(2034841)) Building else IF ("Table ID" = CONST(2034851)) "FA Template" //BC Update SAHAL01 >> (Drink-IT Code)
            //else IF ("Table ID" = CONST(2034902)) "Serv. Purch. Contract Template" else IF ("Table ID" = CONST(2014310)) "Financial Contract Header" else IF ("Table ID" = CONST(2034890)) "Service Purch. Contract Header" else IF ("Table ID" = CONST(2014317)) "Indirect Journal Line" else IF ("Table ID" = CONST(2014320)) "Indirect Cust. Ledger Entry"
            //else IF ("Table ID" = CONST(2014422)) "Vendor Template" else IF ("Table ID" = CONST(2013788)) "Free Reason Code"; //BC Update SAHAL01 << (Drink-IT Code)
        }
        modify("Dimension Code")
        {
            CaptionML = ENU = 'Dimension Code', FRA = 'Code axe';
        }
        modify("Dimension Value Code")
        {
            CaptionML = ENU = 'Dimension Value Code', FRA = 'Code section';
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Dimension Code"));
        }
        modify("Value Posting")
        {
            CaptionML = ENU = 'Value Posting', FRA = 'Contrôle validation';
        }
        modify("Table Caption")
        {
            CaptionML = ENU = 'Table Caption', FRA = 'Légende table';
        }
        modify("Multi Selection Action")
        {
            CaptionML = ENU = 'Multi Selection Action', FRA = 'Action multi-sélection';
            OptionCaptionML = ENU = ' ,Change,Delete', FRA = ' ,Modifie,Supprime';
        }
        field(50000; "Budgeted Amount FND"; Decimal)
        {
            Caption = 'Budgeted Amount';
        }

    }
    trigger OnDelete();
    begin
        ///DITW17.00.02 SR 10/09/2013 DIT-770 #143 - DITW110.00.08 DDR 02/01/2017 - NRQ#0DITW110.00.11 MSF 07/11/2017 NRQ#13577
        // <<DITW16.00.00.42 DDR 06/12/2012 DIT-715 #470
        //if IsBuildingDimValue() then //BC Update SAHAL01 >> (Drink-IT Code)
        //  ERROR(Text2034841, TABLECAPTION);
        // >>DITW16.00.00.42 DDR DIT-715 #470
        //<< FINXL10.01 AKH 19/07/2017 NRQ#33089
        //if fctIsCustomerDimValue() or fctIsVendorDimValue() or fctIsItemDimValue() then
        //  ERROR(Text2029611, TABLECAPTION); //BC Update SAHAL01 << (Drink-IT Code)
        //>> FINXL10.01 AKH 19/07/2017 NRQ#33089
    end;

    trigger OnInsert();
    begin
        ///DITW17.00.02 SR 10/09/2013 DIT-770 #143 - DITW110.00.08 DDR 02/01/2017 - NRQ#0 - DITW110.00.11 MSF 08/11/2017 NRQ#13577
        // <<DITW16.00.00.42 DDR 06/12/2012 11/12/2012 DIT-715 #470
        //if IsBuildingDimValue() then begin //BC Update SAHAL01 >> (Drink-IT Code)
        //  DitservMgtSetup.GET;
        //if "Dimension Code" = '' then
        //  "Dimension Code" := DitservMgtSetup."Building Dimension Code";
        //if DitservMgtSetup."Building Dimension Code" <> '' then
        //  TESTFIELD("Dimension Code", DitservMgtSetup."Building Dimension Code");
        //if "Dimension Value Code" = '' then begin
        //  "Dimension Value Code" := "No.";
        //"Value Posting" := "Value Posting"::"Same Code";
        //end;
        //if ("Dimension Code" <> '') and ("Dimension Value Code" <> '') then
        //  TESTFIELD("Value Posting", "Value Posting"::"Same Code");
        //end; //BC Update SAHAL01 << (Drink-IT Code)
        // >>DITW16.00.00.42 DDR DIT-715 #470
        //<< FINXL10.01 AKH 19/07/2017 NRQ#33089
        //Customer
        //if fctIsCustomerDimValue() then begin //BC Update SAHAL01 >> (Drink-IT Code)
        //  rSalesSetup.GET;
        //if "Dimension Code" = '' then
        //  "Dimension Code" := rSalesSetup."Customer Auto Dimension Code";
        //if (rSalesSetup."Customer Auto Dimension Code" <> '') then
        //  TESTFIELD("Dimension Code", rSalesSetup."Customer Auto Dimension Code");
        //if "Dimension Value Code" = '' then
        //  "Dimension Value Code" := "No.";
        /// FINXL10.01 AKH 28/07/2017 NRQ#33089
        //end;
        //Vendor
        //if fctIsVendorDimValue() then begin
        //  rPurchSetup.GET;
        //if "Dimension Code" = '' then
        //  "Dimension Code" := rPurchSetup."Vendor Auto Dimension Code";
        //if (rPurchSetup."Vendor Auto Dimension Code" <> '') then
        //  TESTFIELD("Dimension Code", rPurchSetup."Vendor Auto Dimension Code");
        //if "Dimension Value Code" = '' then
        //  "Dimension Value Code" := "No.";
        /// FINXL10.01 AKH 28/07/2017 NRQ#33089
        //end;
        //Item
        //if fctIsItemDimValue() then begin
        //  rInvtSetup.GET;
        //if "Dimension Code" = '' then
        //  "Dimension Code" := rInvtSetup."Item Auto Dimension Code";
        //if (rInvtSetup."Item Auto Dimension Code" <> '') then
        //  TESTFIELD("Dimension Code", rInvtSetup."Item Auto Dimension Code");
        //if "Dimension Value Code" = '' then
        //  "Dimension Value Code" := "No.";
        /// FINXL10.01 AKH 28/07/2017 NRQ#33089
        //end; //BC Update SAHAL01 << (Drink-IT Code)
        //>> FINXL10.01 AKH 19/07/2017 NRQ#33089

        //Fixed Asset
        CheckingOfFADimValue(); //HEI.02
    end;

    trigger OnModify();
    begin
        ///DITW17.00.02 SR 10/09/2013 DIT-770 #143 - DITW110.00.08 DDR 02/01/2017 - NRQ#0 - DITW110.00.11 MSF 07/11/2017 NRQ#13577
        // <<DITW16.00.00.42 DDR 06/12/2012 11/12/2012 DIT-715 #470
        //if IsBuildingDimValue() then begin //BC Update SAHAL01 >> (Drink-IT Code)
        //  if "No." <> "Dimension Value Code" then
        //    ERROR(Text2034840, TABLECAPTION);
        //TESTFIELD("Value Posting", "Value Posting"::"Same Code");
        //end;
        // >>DITW16.00.00.42 DDR DIT-715 #470
        //<< FINXL10.01 AKH 19/07/2017 NRQ#33089
        //if fctIsCustomerDimValue() or fctIsVendorDimValue() or fctIsItemDimValue() then begin
        //  if "No." <> "Dimension Value Code" then
        //    ERROR(Text2029610, TABLECAPTION);
        /// FINXL10.01 AKH 28/07/2017 NRQ#33089
        //end; //BC Update SAHAL01 << (Drink-IT Code)
        //>> FINXL10.01 AKH 19/07/2017 NRQ#33089

        //Fixed Asset
        CheckingOfFADimValue(); //HEI.02
    end;

    var
        Rec_Cust: Record Customer;
        GLSetup: Record "General Ledger Setup";
        rInvtSetup: Record "Inventory Setup";
        Rec_item: Record Item;
        rPurchSetup: Record "Purchases & Payables Setup";
        rSalesSetup: Record "Sales & Receivables Setup";
        Rec_Vend: Record Vendor;
        DimMgt: Codeunit "DimensionManagement";
        CMGRestrictions: Label 'you can''t select the Dimension Value %1, for more information check the FA Setup.';
        Text2029610: Label 'You can''t modify a %1.';
        Text2029611: Label 'You can''t delete a %1.';
        Text000: TextConst ENU = 'You cannot rename a %1.', FRA = 'Vous ne pouvez pas renommer un(e) %1';
        Text2034840: TextConst ENU = 'You can''t modify a %1.', FRA = 'Vous ne pouvez pas modifier un(e) %1';
        Text2034841: TextConst ENU = 'You can''t delete a %1.', FRA = 'Vous ne pouvez pas supprimer un(e) %1';
    //DitservMgtSetup : Record "Property Service Mgt. Setup"; //BC Update SAHAL01 (Drink-IT Code)

    LOCAL procedure CheckingOfFADimValue()
    var
        FixedAssetSetup: Record "FA Setup";
        FixedAsset: Record "Fixed Asset";
    begin
        //HEI.BC.01>>
        //HEI.02>>
        IF ("Table ID" = DATABASE::"Fixed Asset") THEN BEGIN
            FixedAssetSetup.GET();
            IF STRPOS(FixedAssetSetup."Excluded CMG Dim. Values FND", Rec."Dimension Value Code") = 0 THEN BEGIN
                IF FixedAsset.GET("No.") THEN;
            end else
                ERROR(CMGRestrictions, Rec."Dimension Value Code");
        end;
        //HEI.02<<
        //HEI.BC.01<<
    end;
}