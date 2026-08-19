tableextension 50167 VATEntryExtFND extends "VAT Entry"
{
    // version NAVW110.0,DITW110.00.08,HEI.02
    // DITW17.00.02 SR 10/09/2013 DIT-770 #137 : Add options 'Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back' to "Document Type"
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1

    // HEI.01 FDD-KDD0TC002 IBM HORTOC01 04.10.2017 - new option on "Document type" field - "Interest Rate Credit"
    // HEI.02 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    // # New Field created: 50001 - "TIN No."
    // HEI.03 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    // # New functions added
    //     # CheckDelayedUnrealVATType
    //     # GetUnrealizedVATPartFRLoc
    // HEI.04 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    // # New Field created: 50002 - Location Code
    // HEI.05 FDD-HT2159 - CHG2105031 IBM NASTAA02 04.08.2021 # VAT Centime - Part 2 - Purchases
    // # New Field created: 50003 - Region Code
    // BC UPGRADE GUPTAK03 WHT functions migrated 

    fields
    {
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';

        }
        modify("Gen. Bus. Posting Group")
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group', FRA = 'Groupe compta. marché';
        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            //OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back,Prepayment Invoice,Prepayment CreditMemo,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement,,,,,Banque inverse,Charge bancaire,Paiment prêt,Rembousement prêtk,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment';

            //Unsupported feature: Change OptionString on ""Document Type"(Field 6)". Please convert manually.


            //Unsupported feature: Change Description on ""Document Type"(Field 6)". Please convert manually.

        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            //OptionCaptionML = ENU = ' ,Purchase,Sale,Settlement', FRA = ' ,Achat,Vente,Règlement';
        }
        modify(Base)
        {
            CaptionML = ENU = 'Base', FRA = 'Base';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("VAT Calculation Type")
        {
            CaptionML = ENU = 'VAT Calculation Type', FRA = 'Mode calcul TVA';
            //OptionCaptionML = ENU = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax', FRA = 'Normal,Intracomm.,Correctif,Sales Tax';
        }
        modify("Bill-to/Pay-to No.")
        {

            //Unsupported feature: Change TableRelation on ""Bill-to/Pay-to No."(Field 12)". Please convert manually.

            TableRelation = if (Type = const(Purchase)) Vendor
            else if (Type = const(Sale)) Customer;
            CaptionML = ENU = 'Bill-to/Pay-to No.', FRA = 'N°donneur/preneur d''ordre';

        }
        modify("EU 3-Party Trade")
        {
            CaptionML = ENU = 'EU 3-Party Trade', FRA = 'Trans. tripartite UE';
        }
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify("Source Code")
        {
            CaptionML = ENU = 'Source Code', FRA = 'Code journal';
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
        }
        modify("Closed by Entry No.")
        {
            CaptionML = ENU = 'Closed by Entry No.', FRA = 'N° séquence lettrage final';
        }
        modify(Closed)
        {
            CaptionML = ENU = 'Closed', FRA = 'Clôturé';
        }
        modify("Country/Region Code")
        {

            //Unsupported feature: Change TableRelation on ""Country/Region Code"(Field 19)". Please convert manually.

            CaptionML = ENU = 'Country/Region Code', FRA = 'Code pays/région';
        }
        modify("Internal Ref. No.")
        {
            CaptionML = ENU = 'Internal Ref. No.', FRA = 'N° référence interne';
        }
        modify("Transaction No.")
        {
            CaptionML = ENU = 'Transaction No.', FRA = 'N° transaction';
        }
        modify("Unrealized Amount")
        {
            CaptionML = ENU = 'Unrealized Amount', FRA = 'Taxe encaissement';
        }
        modify("Unrealized Base")
        {
            CaptionML = ENU = 'Unrealized Base', FRA = 'Base encaissement';
        }
        modify("Remaining Unrealized Amount")
        {
            CaptionML = ENU = 'Remaining Unrealized Amount', FRA = 'Taxe encaissement restante';
        }
        modify("Remaining Unrealized Base")
        {
            CaptionML = ENU = 'Remaining Unrealized Base', FRA = 'Base encaissement restante';
        }
        modify("External Document No.")
        {
            CaptionML = ENU = 'External Document No.', FRA = 'N° doc. externe';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Tax Area Code")
        {
            CaptionML = ENU = 'Tax Area Code', FRA = 'Code zone recouvrement';
        }
        modify("Tax Liable")
        {
            CaptionML = ENU = 'Tax Liable', FRA = 'Soumis à recouvrement';
        }
        modify("Tax Group Code")
        {
            CaptionML = ENU = 'Tax Group Code', FRA = 'Code groupe taxes';
        }
        modify("Use Tax")
        {
            CaptionML = ENU = 'Use Tax', FRA = 'Use Tax';
        }
        modify("Tax Jurisdiction Code")
        {
            CaptionML = ENU = 'Tax Jurisdiction Code', FRA = 'USA code autorités recouvrem.';
        }
        modify("Tax Group Used")
        {
            CaptionML = ENU = 'Tax Group Used', FRA = 'Groupe taxes utilisé';
        }
        modify("Tax Type")
        {
            CaptionML = ENU = 'Tax Type', FRA = 'Type taxe';
            OptionCaptionML = ENU = 'Sales Tax,Excise Tax', FRA = 'Sales Tax,Excise Tax';
        }
        modify("Tax on Tax")
        {
            CaptionML = ENU = 'Tax on Tax', FRA = 'Taxe sur taxe';
        }
        modify("Sales Tax Connection No.")
        {
            CaptionML = ENU = 'Sales Tax Connection No.', FRA = 'N° lien Sales Tax';
        }
        modify("Unrealized VAT Entry No.")
        {
            CaptionML = ENU = 'Unrealized VAT Entry No.', FRA = 'N° séq. TVA sur encaissement';
        }
        modify("VAT Bus. Posting Group")
        {
            CaptionML = ENU = 'VAT Bus. Posting Group', FRA = 'Groupe compta. marché TVA';
        }
        modify("VAT Prod. Posting Group")
        {
            CaptionML = ENU = 'VAT Prod. Posting Group', FRA = 'Groupe compta. produit TVA';
        }
        modify("Additional-Currency Amount")
        {
            CaptionML = ENU = 'Additional-Currency Amount', FRA = 'Montant DR';
        }
        modify("Additional-Currency Base")
        {
            CaptionML = ENU = 'Additional-Currency Base', FRA = 'Base DR';
        }
        modify("Add.-Currency Unrealized Amt.")
        {
            CaptionML = ENU = 'Add.-Currency Unrealized Amt.', FRA = 'Montant prévu DR';
        }
        modify("Add.-Currency Unrealized Base")
        {
            CaptionML = ENU = 'Add.-Currency Unrealized Base', FRA = 'Base prévue DR';
        }
        modify("VAT Base Discount %")
        {
            CaptionML = ENU = 'VAT Base Discount %', FRA = '% remise base TVA';
        }
        modify("Add.-Curr. Rem. Unreal. Amount")
        {
            CaptionML = ENU = 'Add.-Curr. Rem. Unreal. Amount', FRA = 'Taxe encaiss. rest. DR';
        }
        modify("Add.-Curr. Rem. Unreal. Base")
        {
            CaptionML = ENU = 'Add.-Curr. Rem. Unreal. Base', FRA = 'Base encaiss. rest. DR';
        }
        modify("VAT Difference")
        {
            CaptionML = ENU = 'VAT Difference', FRA = 'Différence TVA';
        }
        modify("Add.-Curr. VAT Difference")
        {
            CaptionML = ENU = 'Add.-Curr. VAT Difference', FRA = 'Différence TVA DR';
        }
        modify("Ship-to/Order Address Code")
        {

            //Unsupported feature: Change TableRelation on ""Ship-to/Order Address Code"(Field 53)". Please convert manually.

            CaptionML = ENU = 'Ship-to/Order Address Code', FRA = 'Code adresse destinataire/adresse de commande';
        }
        modify("Document Date")
        {
            CaptionML = ENU = 'Document Date', FRA = 'Date document';
        }
        modify("VAT Registration No.")
        {
            CaptionML = ENU = 'VAT Registration No.', FRA = 'N° identif. intracomm.';
        }
        modify(Reversed)
        {
            CaptionML = ENU = 'Reversed', FRA = 'Contre-passé';
        }
        modify("Reversed by Entry No.")
        {
            CaptionML = ENU = 'Reversed by Entry No.', FRA = 'Contre-passé par n° écriture';
        }
        modify("Reversed Entry No.")
        {
            CaptionML = ENU = 'Reversed Entry No.', FRA = 'N° écriture contre-passée';
        }
        modify("EU Service")
        {
            CaptionML = ENU = 'EU Service', FRA = 'Service UE';
        }

        //Unsupported feature: CodeModification on "Type(Field 7).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Type = Type::Settlement THEN
          ERROR(Text000,FIELDCAPTION(Type),Type);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if Type = Type::Settlement then
          ERROR(Text000,FIELDCAPTION(Type),Type);
        */
        //end;


        //Unsupported feature: CodeModification on ""Bill-to/Pay-to No."(Field 12).OnValidate". Please convert manually.

        //trigger "(Field 12)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE(Type);
        IF "Bill-to/Pay-to No." = '' THEN BEGIN
          "Country/Region Code" := '';
          "VAT Registration No." := '';
        end else
          CASE Type OF
            Type::Purchase:
              BEGIN
                Vend.GET("Bill-to/Pay-to No.");
                "Country/Region Code" := Vend."Country/Region Code";
                "VAT Registration No." := Vend."VAT Registration No.";
              end;
            Type::Sale:
              BEGIN
                Cust.GET("Bill-to/Pay-to No.");
                "Country/Region Code" := Cust."Country/Region Code";
                "VAT Registration No." := Cust."VAT Registration No.";
              end;
          end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        VALIDATE(Type);
        if "Bill-to/Pay-to No." = '' then begin
          "Country/Region Code" := '';
          "VAT Registration No." := '';
        end else
          case Type of
            Type::Purchase:
              begin
        #9..11
              end;
            Type::Sale:
              begin
        #15..17
              end;
          end;
        */
        //end;
        field(50000; "VAT Retention Base FND"; Boolean)
        {
            Caption = 'VAT Retention Base';
        }
        field(50001; "TIN No. FND"; Text[20])
        {
            CalcFormula = Lookup("VAT Product Posting Group"."TIN No. FND" where(Code = FIELD("VAT Prod. Posting Group")));
            Caption = 'TIN No.';
            Description = 'HEI.02';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Location Code FND"; Code[10])
        {
            CaptionML = ENU = 'Location Code',
                        FRA = 'Code magasin';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            TableRelation = Location where("Use As In-Transit" = CONST(false));
        }
        field(50003; "Region Code FND"; Code[20])
        {
            Caption = 'Region Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
            TableRelation = Location;
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You cannot change the contents of this field when %1 is %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You cannot change the contents of this field when %1 is %2.;FRA=Vous ne pouvez pas modifier le contenu de ce champ quand %1 est %2.;
    //Variable type has not been exported.

    var
        CompanyInfo: Record "Company Information";
        Text000: TextConst ENU = 'You cannot change the contents of this field when %1 is %2.', FRA = 'Vous ne pouvez pas modifier le contenu de ce champ quand %1 est %2.';

    procedure CheckDelayedUnrealVATType();
    var
        TaxJurisdiction: Record "Tax Jurisdiction";
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        //HEI.03>>
        CompanyInfo.GET();
        IF NOT CompanyInfo."Enable French Localization FND" THEN
            EXIT;

        IF "VAT Calculation Type" = "VAT Calculation Type"::"Sales Tax" THEN BEGIN
            TaxJurisdiction.GET("Tax Jurisdiction Code");
            TaxJurisdiction.TESTFIELD("Unrealized VAT Type", TaxJurisdiction."Unrealized VAT Type"::Percentage);
        end else BEGIN
            VATPostingSetup.GET("VAT Bus. Posting Group", "VAT Prod. Posting Group");
            VATPostingSetup.TESTFIELD("Unrealized VAT Type", VATPostingSetup."Unrealized VAT Type"::Percentage);
        end;
        //HEI.03<<
    end;

    procedure GetUnrealizedVATPartFRLoc(SettledAmount: Decimal; Paid: Decimal; Full: Decimal; TotalUnrealVATAmountFirst: Decimal; TotalUnrealVATAmountLast: Decimal; DelayedUnrealizedVAT: Boolean; RealizeVAT: Boolean): Decimal;
    var
        UnrealizedVATType: Option " ",Percentage,First,Last,"First (Fully Paid)","Last (Fully Paid)";
    begin
        //HEI.03>>
        CompanyInfo.GET();
        IF NOT CompanyInfo."Enable French Localization FND" THEN
            EXIT;

        IF (Type.AsInteger() <> 0) AND
           (Amount = 0) AND
           (Base = 0)
        THEN BEGIN
            UnrealizedVATType := GetUnrealizedVATType();
            IF (UnrealizedVATType = UnrealizedVATType::" ") OR
               (("Remaining Unrealized Amount" = 0) AND
                ("Remaining Unrealized Base" = 0))
            THEN
                EXIT(0);

            IF DelayedUnrealizedVAT AND RealizeVAT THEN
                CheckDelayedUnrealVATType();

            IF ABS(Paid) = ABS(Full) THEN
                EXIT(1);

            CASE UnrealizedVATType OF
                UnrealizedVATType::Percentage:
                    BEGIN
                        IF ABS(Full) = ABS(Paid) - ABS(SettledAmount) THEN
                            EXIT(1);
                        EXIT(ABS(SettledAmount) / (ABS(Full) - (ABS(Paid) - ABS(SettledAmount))));
                    end;
                UnrealizedVATType::First:
                    BEGIN
                        IF "VAT Calculation Type" = "VAT Calculation Type"::"Reverse Charge VAT" THEN
                            EXIT(1);
                        IF ABS(Paid) < ABS(TotalUnrealVATAmountFirst) THEN
                            EXIT(ABS(SettledAmount) / ABS(TotalUnrealVATAmountFirst));
                        EXIT(1);
                    end;
                UnrealizedVATType::"First (Fully Paid)":
                    BEGIN
                        IF "VAT Calculation Type" = "VAT Calculation Type"::"Reverse Charge VAT" THEN
                            EXIT(1);
                        IF ABS(Paid) < ABS(TotalUnrealVATAmountFirst) THEN
                            EXIT(0);
                        EXIT(1);
                    end;
                UnrealizedVATType::"Last (Fully Paid)":
                    EXIT(0);
                UnrealizedVATType::Last:
                    BEGIN
                        IF "VAT Calculation Type" = "VAT Calculation Type"::"Reverse Charge VAT" THEN
                            EXIT(0);
                        IF ABS(Paid) > ABS(Full) - ABS(TotalUnrealVATAmountLast) THEN
                            EXIT((ABS(Paid) - (ABS(Full) - ABS(TotalUnrealVATAmountLast))) / ABS(TotalUnrealVATAmountLast));
                        EXIT(0);
                    end;
            end;
        end else
            EXIT(0);
        //HEI.03<<
    end;

    procedure SetVATDateFromGenJnlLine(GenJnlLine: Record "Gen. Journal Line")
    begin
        if GenJnlLine."VAT Reporting Date" = 0D then
            "VAT Reporting Date" := GLSetup.GetVATDate(GenJnlLine."Posting Date", GenJnlLine."Document Date")
        else
            "VAT Reporting Date" := GenJnlLine."VAT Reporting Date";
    end;

    //BC UPGRADE GUPTAK03 WHT functions migrated -- >>
    LOCAL PROCEDURE GetWHTAmount(DocumentNo: Code[20]; var WHTAmount: Decimal);
    VAR
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        WHTEntry: Record "WHT Entry FND";
        WHTAmount1: Decimal;
    BEGIN
        SalesCrMemoHeader.SETRANGE("Applies-to Doc. Type", SalesCrMemoHeader."Applies-to Doc. Type"::Invoice);
        SalesCrMemoHeader.SETRANGE("Applies-to Doc. No.", DocumentNo);
        IF SalesCrMemoHeader.FINDFIRST() THEN BEGIN
            WHTAmount1 := 0;
            WHTEntry.RESET();
            WHTEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");
            WHTEntry.SETRANGE("Applies-to Entry No.", 0);
            IF WHTEntry.FIND('-') THEN
                REPEAT
                    WHTAmount1 += WHTEntry."Unrealized Amount (LCY)";
                UNTIL WHTEntry.NEXT() = 0;
            GLSetup.GET();
        END;
        WHTAmount := WHTAmount - WHTAmount1;
    END;

    PROCEDURE GetCustUnrealizedVATPart(SettledAmount: Decimal; Paid: Decimal; Full: Decimal; TotalUnrealVATAmountFirst: Decimal; TotalUnrealVATAmountLast: Decimal; CustLedgEntry: Record 21; GenJnlLine: Record 81; WHTAmount: Decimal): Decimal;
    VAR
        UnrealizedVATType: Option "",Percentage,First,Last,"First (Fully Paid)","Last (Fully Paid)";
        DiscPercent: Decimal;
        WHTDiscount: Decimal;
    BEGIN
        IF (Type <> 0) AND
           (Amount = 0) AND
           (Base = 0)
        THEN BEGIN
            UnrealizedVATType := GetUnrealizedVATType();
            IF ABS(Paid) = ABS(Full) THEN
                EXIT(1);

            IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::Refund THEN
                WHTAmount := 0
            ELSE
                IF GLSetup."Manual Sales WHT Calc. FND" THEN
                    GetWHTAmount(CustLedgEntry."Document No.", WHTAmount);

            IF (UnrealizedVATType > 0) AND
               (("Remaining Unrealized Amount" <> 0) OR
                ("Remaining Unrealized Base" <> 0))
            THEN
                CASE UnrealizedVATType OF
                    UnrealizedVATType::Percentage:
                        BEGIN
                            GLSetup.GET();
                            IF GLSetup."Manual Sales WHT Calc. FND" THEN BEGIN
                                IF ABS(SettledAmount) < ABS(Full) THEN BEGIN
                                    IF GenJnlLine."Posting Date" <= CustLedgEntry."Pmt. Discount Date" THEN BEGIN
                                        DiscPercent := (CustLedgEntry."Original Pmt. Disc. Possible" / Full) * 100;
                                        WHTDiscount := WHTAmount * (DiscPercent / 100);
                                    END;
                                    IF ABS(CustLedgEntry."Rem. Amt for WHT FND") < ABS(CustLedgEntry."Rem. Amt FND") THEN BEGIN
                                        IF ABS(GenJnlLine.Amount) < (Full + WHTAmount) THEN BEGIN
                                            IF GenJnlLine."Posting Date" <= CustLedgEntry."Pmt. Discount Date" THEN
                                                EXIT(-SettledAmount / (Full + WHTAmount + Full));
                                            EXIT(-SettledAmount / (Full + WHTAmount));
                                        END;
                                        EXIT(-SettledAmount / (Full + WHTAmount - WHTDiscount));
                                    END;
                                    IF ABS(GenJnlLine.Amount) = (Full + WHTAmount) THEN BEGIN
                                        IF GenJnlLine."Posting Date" <= CustLedgEntry."Pmt. Discount Date" THEN
                                            EXIT(-SettledAmount / (Full + WHTAmount + CustLedgEntry."Original Pmt. Disc. Possible"));
                                        EXIT(-SettledAmount / (Full + WHTAmount));
                                    END;
                                    IF (GenJnlLine."Posting Date" <= CustLedgEntry."Pmt. Discount Date") AND
                                       (CustLedgEntry."Original Pmt. Disc. Possible" <> 0)
                                    THEN
                                        EXIT(
                                          -(SettledAmount + CustLedgEntry."Original Pmt. Disc. Possible") /
                                          (Full - CustLedgEntry."Original Pmt. Disc. Possible"));
                                    IF ABS(GenJnlLine.Amount) = (Full - CustLedgEntry."Remaining Amt. (LCY)") THEN
                                        EXIT(1);
                                    EXIT(-SettledAmount / Full);
                                END;
                                IF (GenJnlLine."Posting Date" <= CustLedgEntry."Pmt. Discount Date") AND
                                   (CustLedgEntry."Original Pmt. Disc. Possible" <> 0)
                                THEN BEGIN
                                    IF ABS(SettledAmount + CustLedgEntry."Original Pmt. Disc. Possible") =
                                       ABS(CustLedgEntry."Remaining Amt. (LCY)")
                                    THEN
                                        EXIT(1);
                                    EXIT(
                                      -(SettledAmount + CustLedgEntry."Original Pmt. Disc. Possible") /
                                      (CustLedgEntry."Remaining Amt. (LCY)" - CustLedgEntry."Original Pmt. Disc. Possible"));
                                END;
                                EXIT(-SettledAmount / CustLedgEntry."Remaining Amt. (LCY)");
                            END;
                            EXIT(ABS(SettledAmount) / (ABS(Full) - (ABS(Paid) - ABS(SettledAmount))));
                        END;
                    UnrealizedVATType::First:
                        BEGIN
                            IF "VAT Calculation Type" = "VAT Calculation Type"::"Reverse Charge VAT" THEN
                                EXIT(1);
                            IF ABS(Paid) < ABS(TotalUnrealVATAmountFirst) THEN
                                EXIT(ABS(SettledAmount) / ABS(TotalUnrealVATAmountFirst));
                            EXIT(1);
                        END;
                    UnrealizedVATType::"First (Fully Paid)":
                        BEGIN
                            IF "VAT Calculation Type" = "VAT Calculation Type"::"Reverse Charge VAT" THEN
                                EXIT(1);
                            IF ABS(Paid) < ABS(TotalUnrealVATAmountFirst) THEN
                                EXIT(0);
                            EXIT(1);
                        END;
                    UnrealizedVATType::"Last (Fully Paid)":
                        EXIT(0);
                    UnrealizedVATType::Last:
                        BEGIN
                            IF "VAT Calculation Type" = "VAT Calculation Type"::"Reverse Charge VAT" THEN
                                EXIT(0);
                            IF ABS(Paid) > ABS(Full) - ABS(TotalUnrealVATAmountLast) THEN
                                EXIT((ABS(Paid) - (ABS(Full) - ABS(TotalUnrealVATAmountLast))) / ABS(TotalUnrealVATAmountLast));
                            EXIT(0);
                        END;
                END
            ELSE
                EXIT(-1);
        END ELSE
            EXIT(-1);
    END;
    //BC UPGRADE GUPTAK03 WHT functions migrated -- <<

    var
        GLSetup: Record "General Ledger Setup";
}


