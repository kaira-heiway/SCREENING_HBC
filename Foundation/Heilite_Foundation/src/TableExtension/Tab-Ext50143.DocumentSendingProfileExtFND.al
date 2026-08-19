tableextension 50143 DocumentSendingProfileExtFND extends "Document Sending Profile"
{
    //     HEI.01 FDD-LB-GAPLOG04 IBM NASTAA02 25.07.2018 # Order Confirmation Almaza, Proforma Invoice and Export Invoice
    //   # New Fields added: 50000 - Std Text Code Proforma Inv F
    //                       50001 - Std Text Code Export Inv F
    //                       50002 - Std Text Code Proforma Inv H
    //                       50003 - Std Text Code Export Inv H
    //                       50004 - Bank


    fields
    {
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Description';
        }
        modify(Printer)
        {
            CaptionML = ENU = 'Printer', FRA = 'Imprimante';
            OptionCaptionML = ENU = 'No,Yes (Prompt for Settings),Yes (Use Default Settings)', FRA = 'Non,Oui (Afficher une invite pour le réglage des paramètres),Oui (Utiliser les paramètres par défaut)';
        }
        modify("E-Mail")
        {
            CaptionML = ENU = 'Email', FRA = 'Adresse e-mail';
            OptionCaptionML = ENU = 'No,Yes (Prompt for Settings),Yes (Use Default Settings)', FRA = 'Non,Oui (Afficher une invite pour le réglage des paramètres),Oui (Utiliser les paramètres par défaut)';
        }
        modify("E-Mail Attachment")
        {
            CaptionML = ENU = 'Email Attachment', FRA = 'Pièce jointe d''e-mail';
            // OptionCaptionML = ENU = 'PDF,Electronic Document,PDF & Electronic Document', FRA = 'PDF,Document électronique,PDF et document électronique';
        }
        modify("E-Mail Format")
        {
            CaptionML = ENU = 'Email Format', FRA = 'Format e-mail';
        }
        modify(Disk)
        {
            CaptionML = ENU = 'Disk', FRA = 'Disque';
            // OptionCaptionML = ENU = 'No,PDF,Electronic Document,PDF & Electronic Document', FRA = 'Aucun,PDF,Document électronique,PDF et document électronique';
        }
        modify("Disk Format")
        {
            CaptionML = ENU = 'Disk Format', FRA = 'Format disque';
        }
        modify("Electronic Document")
        {
            CaptionML = ENU = 'Electronic Document', FRA = 'Document électronique';
            // OptionCaptionML = ENU = 'No,Through Document Exchange Service', FRA = 'Aucun,Via le service d''échange de documents';
        }
        modify("Electronic Format")
        {
            CaptionML = ENU = 'Electronic Format', FRA = 'Format électronique';
        }
        modify(Default)
        {
            CaptionML = ENU = 'Default', FRA = 'Par défaut';
        }
        modify("Send To")
        {
            CaptionML = ENU = 'Send To', FRA = 'Envoyer à';
            // OptionCaptionML = ENU = 'Disk,Email,Print,Electronic Document', FRA = 'Disque,E-mail,Impression,Document électronique';
        }
        modify(Usage)
        {
            CaptionML = ENU = 'Usage', FRA = 'Utilisation';
            // OptionCaptionML = ENU = 'Sales Invoice,Sales Credit Memo,,Service Invoice,Service Credit Memo,Job Quote', FRA = 'Facture vente,Avoir vente,Facture service,,Avoir service,Devis projet';
        }
        modify("One Related Party Selected")
        {
            CaptionML = ENU = 'One Related Party Selected', FRA = 'Une partie associée est sélectionnée';
        }
        field(50000; "Std Text CodeProformaInv F FND"; Code[20])
        {
            Caption = 'Std Text Code Proforma Inv Footer';
            Description = 'HEI.01';
            TableRelation = "Standard Text";
        }
        field(50001; "Std Text Code Export Inv F FND"; Code[20])
        {
            Caption = 'Std Text Code Export Inv Footer';
            Description = 'HEI.01';
            TableRelation = "Standard Text";
        }
        field(50002; "Std Text CodeProformaInv H FND"; Code[20])
        {
            Caption = 'Std Text Code Proforma Inv Header';
            Description = 'HEI.01';
            TableRelation = "Standard Text";
        }
        field(50003; "Std Text Code Export Inv H FND"; Code[20])
        {
            Caption = 'Std Text Code Export Inv Header';
            Description = 'HEI.01';
            TableRelation = "Standard Text";
        }
        field(50004; "Bank FND"; Code[20])
        {
            Caption = 'Bank';
            Description = 'HEI.01';
            TableRelation = "Bank Account";
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "DefaultCodeTxt(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DefaultCodeTxt : @@@=Translate as we translate default term in local languages;ENU=DEFAULT;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DefaultCodeTxt : @@@=Translate as we translate default term in local languages;ENU=DEFAULT;FRA=PAR DÉFAUT;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "DefaultDescriptionTxt(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DefaultDescriptionTxt : ENU=Default rule used if no other provided;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DefaultDescriptionTxt : ENU=Default rule used if no other provided;FRA=Règle par déf. utilisée si aucune règle définie;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "RecordAsTextFormatterTxt(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //RecordAsTextFormatterTxt : ENU="%1 ; %2";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RecordAsTextFormatterTxt : ENU="%1 ; %2";FRA="%1 ; %2";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "FieldCaptionContentFormatterTxt(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //FieldCaptionContentFormatterTxt : @@@="%1=Field Caption (e.g. Email), %2=Field Content (e.g. PDF) so for example 'Email (PDF)'";ENU=%1 (%2);
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //FieldCaptionContentFormatterTxt : @@@="%1=Field Caption (e.g. Email), %2=Field Content (e.g. PDF) so for example 'Email (PDF)'";ENU=%1 (%2);FRA=%1 (%2);
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CannotDeleteDefaultRuleErr(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CannotDeleteDefaultRuleErr : ENU=You cannot delete the default rule. Assign other rule to be default first.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CannotDeleteDefaultRuleErr : ENU=You cannot delete the default rule. Assign other rule to be default first.;FRA=Vous ne pouvez pas supprimer la règle par défaut. Définissez d'abord une autre règle par défaut.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CannotRemoveDefaultRuleErr(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CannotRemoveDefaultRuleErr : ENU=There must be one default rule in the system. To remove the default property from this rule, assign default to another rule.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CannotRemoveDefaultRuleErr : ENU=There must be one default rule in the system. To remove the default property from this rule, assign default to another rule.;FRA=Le système doit contenir une règle par défaut. Pour que cette règle ne soit plus la règle par défaut, définissez une autre règle comme règle par défaut.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "UpdateAssCustomerQst(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //UpdateAssCustomerQst : ENU=If you delete document sending profile %1, it will also be deleted on customer cards that use the profile.\\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //UpdateAssCustomerQst : ENU=If you delete document sending profile %1, it will also be deleted on customer cards that use the profile.\\Do you want to continue?;FRA=Si vous supprimez le profil d'envoi de documents %1, ce dernier sera également supprimé des fiches clients qui utilisent le profil.\\Souhaitez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CannotDeleteErr(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CannotDeleteErr : ENU=Cannot delete the document sending profile.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CannotDeleteErr : ENU=Cannot delete the document sending profile.;FRA=Impossible de supprimer le profil d'envoi de documents.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CannotSendMultipleSalesDocsErr(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CannotSendMultipleSalesDocsErr : ENU=You can only send one electronic sales document at a time.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CannotSendMultipleSalesDocsErr : ENU=You can only send one electronic sales document at a time.;FRA=Vous ne pouvez envoyer qu'un seul document vente électronique à la fois.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "InvoicesTxt(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //InvoicesTxt : ENU=Invoices;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //InvoicesTxt : ENU=Invoices;FRA=Factures;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ShipmentsTxt(Variable 1010)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ShipmentsTxt : ENU=Shipments;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ShipmentsTxt : ENU=Shipments;FRA=Livraisons;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CreditMemosTxt(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CreditMemosTxt : ENU=Credit Memos;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CreditMemosTxt : ENU=Credit Memos;FRA=Avoirs;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ReceiptsTxt(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ReceiptsTxt : ENU=Receipts;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ReceiptsTxt : ENU=Receipts;FRA=Réceptions;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "JobQuotesTxt(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //JobQuotesTxt : ENU=Job Quotes;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //JobQuotesTxt : ENU=Job Quotes;FRA=Devis projet;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "PurchaseOrdersTxt(Variable 1014)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //PurchaseOrdersTxt : ENU=Purchase Orders;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PurchaseOrdersTxt : ENU=Purchase Orders;FRA=Commandes achat;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ProfileSelectionQst(Variable 1015)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ProfileSelectionQst : @@@=Translation should contain comma separators between variants as ENU value does. No other commas should be there.;ENU=Confirm the first profile and use it for all selected documents.,Confirm the profile for each document.,Use the default profile for all selected documents without confimation.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ProfileSelectionQst : @@@=Translation should contain comma separators between variants as ENU value does. No other commas should be there.;ENU=Confirm the first profile and use it for all selected documents.,Confirm the profile for each document.,Use the default profile for all selected documents without confimation.;FRA=Confirmez le premier profil et utilisez-le pour tous les documents sélectionnés.,Confirmez le profil pour chaque document.,Utilisez le profil par défaut pour tous les documents sélectionnés sans confirmation.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CustomerProfileSelectionInstrTxt(Variable 1016)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CustomerProfileSelectionInstrTxt : ENU="Customers on the selected documents use different document sending profiles. Choose one of the following options: ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CustomerProfileSelectionInstrTxt : ENU="Customers on the selected documents use different document sending profiles. Choose one of the following options: ";FRA="Les clients sur les documents sélectionnés utilisent différents profils d'envoi de document. Choisissez l'une des options suivantes : ";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "VendorProfileSelectionInstrTxt(Variable 1017)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //VendorProfileSelectionInstrTxt : ENU="Vendors on the selected documents use different document sending profiles. Choose one of the following options: ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //VendorProfileSelectionInstrTxt : ENU="Vendors on the selected documents use different document sending profiles. Choose one of the following options: ";FRA="Les fournisseurs sur les documents sélectionnés utilisent différents profils d'envoi de document. Choisissez l'une des options suivantes : ";
    //Variable type has not been exported.
}

