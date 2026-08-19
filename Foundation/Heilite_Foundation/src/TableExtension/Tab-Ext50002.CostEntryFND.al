tableextension 50002 CostEntryExtFND extends "Cost Entry"
{
    // version NAVW18.00,HEI.01
    // HEI.01 CHG2068359 BULIMC01 IBM 08.10.2020 #new boolean field added: 50002-"Shipping Cost"

    fields
    {
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("Cost Type No.")
        {
            CaptionML = ENU = 'Cost Type No.', FRA = 'N° type coût';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Description';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Debit Amount")
        {
            CaptionML = ENU = 'Debit Amount', FRA = 'Montant débit';
        }
        modify("Credit Amount")
        {
            CaptionML = ENU = 'Credit Amount', FRA = 'Montant crédit';
        }
        modify("Cost Center Code")
        {
            CaptionML = ENU = 'Cost Center Code', FRA = 'Code centre de coûts';
        }
        modify("Cost Object Code")
        {
            CaptionML = ENU = 'Cost Object Code', FRA = 'Code objet de coûts';
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
        }
        modify("G/L Account")
        {
            CaptionML = ENU = 'G/L Account', FRA = 'Compte général';
        }
        modify("G/L Entry No.")
        {
            CaptionML = ENU = 'G/L Entry No.', FRA = 'N° séquence compta.';
        }
        modify("Source Code")
        {
            CaptionML = ENU = 'Source Code', FRA = 'Code journal';
        }
        modify("System-Created Entry")
        {
            CaptionML = ENU = 'System-Created Entry', FRA = 'Écriture système';
        }
        modify(Allocated)
        {
            CaptionML = ENU = 'Allocated', FRA = 'Ventilé';
        }
        modify("Allocated with Journal No.")
        {
            CaptionML = ENU = 'Allocated with Journal No.', FRA = 'Ventilé avec n° feuille';
        }
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify("Batch Name")
        {
            CaptionML = ENU = 'Batch Name', FRA = 'Nom de la feuille';
        }
        modify("Allocation Description")
        {
            CaptionML = ENU = 'Allocation Description', FRA = 'Description ventilation';
        }
        modify("Allocation ID")
        {
            CaptionML = ENU = 'Allocation ID', FRA = 'ID ventilation';
        }
        modify("Additional-Currency Amount")
        {
            CaptionML = ENU = 'Additional-Currency Amount', FRA = 'Montant DR';
        }
        modify("Add.-Currency Debit Amount")
        {
            CaptionML = ENU = 'Add.-Currency Debit Amount', FRA = 'Montant débit DR';
        }
        modify("Add.-Currency Credit Amount")
        {
            CaptionML = ENU = 'Add.-Currency Credit Amount', FRA = 'Montant crédit DR';
        }
        // field(480; "Dimension Set ID"; Integer)
        // {
        //     Caption = 'Dimension Set ID';
        //     Editable = false;
        //   TableRelation = "Dimension Set Entry";

        //     trigger OnLookup();
        //     begin
        //       //ShowDimensions;
        //     end;
        // }
        field(50000; "Brand FND"; Code[20])
        {
            Caption = 'Brand';
        }
        field(50001; "Line FND"; Code[20])
        {
            Caption = 'Line';
        }
        field(50002; "Shipping Cost FND"; Boolean)
        {
            Description = 'HEI.01';
            Caption = 'Shipping Cost';
        }
        field(60000; "Dimension 1 Code FND"; Code[20])
        {
            TableRelation = Dimension;
            Caption = 'Dimension 1 Code';

        }
        field(60001; "Dimension 2 Code FND"; Code[20])
        {
            TableRelation = Dimension;
            Caption = 'Dimension 2 Code';
        }
        field(60002; "Dimension 3 Code FND"; Code[20])
        {
            TableRelation = Dimension;
            Caption = 'Dimension 3 Code';
        }
        field(60003; "Dimension 4 Code FND"; Code[20])
        {
            TableRelation = Dimension;
            Caption = 'Dimension 4 Code';
        }
        field(60004; "Dimension 5 Code FND"; Code[20])
        {
            TableRelation = Dimension;
            Caption = 'Dimension 5 Code';
        }
        field(60005; "Dimension 6 Code FND"; Code[20])
        {
            TableRelation = Dimension;
            Caption = 'Dimension 6 Code';
        }
        field(60006; "Dimension 7 Code FND"; Code[20])
        {
            TableRelation = Dimension;
            Caption = 'Dimension 7 Code';
        }
        field(60007; "Dimension 8 Code FND"; Code[20])
        {
            TableRelation = Dimension;
            Caption = 'Dimension 8 Code';
        }
        field(60008; "Dimension 9 Code FND"; Code[20])
        {
            TableRelation = Dimension;
            Caption = 'Dimension 9 Code';
        }
        field(60009; "Dimension 10 Code FND"; Code[20])
        {
            TableRelation = Dimension;
            Caption = 'Dimension 10 Code';
        }
        field(60010; "Dimension 11 Code FND"; Code[20])
        {
            TableRelation = Dimension;
            Caption = 'Dimension 11 Code';
        }
        field(60011; "Dimension 12 Code FND"; Code[20])
        {
            TableRelation = Dimension;
            Caption = 'Dimension 12 Code';
        }
        field(60012; "Dimension 13 Code FND"; Code[20])
        {
            TableRelation = Dimension;
            Caption = 'Dimension 13 Code';
        }
        field(60013; "Dimension 14 Code FND"; Code[20])
        {
            TableRelation = Dimension;
            Caption = 'Dimension 14 Code';
        }
        field(60014; "Dimension 15 Code FND"; Code[20])
        {
            TableRelation = Dimension;
            Caption = 'Dimension 15 Code';
        }
        field(60015; "Dimension 16 Code FND"; Code[20])
        {
            TableRelation = Dimension;
            Caption = 'Dimension 16 Code';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

