table 50017 "Source Code Dimension FND"
{
    // version HEI.01

    // HEI.01 BPMGAP015 IBM SOICAD01 11.07.2017 EBF Matrix & Movement Type
    //   #new table created


    fields
    {
        field(1; "GL Account No."; Code[20])
        {
            TableRelation = "G/L Account"."No." where("Account Type" = FILTER(Posting));
        }
        field(2; "Source Code"; Code[10])
        {
            TableRelation = "Source Code";
        }
        field(3; "Dimension Code"; Code[20])
        {
            TableRelation = Dimension;
        }
        field(4; "Dimension Value Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Dimension Code"));
        }
        field(5; "Dimension Value ID"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "GL Account No.", "Source Code", "Dimension Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        UpdateDimID();
    end;

    trigger OnModify();
    begin
        UpdateDimID();
    end;

    trigger OnRename();
    begin
        UpdateDimID();
    end;

    local procedure UpdateDimID();
    var
        DimValue: Record "Dimension Value";
    begin
        if DimValue.GET("Dimension Code", "Dimension Value Code") then
            "Dimension Value ID" := DimValue."Dimension Value ID";
    end;
}

