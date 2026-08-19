pageextension 51070 VendorBankAccountCardExtCBN extends "Vendor Bank Account Card"
{
    // # HEI.01 IBM PATHAA02 27.08.2017 Made “Show Mandatory” property to TRUE for Mandatory Fields (Code, Name, Address, Country/Region,
    // Bank branch No, Bank Account No, IBAN)
    // HEI.02 FDD PTPGAP084 IBM POSTOI01 19.05.2018
    //   # show new fields 50001->50003 in new group Sensitive data
    // HEI.03 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Code added in OnOpenPage
    //   # New fields "Agency Code", "RIB Key", "RIB Checked"
    // HEI.04 FDD-HT1103 IBM SURYAS01  13-04-2020
    //   #Added new Field - "Compensation Bank"
    // HEI.05 CHG2119688 IBM POENAB02 04.11.2022 HB2428 Panama CITI - bank connectivity payment file
    //   # New field added: 50012 Domestic - Bank Branch No.
    // HEI.06 CHG2119688 IBM POENAB02 21.12.2022 HB2428 Panama CITI - bank connectivity payment file
    //   # New field added: 50013 "Interm. Bank BIC/SWFT Code"
    // HEI.07 CHG2119688 IBM POENAB02 19.01.2023 HB2428 Panama CITI - bank connectivity payment file
    //   # Field 50013 "Interm. Bank BIC/SWFT Code" moved to Transfer group
    //   # Panama Group removed from page

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies a code to identify this vendor bank account.', FRA = 'Spécifie un code pour identifier le compte bancaire de ce fournisseur.';
            ShowMandatory = TRUE;
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name of the bank where the vendor has this bank account.', FRA = 'Spécifie le nom de la banque où le fournisseur a ouvert ce compte bancaire.';
            ShowMandatory = TRUE;
        }
        modify(Address)
        {
            ToolTipML = ENU = 'Specifies the address of the bank where the vendor has the bank account.', FRA = 'Spécifie l''adresse de la banque où le fournisseur a ouvert le compte bancaire.';
            ShowMandatory = TRUE;
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
            ToolTipML = ENU = 'Specifies the city of the bank where the vendor has the bank account.', FRA = 'Spécifie la ville de la banque dans laquelle le fournisseur possède le compte bancaire.';
        }
        modify("Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region of the address.', FRA = 'Spécifie le pays/la région de l''adresse.';
            ShowMandatory = TRUE;
        }
        modify("Phone No.")
        {
            ToolTipML = ENU = 'Specifies the telephone number of the bank where the vendor has the bank account.', FRA = 'Spécifie le numéro de téléphone de la banque où le fournisseur a ouvert le compte bancaire.';
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
            ShowMandatory = TRUE;
        }
        modify("Bank Account No.")
        {
            ToolTipML = ENU = 'Specifies the number used by the bank for the bank account.', FRA = 'Spécifie le numéro utilisé par la banque pour le compte bancaire.';
            ShowMandatory = TRUE;
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
            ToolTipML = ENU = 'Specifies the fax number of the bank where the vendor has the bank account.', FRA = 'Spécifie le numéro de télécopie de la banque où le fournisseur a ouvert le compte bancaire.';
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
            ToolTipML = ENU = 'Specifies the SWIFT code (international bank identifier code) of the bank where the vendor has the account.', FRA = 'Spécifie le code SWIFT (code international d''identification bancaire) de la banque qui détient le compte du fournisseur.';
            ShowMandatory = TRUE;
        }
        modify(IBAN)
        {
            ToolTipML = ENU = 'Specifies the bank account''s international bank account number.', FRA = 'Spécifie le numéro du compte bancaire international.';
            ShowMandatory = TRUE;
        }
        modify("Bank Clearing Standard")
        {
            ToolTipML = ENU = 'Specifies the format standard to be used in bank transfers if you use the Bank Clearing Code field to identify you as the sender.', FRA = 'Spécifie la norme de format à utiliser dans des transferts bancaires si vous utilisez le champ Code compensation bancaire pour vous identifier en tant qu''expéditeur.';
        }
        modify("Bank Clearing Code")
        {
            ToolTipML = ENU = 'Specifies the code for bank clearing that is required according to the format standard you selected in the Bank Clearing Standard field.', FRA = 'Spécifie le code pour la compensation bancaire qui est requis selon la norme de format que vous avez sélectionnée dans le champ Standard compensation bancaire.';
        }
        addafter("Currency Code")
        {
            field("Account Type"; Rec."Account Type FND")
            {
                ApplicationArea = Basic, Suite;
                OptionCaption = ' ,Checking,Savings';
                ToolTip = 'Specifies the value of the Account Type field.';
            }
        }
        // BC Upgrade NANDIS03 - Blocked as FR Localization fields >>
        // addafter("Bank Branch No.")
        // {
        //     field("Agency Code"; Rec."Agency Code")
        //     {
        //         ApplicationArea = Basic, Suite;
        //         Enabled = FRLocAction;
        //         ToolTipML = ENU = 'Specifies the five-number code of the agency of the bank, for example, 00300.',
        //                     FRA = 'Spécifie le code à 5 chiffres de l''agence bancaire, par exemple 00300.';
        //         Visible = FRLocAction;

        //     }
        // }          
        // addafter("Bank Account No.")
        // {
        //     field("RIB Key"; Rec."RIB Key")
        //     {
        //         ApplicationArea = Basic, Suite;
        //         Enabled = FRLocAction;
        //         ToolTipML = ENU = 'Specifies the two-digit RIB key associated with the Bank Account No.',
        //                     FRA = 'Spécifie la clé RIB à deux chiffres associée au N° compte bancaire.';
        //         Visible = FRLocAction;
        //     }
        //     field("RIB Checked"; Rec."RIB Checked")
        //     {
        //         ApplicationArea = Basic, Suite;
        //         Enabled = FRLocAction;
        //         ToolTipML = ENU = 'Specifies the Bank Account No. has been verified against the RIB Key.',
        //                     FRA = 'Spécifie que le N° compte bancaire a été vérifié par rapport à la Clé RIB.';
        //         Visible = FRLocAction;
        //     }
        // }
        // BC Upgrade NANDIS03 - Blocked as FR Localization fields <<
        // addafter("Transit No.") // BC FR Upgrade KAIRAR01
        addafter("Bank Account No.")
        {
            field("Compensation Bank"; Rec."Compensation Bank FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Compensation Bank field.';
            }
        }
        addafter("Bank Clearing Code")
        {
            field("Bank Method"; Rec."Bank Method FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Bank Method field.';
            }
            field("Interm. Bank BIC/SWIFT Code"; Rec."Interm. Bank BIC/SWIFT Cod FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Intermediary Bank BIC/SWIFT Code field.';

            }
        }
        addafter(Transfer)
        {
            group("Sensitive Data")
            {
                Caption = 'Sensitive Data';
                field("Old Bank Account No."; Rec."Old Bank Account No. FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Old Bank Account No. field.';
                }
                field("Old Bank Branch No."; Rec."Old Bank Branch No. FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Old Bank Branch No. field.';
                }
                field("Old IBAN"; Rec."Old IBAN FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Old IBAN field.';
                }
            }

        }
    }

    var
        CompanyInfo: Record "Company Information";
        FRLocAction: Boolean;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //begin
    /*
    //HEI.03>>
    FRLocAction := false;
    CompanyInfo.GET;
    if CompanyInfo."Enable French Localization" then
      FRLocAction := true;
    //HEI.03<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

