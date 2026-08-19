table 50354 "Standard Text Report FND"
{
    // version DITW17.00.01

    // HEI.01 FDD-HT637 IBM NASTAA02 13.01.2020 # Invoice Cr Memo Proforma Inv LaReunion
    //   # Added new option 'Header' to Field 3 - "Position Text"
    //   # New Field created 50000 - "Image"

    // BC Upgrade SHUKLP03 >> Created new table for standard text report.

    CaptionML = ENU = 'Standard Text Report',
                FRA = 'Texte standard - Etats';
    DrillDownPageID = "Standard Text Report List FND";
    LookupPageID = "Standard Text Report List FND";

    fields
    {
        field(1; "Report ID"; Integer)
        {
            CaptionML = ENU = 'Report ID',
                        FRA = 'ID état';
            MinValue = 1;
            NotBlank = true;
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Report));

            trigger OnValidate();
            begin
                CALCFIELDS("Report Name");
            end;
        }
        field(2; "Standard Text Code"; Code[10])
        {
            CaptionML = ENU = 'Standard Text Code',
                        FRA = 'Code texte standard';
            NotBlank = true;
            TableRelation = "Standard Text";

            trigger OnValidate();
            begin
                CALCFIELDS("Standard Text Description");
            end;
        }
        field(3; "Position Text"; Option)
        {
            CaptionML = ENU = 'Position',
                        FRA = 'Position';
            Description = 'HEI.01';
            OptionCaptionML = ENU = 'Line,Footer,Header',
                              FRA = 'Ligne,Bas de page';
            OptionMembers = Line,Footer,Header;
        }
        field(4; Sequence; Integer)
        {
            CaptionML = ENU = 'Sequence',
                        FRA = 'Séquence';
            MinValue = 0;
        }
        field(10; "Report Name"; Text[249])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Report),
                                                                           "Object ID" = FIELD("Report ID")));
            CaptionML = ENU = 'Report Name',
                        FRA = 'Nom état';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Standard Text Description"; Text[100])
        {
            CalcFormula = Lookup("Standard Text".Description WHERE(Code = FIELD("Standard Text Code")));
            CaptionML = ENU = 'Standard Text Description',
                        FRA = 'Description texte standard';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000; Image; BLOB)
        {
            CaptionML = ENU = 'Image',
                        FRA = 'Image';
            Description = 'HEI.01';
            SubType = Bitmap;
        }
    }

    keys
    {
        key(Key1; "Report ID", "Position Text", Sequence)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        TESTFIELD("Report ID");
        TESTFIELD("Standard Text Code");
    end;

    trigger OnModify();
    begin
        TESTFIELD("Standard Text Code");
    end;

    trigger OnRename();
    begin
        TESTFIELD("Report ID");
    end;
}

