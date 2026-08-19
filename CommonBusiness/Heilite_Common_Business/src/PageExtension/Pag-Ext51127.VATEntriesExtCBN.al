pageextension 51127 VATEntriesExtCBN extends "VAT Entries"
{
    // FINXL7.00.001 RBE 20/03/2013 : Added following fields on page "Unrealized Amount"
    //                                                               "Unrealized Base"
    //                                                               "Remaining Unrealized Amount"
    //                                                               "Remaining Unrealized Base"
    //                                                               "Unrealized VAT Entry No."
    // FINXL8.00.001 BSA 11/06/2015 #79 : Calculate Field Name

    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //   # New Field added - "TIN No."

    // HEI.02 FDD-RTRGAP BRD HT422 IBM BULIMC01 10.04.2019 # New field "External Document Number" added on page
    // HEI.03 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # New Field added: "Location Code"
    // HEI.04 FDD-HT2159 - CHG2105031 IBM NASTAA02 04.08.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field added: "Region Code"

    layout
    {
        modify("Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number assigned to the entry.', FRA = 'Spécifie le numéro affecté à l''écriture.';
        }
        modify("Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code for the general business posting group that was used when the VAT entry was posted.', FRA = 'Spécifie le code groupe comptabilisation marché qui a été utilisé lorsque l''écriture TVA a été validée.';
        }
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code for the general product posting group that was used when the VAT entry was posted.', FRA = 'Spécifie le code groupe comptabilisation produit qui a été utilisé lorsque l''écriture TVA a été validée.';
        }
        modify("VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the VAT business posting group code that was used when the entry was posted.', FRA = 'Spécifie le code groupe comptabilisation marché TVA qui a été utilisé lorsque l''écriture a été validée.';
        }
        modify("VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the VAT product posting group code that was used when the entry was posted.', FRA = 'Spécifie le code groupe comptabilisation produit TVA utilisé lorsque l''écriture a été validée.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the VAT entry''s posting date.', FRA = 'Spécifie la date comptabilisation de l''écriture TVA.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date on the document that provided the basis for this VAT entry.', FRA = 'Spécifie la date du document qui a servi à générer cette écriture TVA.';
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies the document number on the VAT entry.', FRA = 'Spécifie le numéro du document de l''écriture TVA.';
        }
        modify("Document Type")
        {
            ToolTipML = ENU = 'Specifies the document type that the VAT entry belongs to.', FRA = 'Spécifie le type de document auquel appartient l''écriture TVA.';
        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the type of the VAT entry.', FRA = 'Spécifie le type d''écriture TVA.';
        }
        modify(Base)
        {
            ToolTipML = ENU = 'Specifies the amount that the VAT amount (the amount shown in the Amount field) is calculated from.', FRA = 'Spécifie le montant à partir duquel le montant de TVA (affiché dans le champ Montant) est calculé.';
        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the amount of the VAT entry in LCY.', FRA = 'Spécifie le montant de l''écriture TVA en DS.';
        }
        modify("VAT Difference")
        {
            ToolTipML = ENU = 'Specifies the VAT difference that arises when you make a correction to a VAT amount on a sales or purchase document.', FRA = 'Spécifie la différence de TVA qui apparaît lorsque vous corrigez le montant de TVA sur un document vente ou achat.';
        }
        modify("Additional-Currency Base")
        {
            ToolTipML = ENU = 'Specifies the amount that the VAT amount is calculated from if you post in an additional reporting currency.', FRA = 'Spécifie le montant à partir duquel le montant de la TVA est calculé si vous validez dans une devise report.';
        }
        modify("Additional-Currency Amount")
        {
            ToolTipML = ENU = 'Specifies the amount of the VAT entry. The amount is in the additional reporting currency.', FRA = 'Spécifie le montant de l''écriture TVA. Le montant est en devise report.';
        }
        modify("Add.-Curr. VAT Difference")
        {
            ToolTipML = ENU = 'Specifies (in the additional reporting currency) the VAT difference that arises when you make a correction to a VAT amount on a sales or purchase document.', FRA = 'Spécifie (dans la devise report supplémentaire) la différence de TVA qui apparaît lorsque vous corrigez le montant de TVA sur un document vente ou achat.';
        }
        modify("VAT Calculation Type")
        {
            ToolTipML = ENU = 'Specifies which VAT calculation type was used when this entry was posted.', FRA = 'Spécifie le mode calcul TVA utilisé lorsque cette écriture a été validée.';
        }
        modify("Bill-to/Pay-to No.")
        {
            ToolTipML = ENU = 'Specifies the number of the bill-to customer or pay-to vendor that the entry is linked to.', FRA = 'Spécifie le numéro du client facturé ou du fournisseur à payer auquel l''écriture est liée.';
        }
        modify("VAT Registration No.")
        {
            ToolTipML = ENU = 'Specifies the VAT registration number of the customer or vendor that the entry is linked to.', FRA = 'Spécifie le numéro d''identification intracommunautaire du client ou du fournisseur auquel l''écriture est associée.';
        }
        modify("Ship-to/Order Address Code")
        {
            ToolTipML = ENU = 'Specifies the address code of the ship-to customer or order-from vendor that the entry is linked to.', FRA = 'Spécifie le code adresse destinataire ou le code adresse de commande auquel l''écriture est liée.';
        }
        modify("Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region of the address.', FRA = 'Spécifie le pays/la région de l''adresse.';
        }
        modify("EU 3-Party Trade")
        {
            ToolTipML = ENU = 'Specifies whether the entry was part of a 3-party trade.', FRA = 'Spécifie si l''écriture faisait partie ou non d''une transaction tripartite.';
        }
        modify(Closed)
        {
            ToolTipML = ENU = 'Specifies whether the VAT entry has been closed by the Calc. and Post VAT Settlement batch job.', FRA = 'Spécifie si l''écriture TVA a été clôturée par le traitement par lots Calculer et valider décl. TVA.';
        }
        modify("Closed by Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number of the VAT entry that has closed the entry, if the VAT entry was closed with the Calc. and Post VAT Settlement batch job.', FRA = 'Spécifie le numéro de l''écriture TVA qui a clôturé l''écriture, si l''écriture TVA a été clôturée avec le traitement par lots Calculer et valider décl. TVA.';
        }
        modify("Internal Ref. No.")
        {
            ToolTipML = ENU = 'Specifies the internal reference number for the line.', FRA = 'Spécifie le numéro de référence interne de la ligne.';
        }
        modify(Reversed)
        {
            ToolTipML = ENU = 'Specifies if the entry has been part of a reverse transaction.', FRA = 'Spécifie si l''écriture a fait partie d''une transaction contre-passée.';
        }
        modify("Reversed by Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number of the correcting entry. If the field Specifies a number, the entry cannot be reversed again.', FRA = 'Spécifie le numéro de l''écriture de correction. Si le champ contient un numéro, l''écriture ne peut pas être contrepassée à nouveau.';
        }
        modify("Reversed Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number of the original entry that was undone by the reverse transaction.', FRA = 'Spécifie le numéro de l''écriture initiale annulée par la transaction contre-passée.';
        }
        modify("EU Service")
        {
            ToolTipML = ENU = 'Specifies if this VAT entry is to be reported as a service in the periodic VAT reports.', FRA = 'Indique si l''écriture TVA doit être enregistrée en tant que service dans les déclarations de TVA périodiques.';
        }
        addafter("Add.-Curr. VAT Difference")
        {
            //BC Upgrade ADHIKG01>>
            // field("Unrealized Amount";"Unrealized Amount")
            // {
            //     Description = 'FINXL7.00.001';
            // }
            // field("Unrealized Base";"Unrealized Base")
            // {
            //     Description = 'FINXL7.00.001';
            // }
            // field("Remaining Unrealized Amount";"Remaining Unrealized Amount")
            // {
            //     Description = 'FINXL7.00.001';
            // }
            // field("Remaining Unrealized Base";"Remaining Unrealized Base")
            // {
            //     Description = 'FINXL7.00.001';
            // }
            //BC Upgrade ADHIKG01<<
            field("Unrealized VAT Entry No."; Rec."Unrealized VAT Entry No.")
            {
                Description = 'FINXL7.00.001';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Unrealized VAT Entry No. field.';
            }
        }
        addafter("Bill-to/Pay-to No.")
        {
            field(Name; TxtName)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TxtName field.';
            }
        }
        addafter("Internal Ref. No.")
        {
            field("VAT Retention Base"; Rec."VAT Retention Base FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VAT Retention Base field.';
            }
        }
        modify("External Document No.") //BC Version 28.0 Compatibility Fix
        {
            Visible = true;
            Editable = false;
            ApplicationArea = All;
            ToolTip = 'Specifies the value of the External Document No. field.';
        }
        addafter("EU Service")
        {
            field("TIN No."; Rec."TIN No. FND")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TIN No. field.';
            }

            // field("External Document No."; Rec."External Document No.") //BC Version 28.0 Compatibility Fix
            // {
            //     Editable = false;
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the External Document No. field.';
            // }

            field("Location Code"; Rec."Location Code FND")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Location Code field.';
            }
            field("Region Code"; Rec."Region Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Region Code field.';
            }
        }
        moveafter("TIN No."; "External Document No.") //BC Version 28.0 Compatibility Fix
    }
    actions
    {
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
            ToolTipML = ENU = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.', FRA = 'Recherchez toutes les écritures et tous les documents qui existent pour le numéro de document et la date comptabilisation sur l''écriture ou le document.';
        }
        modify(IncomingDocument)
        {
            CaptionML = ENU = 'Incoming Document', FRA = 'Document entrant';
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
    }

    var
        TxtName: Text[80];


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    var
        lrecCustomer: Record Customer;
        lrecVendor: Record Vendor;
    //begin
    /*
    //<<FINXL8.00.001 BSA 11/06/2015 #79
    if Type = Type::Sale then begin
      if lrecCustomer.GET("Bill-to/Pay-to No.") then
        TxtName := lrecCustomer.Name;
      end else if  Type = Type::Purchase then
      if lrecVendor.GET("Bill-to/Pay-to No.")then
        TxtName := lrecVendor.Name;
    //>>FINXL8.00.001 BSA 11/06/2015 #79
    */
    //end;


    //Unsupported feature: CodeModification on "OnModifyRecord". Please convert manually.

    //trigger OnModifyRecord() : Boolean;
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CODEUNIT.RUN(CODEUNIT::"VAT Entry - Edit",Rec);
    EXIT(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CODEUNIT.RUN(CODEUNIT::"VAT Entry - Edit",Rec);
    exit(false);
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

