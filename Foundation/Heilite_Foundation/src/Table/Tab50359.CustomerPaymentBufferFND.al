table 50359 "Customer Payment Buffer FND"
{
    // version DITW110.00.11

    // DITW110.00.11 MSF 25/08/2017 NRQ#17902 Route settlement - Order Payments, Suggest customer and vendor payments
    //                              New Table Created Copy From 372
    // DITW110.00.11 MSF 15/11/2017 NRQ#45760 Added fields Financial Contract No.


    //BC UPGRADE KUMARR78 >>
    //FDD No.-->   FDD-MTC-009
    //GAP Np. -->  IBM GAP MTC 49
    //PID363-PID364(OTC152-OTC153)Suggest Customer Payments
    //Migrating Table from NAV
    //Old NAV Table id- 2014081
    //BC UPGRADE KUMARR78 <<
    Caption = 'Payment Buffer';

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(2; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(3; "Customer Ledg. Entry No."; Integer)
        {
            Caption = 'Customer Ledg. Entry No.';
            TableRelation = "Cust. Ledger Entry";
        }
        field(4; "Dimension Entry No."; Integer)
        {
            Caption = 'Dimension Entry No.';
        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(8; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(9; "Customer Ledg. Entry Doc. Type"; Option)
        {
            Caption = 'Customer Ledg. Entry Doc. Type';
            OptionCaption = '" ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund"';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(10; "Customer Ledg. Entry Doc. No."; Code[20])
        {
            Caption = 'Customer Ledg. Entry Doc. No.';
        }
        field(170; "Creditor No."; Code[20])
        {
            Caption = 'Creditor No.';
            Numeric = true;
        }
        field(171; "Payment Reference"; Code[50])
        {
            Caption = 'Payment Reference';
            Numeric = true;
        }
        field(172; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Cust. Ledger Entry"."Payment Method Code" WHERE("Customer No." = FIELD("Customer No."));
        }
        field(173; "Applies-to Ext. Doc. No."; Code[35])
        {
            Caption = 'Applies-to Ext. Doc. No.';
        }
        field(290; "Exported to Payment File"; Boolean)
        {
            Caption = 'Exported to Payment File';
            Editable = false;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        //BC UPGRADE KUMARR78 >> Adding Document Subtype Code Field and Changing ID
        field(481; "Document Subtype Code"; Code[10])
        {
            Caption = 'Document Subtype Code';
            Description = 'DITW110.00.11 NRQ#17902';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Purchase));
        }
        //BC UPGRADE KUMARR78 << Adding Document Subtype Code Field and Changing ID
        //BC UPGRADE KUMARR78 >> Adding Posting Group Field and Changing ID
        field(482; "Posting Group"; Code[10])
        {
            Caption = 'Posting Group';
            Description = 'DIT-770 #340';
        }
        //BC UPGRADE KUMARR78 << Adding Posting Group Field and Changing ID

        //BC UPGRADE KUMARR78 >> Blocking DIT Fields
        // field(2014109; "Route Planning No."; Code[20])
        // {
        //     Caption = 'Route Planning No.';
        //     Description = 'DITW110.00.11 NRQ#17902';
        //     TableRelation = "Route Planning Worksheet";
        // }
        // field(2014310; "Service Contract Line No."; Integer)
        // {
        //     Caption = 'Contract Line No.';
        //     Description = 'DITW16.00.00.43 DIT-715 #714';
        // }
        // field(2014421; "Document Subtype Code"; Code[10])
        // {
        //     Caption = 'Document Subtype Code';
        //     Description = 'DITW110.00.11 NRQ#17902';
        //     TableRelation = "Document Subtype Code".Code WHERE("Report Selection Type" = FILTER(Purchase));
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
        //BC UPGRADE KUMARR78 << Blocking DIT Fields
    }

    keys
    {
        key(Key1; "Customer No.", "Currency Code", "Customer Ledg. Entry No.", "Dimension Entry No.")
        {
        }
        key(Key2; "Document No.")
        {
        }
    }

    fieldgroups
    {
    }
}

