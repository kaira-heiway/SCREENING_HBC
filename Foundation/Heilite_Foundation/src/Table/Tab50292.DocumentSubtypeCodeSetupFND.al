table 50292 "Doc Subtype Code Setup FND"
{
    // BC Upgrade BHANDS01 >> 2 Mar 2026 => Created table

    CaptionML = ENU = 'Document Subtype Code Setup',
                FRA = 'Paramétrage Code Sous-Type Document';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            CaptionML = ENU = 'Primary Key',
                        FRA = 'Clé primaire';
        }
        field(2; "Sales - General"; Code[10])
        {
            CaptionML = ENU = 'Sales - General',
                        FRA = 'Vente - Général';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales));
        }
        field(3; "Sales - Periodic Discounts"; Code[10])
        {
            CaptionML = ENU = 'Sales - Periodic Discounts',
                        FRA = 'Ventes - Remises périodiques';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales));
        }
        field(10; "Purchase - General"; Code[10])
        {
            CaptionML = ENU = 'Purchase - General',
                        FRA = 'Achat - Général';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Purchase));
        }
        field(11; "Purchase - Periodic Discounts"; Code[10])
        {
            CaptionML = ENU = 'Purchase - Periodic Discounts',
                        FRA = 'Achat - Remise périodiques';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Purchase));
        }

        field(30; "Transfer - General"; Code[10])
        {
            CaptionML = ENU = 'Transfer - General',
                        FRA = 'Transfert - Général';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Inventory));
        }

        field(50000; "Std Sales Return Order RPM"; Code[10])
        {
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales));
        }
        field(50001; "Std Sales Order(Inc.FreeGoods)"; Code[10])
        {
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales));
        }
        field(50002; "Credit Memo-Qty Correction"; Code[10])
        {
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales));
        }
        field(50003; "CreditMemo-PriceCorr(Negative)"; Code[10])
        {
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales));
        }
        field(50004; "CreditMemo-PriceCorr(Positive)"; Code[10])
        {
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales));
        }
        field(50005; "Sundry Sales Order Stock"; Code[10])
        {
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales));
        }
        field(50006; "Sundry Sales Order Non Stock"; Code[10])
        {
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales));
        }
        field(50007; "Debit Memo- Reinvoice Recharge"; Code[10])
        {
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales));
        }
        field(50008; "Standard Sales Return Order"; Code[10])
        {
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales));
        }
        field(50009; "CTS Order"; Code[10])
        {
            Caption = 'CTS Order';
            Description = 'HEI.02';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales));
        }
        field(50010; "Default Sales Order"; Code[10])
        {
            Caption = 'Default Sales Order';
            Description = 'HEI.03';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales));
        }
        field(50011; "Order Generated from Quote"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales));
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

