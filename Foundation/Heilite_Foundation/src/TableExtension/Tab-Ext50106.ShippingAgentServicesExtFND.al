tableextension 50106 ShippingAgentServicesExtFND extends "Shipping Agent Services"
{
    // version NAVW17.00,DITW18.00,HEI.04
    //     DITW15.00.00.21 DDR 18/06/2008 added fields
    //                                  2014060 Maximum Weight
    //                                  2014061 Maximum Volume
    //                                  2014062 Shipping Charge Type
    //                                  2014063 Shipping Charge No.
    //                                  2014064 Shipping Charge Per
    // DITW15.00.00.28 DDR 02/12/2008 Added fields
    //                                  2014087 Distance
    // DITW15.00.00.39 DDR 06/07/2011 issue 1353 Added fields
    //                                   2014290 Journey Time
    //                     04/08/2011 issue 1353 Modified caption field2014290 "Journey Time"
    // DITW16.00.00.40 DDR 16/02/2012 DIT-715 #245
    //                                 Added fields
    //                                   2014065 Truck Size
    //                                   2014066 Truck Unload Type
    //                                 Added functions ShowTruckUnload(),ValidateTruckUnload(),TruckUnloadCaptionClass()
    //                                 Added text constants Text2014060,Text2014061,Text2014062,Text2014063

    // HEI.01 Defect#1330 IBM LAZARE02 11.01.2018 # New fields "Vendor No.", "Blanket Order No."
    // HEI.02 FDD-HT658 IBM.GUNERE01 20.09.2019 # "Create PO Options" field added
    //                               24.09.2019 # Allow Shipping Cost Per field added
    //                                          # "Charge Assign Suggest Type" field added
    // HEI.03 CHG2039144 FDD-HT949 IBM.GUNERE01 28.11.2019 # "Shipping Charge Per" new option added UOM,
    //                                                     # "Unit of Measure" field added
    //                                                     # "Unit of Measure" - OnLookUp func. modified
    //                                                     # GetWarehouseSetup func. added
    // HEI.04 CHG2181622 IBM.COSTES04 20.01.2023 #  Transportation Cost Module incorect currency code
    //   # New field currency code

    fields
    {
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Shipping Agent Code', FRA = 'Code transporteur';
        }
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Shipping Time")
        {
            CaptionML = ENU = 'Shipping Time', FRA = 'Délai d''expédition';
        }
        modify("Base Calendar Code")
        {
            CaptionML = ENU = 'Base Calendar Code', FRA = 'Code calendrier principal';
        }

        //Unsupported feature: CodeModification on ""Shipping Time"(Field 4).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DateTest := CALCDATE("Shipping Time",WORKDATE);
        IF DateTest < WORKDATE THEN
          ERROR(Text000,FIELDCAPTION("Shipping Time"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        DateTest := CALCDATE("Shipping Time",WORKDATE);
        if DateTest < WORKDATE then
          ERROR(Text000,FIELDCAPTION("Shipping Time"));
        */
        //end;
        field(50001; "Blanket Order No. FND"; Code[20])
        {
            CaptionML = ENU = 'Blanket Order No.',
                        FRA = 'N° commande ouverte';
            Description = 'HEI.01';

            trigger OnLookup();
            var
                PurchaseHeader: Record "Purchase Header";
                ShippingAgent: Record "Shipping Agent";
            begin
                //HEI.01>>
                ShippingAgent.GET("Shipping Agent Code");
                PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::"Blanket Order");
                //PurchaseHeader.SETRANGE("Buy-from Vendor No.", ShippingAgent."Vendor No.");  // BC Upgrade NANDIS03
                if PAGE.RUNMODAL(PAGE::"Blanket Purchase Orders", PurchaseHeader) = ACTION::LookupOK then
                    "Blanket Order No. FND" := PurchaseHeader."No.";
                //HEI.01<<
            end;
        }
        // field(50002; "Create PO Options"; Option)  // BC Upgrade - blocked option type
        field(50002; "Create PO Options FND"; enum "Create PO Options")  // BC Upgrade - opened enum type
        {
            caption ='Create PO Options';
            Description = 'HEI.02';
            // OptionCaption = '" ,Create Open PO,Create & Release PO,Create & Release & Receive PO"';
            // OptionMembers = " ",CreateOpenPO,CreateReleasePO,CreateReleaseReceivePO;
        }
        field(50003; "Unit of Measure FND"; Code[10])
        {
            caption ='Unit of Measure';
            Description = 'HEI.03';

            trigger OnLookup();
            begin
                //>> HEI.03
                GetWarehouseSetup();
                // UnitofMeasure.SETFILTER(UnitofMeasure.Code, '%1|%2|%3', WarehouseSetup."Shortcut Unit of Measure1 Code",
                //                                                       WarehouseSetup."Shortcut Unit of Measure2 Code",
                //                                                       WarehouseSetup."Shortcut Unit of Measure3 Code");  // BC Upgrade NANDIS03 - Dependency on Aptean

                if PAGE.RUNMODAL(PAGE::"Units of Measure", UnitofMeasure) = ACTION::LookupOK then
                    "Unit of Measure FND" := UnitofMeasure.Code;
                //<< HEI.03
            end;

            trigger OnValidate();
            begin
                //>> HEI.03
                //TESTFIELD("Shipping Charge Per", "Shipping Charge Per"::UOM);  // BC Upgrade NANDIS03
                //<< HEI.03
            end;
        }
        field(50004; "Currency Code FND"; Code[20])
        {
            CalcFormula = Lookup("Purchase Header"."Currency Code" WHERE("Document Type" = CONST("Blanket Order"),
                                                                          "No." = FIELD("Blanket Order No. FND")));
            Caption = 'Currency Code';
            Description = 'HEI.04';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Currency;
        }
        // field(2014060; "Maximum Weight"; Decimal)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Maximum Weight',
        //                 FRA = 'Poids maximum';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.21';
        //     MinValue = 0;
        // }
        // field(2014061; "Maximum Cubage"; Decimal)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Maximum Volume (Cubage)',
        //                 FRA = 'Volume (Cubage) maximum';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.21';
        //     MinValue = 0;
        // }
        // field(2014062; "Shipping Charge Type"; Option)
        // {
        //     CaptionML = ENU = 'Shipping Charge Type',
        //                 FRA = 'Type frais transport';
        //     Description = 'DITW15.00.00.21';
        //     OptionCaptionML = ENU = ' ,Account (G/L),Charge (Item)',
        //                       FRA = ' ,Compte général,Frais annexes';
        //     OptionMembers = " ","Account (G/L)","Charge (Item)";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.21 DDR 18/06/2008
        //         if ("Shipping Charge Type" = "Shipping Charge Type"::" ") or
        //            (("Shipping Charge Type" <> xRec."Shipping Charge Type") and
        //             ("Shipping Charge Type" <> "Shipping Charge Type"::" "))
        //         then begin
        //             CLEAR("Shipping Charge No.");
        //             CLEAR("Shipping Charge Per");
        //         end
        //         // >>DITW15.00.00.21 DDR
        //     end;
        // }
        // field(2014063; "Shipping Charge No."; Code[20])
        // {
        //     CaptionML = ENU = 'Shipping Charge No.',
        //                 FRA = 'N° frais transport';
        //     Description = 'DITW15.00.00.21';
        //     TableRelation = IF ("Shipping Charge Type" = CONST("Account (G/L)")) "G/L Account" WHERE(Blocked = CONST(false),
        //                                                                                             "Direct Posting" = CONST(true),
        //                                                                                             "Account Type" = CONST(Posting))
        //     ELSE IF ("Shipping Charge Type" = CONST("Charge (Item)")) "Item Charge" WHERE("Item Charge Type" = CONST(ShippingCost));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.21 DDR 18/06/2008
        //         TESTFIELD("Shipping Charge Type");
        //         // >>DITW15.00.00.21 DDR
        //     end;
        // }
        // field(2014064; "Shipping Charge Per"; Option)
        // {
        //     CaptionML = ENU = 'Shipping Charge Per',
        //                 FRA = 'Frais transport par';
        //     Description = 'DITW15.00.00.21,HEI.03';
        //     OptionCaptionML = ENU = 'Shipment,Weight,Volume,UOM',
        //                       FRA = 'Expédition,Poids,Volume,UOM';
        //     OptionMembers = Shipment,Weight,Volume,UOM;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.21 DDR 18/06/2008
        //         TESTFIELD("Shipping Charge Type");
        //         TESTFIELD("Shipping Charge No.");
        //         // >>DITW15.00.00.21 DDR
        //     end;
        // }
        // field(2014065; "Truck Size"; Code[10])
        // {
        //     CaptionML = ENU = 'Truck Size',
        //                 FRA = 'Taille/Dimension camion';
        //     Description = 'DIT-715 #245';
        //     TableRelation = "Whse. Shipping Truck Size";
        // }
        // field(2014066; "Truck Unload Type"; Code[3])
        // {
        //     CaptionML = ENU = 'Truck Unload Type',
        //                 FRA = 'Type déchargement camion';
        //     Description = 'DIT-715 #245';
        //     InitValue = '000';
        //     Numeric = true;

        //     trigger OnValidate();
        //     var
        //         BadNumCode: Code[10];
        //     begin
        //         BadNumCode := DELCHR("Truck Unload Type", '<>=', '01');
        //         "Truck Unload Type" := PADSTR('', MAXSTRLEN("Truck Unload Type") - STRLEN("Truck Unload Type"), '0') + "Truck Unload Type";
        //         "Truck Unload Type" := CONVERTSTR("Truck Unload Type", BadNumCode, PADSTR('', STRLEN(BadNumCode), '0'));
        //     end;
        // }
        // field(2014071; "Allow Shipping Cost Per"; Option)
        // {
        //     Description = 'HEI.02';
        //     OptionCaption = '" ,Order/Return/Transfer,Warehouse"';
        //     OptionMembers = " ",Document,Warehouse;
        // }
        // field(2014080; "Charge Assign Suggest Type"; Option)
        // {
        //     Description = 'HEI.02';
        //     OptionCaption = '" ,Equally,By Amount,By Gross Weight,By Unit Volume,,,,,,By Weight,By Volume (Cubage),By Quantity"';
        //     OptionMembers = " ",Equally,"By Amount","By Gross Weight","By Unit Volume",,,,,,"By Weight","By Cubage","By Quantity";

        //     trigger OnValidate();
        //     begin
        //         //>> HEI.02
        //         if "Charge Assign Suggest Type" <> "Charge Assign Suggest Type"::" " then
        //             TESTFIELD("Shipping Charge Type", "Shipping Charge Type"::"Charge (Item)")
        //         else
        //             case "Shipping Charge Type" of
        //                 "Shipping Charge Type"::"Account (G/L)":
        //                     ;
        //                 "Shipping Charge Type"::"Charge (Item)":
        //                     FIELDERROR("Charge Assign Suggest Type", STRSUBSTNO(Text001, FIELDCAPTION("Shipping Charge Type"), "Shipping Charge Type"));
        //             end;
        //         //<< HEI.02
        //     end;
        // }
        // field(2014087; Distance; Decimal)
        // {
        //     CaptionML = ENU = 'Distance',
        //                 FRA = 'Distance';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.28';
        //     MinValue = 0;
        // }
        // field(2014290; "Journey Time"; DateFormula)
        // {
        //     CaptionML = ENU = 'Journey Time (EMCS)',
        //                 FRA = 'Temps de trajet (EMCS)';
        //     Description = 'DITW15.00.00.39 #1353';

        //     trigger OnValidate();
        //     var
        //         DateTest: Date;
        //     begin
        //         DateTest := CALCDATE("Journey Time", WORKDATE);
        //         if DateTest < WORKDATE then
        //             ERROR(Text000, FIELDCAPTION("Journey Time"));
        //     end;
        // }  // BC Upgrade NANDIS03
    }


    //Unsupported feature: CodeInsertion on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW15.00.00.21 DDR 18/06/2008
    if ("Shipping Charge Type" <> "Shipping Charge Type"::" ") and
       ("Shipping Charge No." = '')
    then
      "Shipping Charge Type" := "Shipping Charge Type"::" ";
    // >>DITW15.00.00.21 DDR
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=The %1 cannot be negative.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=The %1 cannot be negative.;FRA=Le %1 ne peut être négatif.;
    //Variable type has not been exported.

    var
        Text2014060: TextConst ENU = '3,%1', FRA = '3,%1';
        Text2014061: TextConst ENU = 'Left', FRA = 'Gauche';
        Text2014062: TextConst ENU = 'Right', FRA = 'Droite';
        Text2014063: TextConst ENU = 'Back', FRA = 'Arrière';
        Text001: Label 'cannot be specified when %1 is %2';
        WarehouseSetup: Record "Warehouse Setup";
        WarehouseSetupGot: Boolean;
        UnitofMeasure: Record "Unit of Measure";

    // BC Upgrade NANDIS03 >>
    local procedure GetWarehouseSetup()
    begin
        //>> HEI.03
        IF NOT WarehouseSetupGot THEN
            IF WarehouseSetup.GET() THEN;
        WarehouseSetupGot := TRUE
        //<< HEI.03
    end;

    procedure ChargePerToSuggestChargePer2(ChargePer: Option "",Shipment,Weight,Volume): Integer
    var
        myInt: Integer;
    begin
        //>> HEI.02
        // CASE ChargePer OF
        //     ChargePer::Shipment:
        //         EXIT("Charge Assign Suggest Type"::"By Cubage");
        //     ChargePer::Volume:
        //         EXIT("Charge Assign Suggest Type"::"By Cubage");
        //     ChargePer::Weight:
        //         EXIT("Charge Assign Suggest Type"::"By Weight");
        //     ELSE
        //         EXIT("Charge Assign Suggest Type"::" ");
        // END;  // BC Upgrade NANDIS03
        //<< HEI.02
    end;
    // BC Upgrade NANDIS03 <<
}

