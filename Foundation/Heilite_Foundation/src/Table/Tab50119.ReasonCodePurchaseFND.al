table 50119 "Reason Code_Purchase FND"
{
    // version NAVW19.00

    // HEI.01 RFC-CHG0246348 IBM.AB 08.10.2018
    //   # New table created for Reason Codes related to Purchase only

    CaptionML = ENU = 'Reason Code',
                FRA = 'Code motif';
    LookupPageID = "Reason Codes_Purchase";

    fields
    {
        field(1; "Code"; Code[10])
        {
            CaptionML = ENU = 'Code',
                        FRA = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            CaptionML = ENU = 'Description',
                        FRA = 'Désignation';
        }
        field(5900; "Date Filter"; Date)
        {
            CaptionML = ENU = 'Date Filter',
                        FRA = 'Filtre date';
            FieldClass = FlowFilter;
        }
        field(5901; "Contract Gain/Loss Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Contract Gain/Loss Entry".Amount where("Reason Code" = FIELD(Code),
                                                                       "Change Date" = FIELD("Date Filter")));
            CaptionML = ENU = 'Contract Gain/Loss Amount',
                        FRA = 'Montant gain/perte contrat';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(Brick; "Code", Description, "Date Filter")
        {
        }
    }
}

