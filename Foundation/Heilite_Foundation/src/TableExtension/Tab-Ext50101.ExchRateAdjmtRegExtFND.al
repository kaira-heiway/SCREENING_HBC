tableextension 50101 ExchRateAdjmtRegExtFND extends "Exch. Rate Adjmt. Reg."
{
    // version NAVW19.00,HEI.01

    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Creation Date")
        {
            CaptionML = ENU = 'Creation Date', FRA = 'Date création';
        }
        modify("Account Type")
        {
            CaptionML = ENU = 'Account Type', FRA = 'Type compte';
            //OptionCaptionML = ENU = 'G/L Account,Customer,Vendor,Bank Account', FRA = 'Général,Client,Fournisseur,Banque';
        }
        modify("Posting Group")
        {

            //Unsupported feature: Change TableRelation on ""Posting Group"(Field 4)". Please convert manually.

            CaptionML = ENU = 'Posting Group', FRA = 'Groupe comptabilisation';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Currency Factor")
        {
            CaptionML = ENU = 'Currency Factor', FRA = 'Facteur devise';
        }
        modify("Adjusted Base")
        {
            CaptionML = ENU = 'Adjusted Base', FRA = 'Base ajustée';
        }
        modify("Adjusted Base (LCY)")
        {
            CaptionML = ENU = 'Adjusted Base (LCY)', FRA = 'Base ajustée DS';
        }
        modify("Adjusted Amt. (LCY)")
        {
            CaptionML = ENU = 'Adjusted Amt. (LCY)', FRA = 'Montant ajusté DS';
        }
        modify("Adjusted Base (Add.-Curr.)")
        {
            CaptionML = ENU = 'Adjusted Base (Add.-Curr.)', FRA = 'Base ajustée DR';
        }
        modify("Adjusted Amt. (Add.-Curr.)")
        {
            CaptionML = ENU = 'Adjusted Amt. (Add.-Curr.)', FRA = 'Montant ajusté DR';
        }
        field(50000; "Reversed FND"; Boolean)
        {
            caption = 'Reversed';
            Description = 'HEI.01';
        }
        field(50001; "Document No. FND"; Code[20])
        {
            caption = 'Document No.';
            Description = 'HEI.01';
        }
        field(50002; "Account No. FND"; Code[20])
        {
            caption = 'Account No.';
            Description = 'HEI.01';
            TableRelation = IF ("Account Type" = CONST(Customer)) Customer."No." where("No." = FIELD("Account No. FND"))
            else IF ("Account Type" = CONST(Vendor)) Vendor."No." where("No." = FIELD("Account No. FND"))
            else IF ("Account Type" = CONST("Bank Account")) "Bank Account"."No." where("No." = FIELD("Account No. FND"));
        }
        field(50003; "CV Detailed Entry No. FND"; Integer)
        {
            caption = 'CV Detailed Entry No.';
            BlankZero = true;
            Description = 'HEI.01';
            TableRelation = IF ("Account Type" = FILTER(Customer)) "Detailed Cust. Ledg. Entry"."Entry No." where("Entry No." = FIELD("CV Detailed Entry No. FND"))
            else IF ("Account Type" = FILTER(Vendor)) "Detailed Vendor Ledg. Entry"."Entry No." where("Entry No." = FIELD("CV Detailed Entry No. FND"));
        }
    }

    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

