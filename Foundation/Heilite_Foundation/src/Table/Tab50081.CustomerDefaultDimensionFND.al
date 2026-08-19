table 50081 "Customer Default Dimension FND"
{
    // version HEI.04

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 24.08.2017 # MDM Customer Card
    //   # Object created
    // HEI.02 FDD-SLSGAP001 IBM POENAB01 24.08.2017 # MDM Customer Card
    //   # Modified Table ID option
    //   # Modified code in OnInsert and OnDelete
    // HEI.03 FDD-SLSGAP001 IBM POENAB01 28.08.2017 # MDM Customer Card
    //   # Modified table relation for "Field ID"
    //   # Validate "Table ID"
    //   # Changed primary key
    // 
    // HEI.04 FDD-SLSGAP001 IBM NASTAA02 15.09.2017 # MDM Customer Card
    //   # New field "Dimension Code" added
    //   # Changed Data Type of "Field ID" from Code to Integer to be used for choosing a Field ID from Table 50089
    //   # Deleted not needed field "Code"

    Caption = 'Customer Default Dimension';

    fields
    {
        field(1; "Table ID"; Option)
        {
            Caption = 'Table ID';
            OptionCaption = 'Cust,Cust. Attributes';
            OptionMembers = Cust,"Cust. Attributes";

            trigger OnValidate();
            begin
                //<<HEI.03
                if Rec."Field ID" <> xRec."Field ID" then begin
                    "Field ID" := 0;
                    "Field Name" := '';
                end;
                //>>HEI.03
            end;
        }
        field(2; "Field ID"; Integer)
        {
            Caption = 'Field ID';
            Description = 'HEI.04';
            TableRelation = "MDM Customer Fields FND"."Field ID" where(TableNo = FIELD("Table ID"));

            trigger OnValidate();
            begin
                //<<HEI.04
                "Field Name" := GetFieldName("Field ID");
                //>>HEI.04
            end;
        }
        field(4; "Field Name"; Text[30])
        {
            Caption = 'Field Name';
            Editable = false;
            FieldClass = Normal;
        }
        field(5; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            Description = 'HEI.04';
            NotBlank = true;
            TableRelation = Dimension;
        }
    }

    keys
    {
        key(Key1; "Field ID", "Field Name")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        //<<HEI.02
        //"Field Id" := GetFieldName("Field ID");
        "Field Name" := GetFieldName("Field ID");
        //>>HEI.02
    end;

    trigger OnModify();
    begin
        //<<HEI.02
        //"Field Id" := GetFieldName("Field ID");
        "Field Name" := GetFieldName("Field ID");
        //>>HEI.02
    end;

    trigger OnRename();
    begin
        //<<HEI.03
        "Field Name" := GetFieldName("Field ID");
        //>>HEI.03
    end;

    var
        FieldTbl: Record "Field";

    local procedure GetFieldName(FieldID: Integer): Text;
    var
        lFieldTbl: Record "Field";
        FieldIdInt: Integer;
    begin
        lFieldTbl.RESET();
        if FieldID <> 0 then begin
            if "Table ID" = "Table ID"::Cust then begin
                lFieldTbl.SETRANGE(TableNo, 18);
                //>>HEI.04
                //EVALUATE(FieldIdInt,FieldID);
                FieldIdInt := FieldID;
                //<<HEI.04
                lFieldTbl.SETRANGE("No.", FieldIdInt);
                if lFieldTbl.FINDFIRST() then
                    exit(lFieldTbl.FieldName);
            end;
            if "Table ID" = "Table ID"::"Cust. Attributes" then begin
                lFieldTbl.SETRANGE(TableNo, 50072);
                //>>HEI.04
                //EVALUATE(FieldIdInt,FieldID);
                FieldIdInt := FieldID;
                //<<HEI.04
                lFieldTbl.SETRANGE("No.", FieldIdInt);
                if lFieldTbl.FINDFIRST() then
                    exit(lFieldTbl.FieldName);
            end;
        end;

        exit('');
    end;
}

