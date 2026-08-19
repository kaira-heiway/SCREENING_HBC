table 50097 "Request Order Line FND"
{
    // version HEI.04

    // HEI.01 FDD-BA-LOGGAP01 IBM NASTAA02 06.07.2018 # Request Order
    //   # New Table created
    // HEI.02 FDD-BA-LOGGAP01 IBM NASTAA02 09.10.2018 # Request Order
    //   # Added Decimal Places 0:5 for the Quantity fields
    // HEI.03 Defect #3388 IBM NASTAA02 30.10.2018 # Request Order - Multiple Adjustments
    //   # "Qty. per Unit of Measure" should be updated when modifying the "Unit of Measure Code"
    //   # New Fields created: 30 - "Total Actual Quantity"
    //                         31 - "Total Outstanding Quantity"
    // HEI.04 Defect #3453 IBM NASTAA02 06.11.2018 # Request Order - multiple corrections
    //   # Removed 'NotBlank' property for "From Code"
    //   # Removed check on "Release Request Order" for UserID when insert or modify a line
    // HEI.05 IBM.Ak added code on OnInsert to update From Code from Header;

    Caption = 'Request Order Line';

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Item No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Item;

            trigger OnValidate();
            begin
                if Item.GET("Item No.") then begin
                    VALIDATE(Description, Item.Description);
                    // VALIDATE("Unit of Measure Code",Item."Inventory Unit of Measure"); ////---BC Upgrade KAMNAY01 Item."Inventory Unit of Measure" DITW field 
                    ItemUnitOfMeasure.GET("Item No.", "Unit of Measure Code");
                    VALIDATE("Qty. per Unit of Measure", UOMMgt.GetQtyPerUnitOfMeasure(Item, "Unit of Measure Code"));
                end;
            end;
        }
        field(4; Description; Text[50])
        {
            Editable = false;
        }
        field(5; "Unit of Measure Code"; Text[10])
        {
            TableRelation = "Item Unit of Measure".Code where("Item No." = FIELD("Item No."));

            trigger OnValidate();
            begin
                //HEI.03>>
                if Item.GET("Item No.") then
                    VALIDATE("Qty. per Unit of Measure", UOMMgt.GetQtyPerUnitOfMeasure(Item, "Unit of Measure Code"));
                //HEI.03<<
            end;
        }
        field(6; "Requested Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate();
            var
                RequestLine2: Record "Request Order Line FND";
            begin
                RequestLine2.SETRANGE("Document No.", "Document No.");
                RequestLine2.SETRANGE("Item No.", "Item No.");
                RequestLine2.SETFILTER("Line No.", '<>%1', "Line No.");
                RequestLine2.SETFILTER("Requested Quantity", '<>%1', 0);
                if RequestLine2.FINDFIRST() then
                    ERROR(Text003, RequestLine2.FIELDCAPTION("Requested Quantity"), RequestLine2.FIELDCAPTION("Line No."),
                      RequestLine2."Line No.", RequestLine2."Requested Quantity");

                RequestHeader.GET("Document No.");
                if RequestHeader."Requester ID" <> USERID then
                    ERROR(Text005, RequestHeader.FIELDCAPTION("Requester ID"), RequestHeader."Requester ID",
                      FIELDCAPTION("Requested Quantity"), "Document No.");

                CalculateOutstandingQty();
            end;
        }
        field(7; "Actual Qty."; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate();
            begin
                CalculateOutstandingQty();
            end;
        }
        field(8; "Outstanding Qty."; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(9; "From-Code"; Code[10])
        {
            TableRelation = Location;

            trigger OnValidate();
            begin
                RequestHeader.GET("Document No.");
                if RequestHeader."To-Code" = "From-Code" then
                    ERROR(Text002, RequestHeader."To-Code", "From-Code", "Document No.");
            end;
        }
        field(20; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Quantity per Unit of Measure';
            Editable = false;
        }
        field(30; "Total Actual Quantity"; Decimal)
        {
            CalcFormula = Sum("Request Order Line FND"."Actual Qty." where("Document No." = FIELD("Document No."),
                                                                        "Item No." = FIELD("Item No.")));
            DecimalPlaces = 0 : 5;
            Description = 'HEI.03';
            FieldClass = FlowField;
        }
        field(31; "Total Outstanding Quantity"; Decimal)
        {
            CalcFormula = Sum("Request Order Line FND"."Outstanding Qty." where("Document No." = FIELD("Document No."),
                                                                             "Item No." = FIELD("Item No.")));
            DecimalPlaces = 0 : 5;
            Description = 'HEI.03';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        RequestHeader.GET("Document No.");
        RequestHeader.TESTFIELD(Status, RequestHeader.Status::Open);
        if RequestHeader."Requester ID" <> USERID then
            ERROR(Text004, RequestHeader.FIELDCAPTION("Requester ID"), RequestHeader."Requester ID", "Document No.");
    end;

    trigger OnInsert();
    begin
        if "Line No." = 0 then begin
            RequestLine.RESET();
            RequestHeader.GET("Document No.");
            RequestLine.SETRANGE("Document No.", RequestHeader."No.");
            if RequestLine.FINDLAST() then
                "Line No." := RequestLine."Line No." + 10000;
        end;

        //HEI.05>>
        if RequestHeader.GET("Document No.") then
            "From-Code" := RequestHeader."From-Code";
        //HEI.05<<
    end;

    trigger OnRename();
    begin
        ERROR(Text001, TABLECAPTION);
    end;

    var
        Item: Record Item;
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        RequestHeader: Record "Request Order Header FND";
        RequestLine: Record "Request Order Line FND";
        UserSetup: Record "User Setup";
        UOMMgt: Codeunit "Unit of Measure Management";
        Text002: Label '%1 and %2 cannot be the same in Request Order No. %3.';
        Text003: Label '%1 is already filled-in on %2 %3 with %4.';
        Text004: Label 'Only %1 %2 can delete a line in Request Order No. %3.';
        Text005: Label 'Only %1 %2 can change the %3 in Request Order No. %4.';
        Text001: TextConst ENU = 'You cannot rename a %1.', FRA = 'Vous ne pouvez pas renommer l''enregistrement %1.';

    local procedure CalculateOutstandingQty();
    begin
        "Outstanding Qty." := "Requested Quantity" - "Actual Qty.";
    end;
}

