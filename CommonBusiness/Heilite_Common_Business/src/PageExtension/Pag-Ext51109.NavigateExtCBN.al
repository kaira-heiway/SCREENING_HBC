pageextension 51109 NavigateExtCBN extends Navigate
{
    // version NAVW110.0,FINXL7.00.001,QXL9.00.001,DITW110.00.08,HEI.04
    // HEI.01 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Code added in ShowRecords, FindRecords
    // HEI.03 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # Code added in functions "ShowRecords" and "FindRecords"
    // HEI.04 CHG2224401 HB3624 YADAVM09 06.02.2024 Health and Security Levy Tax
    //  #Code Added in function #Showrecords
    //                          #FindRecord
    //BC UPGRADE PATHAA02-260925

    // BC Upgrade MISHRS14 >>
    // Blocked OptionCaptionML line as modify(ContactType) is enum so OptionCaptionML not required.
    // BC Upgrade MISHRS14 <<

    layout
    {
        modify(Document)
        {
            CaptionML = ENU = 'Document', FRA = 'Document';
        }
        modify(DocNoFilter)
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
            ToolTipML = ENU = 'Specifies the document number of an entry that is used to find all documents that have the same document number. You can enter a new document number in this field to search for another set of documents.', FRA = 'Spécifie le numéro de document d''une écriture utilisée pour rechercher tous les documents qui ont le même numéro. Vous pouvez saisir un nouveau numéro de document dans ce champ pour rechercher un autre ensemble de documents.';
        }
        modify(PostingDateFilter)
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
            ToolTipML = ENU = 'Specifies the posting date for the document that you are searching for. You can insert a filter if you want to search for a certain interval of dates.', FRA = 'Spécifie la date comptabilisation pour le document que vous recherchez. Vous pouvez insérer un filtre si vous voulez rechercher un certain intervalle de dates.';
        }
        modify("Business Contact")
        {
            CaptionML = ENU = 'Business Contact', FRA = 'Contact professionnel';
        }
        modify(ContactType)
        {
            CaptionML = ENU = 'Business Contact Type', FRA = 'Type tiers';
            ToolTipML = ENU = 'Specifies if you want to search for customers, vendors, or bank accounts. Your choice determines the list that you can access in the Business Contact No. field.', FRA = 'Spécifie si vous voulez rechercher des clients, des fournisseurs ou des comptes bancaires. Votre choix détermine la liste à laquelle vous pouvez accéder dans le champ Identifiant tiers.';

            // BC Upgrade MISHRS14 >>
            // Blocked below line as modify(ContactType) is enum so OptionCaptionML not required.
            //OptionCaptionML = ENU = ' ,Vendor,Customer', FRA = ' ,Fournisseur,Client';
            // BC Upgrade MISHRS14 <<

        }
        modify(ContactNo)
        {
            CaptionML = ENU = 'Business Contact No.', FRA = 'Identifiant tiers';
            ToolTipML = ENU = 'Specifies the number of the customer, vendor, or bank account that you want to find entries for.', FRA = 'Spécifie le numéro du client, du fournisseur ou du compte bancaire pour lequel vous voulez trouver des écritures.';
        }
        modify(ExtDocNo)
        {
            CaptionML = ENU = 'External Document No.', FRA = 'N° doc. externe';
            ToolTipML = ENU = 'Specifies the document number assigned by the vendor.', FRA = 'Spécifie le numéro de document attribué par le fournisseur.';
        }
        modify("Item Reference")
        {
            CaptionML = ENU = 'Item Reference', FRA = 'Référence article';
        }
        modify(SerialNoFilter)
        {
            CaptionML = ENU = 'Serial No.', FRA = 'N° de série';
            ToolTipML = ENU = 'Specifies the posting date of the document when you have opened the Navigate window from the document. The entry''s document number is shown in the Document No. field.', FRA = 'Spécifie la date comptabilisation du document lorsque vous avez ouvert la fenêtre Naviguer depuis le document. Le numéro de document de l''écriture apparaît dans le champ N° document.';
            //Enabled = SerialNoEnable; //BC UPGRADE PATHAA02-DIT
        }
        modify(LotNoFilter)
        {
            CaptionML = ENU = 'Lot No.', FRA = 'N° lot';
            ToolTipML = ENU = 'Specifies the number that you want to find entries for.', FRA = 'Spécifie le numéro pour lequel vous voulez trouver des écritures.';
        }
        modify(Notification)
        {
            CaptionML = ENU = 'Notification', FRA = 'Notification';

            //Unsupported feature: Change InstructionalTextML on "Notification(Control 25)". Please convert manually.

        }
        modify("Entry No.")
        {
            ToolTipML = ENU = 'Specifies the entry number that is assigned to the entry.', FRA = 'Spécifie le numéro d''écriture qui est affecté à l''écriture.';
        }
        modify("Table ID")
        {
            ToolTipML = ENU = 'Specifies the table that the entry is stored in.', FRA = 'Spécifie la table dans laquelle l''écriture est stockée.';
        }
        modify("Table Name")
        {
            CaptionML = ENU = 'Related Entries', FRA = 'Écritures associées';
            ToolTipML = ENU = 'Specifies the name of the table where the Navigate facility has found entries with the selected document number and/or posting date.', FRA = 'Spécifie le nom de la table dans laquelle la fonction Naviguer a détecté des écritures portant le numéro et/ou la date comptabilisation du document sélectionné.';
        }
        modify("No. of Records")
        {
            CaptionML = ENU = 'No. of Entries', FRA = 'Nbre écritures';
            ToolTipML = ENU = 'Specifies the number of documents that the Navigate facility has found in the table with the selected entries.', FRA = 'Spécifie le nombre de documents trouvés par la fonction Naviguer dans la table et comprenant les écritures sélectionnées.';
        }
        modify(Source)
        {
            CaptionML = ENU = 'Source', FRA = 'Source';
        }
        modify(DocType)
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            ToolTipML = ENU = 'Specifies the type of the selected document. Leave the Document Type field blank if you want to search by posting date. The entry''s document number is shown in the Document No. field.', FRA = 'Spécifie le type du document sélectionné. Ne renseignez pas le champ Type document si vous voulez rechercher par date comptabilisation. Le numéro de document de l''écriture apparaît dans le champ N° document.';
        }
        modify(SourceType)
        {
            CaptionML = ENU = 'Source Type', FRA = 'Type origine';
            ToolTipML = ENU = 'Specifies the source type of the selected document or remains blank if you search by posting date. The entry''s document number is shown in the Document No. field.', FRA = 'Spécifie le type origine du document sélectionné ou est vierge si vous recherchez par date comptabilisation. Le numéro de document de l''écriture apparaît dans le champ N° document.';
        }
        modify(SourceNo)
        {
            CaptionML = ENU = 'Source No.', FRA = 'N° origine';
            ToolTipML = ENU = 'Specifies the source number of the selected document. The entry''s document number is shown in the Document No. field.', FRA = 'Spécifie le numéro origine du document sélectionné. Le numéro de document de l''écriture apparaît dans le champ N° document.';
        }
        modify(SourceName)
        {
            CaptionML = ENU = 'Source Name', FRA = 'Nom origine';
            ToolTipML = ENU = 'Specifies the source name on the selected entry. The entry''s document number is shown in the Document No. field.', FRA = 'Spécifie le nom origine sur l''écriture sélectionnée. Le numéro de document de l''écriture apparaît dans le champ N° document.';
        }
        //BC UPGRADE PATHAA02-DIT>>
        // addafter(LotNoFilter)
        // {
        //     field(SSCCNo; SSCCNoFilter)
        //     {
        //         CaptionML = ENU = 'SSCC No.',
        //                     FRA = 'N° SSCC';

        //         trigger OnLookup(Text: Text): Boolean;
        //         var
        //             SSCCNoInfo: Record "SSCC Ledger Entry";
        //             SSCCNoList: Page "SSCC Tracking List";
        //         begin
        //             // <<DITW15.00.00.38 DDR 25/10/2010 #1139
        //             CLEAR(SSCCNoList);
        //             if SSCCNoList.RUNMODAL = ACTION::LookupOK then begin
        //                 Text := SSCCNoList.GetSelectionFilter;
        //                 exit(true);
        //             end;
        //         end;

        //         trigger OnValidate();
        //         begin
        //             ClearInfo;
        //             SSCCNoFilterOnAfterValidate;
        //             // <<DITW17.10.02 DDR 22/11/2013 DIT-770 #000
        //             FilterSelectionChanged;
        //             // >>DITW17.10.02 DDR DIT-770 #000
        //         end;
        //     }
        //     group("AAD/LRN/ARC Tracking")
        //     {
        //         CaptionML = ENU = 'AAD/LRN/ARC Tracking',
        //                     FRA = 'DAA/LRN/ Traçabilité ARC';
        //         Visible = emcsVisible;
        //         field(AADNo; AADNoFilter)
        //         {
        //             CaptionML = ENU = 'AAD No.',
        //                         FRA = 'N° DAA';

        //             trigger OnLookup(Text: Text): Boolean;
        //             var
        //                 AADTrackingEntryList: Record "AAD Tracking Entry";
        //                 AADTrackingList: Page "AAD Tracking List";
        //             begin
        //                 // <<DITW15.00.00.38 DDR 10/08/2010 #1217
        //                 CLEAR(AADTrackingList);
        //                 if AADTrackingList.RUNMODAL = ACTION::LookupOK then begin
        //                     Text := AADTrackingList.GetSelectionFilter;
        //                     exit(true);
        //                 end;
        //             end;

        //             trigger OnValidate();
        //             begin
        //                 // <<DITW15.00.00.38 DDR 10/08/2010 #1217
        //                 ClearInfo;
        //                 AADNoFilterOnAfterValidate;
        //                 // <<DITW17.10.02 DDR 22/11/2013 DIT-770 #000
        //                 FilterSelectionChanged;
        //                 // >>DITW17.10.02 DDR DIT-770 #000
        //             end;
        //         }
        //         field(LRNNo; LRNNoFilter)
        //         {
        //             CaptionML = ENU = 'LRN No.',
        //                         FRA = 'N° LRN';

        //             trigger OnLookup(Text: Text): Boolean;
        //             var
        //                 AADTrackingEntry: Record "AAD Tracking Entry";
        //                 LATrackingList: Page "LRN-ARC Tracking List";
        //             begin
        //                 // <<DITW15.00.00.38 DDR 10/08/2010 #1217
        //                 CLEAR(LATrackingList);
        //                 //AADTrackingEntry.FILTERGROUP(2);
        //                 AADTrackingEntry.SETFILTER("LRN No.", '<>%1', '');
        //                 //AADTrackingEntry.FILTERGROUP(0);
        //                 LATrackingList.SETTABLEVIEW(AADTrackingEntry);
        //                 if LATrackingList.RUNMODAL = ACTION::LookupOK then begin
        //                     Text := LATrackingList.GetSelectionFilterLRN;
        //                     exit(true);
        //                 end;
        //             end;

        //             trigger OnValidate();
        //             begin
        //                 // <<DITW15.00.00.38 DDR 10/08/2010 #1217
        //                 ClearInfo;
        //                 LRNNoFilterOnAfterValidate;
        //                 // <<DITW17.10.02 DDR 22/11/2013 DIT-770 #000
        //                 FilterSelectionChanged;
        //                 // >>DITW17.10.02 DDR DIT-770 #000
        //             end;
        //         }
        //         field(ARCNo; ARCNoFilter)
        //         {
        //             CaptionML = ENU = 'ARC No.',
        //                         FRA = 'N° ARC';

        //             trigger OnLookup(Text: Text): Boolean;
        //             var
        //                 AADTrackingEntry: Record "AAD Tracking Entry";
        //                 LATrackingList: Page "LRN-ARC Tracking List";
        //             begin
        //                 // <<DITW15.00.00.38 DDR 10/08/2010 - 30/09/2010 #1217
        //                 CLEAR(LATrackingList);
        //                 AADTrackingEntry.FILTERGROUP(2);
        //                 AADTrackingEntry.SETFILTER("ARC No.", '<>%1', '');
        //                 AADTrackingEntry.FILTERGROUP(0);
        //                 LATrackingList.SETTABLEVIEW(AADTrackingEntry);
        //                 if LATrackingList.RUNMODAL = ACTION::LookupOK then begin
        //                     Text := LATrackingList.GetSelectionFilterARC;
        //                     exit(true);
        //                 end;
        //             end;

        //             trigger OnValidate();
        //             begin
        //                 // <<DITW15.00.00.38 DDR 10/08/2010 #1217
        //                 ClearInfo;
        //                 ARCNoFilterOnAfterValidate;
        //                 // <<DITW17.10.02 DDR 22/11/2013 DIT-770 #000
        //                 FilterSelectionChanged;
        //                 // >>DITW17.10.02 DDR DIT-770 #000
        //             end;
        //         }
        //     }
        // }
        //BC UPGRADE PATHAA02-DIT<<
    }
    actions
    {
        modify(Process)
        {
            CaptionML = ENU = 'Process', FRA = 'Processus';
        }
        modify(Show)
        {
            CaptionML = ENU = '&Show Related Entries', FRA = '&Afficher écritures associées';
            ToolTipML = ENU = 'Show the related entries of the type that you have chosen.', FRA = 'Affichez les écritures associées du type que vous avez choisi.';
        }
        modify(Find)
        {
            CaptionML = ENU = 'Fi&nd', FRA = '&Rechercher';
            ToolTipML = ENU = 'Apply a filter to search on this page.', FRA = 'Appliquez un filtre pour la recherche sur cette page.';
        }
        modify(Print)
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
            ToolTipML = ENU = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.', FRA = 'Préparez-vous à imprimer le document. Une fenêtre de sélection de l''état pour le document s''ouvre et vous permet d''indiquer les éléments à imprimer.';
        }
        modify(FindGroup)
        {
            CaptionML = ENU = 'Find by', FRA = 'Trouver par';
        }
        modify(FindByDocument)
        {
            CaptionML = ENU = 'Find by Document', FRA = 'Trouver par Document';
            ToolTipML = ENU = 'View entries based on the specified document number.', FRA = 'Affichez des écritures basées sur le numéro de document spécifié.';
        }
        modify(FindByBusinessContact)
        {
            CaptionML = ENU = 'Find by Business Contact', FRA = 'Trouver par Contact professionnel';
            ToolTipML = ENU = 'Filter entries based on the specified contact or contact type.', FRA = 'Filtrez des écritures en fonction du type de contact ou du contact spécifié.';
        }
        modify(FindByItemReference)
        {
            CaptionML = ENU = 'Find by Item Reference', FRA = 'Trouver par Référence article';
            ToolTipML = ENU = 'Filter entries based on the specified serial number or lot number.', FRA = 'Filtrez des écritures en fonction du numéro de lot ou du numéro de série spécifié.';
        }
        // addafter(FindByItemReference)
        // {
        //     action(FindByEmcs)
        //     {
        //         CaptionML = ENU = 'Find by Emcs',
        //                     FRA = 'Trouver par EMCS';
        //         Description = 'DIT-770 #1221';
        //         Image = TaxDetail;
        //         Promoted = true;
        //         PromotedCategory = Category4;
        //         PromotedIsBig = true;

        //         trigger OnAction();
        //         begin
        //             // <<DITW17.10.05 DDR 12/02/2015 DIT-770 #1221
        //             FindBasedOn := FindBasedOn::Emcs;
        //             UpdateFindByGroupsVisibility;
        //             // >>DITW17.10.05 DDR DIT-770 #1221
        //         end;
        //     }
        // } //BC UPGRADE PATHAA02-DIT
    }


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=The business contact type was not specified.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=The business contact type was not specified.;FRA=Le type d'identifiant tiers n'a pas été spécifié.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=There are no posted records with this external document number.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=There are no posted records with this external document number.;FRA=Il n'existe pas d'enregistrement comptabilisé avec ce numéro de document externe.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=Counting records...;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=Counting records...;FRA=Comptage des enregistrements...;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=Posted Sales Invoice;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=Posted Sales Invoice;FRA=Facture vente enregistrée;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=Posted Sales Credit Memo;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=Posted Sales Credit Memo;FRA=Avoir vente enregistré;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=Posted Sales Shipment;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=Posted Sales Shipment;FRA=Expédition vente enregistrée;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=Issued Reminder;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=Issued Reminder;FRA=Relances émises;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=Issued Finance Charge Memo;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=Issued Finance Charge Memo;FRA=Factures d'intérêts émises;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=Posted Purchase Invoice;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=Posted Purchase Invoice;FRA=Facture achat enregistrée;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text009(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : ENU=Posted Purchase Credit Memo;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : ENU=Posted Purchase Credit Memo;FRA=Avoir achat enregistré;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text010(Variable 1010)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text010 : ENU=Posted Purchase Receipt;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text010 : ENU=Posted Purchase Receipt;FRA=Réception achat enregistrée;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text011(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text011 : ENU=The document number has been used more than once.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text011 : ENU=The document number has been used more than once.;FRA=Le numéro de document a été utilisé plusieurs fois.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text012(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text012 : ENU=This combination of document number and posting date has been used more than once.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text012 : ENU=This combination of document number and posting date has been used more than once.;FRA=Cette combinaison de numéro de document et de date de comptabilisation a été utilisée plusieurs fois.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text013(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text013 : ENU=There are no posted records with this document number.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text013 : ENU=There are no posted records with this document number.;FRA=Il n'existe pas d'enregistrement comptabilisé avec ce numéro de document.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text014(Variable 1014)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text014 : ENU=There are no posted records with this combination of document number and posting date.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text014 : ENU=There are no posted records with this combination of document number and posting date.;FRA=Il n'existe pas d'enregistrement pour cette combinaison de numéro de document et de date de comptabilisation.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text015(Variable 1015)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text015 : ENU=The search results in too many external documents. Specify a business contact no.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text015 : ENU=The search results in too many external documents. Specify a business contact no.;FRA=Trop de documents externes ont été trouvés. Spécifiez un identifiant tiers.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text016(Variable 1016)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text016 : ENU=The search results in too many external documents. Use Navigate from the relevant ledger entries.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text016 : ENU=The search results in too many external documents. Use Navigate from the relevant ledger entries.;FRA=Trop de documents externes ont été trouvés. Utilisez la fonction Naviguer à partir des écritures comptables correspondantes.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text017(Variable 1017)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text017 : ENU=Posted Return Receipt;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text017 : ENU=Posted Return Receipt;FRA=Réception retour enreg.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text018(Variable 1018)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text018 : ENU=Posted Return Shipment;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text018 : ENU=Posted Return Shipment;FRA=Expédition retour enreg.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text019(Variable 1019)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text019 : ENU=Posted Transfer Shipment;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text019 : ENU=Posted Transfer Shipment;FRA=Expédition transfert enreg.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text020(Variable 1020)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text020 : ENU=Posted Transfer Receipt;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text020 : ENU=Posted Transfer Receipt;FRA=Réception transfert enreg.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text021(Variable 1061)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text021 : ENU=Sales Order;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text021 : ENU=Sales Order;FRA=Commande vente;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text022(Variable 1080)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text022 : ENU=Sales Invoice;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text022 : ENU=Sales Invoice;FRA=Facture vente;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text023(Variable 1081)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text023 : ENU=Sales Return Order;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text023 : ENU=Sales Return Order;FRA=Retour vente;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text024(Variable 1082)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text024 : ENU=Sales Credit Memo;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text024 : ENU=Sales Credit Memo;FRA=Avoir vente;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text025(Variable 1097)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text025 : ENU=Posted Assembly Order;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text025 : ENU=Posted Assembly Order;FRA=Ordre d'assemblage validé;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "sText003(Variable 1096)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //sText003 : ENU=Posted Service Invoice;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //sText003 : ENU=Posted Service Invoice;FRA=Facture service enreg.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "sText004(Variable 1095)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //sText004 : ENU=Posted Service Credit Memo;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //sText004 : ENU=Posted Service Credit Memo;FRA=Avoir service enreg.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "sText005(Variable 1092)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //sText005 : ENU=Posted Service Shipment;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //sText005 : ENU=Posted Service Shipment;FRA=Expédition service enreg.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "sText021(Variable 1094)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //sText021 : ENU=Service Order;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //sText021 : ENU=Service Order;FRA=Commande service;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "sText022(Variable 1093)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //sText022 : ENU=Service Invoice;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //sText022 : ENU=Service Invoice;FRA=Facture service;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "sText024(Variable 1036)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //sText024 : ENU=Service Credit Memo;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //sText024 : ENU=Service Credit Memo;FRA=Avoir service;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text99000000(Variable 1021)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text99000000 : ENU=Production Order;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text99000000 : ENU=Production Order;FRA=Ordre de fabrication;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "FindBasedOn(Variable 1102)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //FindBasedOn : Document,"Business Contact","Item Reference";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //FindBasedOn : Document,"Business Contact","Item Reference",,,,,Emcs;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "PageCaptionTxt(Variable 1108)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //PageCaptionTxt : ENU=Selected - %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PageCaptionTxt : ENU=Selected - %1;FRA=Sélectionné - %1;
    //Variable type has not been exported.

    var
    //BC UPGRADE PATHAA02-DIT>>
    // rIntrastatledgEntry: Record "Intrastat Ledger Entry";
    // QualityTestHeader: Record "Quality Test Header";
    // DelayedEntry: Record "Delayed Disc. & Promo. Line";
    // PostedDelayedEntry: Record "Delayed Disc. & Promo. Entry";
    // AADTrackingEntry: Record "AAD Tracking Entry";
    // AADNoFilter: Code[1000];
    // NewAADNo: Code[20];
    // POServHeader: Record "Service Purchase Header";
    // PIServHeader: Record "Service Purchase Header";
    // PCMServHeader: Record "Service Purchase Header";
    // ServRcptHeader: Record "Service Receipt Header";
    // ServPurchInvHeader: Record "Service Purch. Invoice Header";
    // ServPurchCrMemoHeader: Record "Service Purch. Cr.Memo Header";
    // Text2034889: TextConst ENU = 'Posted Service Invoice', FRA = 'Facture service enreg.';
    // Text2034890: TextConst ENU = 'Posted Service Credit Memo', FRA = 'Avoir service enreg.';
    // Text2034891: TextConst ENU = 'Posted Service Shipment', FRA = 'Expédition service enreg.';
    // Text2034892: TextConst ENU = 'Service Order', FRA = 'Commande service';
    // Text2034893: TextConst ENU = 'Service Invoice', FRA = 'Facture service';
    // Text2034894: TextConst ENU = 'Service Credit Memo', FRA = 'Avoir service';
    // ServPurchLedgerEntry: Record "Service Purchase Ledger Entry";
    // rEventHeader: Record "Event Header";
    // rPostedEventHeader: Record "Posted Event Header";
    // LRNNoFilter: Code[1000];
    // NewLRNNo: Code[1000];
    // ARCNoFilter: Code[1000];
    // NewARCNo: Code[1000];
    // AADTrackingNavigateMgt: Codeunit "AAD Tracking Navigate Mgt.";
    // SSCCNoFilter: Code[1000];
    // NewSSCCNo: Code[50];
    // SSCCTrackingNavigateMgt: Codeunit "SSCC Tracking Navigate Mgt.";
    // SSCCLedgEntry: Record "SSCC Ledger Entry";
    // PostedWhseRcptHeader: Record "Posted Whse. Receipt Header";
    // PostedWhseShptHeader: Record "Posted Whse. Shipment Header";
    // PostedWhseRcptLine2: Record "Posted Whse. Receipt Line";
    // PostedWhseShptLine2: Record "Posted Whse. Shipment Line";
    // DocEntry2: Record "Document Entry" temporary;
    // 
    // SerialNoEnable: Boolean;
    // Text2014360: TextConst ENU = 'Event Header', FRA = 'Entête évenement';
    // Text2014361: TextConst ENU = 'Posted Event Header', FRA = 'En-tête événement enregistré';
    // EmcsVisible: Boolean;
    // LossBreakdownEntry: Record "Loss Breakdown Entry";
    // WHTEntry: Record "WHT Entry";
    // CompanyInfo: Record "Company Information";
    // FRLocAction: Boolean;
    // [SecurityFiltering(SecurityFilter::Filtered)]
    // PaymentHeader: Record "Payment Header";
    // [SecurityFiltering(SecurityFilter::Filtered)]
    // PaymentHeaderArchive: Record "Payment Header Archive";
    // [SecurityFiltering(SecurityFilter::Filtered)]
    // PaymentLine: Record "Payment Line";
    // [SecurityFiltering(SecurityFilter::Filtered)]
    // PaymentLineArchive: Record "Payment Line Archive";
    // ShipCostAllocation: Record "Shipping Cost Allocation FND";
    // CADEntry: Record "CAD Entry";
    // LevyTaxEntries: Record "Levy Tax Entries FND";
    //BC UPGRADE PATHAA02-DIT<<


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SourceNameEnable := true;
    SourceNoEnable := true;
    SourceTypeEnable := true;
    DocTypeEnable := true;
    PrintEnable := true;
    ShowEnable := true;
    DocumentVisible := true;
    FindBasedOn := FindBasedOn::Document;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
    // <<DITW16.00.00.37 DIT-715 #1
    SerialNoEnable := true;
    // >>DITW16.00.00.37 DIT-715 #1
    */
    //end;


    //Unsupported feature: CodeModification on "FindExtRecords(PROCEDURE 8)". Please convert manually.

    //procedure FindExtRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    FoundRecords := false;
    case ContactType of
      ContactType::Vendor:
    #4..85
              InsertIntoDocEntry(
                DATABASE::"Service Cr.Memo Header",0,sText004,ServCrMemoHeader.COUNT);
            end;

          DocExists := FINDFIRST;

    #92..99
      SetSource(0D,'','',0,'');
      MESSAGE(Text001);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..88
          // <<DITW15.00.00.35 DDR 11/09/2009
          FindUnpostedServPurchDocs(POServHeader."Document Type"::Order,Text2034892,POServHeader);
          FindUnpostedServPurchDocs(PIServHeader."Document Type"::Invoice,Text2034893,PIServHeader);
          FindUnpostedServPurchDocs(PCMServHeader."Document Type"::"Credit Memo",Text2034894,PCMServHeader);
          if ServRcptHeader.READPERMISSION then begin
            if ExtDocNo = '' then begin
              ServRcptHeader.RESET;
              ServRcptHeader.SETCURRENTKEY("Vendor No.");
              ServRcptHeader.SETFILTER("Vendor No.",ContactNo);
              InsertIntoDocEntry(
                DATABASE::"Service Receipt Header",0,Text2034891,ServRcptHeader.COUNT);
            end;
          end;
          if ServPurchInvHeader.READPERMISSION then begin
            if ExtDocNo = '' then begin
              ServPurchInvHeader.RESET;
              ServRcptHeader.SETCURRENTKEY("Vendor No.");
              ServPurchInvHeader.SETFILTER("Vendor No.",ContactNo);
              InsertIntoDocEntry(
                DATABASE::"Service Purch. Invoice Header",0,Text2034889,ServPurchInvHeader.COUNT);
            end;
          end;
          if ServPurchCrMemoHeader.READPERMISSION then begin
            if ExtDocNo = '' then begin
              ServPurchCrMemoHeader.RESET;
              ServRcptHeader.SETCURRENTKEY("Vendor No.");
              ServPurchCrMemoHeader.SETFILTER("Vendor No.",ContactNo);
              InsertIntoDocEntry(
                DATABASE::"Service Purch. Cr.Memo Header",0,Text2034890,ServPurchCrMemoHeader.COUNT);
            end;
          end;
          // >>DITW15.00.00.35 DDR
    #89..102
    */
    //end;


    //Unsupported feature: CodeModification on "FindRecords(PROCEDURE 2)". Please convert manually.

    //procedure FindRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Window.OPEN(Text002);
    RESET;
    DELETEALL;
    #4..8
      SalesShptHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Sales Shipment Header",0,Text005,SalesShptHeader.COUNT);
    end;
    if SalesInvHeader.READPERMISSION then begin
      SalesInvHeader.RESET;
      SalesInvHeader.SETFILTER("No.",DocNoFilter);
      SalesInvHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Sales Invoice Header",0,Text003,SalesInvHeader.COUNT);
    end;
    if ReturnRcptHeader.READPERMISSION then begin
      ReturnRcptHeader.RESET;
      ReturnRcptHeader.SETFILTER("No.",DocNoFilter);
    #23..51
      InsertIntoDocEntry(
        DATABASE::"Service Cr.Memo Header",0,sText004,ServCrMemoHeader.COUNT);
    end;
    if IssuedReminderHeader.READPERMISSION then begin
      IssuedReminderHeader.RESET;
      IssuedReminderHeader.SETFILTER("No.",DocNoFilter);
    #58..87
      InsertIntoDocEntry(
        DATABASE::"Return Shipment Header",0,Text018,ReturnShptHeader.COUNT);
    end;
    if PurchCrMemoHeader.READPERMISSION then begin
      PurchCrMemoHeader.RESET;
      PurchCrMemoHeader.SETFILTER("No.",DocNoFilter);
    #94..132
      InsertIntoDocEntry(
        DATABASE::"Posted Whse. Shipment Line",0,
        PostedWhseShptLine.TABLECAPTION,PostedWhseShptLine.COUNT);
    end;
    if PostedWhseRcptLine.READPERMISSION then begin
      PostedWhseRcptLine.RESET;
      PostedWhseRcptLine.SETCURRENTKEY("Posted Source No.","Posting Date");
      PostedWhseRcptLine.SETFILTER("Posted Source No.",DocNoFilter);
      PostedWhseRcptLine.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Posted Whse. Receipt Line",0,
        PostedWhseRcptLine.TABLECAPTION,PostedWhseRcptLine.COUNT);
    end;
    if GLEntry.READPERMISSION then begin
      GLEntry.RESET;
      GLEntry.SETCURRENTKEY("Document No.","Posting Date");
      GLEntry.SETFILTER("Document No.",DocNoFilter);
      GLEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"G/L Entry",0,GLEntry.TABLECAPTION,GLEntry.COUNT);
    end;
    if VATEntry.READPERMISSION then begin
      VATEntry.RESET;
      VATEntry.SETCURRENTKEY("Document No.","Posting Date");
      VATEntry.SETFILTER("Document No.",DocNoFilter);
      VATEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"VAT Entry",0,VATEntry.TABLECAPTION,VATEntry.COUNT);
    end;
    if CustLedgEntry.READPERMISSION then begin
      CustLedgEntry.RESET;
      CustLedgEntry.SETCURRENTKEY("Document No.");
      CustLedgEntry.SETFILTER("Document No.",DocNoFilter);
      CustLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Cust. Ledger Entry",0,CustLedgEntry.TABLECAPTION,CustLedgEntry.COUNT);
    end;
    if DtldCustLedgEntry.READPERMISSION then begin
      DtldCustLedgEntry.RESET;
      DtldCustLedgEntry.SETCURRENTKEY("Document No.");
      DtldCustLedgEntry.SETFILTER("Document No.",DocNoFilter);
      DtldCustLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Detailed Cust. Ledg. Entry",0,DtldCustLedgEntry.TABLECAPTION,DtldCustLedgEntry.COUNT);
    end;
    if ReminderEntry.READPERMISSION then begin
      ReminderEntry.RESET;
    #180..189
      VendLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Vendor Ledger Entry",0,VendLedgEntry.TABLECAPTION,VendLedgEntry.COUNT);
    end;
    if DtldVendLedgEntry.READPERMISSION then begin
      DtldVendLedgEntry.RESET;
      DtldVendLedgEntry.SETCURRENTKEY("Document No.");
      DtldVendLedgEntry.SETFILTER("Document No.",DocNoFilter);
      DtldVendLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Detailed Vendor Ledg. Entry",0,DtldVendLedgEntry.TABLECAPTION,DtldVendLedgEntry.COUNT);
    end;
    if ItemLedgEntry.READPERMISSION then begin
      ItemLedgEntry.RESET;
    #204..287
      InsertIntoDocEntry(
        DATABASE::"Warehouse Entry",0,WhseEntry.TABLECAPTION,WhseEntry.COUNT);
    end;

    if ServLedgerEntry.READPERMISSION then begin
      ServLedgerEntry.RESET;
      ServLedgerEntry.SETCURRENTKEY("Document No.","Posting Date");
    #295..313
      InsertIntoDocEntry(
        DATABASE::"Cost Entry",0,CostEntry.TABLECAPTION,CostEntry.COUNT);
    end;
    OnAfterNavigateFindRecords(Rec,DocNoFilter,PostingDateFilter);
    DocExists := FINDFIRST;

    #320..326
          NoOfRecords(DATABASE::"Purch. Cr. Memo Hdr.") + NoOfRecords(DATABASE::"Purch. Rcpt. Header") +
          NoOfRecords(DATABASE::"Service Invoice Header") + NoOfRecords(DATABASE::"Service Cr.Memo Header") +
          NoOfRecords(DATABASE::"Service Shipment Header") +
          NoOfRecords(DATABASE::"Transfer Shipment Header") + NoOfRecords(DATABASE::"Transfer Receipt Header") <= 1)
      then begin
        // Service Management
    #333..346
            WarrantyLedgerEntry."Posting Date",'',WarrantyLedgerEntry."Document No.",
            2,WarrantyLedgerEntry."Service Order No.")
        end;

        // Sales
        if NoOfRecords(DATABASE::"Cust. Ledger Entry") = 1 then begin
    #353..384
            SalesShptHeader."Posting Date",FORMAT("Table Name"),SalesShptHeader."No.",
            1,SalesShptHeader."Sell-to Customer No.");
        end;
        if NoOfRecords(DATABASE::"Posted Whse. Shipment Line") = 1 then begin
          PostedWhseShptLine.FINDFIRST;
          SetSource(
    #391..459
            PurchRcptHeader."Posting Date",FORMAT("Table Name"),PurchRcptHeader."No.",
            2,PurchRcptHeader."Buy-from Vendor No.");
        end;
        if NoOfRecords(DATABASE::"Posted Whse. Receipt Line") = 1 then begin
          PostedWhseRcptLine.FINDFIRST;
          SetSource(
            PostedWhseRcptLine."Posting Date",FORMAT("Table Name"),PostedWhseRcptLine."No.",
            2,'');
        end;
      end else begin
        if DocNoFilter <> '' then
          if PostingDateFilter = '' then
    #472..481
    if UpdateForm then
      UpdateFormAfterFindRecords;
    Window.CLOSE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..11
      // <<DITW17.10.05 WSA 04/02/2015 DIT-770 #779
      if SalesShptHeader.FINDFIRST then
        if SalesShptHeader."Event No."<>'' then
          if rEventHeader.READPERMISSION then begin
            rEventHeader.SETFILTER("No.",SalesShptHeader."Event No.");
            InsertIntoDocEntry(
              DATABASE::"Event Header",0,Text2014360,rEventHeader.COUNT);
          end;
      // >>DITW17.10.05 WSA 04/02/2015 DIT-770 #779
    #12..18
      // <<DITW17.10.05 WSA 04/02/2015 DIT-770 #779
      if SalesInvHeader.FINDFIRST then
        if SalesInvHeader."Event No."<>'' then
          if rEventHeader.READPERMISSION then begin
            rEventHeader.RESET;
            rEventHeader.SETFILTER("No.",SalesInvHeader."Event No.");
            InsertIntoDocEntry(
              DATABASE::"Event Header",0,Text2014360,rEventHeader.COUNT);
          end;
      // >>DITW17.10.05 WSA 04/02/2015 DIT-770 #779
    end;
    // <<DITW17.10.05 WSA 04/02/2015 DIT-770 #779
    if (rEventHeader.READPERMISSION) and not (rEventHeader.HASFILTER) then begin
      rEventHeader.RESET;
      rEventHeader.SETFILTER("No.",DocNoFilter);
      rEventHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Event Header",0,Text2014360,rEventHeader.COUNT);
      if not rEventHeader.ISEMPTY then
        FindEventRecords;
    end;
    if rEventHeader.READPERMISSION then begin
      rPostedEventHeader.RESET;
      rPostedEventHeader.SETFILTER("No.",DocNoFilter);
      rPostedEventHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Posted Event Header",0,Text2014360,rPostedEventHeader.COUNT);
      if not rPostedEventHeader.ISEMPTY then
        FindEventRecords;
    end;
    // >>DITW17.10.05 WSA 04/02/2015 DIT-770 #779
    #20..54
    // <<DITW15.00.00.35 DDR 11/09/2009
    if ServRcptHeader.READPERMISSION then begin
      ServRcptHeader.RESET;
      ServRcptHeader.SETFILTER("No.",DocNoFilter);
      ServRcptHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Service Receipt Header",0,Text2034891,ServRcptHeader.COUNT);
    end;
    if ServPurchInvHeader.READPERMISSION then begin
      ServPurchInvHeader.RESET;
      ServPurchInvHeader.SETFILTER("No.",DocNoFilter);
      ServPurchInvHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Service Purch. Invoice Header",0,Text2034889,ServPurchInvHeader.COUNT);
    end;
    if ServPurchCrMemoHeader.READPERMISSION then begin
      ServPurchCrMemoHeader.RESET;
      ServPurchCrMemoHeader.SETFILTER("No.",DocNoFilter);
      ServPurchCrMemoHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Service Purch. Cr.Memo Header",0,Text2034890,ServPurchCrMemoHeader.COUNT);
    end;
    // >>DITW15.00.00.35 DDR
    #55..90

    //HEI.04>>
    if LevyTaxEntries.READPERMISSION then begin
      LevyTaxEntries.RESET;
      LevyTaxEntries.SETCURRENTKEY("Doc. No.","Posting Date");
      LevyTaxEntries.SETFILTER("Doc. No.",DocNoFilter);
      LevyTaxEntries.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Levy Tax Entries FND",0,LevyTaxEntries.TABLECAPTION,LevyTaxEntries.COUNT);
    end;
    //HEI.04<<
    #91..135
      // <<DITW15.00.00.39 DDR 30/06/2011 #1326
      if PostedWhseShptHeader.READPERMISSION and not PostedWhseShptLine.ISEMPTY then begin
        PostedWhseShptLine.FINDFIRST;
        PostedWhseShptHeader.SETRANGE("No.",PostedWhseShptLine."No.");
        if NoOfRecords(DATABASE::"Posted Whse. Shipment Header") = 0 then
            InsertIntoDocEntry(
              DATABASE::"Posted Whse. Shipment Header",0,
              PostedWhseShptHeader.TABLECAPTION,1);
      end;
      // >>DITW15.00.00.39 DDR #1326
    end;
    // <<DITW15.00.00.39 DDR 15/04/2011 #1296 - 30/06/2011 #1326
    if PostedWhseShptHeader.READPERMISSION and PostedWhseShptLine.ISEMPTY then begin
      PostedWhseShptHeader.RESET;
      PostedWhseShptHeader.SETFILTER("No.",DocNoFilter);
      PostedWhseShptHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Posted Whse. Shipment Header",0,
        PostedWhseShptHeader.TABLECAPTION,PostedWhseShptHeader.COUNT);
    end;
    // <<DITW15.00.00.39 DDR 30/06/2011 #1326
    if PostedWhseShptLine2.READPERMISSION then begin
      PostedWhseShptLine2.RESET;
      PostedWhseShptLine2.SETFILTER("No.",DocNoFilter);
      PostedWhseShptLine2.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Posted Whse. Shipment Line",0,
        PostedWhseShptLine2.TABLECAPTION,PostedWhseShptLine2.COUNT);
    end;
    // >>DITW15.00.00.39 DDR #1326 #1296
    #137..144
      // <<DITW15.00.00.39 DDR 30/06/2011 #1326
      if PostedWhseRcptHeader.READPERMISSION and not PostedWhseRcptLine.ISEMPTY then begin
        PostedWhseRcptLine.FINDFIRST;
        PostedWhseRcptHeader.SETRANGE("No.",PostedWhseRcptLine."No.");
        if NoOfRecords(DATABASE::"Posted Whse. Receipt Header") = 0 then
            InsertIntoDocEntry(
              DATABASE::"Posted Whse. Receipt Header",0,
              PostedWhseRcptHeader.TABLECAPTION,1);
      end;
      // >>DITW15.00.00.39 DDR #1326
    end;
    // <<DITW15.00.00.39 DDR 15/04/2011 #1296 - 30/06/2011 #1326
    if PostedWhseRcptHeader.READPERMISSION and PostedWhseRcptLine.ISEMPTY then begin
      PostedWhseRcptHeader.RESET;
      PostedWhseRcptHeader.SETFILTER("No.",DocNoFilter);
      PostedWhseRcptHeader.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Posted Whse. Receipt Header",0,
        PostedWhseRcptHeader.TABLECAPTION,PostedWhseRcptHeader.COUNT);
    end;
    // <<DITW15.00.00.39 DDR 30/06/2011 #1326 - DITW15.00.00.39 DDR #1326
    if PostedWhseRcptLine2.READPERMISSION then begin
      PostedWhseRcptLine2.RESET;
      PostedWhseRcptLine2.SETFILTER("No.",DocNoFilter);
      PostedWhseRcptLine2.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Posted Whse. Receipt Line",0,
        PostedWhseRcptLine2.TABLECAPTION,PostedWhseRcptLine2.COUNT);
    end;
    // >>DITW15.00.00.39 DDR #1326 #1296
    // <<QXL9.00.001 DAT 23/03/2016 - DITW19.00.08 DDR 29/09/2016 BL#10443
    if QualityTestHeader.READPERMISSION then begin
      QualityTestHeader.RESET;
      QualityTestHeader.SETCURRENTKEY("Document Date");
      QualityTestHeader.SETFILTER("No.",DocNoFilter);
      QualityTestHeader.SETFILTER("Document Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Quality Test Header",0,QualityTestHeader.TABLECAPTION,QualityTestHeader.COUNT);
    end;
    // >>QXL9.00.001 DAT 23/03/2016 - DITW19.00.08 DDR BL#10443
    #146..153
    //<<FINXL7.00.001 RBE 20/03/2013
    if rIntrastatledgEntry.READPERMISSION then begin
      rIntrastatledgEntry.RESET;
      rIntrastatledgEntry.SETCURRENTKEY("Document No.","Posting Date");
      rIntrastatledgEntry.SETFILTER("Document No.",DocNoFilter);
      rIntrastatledgEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Intrastat Ledger Entry",0,rIntrastatledgEntry.TABLECAPTION,rIntrastatledgEntry.COUNT);
    end;
    if rIntrastatledgEntry.READPERMISSION then
      // Based on Invoice No. if no records found using Document No. (shipment/receipt - invoicing separate)
      if rIntrastatledgEntry.COUNT = 0 then begin
        rIntrastatledgEntry.RESET;
        rIntrastatledgEntry.SETCURRENTKEY("Invoice No.","Posting Date");
        rIntrastatledgEntry.SETFILTER("Invoice No.",DocNoFilter);
        rIntrastatledgEntry.SETFILTER("Posting Date",PostingDateFilter);
        InsertIntoDocEntry(
          DATABASE::"Intrastat Ledger Entry",0,rIntrastatledgEntry.TABLECAPTION,rIntrastatledgEntry.COUNT);
      end;
    //>>FINXL7.00.001 RBE 20/03/2013
    #154..161

    //HEI.03>>
    if CADEntry.READPERMISSION then begin
      CADEntry.RESET;
      CADEntry.SETCURRENTKEY("Document No.","Posting Date");
      CADEntry.SETFILTER("Document No.",DocNoFilter);
      CADEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"CAD Entry",0,CADEntry.TABLECAPTION,CADEntry.COUNT);
    end;
    //HEI.03<<

    //soicad>>
    if WHTEntry.READPERMISSION then begin
      WHTEntry.RESET;
      WHTEntry.SETCURRENTKEY("Document No.","Posting Date");
      WHTEntry.SETFILTER("Document No.",DocNoFilter);
      WHTEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"WHT Entry",0,WHTEntry.TABLECAPTION,WHTEntry.COUNT);
    end;
    //soica<<
    #162..168
      // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
      CustLedgEntry.SETRANGE("Item Charge Type",0);
      InsertIntoDocEntry2(DATABASE::"Cust. Ledger Entry",CustLedgEntry.COUNT);
      CustLedgEntry.SETRANGE("Item Charge Type");
      // >>DITW16.00.00.42 DDR DIT-715 #370
    #169..176
      // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
      DtldCustLedgEntry.SETRANGE("Item Charge Type",0);
      InsertIntoDocEntry2(DATABASE::"Detailed Cust. Ledg. Entry",DtldCustLedgEntry.COUNT);
      DtldCustLedgEntry.SETRANGE("Item Charge Type");
      // >>DITW16.00.00.42 DDR DIT-715 #370
    #177..192
      // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
      VendLedgEntry.SETRANGE("Item Charge Type",0);
      InsertIntoDocEntry2(DATABASE::"Vendor Ledger Entry",VendLedgEntry.COUNT);
      VendLedgEntry.SETRANGE("Item Charge Type");
      // >>DITW16.00.00.42 DDR DIT-715 #370
    #193..200
      // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
      DtldVendLedgEntry.SETRANGE("Item Charge Type",0);
      InsertIntoDocEntry2(DATABASE::"Detailed Vendor Ledg. Entry",DtldVendLedgEntry.COUNT);
      DtldVendLedgEntry.SETRANGE("Item Charge Type");
      // >>DITW16.00.00.42 DDR DIT-715 #370
    #201..290
    #292..316

    //HEI.01>>
    CompanyInfo.GET;
    if CompanyInfo."Enable French Localization" then
      begin
        if PaymentHeader.READPERMISSION then begin
          PaymentHeader.RESET;
          PaymentHeader.SETCURRENTKEY("Posting Date");
          PaymentHeader.SETFILTER("No.",DocNoFilter);
          PaymentHeader.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Payment Header",0,PaymentHeader.TABLECAPTION,PaymentHeader.COUNT);
        end;
        if PaymentLine.READPERMISSION then begin
          PaymentLine.RESET;
          PaymentLine.SETCURRENTKEY("Posting Date");
          PaymentLine.SETFILTER("Document No.",DocNoFilter);
          PaymentLine.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Payment Line",0,PaymentLine.TABLECAPTION,PaymentLine.COUNT);
        end;
        if PaymentHeaderArchive.READPERMISSION then begin
          PaymentHeaderArchive.RESET;
          PaymentHeaderArchive.SETCURRENTKEY("Posting Date");
          PaymentHeaderArchive.SETFILTER("No.",DocNoFilter);
          PaymentHeaderArchive.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Payment Header Archive",0,PaymentHeaderArchive.TABLECAPTION,PaymentHeaderArchive.COUNT);
        end;
        if PaymentLineArchive.READPERMISSION then begin
          PaymentLineArchive.RESET;
          PaymentLineArchive.SETCURRENTKEY("Posting Date");
          PaymentLineArchive.SETFILTER("Document No.",DocNoFilter);
          PaymentLineArchive.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Payment Line Archive",0,PaymentLineArchive.TABLECAPTION,PaymentLineArchive.COUNT);
        end;
      end;
    //HEI.01<<

    // <<DITW15.00.00.26 DDR 31/10/2008
    if DelayedEntry.READPERMISSION then begin
      DelayedEntry.RESET;
      DelayedEntry.SETCURRENTKEY("Last Post. Document No.");
      DelayedEntry.SETFILTER("Last Post. Document No.",DocNoFilter);
      DelayedEntry.SETFILTER("Last Post. Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Delayed Disc. & Promo. Line",0,DelayedEntry.TABLECAPTION,DelayedEntry.COUNT);
    end;
    if PostedDelayedEntry.READPERMISSION then begin
      PostedDelayedEntry.RESET;
      PostedDelayedEntry.SETCURRENTKEY("Last Post. Document No.");
      PostedDelayedEntry.SETFILTER("Last Post. Document No.",DocNoFilter);
      PostedDelayedEntry.SETFILTER("Last Post. Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Delayed Disc. & Promo. Entry",0,PostedDelayedEntry.TABLECAPTION,PostedDelayedEntry.COUNT);
    end;
    if PostedDelayedEntry.READPERMISSION then begin
      PostedDelayedEntry.RESET;
      PostedDelayedEntry.SETCURRENTKEY("Used Post. Document No.");
      PostedDelayedEntry.SETFILTER("Used Post. Document No.",DocNoFilter);
      PostedDelayedEntry.SETFILTER("Used Post. Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Delayed Disc. & Promo. Entry",0,PostedDelayedEntry.TABLECAPTION,PostedDelayedEntry.COUNT);
    end;
    // >>DITW15.00.00.26 DDR
    // <<DITW15.00.00.28 DDR 27/11/2008
    if AADTrackingEntry.READPERMISSION then begin
      AADTrackingEntry.RESET;
      AADTrackingEntry.SETCURRENTKEY("Document No.","Posting Date");
      AADTrackingEntry.SETFILTER("Document No.",DocNoFilter);
      AADTrackingEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"AAD Tracking Entry",0,AADTrackingEntry.TABLECAPTION,AADTrackingEntry.COUNT);
    end;
    // >>DITW15.00.00.28 DDR
    // <<DITW15.00.00.35 DDR 18/09/2009
    if ServPurchLedgerEntry.READPERMISSION then begin
      ServPurchLedgerEntry.RESET;
      ServPurchLedgerEntry.SETCURRENTKEY("Document No.","Posting Date");
      ServPurchLedgerEntry.SETFILTER("Document No.",DocNoFilter);
      ServPurchLedgerEntry.SETFILTER("Posting Date",PostingDateFilter);
      InsertIntoDocEntry(
        DATABASE::"Service Purchase Ledger Entry",0,ServPurchLedgerEntry.TABLECAPTION,ServPurchLedgerEntry.COUNT);
    end;
    // >>DITW15.00.00.35 DDR
    // <<DITW15.00.00.38 DDR 25/10/2010 - 29/11/2010 #1139
    if SSCCLedgEntry.READPERMISSION then begin
      SSCCLedgEntry.RESET;
      SSCCLedgEntry.SETCURRENTKEY("Document No.","Posting Date");
      SSCCLedgEntry.SETFILTER("Document No.",DocNoFilter);
      // <<DITW16.00.00.40 DDR 23/05/2012 DIT-715 #275
      SSCCLedgEntry.SETFILTER("Posting Date",PostingDateFilter);
      // >>DITW16.00.00.40 DDR DIT-715 #275
      InsertIntoDocEntry(
        DATABASE::"SSCC Ledger Entry",0,SSCCLedgEntry.TABLECAPTION,SSCCLedgEntry.COUNT);
    end;
    // >>DITW15.00.00.38 #1139
    // <<DITW19.00.08 DDR 29/09/2016 BL#10443
    if LossBreakdownEntry.READPERMISSION then begin
      LossBreakdownEntry.RESET;
      LossBreakdownEntry.SETCURRENTKEY("Document No.","Posting Date");
      LossBreakdownEntry.SETFILTER("Document No.",DocNoFilter);
      // <<DITW16.00.00.40 DDR 23/05/2012 DIT-715 #275
      LossBreakdownEntry.SETFILTER("Posting Date",PostingDateFilter);
      // >>DITW16.00.00.40 DDR DIT-715 #275
      InsertIntoDocEntry(
        DATABASE::"Loss Breakdown Entry",0,LossBreakdownEntry.TABLECAPTION,LossBreakdownEntry.COUNT);
    end;
    // >>DITW19.00.08 DDR BL#10443

    #317..329
          // <<DITW15.00.00.35 DDR 11/09/2009
          NoOfRecords(DATABASE::"Service Purch. Invoice Header") + NoOfRecords(DATABASE::"Service Purch. Cr.Memo Header") +
          NoOfRecords(DATABASE::"Service Receipt Header") +
          // >>DITW15.00.00.35 DDR
          // <<DITW17.10.05 WSA 25/11/2014 DIT-770 #779
          NoOfRecords(DATABASE::"Event Header") +
          // >>DITW17.10.05 WSA 25/11/2014 DIT-770 #779
    #330..349
        // <<DITW15.00.00.35 DDR 18/09/2009
        if NoOfRecords(DATABASE::"Service Purchase Ledger Entry") = 1 then begin
          ServPurchLedgerEntry.FINDFIRST;
          if ServPurchLedgerEntry.Type = ServPurchLedgerEntry.Type::"Service Contract" then
            SetSource(
              ServPurchLedgerEntry."Posting Date",FORMAT(ServPurchLedgerEntry."Document Type"),ServPurchLedgerEntry."Document No.",
              2,ServPurchLedgerEntry."Service Contract No.")
          else
            SetSource(
              ServPurchLedgerEntry."Posting Date",FORMAT(ServPurchLedgerEntry."Document Type"),ServPurchLedgerEntry."Document No.",
              2,ServPurchLedgerEntry."Service Order No.")
        end;
        // >>DITW15.00.00.35 DDR
    #350..387
        // <<DITW15.00.00.39 DDR 15/04/2011 #1296
        if NoOfRecords(DATABASE::"Posted Whse. Shipment Header") = 1 then begin
          // <<DITW15.00.00.39 DDR 30/06/2011 #1326
          if PostedWhseShptHeader.FINDFIRST and not PostedWhseShptLine2.ISEMPTY then
          SetSource(
            PostedWhseShptHeader."Posting Date",FORMAT("Table Name"),PostedWhseShptHeader."No.",
            3,PostedWhseShptHeader."Location Code");
        end;
        // >>DITW15.00.00.39 DDR  #1296
    #388..462
        //HEI.01>>
        CompanyInfo.GET;
        if CompanyInfo."Enable French Localization" then
          if NoOfRecords(DATABASE::"Posted Whse. Shipment Line") = 1 then begin
            PostedWhseShptLine.FINDFIRST;
            SetSource(
              PostedWhseShptLine."Posting Date",FORMAT("Table Name"),PostedWhseShptLine."No.",
              1,PostedWhseShptLine."Destination No.");
          end;
        //HEI.01<<
        // <<DITW15.00.00.39 DDR 15/04/2011 #1296
        if NoOfRecords(DATABASE::"Posted Whse. Receipt Header") = 1 then begin
          // <<DITW15.00.00.39 DDR 30/06/2011 #1326
          if PostedWhseRcptHeader.FINDFIRST and not PostedWhseRcptLine2.ISEMPTY then
          SetSource(
            PostedWhseRcptHeader."Posting Date",FORMAT("Table Name"),PostedWhseRcptHeader."No.",
            2,PostedWhseRcptHeader."Location Code");
        end;
        // >>DITW15.00.00.39 DDR  #1296
    #463..468
        // <<DITW15.00.00.35 DDR 11/09/2009
        if NoOfRecords(DATABASE::"Service Purch. Invoice Header") = 1 then begin
          // <<DITW16.00.00.37 DIT-715 #1
          ServPurchInvHeader.FINDFIRST;
          // >>DITW16.00.00.37 DIT-715 #1
          SetSource(
            ServPurchInvHeader."Posting Date",FORMAT("Table Name"),ServPurchInvHeader."No.",
            1,ServPurchInvHeader."Pay-to Vendor No.");
        end;
        if NoOfRecords(DATABASE::"Service Purch. Cr.Memo Header") = 1 then begin
          // <<DITW16.00.00.37 DIT-715 #1
          ServPurchCrMemoHeader.FINDFIRST;
          // >>DITW16.00.00.37 DIT-715 #1
          SetSource(
            ServPurchCrMemoHeader."Posting Date",FORMAT("Table Name"),ServPurchCrMemoHeader."No.",
            1,ServPurchCrMemoHeader."Pay-to Vendor No.");
        end;
        if NoOfRecords(DATABASE::"Service Receipt Header") = 1 then begin
          // <<DITW16.00.00.37 DIT-715 #1
          ServRcptHeader.FINDFIRST;
          // >>DITW16.00.00.37 DIT-715 #1
          SetSource(
            ServRcptHeader."Posting Date",FORMAT("Table Name"),ServRcptHeader."No.",
            1,ServRcptHeader."Vendor No.");
        end;
        // >>DITW15.00.00.35 DDR
    #469..484
    */
    //end;


    //Unsupported feature: CodeModification on "NoOfRecords(PROCEDURE 4)". Please convert manually.

    //procedure NoOfRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SETRANGE("Table ID",TableID);
    if not FINDFIRST then
      INIT;
    SETRANGE("Table ID");
    exit("No. of Records");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
    if NoOfRecords2(TableID) <> 0 then
      exit;
    // >>DITW16.00.00.42 DDR DIT-715 #370
    #1..5
    */
    //end;


    //Unsupported feature: CodeModification on "ShowRecords(PROCEDURE 6)". Please convert manually.

    //procedure ShowRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if ItemTrackingSearch then
      ItemTrackingNavigateMgt.Show("Table ID")
    else
      case "Table ID" of
        DATABASE::"Incoming Document":
          PAGE.RUN(PAGE::"Incoming Document",IncomingDocument);
    #7..50
            PAGE.RUN(PAGE::"Posted Return Shipment",ReturnShptHeader)
          else
            PAGE.RUN(0,ReturnShptHeader);
        DATABASE::"Purch. Rcpt. Header":
          if "No. of Records" = 1 then
            PAGE.RUN(PAGE::"Posted Purchase Receipt",PurchRcptHeader)
    #57..72
            PAGE.RUN(PAGE::"Posted Transfer Receipt",TransRcptHeader)
          else
            PAGE.RUN(0,TransRcptHeader);
        DATABASE::"Posted Whse. Shipment Line":
          PAGE.RUN(0,PostedWhseShptLine);
        DATABASE::"Posted Whse. Receipt Line":
          PAGE.RUN(0,PostedWhseRcptLine);
        DATABASE::"G/L Entry":
          PAGE.RUN(0,GLEntry);
        DATABASE::"VAT Entry":
          PAGE.RUN(0,VATEntry);
        DATABASE::"Detailed Cust. Ledg. Entry":
          PAGE.RUN(0,DtldCustLedgEntry);
        DATABASE::"Cust. Ledger Entry":
    #87..125
            PAGE.RUN(PAGE::"Posted Service Invoice",ServInvHeader)
          else
            PAGE.RUN(0,ServInvHeader);
        DATABASE::"Service Cr.Memo Header":
          if "No. of Records" = 1 then
            PAGE.RUN(PAGE::"Posted Service Credit Memo",ServCrMemoHeader)
    #132..135
            PAGE.RUN(PAGE::"Posted Service Shipment",ServShptHeader)
          else
            PAGE.RUN(0,ServShptHeader);
        DATABASE::"Service Ledger Entry":
          PAGE.RUN(0,ServLedgerEntry);
        DATABASE::"Warranty Ledger Entry":
          PAGE.RUN(0,WarrantyLedgerEntry);
        DATABASE::"Cost Entry":
          PAGE.RUN(0,CostEntry);
      end;

    OnAfterNavigateShowRecords("Table ID",DocNoFilter,PostingDateFilter,ItemTrackingSearch);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CompanyInfo.GET;//HEI.01
    #1..3
    // <<DITW15.00.00.38 DDR 10/08/2010 #1217
      // <<DITW15.00.00.38 DDR 25/10/2010 #1139
      if ItemSSCCTrackingSearch then
        SSCCTrackingNavigateMgt.Show("Table ID")
      else
      // >>DITW15.00.00.38 #1139
        if ItemAADTrackingSearch then
          AADTrackingNavigateMgt.Show("Table ID",0)
        else
          if ItemLRNTrackingSearch then
            AADTrackingNavigateMgt.Show("Table ID",1)
          else
            if ItemARCTrackingSearch then
              AADTrackingNavigateMgt.Show("Table ID",2)
    // ........
    else
    // >>DITW15.00.00.38 DDR
    #4..53
          //HEI.04>>
            DATABASE::"Levy Tax Entries FND":
          if "No. of Records" = 1 then
            PAGE.RUN(PAGE::"Levy Tax entries Preview",LevyTaxEntries)
          else
            PAGE.RUN(PAGE::"Levy Tax entries Preview",LevyTaxEntries);
          //HEI.04<<
    #54..75
        // <<DITW15.00.00.39 DDR 15/04/2011 #1296
        DATABASE::"Posted Whse. Shipment Header":
          PAGE.RUN(0,PostedWhseShptHeader);
        // >>DITW15.00.00.39 DDR  #1296
        DATABASE::"Posted Whse. Shipment Line":
          // <<DITW15.00.00.39 DDR 30/06/2011 #1326
          if not PostedWhseShptLine2.ISEMPTY then
            PAGE.RUN(0,PostedWhseShptLine2)
          else
          // >>DITW15.00.00.39 DDR #1326
            PAGE.RUN(0,PostedWhseShptLine);
        // <<DITW15.00.00.39 DDR 15/04/2011 #1296
        DATABASE::"Posted Whse. Receipt Header":
          PAGE.RUN(0,PostedWhseRcptHeader);
        // >>DITW15.00.00.39 DDR  #1296
        DATABASE::"Posted Whse. Receipt Line":
          // <<DITW15.00.00.39 DDR 30/06/2011 #1326
          if not PostedWhseRcptLine2.ISEMPTY then
            PAGE.RUN(0,PostedWhseRcptLine2)
          else
          // >>DITW15.00.00.39 DDR #1326
            PAGE.RUN(0,PostedWhseRcptLine);
        DATABASE::"G/L Entry":
          PAGE.RUN(0,GLEntry);
        //<<FINXL7.00.001 RBE 20/03/2013
        DATABASE::"Intrastat Ledger Entry":
          PAGE.RUN(0,rIntrastatledgEntry);
        //>>FINXL7.00.001 RBE 20/03/2013
        DATABASE::"VAT Entry":
          PAGE.RUN(0,VATEntry);
        //soicad>>
        DATABASE::"WHT Entry":
          PAGE.RUN(0,WHTEntry);
        //soicad<<

        //HEI.03>>
        DATABASE::"CAD Entry":
          PAGE.RUN(0,CADEntry);
        //HEI.03<<

    #84..128
        // <<DITW15.00.00.35 DDR 11/09/2009 - DITW17.00.01 DDR 28/11/2012 DIT-770 #001
        DATABASE::"Service Purchase Header":
          ShowPurchServiceHeaderRecords;
        // >>DITW15.00.00.35 DDR - DITW17.00.01 DDR DIT-770 #001
    #129..138
        // <<DITW15.00.00.35 DDR 18/09/2009 - DITW17.00.01 DDR 28/11/2012 DIT-770 #001
        DATABASE::"Service Purch. Invoice Header":
          if "No. of Records" = 1 then
            PAGE.RUN(PAGE::"Posted Service Purch. Invoice",ServPurchInvHeader)
          else
            PAGE.RUN(0,ServPurchInvHeader);
        DATABASE::"Service Purch. Cr.Memo Header":
          if "No. of Records" = 1 then
            PAGE.RUN(PAGE::"Posted Service Purch. Cr. Memo",ServPurchCrMemoHeader)
          else
            PAGE.RUN(0,ServPurchCrMemoHeader);
        //HEI.04>>
            DATABASE::"Levy Tax Entries FND":
          PAGE.RUN(0,LevyTaxEntries);
        //HEI.04<<
        DATABASE::"Service Receipt Header":
          if "No. of Records" = 1 then
            PAGE.RUN(PAGE::"Posted Service Receipt",ServRcptHeader)
          else
            PAGE.RUN(0,ServRcptHeader);
        // >>DITW15.00.00.35 DDR - DITW17.00.01 DDR 28/11/2012 DIT-770 #001
        DATABASE::"Service Ledger Entry":
          PAGE.RUN(0,ServLedgerEntry);
        // <<DITW15.00.00.35 DDR 18/09/2009
        DATABASE::"Service Purchase Ledger Entry":
          PAGE.RUN(0,ServPurchLedgerEntry);
        // >>DITW15.00.00.35 DDR
    #141..144
        //<<QXL9.00.001 DAT 23/03/2016
        DATABASE::"Quality Test Header":
          PAGE.RUN(0,QualityTestHeader);
        //>>QXL9.00.001 DAT 23/03/2016
        // <<DITW15.00.00.26 DDR 31/10/2008
        DATABASE::"Delayed Disc. & Promo. Line":
          PAGE.RUN(0,DelayedEntry);
        DATABASE::"Delayed Disc. & Promo. Entry":
          PAGE.RUN(0,PostedDelayedEntry);
        // >>DITW15.00.00.26 DDR
        // <<DITW15.00.00.28 DDR 27/11/2008
        DATABASE::"AAD Tracking Entry":
          PAGE.RUN(0,AADTrackingEntry);
        // >>DITW15.00.00.28 DDR
        // <<DITW15.00.00.38 DDR 25/10/2010 #1139
        DATABASE::"SSCC Ledger Entry":
          PAGE.RUN(0,SSCCLedgEntry);
        // >>DITW15.00.00.38 #1139
        // <<DITW17.10.05 WSA 25/11/2014 DIT-770 #779
        DATABASE::"Event Header":
          if "No. of Records" = 1 then
            PAGE.RUN(PAGE::"Event Header",rEventHeader)
          else
          PAGE.RUN(0,rEventHeader);
        // >>DITW17.10.05 DIT-770 #779
        // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        DATABASE::"Loss Breakdown Entry":
          PAGE.RUN(0,LossBreakdownEntry);
        // >>DITW19.00.08 DDR BL#10443
        //HEI.01>>
        DATABASE::"Payment Header":
          if CompanyInfo."Enable French Localization" then
            PAGE.RUN(0,PaymentHeader);
        DATABASE::"Payment Line":
          if CompanyInfo."Enable French Localization" then
            PAGE.RUN(0,PaymentLine);
        DATABASE::"Payment Header Archive":
          if CompanyInfo."Enable French Localization" then
            PAGE.RUN(0,PaymentHeaderArchive);
        DATABASE::"Payment Line Archive":
          if CompanyInfo."Enable French Localization" then
            PAGE.RUN(0,PaymentLineArchive)
        //HEI.01<<
    #145..147
    */
    //end;


    //Unsupported feature: CodeModification on "FindPush(PROCEDURE 13)". Please convert manually.

    //procedure FindPush();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if (DocNoFilter = '') and (PostingDateFilter = '') and
       (not ItemTrackingSearch) and
       ((ContactType <> 0) or (ContactNo <> '') or (ExtDocNo <> ''))
    then
      FindExtRecords
    #6..9
      then
        FindTrackingRecords
      else
        FindRecords;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if (DocNoFilter = '') and (PostingDateFilter = '') and
       (not ItemTrackingSearch) and
       // <<DITW15.00.00.28 DDR 27/11/2008
       (not ItemAADTrackingSearch) and
       // >>DITW15.00.00.28 DDR
       // <<DITW15.00.00.38 DDR 10/08/2010 #1217
       (not ItemLRNTrackingSearch) and
       (not ItemARCTrackingSearch) and
       // >>DITW15.00.00.38 DDR
       // <<DITW15.00.00.38 DDR 25/10/2010 #1139
       (not ItemSSCCTrackingSearch) and
       // >>DITW15.00.00.38 #1139
    #3..12
        // <<DITW15.00.00.38 DDR 25/10/2010 #1139
        //FindRecords;
        if ItemSSCCTrackingSearch and
          (DocNoFilter = '') and (PostingDateFilter = '') and
          (ContactType = 0) and (ContactNo = '') and (ExtDocNo = '')
        then
          FindSSCCTrackingRecords
        else
        // >>DITW15.00.00.38 #1139
        // <<DITW15.00.00.28 DDR 27/11/2008
        if ItemAADTrackingSearch and
          (DocNoFilter = '') and (PostingDateFilter = '') and
          (ContactType = 0) and (ContactNo = '') and (ExtDocNo = '')
        then
          FindAADTrackingRecords
        else
        // >>DITW15.00.00.28 DDR
          // <<DITW15.00.00.38 DDR 10/08/2010 #1217
            if ItemLRNTrackingSearch and
              (DocNoFilter = '') and (PostingDateFilter = '') and
              (ContactType = 0) and (ContactNo = '') and (ExtDocNo = '')
            then
              FindLRNTrackingRecords
            else
              if ItemARCTrackingSearch and
                (DocNoFilter = '') and (PostingDateFilter = '') and
                (ContactType = 0) and (ContactNo = '') and (ExtDocNo = '')
              then
                FindARCTrackingRecords
              else
                FindRecords;
        // >>DITW15.00.00.38 DDR
    */
    //end;


    //Unsupported feature: CodeModification on "ItemTrackingSearch(PROCEDURE 19)". Please convert manually.

    //procedure ItemTrackingSearch();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    exit((SerialNoFilter <> '') or (LotNoFilter <> ''));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW15.00.00.38 DDR 25/10/2010 #1139
    if SSCCNoFilter <> '' then
      exit(false);
    // >>DITW15.00.00.38 #1139

    exit((SerialNoFilter <> '') or (LotNoFilter <> ''));
    */
    //end;


    //Unsupported feature: CodeModification on "FindRecordsOnOpen(PROCEDURE 21)". Please convert manually.

    //procedure FindRecordsOnOpen();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if (NewDocNo = '') and (NewPostingDate = 0D) and (NewSerialNo = '') and (NewLotNo = '') then begin
      DELETEALL;
      ShowEnable := false;
      PrintEnable := false;
      SetSource(0D,'','',0,'');
    end else
      if (NewSerialNo <> '') or (NewLotNo <> '') then begin
        SetSource(0D,'','',0,'');
        SETRANGE("Serial No. Filter",NewSerialNo);
        SETRANGE("Lot No. Filter",NewLotNo);
        SerialNoFilter := GETFILTER("Serial No. Filter");
        LotNoFilter := GETFILTER("Lot No. Filter");
        ClearInfo;
        FindTrackingRecords;
      end else begin
        SETRANGE("Document No.",NewDocNo);
        SETRANGE("Posting Date",NewPostingDate);
        DocNoFilter := GETFILTER("Document No.");
        PostingDateFilter := GETFILTER("Posting Date");
        ContactType := ContactType::" ";
        ContactNo := '';
        ExtDocNo := '';
        ClearTrackingInfo;
        FindRecords;
      end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if (NewDocNo = '') and (NewPostingDate = 0D) and (NewSerialNo = '') and (NewLotNo = '') and
      // <<DITW15.00.00.28 DDR 27/11/2008 - DITW15.00.00.38 DDR 25/10/2010 #1217 #1139
     (NewAADNo = '') and (NewARCNo = '') and (NewLRNNo = '') and (NewSSCCNo = '')
      // >>DITW15.00.00.28 DDR - DITW15.00.00.38 DDR #1217 #1139
    then begin
      DELETEALL;
      // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
      CLEAR(DocEntry2);
      DocEntry2.DELETEALL;
      // >>DITW16.00.00.42 DDR DIT-715 #370
    #3..6
      // <<DITW15.00.00.38 DDR 25/10/2010 #1139
      //IF (NewSerialNo <> '') OR (NewLotNo <> '') THEN BEGIN
      if (NewSerialNo <> '') or (NewLotNo <> '') or (NewSSCCNo <> '') then begin
      // >>DITW15.00.00.38 DDR #1139
    #8..12
                   // <<DITW15.00.00.38 DDR 25/10/2010 #1139
                   SETFILTER("SSCC No. Filter",NewSSCCNo);
                   SSCCNoFilter := GETFILTER("SSCC No. Filter");
                   // >>DITW15.00.00.38 #1139
        ClearInfo;
        // <<DITW15.00.00.38 DDR 25/10/2010 #1139
        //FindTrackingRecords;
        SerialNoEnable := NewSSCCNo = '';
        if NewSSCCNo <> '' then begin
          FindSSCCTrackingRecords;
          SerialNoFilter := '';
          NewSerialNo := '';
        end else begin
          FindTrackingRecords;
        end;
        // >>DITW15.00.00.38 #1139
      end else begin
        // <<DITW15.00.00.28 DDR 27/11/2008
        if (NewAADNo = '') and (NewLRNNo = '') and (NewARCNo = '') then begin
        // >>DITW15.00.00.28 DDR
          SETRANGE("Document No.",NewDocNo);
          SETRANGE("Posting Date",NewPostingDate);
          DocNoFilter := GETFILTER("Document No.");
          PostingDateFilter := GETFILTER("Posting Date");
          ContactType := ContactType::" ";
          ContactNo := '';
          ExtDocNo := '';
          ClearTrackingInfo;
          // <<DITW15.00.00.38 DDR 25/10/2010 #1139
          ClearSSCCTrackingInfo;
          // >>DITW15.00.00.38 #1139
          // <<DITW15.00.00.28 DDR 27/11/2008
          ClearAADTrackingInfo;
          // >>DITW15.00.00.28 DDR
          // <<DITW15.00.00.38 DDR 10/08/2010 #1217
          ClearLRNTrackingInfo;
          ClearARCTrackingInfo;
          // >>DITW15.00.00.38 DDR
          FindRecords;
        // <<DITW15.00.00.28 DDR 27/11/2008
        end else
          if (NewAADNo <> '') then begin
            SETRANGE("AAD No. Filter",NewAADNo);
            AADNoFilter := GETFILTER("AAD No. Filter");
            ClearInfo;
            FindAADTrackingRecords;
            // >>DITW15.00.00.38 DDR
          end else
            // <<DITW15.00.00.38 DDR 10/08/2010 #1217
            if (NewLRNNo <> '') then begin
              SETRANGE("LRN No. Filter",NewLRNNo);
              LRNNoFilter := GETFILTER("LRN No. Filter");
              ClearInfo;
              ClearAADTrackingInfo;
              ClearARCTrackingInfo;
              FindLRNTrackingRecords;
            end else
              if (NewARCNo <> '') then begin
                SETRANGE("ARC No. Filter",NewARCNo);
                ARCNoFilter := GETFILTER("ARC No. Filter");
                ClearInfo;
                ClearAADTrackingInfo;
                ClearLRNTrackingInfo;
                FindARCTrackingRecords;
              end;
            // >>DITW15.00.00.38 DDR
        // >>DITW15.00.00.28 DDR
      end;
    */
    //end;


    //Unsupported feature: CodeModification on "UpdateFindByGroupsVisibility(PROCEDURE 34)". Please convert manually.

    //procedure UpdateFindByGroupsVisibility();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DocumentVisible := false;
    BusinessContactVisible := false;
    ItemReferenceVisible := false;

    case FindBasedOn of
      FindBasedOn::Document:
        DocumentVisible := true;
      FindBasedOn::"Business Contact":
        BusinessContactVisible := true;
      FindBasedOn::"Item Reference":
        ItemReferenceVisible := true;
    end;

    CurrPage.UPDATE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    // <<DITW17.10.05 DDR 12/02/2015 DIT-770 #1221
    EmcsVisible := false;
    // >>DITW17.10.05 DDR DIT-770 #1221
    #4..11
      // <<DITW17.10.05 DDR 12/02/2015 DIT-770 #1221
      FindBasedOn::Emcs:
        EmcsVisible := true;
      // >>DITW17.10.05 DDR DIT-770 #1221
    #12..14
    */
    //end;

    // local procedure ShowPurchServiceHeaderRecords();
    // begin
    //     // <<DITW15.00.00.35 DDR 11/09/2009 - DITW17.00.01 DDR 28/11/2012 DIT-770 #001
    //     TESTFIELD("Table ID", DATABASE::"Service Purchase Header");

    //     case "Document Type" of
    //         // not yet
    //         //"Document Type"::Order:
    //         //  IF "No. of Records" = 1 THEN
    //         //    PAGE.RUN(PAGE::"P. Service Order",POServHeader)
    //         //  else
    //         //    PAGE.RUN(0,POServHeader);
    //         "Document Type"::Invoice:
    //             if "No. of Records" = 1 then
    //                 PAGE.RUN(PAGE::"Service Purchase Invoice", PIServHeader)
    //             else
    //                 PAGE.RUN(0, PIServHeader);
    //         "Document Type"::"Credit Memo":
    //             if "No. of Records" = 1 then
    //                 PAGE.RUN(PAGE::"Service Purch. Credit Memo", PCMServHeader)
    //             else
    //                 PAGE.RUN(0, PCMServHeader);
    //     end;
    // end; //BC UPGRADE PATHAA02-DIT

    // procedure FindAADTrackingRecords();
    // var
    //     DocNoOfRecords: Integer;
    // begin
    //     // <<DITW15.00.00.28 DDR 27/11/2008 - DITW15.00.00.38 DDR 10/08/2010 #1217
    //     Window.OPEN(Text002);
    //     DELETEALL;
    //     "Entry No." := 0;

    //     CLEAR(AADTrackingNavigateMgt);
    //     AADTrackingNavigateMgt.FindAADTrackingRecords(AADNoFilter, '', '');

    //     AADTrackingNavigateMgt.Collect(TempRecordBuffer);
    //     TempRecordBuffer.SETCURRENTKEY("Table No.", "Search Record ID");
    //     if TempRecordBuffer.FIND('-') then
    //         repeat
    //             TempRecordBuffer.SETRANGE("Table No.", TempRecordBuffer."Table No.");

    //             DocNoOfRecords := 0;
    //             if TempRecordBuffer.FIND('-') then
    //                 repeat
    //                     TempRecordBuffer.SETRANGE("Search Record ID", TempRecordBuffer."Search Record ID");
    //                     TempRecordBuffer.FIND('+');
    //                     TempRecordBuffer.SETRANGE("Search Record ID");
    //                     DocNoOfRecords += 1;
    //                 until TempRecordBuffer.NEXT = 0;

    //             InsertIntoDocEntry(
    //     TempRecordBuffer."Table No.", 0, TempRecordBuffer."Table Name", DocNoOfRecords);

    //             TempRecordBuffer.SETRANGE("Table No.");
    //         until TempRecordBuffer.NEXT = 0;

    //     DocExists := FINDFIRST;

    //     UpdateFormAfterFindRecords;
    //     Window.CLOSE;
    // end; //BC UPGRADE PATHAA02-DIT

    // procedure ClearAADTrackingInfo();
    // begin
    //     AADNoFilter := '';
    // end;

    // procedure SetAADTracking(AADNo: Code[20]);
    // begin
    //     NewAADNo := AADNo;
    // end; //BC UPGRADE PATHAA02-DIT

    // procedure ItemAADTrackingSearch(): Boolean;
    // begin
    //     exit(AADNoFilter <> '');
    // end; //BC UPGRADE PATHAA02-DIT

    // local procedure FindUnpostedServPurchDocs(DocType: Option; DocTableName: Text[100]; var ServPurchHeader: Record "Service Purchase Header");
    // begin
    //     // <<DITW15.00.00.35 DDR 11/09/2009
    //     if ServPurchHeader.READPERMISSION then begin
    //         if ExtDocNo = '' then begin
    //             ServPurchHeader.RESET;
    //             ServPurchHeader.SETCURRENTKEY("Vendor No.");
    //             ServPurchHeader.SETFILTER("Vendor No.", ContactNo);
    //             ServPurchHeader.SETRANGE("Document Type", DocType);
    //             InsertIntoDocEntry(DATABASE::"Service Purchase Header", DocType, DocTableName, ServPurchHeader.COUNT);
    //         end;
    //     end;
    // end; //BC UPGRADE PATHAA02-DIT

    // procedure FindLRNTrackingRecords();
    // var
    //     DocNoOfRecords: Integer;
    // begin
    //     // <<DITW15.00.00.38 DDR 10/08/2010 #1217
    //     Window.OPEN(Text002);
    //     DELETEALL;
    //     "Entry No." := 0;

    //     CLEAR(AADTrackingNavigateMgt);
    //     AADTrackingNavigateMgt.FindLRNTrackingRecords(LRNNoFilter, '', '');

    //     AADTrackingNavigateMgt.Collect(TempRecordBuffer);
    //     TempRecordBuffer.SETCURRENTKEY("Table No.", "Search Record ID");
    //     if TempRecordBuffer.FIND('-') then
    //         repeat
    //             TempRecordBuffer.SETRANGE("Table No.", TempRecordBuffer."Table No.");

    //             DocNoOfRecords := 0;
    //             if TempRecordBuffer.FIND('-') then
    //                 repeat
    //                     TempRecordBuffer.SETRANGE("Search Record ID", TempRecordBuffer."Search Record ID");
    //                     TempRecordBuffer.FIND('+');
    //                     TempRecordBuffer.SETRANGE("Search Record ID");
    //                     DocNoOfRecords += 1;
    //                 until TempRecordBuffer.NEXT = 0;

    //             InsertIntoDocEntry(
    //               TempRecordBuffer."Table No.", 0, TempRecordBuffer."Table Name", DocNoOfRecords);

    //             TempRecordBuffer.SETRANGE("Table No.");
    //         until TempRecordBuffer.NEXT = 0;

    //     DocExists := FINDFIRST;

    //     UpdateFormAfterFindRecords;
    //     Window.CLOSE;
    // end;//BC UPGRADE PATHAA02-DIT

    // procedure ClearLRNTrackingInfo();
    // begin
    //     // <<DITW15.00.00.38 DDR 10/08/2010 #1217
    //     LRNNoFilter := '';
    // end; //BC UPGRADE PATHAA02-DIT

    // procedure SetLRNTracking(LRNNo: Code[20]);
    // begin
    //     // <<DITW15.00.00.38 DDR 10/08/2010 #1217
    //     NewLRNNo := LRNNo;
    // end; //BC UPGRADE PATHAA02-DIT

    // procedure ItemLRNTrackingSearch(): Boolean;
    // begin
    //     // <<DITW15.00.00.38 DDR 10/08/2010 #1217
    //     exit(LRNNoFilter <> '');
    // end; //BC UPGRADE PATHAA02-DIT

    // procedure FindARCTrackingRecords();
    // var
    //     DocNoOfRecords: Integer;
    // begin
    //     // <<DITW15.00.00.38 DDR 10/08/2010 #1217
    //     Window.OPEN(Text002);
    //     DELETEALL;
    //     "Entry No." := 0;

    //     CLEAR(AADTrackingNavigateMgt);
    //     AADTrackingNavigateMgt.FindARCTrackingRecords(ARCNoFilter);

    //     AADTrackingNavigateMgt.Collect(TempRecordBuffer);
    //     TempRecordBuffer.SETCURRENTKEY("Table No.", "Search Record ID");
    //     if TempRecordBuffer.FIND('-') then
    //         repeat
    //             TempRecordBuffer.SETRANGE("Table No.", TempRecordBuffer."Table No.");

    //             DocNoOfRecords := 0;
    //             if TempRecordBuffer.FIND('-') then
    //                 repeat
    //                     TempRecordBuffer.SETRANGE("Search Record ID", TempRecordBuffer."Search Record ID");
    //                     TempRecordBuffer.FIND('+');
    //                     TempRecordBuffer.SETRANGE("Search Record ID");
    //                     DocNoOfRecords += 1;
    //                 until TempRecordBuffer.NEXT = 0;

    //             InsertIntoDocEntry(
    //               TempRecordBuffer."Table No.", 0, TempRecordBuffer."Table Name", DocNoOfRecords);

    //             TempRecordBuffer.SETRANGE("Table No.");
    //         until TempRecordBuffer.NEXT = 0;

    //     DocExists := FINDFIRST;

    //     UpdateFormAfterFindRecords;
    //     Window.CLOSE;
    // end; //BC UPGRADE PATHAA02-DIT

    // procedure ClearARCTrackingInfo();
    // begin
    //     // <<DITW15.00.00.38 DDR 10/08/2010 #1217
    //     ARCNoFilter := '';
    // end; //BC UPGRADE PATHAA02-DIT

    // procedure SetARCTracking(ARCNo: Code[20]);
    // begin
    //     // <<DITW15.00.00.38 DDR 10/08/2010 #1217
    //     NewARCNo := ARCNo;
    // end; //BC UPGRADE PATHAA02-DIT

    // procedure ItemARCTrackingSearch(): Boolean;
    // begin
    //     // <<DITW15.00.00.38 DDR 10/08/2010 #1217
    //     exit(ARCNoFilter <> '');
    // end; //BC UPGRADE PATHAA02-DIT

    // procedure SetSSCCTracking(SSCCNo: Code[50]; LotNo: Code[20]);
    // begin
    //     // <<DITW15.00.00.38 DDR 25/10/2010 #1139
    //     NewSSCCNo := SSCCNo;
    //     NewLotNo := LotNo;
    // end; //BC UPGRADE PATHAA02-DIT

    // procedure FindSSCCTrackingRecords();
    // var
    //     DocNoOfRecords: Integer;
    // begin
    //     // <<DITW15.00.00.38 DDR 25/10/2010 #1139
    //     Window.OPEN(Text002);
    //     DELETEALL;
    //     "Entry No." := 0;

    //     CLEAR(SSCCTrackingNavigateMgt);
    //     SSCCTrackingNavigateMgt.FindTrackingRecords(SSCCNoFilter, LotNoFilter, '', '', false);

    //     SSCCTrackingNavigateMgt.Collect(TempRecordBuffer);
    //     TempRecordBuffer.SETCURRENTKEY("Table No.", "Search Record ID");
    //     if TempRecordBuffer.FIND('-') then
    //         repeat
    //             TempRecordBuffer.SETRANGE("Table No.", TempRecordBuffer."Table No.");

    //             DocNoOfRecords := 0;
    //             if TempRecordBuffer.FIND('-') then
    //                 repeat
    //                     TempRecordBuffer.SETRANGE("Search Record ID", TempRecordBuffer."Search Record ID");
    //                     TempRecordBuffer.FIND('+');
    //                     TempRecordBuffer.SETRANGE("Search Record ID");
    //                     DocNoOfRecords += 1;
    //                 until TempRecordBuffer.NEXT = 0;

    //             InsertIntoDocEntry(
    //               TempRecordBuffer."Table No.", 0, TempRecordBuffer."Table Name", DocNoOfRecords);

    //             TempRecordBuffer.SETRANGE("Table No.");
    //         until TempRecordBuffer.NEXT = 0;

    //     DocExists := FIND('-');

    //     UpdateFormAfterFindRecords;
    //     Window.CLOSE;
    // end; //BC UPGRADE PATHAA02-DIT

    // procedure ItemSSCCTrackingSearch(): Boolean;
    // begin
    //     // <<DITW15.00.00.38 DDR 25/10/2010 #1139
    //     exit(SSCCNoFilter <> '');
    // end; //BC UPGRADE PATHAA02-DIT

    // procedure ClearSSCCTrackingInfo();
    // begin
    //     // <<DITW15.00.00.38 DDR 25/10/2010 #1139
    //     SerialNoFilter := '';
    //     LotNoFilter := '';
    //     SSCCNoFilter := '';
    // end; //BC UPGRADE PATHAA02-DIT

    // local procedure NoOfRecords2(TableID: Integer): Integer;
    // begin
    //     // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
    //     with DocEntry2 do begin
    //         SETRANGE("Table ID", TableID);
    //         if FINDFIRST then
    //             exit("No. of Records");
    //     end;
    // end; //BC UPGRADE PATHAA02-DIT

    // local procedure InsertIntoDocEntry2(DocTableID: Integer; DocNoOfRecords: Integer);
    // begin
    //     // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
    //     with DocEntry2 do begin
    //         if DocNoOfRecords = 0 then
    //             exit;
    //         INIT;
    //         "Entry No." := "Entry No." + 1;
    //         "Table ID" := DocTableID;
    //         "No. of Records" := DocNoOfRecords;
    //         INSERT;
    //     end;
    // end; //BC UPGRADE PATHAA02-DIT

    local procedure SSCCNoFilterOnAfterValidate();
    begin
        ClearSourceInfo();
    end;

    // local procedure AADNoFilterOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.38 DDR 10/08/2010 #1217
    //     ClearSourceInfo;
    //     LRNNoFilter := '';
    //     NewLRNNo := '';
    //     ARCNoFilter := '';
    //     NewARCNo := '';
    // end; //BC UPGRADE PATHAA02-DIT

    // local procedure LRNNoFilterOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.38 DDR 10/08/2010 #1217
    //     ClearSourceInfo;
    //     AADNoFilter := '';
    //     NewAADNo := '';
    //     ARCNoFilter := '';
    //     NewARCNo := '';
    // end; //BC UPGRADE PATHAA02-DIT

    // local procedure ARCNoFilterOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.38 DDR 10/08/2010 #1217
    //     ClearSourceInfo;
    //     AADNoFilter := '';
    //     NewAADNo := '';
    //     LRNNoFilter := '';
    //     NewLRNNo := '';
    // end; //BC UPGRADE PATHAA02-DIT

    // procedure FindEventRecords();
    // begin
    //     // <<DITW17.10.05 WSA 25/11/2014 DIT-770 #779
    //     if SOSalesHeader.READPERMISSION then begin
    //         SOSalesHeader.RESET;
    //         SOSalesHeader.SETRANGE("Document Type", SOSalesHeader."Document Type"::Order);
    //         SOSalesHeader.SETFILTER("Event No.", DocNoFilter);
    //         InsertIntoDocEntry(DATABASE::"Sales Header", SOSalesHeader."Document Type"::Order, SOSalesHeader.TABLECAPTION, SOSalesHeader.COUNT);
    //     end;
    //     if SalesShptHeader.READPERMISSION then begin
    //         SalesShptHeader.RESET;
    //         SalesShptHeader.SETFILTER("Event No.", DocNoFilter);
    //         InsertIntoDocEntry(
    //           DATABASE::"Sales Shipment Header", 0, Text005, SalesShptHeader.COUNT);
    //     end;
    //     if SalesInvHeader.READPERMISSION then begin
    //         SalesInvHeader.RESET;
    //         SalesInvHeader.SETFILTER("Event No.", DocNoFilter);
    //         InsertIntoDocEntry(
    //           DATABASE::"Sales Invoice Header", 0, Text003, SalesInvHeader.COUNT);
    //     end;
    //     // >>DITW17.10.05 WSA 25/11/2014 DIT-770 #779
    // end; //BC UPGRADE PATHAA02-DIT

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

