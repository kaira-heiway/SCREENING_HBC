codeunit 51008 "Heicore_Funct CBN"
{
    // version HIT1.0,HEI1.00.07,EDD034,EDD023

    // HIT0010.2 JFE 14/08/2008 : Automatic reservation addon 4.10 FEFO Picking
    // HEI:EDD023:1:1 28/07/09 TECTURA.DM
    //   # Function Block WorkCenter added for checking permission for unblocking Work Center
    // HEI:EDD067:1:1 13/07/10 SKS
    //   # Function BlockServiceItem added for checking permission for unblocking Service Item
    // 
    // HEI:EDD034:1:1 25/09/14 TECTURA.HKH
    //   # Function Block FA
    // 
    // HEI.01 FDD-GAPLOG006 IBM ISYED01 29.09.2017 # Algerai Local
    // # Imported  from HEI2.0 to support report ("50040 -Sales Invoice - Base")
    // 
    // HEI.02 INC3151985 - CHG2086115 IBM NASTAA02 05.11.2020 # Sales invoice print wrong currency code
    //   # New function 'SetCurrencyCode' created to setup the Currency Code
    //   # Code added on function 'Montant en texte1'
    // BC Upgrae BHARDA11 >>
    // 1. Remove Drink-IT Fields("Free Item")
    // BC Upgrade BHARDA11 <<

    // BC Upgrade PATELP08 >> 
    // Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
    // BC Upgrade PATELP08 <<

    Permissions = TableData "Vendor Ledger Entry" = rm,
                  TableData "Sales Shipment Line" = rm,
                  TableData "Purch. Rcpt. Line" = rm,
                  TableData "Return Shipment Line" = rm,
                  TableData "Return Receipt Line" = rm;

    trigger OnRun();
    begin
    end;

    var
        Text98150: TextConst ENU = 'You do not have permission to make this entry payable.', NLD = 'U ben niet geautoriseerd deze post betaalbaar te stellen.';
        Text98151: TextConst ENU = 'You do not have permission to deblock this %1.', NLD = 'U ben niet geautoriseerd deze %1 te deblokkeren.';
        Text98152: TextConst ENU = 'Thare are one or more %1 with a %2 after the %3 %4.', NLD = 'Er zijn één of meer %1 regels met een %2 na de %3 %4.';
        Text98153: TextConst ENU = 'You do not have permission to deblock this %1.', NLD = 'U bent niet geautoriseerd dit %1 te deblokkeren.';
        GenJournalLineTempRecG: Record "Gen. Journal Line" temporary;
        Text98154: TextConst ENU = 'You can post the Invoice en the Receipt only at the same time when %1 equals %2 or select menuitem Invoices. ', NLD = 'U kunt alleen de Factuur tegelijk met de Ontvangst boeken wanneer %1 gelijk is aan %2 of selecteer menuoptie Facturen. ';
        Text98155: TextConst ENU = 'You can post the Credit Memo en the Shipment only at the same time when %1 equals %2 or select menuitem Credit Memo''s.', NLD = 'U kunt alleen de Creditnota tegelijk met de Levering boeken wanneer %1 gelijk is aan %2 of selecteer menuoptie Creditnota''s.';
        Text98156: TextConst ENU = 'There is %1 inserted. %2 in %3 must be adjusted as Invoice Discounts or All Discounts.', NLD = 'Er is %1 ingevoerd. %2 in %3 dient ingesteld te zijn als Factuurkorting of Alle.';
        Error50000: Label '"Function can not be activated when there are existing tracking lines "';
        million: Text[250];
        mille: Text[250];
        cent: Text[250];
        entiere: Integer;
        decimal: Integer;
        nbre: Integer;
        nbre1: Integer;
        j: Integer;
        "Chèque": Report Check;
        chaine1: Text[30];
        VarDeviseEntiere: Text[30];
        VarDeviseDecimal: Text[30];
        CurrencyCode: Code[10];

    procedure fctBlockFixedAsset(var precFixedAsset: Record "Fixed Asset"; pxrecFixedAsset: Record "Fixed Asset"; pblnOnInsert: Boolean): Boolean;
    var
        "_LHIT0003.1": Integer;
        lrecUserSetup: Record "User Setup";
    begin
        if pblnOnInsert then begin
            if not lrecUserSetup.GET(UPPERCASE(USERID)) then
                exit(true);

            if not lrecUserSetup."Release Fixed assets FND" then
                exit(true);
        end
        else begin
            if not pxrecFixedAsset.Blocked then
                exit(false);

            if not lrecUserSetup.GET(UPPERCASE(USERID)) then
                ERROR(Text98151, precFixedAsset.TABLECAPTION);

            if lrecUserSetup."Release Fixed assets FND" then
                exit(false)
            else
                ERROR(Text98151, precFixedAsset.TABLECAPTION);
        end;
    end;

    procedure "---HEI01.0---"();
    begin
    end;

    procedure BlockWorkCenter(var RecWorkCenter: Record "Work Center"; xRecWorkCenter: Record "Work Center"; blnOnInsert: Boolean): Boolean;
    var
        "---HEI01.00---": Integer;
        RecUserSetup: Record "User Setup";
    begin
        //>>HEI:EDD023:1:1 07/11/14 TECTURA.WSA
        if blnOnInsert then begin
            if not RecUserSetup.GET(UPPERCASE(USERID)) then
                exit(true);

            //IF NOT RecUserSetup."Release Work Center" THEN
            //EXIT(TRUE);
        end
        else begin
            if not xRecWorkCenter.Blocked then
                exit(RecWorkCenter.Blocked);

            if not RecUserSetup.GET(UPPERCASE(USERID)) then
                ERROR(Text98151, RecWorkCenter.TABLECAPTION);

            //IF RecUserSetup."Release Work Center" THEN
            //EXIT(FALSE)
            //ELSE
            //ERROR(Text98151,RecWorkCenter.TABLECAPTION);
        end;
        //<<HEI:EDD023:1:1 07/11/14 TECTURA.WSA
    end;

    procedure "Montant en texte"(var strprix: Text[250]; prix: Decimal);
    begin

        entiere := ROUND(prix, 1, '<');
        decimal := ROUND((prix - entiere) * 1000, 1, '<');

        nbre := entiere;
        //Chèque.FormatNumTexte(strprix,nbre);

        million := '';
        mille := '';
        cent := '';

        nbre1 := nbre div 1000000;
        if nbre1 <> 0 then begin
            Centaine(million, nbre1);
            million := million + ' million';
        end;

        nbre := nbre mod 1000000;
        nbre1 := nbre div 1000;
        if nbre1 <> 0 then begin
            Centaine(mille, nbre1);
            if mille <> 'un' then
                mille := mille + ' mille'
            else
                mille := 'mille'
        end;

        nbre := nbre mod 1000;

        if nbre <> 0 then begin
            Centaine(cent, nbre);
        end;

        if million <> '' then
            strprix := million;
        if ((mille <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + mille
        else
            strprix := strprix + mille;
        if ((cent <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + cent
        else
            strprix := strprix + cent;

        if entiere > 1 then
            strprix := strprix + ' dinars';
        if entiere = 1 then
            strprix := strprix + ' dinar';

        cent := '';
        if decimal <> 0 then begin
            Centaine(cent, decimal);
            if strprix <> '' then
                strprix := strprix + ' ' + cent
            else
                strprix := strprix + cent;
            if decimal = 1 then
                strprix := strprix + ' millime'
            else
                strprix := strprix + ' millimes';
        end;

        strprix := UPPERCASE(strprix);
    end;

    procedure Centaine(var chaine: Text[250]; i: Integer);
    var
        k: Integer;
    begin

        k := i div 100;
        chaine := '';
        case k of
            1:
                chaine := 'cent';
            2:
                chaine := 'deux cent';
            3:
                chaine := 'trois cent';
            4:
                chaine := 'quatre cent';
            5:
                chaine := 'cinq cent';
            6:
                chaine := 'six cent';
            7:
                chaine := 'sept cent';
            8:
                chaine := 'huit cent';
            9:
                chaine := 'neuf cent';
        end;
        k := i mod 100;
        Dizaine(chaine, k);
    end;

    procedure Dizaine(var chaine: Text[250]; i: Integer);
    var
        k: Integer;
        l: Integer;
    begin

        if i > 16 then begin
            k := i div 10;
            chaine1 := '';
            case k of
                1:
                    chaine1 := 'dix';
                2:
                    chaine1 := 'vingt';
                3:
                    chaine1 := 'trente';
                4:
                    chaine1 := 'quarante';
                5:
                    chaine1 := 'cinquante';
                6:
                    chaine1 := 'soixante';
                7:
                    chaine1 := 'soixante';
                8:
                    chaine1 := 'quatre vingt';
                9:
                    chaine1 := 'quatre vingt';
            end;
            if ((chaine1 <> '') and (chaine <> '')) then
                chaine1 := ' ' + chaine1;
            chaine := chaine + chaine1;
            l := k;
            if ((k = 7) or (k = 9)) then
                k := (i mod 10) + 10
            else
                k := (i mod 10);
        end
        else
            k := i;

        if ((l <> 8) and (l <> 0) and ((k = 1) or (k = 11))) then
            chaine := chaine + ' et';
        if (((k = 0) or (k > 16)) and ((l = 7) or (l = 9))) then begin
            chaine := chaine + ' dix';
            if k > 16 then
                k := k - 10;
        end;

        Unité(chaine, k);
    end;

    procedure "Unité"(var chaine: Text[250]; i: Integer);
    begin

        chaine1 := '';
        case i of
            1:
                chaine1 := 'un';
            2:
                chaine1 := 'deux';
            3:
                chaine1 := 'trois';
            4:
                chaine1 := 'quatre';
            5:
                chaine1 := 'cinq';
            6:
                chaine1 := 'six';
            7:
                chaine1 := 'sept';
            8:
                chaine1 := 'huit';
            9:
                chaine1 := 'neuf';
            10:
                chaine1 := 'dix';
            11:
                chaine1 := 'onze';
            12:
                chaine1 := 'douze';
            13:
                chaine1 := 'treize';
            14:
                chaine1 := 'quatorze';
            15:
                chaine1 := 'quinze';
            16:
                chaine1 := 'seize';
        end;
        if ((chaine1 <> '') and (chaine <> '')) then
            chaine1 := ' ' + chaine1;
        chaine := chaine + chaine1;
    end;

    procedure "Montant en texte sans millimes"(var strprix: Text[250]; prix: Decimal);
    begin

        entiere := ROUND(prix, 1, '<');
        decimal := ROUND((prix - entiere) * 1000, 1, '<');

        nbre := entiere;
        //Chèque.FormatNumTexte(strprix,nbre);

        million := '';
        mille := '';
        cent := '';

        nbre1 := nbre div 1000000;
        if nbre1 <> 0 then begin
            Centaine(million, nbre1);
            million := million + ' million';
        end;

        nbre := nbre mod 1000000;
        nbre1 := nbre div 1000;
        if nbre1 <> 0 then begin
            Centaine(mille, nbre1);
            if mille <> 'un' then
                mille := mille + ' mille'
            else
                mille := 'mille'
        end;

        nbre := nbre mod 1000;

        if nbre <> 0 then begin
            Centaine(cent, nbre);
        end;

        if million <> '' then
            strprix := million;
        if ((mille <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + mille
        else
            strprix := strprix + mille;
        if ((cent <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + cent
        else
            strprix := strprix + cent;

        if entiere > 1 then
            strprix := strprix + ' dinars';
        if entiere = 1 then
            strprix := strprix + ' dinar';

        if decimal <> 0 then begin
            if strprix <> '' then
                strprix := strprix + ' ' + FORMAT(decimal)
            else
                strprix := strprix + FORMAT(decimal);
            if decimal = 1 then
                strprix := strprix + ' millime'
            else
                strprix := strprix + ' millimes';
        end;

        strprix := UPPERCASE(strprix);
    end;

    procedure MontantTexteDevise(var strprix: Text[250]; prix: Decimal; Devise: Text[30]);
    begin

        //WAJ_09102003_Pour un montant toute lettre en devise

        // Chercher le Dinar et Millimes de la devise
        QuelleDevise(Devise);
        //

        entiere := ROUND(prix, 1, '<');
        decimal := ROUND((prix - entiere) * 100, 1, '<');

        nbre := entiere;
        //Chèque.FormatNumTexte(strprix,nbre);

        million := '';
        mille := '';
        cent := '';

        nbre1 := nbre div 1000000;
        if nbre1 <> 0 then begin
            Centaine(million, nbre1);
            million := million + ' million';
        end;

        nbre := nbre mod 1000000;
        nbre1 := nbre div 1000;
        if nbre1 <> 0 then begin
            Centaine(mille, nbre1);
            if mille <> 'un' then
                mille := mille + ' mille'
            else
                mille := 'mille'
        end;

        nbre := nbre mod 1000;

        if nbre <> 0 then begin
            Centaine(cent, nbre);
        end;

        if million <> '' then
            strprix := million;
        if ((mille <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + mille
        else
            strprix := strprix + mille;
        if ((cent <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + cent
        else
            strprix := strprix + cent;

        if entiere > 1 then
            strprix := strprix + ' ' + VarDeviseEntiere;
        if entiere = 1 then
            strprix := strprix + ' ' + VarDeviseEntiere;

        cent := '';
        if decimal <> 0 then begin
            Centaine(cent, decimal);
            if strprix <> '' then
                strprix := strprix + ' ' + cent
            else
                strprix := strprix + cent;
            if decimal = 1 then
                strprix := strprix + ' ' + VarDeviseDecimal
            else
                strprix := strprix + ' ' + VarDeviseDecimal;



        end;

        strprix := UPPERCASE(strprix);
    end;

    procedure QuelleDevise(var StrDevise: Text[30]);
    begin

        //
        if StrDevise = 'USD' then begin
            VarDeviseEntiere := 'Dollars';
            VarDeviseDecimal := 'Cens';
        end;

        if StrDevise = 'EURO' then begin
            VarDeviseEntiere := 'Euro';
            VarDeviseDecimal := 'Centimes';
        end;

        if StrDevise = '£' then begin
            VarDeviseEntiere := 'Livres Sterling';
            VarDeviseDecimal := 'Cens';
        end;
    end;

    procedure MontantTexteDev(var strprix: Text[250]; prix: Decimal; Devise: Text[30]);
    begin

        //WAJ_09102003_Pour un montant toute lettre en devise

        // Chercher le Dinar et Millimes de la devise
        QuelleDevise(Devise);
        //

        entiere := ROUND(prix, 1, '<');
        decimal := ROUND((prix - entiere) * 100, 1, '<');

        nbre := entiere;
        //Chèque.FormatNumTexte(strprix,nbre);

        million := '';
        mille := '';
        cent := '';

        nbre1 := nbre div 1000000;
        if nbre1 <> 0 then begin
            Centaine(million, nbre1);
            million := million + ' million';
        end;

        nbre := nbre mod 1000000;
        nbre1 := nbre div 1000;
        if nbre1 <> 0 then begin
            Centaine(mille, nbre1);
            if mille <> 'un' then
                mille := mille + ' mille'
            else
                mille := 'mille'
        end;

        nbre := nbre mod 1000;

        if nbre <> 0 then begin
            Centaine(cent, nbre);
        end;

        if million <> '' then
            strprix := million;
        if ((mille <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + mille
        else
            strprix := strprix + mille;
        if ((cent <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + cent
        else
            strprix := strprix + cent;

        if entiere > 1 then
            strprix := strprix + ' ' + VarDeviseEntiere;
        if entiere = 1 then
            strprix := strprix + ' ' + VarDeviseEntiere;

        cent := '';
        if decimal <> 0 then begin
            Centaine(cent, decimal);
            if strprix <> '' then
                strprix := strprix + ' ' + cent
            else
                strprix := strprix + cent;
            if decimal = 1 then
                strprix := strprix + ' ' + VarDeviseDecimal
            else
                strprix := strprix + ' ' + VarDeviseDecimal;



        end;

        strprix := UPPERCASE(strprix);
    end;

    procedure "Montant en texte1"(var strprix: Text[250]; prix: Decimal);
    begin

        entiere := ROUND(prix, 1, '<');
        decimal := ROUND((prix - entiere) * 100, 1, '<');

        nbre := entiere;
        //Chèque.FormatNumTexte(strprix,nbre);

        million := '';
        mille := '';
        cent := '';

        nbre1 := nbre div 1000000;
        if nbre1 <> 0 then begin
            Centaine(million, nbre1);
            million := million + ' million';
        end;

        nbre := nbre mod 1000000;
        nbre1 := nbre div 1000;
        if nbre1 <> 0 then begin
            Centaine(mille, nbre1);
            if mille <> 'un' then
                mille := mille + ' mille'
            else
                mille := 'mille'
        end;

        nbre := nbre mod 1000;

        if nbre <> 0 then begin
            Centaine(cent, nbre);
        end;

        if million <> '' then
            strprix := million;
        if ((mille <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + mille
        else
            strprix := strprix + mille;
        if ((cent <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + cent
        else
            strprix := strprix + cent;

        if CurrencyCode = '' then begin //HEI.02
            if entiere > 1 then
                strprix := strprix + ' Dinars Algérien';
            if entiere = 1 then
                strprix := strprix + ' Dinar Algérien';
            //HEI.02>>
        end else begin
            if CurrencyCode = 'EUR' then begin
                if entiere > 1 then
                    strprix := strprix + ' ' + 'EUROS';
                if entiere = 1 then
                    strprix := strprix + ' ' + 'EURO';
            end else begin
                if entiere > 1 then
                    strprix := strprix + ' ' + CurrencyCode;
                if entiere = 1 then
                    strprix := strprix + ' ' + CurrencyCode;
            end;
        end;
        //HEI.02<<

        cent := '';
        if decimal <> 0 then begin
            Centaine(cent, decimal);
            if strprix <> '' then
                strprix := strprix + ' ' + cent
            else
                strprix := strprix + cent;
            if decimal = 1 then
                strprix := strprix + ' centime'
            else
                strprix := strprix + ' centimes';
        end;

        strprix := UPPERCASE(strprix);
    end;

    procedure ApplyDiscountOnPurchDocument(var PurchHdr: Record "Purchase Header"; TotalDiscAmount: Decimal);
    var
        AmountFromLines: Integer;
        PurchLine: Record "Purchase Line";
        TotalLinesAmt: Decimal;
        LineAppliedDiscount: Decimal;
        TotalAppliedDiscount: Decimal;
        RemainingDiscount: Decimal;
        DocAmount: Decimal;
        DiscPerc: Decimal;
        PurchaseCalcDiscByType: Codeunit "Purch-Calc Disc. By Type CBN";
    begin
        //SOICAD
        if TotalDiscAmount = 0 then
            exit;
        //> DS002 30/06/17
        //TotalDiscAmount := -TotalDiscAmount;
        //< DS002 30/06/17
        //CalcPurchaseDocAmount(PurchHdr,DocA;mount);
        //IF DocAmount = 0 THEN
        //EXIT;
        //PurchaseHeader.GET("Document Type","Document No.");
        //ApplyInvDiscBasedOnAmt(TotalDiscAmount,PurchHdr);
        CLEAR(PurchLine);
        PurchLine.SETRANGE("Document Type", PurchHdr."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHdr."No.");
        // PurchLine.SETRANGE("Free Item",false); // BC Upgrade BHARDA11 ----Drink-IT Fields("Free Item")
        //>DS002 29/06/17
        PurchLine.SETRANGE(Type, PurchLine.Type::Item);
        //<DS002 29/06/17
        if PurchLine.FINDSET() then
            repeat
                ///TotalLinesAmt += PurchLine."Amount Including VAT";
                TotalLinesAmt += PurchLine."Line Amount";
            until PurchLine.NEXT() = 0;

        CLEAR(PurchLine);
        PurchLine.SETRANGE("Document Type", PurchHdr."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHdr."No.");
        // PurchLine.SETRANGE("Free Item", false); // BC Upgrade BHARDA11 ----Drink-IT Fields("Free Item")
        //>DS002 29/06/17
        PurchLine.SETRANGE(Type, PurchLine.Type::Item);
        //<DS002 29/06/17
        if PurchLine.FINDSET() then
            repeat
                //LineAppliedDiscount := ROUND(TotalDiscAmount * PurchLine."Amount Including VAT" / TotalLinesAmt,0.01);  //DS003 -> we should consider the amount excluded vat
                LineAppliedDiscount := ROUND(TotalDiscAmount * PurchLine."Line Amount" / TotalLinesAmt, 0.01);
                //LineAppliedDiscount := 100 *LineAppliedDiscount / (100 + PurchLine."VAT %");        //DS003 -> we don't need this linesof code
                PurchLine.VALIDATE("Inv. Discount Amount", LineAppliedDiscount);
                //  NewLineAmtInclVat =
                //PurchLine.VALIDATE(PurchLine."Amount Including VAT",PurchLine."Amount Including VAT" - LineAppliedDiscount);
                PurchLine.MODIFY(true);
            until PurchLine.NEXT() = 0;


        /*
        DiscPerc := 100 * TotalDiscAmount /DocAmount;
        TotalDiscAmount := - TotalDiscAmount;
        PurchLine.SETRANGE("Document Type",PurchHdr."Document Type");
        PurchLine.SETRANGE("Document No.",PurchHdr."No.");
        //>DS001 23.06.17
        //PurchLine.SETRANGE("Allow Invoice Disc.",TRUE);
        //<DS001 23.06.17
        {IF PurchLine.FINDSET THEN REPEAT
          IF (NOT PurchLine."Free Item") AND (PurchLine.Type <> PurchLine.Type::"Charge (Item)") THEN BEGIN
            TotalLinesAmt += PurchLine."Line Amount";
          END;
        UNTIL PurchLine.NEXT = 0;  }
        CLEAR(PurchLine);
        PurchLine.SETRANGE("Document Type",PurchHdr."Document Type");
        PurchLine.SETRANGE("Document No.",PurchHdr."No.");
        //>DS001 23.06.17
        //PurchLine.SETRANGE("Allow Invoice Disc.",TRUE);
        //<DS001 23.06.17
        IF PurchLine.FINDSET THEN REPEAT
          IF (NOT PurchLine."Free Item") AND (PurchLine.Type <> PurchLine.Type::"Charge (Item)") THEN BEGIN
            //LineAppliedDiscount := ROUND(TotalDiscAmount * PurchLine."Line PurchLine."Line Discount Amount"Amount" / TotalLinesAmt,0.01);
        //    PurchLine.Validate("Line Discount Amount",PurchLine."Line Amount"
          //  PurchLine.VALIDATE("Direct Unit Cost",PurchLine."Direct Unit Cost" * DiscPerc);
            PurchLine.MODIFY;
           // TotalAppliedDiscount += LineAppliedDiscount;
          END;
        UNTIL PurchLine.NEXT = 0;
        //IF TotalAppliedDiscount <> TotalAppliedDiscount
        //*/

    end;

    procedure CalcPurchaseDocAmount(PurchaseHeader: Record "Purchase Header"; var DocAmountLCY: Decimal);
    var
        TempPurchaseLine: Record "Purchase Line" temporary;
        TotalPurchaseLine: Record "Purchase Line";
        TotalPurchaseLineLCY: Record "Purchase Line";
        PurchasePost: Codeunit "Purch.-Post";
        TempAmount: Decimal;
        VAtText: Text[30];
    begin
        PurchasePost.GetPurchLines(PurchaseHeader, TempPurchaseLine, 0);
        CLEAR(PurchasePost);
        PurchasePost.SumPurchLinesTemp(
          PurchaseHeader, TempPurchaseLine, 0, TotalPurchaseLine, TotalPurchaseLineLCY,
          TempAmount, VAtText);

        DocAmountLCY := TempPurchaseLine."Amount Including VAT";
    end;

    procedure ApplyInvDiscBasedOnAmt(InvoiceDiscountAmount: Decimal; var PurchaseHeader: Record "Purchase Header");
    var
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        PurchaseLine: Record "Purchase Line";
        InvDiscBaseAmount: Decimal;
    begin
        // BC Upgrade PATELP08 >> Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required 
        // with PurchaseHeader do begin
        //     PurchaseLine.SETRANGE("Document No.", "No.");
        //     PurchaseLine.SETRANGE("Document Type", "Document Type");
        //     //<DS012
        //     //PurchaseLine.findfirst;
        //     //PurchaseHeader.validate("Invoice Discount Amount",InvoiceDiscountAmount);    //DS  -> Here error. The system cannot find the purchase lines to update
        //     //<DS012
        //     PurchaseLine.CalcVATAmountLines(0, PurchaseHeader, PurchaseLine, TempVATAmountLine);

        //     InvDiscBaseAmount := TempVATAmountLine.GetTotalInvDiscBaseAmount(false, "Currency Code");  //DS -> The DiscBaseAmount is not computed

        //     if (InvDiscBaseAmount = 0) and (InvoiceDiscountAmount > 0) then
        //         ERROR('InvDiscBaseAmountIsZeroErr');

        //     TempVATAmountLine.SetInvoiceDiscountAmount(InvoiceDiscountAmount, "Currency Code",
        //       true, "VAT Base Discount %");
        //     //    "Prices Including VAT"
        //     PurchaseLine.UpdateVATOnLines(0, PurchaseHeader, PurchaseLine, TempVATAmountLine);

        //     "Invoice Discount Calculation" := "Invoice Discount Calculation"::Amount;
        //     "Invoice Discount Value" := InvoiceDiscountAmount;

        //     MODIFY();
        // end;
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        //<DS012
        //PurchaseLine.findfirst;
        //PurchaseHeader.validate("Invoice Discount Amount",InvoiceDiscountAmount);    //DS  -> Here error. The system cannot find the purchase lines to update
        //<DS012
        PurchaseLine.CalcVATAmountLines(0, PurchaseHeader, PurchaseLine, TempVATAmountLine);

        InvDiscBaseAmount := TempVATAmountLine.GetTotalInvDiscBaseAmount(false, PurchaseHeader."Currency Code");  //DS -> The DiscBaseAmount is not computed

        if (InvDiscBaseAmount = 0) and (InvoiceDiscountAmount > 0) then
            ERROR('InvDiscBaseAmountIsZeroErr');

        TempVATAmountLine.SetInvoiceDiscountAmount(InvoiceDiscountAmount, PurchaseHeader."Currency Code",
            true, PurchaseHeader."VAT Base Discount %");
        //    "Prices Including VAT"
        PurchaseLine.UpdateVATOnLines(0, PurchaseHeader, PurchaseLine, TempVATAmountLine);

        PurchaseHeader."Invoice Discount Calculation" := PurchaseHeader."Invoice Discount Calculation"::Amount;
        PurchaseHeader."Invoice Discount Value" := InvoiceDiscountAmount;

        PurchaseHeader.MODIFY();
        // BC Upgrade PATELP08 <<
    end;

    procedure SetCurrencyCode(CurrencyCode2: Code[10]);
    begin
        //HEI.02>>
        CurrencyCode := CurrencyCode2;
        //HEI.02<<
    end;
}

