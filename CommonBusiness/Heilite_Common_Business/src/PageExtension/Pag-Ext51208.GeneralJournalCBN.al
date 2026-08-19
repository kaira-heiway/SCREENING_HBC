pageextension 51208 GeneralJournalExtCBN extends "General Journal"
{
    // version NAVW110.0,FINXL9.00,DITW110.00.08,HEI.14

    // BC Upgrade SHUKLP03 >> Added code to validate document subtype -> FDD-MTC-001

    layout
    {
        modify(CurrentJnlBatchName)
        {
            CaptionML = ENU = 'Batch Name', FRA = 'Nom de la feuille';
            ToolTipML = ENU = 'Specifies the batch name of the general journal.', FRA = 'Spécifie le nom de la feuille comptabilité.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the posting date for the entry.', FRA = 'Spécifie la date comptabilisation de l''écriture.';
        }
        modify("Document Date")
        {
            Visible = true;//BC UpgradeSHARMP16
            ToolTipML = ENU = 'Specifies the date on the document that provides the basis for the entry on the journal line.', FRA = 'Spécifie la date du document qui est utilisé comme document de base pour l''écriture de la ligne feuille.';
        }
        modify("Document Type")
        {
            ToolTipML = ENU = 'Specifies the type of document that the entry on the journal line is.', FRA = 'Spécifie le type de document auquel appartient l''écriture de la ligne feuille.';
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies a document number for the journal line.', FRA = 'Spécifie le numéro de document de la ligne feuille.';
        }
        modify("Incoming Document Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number of the incoming document that this general journal line is created for.', FRA = 'Spécifie le numéro du document entrant pour lequel cette ligne feuille comptabilité est créée.';
        }
        modify("External Document No.")
        {
            Visible = true;//BC Upgrade SHARMP16
            ToolTipML = ENU = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.', FRA = 'Spécifie un numéro de document qui fait référence au programme de numérotation du client ou du fournisseur.';
        }
        modify("Applies-to Ext. Doc. No.")
        {
            ToolTipML = ENU = 'Specifies the external document number that will be exported in the payment file.', FRA = 'Spécifie le numéro document externe exporté dans le fichier paiement.';
        }
        modify("Account Type")
        {
            ToolTipML = ENU = 'Specifies the type of account that the entry on the journal line will be posted to.', FRA = 'Spécifie le type de compte sur lequel l''écriture de la ligne feuille est validée.';
        }
        modify("Account No.")
        {
            ToolTipML = ENU = 'Specifies the account number that the entry on the journal line will be posted to.', FRA = 'Spécifie le numéro de compte sur lequel l''écriture de la ligne feuille est validée.';
            // BC Upgrade SHUKLP03 >> Testscript -> Added code to OnValidate trigger of Account No. field to validate "Auto_Cust FND" value.
            trigger OnAfterValidate()
            var
            begin
                //HEI.10
                if DimensionSetEntry.GET(Rec."Dimension Set ID", 'AUTO_CUST') then
                    Rec."Auto_Cust FND" := DimensionSetEntry."Dimension Value Code"
                else
                    Rec."Auto_Cust FND" := '';
                //HEI.10
            end;
            // BC Upgrade SHUKLP03 << Testscript -> Added code to OnValidate trigger of Account No. field validate "Auto_Cust FND" value.

        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the entry. The field is automatically filled when the Account No. field is filled.', FRA = 'Spécifie une description de l''écriture. Le champ est automatiquement rempli lorsque le champ N° compte est rempli.';
        }
        modify("Payer Information")
        {
            ToolTipML = ENU = 'Specifies payer information that is imported with the bank statement file.', FRA = 'Spécifie les informations du payeur qui sont importées avec le fichier relevé bancaire.';
        }
        modify("Transaction Information")
        {
            ToolTipML = ENU = 'Specifies transaction information that is imported with the bank statement file.', FRA = 'Spécifie les informations de transaction qui sont importées avec le fichier relevé bancaire.';
        }
        modify("Business Unit Code")
        {
            ToolTipML = ENU = 'Specifies the code of the business unit that the entry derives from in a consolidated company.', FRA = 'Spécifie le code du centre de profit duquel provient l''écriture dans une société consolidée.';
        }
        modify("Salespers./Purch. Code")
        {
            ToolTipML = ENU = 'Specifies the salesperson or purchaser who is linked to the journal line.', FRA = 'Spécifie le vendeur ou l''acheteur lié à la ligne feuille.';
        }
        modify("Campaign No.")
        {
            ToolTipML = ENU = 'Specifies the number of the campaign the journal line is linked to.', FRA = 'Spécifie le numéro de la campagne à laquelle la ligne feuille est liée.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the code of the currency for the amounts on the journal line.', FRA = 'Spécifie le code de la devise des montants de la ligne feuille.';
        }
        modify("Gen. Posting Type")
        {
            ToolTipML = ENU = 'Specifies the general posting type that will be used when you post the entry on this journal line.', FRA = 'Spécifie le type validation général qui est utilisé lorsque vous validez l''écriture de cette ligne feuille.';
        }
        modify("Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the general business posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le groupe comptabilisation marché utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the general product posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation produit utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the VAT business posting group code that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation marché TVA qui est utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the VAT product posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation produit TVA utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the quantity of items to be included on the journal line.', FRA = 'Spécifie la quantité d''articles à inclure dans la ligne feuille.';
        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the total amount (including VAT) that the journal line consists of.', FRA = 'Spécifie le montant total (TVA incluse) qui constitue la ligne feuille.';

            trigger OnAfterValidate()
            begin
                Rec.CheckTINNoMandatory(); //HEI.04
            end;
        }
        modify("Debit Amount")
        {
            ToolTipML = ENU = 'Specifies the total amount (including VAT) that the journal line consists of, if it is a debit amount.', FRA = 'Spécifie le montant total (TVA incluse) qui constitue la ligne feuille, s''il s''agit d''un montant débiteur.';
        }
        modify("Credit Amount")
        {
            ToolTipML = ENU = 'Specifies the total amount (including VAT) that the journal line consists of, if it is a credit amount.', FRA = 'Spécifie le montant total (TVA incluse) qui constitue la ligne feuille, s''il s''agit d''un montant crédit.';
        }
        modify("VAT Amount")
        {
            ToolTipML = ENU = 'Specifies the amount of VAT included in the total amount.', FRA = 'Spécifie le montant de TVA incluse dans le montant total.';
        }
        modify("VAT Difference")
        {
            ToolTipML = ENU = 'Specifies the difference between the calculate VAT amount and the VAT amount that you have entered manually.', FRA = 'Spécifie la différence entre le montant TVA calculé et le montant TVA que vous avez entré manuellement.';
        }
        modify("Bal. VAT Amount")
        {
            ToolTipML = ENU = 'Specifies the amount of Bal. VAT included in the total amount.', FRA = 'Spécifie le montant de TVA contrepartie incluse dans le montant total.';
        }
        modify("Bal. VAT Difference")
        {
            ToolTipML = ENU = 'Specifies the difference between the calculate VAT amount and the VAT amount that you have entered manually.', FRA = 'Spécifie la différence entre le montant TVA calculé et le montant TVA que vous avez entré manuellement.';
        }
        modify("Bal. Account Type")
        {
            ToolTipML = ENU = 'Specifies the code for the balancing account type that should be used in this journal line.', FRA = 'Spécifie le code du type de compte contrepartie à utiliser dans cette ligne feuille.';
        }
        modify("Bal. Account No.")
        {
            ToolTipML = ENU = 'Specifies the number of the general ledger, customer, vendor, or bank account to which a balancing entry for the journal line will posted (for example, a cash account for cash purchases).', FRA = 'Spécifie le numéro du compte général, client, fournisseur ou bancaire sur lequel une écriture contrepartie est insérée pour la ligne feuille (par exemple, un compte caisse pour les achats).';
        }
        modify("Bal. Gen. Posting Type")
        {
            ToolTipML = ENU = 'Specifies the general posting type associated with the balancing account that will be used when you post the entry on the journal line.', FRA = 'Spécifie le type de validation associé au compte contrepartie qui est utilisé lorsque vous validez l''écriture sur cette ligne feuille.';
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the general business posting group code associated with the balancing account that will be used when you post the entry.', FRA = 'Spécifie le code groupe comptabilisation marché associé au compte contrepartie qui est utilisé lorsque vous validez l''écriture sur cette ligne feuille.';
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the general product posting group code associated with the balancing account that will be used when you post the entry.', FRA = 'Spécifie le code groupe comptabilisation produit associé au compte contrepartie qui est utilisé lorsque vous validez l''écriture sur cette ligne feuille.';
        }
        modify("Deferral Code")
        {
            ToolTipML = ENU = 'Specifies the deferral template that governs how expenses or revenue are deferred to the different accounting periods when the expenses or revenue were incurred.', FRA = 'Spécifie le modèle d''échelonnement qui régit la manière dont les dépenses ou les revenus sont reportés sur les différentes périodes de comptabilité lorsque des dépenses ou des revenus sont encourus.';
        }
        modify("Bal. VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the VAT business posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation marché TVA utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("Bal. VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the VAT product posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation produit TVA utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("Bill-to/Pay-to No.")
        {
            ToolTipML = ENU = 'Specifies the address code of the bill-to customer or pay-to vendor that the entry is linked to.', FRA = 'Spécifie le code adresse du client facturé ou du fournisseur à payer auquel l''écriture est liée.';
        }
        modify("Ship-to/Order Address Code")
        {
            ToolTipML = ENU = 'Specifies the address code of the ship-to customer or order-from vendor that the entry is linked to.', FRA = 'Spécifie le code adresse destinataire ou le code adresse de commande auquel l''écriture est liée.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';
        }
        modify("Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies the code that represents the payments terms that apply to the entry on the journal line.', FRA = 'Spécifie le code qui représente les conditions de paiement qui s''appliquent à l''écriture de la ligne feuille.';
        }
        modify("Applied Automatically")
        {
            ToolTipML = ENU = 'Specifies that the general journal line has been automatically applied with a matching payment using the Apply Automatically function.', FRA = 'Spécifie que la ligne feuille comptabilité a été lettrée automatiquement avec un paiement correspondant à l''aide de la fonction Lettrer automatiquement.';
        }
        modify(Applied)
        {
            CaptionML = ENU = 'Applied', FRA = 'Lettré';
        }
        modify("Applies-to Doc. Type")
        {
            ToolTipML = ENU = 'Specifies the type of the posted document that this document or journal line will be applied to when you post, for example to register payment.', FRA = 'Spécifie le type du document validé avec lequel ce document ou cette ligne feuille sera lettré lorsque vous validez, par exemple pour enregistrer un paiement.';
        }
        modify("Applies-to Doc. No.")
        {
            ToolTipML = ENU = 'Specifies the number of the posted document that this document or journal line will be applied to when you post, for example to register payment.', FRA = 'Spécifie le numéro du document validé avec lequel ce document ou cette ligne feuille sera lettré lorsque vous validez, par exemple pour enregistrer un paiement.';

            // BC Upgrade SHUKLP03 >> FDD-MTC-001
            trigger OnAfterValidate()
            var
                CustLedgEntry: Record "Cust. Ledger Entry";
                VendLedgEntry: Record "Vendor Ledger Entry";

            begin
                // If PostedSaleInv.Get(Rec."Applies-to Doc. No.") then
                //     Rec."Document Subtype Code" := PostedSaleInv."Document Subtype Code"
                // else
                //     Rec."Document Subtype Code" := '';
                IF (Rec."Applies-to Doc. No." <> xRec."Applies-to Doc. No.") AND (Rec."Applies-to Doc. No." <> '') THEN begin
                    GLSetup.GET();
                    IF Rec."Account Type" = Rec."Account Type"::Customer THEN BEGIN
                        CustLedgEntry.SETCURRENTKEY("Document No.");
                        CustLedgEntry.SETRANGE("Document No.", Rec."Applies-to Doc. No.");
                        CustLedgEntry.SETRANGE("Customer No.", Rec."Account No.");
                        CustLedgEntry.SETRANGE(Open, TRUE);
                        IF Rec.Amount <> 0 THEN BEGIN
                            CustLedgEntry.SETRANGE(Positive, Rec.Amount < 0);
                            IF CustLedgEntry.FIND('-') THEN;
                            CustLedgEntry.SETRANGE(Positive);
                        END;

                        IF CustLedgEntry.FIND('-') THEN
                            IF Rec."Currency Code" <> CustLedgEntry."Currency Code" THEN
                                IF Rec.Amount = 0 THEN
                                    // "Applies-to Doc. Type" := CustLedgEntry."Document Type";
                                    // "Applies-to Doc. No." := CustLedgEntry."Document No.";
                                    // "Applies-to ID" := '';
                                    // "Route Planning No." := CustLedgEntry."Route Planning No.";
                                    Rec."Document Subtype Code FND" := CustLedgEntry."Document Subtype Code FND"

                    END ELSE IF Rec."Account Type" = Rec."Account Type"::Vendor THEN BEGIN
                        VendLedgEntry.SETCURRENTKEY("Document No.");
                        VendLedgEntry.SETRANGE("Document No.", Rec."Applies-to Doc. No.");
                        VendLedgEntry.SETRANGE("Vendor No.", Rec."Account No.");
                        VendLedgEntry.SETRANGE(Open, TRUE);
                        IF Rec.Amount <> 0 THEN BEGIN
                            VendLedgEntry.SETRANGE(Positive, Rec.Amount < 0);
                            IF VendLedgEntry.FIND('-') THEN;
                            VendLedgEntry.SETRANGE(Positive);
                        END;
                        Rec.FIELDERROR("Applies-to Doc. No.");
                    END;
                    IF VendLedgEntry.FIND('-') THEN
                        IF Rec."Currency Code" <> VendLedgEntry."Currency Code" THEN
                            IF Rec.Amount = 0 THEN
                                // Rec."Applies-to Doc. Type" := VendLedgEntry."Document Type";
                                // "Applies-to Doc. No." := VendLedgEntry."Document No.";
                                // "Applies-to ID" := '';
                                // "Route Planning No." := VendLedgEntry."Route Planning No.";
                                Rec."Document Subtype Code FND" := VendLedgEntry."Document Subtype Code FND";
                end;
            end;
            // BC Upgrade SHUKLP03 << FDD-MTC-001

        }
        modify("Applies-to ID")
        {
            ToolTipML = ENU = 'Specifies the ID of entries that will be applied to when you choose the Apply Entries action.', FRA = 'Spécifie l''ID de lettrage des écritures lorsque vous choisissez l''action Ecr. ouvertes.';
        }
        modify("On Hold")
        {
            ToolTipML = ENU = 'Specifies if the journal line has been invoiced, and you execute the payment suggestions batch job, or you create a finance charge memo or reminder.', FRA = 'Indique si la ligne feuille a été facturée et si vous exécutez le traitement par lots de suggestion de paiements ou créez des intérêts ou une relance.';
        }
        modify("Bank Payment Type")
        {
            ToolTipML = ENU = 'Specifies the code for the payment type to be used for the entry on the payment journal line.', FRA = 'Spécifie le code du mode de paiement à utiliser pour l''écriture de la ligne feuille paiement.';
        }
        modify("Reason Code")
        {
            ToolTipML = ENU = 'Specifies the reason code that has been entered on the journal lines.', FRA = 'Spécifie le code motif qui a été saisi sur les lignes feuille.';
        }
        modify(Comment)
        {
            ToolTipML = ENU = 'Specifies a comment related to registering a payment.', FRA = 'Spécifie un commentaire lié à l''enregistrement d''un paiement.';
        }
        modify("Direct Debit Mandate ID")
        {
            ToolTipML = ENU = 'Specifies the identification of the direct-debit mandate that is being used on the journal lines to process a direct debit collection.', FRA = 'Spécifie l''identification du mandat de prélèvement qui est utilisé sur les lignes feuille pour traiter un recouvrement prélèvement.';
        }
        modify("Account Name")
        {
            CaptionML = ENU = 'Account Name', FRA = 'Nom du compte';
        }
        modify(AccName)
        {
            ToolTipML = ENU = 'Specifies the name of the account.', FRA = 'Spécifie le nom du compte.';
        }
        modify("Bal. Account Name")
        {
            CaptionML = ENU = 'Bal. Account Name', FRA = 'Nom du compte contrepartie';
        }
        modify(BalAccName)
        {
            CaptionML = ENU = 'Bal. Account Name', FRA = 'Nom du compte contrepartie';
            ToolTipML = ENU = 'Specifies the name of the balancing account that has been entered on the journal line.', FRA = 'Indique le nom du compte contrepartie qui a été saisi sur la ligne feuille où se trouve le pointeur de la souris.';
        }
        modify(Control1902759701)
        {
            CaptionML = ENU = 'Balance', FRA = 'Solde';
        }
        modify(Balance)
        {
            CaptionML = ENU = 'Balance', FRA = 'Solde';
            ToolTipML = ENU = 'Specifies the balance that has accumulated in the general journal on the line where the cursor is.', FRA = 'Spécifie le solde du document cumulé dans la feuille comptabilité sur la ligne où se trouve le pointeur de la souris.';
        }
        modify("Total Balance")
        {
            CaptionML = ENU = 'Total Balance', FRA = 'Solde final';
        }
        modify(TotalBalance)
        {
            CaptionML = ENU = 'Total Balance', FRA = 'Solde final';
            ToolTipML = ENU = 'Specifies the total balance in the general journal.', FRA = 'Indique le solde final de la feuille comptabilité.';
        }
        modify(WorkflowStatusBatch)
        {
            CaptionML = ENU = 'Batch Workflows', FRA = 'Flux de travail par lots';
        }
        modify(WorkflowStatusLine)
        {
            CaptionML = ENU = 'Line Workflows', FRA = 'Flux de travail ligne';
        }

        //Unsupported feature: Change Visible on "Control1900383207(Control 1900383207)". Please convert manually.


        //Unsupported feature: CodeInsertion on "Amount(Control 18)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        CheckTINNoMandatory; //HEI.05
        */
        //end;
        addafter("Document Type")
        {
            field("Source Code"; Rec."Source Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Account No.")
        {
            field("G/L Acc. No. 2"; Rec."G/L Acc. No. 2 FND")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Auto_Cust"; Rec."Auto_Cust FND")
            {
                ApplicationArea = All;

                trigger OnValidate();
                var
                    TempDimSetEntry: Record "Dimension Set Entry" temporary;
                    DimensionManagement: Codeunit DimensionManagement;
                begin
                    //HEI.10>>
                    TempDimSetEntry.RESET();
                    TempDimSetEntry.VALIDATE("Dimension Code", 'AUTO_CUST');
                    TempDimSetEntry.VALIDATE("Dimension Value Code", Rec."Auto_Cust FND");
                    TempDimSetEntry.INSERT();
                    CLEAR(TempDimSetEntry);
                    if TempDimSetEntry.FINDFIRST() then
                        Rec."Dimension Set ID" := DimensionManagement.GetDimensionSetID(TempDimSetEntry);
                    //HEI.10>>
                end;
            }
        }

        // BC Upgrade SHUKLP03 >> Blocked DIT Field.
        // addafter("Campaign No.")
        // {
        //     field("Contract Type"; Rec."Contract Type")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Service Contract No."; Rec."Service Contract No.")
        //     {
        //         Visible = false;
        //     }
        //     field("Financial Contract No."; Rec."Financial Contract No.")
        //     {
        //         Visible = false;
        //     }
        //     field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
        //     {
        //         Visible = false;
        //     }
        //     field("Contract Group Code"; Rec."Contract Group Code")
        //     {
        //         Visible = false;
        //     }
        //     field("Building No."; Rec."Building No.")
        //     {
        //         Visible = false;
        //     }
        //     field("Item Charge Type"; Rec."Item Charge Type")
        //     {
        //         Visible = false;
        //     }
        //}
        // BC Upgrade SHUKLP03 << Blocked DIT Field.

        addafter(Quantity)
        {
            field("Source Type"; Rec."Source Type")
            {
                ApplicationArea = All;
            }
        }
        modify("Amount (LCY)")
        {

            trigger OnAfterValidate();
            begin
                Rec.CheckTINNoMandatory(); //HEI.04
            end;
        }

        addafter("Credit Amount")
        {
            field("Debit Amount (LCY)"; Rec."Debit Amount (LCY) FND")
            {
                ApplicationArea = All;
            }
            field("Credit Amount (LCY)"; Rec."Credit Amount (LCY) FND")
            {
                ApplicationArea = All;
            }
        }
        addafter("Bal. Gen. Bus. Posting Group")
        {
            field("Source No."; Rec."Source No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Bill-to/Pay-to No.")
        {
            field("Vendor Bank Account"; Rec."Vendor Bank Account FND")
            {
                ApplicationArea = All;
            }
            // BC Upgrade SHUKLP03 >> Blocked DIT field.
            // field("Auto. Acc. Group"; Rec."Auto. Acc. Group")
            // {
            //     Description = 'FINXL7.00.001';
            // }
            // BC Upgrade SHUKLP03 << Blocked DIT field.

        }
        addafter(ShortcutDimCode8)
        {
            field("Maison des Vins Value Code"; Rec."Maison des Vins Value Code FND")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field(PayrollDim; PayrollDim)
            {
                //CaptionClass = Rec.GetDimCaptionClass(2);  // BC Upgrade SHUKLP03 << Blocked because not found in table.
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(16),
                                                              Blocked = CONST(false));
                Visible = SetPayrollDimVisible;
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    //HEI.13<<
                    GLSetup.GET();
                    if GLSetup."Payroll Dimension Code FND" <> '' then
                        ValidateLocalDim(GLSetup."Payroll Dimension Code FND", PayrollDim);
                    //HEI.13>>
                end;
            }
            field(SalariesDim; SalariesDim)
            {
                //CaptionClass = Rec.GetDimCaptionClass(3);  // BC Upgrade SHUKLP03 << Blocked because not found in table.
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(17),
                                                              Blocked = CONST(false));
                Visible = SetSalariesDimVisible;
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    //HEI.13<<
                    GLSetup.GET();
                    if GLSetup."Salaries Dimension Code FND" <> '' then
                        ValidateLocalDim(GLSetup."Salaries Dimension Code FND", SalariesDim);
                    //HEI.13>>
                end;
            }
        }
        addafter("Direct Debit Mandate ID")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
            field("TIN No."; Rec."TIN No. FND")
            {
                ApplicationArea = All;
            }
            field("Dimension Set ID"; Rec."Dimension Set ID")
            {
                ApplicationArea = All;
            }
            field("Transaction Code"; Rec."Transaction Code FND")
            {
                ApplicationArea = All;
            }
            field("Free Goods Accounting"; Rec."Free Goods Accounting FND")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("A&ccount")
        {
            CaptionML = ENU = 'A&ccount', FRA = '&Compte';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card', FRA = 'Fiche';
            ToolTipML = ENU = 'View or change detailed information about the record that is being processed on the journal line.', FRA = 'Affichez ou modifiez les informations détaillées sur l''enregistrement qui sont traitées sur la ligne feuille.';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
            ToolTipML = ENU = 'View the history of transactions that have been posted for the selected record.', FRA = 'Affichez l''historique des transactions qui ont été validées pour l''enregistrement sélectionné.';
        }
        modify(Approvals)
        {
            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("Renumber Document Numbers")
        {
            CaptionML = ENU = 'Renumber Document Numbers', FRA = 'Renuméroter des documents';
            ToolTipML = ENU = 'Resort the numbers in the Document No. column to avoid posting errors because the document numbers are not in sequence. Entry applications and line groupings are preserved.', FRA = 'Réaffectez les priorités des numéros dans la colonne N° document pour éviter les erreurs de validation dues au fait que les numéros de document ne sont pas dans l''ordre. Le lettrage des écritures et les groupements de lignes sont préservés.';
        }
        modify("Insert Conv. LCY Rndg. Lines")
        {
            CaptionML = ENU = 'Insert Conv. LCY Rndg. Lines', FRA = 'Insérer lignes arr. conv. DS';
            ToolTipML = ENU = 'Insert a rounding correction line in the journal. This rounding correction line will balance in LCY when amounts in the foreign currency also balance. You can then post the journal.', FRA = 'Insérez une ligne correction arrondi dans la feuille. Cette ligne correction d''arrondi permet d''équilibrer en devise société lorsque les montants en devise étrangère sont également équilibrés. Vous pouvez alors valider la feuille.';
        }
        modify("-")
        {
            CaptionML = ENU = '-', FRA = '-';
        }
        modify(GetStandardJournals)
        {
            CaptionML = ENU = '&Get Standard Journals', FRA = '&Obtenir les feuilles standard';
            ToolTipML = ENU = 'Select a standard general journal to be inserted.', FRA = 'Sélectionnez une feuille comptabilité standard à insérer.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(SaveAsStandardJournal)
        {
            CaptionML = ENU = '&Save as Standard Journal', FRA = 'Enregi&strer en tant que feuille standard';
            ToolTipML = ENU = 'Define the journal lines that you want to use later as a standard journal before you post the journal.', FRA = 'Définissez les lignes feuille que vous souhaitez utiliser ultérieurement comme une feuille standard avant de valider la feuille.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("Test Report")
        {
            CaptionML = ENU = 'Test Report', FRA = 'Impression test';
            ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';
        }
        modify(Post)
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
            ToolTipML = ENU = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.', FRA = 'Finalisez le document ou la feuille en validant les montants et les quantités sur les comptes concernés dans la comptabilité de la société.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Preview)
        {
            CaptionML = ENU = 'Preview Posting', FRA = 'Aperçu compta.';
            ToolTipML = ENU = 'Review the different types of entries that will be created when you post the document or journal.', FRA = 'Examinez les différents types d''écritures qui seront créés lorsque vous validez le document ou la feuille.';
        }
        modify(PostAndPrint)
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
            ToolTipML = ENU = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.', FRA = 'Finalisez et préparez-vous à imprimer le document ou la feuille. Les valeurs et les quantités sont validées en fonction des comptes associés. Une fenêtre de demande d''état où vous pouvez spécifier ce qu''il faut inclure sur l''élément à imprimer.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(DeferralSchedule)
        {
            CaptionML = ENU = 'Deferral Schedule', FRA = 'Tableau d''échelonnement';
            ToolTipML = ENU = 'View or edit the deferral schedule that governs how expenses or revenue are deferred to different accounting periods when the journal line is posted.', FRA = 'Affichez ou modifiez le tableau d''échelonnement qui régit la manière dont les dépenses ou les revenus sont reportés sur différentes périodes de comptabilité lorsque la ligne feuille est validée.';
        }
        modify(IncomingDocument)
        {
            CaptionML = ENU = 'Incoming Document', FRA = 'Document entrant';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(IncomingDocCard)
        {
            CaptionML = ENU = 'View Incoming Document', FRA = 'Afficher le document entrant';
            ToolTipML = ENU = 'View any incoming document records and file attachments that exist for the entry or document.', FRA = 'Affichez tout enregistrement et fichier joint de document entrant qui existe pour l''écriture ou le document.';
        }
        modify(SelectIncomingDoc)
        {
            CaptionML = ENU = 'Select Incoming Document', FRA = 'Sélectionner le document entrant';
            ToolTipML = ENU = 'Select an incoming document record and file attachment that you want to link to the entry or document.', FRA = 'Sélectionnez un fichier joint ou un enregistrement de document entrant que vous voulez associer à l''écriture ou au document.';
        }
        modify(IncomingDocAttachFile)
        {
            CaptionML = ENU = 'Create Incoming Document from File', FRA = 'Créer un document entrant à partir d''un fichier';
            ToolTipML = ENU = 'Create an incoming document record by selecting a file to attach, and then link the incoming document record to the entry or document.', FRA = 'Créez un enregistrement de document entrant en sélectionnant un fichier à joindre, puis associez l''enregistrement de document entrant à l''écriture ou au document.';
        }
        modify(RemoveIncomingDoc)
        {
            CaptionML = ENU = 'Remove Incoming Document', FRA = 'Supprimer le document entrant';
            ToolTipML = ENU = 'Remove the link to an incoming document record and file attachment.', FRA = 'Supprimez le lien dans un fichier joint ou un enregistrement de document entrant.';
        }
        modify("B&ank")
        {
            CaptionML = ENU = 'B&ank', FRA = 'B&anque';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(ImportBankStatement)
        {
            CaptionML = ENU = 'Import Bank Statement', FRA = 'Importer le relevé bancaire';
        }
        modify(ShowStatementLineDetails)
        {
            CaptionML = ENU = 'Bank Statement Details', FRA = 'Détails relevé bancaire';
        }
        modify(Reconcile)
        {
            CaptionML = ENU = 'Reconcile', FRA = 'Simuler';
            ToolTipML = ENU = 'View the balances on bank accounts that are marked for reconciliation, usually liquid accounts.', FRA = 'Affichez les soldes des comptes bancaires qui sont destinés au rapprochement, en général des comptes de liquidités.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Application)
        {
            CaptionML = ENU = 'Application', FRA = 'Lettrage';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("Apply Entries")
        {
            CaptionML = ENU = 'Apply Entries', FRA = 'Lettrer écritures';
            ToolTipML = ENU = 'Select one or more ledger entries that you want to apply this record to so that the related posted documents are closed as paid or refunded.', FRA = 'Sélectionnez une ou plusieurs écritures comptables que vous voulez lettrer avec cet enregistrement afin que les documents validés concernés soient fermés comme étant payés ou remboursés.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Match)
        {
            CaptionML = ENU = 'Apply Automatically', FRA = 'Lettrer automatiquement';
        }
        modify(AddMappingRule)
        {
            CaptionML = ENU = 'Map Text to Account', FRA = 'Mapper le texte avec le compte';
        }
        modify("Payro&ll")
        {
            CaptionML = ENU = 'Payro&ll', FRA = 'Pa&ie';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(ImportPayrollFile)
        {
            CaptionML = ENU = 'Import Payroll File', FRA = 'Importer le fichier de paie';
        }
        modify(ImportPayrollTransactions)
        {
            CaptionML = ENU = 'Import Payroll Transactions', FRA = 'Importer les transactions de paie';
            ToolTipML = ENU = 'Import Payroll Transactions', FRA = 'Importer les transactions de paie';
        }
        modify("Request Approval")
        {
            CaptionML = ENU = 'Request Approval', FRA = 'Approbation demande achat';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(SendApprovalRequest)
        {
            CaptionML = ENU = 'Send Approval Request', FRA = 'Envoyer demande d''approbation';
        }
        modify(SendApprovalRequestJournalBatch)
        {
            CaptionML = ENU = 'Journal Batch', FRA = 'Feuille';
            ToolTipML = ENU = 'Send all journal lines for approval, also those that you may not see because of filters.', FRA = 'Envoyez toutes les lignes feuilles pour approbation, y compris celles que vous ne voyez peut-être pas à cause de filtres.';
        }
        modify(SendApprovalRequestJournalLine)
        {
            CaptionML = ENU = 'Selected Journal Lines', FRA = 'Lignes feuille sélectionnées';
            ToolTipML = ENU = 'Send selected journal lines for approval.', FRA = 'Envoyez certaines lignes feuille pour approbation.';
        }
        modify(CancelApprovalRequest)
        {
            CaptionML = ENU = 'Cancel Approval Request', FRA = 'Annuler demande d''approbation';
        }
        modify(CancelApprovalRequestJournalBatch)
        {
            CaptionML = ENU = 'Journal Batch', FRA = 'Feuille';
            ToolTipML = ENU = 'Cancel sending all journal lines for approval, also those that you may not see because of filters.', FRA = 'Annulez l''envoi de toutes les lignes feuilles pour approbation, y compris celles que vous ne voyez peut-être pas à cause de filtres.';
        }
        modify(CancelApprovalRequestJournalLine)
        {
            CaptionML = ENU = 'Selected Journal Lines', FRA = 'Lignes feuille sélectionnées';
            ToolTipML = ENU = 'Cancel sending selected journal lines for approval.', FRA = 'Annulez l''envoi de certaines lignes feuilles pour approbation.';
        }
        modify(Approval)
        {
            CaptionML = ENU = 'Approval', FRA = 'Approbation';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Approve)
        {
            CaptionML = ENU = 'Approve', FRA = 'Approuver';
            ToolTipML = ENU = 'Approve the requested changes.', FRA = 'Approuvez les modifications requises.';
        }
        modify(Reject)
        {
            CaptionML = ENU = 'Reject', FRA = 'Rejeter';
            ToolTipML = ENU = 'Reject the approval request.', FRA = 'Rejetez la demande d''approbation.';
        }
        modify(Delegate)
        {
            CaptionML = ENU = 'Delegate', FRA = 'Déléguer';
            ToolTipML = ENU = 'Delegate the approval to a substitute approver.', FRA = 'Déléguez l''approbation à un approbateur remplaçant.';
        }


        //Unsupported feature: CodeInsertion on "ImportBankStatement(Action 11).OnAction". Please convert manually.

        //trigger (Variable: ImportBankStatement)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on "ImportBankStatement(Action 11).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if FINDLAST then;
        ImportBankStatement;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if FINDLAST then;
        //MSF
        // ImportBankStatement :=;
        //>>MSF
        */
        //end;
        addafter(SaveAsStandardJournal)
        {
            // BC Upgrade SHUKLP03 >> Blocked code because of DIT XMLport "Import Gen. Journal".
            // action("Import Gen. Journal")
            // {
            //     CaptionML = ENU = 'Import Gen. Journal',
            //                 FRA = 'Importer feuille comptabilité';
            //     Description = 'FINXL7.00.001';
            //     Ellipsis = true;
            //     Enabled = EnableActnIfTemplateNtBlck;
            //     Image = Import;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;

            //     trigger OnAction();
            //     var
            //         lxmlImportGenJournal: XMLport "Import Gen. Journal";
            //     begin
            //         //<<FINXL7.00.001 RBE 06/08/2013
            //         CLEAR(lxmlImportGenJournal);
            //         lxmlImportGenJournal.fctSetParameters("Journal Template Name", "Journal Batch Name");
            //         lxmlImportGenJournal.RUN;
            //         //>>FINXL7.00.001 RBE 06/08/2013
            //     end;
            // }
            // BC Upgrade SHUKLP03 << Blocked code because of DIT XMLport "Import Gen. Journal".
            action("GL Mass Upload")
            {
                Caption = 'GL Mass Upload';
                Ellipsis = true;
                Enabled = EnableActnIfTemplateNtBlck;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction();
                var
                    ImportGenJournalFromExcel: Report "Import Gen.Jrnl From Excel CBN";
                begin
                    CLEAR(ImportGenJournalFromExcel);
                    ImportGenJournalFromExcel.SetGenJournal(Rec."Journal Template Name", Rec."Journal Batch Name");
                    ImportGenJournalFromExcel.RUNMODAL();
                end;
            }
            // BC Upgrade SHUKLP03 >> Blocked code because of DIT XMLport "Import Gen. Journal".
            // action(SuggestCustPayments)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Suggest Customer Payments';
            //     Description = 'NRQ17902';
            //     Ellipsis = true;
            //     Enabled = EnableActnIfTemplateNtBlck;
            //     Image = SuggestCustomerPayments;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     ToolTip = 'Create payment suggestion as lines in the Cash Receipt Journal';

            //     trigger OnAction();
            //     var
            //         SuggestCustomerPayments: Report "Suggest Customer Payments";
            //     begin
            //         //<<DITW110.00.11 MSF 25/08/2017 NRQ#17902
            //         CLEAR(SuggestCustomerPayments);
            //         SuggestCustomerPayments.SetGenJnlLine(Rec);
            //         SuggestCustomerPayments.RUNMODAL;
            //         //>>DITW110.00.11 MSF 25/08/2017 NRQ#17902
            //     end;
            // }
            // BC Upgrade SHUKLP03 << Blocked code because of DIT XMLport "Import Gen. Journal".


        }
        addafter(ImportPayrollTransactions)
        {
            action(ImportPayroll)
            {
                Caption = 'Import Payroll';
                Enabled = EnableActnIfTemplateNtBlck;
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction();
                var
                    GenJournalLine: Record "Gen. Journal Line";
                    GeneralOpCoSetup: Record "General OpCo Setup FND";
                    GenJnlBatchname: Code[20];
                    GenJnlTemplateName: Code[20];
                begin
                    //HEI.03>>
                    /*
                    GenJnlBatchname := "Journal Batch Name";
                    GenJnlTemplateName := "Journal Template Name";
                    GenJournalLine.SETRANGE("Journal Template Name",GenJnlTemplateName);
                    GenJournalLine.SETRANGE("Journal Batch Name",GenJnlBatchname);
                    */
                    GeneralOpCoSetup.GET();
                    GeneralOpCoSetup.TESTFIELD("Payroll Report ID");
                    //GenJournalLine.SETRECFILTER;
                    Rec.FILTERGROUP(2);
                    REPORT.RUNMODAL(GeneralOpCoSetup."Payroll Report ID", true, true, Rec);
                    Rec.FILTERGROUP(0);
                    //HEI.03<<

                end;
            }
        }
    }

    var
        ImportBankStatement: Codeunit "Import Bank Statement";



    //Unsupported feature: PropertyModification on "Text000(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=General Journal lines have been successfully inserted from Standard General Journal %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=General Journal lines have been successfully inserted from Standard General Journal %1.;FRA=Les lignes feuille comptabilité ont été insérées à partir de la feuille comptabilité standard %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=Standard General Journal %1 has been successfully created.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=Standard General Journal %1 has been successfully created.;FRA=La création de la feuille comptabilité standard %1 a réussi.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "AccTypeNotSupportedErr(Variable 1017)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //AccTypeNotSupportedErr : ENU=You cannot specify a deferral code for this type of account.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //AccTypeNotSupportedErr : ENU=You cannot specify a deferral code for this type of account.;FRA=Vous ne pouvez pas spécifier un code échelonnement pour ce type de compte.;
    //Variable type has not been exported.

    var
        DimensionSetEntry: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        SetMaisionDesVinsDimVisible: Boolean;
        SetPayrollDimVisible: Boolean;
        SetSalariesDimVisible: Boolean;
        PayrollDim: Code[10];
        SalariesDim: Code[10];
        EnableActnIfTemplateNtBlck: Boolean;
        GenJnlTemplate: Record "Gen. Journal Template";


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GenJnlManagement.GetAccounts(Rec,AccName,BalAccName);
    UpdateBalance;
    SetControlAppearance;
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    EnableActnIfTemplateNtBlck := EnableActionIfTemplateNtBlock;   //HEI.14
    // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
    SetFilterSubContractPostType;
     // >>DITW16.00.00.41 AHU DIT-715 #327
    #1..4
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    trigger OnAfterGetRecord()
    begin
        EnableActnIfTemplateNtBlck := Rec.EnableActionIfTemplateNtBlock();   //HEI.14

        //HEI.10
        if DimensionSetEntry.GET(Rec."Dimension Set ID", 'AUTO_CUST') then
            Rec."Auto_Cust FND" := DimensionSetEntry."Dimension Value Code"
        else
            Rec."Auto_Cust FND" := '';
        //HEI.10
        //HEI.12<<
        GLSetup.GET();
        DimensionSetEntry.RESET();
        if DimensionSetEntry.GET(Rec."Dimension Set ID", GLSetup."Maison des Vins Dim. Code FND") then
            Rec."Maison des Vins Value Code FND" := DimensionSetEntry."Dimension Value Code"
        else
            Rec."Maison des Vins Value Code FND" := '';
        //HEI.12>>

        //HEI.13<<
        DimensionSetEntry.RESET();
        if DimensionSetEntry.GET(Rec."Dimension Set ID", GLSetup."Payroll Dimension Code FND") then
            PayrollDim := DimensionSetEntry."Dimension Value Code"
        else
            PayrollDim := '';
        DimensionSetEntry.RESET();
        if DimensionSetEntry.GET(Rec."Dimension Set ID", GLSetup."Salaries Dimension Code FND") then
            SalariesDim := DimensionSetEntry."Dimension Value Code"
        else
            SalariesDim := '';
        //HEI.13>>
    end;


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TotalBalanceVisible := true;
    BalanceVisible := true;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TotalBalanceVisible := true;
    BalanceVisible := true;

    //HEI.13<<
    GLSetup.GET;
    if GLSetup."Payroll Dimension Code" <> '' then
      SetPayrollDimVisible := true
    else
      SetPayrollDimVisible := false;
    if GLSetup."Salaries Dimension Code" <> '' then
      SetSalariesDimVisible := true
    else
      SetSalariesDimVisible := false;
    //HEI.13>>
    //HEI.14>>
    CLEAR(EnableActnIfTemplateNtBlck);
    EnableActnIfTemplateNtBlck := true;
    //HEI.14<<
    */
    //end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //HEI.13<<
        GLSetup.GET();
        IF GLSetup."Payroll Dimension Code FND" <> '' THEN
            SetPayrollDimVisible := TRUE
        ELSE
            SetPayrollDimVisible := FALSE;
        IF GLSetup."Salaries Dimension Code FND" <> '' THEN
            SetSalariesDimVisible := TRUE
        ELSE
            SetSalariesDimVisible := FALSE;
        //HEI.13>>
        //HEI.14>>
        CLEAR(EnableActnIfTemplateNtBlck);
        EnableActnIfTemplateNtBlck := TRUE;
        //HEI.14<<
    end;

    local procedure ValidateLocalDim(DimCode: Code[20]; DimValueCode: Code[20]);
    var
        DimSetEntry: Record "Dimension Set Entry";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        GLSetup: Record "General Ledger Setup";
        DimensionManagement: Codeunit DimensionManagement;
    begin
        //HEI.13<<
        DimSetEntry.RESET();
        DimSetEntry.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
        if DimSetEntry.FINDSET() then
            repeat
                TempDimSetEntry.INIT();
                TempDimSetEntry.TRANSFERFIELDS(DimSetEntry);
                TempDimSetEntry."Dimension Set ID" := 0;
                TempDimSetEntry.INSERT();
            until DimSetEntry.NEXT() = 0;

        TempDimSetEntry.RESET();
        if not TempDimSetEntry.GET(0, DimCode) then begin
            TempDimSetEntry.VALIDATE("Dimension Code", DimCode);
            TempDimSetEntry.VALIDATE("Dimension Value Code", DimValueCode);
            TempDimSetEntry.INSERT();
        end else begin
            TempDimSetEntry.VALIDATE("Dimension Value Code", DimValueCode);
            TempDimSetEntry.MODIFY();
        end;

        TempDimSetEntry.RESET();
        if TempDimSetEntry.FINDFIRST() then
            Rec."Dimension Set ID" := DimensionManagement.GetDimensionSetID(TempDimSetEntry);
        //HEI.13>>
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

