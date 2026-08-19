table 50360 "Payable Cust Ledger Entry FND"
{
    // version NAVW16.00,DITW110.00.11

    // DITW110.00.11 MSF 25/08/2017 NRQ#17902 Route settlement - Order Payments, Suggest customer and vendor payments
    //                                        New Table Created Copy From 317
    // DITW110.00.11 MSF 15/11/2017 NRQ#45760 Added fields Financial Contract No.

    //BC UPGRADE KUMARR78 >>
    //FDD No.-->   FDD-MTC-009
    //GAP Np. -->  IBM GAP MTC 49
    //PID363-PID364(OTC152-OTC153)Suggest Customer Payments
    //Migrating Table from NAV
    //Old NAV Table id- 2014075
    //BC UPGRADE KUMARR78 <<
    Caption = 'Payable Customer Ledger Entry';

    fields
    {
        field(1; Priority; Integer)
        {
            Caption = 'Priority';
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(3; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(4; "Customer Ledg. Entry No."; Integer)
        {
            Caption = 'Customer Ledg. Entry No.';
            TableRelation = "Cust. Ledger Entry";
        }
        field(5; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(6; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';
        }
        field(7; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(8; Positive; Boolean)
        {
            Caption = 'Positive';
        }
        field(9; Future; Boolean)
        {
            Caption = 'Future';
        }
        //BC UPGRADE KUMARR78 >> Adding Posting Group Field and Changing ID
        field(10; "Posting Group"; Code[10])
        {
            Caption = 'Posting Group';
            Description = 'DIT-770 #340';
        }
        //BC UPGRADE KUMARR78 << Adding Posting Group Field and Changing ID
        //BC UPGRADE KUMARR78 >> Blocking
        // field(2014310; "Service Contract Line No."; Integer)
        // {
        //     Caption = 'Contract Line No.';
        //     Description = 'DITW16.00.00.43 DIT-715 #714';
        // }
        // field(2034840; "Building No."; Code[20])
        // {
        //     Caption = 'Building No.';
        //     Description = 'DITW16.00.00.43 DIT-715 #714';
        //     TableRelation = Building;
        // }
        // field(2034850; "DIT Sub-Contract Type"; Option)
        // {
        //     Caption = 'Sub Contract Type';
        //     Description = 'DITW16.00.00.43 DIT-715 #714';
        //     OptionCaption = '" ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance"';
        //     OptionMembers = " ",Rent,Loan,"Loan in use",Maintenance,Other,PlantMaintenance;
        // }
        // field(2034872; "Contract Group Code"; Code[10])
        // {
        //     Caption = 'Contract Group Code';
        //     Description = 'DITW16.00.00.43 DIT-715 #714';
        //     TableRelation = IF (Contract Type=CONST(Service),
        //                         DIT Sub-Contract Type=FILTER(<>' ')) "Contract Group".Code WHERE (DIT Sub-Contract Type=FIELD(DIT Sub-Contract Type))
        //                         ELSE IF (Contract Type=CONST(Service),
        //                                  DIT Sub-Contract Type=CONST(" ")) "Contract Group".Code
        //                                  ELSE IF (Contract Type=CONST(Financial)) "Financial Contract Group".Code WHERE (DIT Sub-Contract Type=FIELD(DIT Sub-Contract Type));
        // }
        // field(2034915;"Service Contract No.";Code[20])
        // {
        //     Caption = 'Service Contract No.';
        //     Description = 'DITW16.00.00.43 DIT-715 #714';
        //     TableRelation = "Service Purch. Contract Header"."Contract No." WHERE (Contract Type=CONST(Contract));
        // }
        // field(2034916;"Posting Group";Code[10])
        // {
        //     Caption = 'Posting Group';
        //     Description = 'DIT-770 #340';
        // }
        // field(2034917;"Financial Contract No.";Code[20])
        // {
        //     Caption = 'Financial Contract No.';
        //     Description = 'NRQ#45760';
        //     TableRelation = "Financial Contract Header"."Contract No.";
        // }
        // field(2035393;"Contract Type";Option)
        // {
        //     Caption = 'Contract Type';
        //     Description = 'DITW16.00.00.43 DIT-715 #714 - DITW18.00.06 DIT-770 #1368';
        //     OptionCaption = '" ,Service,Financial"';
        //     OptionMembers = " ",Service,Financial;
        // }
        //BC UPGRADE KUMARR78 << Blocking
    }

    keys
    {
        key(Key1; Priority, "Customer No.", "Currency Code", Positive, Future, "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

