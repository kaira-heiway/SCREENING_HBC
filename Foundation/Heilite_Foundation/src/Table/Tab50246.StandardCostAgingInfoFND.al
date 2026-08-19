table 50246 "Standard Cost Aging Info FND"
{
    // version HEI.06

    // HEI.01 CHG2167977 NORRIQ KOROLA04 18.08.2022
    //   #Table created
    // 
    // HEI.02 CHG2167977 NORRIQ KOROLA04 30.08.2022
    //   #CreateLogEntry() - modified
    // 
    // HEI.03 CHG2167977 NORRIQ KOROLA04 06.09.2022
    //   #CreateLogEntry() - modified
    //   #new table Index Location Code,Item No. added
    // HEI.04 CHG2207110 SAHAL01 27.06.2023 Update Standard Cost Aging Info table with blocked/unblocked information
    //   # Created New Fields: 9 - Block or Unblock Date
    //   # Added Code
    // HEI.05 CHG2237893 PRASAA03 21.03.2024 Std cost aging info / add new filters
    //   # Created New Fields: 10 - Old Standard Cost
    //   # Created New Fields: 11 - New Standard Cost
    //   # Created New Fields: 12 - User ID
    //   # Updated Create Log entry function
    // HEI.06 CHG2237893 PRASAA03 01.04.2024 Std cost aging info / add new filters
    //   # Increased Decimal Places to 5 for Field: 10 - Old Standard Cost
    //   # Increased Decimal Places to 5 for Field: 11 - New Standard Cost


    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(3; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(4; "Item Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Item Category Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Category";
        }
        field(6; Blocked; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                //HEI.04>>
                "Block or Unblock Date" := TODAY;
                //HEI.04<<
            end;
        }
        field(7; "Date of Change"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Legal Entity"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Block or Unblock Date"; Date)
        {
            Caption = 'Block or Unblock Date';
            Description = 'HEI.04';
            Editable = false;
        }
        field(10; "Old Standard Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = '//HEI.05//HEI.06';
        }
        field(11; "New Standard Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = '//HEI.05//HEI.06';
        }
        field(12; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = '//HEI.05';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Location Code", "Item No.")
        {
        }
    }

    fieldgroups
    {
    }

    procedure CreateLogEntry(var SKU: Record "Stockkeeping Unit"; var XSku: Record "Stockkeeping Unit");
    var
        CompanyInfo: Record "Company Information";
        Item: Record Item;
    begin
        //HEI.05 Added Xsku parameter to the functions
        //HEI.01 >>
        if not Item.GET(SKU."Item No.") then
            exit;

        if Item."Costing Method" <> Item."Costing Method"::Standard then
            exit;

        CompanyInfo.GET();//HEI.02

        //HEI.03 >>
        Rec.RESET();
        Rec.SETCURRENTKEY("Location Code", "Item No.");
        Rec.SETRANGE("Location Code", SKU."Location Code");
        Rec.SETRANGE("Item No.", SKU."Item No.");
        if not Rec.ISEMPTY then
            Rec.DELETEALL();

        Rec.RESET();
        CLEAR(Rec);
        //HEI.03 >>

        Rec."Entry No." := 0;
        Rec."Location Code" := SKU."Location Code";
        Rec."Item No." := Item."No.";
        Rec."Item Description" := Item.Description;
        Rec."Item Category Code" := Item."Item Category Code";
        Rec.Blocked := Item.Blocked;
        //HEI.04>>
        "Block or Unblock Date" := TODAY;
        //HEI.04<<
        Rec."Date of Change" := TODAY;
        Rec."Legal Entity" := CompanyInfo."Legal Entity Code FND";//HEI.02
        //HEI.05>>
        Rec."Old Standard Cost" := ROUND(XSku."Standard Cost", 0.00001);//HEI.06
        Rec."New Standard Cost" := ROUND(SKU."Standard Cost", 0.00001);//HEI.06
        Rec."User ID" := USERID;
        //HEI.05<<
        Rec.INSERT(true);
    end;
}

