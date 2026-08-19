tableextension 50000 ShipmentMethodExtFND extends "Shipment Method"
{
    // version NAVW17.00,DITW110.00.11

    fields
    {
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';

            // BC Upgrade NANDIS03 >>
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.01>>
                CompanyInfo.GET();
                IF CompanyInfo."Enable French Localization FND" THEN
                    IF ValidateShipmentMethod() THEN
                        MESSAGE(Text10800);
                //HEI.01<<
            end;
            // BC Upgrade NANDIS03 <<
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }

        //Unsupported feature: CodeInsertion on "Code(Field 1)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //HEI.01>>
        CompanyInfo.GET;
        if CompanyInfo."Enable French Localization" then
          if ValidateShipmentMethod then
            MESSAGE(Text10800);
        //HEI.01<<
        */
        //end;
        // field(2014090; "Shipping Agent"; Code[10])
        // {
        //     CaptionML = ENU = 'Shipping Agent',
        //                 FRA = 'Transporteur';
        //     Description = 'DITW17.00.02 DIT-770 #154';
        //     TableRelation = "Shipping Agent";
        // }
        // field(2014091; "Shipping Agent Service Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Shipping Agent Service Code',
        //                 FRA = 'Code prestation transporteur';
        //     Description = 'DITW17.00.02 DIT-770 #154';
        //     TableRelation = "Shipping Agent Services".Code where("Shipping Agent Code" = FIELD("Shipping Agent"));
        // }
        // field(2014092; "Payment Terms"; Code[10])
        // {
        //     CaptionML = ENU = 'Payment Terms',
        //                 FRA = 'Conditions de paiement';
        //     Description = 'DITW17.00.02 DIT-770 #154';
        //     TableRelation = "Payment Terms";
        // }
        // field(2014093; "Payment Method"; Code[10])
        // {
        //     CaptionML = ENU = 'Payment Method',
        //                 FRA = 'Mode de règlement';
        //     Description = 'DITW17.00.02 DIT-770 #154';
        //     TableRelation = "Payment Method";
        // }
        // field(2035390; Pickup; Boolean)
        // {
        //     Caption = 'Pickup';
        //     Description = 'DITW110.00.11 NRQ#43605';
        // }  // BC Upgrade NANDIS03
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH ShipmentTermsTranslation DO BEGIN
      SETRANGE("Shipment Method",Code);
      DELETEALL
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    with ShipmentTermsTranslation do begin
      SETRANGE("Shipment Method",Code);
      DELETEALL
    end;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        CompanyInfo: Record "Company Information";
        Text10800: TextConst ENU = 'The French Intrastat feature requires a Shipment Method Code of 3 letters and 1 number.', FRA = 'La fonction des états D.E.B. français nécessite un code condition livraison de 3 lettres et 1 chiffre.';

    // BC Upgrade NANDIS03 >>
    procedure ValidateShipmentMethod(): Boolean
    var
        I: Integer;
    begin
        //HEI.01>>
        CompanyInfo.GET();
        IF NOT CompanyInfo."Enable French Localization FND" THEN
            EXIT;

        IF STRLEN(Code) <> 4 THEN
            EXIT(TRUE);
        FOR I := 1 TO 3 DO
            IF Code[I] IN ['a' .. 'z', 'A' .. 'Z'] = FALSE THEN
                EXIT(TRUE);
        IF Code[4] IN ['0' .. '9'] = FALSE THEN
            EXIT(TRUE);
        EXIT(FALSE);
        //HEI.01<<
    end;
    // BC Upgrade NANDIS03 <<
}

