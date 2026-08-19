table 50138 "Gen. Journal Line BC FND"
{
    // version HEI.01

    // HEI.01 V1.05 HT84 IBM POENAB02 04.07.2019 # New table for Bank Connectivity interface
    // HEI.02 CHG2022329 IBM POENAB02 06.02.2020 # WHT
    //   # New fields:
    //     # 50066 WHT Amount
    //     # 50067 WHT Amount (LCY)

    // BC Upgrade SHUKLP03 >> Document subtype table relation added.


    CaptionML = ENU = 'Gen. Journal Line BC',
                FRA = 'Ligne feuille comptabilité BC';
    Permissions = TableData "Data Exch. Field" = rimd;

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            CaptionML = ENU = 'Journal Template Name',
                        FRA = 'Nom modèle feuille';
            TableRelation = "Gen. Journal Template";
        }
        field(2; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.',
                        FRA = 'N° ligne';
        }
        field(3; "Account Type"; Option)
        {
            CaptionML = ENU = 'Account Type',
                        FRA = 'Type compte';
            OptionCaptionML = ENU = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner',
                              FRA = 'Général,Client,Fournisseur,Banque,Immobilisation,Partenaire IC';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(4; "Account No."; Code[20])
        {
            CaptionML = ENU = 'Account No.',
                        FRA = 'N° compte';
            /*TableRelation = IF ("Account Type"=CONST("G/L Account")) "G/L Account" WHERE ("Account Type"=CONST(Posting),
                                                                                          Blocked=CONST(false),
                                                                                          "DIT Sub-Contract Posting Type"=FIELD("DIT Sub-Contr.Pst. Type Filter"))
                                                                                          else IF ("Account Type"=CONST(Customer)) Customer
                                                                                          else IF ("Account Type"=CONST(Vendor)) Vendor
                                                                                          else IF ("Account Type"=CONST("Bank Account")) "Bank Account"
                                                                                          else IF ("Account Type"=CONST("Fixed Asset")) "Fixed Asset" WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contr.Pst. Type Filter"))
                                                                                          else IF ("Account Type"=CONST("IC Partner")) "IC Partner";*/  // BC Upgrade NANDIS03
        }
        field(5; "Posting Date"; Date)
        {
            CaptionML = ENU = 'Posting Date',
                        FRA = 'Date comptabilisation';
            ClosingDates = true;
        }
        field(6; "Document Type"; Option)
        {
            CaptionML = ENU = 'Document Type',
                        FRA = 'Type document';
            OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back,Purchase Receipt,Interest Rate Credit,RPM Damage / Loss,FFE Security Payment',
                              FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement,,,,,Banque inverse,Charge bancaire,Paiment prêt,Rembousement prêt,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,,,,,"Bank Reverse","Bank Charge","Loan Pay Out","Loan Pay Back","Purchase Receipt","Interest Rate Credit","RPM Damage or Loss","FFE Security Payment";

            trigger OnValidate();
            var
                Cust: Record Customer;
                Vend: Record Vendor;
            begin
            end;
        }
        field(7; "Document No."; Code[20])
        {
            CaptionML = ENU = 'Document No.',
                        FRA = 'N° document';
        }
        field(8; Description; Text[50])
        {
            CaptionML = ENU = 'Description',
                        FRA = 'Désignation';
        }
        field(10; "VAT %"; Decimal)
        {
            CaptionML = ENU = 'VAT %',
                        FRA = '% TVA';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(11; "Bal. Account No."; Code[20])
        {
            CaptionML = ENU = 'Bal. Account No.',
                        FRA = 'N° compte contrepartie';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account" where("Account Type" = CONST(Posting),
                                                                                               Blocked = CONST(false))
            else IF ("Bal. Account Type" = CONST(Customer)) Customer
            else IF ("Bal. Account Type" = CONST(Vendor)) Vendor
            else IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account"
            else IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            else IF ("Bal. Account Type" = CONST("IC Partner")) "IC Partner";
        }
        field(12; "Currency Code"; Code[10])
        {
            CaptionML = ENU = 'Currency Code',
                        FRA = 'Code devise';
            TableRelation = Currency;

            trigger OnValidate();
            var
                BankAcc: Record "Bank Account";
            begin
            end;
        }
        field(13; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU = 'Amount',
                        FRA = 'Montant';
        }
        field(14; "Debit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CaptionML = ENU = 'Debit Amount',
                        FRA = 'Montant débit';
        }
        field(15; "Credit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CaptionML = ENU = 'Credit Amount',
                        FRA = 'Montant crédit';
        }
        field(16; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Amount (LCY)',
                        FRA = 'Montant DS';
        }
        field(17; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Balance (LCY)',
                        FRA = 'Solde DS';
            Editable = false;
        }
        field(18; "Currency Factor"; Decimal)
        {
            CaptionML = ENU = 'Currency Factor',
                        FRA = 'Facteur devise';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(19; "Sales/Purch. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Sales/Purch. (LCY)',
                        FRA = 'Ventes/Achats DS';
        }
        field(20; "Profit (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Profit (LCY)',
                        FRA = 'Marge DS';
        }
        field(21; "Inv. Discount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Inv. Discount (LCY)',
                        FRA = 'Remise facture DS';
        }
        field(22; "Bill-to/Pay-to No."; Code[20])
        {
            CaptionML = ENU = 'Bill-to/Pay-to No.',
                        FRA = 'N° client facturé/personne à payer';
            Editable = false;
            TableRelation = IF ("Account Type" = CONST(Customer)) Customer
            else IF ("Bal. Account Type" = CONST(Customer)) Customer
            else IF ("Account Type" = CONST(Vendor)) Vendor
            else IF ("Bal. Account Type" = CONST(Vendor)) Vendor;
        }
        field(23; "Posting Group"; Code[10])
        {
            CaptionML = ENU = 'Posting Group',
                        FRA = 'Groupe comptabilisation';
            Editable = true;
            TableRelation = IF ("Account Type" = CONST(Customer)) "Customer Posting Group"
            else IF ("Account Type" = CONST(Vendor)) "Vendor Posting Group"
            else IF ("Account Type" = CONST("Fixed Asset")) "FA Posting Group";
        }
        field(24; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            CaptionML = ENU = 'Shortcut Dimension 1 Code',
                        FRA = 'Code raccourci axe 1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(1));
        }
        field(25; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            CaptionML = ENU = 'Shortcut Dimension 2 Code',
                        FRA = 'Code raccourci axe 2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(2));
        }
        field(26; "Salespers./Purch. Code"; Code[10])
        {
            CaptionML = ENU = 'Salespers./Purch. Code',
                        FRA = 'Code vendeur/acheteur';
            TableRelation = "Salesperson/Purchaser";
        }
        field(29; "Source Code"; Code[10])
        {
            CaptionML = ENU = 'Source Code',
                        FRA = 'Code journal';
            Editable = false;
            TableRelation = "Source Code";
        }
        field(30; "System-Created Entry"; Boolean)
        {
            CaptionML = ENU = 'System-Created Entry',
                        FRA = 'Écriture système';
            Editable = false;
        }
        field(34; "On Hold"; Code[3])
        {
            CaptionML = ENU = 'On Hold',
                        FRA = 'En attente';
        }
        field(35; "Applies-to Doc. Type"; Option)
        {
            CaptionML = ENU = 'Applies-to Doc. Type',
                        FRA = 'Type doc. lettrage';
            OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back',
                              FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,,,,,"Bank Reverse","Bank Charge","Loan Pay Out","Loan Pay Back";
        }
        field(36; "Applies-to Doc. No."; Code[20])
        {
            CaptionML = ENU = 'Applies-to Doc. No.',
                        FRA = 'N° doc. lettrage';

            trigger OnLookup();
            var
                PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
                AccNo: Code[20];
                AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
            begin
            end;

            trigger OnValidate();
            var
                CustLedgEntry: Record "Cust. Ledger Entry";
                TempGenJnlLine: Record "Gen. Journal Line" temporary;
                VendLedgEntry: Record "Vendor Ledger Entry";
            begin
            end;
        }
        field(38; "Due Date"; Date)
        {
            CaptionML = ENU = 'Due Date',
                        FRA = 'Date d''échéance';
        }
        field(39; "Pmt. Discount Date"; Date)
        {
            CaptionML = ENU = 'Pmt. Discount Date',
                        FRA = 'Date d''escompte';
        }
        field(40; "Payment Discount %"; Decimal)
        {
            CaptionML = ENU = 'Payment Discount %',
                        FRA = '% escompte';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(42; "Job No."; Code[20])
        {
            CaptionML = ENU = 'Job No.',
                        FRA = 'N° projet';
            TableRelation = Job;
        }
        field(43; Quantity; Decimal)
        {
            CaptionML = ENU = 'Quantity',
                        FRA = 'Quantité';
            DecimalPlaces = 0 : 5;
        }
        field(44; "VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU = 'VAT Amount',
                        FRA = 'Montant TVA';
        }
        field(45; "VAT Posting"; Option)
        {
            CaptionML = ENU = 'VAT Posting',
                        FRA = 'Comptabilisation TVA';
            Editable = false;
            OptionCaptionML = ENU = 'Automatic VAT Entry,Manual VAT Entry',
                              FRA = 'Automatique,Manuel';
            OptionMembers = "Automatic VAT Entry","Manual VAT Entry";
        }
        field(47; "Payment Terms Code"; Code[10])
        {
            CaptionML = ENU = 'Payment Terms Code',
                        FRA = 'Code condition paiement';
            TableRelation = "Payment Terms";
        }
        field(48; "Applies-to ID"; Code[50])
        {
            CaptionML = ENU = 'Applies-to ID',
                        FRA = 'ID lettrage';
        }
        field(50; "Business Unit Code"; Code[10])
        {
            CaptionML = ENU = 'Business Unit Code',
                        FRA = 'Code centre de profit';
            TableRelation = "Business Unit";
        }
        field(51; "Journal Batch Name"; Code[10])
        {
            CaptionML = ENU = 'Journal Batch Name',
                        FRA = 'Nom feuille';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(52; "Reason Code"; Code[10])
        {
            CaptionML = ENU = 'Reason Code',
                        FRA = 'Code motif';
            TableRelation = "Reason Code";
        }
        field(53; "Recurring Method"; Option)
        {
            BlankZero = true;
            CaptionML = ENU = 'Recurring Method',
                        FRA = 'Mode abonnement';
            OptionCaptionML = ENU = ' ,F  Fixed,V  Variable,B  Balance,RF Reversing Fixed,RV Reversing Variable,RB Reversing Balance',
                              FRA = ' ,F Fixe,V Variable,S Solde,FI Fixe inverse,VI Variable inverse,SI Solde inverse';
            OptionMembers = " ","F  Fixed","V  Variable","B  Balance","RF Reversing Fixed","RV Reversing Variable","RB Reversing Balance";
        }
        field(54; "Expiration Date"; Date)
        {
            CaptionML = ENU = 'Expiration Date',
                        FRA = 'Date d''expiration';
        }
        field(55; "Recurring Frequency"; DateFormula)
        {
            CaptionML = ENU = 'Recurring Frequency',
                        FRA = 'Périodicité abonnement';
        }
        field(56; "Allocated Amt. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Gen. Jnl. Allocation".Amount where("Journal Template Name" = FIELD("Journal Template Name"),
                                                                   "Journal Batch Name" = FIELD("Journal Batch Name"),
                                                                   "Journal Line No." = FIELD("Line No.")));
            CaptionML = ENU = 'Allocated Amt. (LCY)',
                        FRA = 'Montant imputé DS';
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; "Gen. Posting Type"; Option)
        {
            CaptionML = ENU = 'Gen. Posting Type',
                        FRA = 'Type compta. TVA';
            OptionCaptionML = ENU = ' ,Purchase,Sale,Settlement',
                              FRA = ' ,Achat,Vente,Règlement';
            OptionMembers = " ",Purchase,Sale,Settlement;
        }
        field(58; "Gen. Bus. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group',
                        FRA = 'Groupe compta. marché';
            TableRelation = "Gen. Business Posting Group";
        }
        field(59; "Gen. Prod. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group',
                        FRA = 'Groupe compta. produit';
            TableRelation = "Gen. Product Posting Group";
        }
        field(60; "VAT Calculation Type"; Option)
        {
            CaptionML = ENU = 'VAT Calculation Type',
                        FRA = 'Mode calcul TVA';
            Editable = false;
            OptionCaptionML = ENU = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax',
                              FRA = 'Normal,Intracomm.,Correctif,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(61; "EU 3-Party Trade"; Boolean)
        {
            CaptionML = ENU = 'EU 3-Party Trade',
                        FRA = 'Trans. tripartite UE';
            Editable = false;
        }
        field(62; "Allow Application"; Boolean)
        {
            CaptionML = ENU = 'Allow Application',
                        FRA = 'Lettrable';
            InitValue = true;
        }
        field(63; "Bal. Account Type"; Option)
        {
            CaptionML = ENU = 'Bal. Account Type',
                        FRA = 'Type compte contrepartie';
            OptionCaptionML = ENU = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner',
                              FRA = 'Général,Client,Fournisseur,Banque,Immobilisation,Partenaire IC';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(64; "Bal. Gen. Posting Type"; Option)
        {
            CaptionML = ENU = 'Bal. Gen. Posting Type',
                        FRA = 'Type compta. contrepartie';
            OptionCaptionML = ENU = ' ,Purchase,Sale,Settlement',
                              FRA = ' ,Achat,Vente,Règlement';
            OptionMembers = " ",Purchase,Sale,Settlement;
        }
        field(65; "Bal. Gen. Bus. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'Bal. Gen. Bus. Posting Group',
                        FRA = 'Groupe compta. marché contr.';
            TableRelation = "Gen. Business Posting Group";
        }
        field(66; "Bal. Gen. Prod. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'Bal. Gen. Prod. Posting Group',
                        FRA = 'Groupe compta. produit contr.';
            TableRelation = "Gen. Product Posting Group";
        }
        field(67; "Bal. VAT Calculation Type"; Option)
        {
            CaptionML = ENU = 'Bal. VAT Calculation Type',
                        FRA = 'Mode calcul TVA contrepartie';
            Editable = false;
            OptionCaptionML = ENU = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax',
                              FRA = 'Normal,Intracomm.,Correctif,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(68; "Bal. VAT %"; Decimal)
        {
            CaptionML = ENU = 'Bal. VAT %',
                        FRA = '% TVA contrepartie';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(69; "Bal. VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU = 'Bal. VAT Amount',
                        FRA = 'Montant TVA contrepartie';
        }
        field(70; "Bank Payment Type"; Option)
        {
            AccessByPermission = TableData "Bank Account" = R;
            CaptionML = ENU = 'Bank Payment Type',
                        FRA = 'Mode émission paiement';
            OptionCaptionML = ENU = ' ,Computer Check,Manual Check',
                              FRA = ' ,Informatique,Manuel';
            OptionMembers = " ","Computer Check","Manual Check";
        }
        field(71; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU = 'VAT Base Amount',
                        FRA = 'Montant base TVA';
        }
        field(72; "Bal. VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU = 'Bal. VAT Base Amount',
                        FRA = 'Montant base TVA contrepartie';
        }
        field(73; Correction; Boolean)
        {
            CaptionML = ENU = 'Correction',
                        FRA = 'Correction';
        }
        field(75; "Check Printed"; Boolean)
        {
            AccessByPermission = TableData "Check Ledger Entry" = R;
            CaptionML = ENU = 'Check Printed',
                        FRA = 'Chèque imprimé';
            Editable = false;
        }
        field(76; "Document Date"; Date)
        {
            CaptionML = ENU = 'Document Date',
                        FRA = 'Date document';
            ClosingDates = true;
        }
        field(77; "External Document No."; Code[35])
        {
            CaptionML = ENU = 'External Document No.',
                        FRA = 'N° doc. externe';
        }
        field(78; "Source Type"; Option)
        {
            CaptionML = ENU = 'Source Type',
                        FRA = 'Type origine';
            OptionCaptionML = ENU = ' ,Customer,Vendor,Bank Account,Fixed Asset',
                              FRA = ' ,Client,Fournisseur,Banque,Immobilisation';
            OptionMembers = " ",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(79; "Source No."; Code[20])
        {
            CaptionML = ENU = 'Source No.',
                        FRA = 'N° origine';
            TableRelation = IF ("Source Type" = CONST(Customer)) Customer
            else IF ("Source Type" = CONST(Vendor)) Vendor
            else IF ("Source Type" = CONST("Bank Account")) "Bank Account"
            else IF ("Source Type" = CONST("Fixed Asset")) "Fixed Asset";
        }
        field(80; "Posting No. Series"; Code[10])
        {
            CaptionML = ENU = 'Posting No. Series',
                        FRA = 'Souches de n° validation';
            TableRelation = "No. Series";
        }
        field(82; "Tax Area Code"; Code[20])
        {
            CaptionML = ENU = 'Tax Area Code',
                        FRA = 'Code zone recouvrement';
            TableRelation = "Tax Area";
        }
        field(83; "Tax Liable"; Boolean)
        {
            CaptionML = ENU = 'Tax Liable',
                        FRA = 'Soumis à recouvrement';
        }
        field(84; "Tax Group Code"; Code[10])
        {
            CaptionML = ENU = 'Tax Group Code',
                        FRA = 'Code groupe taxes';
            TableRelation = "Tax Group";
        }
        field(85; "Use Tax"; Boolean)
        {
            CaptionML = ENU = 'Use Tax',
                        FRA = 'Use Tax';
        }
        field(86; "Bal. Tax Area Code"; Code[20])
        {
            CaptionML = ENU = 'Bal. Tax Area Code',
                        FRA = 'Code zone recouvrement contr.';
            TableRelation = "Tax Area";
        }
        field(87; "Bal. Tax Liable"; Boolean)
        {
            CaptionML = ENU = 'Bal. Tax Liable',
                        FRA = 'Soumis à recouvrement contr.';
        }
        field(88; "Bal. Tax Group Code"; Code[10])
        {
            CaptionML = ENU = 'Bal. Tax Group Code',
                        FRA = 'Code groupe taxes contrepartie';
            TableRelation = "Tax Group";
        }
        field(89; "Bal. Use Tax"; Boolean)
        {
            CaptionML = ENU = 'Bal. Use Tax',
                        FRA = 'Use Tax contrepartie';
        }
        field(90; "VAT Bus. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'VAT Bus. Posting Group',
                        FRA = 'Groupe compta. marché TVA';
            TableRelation = "VAT Business Posting Group";
        }
        field(91; "VAT Prod. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'VAT Prod. Posting Group',
                        FRA = 'Groupe compta. produit TVA';
            TableRelation = "VAT Product Posting Group";
        }
        field(92; "Bal. VAT Bus. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'Bal. VAT Bus. Posting Group',
                        FRA = 'Gpe compta. marché TVA contr.';
            TableRelation = "VAT Business Posting Group";
        }
        field(93; "Bal. VAT Prod. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'Bal. VAT Prod. Posting Group',
                        FRA = 'Gpe compta. produit TVA contr.';
            TableRelation = "VAT Product Posting Group";
        }
        field(95; "Additional-Currency Posting"; Option)
        {
            CaptionML = ENU = 'Additional-Currency Posting',
                        FRA = 'Comptabilisation devise report';
            Editable = false;
            OptionCaptionML = ENU = 'None,Amount Only,Additional-Currency Amount Only',
                              FRA = 'Aucun,Montant seulement,Montant DR seulement';
            OptionMembers = "None","Amount Only","Additional-Currency Amount Only";
        }
        field(98; "FA Add.-Currency Factor"; Decimal)
        {
            CaptionML = ENU = 'FA Add.-Currency Factor',
                        FRA = 'Facteur devise immo.';
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }
        field(99; "Source Currency Code"; Code[10])
        {
            CaptionML = ENU = 'Source Currency Code',
                        FRA = 'Code devise origine';
            Editable = false;
            TableRelation = Currency;
        }
        field(100; "Source Currency Amount"; Decimal)
        {
            AccessByPermission = TableData Currency = R;
            AutoFormatType = 1;
            CaptionML = ENU = 'Source Currency Amount',
                        FRA = 'Montant devise origine';
            Editable = false;
        }
        field(101; "Source Curr. VAT Base Amount"; Decimal)
        {
            AccessByPermission = TableData Currency = R;
            AutoFormatType = 1;
            CaptionML = ENU = 'Source Curr. VAT Base Amount',
                        FRA = 'Montant base TVA devise origine';
            Editable = false;
        }
        field(102; "Source Curr. VAT Amount"; Decimal)
        {
            AccessByPermission = TableData Currency = R;
            AutoFormatType = 1;
            CaptionML = ENU = 'Source Curr. VAT Amount',
                        FRA = 'Montant TVA devise origine';
            Editable = false;
        }
        field(103; "VAT Base Discount %"; Decimal)
        {
            CaptionML = ENU = 'VAT Base Discount %',
                        FRA = '% remise base TVA';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(104; "VAT Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'VAT Amount (LCY)',
                        FRA = 'Montant TVA DS';
            Editable = false;
        }
        field(105; "VAT Base Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'VAT Base Amount (LCY)',
                        FRA = 'Montant base TVA DS';
            Editable = false;
        }
        field(106; "Bal. VAT Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Bal. VAT Amount (LCY)',
                        FRA = 'Montant TVA contr. DS';
            Editable = false;
        }
        field(107; "Bal. VAT Base Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Bal. VAT Base Amount (LCY)',
                        FRA = 'Mont. base TVA contr. DS';
            Editable = false;
        }
        field(108; "Reversing Entry"; Boolean)
        {
            CaptionML = ENU = 'Reversing Entry',
                        FRA = 'Ecriture opposée';
            Editable = false;
        }
        field(109; "Allow Zero-Amount Posting"; Boolean)
        {
            CaptionML = ENU = 'Allow Zero-Amount Posting',
                        FRA = 'Autoriser compta. montant nul';
            Editable = false;
        }
        field(110; "Ship-to/Order Address Code"; Code[10])
        {
            CaptionML = ENU = 'Ship-to/Order Address Code',
                        FRA = 'Code adresse destinataire/adresse de commande';
            TableRelation = IF ("Account Type" = CONST(Customer)) "Ship-to Address".Code where("Customer No." = FIELD("Bill-to/Pay-to No."))
            else IF ("Account Type" = CONST(Vendor)) "Order Address".Code where("Vendor No." = FIELD("Bill-to/Pay-to No."))
            else IF ("Bal. Account Type" = CONST(Customer)) "Ship-to Address".Code where("Customer No." = FIELD("Bill-to/Pay-to No."))
            else IF ("Bal. Account Type" = CONST(Vendor)) "Order Address".Code where("Vendor No." = FIELD("Bill-to/Pay-to No."));
        }
        field(111; "VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU = 'VAT Difference',
                        FRA = 'Différence TVA';
            Editable = false;
        }
        field(112; "Bal. VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU = 'Bal. VAT Difference',
                        FRA = 'Différence TVA contrepartie';
            Editable = false;
        }
        field(113; "IC Partner Code"; Code[20])
        {
            CaptionML = ENU = 'IC Partner Code',
                        FRA = 'Code du partenaire IC';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(114; "IC Direction"; Option)
        {
            CaptionML = ENU = 'IC Direction',
                        FRA = 'Direction IC';
            OptionCaptionML = ENU = 'Outgoing,Incoming',
                              FRA = 'Sortant,Entrant';
            OptionMembers = Outgoing,Incoming;
        }
        field(116; "IC Partner G/L Acc. No."; Code[20])
        {
            CaptionML = ENU = 'IC Partner G/L Acc. No.',
                        FRA = 'N° cpte gén partenaire IC';
            TableRelation = "IC G/L Account";

            trigger OnValidate();
            var
                ICGLAccount: Record "IC G/L Account";
            begin
            end;
        }
        field(117; "IC Partner Transaction No."; Integer)
        {
            CaptionML = ENU = 'IC Partner Transaction No.',
                        FRA = 'N° transaction partenaire IC';
            Editable = false;
        }
        field(118; "Sell-to/Buy-from No."; Code[20])
        {
            CaptionML = ENU = 'Sell-to/Buy-from No.',
                        FRA = 'N° donneur d''ordre/fournisseur';
            TableRelation = IF ("Account Type" = CONST(Customer)) Customer
            else IF ("Bal. Account Type" = CONST(Customer)) Customer
            else IF ("Account Type" = CONST(Vendor)) Vendor
            else IF ("Bal. Account Type" = CONST(Vendor)) Vendor;
        }
        field(119; "VAT Registration No."; Text[20])
        {
            CaptionML = ENU = 'VAT Registration No.',
                        FRA = 'N° identif. intracomm.';

            trigger OnValidate();
            var
                VATRegNoFormat: Record "VAT Registration No. Format";
            begin
            end;
        }
        field(120; "Country/Region Code"; Code[10])
        {
            CaptionML = ENU = 'Country/Region Code',
                        FRA = 'Code pays/région';
            TableRelation = "Country/Region";
        }
        field(121; Prepayment; Boolean)
        {
            CaptionML = ENU = 'Prepayment',
                        FRA = 'Acompte';
        }
        field(122; "Financial Void"; Boolean)
        {
            CaptionML = ENU = 'Financial Void',
                        FRA = 'Annulation financière';
            Editable = false;
        }
        field(165; "Incoming Document Entry No."; Integer)
        {
            CaptionML = ENU = 'Incoming Document Entry No.',
                        FRA = 'N° de séquence du document entrant';
            TableRelation = "Incoming Document";

            trigger OnValidate();
            var
                IncomingDocument: Record "Incoming Document";
            begin
            end;
        }
        field(170; "Creditor No."; Code[20])
        {
            CaptionML = ENU = 'Creditor No.',
                        FRA = 'N° créditeur';
            Numeric = true;
        }
        field(171; "Payment Reference"; Code[50])
        {
            CaptionML = ENU = 'Payment Reference',
                        FRA = 'Référence paiement';
            Numeric = true;
        }
        field(172; "Payment Method Code"; Code[10])
        {
            CaptionML = ENU = 'Payment Method Code',
                        FRA = 'Code mode de règlement';
            TableRelation = "Payment Method";
        }
        field(173; "Applies-to Ext. Doc. No."; Code[35])
        {
            CaptionML = ENU = 'Applies-to Ext. Doc. No.',
                        FRA = 'N° ligne doc. ext. lettrage';
        }
        field(288; "Recipient Bank Account"; Code[10])
        {
            CaptionML = ENU = 'Recipient Bank Account',
                        FRA = 'Cpte bancaire destinataire';
            TableRelation = IF ("Account Type" = CONST(Customer)) "Customer Bank Account".Code where("Customer No." = FIELD("Account No."))
            else IF ("Account Type" = CONST(Vendor)) "Vendor Bank Account".Code where("Vendor No." = FIELD("Account No."))
            else IF ("Bal. Account Type" = CONST(Customer)) "Customer Bank Account".Code where("Customer No." = FIELD("Bal. Account No."))
            else IF ("Bal. Account Type" = CONST(Vendor)) "Vendor Bank Account".Code where("Vendor No." = FIELD("Bal. Account No."));
        }
        field(289; "Message to Recipient"; Text[140])
        {
            CaptionML = ENU = 'Message to Recipient',
                        FRA = 'Message au destinataire';
        }
        field(290; "Exported to Payment File"; Boolean)
        {
            CaptionML = ENU = 'Exported to Payment File',
                        FRA = 'Exporté dans fichier paiement';
            Editable = false;
        }
        field(291; "Has Payment Export Error"; Boolean)
        {
            CalcFormula = Exist("Payment Jnl. Export Error Text" where("Journal Template Name" = FIELD("Journal Template Name"),
                                                                        "Journal Batch Name" = FIELD("Journal Batch Name"),
                                                                        "Journal Line No." = FIELD("Line No.")));
            CaptionML = ENU = 'Has Payment Export Error',
                        FRA = 'Présente erreur exportation paiement';
            Editable = false;
            FieldClass = FlowField;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            CaptionML = ENU = 'Dimension Set ID',
                        FRA = 'ID ensemble de dimensions';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(827; "Credit Card No."; Code[20])
        {
            CaptionML = ENU = 'Credit Card No.',
                        FRA = 'N° de carte de crédit';
        }
        field(1001; "Job Task No."; Code[20])
        {
            CaptionML = ENU = 'Job Task No.',
                        FRA = 'N° tâche projet';
            TableRelation = "Job Task"."Job Task No." where("Job No." = FIELD("Job No."));
        }
        field(1002; "Job Unit Price (LCY)"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatType = 2;
            CaptionML = ENU = 'Job Unit Price (LCY)',
                        FRA = 'Prix unitaire projet DS';
            Editable = false;
        }
        field(1003; "Job Total Price (LCY)"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatType = 1;
            CaptionML = ENU = 'Job Total Price (LCY)',
                        FRA = 'Prix total projet DS';
            Editable = false;
        }
        field(1004; "Job Quantity"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            CaptionML = ENU = 'Job Quantity',
                        FRA = 'Quantité projet';
            DecimalPlaces = 0 : 5;
        }
        field(1005; "Job Unit Cost (LCY)"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatType = 2;
            CaptionML = ENU = 'Job Unit Cost (LCY)',
                        FRA = 'Coût unitaire projet DS';
            Editable = false;
        }
        field(1006; "Job Line Discount %"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatType = 1;
            CaptionML = ENU = 'Job Line Discount %',
                        FRA = '% remise ligne projet';
        }
        field(1007; "Job Line Disc. Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Job Line Disc. Amount (LCY)',
                        FRA = 'Montant remise ligne projet DS';
            Editable = false;
        }
        field(1008; "Job Unit Of Measure Code"; Code[10])
        {
            CaptionML = ENU = 'Job Unit Of Measure Code',
                        FRA = 'Code unité projet';
            TableRelation = "Unit of Measure";
        }
        field(1009; "Job Line Type"; Option)
        {
            AccessByPermission = TableData Job = R;
            CaptionML = ENU = 'Job Line Type',
                        FRA = 'Type ligne projet';
            OptionCaptionML = ENU = ' ,Budget,Billable,Both Budget and Billable',
                              FRA = ' ,Budget,Facturable,Budget et Facturable';
            OptionMembers = " ",Budget,Billable,"Both Budget and Billable";
        }
        field(1010; "Job Unit Price"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 2;
            CaptionML = ENU = 'Job Unit Price',
                        FRA = 'Prix unitaire projet';
        }
        field(1011; "Job Total Price"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU = 'Job Total Price',
                        FRA = 'Prix total projet';
            Editable = false;
        }
        field(1012; "Job Unit Cost"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 2;
            CaptionML = ENU = 'Job Unit Cost',
                        FRA = 'Coût unitaire projet';
            Editable = false;
        }
        field(1013; "Job Total Cost"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU = 'Job Total Cost',
                        FRA = 'Coût total projet';
            Editable = false;
        }
        field(1014; "Job Line Discount Amount"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU = 'Job Line Discount Amount',
                        FRA = 'Montant remise ligne projet';
        }
        field(1015; "Job Line Amount"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU = 'Job Line Amount',
                        FRA = 'Montant ligne projet';
        }
        field(1016; "Job Total Cost (LCY)"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatType = 1;
            CaptionML = ENU = 'Job Total Cost (LCY)',
                        FRA = 'Coût total projet DS';
            Editable = false;
        }
        field(1017; "Job Line Amount (LCY)"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatType = 1;
            CaptionML = ENU = 'Job Line Amount (LCY)',
                        FRA = 'Montant ligne projet DS';
            Editable = false;
        }
        field(1018; "Job Currency Factor"; Decimal)
        {
            CaptionML = ENU = 'Job Currency Factor',
                        FRA = 'Facteur devise projet';
        }
        field(1019; "Job Currency Code"; Code[10])
        {
            CaptionML = ENU = 'Job Currency Code',
                        FRA = 'Code devise projet';
        }
        field(1020; "Job Planning Line No."; Integer)
        {
            AccessByPermission = TableData Job = R;
            BlankZero = true;
            CaptionML = ENU = 'Job Planning Line No.',
                        FRA = 'N° ligne planning projet';

            trigger OnLookup();
            var
                JobPlanningLine: Record "Job Planning Line";
            begin
            end;

            trigger OnValidate();
            var
                JobPlanningLine: Record "Job Planning Line";
            begin
            end;
        }
        field(1030; "Job Remaining Qty."; Decimal)
        {
            AccessByPermission = TableData Job = R;
            CaptionML = ENU = 'Job Remaining Qty.',
                        FRA = 'Quantité travail à accomplir';
            DecimalPlaces = 0 : 5;

            trigger OnValidate();
            var
                JobPlanningLine: Record "Job Planning Line";
            begin
            end;
        }
        field(1200; "Direct Debit Mandate ID"; Code[35])
        {
            CaptionML = ENU = 'Direct Debit Mandate ID',
                        FRA = 'ID mandat domiciliation européenne';
            TableRelation = IF ("Account Type" = CONST(Customer)) "SEPA Direct Debit Mandate" where("Customer No." = FIELD("Account No."));

            trigger OnValidate();
            var
                SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
            begin
            end;
        }
        field(1220; "Data Exch. Entry No."; Integer)
        {
            CaptionML = ENU = 'Data Exch. Entry No.',
                        FRA = 'N° écriture échange données';
            Editable = false;
            TableRelation = "Data Exch.";
        }
        field(1221; "Payer Information"; Text[50])
        {
            CaptionML = ENU = 'Payer Information',
                        FRA = 'Informations payeur';
        }
        field(1222; "Transaction Information"; Text[100])
        {
            CaptionML = ENU = 'Transaction Information',
                        FRA = 'Informations transaction';
        }
        field(1223; "Data Exch. Line No."; Integer)
        {
            CaptionML = ENU = 'Data Exch. Line No.',
                        FRA = 'N° ligne échange données';
            Editable = false;
        }
        field(1224; "Applied Automatically"; Boolean)
        {
            CaptionML = ENU = 'Applied Automatically',
                        FRA = 'Lettré automatiquement';
        }
        field(1700; "Deferral Code"; Code[10])
        {
            CaptionML = ENU = 'Deferral Code',
                        FRA = 'Code échelonnement';
            TableRelation = "Deferral Template"."Deferral Code";

            trigger OnValidate();
            var
                DeferralUtilities: Codeunit "Deferral Utilities";
            begin
            end;
        }
        field(1701; "Deferral Line No."; Integer)
        {
            CaptionML = ENU = 'Deferral Line No.',
                        FRA = 'N° ligne échelonnement';
        }
        field(5050; "Campaign No."; Code[20])
        {
            CaptionML = ENU = 'Campaign No.',
                        FRA = 'N° campagne';
            TableRelation = Campaign;
        }
        field(5400; "Prod. Order No."; Code[20])
        {
            CaptionML = ENU = 'Prod. Order No.',
                        FRA = 'N° ordre de fabrication';
            Editable = false;
        }
        field(5600; "FA Posting Date"; Date)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            CaptionML = ENU = 'FA Posting Date',
                        FRA = 'Date compta. immo.';
        }
        field(5601; "FA Posting Type"; Option)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            CaptionML = ENU = 'FA Posting Type',
                        FRA = 'Type compta. immo.';
            OptionCaptionML = ENU = ' ,Acquisition Cost,Depreciation,Write-Down,Appreciation,Custom 1,Custom 2,Disposal,Maintenance',
                              FRA = ' ,Coût acquisition,Amortissement,Dépréciation,Réévaluation,Param. 1,Param. 2,Cession,Maintenance';
            OptionMembers = " ","Acquisition Cost",Depreciation,"Write-Down",Appreciation,"Custom 1","Custom 2",Disposal,Maintenance;
        }
        field(5602; "Depreciation Book Code"; Code[10])
        {
            CaptionML = ENU = 'Depreciation Book Code',
                        FRA = 'Code loi d''amortissement';
            TableRelation = "Depreciation Book";

            trigger OnValidate();
            var
                FADeprBook: Record "FA Depreciation Book";
            begin
            end;
        }
        field(5603; "Salvage Value"; Decimal)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            AutoFormatType = 1;
            CaptionML = ENU = 'Salvage Value',
                        FRA = 'Valeur résiduelle';
        }
        field(5604; "No. of Depreciation Days"; Integer)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            BlankZero = true;
            CaptionML = ENU = 'No. of Depreciation Days',
                        FRA = 'Nbre jours amort.';
        }
        field(5605; "Depr. until FA Posting Date"; Boolean)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            CaptionML = ENU = 'Depr. until FA Posting Date',
                        FRA = 'Amort. jusqu''à date compta.';
        }
        field(5606; "Depr. Acquisition Cost"; Boolean)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            CaptionML = ENU = 'Depr. Acquisition Cost',
                        FRA = 'Amortir coût acquisition';
        }
        field(5609; "Maintenance Code"; Code[10])
        {
            CaptionML = ENU = 'Maintenance Code',
                        FRA = 'Code maintenance';
            TableRelation = Maintenance;
        }
        field(5610; "Insurance No."; Code[20])
        {
            CaptionML = ENU = 'Insurance No.',
                        FRA = 'N° assurance';
            TableRelation = Insurance;
        }
        field(5611; "Budgeted FA No."; Code[20])
        {
            CaptionML = ENU = 'Budgeted FA No.',
                        FRA = 'N° immo. budgétée';
            TableRelation = "Fixed Asset";

            trigger OnValidate();
            var
                FA: Record "Fixed Asset";
            begin
            end;
        }
        field(5612; "Duplicate in Depreciation Book"; Code[10])
        {
            CaptionML = ENU = 'Duplicate in Depreciation Book',
                        FRA = 'Dupliquer dans journaux amort.';
            TableRelation = "Depreciation Book";
        }
        field(5613; "Use Duplication List"; Boolean)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            CaptionML = ENU = 'Use Duplication List',
                        FRA = 'Utiliser liste duplication';
        }
        field(5614; "FA Reclassification Entry"; Boolean)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            CaptionML = ENU = 'FA Reclassification Entry',
                        FRA = 'Ecriture reclass. immo.';
        }
        field(5615; "FA Error Entry No."; Integer)
        {
            BlankZero = true;
            CaptionML = ENU = 'FA Error Entry No.',
                        FRA = 'N° séquence erreur immo.';
            TableRelation = "FA Ledger Entry";
        }
        field(5616; "Index Entry"; Boolean)
        {
            CaptionML = ENU = 'Index Entry',
                        FRA = 'Ecriture réévaluation';
        }
        field(5617; "Source Line No."; Integer)
        {
            CaptionML = ENU = 'Source Line No.',
                        FRA = 'N° ligne origine';
        }
        field(5618; Comment; Text[250])
        {
            CaptionML = ENU = 'Comment',
                        FRA = 'Commentaire';
        }
        field(50000; "CV Detailed Entry No."; Integer)
        {
        }
        field(50001; "Vendor Bank Account"; Code[10])
        {
            Caption = 'Vendor Bank Account';
            Editable = true;
            TableRelation = IF ("Account Type" = FILTER(Vendor)) "Vendor Bank Account".Code where("Vendor No." = FIELD("Account No."));
        }
        field(50002; "Adj. Exchange Rate Type"; Option)
        {
            OptionMembers = " ",Bank,Customer,Vendor;
        }
        field(50003; "Batch payment name"; Code[30])
        {
        }
        field(50004; "Tree Level"; Integer)
        {
            Caption = 'Tree Level';
        }
        field(50005; "Archive Document No."; Code[20])
        {
            Caption = 'Archive Document No.';
        }
        field(50006; "Parent Line No."; Integer)
        {
            Caption = 'Parent Line No.';
        }
        field(50007; "Bank Branch No."; Text[20])
        {
            Caption = 'Bank Branch No.';
        }
        field(50008; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
        }
        field(50009; "Customer/Vendor Bank"; Code[10])
        {
            Caption = 'Customer/Vendor Bank';
            TableRelation = IF ("Account Type" = CONST(Customer)) "Customer Bank Account".Code where("Customer No." = FIELD("Account No."))
            else IF ("Account Type" = CONST(Vendor)) "Vendor Bank Account".Code where("Vendor No." = FIELD("Account No."));
        }
        field(50010; "WHT Business Posting Group"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            TableRelation = "WHT Business Posting Group FND".Code;
        }
        field(50011; "WHT Product Posting Group"; Code[10])
        {
            Caption = 'WHT Product Posting Group';
            TableRelation = "WHT Product Posting Group FND".Code;
        }
        field(50012; "WHT Absorb Base"; Decimal)
        {
            Caption = 'WHT Absorb Base';
        }
        field(50013; "WHT Entry No."; Integer)
        {
        }
        field(50014; "WHT Report Line No."; Code[10])
        {
            Caption = 'WHT Report Line No.';
        }
        field(50015; "Skip WHT"; Boolean)
        {
            Caption = 'Skip WHT';
        }
        field(50016; "Certificate Printed"; Boolean)
        {
            Caption = 'Certificate Printed';
        }
        field(50017; "WHT Payment"; Boolean)
        {
            Caption = 'WHT Payment';
        }
        field(50018; "Actual Vendor No."; Code[20])
        {
            Caption = 'Actual Vendor No.';
        }
        field(50019; "Is WHT"; Boolean)
        {
            Caption = 'Is WHT';
        }
        field(50020; "Purchase Receipt Line No."; Integer)
        {
            Caption = 'Purchase Receipt Line No.';
        }
        field(50021; "Purchase Receipt Amount"; Decimal)
        {
        }
        field(50022; IBAN; Code[50])
        {
            CalcFormula = Lookup("Vendor Bank Account".IBAN where("Vendor No." = FIELD("Account No."),
                                                                   Code = FIELD("Vendor Bank Account")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50023; "Forecast Line"; Boolean)
        {
            Caption = 'Forecast Line';
        }
        field(50024; "Forecast Key"; Text[30])
        {
        }
        field(50025; "RPM Original Sales Amount"; Decimal)
        {
            Caption = 'RPM Original Sales Amount';
            Editable = false;
        }
        field(50026; "Prepayment Doc Type"; Option)
        {
            OptionMembers = " ","Prepayment Invoice","Prepayment Credit Memo";
        }
        field(50027; "Payment Status"; Option)
        {
            OptionCaption = 'Pending Review,Payment Approved,Payment Rejected';
            OptionMembers = "Pending Review","Payment Approved","Payment Rejected";
        }
        field(50028; "Full WHT"; Boolean)
        {
        }
        field(50029; Reversed; Boolean)
        {
            Caption = 'Reversed';
            Editable = false;
        }
        field(50030; "On Hold UserID"; Code[50])
        {
            Caption = 'On Hold UserID';
        }
        field(50031; "On Hold Date"; Date)
        {
            Caption = 'On Hold Date';
        }
        // field(50032; "Total No. Of Parent Lines"; Integer)
        // {
        //     CalcFormula = Count("Gen. Journal Line" where("Parent Line No." = FILTER(0),
        //                                                    "Journal Template Name" = FIELD("Journal Template Name"),
        //                                                    "Journal Batch Name" = FIELD("Journal Batch Name")));
        //     Caption = 'Total No. Of Parent Lines';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(50033; "Total No. Of Children Lines"; Integer)
        // {
        //     CalcFormula = Count("Gen. Journal Line" where("Parent Line No." = FILTER(<> 0),
        //                                                    "Journal Template Name" = FIELD("Journal Template Name"),
        //                                                    "Journal Batch Name" = FIELD("Journal Batch Name")));
        //     Caption = 'Total No. Of Children Lines';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }  // BC Upgrade NANDIS03
        field(50034; "Vendor Name"; Text[100])  // BC Upgrade NANDIS03 - Increased the length from 50 to 100
        {
            CalcFormula = Lookup(Vendor.Name where("No." = FIELD("Account No.")));
            Caption = 'Vendor Name';
            FieldClass = FlowField;
        }
        field(50035; "Vendor Bank Acc. Name"; Text[100])  // BC Upgrade NANDIS03 - Increased the length from 50 to 100
        {
            CalcFormula = Lookup("Vendor Bank Account".Name where(Code = FIELD("Vendor Bank Account"),
                                                                   "Vendor No." = FIELD("Account No.")));
            Caption = 'Vendor Bank Acc. Name';
            FieldClass = FlowField;
        }
        field(50036; "Vendor Bank Acc. Branch No."; Text[20])
        {
            CalcFormula = Lookup("Vendor Bank Account"."Bank Branch No." where("Vendor No." = FIELD("Account No."),
                                                                                Code = FIELD("Vendor Bank Account")));
            Caption = 'Vendor Bank Acc. Branch No.';
            FieldClass = FlowField;
        }
        field(50037; "Vendor Bank Acc. No."; Text[30])
        {
            CalcFormula = Lookup("Vendor Bank Account"."Bank Account No." where("Vendor No." = FIELD("Account No."),
                                                                                 Code = FIELD("Vendor Bank Account")));
            Caption = 'Vendor Bank Acc. No.';
            FieldClass = FlowField;
        }
        field(50038; "Vandor Bank Acc. Swift Code"; Code[20])
        {
            CalcFormula = Lookup("Vendor Bank Account"."SWIFT Code" where("Vendor No." = FIELD("Account No."),
                                                                           Code = FIELD("Vendor Bank Account")));
            Caption = 'Vandor Bank Acc. Swift Code';
            FieldClass = FlowField;
        }
        field(50039; "Execution Date"; Date)
        {
            Caption = 'Execution Date';
        }
        field(50040; "Real VAT Base"; Decimal)
        {
        }
        field(50041; "Real VAT Amount"; Decimal)
        {
        }
        field(50042; "Only VAT"; Boolean)
        {
        }
        field(50043; "HNK Bank Account"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(50044; "HNK Check No."; Code[20])
        {
        }
        field(50045; "Payment File Created"; Boolean)
        {
        }
        field(50046; "TIN No."; Text[20])
        {
            CalcFormula = Lookup("VAT Product Posting Group"."TIN No. FND" where(Code = FIELD("VAT Prod. Posting Group")));
            Caption = 'TIN No.';
            Editable = false;
            FieldClass = FlowField;
        }
        // field(50047; "Interface Code"; Code[20])
        // {
        //     Caption = 'Interface Code';
        //     TableRelation = "Interface Setup";
        // } // BC Upgrade NANDIS03 - Blocked as no usage found
        field(50048; "CP Vendor Invoice No."; Code[20])
        {
        }
        field(50049; "Instruction Priority"; Option)
        {
            Caption = 'Instruction Priority';
            OptionCaption = 'Normal,High';
            OptionMembers = Normal,High;
        }
        field(50050; "Code Expenses"; Option)
        {
            CaptionML = ENU = 'Code Expenses',
                        FRB = 'Code frais',
                        NLB = 'Kostencode';
            OptionCaptionML = ENU = ' ,SHA,BEN,OUR',
                              FRB = ' ,SHA,BEN,OUR',
                              NLB = ' ,SHA,BEN,OUR';
            OptionMembers = " ",SHA,BEN,OUR;
        }
        field(50051; "Export Protocol Code"; Code[20])
        {
            CaptionML = ENU = 'Export Protocol Code',
                        FRB = 'Code du protocole d''exportation',
                        NLB = 'Exportprotocolcode';
            TableRelation = "Export Protocol FND".Code;
        }
        field(50052; "WS Posting Allowed"; Boolean)
        {
            Caption = 'WS Posting Allowed';
        }
        field(50066; "WHT Amount"; Decimal)
        {
            Caption = 'WHT Amount';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50067; "WHT Amount (LCY)"; Decimal)
        {
            Caption = 'WHT Amount (LCY)';
            Description = 'HEI.02';
            Editable = false;
        }
        field(2013610; "Cust/Vendor Deposit Group Code"; Code[10])
        {
            CaptionML = ENU = 'Cust/Vend DepositChrg.Gr. Code',
                        FRA = 'Code groupe coût consigne Client/Fourn.';
            //TableRelation = "Drink Deposit Group".Code where("Source Type" = FIELD("Source Type"));  // BC Upgrade NANDIS03
        }
        field(2013611; "Deposit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU = 'Deposit Amount',
                        FRA = 'Montant consigne';
        }
        field(2013612; "Deposit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Deposit Amount (LCY)',
                        FRA = 'Montant de la caution DS';
        }
        field(2013667; "Cust/Vendor DTax Group Code"; Code[20])
        {
            CaptionML = ENU = 'Cust/Vendor Tax Group Code',
                        FRA = 'Code groupe taxe Client/Fourn.';
            //TableRelation = "Drink Tax Group".Code where("Source Type" = FIELD("Source Type"));  // BC Upgrade NANDIS03
        }
        field(2013695; "Item Charge Type"; Option)
        {
            CaptionML = ENU = 'Item Charge Type',
                        FRA = 'Type frais annexes';
            OptionCaptionML = ENU = ' ,,Deposit',
                              FRA = ' ,,Consigne';
            OptionMembers = " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        }
        field(2013726; "Cust/Vend Tax Registration No."; Text[20])
        {
            CaptionML = ENU = 'Cust/Vendor Tax Registration No.',
                        FRA = 'N° ident. accise Client/Fourn.';
        }
        field(2013783; "Applies-to D/P Line No."; Integer)
        {
            CaptionML = ENU = 'Applies-to D/P Line No.',
                        FRA = 'N° ligne lettrage C/P';
            //TableRelation = "Sales Disc. & Promo. Worksheet"."Line No." where("Entry Type" = FIELD("Applies-to D/P Line Type"));  // BC Upgrade NANDIS03
        }
        field(2013784; "Applies-to D/P Line Type"; Option)
        {
            CaptionML = ENU = 'Applies-to D/P Line Type',
                        FRA = 'Type ligne lettrage C/P';
            OptionCaptionML = ENU = ' ,Discount,Promotion',
                              FRA = ' ,Remise,Promotion';
            OptionMembers = " ",Discount,Promotion;
            //TableRelation = "Sales Disc. & Promo. Worksheet"."Entry Type"; // BC Upgrade NANDIS03
        }
        field(2013822; "Applies-to D/P Source Table"; Option)
        {
            CaptionML = ENU = 'Applies-to D/P Source Table',
                        FRA = 'Table source lettrage C/P';
            OptionCaptionML = ENU = ' ,Sales,Purchase',
                              FRA = ' ,Vente,Achat';
            OptionMembers = " ",Sales,Purchase;
        }
        field(2013969; "Pos System-Created Entry"; Boolean)
        {
            CaptionML = ENU = 'POS System-Created Entry',
                        FRA = 'Ecriture système POS';
            Editable = false;
        }
        field(2014077; "Truck Code"; Code[10])
        {
            CaptionML = ENU = 'Truck Code',
                        FRA = 'Code camion';
            //TableRelation = "Whse. Shipping Truck";  // BC Upgrade NANDIS03
        }
        field(2014078; "Driver Code"; Code[10])
        {
            CaptionML = ENU = 'Driver Code',
                        FRA = 'Code chauffeur';
            //TableRelation = "Whse. Shipping Driver";  // BC Upgrade NANDIS03
        }
        field(2014109; "Route Planning No."; Code[20])
        {
            Caption = 'Route Planning No.';
            //TableRelation = "Route Planning Worksheet";  // BC Upgrade NANDIS03
        }
        field(2014271; "Cust/Vend Tax Warehouse Ref."; Text[20])
        {
            CaptionML = ENU = 'Cust/Vendor Tax Warehouse Reference',
                        FRA = 'Entrepôt fiscal de référence Client/Fourn.';
        }
        field(2014310; "Service Contract Line No."; Integer)
        {
            CaptionML = ENU = 'Contract Line No.',
                        FRA = 'N° ligne contrat';
        }
        field(2014312; "DIT Sub-Contr.Pst. Type Filter"; Option)
        {
            CaptionML = ENU = 'Financial Contract Posting Type Filter',
                        FRA = 'Filtre Type Imputation contrat DIT';
            FieldClass = FlowFilter;
            OptionCaptionML = ENU = ' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance,,,,,All',
                              FRA = ' ,Location,Prêt,Mise à disposition,Maintenance,Divers,Maintenance Usine,,,,,Tous';
            OptionMembers = " ",Rent,Loan,"Loan in use",Maintenance,Other,PlantMaintenance,,,,,All;
        }
        field(2014313; "DIT Sub-Contract Type Filter"; Option)
        {
            CaptionML = ENU = 'DIT Sub-Contract Type Filter',
                        FRA = 'Filtre type sous-contrat DIT';
            FieldClass = FlowFilter;
            OptionCaptionML = ENU = ' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance,,,,,All',
                              FRA = ' ,Location,Prêt,Mise à disposition,Maintenance,Divers,Maintenance Usine,,,,,Tous';
            OptionMembers = " ",Rent,Loan,"Loan in use",Maintenance,Other,PlantMaintenance,,,,,All;
        }
        field(2014314; "Source Type Filter"; Option)
        {
            CaptionML = ENU = 'Source Type Filter',
                        FRA = 'Filtre type origine';
            FieldClass = FlowFilter;
            OptionCaptionML = ENU = ' ,Customer,Vendor,Bank Account,Fixed Asset',
                              FRA = ' ,Client,Fournisseur,Banque,Immobilisation';
            OptionMembers = " ",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(2014315; "Source No. Filter"; Code[20])
        {
            CaptionML = ENU = 'Source No. Filter',
                        FRA = 'Filtre n° origine';
            FieldClass = FlowFilter;
            TableRelation = IF ("Source Type" = CONST(Customer)) Customer
            else IF ("Source Type" = CONST(Vendor)) Vendor
            else IF ("Source Type" = CONST("Bank Account")) "Bank Account"
            else IF ("Source Type" = CONST("Fixed Asset")) "Fixed Asset";
            ValidateTableRelation = false;
        }
        field(2014316; "Payment Type"; Option)
        {
            CaptionML = ENU = 'Payment Type',
                        FRA = 'Type de règlement';
            OptionCaptionML = ENU = ' ,collection,,,direct debiting',
                              FRA = ' ,collecte,,,débit direct';
            OptionMembers = " ",collection,,,"direct debiting";
        }
        field(2014317; "Create from Financial Contract"; Boolean)
        {
            CaptionML = ENU = 'Create from Financial Contract',
                        FRA = 'Créé à partir du contrat financier';
        }
        field(2014318; "Contract Posting Date"; Date)
        {
            CaptionML = ENU = 'Contract Posting Date',
                        FRA = 'Date comptabilisation du contrat';
        }
        field(2014319; "Financial Contract No."; Code[20])
        {
            CaptionML = ENU = 'Financial Contract No.',
                        FRA = 'N° Contrat Financier';
            /*TableRelation = IF ("DIT Sub-Contract Type" = CONST(" ")) "Financial Contract Header"."Contract No." where("Contract Type" = CONST(Contract))
            else IF ("DIT Sub-Contract Type" = FILTER(<> " ")) "Financial Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
                                                                                                                              "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));*/  // BC Upgrade NANDIS03

            trigger OnValidate();
            var
                FA2: Record "Fixed Asset";
            begin
            end;
        }
        field(50064; "Document Subtype Code"; Code[10]) // BC Upgrade SHUKLP03 << Id chaned.
        {
            Caption = 'Document Subtype Code';
            TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = FILTER(Sales | "Fin.Contract"));  // BC Upgrade SHUKLP03
        }
        field(2014497; "Invoice List Document No."; Code[20])
        {
            CaptionML = ENU = 'Invoice List Document No.',
                        FRA = 'N° document liste facture';
            Editable = false;
            //TableRelation = "Invoice List";  // BC Upgrade NANDIS03
        }
        field(2029610; OGM; Text[30])
        {
            CaptionML = ENU = 'OGM',
                        FRA = 'OGM';
        }
        field(2029611; "Auto. Acc. Group"; Code[10])
        {
            CaptionML = ENU = 'Auto. Acc. Group',
                        FRA = 'Groupe compte autom.';
            //TableRelation = "Automatic Acc. Header";  // BC Upgrade NANDIS03

            trigger OnValidate();
            var
                lrecGeneralLedgerSetup: Record "General Ledger Setup";
            begin
            end;
        }
        field(2034840; "Building No."; Code[20])
        {
            CaptionML = ENU = 'Building No.',
                        FRA = 'N° immeuble';
            //TableRelation = Building;  // BC Upgrade NANDIS03
        }
        field(2034850; "DIT Sub-Contract Type"; Option)
        {
            CaptionML = ENU = 'Sub Contract Type',
                        FRA = 'Sous type contrat';
            OptionCaptionML = ENU = ' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
                              FRA = ' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
            OptionMembers = " ",Rent,Loan,"Loan in use",Maintenance,Other,PlantMaintenance;

            trigger OnValidate();
            var
                Cust: Record Customer;
                FA: Record "Fixed Asset";
                GLAcc: Record "G/L Account";
                TempGenJnlLine: Record "Gen. Journal Line";
                Vend: Record Vendor;
            begin
            end;
        }
        field(2034872; "Contract Group Code"; Code[10])
        {
            CaptionML = ENU = 'Contract Group Code',
                        FRA = 'Code groupe contrat';
            /*TableRelation = IF ("Contract Type" = CONST(Service),
                                "DIT Sub-Contract Type" = FILTER(<> " ")) "Contract Group".Code where("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"))
            else IF ("Contract Type" = CONST(Service),
                                         "DIT Sub-Contract Type" = CONST(" ")) "Contract Group".Code
            else IF ("Contract Type" = CONST(Financial),
                                                  "DIT Sub-Contract Type" = FILTER(<> " ")) "Financial Contract Group".Code where("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"))
            else IF ("Contract Type" = CONST(Financial),
                                                           "DIT Sub-Contract Type" = CONST(" ")) "Financial Contract Group".Code;*/  // BC Upgrade NANDIS03

            trigger OnValidate();
            var
                Cust: Record Customer;
                FA: Record "Fixed Asset";
                GLAcc: Record "G/L Account";
                Vend: Record Vendor;
            begin
            end;
        }
        field(2034915; "Service Contract No."; Code[20])
        {
            CaptionML = ENU = 'Service Contract No.',
                        FRA = 'N° contrat de service';
            /*TableRelation = IF ("Contract Type" = CONST(Service),
                                "Source Type" = CONST(Customer)) "Service Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
                                                                                                               "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type Filter"),
                                                                                                               "Customer No." = FIELD("Source No. Filter"),
                                                                                                               Status = FILTER(Signed))
            else IF ("Contract Type" = CONST(Service),
                                                                                                                        "Source Type" = CONST(Vendor)) "Service Purch. Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
                                                                                                                                                                                                            "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type Filter"),
                                                                                                                                                                                                            "Vendor No." = FIELD("Source No. Filter"),
                                                                                                                                                                                                            Status = FILTER(Signed));*/  // BC Upgrade NANDIS03

            trigger OnValidate();
            var
                FA2: Record "Fixed Asset";
            begin
            end;
        }
        field(2035393; "Contract Type"; Option)
        {
            CaptionML = ENU = 'Contract Type',
                        FRA = 'Type contrat';
            OptionCaptionML = ENU = ' ,Service,Financial',
                              FRA = ' ,Service,Financier';
            OptionMembers = " ",Service,Financial;
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Balance (LCY)";
        }
        key(Key2; "Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.")
        {
            MaintainSQLIndex = false;
        }
        key(Key3; "Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.")
        {
        }
        key(Key4; "Document No.")
        {
            MaintainSQLIndex = false;
        }
        key(Key5; "Incoming Document Entry No.")
        {
        }
        key(Key6; "Applies-to D/P Source Table", "Applies-to D/P Line Type", "Applies-to D/P Line No.")
        {
        }
        key(Key7; "Journal Template Name", "Journal Batch Name", "Driver Code", "Truck Code", "Document No.", "Document Date")
        {
            SumIndexFields = "Amount (LCY)";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    var
    //lrShippingDtldJnlLine: Record "Shipping Dtld. Jnl. Line";  // BC Upgrade NANDIS03
    begin
    end;

    var
        //DiscPromoPostLine: Codeunit "Sales Disc. & Promo.-Post Line";  // BC Upgrade NANDIS03
        //PurchDiscPromoPostLine: Codeunit "Purch.Disc. & Promo.-Post Line";  // BC Upgrade NANDIS03
        //ServPostJnl: Codeunit "Serv-Posting Journals Mgt.";  // BC Upgrade NANDIS03
        //ServPurchPostJnl: Codeunit "Serv Purch.-Post Journals Mgt.";  // BC Upgrade NANDIS03
        ContractGroup: Record "Contract Group";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        CustLedgEntry: Record "Cust. Ledger Entry";
        Cust: Record Customer;
        ExportProtocol: Record "Export Protocol FND";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        GenJnlAlloc: Record "Gen. Jnl. Allocation";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlTemplate: Record "Gen. Journal Template";
        GenProdPostingGrp: Record "Gen. Product Posting Group";
        GLSetup: Record "General Ledger Setup";
        Job: Record Job;
        TempJobJnlLine: Record "Job Journal Line" temporary;
        PaymentTerms: Record "Payment Terms";
        //Building: Record Building;  // BC Upgrade NANDIS03
        //DITServMgtSetup: Record "Property Service Mgt. Setup";  // BC Upgrade NANDIS03
        //DITPurchServMgtSetup: Record "Property Purch Serv Mgt. Setup";  // BC Upgrade NANDIS03
        ServContract: Record "Service Contract Header";
        SourceCodeSetup: Record "Source Code Setup";
        VATPostingSetup: Record "VAT Posting Setup";
        VendLedgEntry: Record "Vendor Ledger Entry";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        //NoSeriesMgt: Codeunit NoSeriesManagement;  // BC Upgrade NANDIS03
        CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";
        CustEntrySetApplID: Codeunit "Cust. Entry-SetAppl.ID";
        DeferralUtilities: Codeunit "Deferral Utilities";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        GenJnlShowCTEntries: Codeunit "Gen. Jnl.-Show CT Entries";
        //recFinXLSetup: Record "Finance XL Setup";  // BC Upgrade NANDIS03
        //PurchasesUtils: Codeunit "Purchases-Utils";  // BC Upgrade NANDIS03 - No Use
        HeinekenGlobal: Codeunit "Heineken Global";
        //DimMgt: Codeunit DimensionManagement;  DimMgt
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        VendEntrySetApplID: Codeunit "Vend. Entry-SetAppl.ID";
        //rPropertyServiceMgtSetup: Record "Property Service Mgt. Setup";  // BC Upgrade NANDIS03
        //rPropertyPurchServMgtSetup: Record "Property Purch Serv Mgt. Setup";  // BC Upgrade NANDIS03
        blnCalledFromValidate: Boolean;
        GLSetupRead: Boolean;
        HideValidationDialog: Boolean;
        TemplateFound: Boolean;
        CurrencyCode: Code[10];
        FromCurrencyCode: Code[10];
        ToCurrencyCode: Code[10];
        CurrencyDate: Date;
        Window: Dialog;
        AccTypeNotInLineWithDocTypeErr: Label '%1 cannot be %2 when %3 is %4.';
        CheckConstant: Label 'INCLUDED IN PAYMENT PROPOSAL';
        Text021: Label '%1 cannot be %2 when %3 is %4.';
        DeferralDocType: Option Purchase,Sales,"G/L";
        AccTypeNotSupportedErr: TextConst ENU = 'You cannot specify a deferral code for this type of account.', FRA = 'Vous ne pouvez pas spécifier un code échelonnement pour ce type de compte.';
        CalcPostDateMsg: TextConst ENU = 'Processing payment journal lines #1##########', FRA = 'Traitement lignes feuille paiement #1##########';
        DocNoFilterErr: TextConst ENU = 'The document numbers cannot be renumbered while there is an active filter on the Document No. field.', FRA = 'Les numéros de document ne peuvent pas être modifiés lorsqu''un filtre est actif sur le champ N° document.';
        DueDateMsg: TextConst ENU = 'This posting date will cause an overdue payment.', FRA = 'Cette date comptabilisation va entraîner un règlement dû.';
        ExportAgainQst: TextConst ENU = 'One or more of the selected lines have already been exported. Do you want to export them again?', FRA = 'Une ou plusieurs des lignes sélectionnées ont déjà été exportées. Souhaitez-vous les exporter à nouveau ?';
        NotExistErr: TextConst Comment = '%1=Document number', ENU = 'Document number %1 does not exist or is already closed.', FRA = 'Le numéro de document %1 n''existe pas ou est déjà fermé.';
        NothingToExportErr: TextConst ENU = 'There is nothing to export.', FRA = 'Il n''y a rien à exporter.';
        Text000: TextConst Comment = '%1=Account Type,%2=Balance Account Type', ENU = '%1 or %2 must be a G/L Account or Bank Account.', FRA = '%1 ou %2 doit être un compte général ou un compte bancaire.';
        Text001: TextConst ENU = 'You must not specify %1 when %2 is %3.', FRA = 'Vous ne devez pas spécifier %1 quand %2 est %3.';
        Text002: TextConst ENU = 'cannot be specified without %1', FRA = 'ne peut pas être spécifié(e) sans %1';
        Text003: TextConst Comment = '%1=Caption of Currency Code field, %2=Caption of table Gen Journal, %3=FromCurrencyCode, %4=ToCurrencyCode', ENU = 'The %1 in the %2 will be changed from %3 to %4.\\Do you want to continue?', FRA = 'Le %1 dans le %2 va passer de %3 à %4.\\Voulez-vous continuer ?';
        Text005: TextConst ENU = 'The update has been interrupted to respect the warning.', FRA = 'La mise à jour a été interrompue pour respecter l''alerte.';
        Text006: TextConst ENU = 'The %1 option can only be used internally in the system.', FRA = 'L''option %1 ne peut être utilisée qu''en interne par le système.';
        Text007: TextConst Comment = '%1=Account Type,%2=Balance Account Type', ENU = '%1 or %2 must be a bank account.', FRA = '%1 ou %2 doit être un compte bancaire.';
        Text008: TextConst ENU = ' must be 0 when %1 is %2.', FRA = ' doit être 0 quand %1 est %2.';
        Text009: TextConst ENU = 'LCY', FRA = 'DS';
        Text010: TextConst ENU = '%1 must be %2 or %3.', FRA = '%1 doit être %2 ou %3.';
        Text011: TextConst ENU = '%1 must be negative.', FRA = '%1 doit être négatif/ve.';
        Text012: TextConst ENU = '%1 must be positive.', FRA = '%1 doit être positif/ve.';
        Text013: TextConst ENU = 'The %1 must not be more than %2.', FRA = '%1 ne doit pas être supérieur(e) à %2.';
        Text014: TextConst Comment = '%1=Caption of Table Customer, %2=Customer No, %3=Caption of field Bill-to Customer No, %4=Value of Bill-to customer no.', ENU = 'The %1 %2 has a %3 %4.\\Do you still want to use %1 %2 in this journal line?', FRA = 'La %2 %1 a un %3 %4.\\Souhaitez-vous quand même utiliser %2 %1 dans cette ligne feuille ?';
        Text015: TextConst ENU = 'You are not allowed to apply and post an entry to an entry with an earlier posting date.\\Instead, post %1 %2 and then apply it to %3 %4.', FRA = 'Vous n''êtes pas autorisé à lettrer et à enregistrer une écriture dans une écriture disposant d''une date de comptabilisation antérieure.\\Enregistrez plutôt %1 %2, puis lettrez-la dans %3 %4.';
        Text016: TextConst ENU = '%1 must be G/L Account or Bank Account.', FRA = '%1 doit être un compte général ou un compte bancaire.';
        Text018: TextConst ENU = '%1 can only be set when %2 is set.', FRA = '%1 ne peut être déterminé que si %2 est défini.';
        Text019: TextConst ENU = '%1 cannot be changed when %2 is set.', FRA = '%1 ne peut pas être modifié si %2 est défini.';
        //ContractDIT: Record "Financial Contract Header";  // BC Upgrade NANDIS03
        //ContractGroupDIT: Record "Financial Contract Group";  // BC Upgrade NANDIS03
        Text2034840: TextConst ENU = 'You may not change the Posting group if the Sub Contract type is filled.', FRA = 'Vous ne pouvez pas changer le groupe comptable si le type sous-contrat est saisi';
        Text2034841: TextConst ENU = 'You may not change %1 when %2 is filled', FRA = 'vous ne pouvez pas modifier %1 quand %2 est rempli';
}

