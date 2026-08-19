table 50358 "Sales Prom Item Charge Sub FND"
{
    // version HEI.01
    // HEI.01 FDD-SLSGAP019 IBM NASTAA02 21.05.2018 # Combo Promotion
    //   # New table created, moved from Hei 2.0
    //   BC Upgrade KUMARS145 Nav ID Table	50093	"Sales Prom Item Charge Sub FND"
    //   BC Upgrade KUMARS145 Drinkit field relation commented dependency on table  #2013762	Drink Promotion Group.
    //   BC Upgrade KUMARS145 Drinkit Table Record commented dependency on table  #2013766	Sales Promotion Item Charge.
    //   BC Upgrade KUMARS145 Drinkit Table Record commented dependency on table  #2013762	Drink Promotion Group.
    //   BC Upgrade KUMARS145 Drinkit Procedure call commented 
    LookupPageID = "Item List";
    fields
    {
        field(1; "Source Type"; Option)
        {
            CaptionML = ENU = 'Source type',
                        FRA = 'Type origine';
            Editable = false;
            InitValue = Item;
            OptionCaptionML = ENU = 'Item',
                              FRA = 'Article';
            OptionMembers = Item;

            trigger OnValidate();
            begin
                if xRec."Source Type" <> "Source Type" then
                    VALIDATE("Source No.", '');
            end;
        }
        field(2; "Source No."; Code[20])
        {
            CaptionML = ENU = 'Source No.',
                        FRA = 'N° origine';
            NotBlank = true;
            TableRelation = IF ("Source Type" = CONST(Item)) Item;

            trigger OnLookup();
            begin
                LookupSourceNo();
            end;
        }
        field(3; Type; Option)
        {
            CaptionML = ENU = 'Type',
                        FRA = 'Type';
            Editable = false;
            OptionCaptionML = ENU = ' ,,Item',
                              FRA = ' ,,Article';
            OptionMembers = " ",,Item;
        }
        field(4; "No."; Code[20])
        {
            CaptionML = ENU = 'No.',
                        FRA = 'N°';
            Editable = false;
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE IF (Type = CONST(Item)) Item;

            trigger OnValidate();
            begin
                if Type <> Type::" " then
                    TESTFIELD("No.");

                case Type of
                    Type::Item:
                        begin
                            GetItem;
                            Item.TESTFIELD(Blocked, false);
                            Item.TESTFIELD("Inventory Posting Group");
                            Item.TESTFIELD("Gen. Prod. Posting Group");
                            Description := Item.Description;
                            "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
                            "VAT Prod. Posting Group" := Item."VAT Prod. Posting Group";
                        end;
                end;

                VALIDATE("Calculate per");
            end;
        }
        field(5; "Currency Code"; Code[10])
        {
            CaptionML = ENU = 'Currency Code',
                        FRA = 'Code devise';
            Editable = false;
            TableRelation = Currency;
        }
        field(6; "Starting Date"; Date)
        {
            CaptionML = ENU = 'Start Date',
                        FRA = 'Date début';
            Editable = false;
        }
        field(7; "Ending Date"; Date)
        {
            CaptionML = ENU = 'Ending Date',
                        FRA = 'Date fin';
            Editable = false;
        }
        field(9; Description; Text[30])
        {
            CaptionML = ENU = 'Description',
                        FRA = 'Désignation';
        }
        field(12; "Unit of Measure Code"; Code[10])
        {
            CaptionML = ENU = 'Unit of Measure Code',
                        FRA = 'Code unité';
            TableRelation = "Unit of Measure";
        }
        field(100; "Sales Type"; Option)
        {
            CaptionML = ENU = 'Sales Type',
                        FRA = 'Type vente';
            Editable = false;
            OptionCaptionML = ENU = 'Customer,Customer Promotion Group,All Customers',
                              FRA = 'Client,Groupe Promotion Client,Tous les clients';
            OptionMembers = Customer,"Customer Promotion Group","All Customers";
        }
        field(101; "Sales Code"; Code[20])
        {
            CaptionML = ENU = 'Sales Code',
                        FRA = 'Code vente';
            Editable = false;
            // TableRelation = IF ("Sales Type" = CONST("Customer Promotion Group")) "Drink Promotion Group".Code WHERE("Source Type" = CONST(Customer)) ELSE IF ("Sales Type" = CONST(Customer)) Customer;     //   BC Upgrade KUMARS145 Drinkit field relation commented dependency on table  #2013762	Drink Promotion Group.

        }
        field(102; "Variant Code"; Code[10])
        {
            CaptionML = ENU = 'Variant Code',
                        FRA = 'Code variante';
            TableRelation = IF ("Source Type" = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("Source No."));
        }
        field(103; "Location Code"; Code[10])
        {
            CaptionML = ENU = 'Location Code',
                        FRA = 'Code magasin';
            Editable = false;
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(105; "Shipment Method Code"; Code[10])
        {
            CaptionML = ENU = 'Shipment Method Code',
                        FRA = 'Code condition livraison';
            Editable = false;
            TableRelation = "Shipment Method";
        }
        field(200; "Calculate per"; Option)
        {
            CaptionML = ENU = 'Calculate per',
                        FRA = 'Calculer par';
            Editable = false;
            OptionCaptionML = ENU = 'Item,Order,Period,Delayed Order',
                              FRA = 'Article,Order,Périodique';
            OptionMembers = Item,"Order",Period,DelayOrder;
        }
        field(202; "Minimum Quantity"; Decimal)
        {
            CaptionML = ENU = 'Minimum Quantity',
                        FRA = 'Quantité minimum';
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate();
            begin
                if "Minimum Quantity" = 0 then
                    "Multiple Quantity" := 0;
            end;
        }
        field(203; "Minimum Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU = 'Minimum Amount',
                        FRA = 'Montant minimum';
            MinValue = 0;
        }
        field(208; "Minimum Quantity in HL"; Decimal)
        {
            CaptionClass = GetUomCaptionClass(FIELDNO("Minimum Quantity in HL"));
            CaptionML = ENU = 'Minimum',
                        FRA = 'Minimum';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(301; "Multiple Quantity"; Decimal)
        {
            CaptionML = ENU = 'Multiple Quantity',
                        FRA = 'Quantié multiple';
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate();
            begin
                if "Multiple Quantity" <> 0 then
                    TESTFIELD("Minimum Quantity");
            end;
        }
        field(303; "Gen. Prod. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group',
                        FRA = 'Group compta. produit';
            Editable = false;
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate();
            var
                GenProdPostingGrp: Record "Gen. Product Posting Group";
            begin
                if xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then
                    if GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp, "Gen. Prod. Posting Group") then
                        VALIDATE("VAT Prod. Posting Group", GenProdPostingGrp."Def. VAT Prod. Posting Group")
                    else
                        VALIDATE("VAT Prod. Posting Group", '');
            end;
        }
        field(304; "VAT Prod. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'VAT Prod. Posting Group',
                        FRA = 'Groupe compta. produit TVA';
            Editable = false;
            TableRelation = "VAT Product Posting Group";
        }
        field(999; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.',
                        FRA = 'N° ligne';
            Editable = false;
        }
        field(80000; "Parent Source Type"; Option)
        {
            CaptionML = ENU = 'Parent Source Type',
                        FRA = 'Parent Source Type';
            Editable = false;
            OptionCaptionML = ENU = 'Item,Item Promotion Group,All Items,Multiple Sources',
                              FRA = 'Article,Groupe Promotion Article,Tous les articles,Multiple Sources';
            OptionMembers = Item,"Item Promotion Group","All Items","Multiple Sources";

            trigger OnValidate();
            begin
                if xRec."Source Type" <> "Source Type" then
                    VALIDATE("Source No.", '');
            end;
        }
        field(80001; "Parent Source No."; Code[20])
        {
            CaptionML = ENU = 'Parent Source No.',
                        FRA = 'Parent Source No.';
            Editable = false;
            TableRelation = IF ("Parent Source Type" = CONST(Item)) Item;

            trigger OnLookup();
            begin
                LookupSourceNo();
            end;
        }
    }

    keys
    {
        key(Key1; "Parent Source Type", "Parent Source No.", "Sales Type", "Sales Code", "Starting Date", "Currency Code", "Location Code", "Shipment Method Code", "Calculate per", Type, "No.", "Line No.")
        {
        }
        key(Key2; "Sales Type", "Sales Code", "Source Type", "Source No.", "Starting Date", "Currency Code", "Location Code", "Variant Code", "Unit of Measure Code", "Shipment Method Code", "Calculate per", Type, "No.", "Minimum Quantity", "Minimum Quantity in HL", "Minimum Amount")
        {
        }
        key(Key3; Type, "No.", "Sales Type", "Sales Code", "Source Type", "Source No.", "Starting Date", "Currency Code", "Location Code", "Variant Code", "Unit of Measure Code", "Shipment Method Code", "Minimum Quantity", "Minimum Quantity in HL", "Minimum Amount")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record Item;
        // TempItemCharges: Record "Sales Promotion Item Charge" temporary; //   BC Upgrade KUMARS145 Drinkit Table Record commented dependency on table  #2013766	Sales Promotion Item Charge.
        StdTxt: Record "Standard Text";
        Text000: TextConst ENU = '%1 cannot be after %2.', FRA = '%1 ne peut pas être après %2.';
        Text001: TextConst ENU = '%1 must be blank.', FRA = '%1 doit être blanc.';
        // DrinkPromotionGroup: Record "Drink Promotion Group"; //   BC Upgrade KUMARS145 Drinkit Table Record commented dependency on table  #2013762	Drink Promotion Group.
        Location: Record Location;
        Cust: Record Customer;
        GLSetup: Record "General Ledger Setup";
        ODT: DateFormula;
        Text002: TextConst ENU = '%1 must not be less than %2..', FRA = '%1 ne doit pas être inférieur(e) à %2.';
        Text003: TextConst ENU = '%1 must not be greater than %2..', FRA = '%1 ne doit pas être supérieur(e) à %2.';
        Text100: TextConst ENU = '<%1>', FRA = '<%1>';
        Text101: TextConst ENU = 'Dynamic', FRA = 'Dynamique';
        SalesPromItemChargeSub: Record "Sales Prom Item Charge Sub FND";

    procedure LookupSourceNo();
    begin
        case "Source Type" of
            "Source Type"::Item:
                begin
                    Item.RESET;
                    Item."No." := "Source No.";
                    if PAGE.RUNMODAL(0, Item) = ACTION::LookupOK then
                        VALIDATE("Source No.", Item."No.");
                end;
        end;
    end;

    local procedure GetUomCaptionClass(FieldNumber: Integer): Text[80];
    var
        lrInvtSetup: Record "Inventory Setup";
        lrecref: RecordRef;
        lrField: Record "Field";
    begin
        lrecref.GETTABLE(Rec);
        lrField.GET(lrecref.NUMBER, FieldNumber);

        if not lrInvtSetup.GET() then
            exit(lrField."Field Caption");

        // exit(lrInvtSetup.GetUnitOfMeasureCaptionClass() + lrField."Field Caption"); //   BC Upgrade KUMARS145 Drinkit Procedure call commented 
    end;


    local procedure GetItem();
    begin
        TESTFIELD("No.");
        if "No." <> Item."No." then
            Item.GET("No.");
    end;

    local procedure GetLocation(LocationCode: Code[10]);
    begin
        if LocationCode = '' then
            CLEAR(Location)
        else
            if Location.Code <> LocationCode then
                Location.GET(LocationCode);
    end;
}

