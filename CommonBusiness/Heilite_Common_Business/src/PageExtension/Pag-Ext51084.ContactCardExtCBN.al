pageextension 51084 ContactCardExtCBN extends "Contact Card"
{
    // version NAVW110.0.00.15601,DITW110.00.09
    //DITW15.00.00.39 DDR 04/07/2011 issue 951 Added tab 'Contract' + field "Serv. Contract Acc. Gr. Code"

    //FINXL7.00.001 RBE 20/03/2013 : Added VAT Validation
    //FINXL7.00.001 WSA 15/07/2014 #88 : Removed fct fctValidateVAT
    //DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //DITW17.10.05 WSA 10/11/2014 DIT-770 #    Added field "Job Title"
    //DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    //DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    //HEI.01 CHG2024918 IBM POENAB02 16.09.2019 La R‚union_France Fiscal Year Closing
    //# Code added in OnInit()
    //# Modified function EnableFields
    //# Fields added in General Group: "Trade Register", "APE Code", "Legal Form", "Stock Capital"


    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the contact number.', FRA = 'Spécifie le numéro contact.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name of the contact. If the contact is a person, you can click the field to see the Name Details window.', FRA = 'Spécifie le nom du contact. Si le contact est une personne, vous pouvez cliquer sur le champ pour voir la fenêtre Aperçu nom.';
        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the type of contact, either company or person.', FRA = 'Spécifie le type de contact : société ou personne.';
        }
        modify("Company Name")
        {
            ToolTipML = ENU = 'Specifies the name of the company. If the contact is a person, Specifies the name of the company for which this contact works. This field is not editable.', FRA = 'Spécifie le nom de la société. Si le contact est une personne, spécifie le nom de la société qui emploie ce contact. Ce champ n''est pas modifiable.';
        }
        modify(IntegrationCustomerNo)
        {
            CaptionML = ENU = 'Integration Customer No.', FRA = 'Intégration N° client';
            ToolTipML = ENU = 'Specifies the number of a customer that is integrated through Dynamics CRM.', FRA = 'Spécifie le numéro d''un client intégré via Dynamics CRM.';
        }
        modify("Search Name")
        {
            ToolTipML = ENU = 'Specifies the search name of the contact. You can use this field to search for a contact when you cannot remember the contact number.', FRA = 'Spécifie le nom de recherche du contact. Vous pouvez utiliser ce champ pour rechercher un contact lorsque vous ne vous souvenez plus du numéro du contact.';
        }
        modify("Salesperson Code")
        {
            ToolTipML = ENU = 'Specifies the code of the salesperson who normally handles this contact.', FRA = 'Spécifie le code du vendeur qui s''occupe habituellement de ce contact.';
        }
        modify("Salutation Code")
        {
            ToolTipML = ENU = 'Specifies the salutation code that will be used when you interact with the contact. The salutation code is only used in Word documents. To see a list of the salutation codes already defined, click the field.', FRA = 'Spécifie le code appellation utilisé pour interagir avec le contact. Le code appellation est uniquement utilisé dans les documents Word. Pour visualiser la liste des codes appellation, cliquez sur le champ.';
        }
        modify("Organizational Level Code")
        {
            ToolTipML = ENU = 'Specifies the organizational code for the contact, for example, top management. This field is valid for persons only.', FRA = 'Spécifie le code niveau hiérarchique du contact, par exemple Direction. Ce champ ne s''applique qu''aux personnes.';
        }
        //BC Upgrade Priya>>
        modify(LastDateTimeModified) //Changed name of field from Last Date Modified to LastDateTimeModified.
        {
            ToolTipML = ENU = 'Specifies the date when the contact card was last modified. This field is not editable.', FRA = 'Spécifie la date de la dernière modification de la fiche contact. Ce champ n''est pas modifiable.';
        } //BC Upgrade Priya<<
        modify("Date of Last Interaction")
        {
            ToolTipML = ENU = 'Specifies the date of the last interaction involving the contact, for example, a received or sent mail, e-mail, or phone call. This field is not editable.', FRA = 'Spécifie la date de la dernière interaction impliquant le contact, consistant par exemple à envoyer ou recevoir du courrier, un e-mail ou un appel téléphonique. Ce champ n''est pas modifiable.';
        }
        modify("Last Date Attempted")
        {
            ToolTipML = ENU = 'Specifies the date when the contact was last contacted, for example, when you tried to call the contact, with or without success. This field is not editable.', FRA = 'Spécifie la date à laquelle le contact a été contacté pour la dernière fois. Il peut s''agir par exemple de la date de votre dernier appel, accompagnée d''une mention indiquant si l''appel a abouti. Ce champ n''est pas modifiable.';
        }
        //BC Upgrade Priya>>
        modify("Next Task Date")  //Changed name of field from Next To-do Date to Next Task Date.
        {
            ToolTipML = ENU = 'Specifies the date of the next to-do involving the contact.', FRA = 'Spécifie la date de la prochaine action impliquant le contact.';
        } //BC Upgrade Priya<<
        modify("Exclude from Segment")
        {
            ToolTipML = ENU = 'Specifies if the contact should be excluded from segments:', FRA = 'Indique si le contact doit être exclu des segments :';
        }
        modify(Communication)
        {
            CaptionML = ENU = 'Communication', FRA = 'Communication';
        }
        modify(Control37)
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
        }
        modify(Address)
        {
            ToolTipML = ENU = 'Specifies the contact''s address.', FRA = 'Spécifie l''adresse du contact.';
        }
        modify("Address 2")
        {
            ToolTipML = ENU = 'Specifies another line of the contact''s address.', FRA = 'Spécifie une autre ligne de l''adresse du contact.';
        }
        modify("Post Code")
        {
            ToolTipML = ENU = 'Specifies the post code for the contact.', FRA = 'Spécifie le code postal pour le contact.';
        }
        modify(City)
        {
            ToolTipML = ENU = 'Specifies the city where the contact is located.', FRA = 'Spécifie la ville où se trouve le contact.';
        }
        modify("Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region code for the contact.', FRA = 'Spécifie le code pays/la région du contact.';
        }
        modify(ShowMap)
        {
            ToolTipML = ENU = 'Specifies the contact''s address on your preferred map website.', FRA = 'Spécifie l''adresse du contact sur votre site Web de mappage par défaut.';
        }
        modify(ContactDetails)
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
        }
        modify("Phone No.")
        {
            ToolTipML = ENU = 'Specifies the contact''s phone number.', FRA = 'Spécifie le numéro de téléphone du contact.';
        }
        modify("Mobile Phone No.")
        {
            ToolTipML = ENU = 'Specifies the contact''s mobile telephone number.', FRA = 'Spécifie le numéro de téléphone mobile du contact.';
        }
        modify("E-Mail")
        {
            ToolTipML = ENU = 'Specifies the email address of the contact.', FRA = 'Spécifie l''adresse électronique du contact.';
        }
        modify("Fax No.")
        {
            ToolTipML = ENU = 'Specifies the contact''s fax number.', FRA = 'Spécifie le numéro de télécopie du contact.';
        }
        modify("Home Page")
        {
            ToolTipML = ENU = 'Specifies the contact''s home page address. You can enter a maximum of 80 characters, both numbers and letters.', FRA = 'Spécifie l''adresse de la page d''accueil du contact. Vous pouvez saisir un maximum de 80 caractères (chiffres et lettres).';
        }
        modify("Correspondence Type")
        {
            ToolTipML = ENU = 'Specifies the type of correspondence that is preferred for this interaction. There are three options:', FRA = 'Spécifie le type de correspondance favori pour cette interaction. Trois options sont disponibles :';
        }
        modify("Language Code")
        {
            ToolTipML = ENU = 'Specifies the language code for the contact.', FRA = 'Spécifie le code de langue pour le contact.';
        }
        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade', FRA = 'International';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency code for the contact.', FRA = 'Spécifie le code de devise pour le contact.';
        }
        modify("Territory Code")
        {
            ToolTipML = ENU = 'Specifies the territory code for the contact.', FRA = 'Spécifie le code de territoire pour le contact.';
        }
        modify("VAT Registration No.")
        {
            ToolTipML = ENU = 'Specifies the contact''s VAT registration number. This field is valid for companies only.', FRA = 'Spécifie le numéro d''identification intra-communautaire du contact. Ce champ ne s''applique qu''aux entreprises.';
        }
        modify("Profile Questionnaire")
        {
            CaptionML = ENU = 'Profile Questionnaire', FRA = 'Questionnaire profil';
        }
        //BC Upgrade Priya>>
        //addafter("Next To-do Date")
        //{
        //    field("Job Title";"Job Title")
        //    {
        //        Description = 'DITW17.10.05 DIT-770 ';
        //    }
        //} //BC Upgrade Priya<<
        // BC Upgrade NANDIS03 - Blocked FR fields >>
        // addafter("Exclude from Segment")
        // {
        //     field("Trade Register"; Rec."Trade Register")
        //     {
        //         Enabled = "Trade RegisterEnable";
        //         ToolTipML = ENU = 'Contains the contact''s RCS number.',
        //                     FRA = 'Contient le numéro RCS du contact.';
        //         Visible = FRLocAction;
        //     }
        //     field("APE Code"; Rec."APE Code")
        //     {
        //         Enabled = "APE CodeEnable";
        //         ToolTipML = ENU = 'Contains the APE code for the contact.',
        //                     FRA = 'Contient le code APE du contact.';
        //         Visible = FRLocAction;
        //     }
        //     field("Legal Form"; Rec."Legal Form")
        //     {
        //         Enabled = "Legal FormEnable";
        //         ToolTipML = ENU = 'Contains the legal form for the contact, for example, SA or SARL.',
        //                     FRA = 'Contient la forme juridique du contact, par exemple SA ou SARL.';
        //         Visible = FRLocAction;
        //     }
        //     field("Stock Capital"; Rec."Stock Capital")
        //     {
        //         Enabled = "Stock CapitalEnable";
        //         ToolTipML = ENU = 'Contains the stock capital for the contact.',
        //                     FRA = 'Contient le capital social du contact.';
        //         Visible = FRLocAction;
        //     }
        // }
        // BC Upgrade NANDIS03 - Blocked FR fields <<
        //BC Upgrade Priya>> Drink IT
        //addafter("Foreign Trade")
        //{
        //    group(Contract)
        //    {
        //        CaptionML = ENU='Contract',
        //                    FRA='Contrat';
        //        field("Serv. Contract Acc. Gr. Code";Serv. Contract Acc. Gr. Code")
        //        {
        //        }
        //    }
        //}//BC Upgrade Priya<<
    }
    actions
    {
        modify("C&ontact")
        {
            CaptionML = ENU = 'C&ontact', FRA = 'Con&tact';
        }
        modify("Comp&any")
        {
            CaptionML = ENU = 'Comp&any', FRA = 'So&ciété';
        }
        modify("Business Relations")
        {
            CaptionML = ENU = 'Business Relations', FRA = 'Relations d''affaires';
            ToolTipML = ENU = 'View or edit the contact''s business relations, such as customers, vendors, banks, lawyers, consultants, competitors, and so on.', FRA = 'Affichez ou modifiez les relations commerciales du contact, telles que les clients, fournisseurs, banques, avocats, consultants, concurrents, etc.';
        }
        modify("Industry Groups")
        {
            CaptionML = ENU = 'Industry Groups', FRA = 'Secteurs d''activité';
            ToolTipML = ENU = 'View or edit the industry groups, such as Retail or Automobile, that the contact belongs to.', FRA = 'Affichez ou modifiez les groupes de secteur, tels que le commerce de détail, l''automobile, auxquels le contact appartient.';
        }
        modify("Web Sources")
        {
            CaptionML = ENU = 'Web Sources', FRA = 'Recherche Web';
            ToolTipML = ENU = 'View a list of the web sites with information about the contact.', FRA = 'Affichez une liste des sites Web avec des informations sur le contact.';
        }
        modify("P&erson")
        {
            CaptionML = ENU = 'P&erson', FRA = '&Personne';
        }
        modify("Job Responsibilities")
        {
            CaptionML = ENU = 'Job Responsibilities', FRA = 'Responsabilités';
            ToolTipML = ENU = 'View or edit the contact''s job responsibilities.', FRA = 'Affichez ou modifiez les responsabilités du poste du contact.';
        }
        modify("Pro&files")
        {
            CaptionML = ENU = 'Pro&files', FRA = 'Pro&fil';
            ToolTipML = ENU = 'Open the Profile Questionnaires window.', FRA = 'Ouvrez la fenêtre Questionnaires profil.';
        }
        modify("&Picture")
        {
            CaptionML = ENU = '&Picture', FRA = 'Imag&e';
            ToolTipML = ENU = 'View or add a picture of the contact person, or for example, the company''s logo.', FRA = 'Affichez ou ajoutez une image de la personne à contacter ou, par exemple, le logo de la société.';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
            ToolTipML = ENU = 'View or add comments.', FRA = 'Affichez ou ajoutez des commentaires.';
        }
        modify("Alternati&ve Address")
        {
            CaptionML = ENU = 'Alternati&ve Address', FRA = '&Adresse secondaire';
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card', FRA = 'Fiche';
            ToolTipML = ENU = 'View or change detailed information about the contact.', FRA = 'Affichez ou modifiez des informations détaillées concernant le contact.';
        }
        modify("Date Ranges")
        {
            CaptionML = ENU = 'Date Ranges', FRA = 'Plage de dates';
            ToolTipML = ENU = 'Specify date ranges that apply to the contact''s alternate address.', FRA = 'Spécifiez les plages de date qui s''appliquent à l''adresse secondaire du contact.';
        }
        modify(ActionGroupCRM)
        {
            CaptionML = ENU = 'Dynamics CRM', FRA = 'Dynamics CRM';
        }
        modify(CRMGotoContact)
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
            ToolTipML = ENU = 'Open the coupled Dynamics CRM contact.', FRA = 'Ouvrez le contact Dynamics CRM couplé.';
        }
        modify(CRMSynchronizeNow)
        {
            CaptionML = ENU = 'Synchronize Now', FRA = 'Synchroniser maintenant';
            ToolTipML = ENU = 'Send or get updated data to or from Microsoft Dynamics CRM.', FRA = 'Envoyez/recevez des données mises à jour à/de Microsoft Dynamics CRM.';
        }
        modify(Coupling)
        {
            CaptionML = ENU = 'Coupling', FRA = 'Couplage';
            ToolTipML = ENU = 'Create, change, or delete a coupling between the Microsoft Dynamics NAV record and a Microsoft Dynamics CRM record.', FRA = 'Créez, modifiez ou supprimez un couplage entre l''enregistrement Microsoft Dynamics NAV et un enregistrement Microsoft Dynamics CRM.';
        }
        modify(ManageCRMCoupling)
        {
            CaptionML = ENU = 'Set Up Coupling', FRA = 'Configurer le couplage';
            ToolTipML = ENU = 'Create or modify the coupling to a Microsoft Dynamics CRM contact.', FRA = 'Créez ou modifiez le couplage avec un contact Microsoft Dynamics CRM.';
        }
        modify(DeleteCRMCoupling)
        {
            CaptionML = ENU = 'Delete Coupling', FRA = 'Supprimer le couplage';
            ToolTipML = ENU = 'Delete the coupling to a Microsoft Dynamics CRM contact.', FRA = 'Supprimez le couplage avec un contact Microsoft Dynamics CRM.';
        }
        modify("Related Information")
        {
            CaptionML = ENU = 'Related Information', FRA = 'Informations connexes';
        }
        modify("Relate&d Contacts")
        {
            CaptionML = ENU = 'Relate&d Contacts', FRA = 'Con&tacts liés';
            ToolTipML = ENU = 'View a list of all contacts.', FRA = 'Affichez une liste de tous les contacts.';
        }
        modify("Segmen&ts")
        {
            CaptionML = ENU = 'Segmen&ts', FRA = 'Segme&nts';
            ToolTipML = ENU = 'View the segments that are related to the contact.', FRA = 'Affichez les segments correspondant au contact.';
        }
        modify("Mailing &Groups")
        {
            CaptionML = ENU = 'Mailing &Groups', FRA = '&Groupes de distribution';
            ToolTipML = ENU = 'View or edit the mailing groups that the contact is assigned to, for example, for sending price lists or Christmas cards.', FRA = 'Affichez ou modifiez les groupes de distribution auxquels le contact est affecté pour envoyer, par exemple, des listes de prix ou des cartes de voux.';
        }
        //BC Upgrade Priya>>
        //modify("C&ustomer/Vendor/Bank Acc.") //4 actions created seperatly in base page for C&ustomer,Vendor,Bank Acc. and Employee.
        //{
        //    CaptionML = ENU = 'C&ustomer/Vendor/Bank Acc.', FRA = 'Client/Fournisseur/&Banque';
        //    ToolTipML = ENU = 'View the related customer, vendor, or bank account that is associated with the current record.', FRA = 'Affichez le compte client, fournisseur ou bancaire associé à l''enregistrement actif.';
        //} BC Upgrade Priya<<
        modify("Online Map")
        {
            CaptionML = ENU = 'Online Map', FRA = 'Online Map';
            ToolTipML = ENU = 'View the address on an online map.', FRA = 'Affichez l''adresse sur une carte en ligne.';
        }
        modify("Office Customer/Vendor")
        {
            CaptionML = ENU = 'Customer/Vendor', FRA = 'Client/Fournisseur';
            ToolTipML = ENU = 'View the related customer, vendor, or bank account.', FRA = 'Affichez le compte client, fournisseur ou bancaire associé.';
        }
        modify(Tasks)
        {
            CaptionML = ENU = 'Tasks', FRA = 'Tâches';
        }
        //BC Upgrade Priya>>
        //modify("T&o-dos") //Not found in base page also no HEI versioning.
        //{
        //    CaptionML = ENU = 'T&o-dos', FRA = 'Act&ions';
        //} //BC Upgrade Priya<<
        modify("Oppo&rtunities")
        {
            CaptionML = ENU = 'Oppo&rtunities', FRA = 'Oppo&rtunités';
            ToolTipML = ENU = 'View the sales opportunities that are handled by salespeople for the contact. Opportunities must involve a contact and can be linked to campaigns.', FRA = 'Affichez les opportunités de vente gérées par les vendeurs pour le contact. Les opportunités doivent impliquer un contact et peuvent être liées aux campagnes.';
        }
        modify("Postponed &Interactions")
        {
            CaptionML = ENU = 'Postponed &Interactions', FRA = '&Interactions reportées';
            ToolTipML = ENU = 'View postponed interactions for the contact.', FRA = 'Affichez les interactions reportées pour le contact.';
        }
        modify(Documents)
        {
            CaptionML = ENU = 'Documents', FRA = 'Documents';
        }
        modify(SalesQuotes)
        {
            CaptionML = ENU = 'Sales &Quotes', FRA = '&Devis';
            ToolTipML = ENU = 'View sales quotes that exist for the contact.', FRA = 'Affichez les devis qui existent pour le contact.';
        }
        modify(History)
        {
            CaptionML = ENU = 'History', FRA = 'Historique';
        }
        modify("Interaction Log E&ntries")
        {
            CaptionML = ENU = 'Interaction Log E&ntries', FRA = 'Écritures jour&nal interaction';
            ToolTipML = ENU = 'View a list of the interactions that you have logged, for example, when you create an interaction, print a cover sheet, a sales order, and so on.', FRA = 'Visualisez la liste des interactions que vous enregistrez lorsque, par exemple, vous créez une interaction, imprimez un bordereau d''envoi, une commande vente, etc.';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
            ToolTipML = ENU = 'View statistical information, such as the value of posted entries, for the record.', FRA = 'Affichez les informations statistiques telles que la valeur des écritures validées pour l''enregistrement.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Launch &Web Source")
        {
            CaptionML = ENU = 'Launch &Web Source', FRA = 'Lancer &recherche Web';
            ToolTipML = ENU = 'Search for information about the contact online.', FRA = 'Recherchez les informations concernant le contact en ligne.';
        }
        modify("Print Cover &Sheet")
        {
            CaptionML = ENU = 'Print Cover &Sheet', FRA = '&Imprimer bordereau d''envoi';
            ToolTipML = ENU = 'View cover sheets to send to your contact.', FRA = 'Affichez les bordereaux d''envoi à envoyer à votre contact.';
        }
        modify("Create as")
        {
            CaptionML = ENU = 'Create as', FRA = 'Créer comme';
        }
        modify(CreateCustomer)
        {
            CaptionML = ENU = 'Customer', FRA = 'Client';
            ToolTipML = ENU = 'Create the contact as a customer.', FRA = 'Créez le contact en tant que client.';
        }
        modify(CreateVendor)
        {
            CaptionML = ENU = 'Vendor', FRA = 'Fournisseur';
            ToolTipML = ENU = 'Create the contact as a vendor.', FRA = 'Créez le contact en tant que fournisseur.';
        }
        modify(CreateBank)
        {
            CaptionML = ENU = 'Bank', FRA = 'Banque';
            ToolTipML = ENU = 'Create the contact as a bank.', FRA = 'Créez le contact en tant que banque.';
        }
        modify("Link with existing")
        {
            CaptionML = ENU = 'Link with existing', FRA = 'Lier avec existant';
        }
        modify(Customer)
        {
            CaptionML = ENU = 'Customer', FRA = 'Client';
            ToolTipML = ENU = 'Link the contact to an existing customer.', FRA = 'Associez le contact à un client existant.';
        }
        modify(Vendor)
        {
            CaptionML = ENU = 'Vendor', FRA = 'Fournisseur';
            ToolTipML = ENU = 'Link the contact to an existing vendor.', FRA = 'Associez le contact à un fournisseur existant.';
        }
        modify(Bank)
        {
            CaptionML = ENU = 'Bank', FRA = 'Banque';
            ToolTipML = ENU = 'Link the contact to an existing bank.', FRA = 'Associez le contact à une banque existante.';
        }
        modify("Apply Template")
        {
            CaptionML = ENU = 'Apply Template', FRA = 'Appliquer modèle';
            ToolTipML = ENU = 'Select a defined template to quickly create a new record.', FRA = 'Sélectionnez un modèle défini pour créer rapidement un enregistrement.';
        }
        modify(CreateAsCustomer)
        {
            CaptionML = ENU = 'Create as Customer', FRA = 'Créer en tant que client';
            ToolTipML = ENU = 'Create a new customer based on this contact.', FRA = 'Créez un client en fonction de ce contact.';
        }
        modify(CreateAsVendor)
        {
            CaptionML = ENU = 'Create as Vendor', FRA = 'Créer en tant que fournisseur';
            ToolTipML = ENU = 'Create a new vendor based on this contact.', FRA = 'Créez un fournisseur en fonction de ce contact.';
        }
        modify("Create &Interaction")
        {
            CaptionML = ENU = 'Create &Interact', FRA = 'Créer &interact.';
            ToolTipML = ENU = 'Create an interaction with a specified contact.', FRA = 'Créez une interaction avec un contact spécifié.';
        }
        modify("Create Opportunity")
        {
            CaptionML = ENU = 'Create Opportunity', FRA = 'Créer opportunité';
            ToolTipML = ENU = 'Register a sales opportunity for the contact.', FRA = 'Enregistrez une opportunité de vente pour le contact.';
        }
        modify(ContactCoverSheet)
        {
            CaptionML = ENU = 'Contact Cover Sheet', FRA = 'Bordereau d''envoi contact';
            ToolTipML = ENU = 'Print or save cover sheets to send to one or more of your contacts.', FRA = 'Imprimez ou enregistrez les bordereaux d''envoi à envoyer à un ou plusieurs de vos contacts.';
        }
    }

    //BC Upgrade Priya>>  In Navision this code was added on OnInit trigger.
    trigger OnOpenPage()
    begin
        //HEI.01>>
        FRLocAction := false;
        CompanyInfo.Get();
        if CompanyInfo."Enable French Localization FND" then begin
            "Stock CapitalEnable" := true;
            "Legal FormEnable" := true;
            "APE CodeEnable" := true;
            "Trade RegisterEnable" := true;
            FRLocAction := true;
        end;
        //HEI.01<< 
    end;
    //BC Upgrade Priya>> In Navision this code was added on OnInit trigger.

    //Unsupported feature: PropertyModification on "ShowMapLbl(Variable 1010)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ShowMapLbl : ENU=Show Map;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ShowMapLbl : ENU=Show Map;FRA=Afficher la carte;
    //Variable type has not been exported.

    var
        CompanyInfo: Record "Company Information";

        "APE CodeEnable": Boolean;
        FRLocAction: Boolean;

        "Legal FormEnable": Boolean;

        "Stock CapitalEnable": Boolean;

        "Trade RegisterEnable": Boolean;


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OrganizationalLevelCodeEnable := true;
    CompanyNameEnable := true;
    VATRegistrationNoEnable := true;
    CurrencyCodeEnable := true;
    ActionVisible := CURRENTCLIENTTYPE = CLIENTTYPE::Windows;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //HEI.01>>
    FRLocAction := false;
    CompanyInfo.GET;
    if CompanyInfo."Enable French Localization" then
      begin
        "Stock CapitalEnable" := true;
        "Legal FormEnable" := true;
        "APE CodeEnable" := true;
        "Trade RegisterEnable" := true;
        FRLocAction := true;
      end;
    //HEI.01<<
    #1..5
    */
    //end;


    //Unsupported feature: CodeModification on "EnableFields(PROCEDURE 1)". Please convert manually.
    //BC Upgrade Priya>> Check this procedure's event sub in Cod53499.
    //procedure EnableFields();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CompanyGroupEnabled := Type = Type::Company;
    PersonGroupEnabled := Type = Type::Person;
    CurrencyCodeEnable := Type = Type::Company;
    VATRegistrationNoEnable := Type = Type::Company;
    CompanyNameEnable := Type = Type::Person;
    OrganizationalLevelCodeEnable := Type = Type::Person;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    //HEI.01>>
    if CompanyInfo."Enable French Localization" then
      begin
        "Trade RegisterEnable" := Type = Type::Company;
        "APE CodeEnable" := Type = Type::Company;
        "Legal FormEnable" := Type = Type::Company;
        "Stock CapitalEnable" := Type = Type::Company;
      end;
    //HEI.01<<
    */
    //end;
    //BC Upgrade Priya<< Check this procedure event sub in Cod53499.
    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

