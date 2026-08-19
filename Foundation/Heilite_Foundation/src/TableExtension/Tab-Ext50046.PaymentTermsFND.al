tableextension 50046 PaymentTermsExtFND extends "Payment Terms"
{
    // version NAVW19.00,DITW18.00.06
    // DITW18.00.06 MVN 28/10/2015 DIT-770 #1623 : Added field 2013610 "Skip Warnings"
    fields
    {
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify("Due Date Calculation")
        {
            CaptionML = ENU = 'Due Date Calculation', FRA = 'Calcul date échéance';
        }
        modify("Discount Date Calculation")
        {
            CaptionML = ENU = 'Discount Date Calculation', FRA = 'Calcul date d''escompte';
        }
        modify("Discount %")
        {
            CaptionML = ENU = 'Discount %', FRA = '% remise';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Calc. Pmt. Disc. on Cr. Memos")
        {
            CaptionML = ENU = 'Calc. Pmt. Disc. on Cr. Memos', FRA = 'Calculer escompte sur avoirs';
        }
        // field(2014410; "Skip Document Warnings"; Boolean)
        // {
        //     CaptionML = ENU = 'Skip Sales/Purchase document warnings',
        //                 FRA = 'Ignorer les avertissements Ventes/Achats';
        //     Description = 'DIT-770 #1623';
        // }  // BC Upgrade NANDIS03
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH PaymentTermsTranslation DO BEGIN
      SETRANGE("Payment Term",Code);
      DELETEALL
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    with PaymentTermsTranslation do begin
      SETRANGE("Payment Term",Code);
      DELETEALL
    end;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

