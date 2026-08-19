table 50035 "Purchase Line Price FND"
{
    // version HEI.03

    // HEI.01 HLSRM02 IBM LAZARE02 28.07.2017 # New table
    // HEI.02 CHG2062226 IBM NANDIS01 29.04.2020 Posting Invoice is not possible
    //   # the price check should not work for Invoice and Credit memo
    // HEI.03 CHG2142122 HB2673 IBM NANDIS01 13.04.2022 #Display description on PO Line from document shipping cost with data from posted sales shipment
    //   #Purchase Price should check only for Valid To as the contract validity is already being checked before price


    // BC Upgrade PATELS08 >>
    // # Field "Document Type" has been changed from Option to Enum data type to align with the "Document Type" (Enum) field in the Purchase Header table.
    // # Blocked 'With' Statement in GetPurchPrice, FindPurchPrice and BlanketOrderPriceExists procedures as 'With' is deprecated and prefix all variables with their respective table names to avoid ambiguity.
    // BC Upgrade PATELS08 <<

    Caption = 'Purchase Line Price';

    fields
    {
        // BC Upgrade PATELS08 >> # Changed field type from Option to Enum data type to align with the "Document Type" (Enum) field in the Purchase Header table.
        // field(1; "Document Type"; Option)
        // {
        //     Caption = 'Document Type';
        //     OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
        //     OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        // }
        field(1; "Document Type"; Enum "Purchase Document Type")
        {
            Caption = 'Document Type';
        }
        // BC Upgrade PATELS08 <<
        field(2; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            Editable = false;
            TableRelation = Vendor;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Purchase Header"."No." where("Document Type" = FIELD("Document Type"));
        }
        field(4; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
        }
        field(10; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

            trigger OnValidate();
            begin
                if ("Starting Date" > "Ending Date") and ("Ending Date" <> 0D) then
                    ERROR(Text000, FIELDCAPTION("Starting Date"), FIELDCAPTION("Ending Date"));
            end;
        }
        field(11; "Ending Date"; Date)
        {
            Caption = 'Ending Date';

            trigger OnValidate();
            begin
                VALIDATE("Starting Date");
            end;
        }
        field(12; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = CONST(false));
        }
        field(13; "Minimum Quantity"; Decimal)
        {
            Caption = 'Minimum Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(14; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code where("Item No." = FIELD("Item No."));
        }
        field(15; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(16; "Direct Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Direct Unit Cost';
            MinValue = 0;
        }
        field(17; "Direct Unit Cost Multiplier"; Decimal)
        {
            Caption = 'Direct Unit Cost Multiplier';
            MinValue = 0;
        }
        field(18; "Direct Cost Per Multiplier"; Decimal)
        {
            Caption = 'Direct Cost Per Multiplier';
            MinValue = 0;
        }
        field(20; "SRM Contract No."; Code[10])
        {
            CalcFormula = Lookup("Purchase Line"."SRM Contract No. FND" where("Document Type" = FIELD("Document Type"),
                                                                           "Document No." = FIELD("Document No.")));
            Caption = 'SRM Contract No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "SRM Contract Line No."; Code[10])
        {
            CalcFormula = lookup("Purchase Line"."SRM Contract Line No. FND" where("Document Type" = FIELD("Document Type"),
                                                                                "Document No." = FIELD("Document No."),
                                                                                "Line No." = FIELD("Document Line No.")));
            Caption = 'SRM Contract Line No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Document Line No.", "Starting Date", "Location Code", "Currency Code", "Unit of Measure Code", "Minimum Quantity")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Currency: Record Currency;
        GLSetup: Record "General Ledger Setup";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        NoPriceFoundErr: Label 'No price could be found for %1 %2 in contract %3.';
        Text000: Label '%1 cannot be after %2';

    procedure GetPurchPrice(PurchaseLine2: Record "Purchase Line"; ShowPriceError: Boolean): Decimal;
    var
        Item: Record Item;
        TempPurchLinePrice: Record "Purchase Line Price FND" temporary;
        Vend: Record Vendor;
        LastStartingDate: Date;
        PurchPrice: Decimal;
    begin
        PurchaseLine := PurchaseLine2;
        PurchaseHeader.GET(PurchaseLine."Document Type", PurchaseLine."Document No.");
        if PurchaseHeader."Currency Code" <> '' then
            Currency.GET(PurchaseHeader."Currency Code");
        GLSetup.GET();

        FindPurchPrice(TempPurchLinePrice);

        Vend.GET(PurchaseLine."Buy-from Vendor No.");
        Item.GET(PurchaseLine."No.");

        // BC Upgrade PATELS08 >> # Blocked 'With' Statement as it is deprecated and prefixed variables with 'TempPurchLinePrice'
        // with TempPurchLinePrice do begin
        // RESET();
        // if FINDSET() then
        TempPurchLinePrice.RESET();
        if TempPurchLinePrice.FINDSET() then
            repeat
                //     if IsInMinQty("Unit of Measure Code", "Minimum Quantity") then begin
                //         ConvertPriceToVAT(
                //           Vend."Prices Including VAT", Item."VAT Prod. Posting Group",
                //           Vend."VAT Bus. Posting Group", "Direct Unit Cost");
                //         ConvertPriceToUoM("Unit of Measure Code", "Direct Unit Cost");
                //         ConvertPriceLCYToFCY("Currency Code", "Direct Unit Cost");

                //         if "Starting Date" >= LastStartingDate then begin
                //             PurchPrice := "Direct Unit Cost";
                //             LastStartingDate := "Starting Date";
                //         end;
                //     end
                // until NEXT() = 0;
                if IsInMinQty(TempPurchLinePrice."Unit of Measure Code", TempPurchLinePrice."Minimum Quantity") then begin
                    ConvertPriceToVAT(
                      Vend."Prices Including VAT", Item."VAT Prod. Posting Group",
                      Vend."VAT Bus. Posting Group", TempPurchLinePrice."Direct Unit Cost");
                    ConvertPriceToUoM(TempPurchLinePrice."Unit of Measure Code", TempPurchLinePrice."Direct Unit Cost");
                    ConvertPriceLCYToFCY(TempPurchLinePrice."Currency Code", TempPurchLinePrice."Direct Unit Cost");

                    if TempPurchLinePrice."Starting Date" >= LastStartingDate then begin
                        PurchPrice := TempPurchLinePrice."Direct Unit Cost";
                        LastStartingDate := TempPurchLinePrice."Starting Date";
                    end;
                end
            until TempPurchLinePrice.NEXT() = 0;
        // BC Upgrade PATELS08 <<
        //HEI.02>>
        if (PurchaseLine."Document Type" <> PurchaseLine."Document Type"::Invoice) and
                (PurchaseLine."Document Type" <> PurchaseLine."Document Type"::"Credit Memo") then
            //HEI.02<<
            if ShowPriceError and (PurchaseLine."SRM Contract No. FND" <> '') and (PurchPrice = 0) then
                ERROR(NoPriceFoundErr, PurchaseLine.Type, PurchaseLine."No.", PurchaseLine."SRM Contract No. FND");
        exit(PurchPrice);

        // BC Upgrade PATELS08 >> # Blocked 'end' of 'with' statement as it is deprecated.
        // end;
        // BC Upgrade PATELS08 <<


        exit(0);
    end;

    local procedure FindPurchPrice(var ToPurchLinePrice: Record "Purchase Line Price FND");
    var
        FromPurchLinePrice: Record "Purchase Line Price FND";
    begin

        // BC Upgrade PATELS08 >> # Blocked with statement as it is deprecated.
        // with FromPurchLinePrice do begin 
        // BC Upgrade PATELS08 <<
        // SETRANGE("Document Type", "Document Type"::"Blanket Order");
        // SETRANGE("Document No.", PurchaseLine."Blanket Order No.");
        // SETRANGE("Document Line No.", PurchaseLine."Blanket Order Line No.");
        // SETRANGE("Starting Date", 0D, PurchaseHeader."Document Date");
        // SETFILTER("Ending Date", '%1|>=%2', 0D, PurchaseHeader."Document Date");
        // SETFILTER("Location Code", '%1|%2', PurchaseLine."Location Code", '');
        // SETRANGE("Currency Code", PurchaseLine."Currency Code");
        // SETFILTER("Unit of Measure Code", '%1|%2', PurchaseLine."Unit of Measure Code", '');

        FromPurchLinePrice.SETRANGE("Document Type", FromPurchLinePrice."Document Type"::"Blanket Order");
        FromPurchLinePrice.SETRANGE("Document No.", PurchaseLine."Blanket Order No.");
        FromPurchLinePrice.SETRANGE("Document Line No.", PurchaseLine."Blanket Order Line No.");
        FromPurchLinePrice.SETRANGE("Starting Date", 0D, PurchaseHeader."Document Date");
        FromPurchLinePrice.SETFILTER("Ending Date", '%1|>=%2', 0D, PurchaseHeader."Document Date");
        FromPurchLinePrice.SETFILTER("Location Code", '%1|%2', PurchaseLine."Location Code", '');
        FromPurchLinePrice.SETRANGE("Currency Code", PurchaseLine."Currency Code");
        FromPurchLinePrice.SETFILTER("Unit of Measure Code", '%1|%2', PurchaseLine."Unit of Measure Code", '');

        ToPurchLinePrice.RESET();
        ToPurchLinePrice.DELETEALL();
        // BC Upgrade PATELS08 >> # Added Prefix 'FromPurchLinePrice' as 'with' statement is blocked.
        // if FINDSET() then
        if FromPurchLinePrice.FINDSET() then
            // BC Upgrade PATELS08 <<
                repeat
                    // BC Upgrade PATELS08 >> # Added Prefix 'FromPurchLinePrice' as 'with' statement is blocked.
                    // if "Direct Unit Cost" <> 0 then begin
                    if FromPurchLinePrice."Direct Unit Cost" <> 0 then begin
                        // BC Upgrade PATELS08 <<
                        ToPurchLinePrice := FromPurchLinePrice;
                        ToPurchLinePrice.INSERT();
                    end;
            // BC Upgrade PATELS08 >> # Added Prefix 'FromPurchLinePrice' as 'with' statement is blocked.
            // until NEXT() = 0;
            until FromPurchLinePrice.NEXT() = 0;
        // BC Upgrade PATELS08 <<

        //  BC Upgrade PATELS08 >> # Blocked 'end' of  'with' statement as it is deprecated.
        //end;
        // BC Upgrade PATELS08 <<
    end;

    procedure BlanketOrderPriceExists(BlanketPurchaseLine: Record "Purchase Line"): Boolean;
    var
        BlanketPurchaseHeader: Record "Purchase Header";
        FromPurchLinePrice: Record "Purchase Line Price FND";
    begin
        BlanketPurchaseHeader.GET(BlanketPurchaseLine."Document Type", BlanketPurchaseLine."Document No.");

        // BC Upgrade PATELS08 >> # Blocked 'With' Statement as it is deprecated and prefixed variables with 'FromPurchLinePrice'
        // with FromPurchLinePrice do begin
        // SETRANGE("Document Type", "Document Type"::"Blanket Order");
        // SETRANGE("Document No.", BlanketPurchaseLine."Document No.");
        // SETRANGE("Document Line No.", BlanketPurchaseLine."Line No.");
        FromPurchLinePrice.SETRANGE("Document Type", FromPurchLinePrice."Document Type"::"Blanket Order");
        FromPurchLinePrice.SETRANGE("Document No.", BlanketPurchaseLine."Document No.");
        FromPurchLinePrice.SETRANGE("Document Line No.", BlanketPurchaseLine."Line No.");
        // BC Upgrade PATELS08 <<

        //HEI.03>>
        //SETRANGE("Starting Date",0D,BlanketPurchaseHeader."Document Date");
        //HEI.03<<

        // BC Upgrade PATELS08 >> # Added Prefix 'FromPurchLinePrice' as 'with' statement is blocked.
        // SETFILTER("Ending Date", '%1|>=%2', 0D, BlanketPurchaseHeader."Document Date");
        // SETFILTER("Location Code", '%1|%2', BlanketPurchaseLine."Location Code", '');
        // SETRANGE("Currency Code", BlanketPurchaseLine."Currency Code");
        // SETFILTER("Unit of Measure Code", '%1|%2', BlanketPurchaseLine."Unit of Measure Code", '');
        // if FINDSET() then
        //     repeat
        //         if "Direct Unit Cost" <> 0 then
        //             exit(true);
        //     until NEXT() = 0;

        FromPurchLinePrice.SETFILTER("Ending Date", '%1|>=%2', 0D, BlanketPurchaseHeader."Document Date");
        FromPurchLinePrice.SETFILTER("Location Code", '%1|%2', BlanketPurchaseLine."Location Code", '');
        FromPurchLinePrice.SETRANGE("Currency Code", BlanketPurchaseLine."Currency Code");
        FromPurchLinePrice.SETFILTER("Unit of Measure Code", '%1|%2', BlanketPurchaseLine."Unit of Measure Code", '');
        if FromPurchLinePrice.FINDSET() then
            repeat
                if FromPurchLinePrice."Direct Unit Cost" <> 0 then
                    exit(true);
            until FromPurchLinePrice.NEXT() = 0;
        // BC Upgrade PATELS08 <<

        // BC Upgrade PATELS08 >> # Blocked 'end' of 'with' statement as it is deprecated.
        // end;
        // BC Upgrade PATELS08 <<
        exit(false);
    end;

    local procedure IsInMinQty(UnitofMeasureCode: Code[10]; MinQty: Decimal): Boolean;
    begin
        if UnitofMeasureCode = '' then
            exit(MinQty <= PurchaseLine."Quantity (Base)");
        exit(MinQty <= PurchaseLine.Quantity);
    end;

    local procedure ConvertPriceToVAT(FromPriceInclVAT: Boolean; FromVATProdPostingGr: Code[10]; FromVATBusPostingGr: Code[10]; var UnitPrice: Decimal);
    var
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        if FromPriceInclVAT then begin
            if not VATPostingSetup.GET(FromVATBusPostingGr, FromVATProdPostingGr) then
                VATPostingSetup.INIT();

            if PurchaseHeader."Prices Including VAT" then begin
                if PurchaseLine."VAT Bus. Posting Group" <> FromVATBusPostingGr then
                    UnitPrice := UnitPrice * (100 + PurchaseLine."VAT %") / (100 + VATPostingSetup."VAT %");
            end else
                UnitPrice := UnitPrice / (1 + VATPostingSetup."VAT %" / 100);
        end else
            if PurchaseHeader."Prices Including VAT" then
                UnitPrice := UnitPrice * (1 + PurchaseLine."VAT %" / 100);
    end;

    local procedure ConvertPriceToUoM(UnitOfMeasureCode: Code[10]; var UnitPrice: Decimal);
    begin
        if UnitOfMeasureCode = '' then
            UnitPrice := UnitPrice * PurchaseLine."Qty. per Unit of Measure";
    end;

    local procedure ConvertPriceLCYToFCY(CurrencyCode: Code[10]; var UnitPrice: Decimal);
    var
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        if PurchaseHeader."Currency Code" <> '' then begin
            if CurrencyCode = '' then
                UnitPrice :=
                  CurrExchRate.ExchangeAmtLCYToFCY(PurchaseHeader."Posting Date", Currency.Code, UnitPrice, PurchaseHeader."Currency Factor");
            UnitPrice := ROUND(UnitPrice, Currency."Unit-Amount Rounding Precision");
        end else
            UnitPrice := ROUND(UnitPrice, GLSetup."Unit-Amount Rounding Precision");
    end;
}

