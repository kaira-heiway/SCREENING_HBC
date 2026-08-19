table 50280 "Purch Order Overdue Entry FND"
{
    // version HEI.02

    // HEI.01 CHG2241988 SAHAL01 13.05.2024 Email Notification of Open POs Sent To Requestors Managers
    //   # Created New Table: 50280 - Purchase Order Overdue Entry
    // HEI.02 CHG2241988 SAHAL01 05.07.2024 Email Notification of Open POs Sent To Requestors Managers
    //   # Created New Fields: 41 - Delivery Finalized
    //                         48 - Last Execution Date-Time
    //                         49 - Last Executed By
    //   # Added Code

    Caption = 'Purchase Order Overdue Entry';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            Description = 'HEI.01';
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type';
            Description = 'HEI.01';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Description = 'HEI.01';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            Description = 'HEI.01';
        }
        field(7; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            Description = 'HEI.01';
        }
        field(8; "Buy-from Vendor Name"; Text[50])
        {
            Caption = 'Buy-from Vendor Name';
            Description = 'HEI.01';
        }
        field(9; "Buy-from Vendor Name 2"; Text[50])
        {
            Caption = 'Buy-from Vendor Name 2';
            Description = 'HEI.01';
        }
        field(10; Status; Option)
        {
            Caption = 'Status';
            Description = 'HEI.01';
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(14; "Maximo Requisition No."; Code[20])
        {
            Caption = 'Maximo Requisition No.';
            Description = 'HEI.01';
        }
        field(15; "Document Subtype Code"; Code[10])
        {
            Caption = 'Document Subtype Code';
            Description = 'HEI.01';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = CONST(Purchase));//Bc Upgrade VAMSIU01 - Added >>
        }
        field(16; "Requester ID"; Code[50])
        {
            Caption = 'Requester ID';
            Description = 'HEI.01';
            TableRelation = "User Setup";
        }
        field(17; "PQ Approver"; Code[50])
        {
            Caption = 'PQ Approver';
            Description = 'HEI.01';
            TableRelation = "User Setup";
        }
        field(20; "Email To User ID"; Code[50])
        {
            Caption = 'Email To User ID';
            Description = 'HEI.01';
        }
        field(21; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Description = 'HEI.01';
        }
        field(22; Type; Option)
        {
            Caption = 'Type';
            Description = 'HEI.01';
            OptionCaption = '" ,G/L Account,Item,,Fixed Asset,Charge (Item)"';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";
        }
        field(23; "No."; Code[20])
        {
            Caption = 'No.';
            Description = 'HEI.01';
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            else IF (Type = CONST("G/L Account"),
                                     "System-Created Entry" = CONST(false)) "G/L Account" where("Direct Posting" = CONST(true),
                                                                                               "Account Type" = CONST(Posting),
                                                                                               Blocked = CONST(false))
            else IF (Type = CONST("G/L Account"),
                                                                                                        "System-Created Entry" = CONST(true)) "G/L Account"
            else IF (Type = CONST(Item)) Item
            else IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            else IF (Type = CONST("Charge (Item)")) "Item Charge";
            ValidateTableRelation = false;
        }
        field(24; Description; Text[50])
        {
            Caption = 'Description';
            Description = 'HEI.01';
        }
        field(25; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            Description = 'HEI.01';
        }
        field(26; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
            Description = 'HEI.01';
        }
        field(27; Quantity; Decimal)
        {
            Caption = 'Quantity';
            Description = 'HEI.01';
        }
        field(28; "Outstanding Quantity"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            Description = 'HEI.01';
        }
        field(35; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
            Description = 'HEI.01';
        }
        field(36; "Shopping Card No."; Code[10])
        {
            Caption = 'Shopping Card No.';
            Description = 'HEI.01';
        }
        field(37; Overdue; Integer)
        {
            Caption = 'Overdue';
            Description = 'HEI.01';
        }
        field(38; "Soon To Be Overdue"; Integer)
        {
            Caption = 'Soon To Be Overdue';
            Description = 'HEI.01';
        }
        field(40; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            Description = 'HEI.01';
        }
        field(41; "Delivery Finalized"; Boolean)
        {
            Caption = 'Delivery Finalized';
            Description = 'HEI.02';
        }
        field(48; "Last Execution Date-Time"; DateTime)
        {
            Caption = 'Last Execution Date-Time';
            Description = 'HEI.02';
            Editable = false;
        }
        field(49; "Last Executed By"; Code[50])
        {
            Caption = 'Last Executed By';
            Description = 'HEI.02';
            Editable = false;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup();
            var
                UserMgtL: Codeunit "User Management";
            begin
                //HEI.02>>
                //UserMgtL.LookupUserID("Last Executed By");// BC upgrade Manisha Function change in BC
                UserMgtL.DisplayUserInformation("Last Executed By");// BC upgrade Manisha Function change in BC
                //HEI.02<<
            end;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

