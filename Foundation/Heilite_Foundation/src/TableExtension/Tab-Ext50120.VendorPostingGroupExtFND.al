tableextension 50120 VendorPostingGroupExtFND extends "Vendor Posting Group"
{
    // version NAVW19.00
    // HEI.01 FDD-HNK PTPGAP067 IBM. ISYED01 24/10/2017
    //   # added new feild "NPO Prepayment Account" to the table
    // HEI.02 FDD-HT2159 - CHG2105031 IBM NASTAA02 04.08.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field created: 50001 - CAD Account

    fields
    {
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify("Payables Account")
        {
            CaptionML = ENU = 'Payables Account', FRA = 'Compte fournisseur';
        }
        modify("Service Charge Acc.")
        {
            CaptionML = ENU = 'Service Charge Acc.', FRA = 'Compte frais forfaitaires';
        }
        modify("Payment Disc. Debit Acc.")
        {
            CaptionML = ENU = 'Payment Disc. Debit Acc.', FRA = 'Compte débit escompte';
        }
        modify("Invoice Rounding Account")
        {
            CaptionML = ENU = 'Invoice Rounding Account', FRA = 'Compte arrondi facture';
        }
        modify("Debit Curr. Appln. Rndg. Acc.")
        {
            CaptionML = ENU = 'Debit Curr. Appln. Rndg. Acc.', FRA = 'Cpte arr. lettr. dev. débit';
        }
        modify("Credit Curr. Appln. Rndg. Acc.")
        {
            CaptionML = ENU = 'Credit Curr. Appln. Rndg. Acc.', FRA = 'Cpte arr. lettr. dev. crédit';
        }
        modify("Debit Rounding Account")
        {
            CaptionML = ENU = 'Debit Rounding Account', FRA = 'Cpte arrondi débit';
        }
        modify("Credit Rounding Account")
        {
            CaptionML = ENU = 'Credit Rounding Account', FRA = 'Cpte arrondi crédit';
        }
        modify("Payment Disc. Credit Acc.")
        {
            CaptionML = ENU = 'Payment Disc. Credit Acc.', FRA = 'Compte crédit escompte';
        }
        modify("Payment Tolerance Debit Acc.")
        {
            CaptionML = ENU = 'Payment Tolerance Debit Acc.', FRA = 'Compte écart règlement débit';
        }
        modify("Payment Tolerance Credit Acc.")
        {
            CaptionML = ENU = 'Payment Tolerance Credit Acc.', FRA = 'Compte écart règlement crédit';
        }

        //Unsupported feature: CodeModification on ""Payables Account"(Field 2).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Payables Account",FALSE,FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Payables Account",false,false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Service Charge Acc."(Field 7).OnValidate". Please convert manually.

        //trigger "(Field 7)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Service Charge Acc.",TRUE,TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Service Charge Acc.",true,true);
        */
        //end;


        //Unsupported feature: CodeModification on ""Payment Disc. Debit Acc."(Field 8).OnValidate". Please convert manually.

        //trigger  Debit Acc();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Payment Disc. Debit Acc.",FALSE,FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Payment Disc. Debit Acc.",false,false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Invoice Rounding Account"(Field 9).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Invoice Rounding Account",TRUE,FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Invoice Rounding Account",true,false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Payment Disc. Credit Acc."(Field 16).OnValidate". Please convert manually.

        //trigger  Credit Acc();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckGLAcc("Payment Disc. Credit Acc.",FALSE,FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckGLAcc("Payment Disc. Credit Acc.",false,false);
        */
        //end;
        field(50000; "Prepayment Request Account FND"; Code[10])
        {
            caption ='Prepayment Request Account';
            Description = 'HEI.01';
            TableRelation = "G/L Account"."No.";
        }
        field(50001; "CAD Account FND"; Code[20])
        {
            Caption = 'CAD Account';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = "G/L Account";
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

