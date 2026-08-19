pageextension 51110 PurchaseOrderArchivesExtCBN extends "Purchase Order Archives"
{
    // version NAVW110.0,HEI.06

    //     HEI.01 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # New Field added: "Fixed Asset Acquisition"
    // HEI.02 FDD-HB2482 CHG2123206 IBM NANDIS01 03.11.2021 - Improvement of multiple HeiLite reports for StP  Procurement users
    //   # Added "Created By" field in the page
    //   # Added Limit PO in the page
    // HEI.03 CHG2121745 IBM BHATTA09 25.11.2021 - SRM - SC fields to be added in HL
    //   # Added "Shopping card No." field in the page
    //   # Added "Shopping Card Creation Date" in the page
    //   # Added field Total VAT
    //   # Added field Total Incl. VAT
    //   # Added field Total Excl. VAT
    //   # Added field "Requester ID"
    // HEI.04 CHG2137782 HB2685 IBM MAJUMS03 23.12.2021 # Add Field "PO Reference" in Archives PO
    //   # New Field added - "Your Reference"
    // HEI.05 CHG2188365 HB3301 IBM NANDIS01 08.03.2023 # Limit PO in PO Archive
    //   # Code modified to show the fields values in Page correctly
    // HEI.06 CHG2198377 CC IBM NANDIS01 27.03.2023 # Limit Po archieve
    //   # Source Expression changed to LimitPO


    layout
    {
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Version No.")
        {
            ToolTipML = ENU = 'Specifies the version number of the archived document.', FRA = 'Spécifie le numéro de version du document archivé.';
        }
        modify("Date Archived")
        {
            ToolTipML = ENU = 'Specifies the date when the document was archived.', FRA = 'Spécifie la date à laquelle vous avez archivé le document.';
        }
        modify("Time Archived")
        {
            ToolTipML = ENU = 'Specifies what time the document was archived.', FRA = 'Spécifie l''heure d''archivage du document.';
        }
        modify("Archived By")
        {
            ToolTipML = ENU = 'Specifies the user ID of the person who archived this document.', FRA = 'Spécifie le code de l''utilisateur ayant archivé ce document.';
        }
        modify("Interaction Exist")
        {
            ToolTipML = ENU = 'Specifies that the archived document is linked to an interaction log entry.', FRA = 'Spécifie que le document archivé est lié à une écriture journal interaction.';
        }
        modify("Buy-from Vendor No.")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Order Address Code")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Buy-from Vendor Name")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Vendor Authorization No.")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Buy-from Post Code")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Buy-from Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Buy-from Contact")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Pay-to Vendor No.")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Pay-to Name")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Pay-to Post Code")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Pay-to Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Pay-to Contact")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Ship-to Code")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Ship-to Name")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Ship-to Post Code")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Ship-to Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Ship-to Contact")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Purchaser Code")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Payment Discount %")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Payment Method Code")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        modify("Shipment Method Code")
        {
            ToolTipML = ENU = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.', FRA = 'Spécifie les informations concernant les devis, les demandes de prix ou les commandes achat figurant dans les versions précédentes du document.';
        }
        addafter("Posting Date")
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Your Reference field.';
            }
        }
        addafter("Shipment Method Code")

        {

            field("Fixed Asset Acquisition"; Rec."Fixed Asset Acquisition FND")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Fixed Asset Acquisition field.';
            }

            /*//BC Upgrade Manisha Drink it code commented>>

            field("Created By";Rec."Created By")
            {
            }
            */ //BC Upgrade Manisha Drink it code commented<<

            field(LimitPO; LimitPO)
            {
                Caption = 'Limit PO';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Limit PO field.';
            }
            /*BC Upgrade Manisha temporary code blocked
            field("Shopping Card No."; Rec."Shopping Card No.")
            {
            }
            *//*BC Upgrade Manisha temporary code blocked
            field("Shopping Card Creation Date"; PurchaseHeaderArchiveAdditional."Shopping Card Creation Date")
            {
            }
            field(Amount; Rec.Amount)
            {
                CaptionML = ENU = 'Total Excl. VAT',
                            FRA = 'Montant';
            }
            field("""Amount Including VAT""-Amount"; Rec."Amount Including VAT" - Rec.Amount)
            {
                Caption = 'Total VAT';
            }
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
                CaptionML = ENU = 'Total Incl. VAT',
                            FRA = 'Montant TTC';
            }
            /* //BC Upgrade Manisha Drink it Field commented>>
            field("Requester ID"; Rec."Requester ID")
            {
            }
            */ //BC Upgrade Manisha Drink it Field commented<<

        }
    }
    actions
    {
        modify("Ver&sion")
        {
            CaptionML = ENU = 'Ver&sion', FRA = 'Ver&sion';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
    }

    var
        PurchaseHeaderAdditionalArch: Record "Purchase Header Arch Addit FND";
        PurchaseHeaderArchiveAdditional: Record "Purchase Header Arch Addit FND";
        LimitPO: Boolean;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    trigger OnAfterGetRecord();
    begin
        //HEI.02>>
        //IF PurchaseHeaderAdditionalArch.GET("Document Type","No.") THEN;  //HEI.05
        //HEI.02<<
        //HEI.05>>
        LimitPO := false;
        PurchaseHeaderAdditionalArch.RESET();
        PurchaseHeaderAdditionalArch.SETRANGE("Document Type", Rec."Document Type");
        PurchaseHeaderAdditionalArch.SETRANGE("No.", Rec."No.");
        PurchaseHeaderAdditionalArch.SETRANGE("Limit PO", true);
        if PurchaseHeaderAdditionalArch.FINDFIRST() then
            LimitPO := PurchaseHeaderAdditionalArch."Limit PO";
        //HEI.05<<

    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

