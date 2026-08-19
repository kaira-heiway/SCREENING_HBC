pageextension 51184 CustomerBankAccountCardExtCBN extends "Customer Bank Account Card"
{
    // HEI.01 Defect #1066 IBM NASTAA02 13.12.2017 # Bank sensitive details change
    //   # Fields "Old Bank Account No.", "Old Bank Branch No." and "Old IBAN" added on new group "Sensitive Data"
    // HEI.02 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Code added in OnOpenPage
    //   # New fields "Agency Code", "RIB Key", "RIB Checked"
    //Bc Upgrade YADAVM09 Drink it field blocked- 'Agency Code','RIB Key','RIB Checked'.
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies a code to identify this customer bank account.', FRA = 'Spécifie un code pour identifier le compte bancaire de ce client.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name of the bank where the customer has the bank account.', FRA = 'Spécifie le nom de la banque où le client a ouvert le compte bancaire.';
        }
        modify(Address)
        {
            ToolTipML = ENU = 'Specifies the address of the bank where the customer has the bank account.', FRA = 'Spécifie l''adresse de la banque où le client a ouvert le compte bancaire.';
        }
        modify("Address 2")
        {
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';
        }
        modify("Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify(City)
        {
            ToolTipML = ENU = 'Specifies the city of the bank where the customer has the bank account.', FRA = 'Spécifie la ville de la banque dans laquelle le client possède le compte bancaire.';
        }
        modify("Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region of the address.', FRA = 'Spécifie le pays/la région de l''adresse.';
        }
        modify("Phone No.")
        {
            ToolTipML = ENU = 'Specifies the telephone number of the bank where the customer has the bank account.', FRA = 'Spécifie le numéro de téléphone de la banque où le client a ouvert le compte bancaire.';
        }
        modify(Contact)
        {
            ToolTipML = ENU = 'Specifies the name of the bank employee regularly contacted in connection with this bank account.', FRA = 'Spécifie le nom de l''employé de banque contacté au sujet de ce compte bancaire.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the relevant currency code for the bank account.', FRA = 'Spécifie le code devise approprié pour le compte bancaire.';
        }
        modify("Bank Branch No.")
        {
            ToolTipML = ENU = 'Specifies the number of the bank branch.', FRA = 'Spécifie le numéro de l''établissement de la banque.';
        }
        modify("Bank Account No.")
        {
            ToolTipML = ENU = 'Specifies the number used by the bank for the bank account.', FRA = 'Spécifie le numéro utilisé par la banque pour le compte bancaire.';
        }
        // modify("Transit No.") // BC FR Upgrade KAIRAR01
        // {
        //     ToolTipML = ENU = 'Specifies a bank identification number of your own choice.', FRA = 'Spécifie un numéro d''identification bancaire de votre choix.';
        // }
        modify(Communication)
        {
            CaptionML = ENU = 'Communication', FRA = 'Communication';
        }
        modify("Fax No.")
        {
            ToolTipML = ENU = 'Specifies the fax number of the bank where the customer has the bank account.', FRA = 'Spécifie le numéro de télécopie de la banque où le client a ouvert le compte bancaire.';
        }
        modify("E-Mail")
        {
            ToolTipML = ENU = 'Specifies the email address associated with the bank account.', FRA = 'Spécifie l''adresse e-mail qui est associée au compte bancaire.';
        }
        modify("Home Page")
        {
            ToolTipML = ENU = 'Specifies the home page address associated with the bank account.', FRA = 'Spécifie la page d''accueil qui est associée au compte bancaire.';
        }
        modify(Transfer)
        {
            CaptionML = ENU = 'Transfer', FRA = 'Virement';
        }
        modify("SWIFT Code")
        {
            ToolTipML = ENU = 'Specifies the SWIFT code (international bank identifier code) of the bank where the customer has the account.', FRA = 'Spécifie le code SWIFT (code international d''identification bancaire) de la banque qui détient le compte du client.';
        }
        modify(IBAN)
        {
            ToolTipML = ENU = 'Specifies the bank account''s international bank account number.', FRA = 'Spécifie le numéro du compte bancaire international.';
        }
        modify("Bank Clearing Standard")
        {
            ToolTipML = ENU = 'Specifies the format standard to be used in bank transfers if you use the Bank Clearing Code field to identify you as the sender.', FRA = 'Spécifie la norme de format à utiliser dans des transferts bancaires si vous utilisez le champ Code compensation bancaire pour vous identifier en tant qu''expéditeur.';
        }
        modify("Bank Clearing Code")
        {
            ToolTipML = ENU = 'Specifies the code for bank clearing that is required according to the format standard you selected in the Bank Clearing Standard field.', FRA = 'Spécifie le code pour la compensation bancaire qui est requis selon la norme de format que vous avez sélectionnée dans le champ Standard compensation bancaire.';
        }
        /* //Bc Upgrade YADAVM09 Drink it field commented>>
        addafter("Bank Branch No.")
        {
            field("Agency Code"; Rec."Agency Code")
            {
                ApplicationArea = Basic, Suite;
                Enabled = FRLocAction;
                ToolTipML = ENU = 'Specifies the five-number code of the agency of the bank, for example, 00300.',
                            FRA = 'Spécifie le code à 5 chiffres de l''agence bancaire, par exemple 00300.';
                Visible = FRLocAction;
            }
        }
        
        addafter("Bank Account No.")
        {
            field("RIB Key"; Rec."RIB Key")
            {
                ApplicationArea = Basic, Suite;
                Enabled = FRLocAction;
                ToolTipML = ENU = 'Specifies the two-digit RIB key associated with the Bank Account No.',
                            FRA = 'Spécifie la clé RIB à deux chiffres associée au N° compte bancaire.';
                Visible = FRLocAction;
            }
            field("RIB Checked"; Rec."RIB Checked")
            {
                ApplicationArea = Basic, Suite;
                Enabled = FRLocAction;
                ToolTipML = ENU = 'Specifies the Bank Account No. has been verified against the RIB Key.',
                            FRA = 'Spécifie que le N° compte bancaire a été vérifié par rapport à la Clé RIB.';
                Visible = FRLocAction;
            }
        }
        */ //Bc Upgrade YADAVM09 Drink it field commented<<
        addafter(Transfer)
        {
            group("Sensitive Data")
            {
                Caption = 'Sensitive Data';
                field("Old Bank Account No."; Rec."Old Bank Account No. FND")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Old Bank Account No. field.';
                }
                field("Old Bank Branch No."; Rec."Old Bank Branch No. FND")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Old Bank Branch No. field.';
                }
                field("Old IBAN"; Rec."Old IBAN FND")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Old IBAN field.';
                }
            }
        }
    }
    actions
    {
        modify("Direct Debit Mandates")
        {
            CaptionML = ENU = 'Direct Debit Mandates', FRA = 'Mandats de domiciliation européenne';
            ToolTipML = ENU = 'View or edit direct-debit mandates that you set up to reflect agreements with customers to collect invoice payments from their bank account.', FRA = 'Affichez ou modifiez des mandats de prélèvement que vous définissez afin de refléter les accords passés avec les clients pour le recouvrement des paiements des factures sur leur compte bancaire.';
        }
    }

    var
        CompanyInfo: Record "Company Information";
        FRLocAction: Boolean;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //begin
    /*
    //HEI.02>>
    FRLocAction := false;
    CompanyInfo.GET;
    if CompanyInfo."Enable French Localization" then
      FRLocAction := true;
    //HEI.02<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

