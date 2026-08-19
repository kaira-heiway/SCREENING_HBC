table 50011 "Dispute Case FND"
{
    // version HEI.01

    // HEI.01 FDD-HNK-HeiliteBASE-OTCGAP029 IBM ISYED01 28/06/2017
    //   #Created new table for Dispute Reasons
    // HEI.02 FDD-HB2071 - CHG2099230 IBM NASTAA02 04.05.2021 # Update Dispute Module in HL
    //   # New Fields created: 9 - Dispute Category Code
    //                         20 - Customer No.
    //                         21 - Document No.
    //                         30 - Closing Date
    //                         31 - Duration of Ticket
    //   # Table Filter added on "Reson Code" Field


    fields
    {
        field(1; "Cust. Ledger Entry No."; Integer)
        {
            Caption = 'Entry No.';
            Description = 'HEI.01.OTCGAP029';
            TableRelation = "Cust. Ledger Entry";
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
            Description = 'HEI.01.OTCGAP029';
            Editable = false;
            Enabled = true;
        }
        field(3; Description; Text[50])
        {
            Description = 'HEI.01.OTCGAP029';
        }
        field(4; "Creation Date"; Date)
        {
            Description = 'HEI.01.OTCGAP029';
            Editable = false;
        }
        field(5; "Reason Code"; Code[20])
        {
            Description = 'HEI.01.OTCGAP029';
            TableRelation = "Dispute Reason FND".Code where("Dispute Category Code" = FIELD("Dispute Category Code"));
        }
        field(6; Priority; Option)
        {
            Description = 'HEI.01.OTCGAP029';
            OptionCaption = 'Very Low, Low, Medium, High, Very High';
            OptionMembers = "Very Low"," Low"," Medium"," High"," Very High";
        }
        field(7; "Resolution Code"; Code[20])
        {
            Description = 'HEI.01.OTCGAP029';
            TableRelation = "Dispute Resolution FND".Code;
        }
        field(8; Status; Option)
        {
            Description = 'HEI.01.OTCGAP029';
            OptionCaption = 'Open,Close';
            OptionMembers = Open,Close;

            trigger OnValidate();
            begin
                //HEI.02>>
                if Status = Status::Close then begin
                    "Closing Date" := WORKDATE();
                    "Duration of Ticket" := "Closing Date" - "Creation Date";
                end else
                    if Status = Status::Open then begin
                        "Closing Date" := 0D;
                        "Duration of Ticket" := 0;
                    end;
                //HEI.02<<
            end;
        }
        field(9; "Dispute Category Code"; Code[20])
        {
            Caption = 'Dispute Category Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = "Dispute Category FND";

            trigger OnValidate();
            begin
                //HEI.02>>
                if ("Dispute Category Code" <> xRec."Dispute Category Code") and ("Reason Code" <> '') then
                    "Reason Code" := '';
                //HEI.02<<
            end;
        }
        field(20; "Customer No."; Code[20])
        {
            CalcFormula = Lookup("Cust. Ledger Entry"."Customer No." where("Entry No." = FIELD("Cust. Ledger Entry No.")));
            Caption = 'Customer No.';
            Description = 'HEI.02';
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Document No."; Code[20])
        {
            CalcFormula = Lookup("Cust. Ledger Entry"."Document No." where("Entry No." = FIELD("Cust. Ledger Entry No.")));
            Caption = 'Document No.';
            Description = 'HEI.02';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Closing Date"; Date)
        {
            Caption = 'Closing Date';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            Editable = false;
        }
        field(31; "Duration of Ticket"; Integer)
        {
            Caption = 'Duration of Ticket';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Cust. Ledger Entry No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        //HEI.01>>
        "Creation Date" := TODAY;
        HeinekenGlobal.StatusOpenOnce(Rec);
        //HEI.01<<
    end;

    trigger OnModify();
    begin
        //HEI.01>>
        HeinekenGlobal.StatusOpenOnceOnModify(Rec, xRec, true);
        //HEI.01>>
    end;

    var
        DisputeCase: Record "Dispute Case FND";
        HeinekenGlobal: Codeunit "Heineken Global";
        Error001: Label 'You cannot create more than one open dispute case for a customer ledger entry %1.';
}

