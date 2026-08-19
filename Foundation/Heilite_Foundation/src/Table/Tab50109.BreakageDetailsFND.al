table 50109 "Breakage Details FND"
{
    // version HEI.01

    // HEI.01 FDD_RW-SLSGAP02  IBM ISYED0110.10.2018
    //   - Rwanda_Bralirwa_Sales Credit Memo Layout_V0.2_HT60
    //     # Created new table for Sales Cr memo Breakage.


    fields
    {
        field(1; "Document No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Line No."; Integer)
        {
            Editable = false;
        }
        field(3; Type; Option)
        {
            Editable = false;
            OptionCaptionML = ENU = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)',
                              FRA = ' ,Compte général,Article,Ressource,Immobilisation,Frais annexes';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(4; "No."; Code[10])
        {
            Editable = false;

            trigger OnValidate();
            begin
                Item.GET("No.");

                ActiveVersionCode := VersionMgt.GetBOMVersion(Item."Production BOM No.", WORKDATE(), true);
                ProdBOMComponent.RESET();
                ProdBOMComponent.SETRANGE("Production BOM No.", Item."Production BOM No.");
                ProdBOMComponent.SETRANGE("Version Code", ActiveVersionCode);
                if ProdBOMComponent.findset() then
                    repeat
                        if ProdBOMComponent.Type = ProdBOMComponent.Type::Item then begin
                            Item.GET(ProdBOMComponent."No.");

                            /*Item.CALCFIELDS("Empty Good");  
                            if Item."Empty Good" then begin
                             if ProdBOMComponent.Quantity = 1 then begin
                               "Empty Crate Item Code" := ProdBOMComponent."No.";
                             end else begin
                               "Empty Bottle Item Code" := ProdBOMComponent."No.";
                               "Empty Bottle Qty Per" := ProdBOMComponent.Quantity;
                             end;
                            end;*/  // BC Upgrade NANDIS03
                        end;
                    until ProdBOMComponent.NEXT() = 0;
            end;
        }
        field(5; Description; Text[50])
        {
            Editable = false;
        }
        field(6; "Location Code"; Code[10])
        {
            Editable = false;
        }
        field(7; "Empty Crate"; Decimal)
        {
        }
        field(8; "Empty Bottle Item Code"; Code[20])
        {
        }
        field(9; "Empty Bottle"; Decimal)
        {
        }
        field(10; "Crate Missing"; Decimal)
        {
        }
        field(11; "Bottle Broken"; Decimal)
        {

            trigger OnValidate();
            begin
                TESTFIELD("Empty Bottle Item Code");
            end;
        }
        field(12; "Bottle Chipped"; Decimal)
        {

            trigger OnValidate();
            begin
                TESTFIELD("Empty Bottle Item Code");
            end;
        }
        field(13; "Bottle Missing"; Decimal)
        {

            trigger OnValidate();
            begin
                TESTFIELD("Empty Bottle Item Code");
            end;
        }
        field(14; "Empty Crate Item Code"; Code[20])
        {
        }
        field(15; "Empty Bottle Qty Per"; Decimal)
        {

            trigger OnValidate();
            begin
                TESTFIELD("Empty Bottle Item Code");
            end;
        }
        field(16; "Credit Memo No."; Code[20])
        {
        }
        field(17; "Credit Memo Line No."; Integer)
        {
        }
        field(18; "Return Receipt No."; Code[20])
        {
        }
        field(19; "Return Receipt Line No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.", Type, "No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record Item;
        ProdBOMComponent: Record "Production BOM Line";
        SalesLine: Record "Sales Line";
        VersionMgt: Codeunit VersionManagement;
        ActiveVersionCode: Code[10];
}

