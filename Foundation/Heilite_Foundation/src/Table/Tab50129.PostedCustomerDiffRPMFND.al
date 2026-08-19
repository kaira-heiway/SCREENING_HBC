table 50129 "Posted Customer Diff RPM FND"
{
    // HEI.01 FDD-RW-GAPLOG10 IBM ISYED01 30-10-2018 RPM Breakages
    //   #Created new table for RPM Breakages


    fields
    {
        field(1; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.',
                        FRA = 'N° ligne';
            Description = 'HEI.01';
            Editable = false;
        }
        field(2; "Item No."; Code[20])
        {
            CaptionML = ENU = 'Item No.',
                        FRA = 'N° article';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = Item;
        }
        field(3; "UOM Code"; Code[10])
        {
            CaptionML = ENU = 'Unit of Measure Code',
                        FRA = 'Code unité';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "Item Unit of Measure".Code where("Item No." = FIELD("Item No."));
        }
        field(4; "Item Description"; Text[50])
        {
            CaptionML = ENU = 'Description',
                        FRA = 'Désignation';
            Description = 'HEI.01';
            Editable = false;
        }
        field(5; "Deposit Price"; Decimal)
        {
            Description = 'HEI.01';
        }
        field(6; "RPM Missing Bottle"; Decimal)
        {
            Description = 'HEI.01';
        }
        field(7; "RPM Broken"; Decimal)
        {
            Description = 'HEI.01';
        }
        field(8; "RPM Chipped"; Decimal)
        {
            Description = 'HEI.01';
        }
        field(9; "RPM Missing crate"; Decimal)
        {
            Description = 'HEI.01';
        }
        field(10; "Sell-to customer no."; Code[20])
        {
            Description = 'HEI.01';
        }
        field(11; "Sell-to Customer Name"; Text[50])
        {
            CaptionML = ENU = 'Sell-to Customer Name',
                        FRA = 'Nom du donneur d''ordre';
            Description = 'HEI.01';
            TableRelation = Customer;
            ValidateTableRelation = false;

            trigger OnValidate();
            var
                Customer: Record Customer;
            begin
            end;
        }
        field(12; "Bill-to Customer No."; Code[20])
        {
            CaptionML = ENU = 'Bill-to Customer No.',
                        FRA = 'N° client facturé';
            Description = 'HEI.01';
            NotBlank = true;
            TableRelation = Customer;

            trigger OnValidate();
            var
                ShipToAddr: Record "Ship-to Address";
                HasRecreateSalesLines: Boolean;
            begin
            end;
        }
        field(13; "Bill-to Customer name"; Text[50])
        {
            Description = 'HEI.01';
        }
        field(14; "Compensation RPM Diff."; Boolean)
        {
            Description = 'HEI.01';
        }
        field(15; "Sales return order no."; Code[20])
        {
            Description = 'HEI.01';
        }
        field(16; "Posting Date"; Date)
        {
            Description = 'HEI.01';
        }
        field(17; "Posted Sales Return receipt No"; Code[20])
        {
            Description = 'HEI.01';
        }
        field(18; Closed; Boolean)
        {
            Description = 'HEI.01';
        }
        field(19; "Closed By Document No."; Code[20])
        {
            Description = 'HEI.01';
        }
        field(20; "Closed By Posting Date"; Date)
        {
            Description = 'HEI.01';
        }
        field(21; "Closed By User Id"; Code[50])
        {
            Description = 'HEI.01';
        }
        field(22; "Closed on Date"; Date)
        {
            Description = 'HEI.01';
        }
        field(23; "Document date"; Date)
        {
            Description = 'HEI.01';
        }
        field(24; "RPM comp.Sales Credit memo No."; Code[20])
        {
            Description = 'HEI.01';
        }
    }

    keys
    {
        key(Key1; "Line No.", "Item No.", "Sales return order no.")
        {
        }
    }

    fieldgroups
    {
    }

    procedure Navigate();
    var
        NavigateForm: Page Navigate;
    begin
        NavigateForm.SetDoc("Posting Date", "Sales return order no.");
        NavigateForm.RUN();
    end;
}

