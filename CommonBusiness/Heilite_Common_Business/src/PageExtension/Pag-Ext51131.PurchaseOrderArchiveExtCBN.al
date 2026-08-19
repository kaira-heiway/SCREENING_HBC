pageextension 51131 PurchaseOrderArchiveExtCBN extends "Purchase Order Archive"
{
    // version NAVW110.0,DITW110.00.08,HEI.01
    // HEI.01 FDD PTPGAP081 IBM POSTOI01 08.05.2018
    //   # New page action :
    //      new group: Document
    //      new actions: Receipts
    // HEI.03 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # Created new Page Action "Purchase Additional"
    // HEI.04 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # New Field added: "Fixed Asset Acquisition"
    // HEI.05  CHG2024557 FDD-HT821 IBM SHANKJ03 10.02.2020
    //   # New Field added : maximo status
    // HEI.06 CHG2048419 FDD-HB1138 IBM SHANKJ03 01.10.2020
    //   # added Field MailSent & Mailsentdatetime
    // HEI.07 CHG2083064 IBM.GUNERE01  21.10.2020 # Mail Sent, Mail sent date time fields set to editable false
    // HEI.08 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New field added in General tab: LSR Order No
    //   # code added in OnAfterGetRecord()
    // HEI.09 FDD-HB1195 CHG2070051 IBM GUNERE01 04.02.2021 # Import Identifier field added
    // HEI.10 CHG2098629 HB2014 IBM NANDIS01 08.04.2021 - LOG_Automatic creation of Transfer Order for Import PO
    //   # Shown field - "TO Reference" from Purchase Header Additional table
    // HEI.11 CHG2121745 IBM BHATTA09 23.08.2021
    //   # New Group SRM created
    //   # New Field added - Shopping Card Creation Date
    //   # Shopping Card No. field added
    //   # Requestor ID field added
    //   # Code Added in OnAfterGetRecord
    // HEI.12 CHG2137782 HB2685 IBM MAJUMS03 23.12.2021 # Add Field "PO Reference" in Archives PO
    //   # New Field added - "Your Reference" (Under General Tab)
    //******************************************************************************************************
    //BC UPGRADE PATHAA02 07.11.25-Done
    //1. DIT Fields commented
    //2. Page Properties-Delete Allowed and Editable added    
    //SRM, Maximo, LSR Interface Fields found,need to put in STP Ext.
    //***************************************************************
    // BC Upgrade SHUKLP03 >> Added in interface the ext.
    // SRM, Maximo, LSR Interface Fields found,need to put in STP Ext.
    // BC Upgrade SHUKLP03 << Added in interface the ext.
    // BC Upgrade - RD03 New Action Added to open the attached attachments

    DeleteAllowed = false;//BC UPGRADE 
    Editable = false;//BC UPGRADE

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }

        //Unsupported feature: Change ImplicitType on ""Buy-from Address"(Control 8)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Buy-from Address 2"(Control 10)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Buy-from City"(Control 122)". Please convert manually.

        modify(Invoicing)
        {
            CaptionML = ENU = 'Invoicing', FRA = 'Facturation';
        }

        //Unsupported feature: Change ImplicitType on ""Pay-to Address"(Control 40)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Pay-to Address 2"(Control 42)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Pay-to City"(Control 124)". Please convert manually.

        modify(Shipping)
        {
            CaptionML = ENU = 'Shipping', FRA = 'Livraison';
        }
        // BC Upgrade BHARDA11 >> --FDD STP 004
        addbefore(Status)
        {
            field("Creation Date/Time IBM"; Rec."Creation Date/Time IBM FND")
            {
                ApplicationArea = All;
            }
            field("Created By IBM"; Rec."Created By IBM FND")
            {
                ApplicationArea = All;
            }

            // BC Upgrade BHARAD11 << --FDD STP 004

            //Unsupported feature: Change ImplicitType on ""Ship-to Address"(Control 66)". Please convert manually.


            //Unsupported feature: Change ImplicitType on ""Ship-to Address 2"(Control 68)". Please convert manually.


            //Unsupported feature: Change ImplicitType on ""Ship-to City"(Control 126)". Please convert manually.
        }
        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade', FRA = 'International';
        }
        modify(Version)
        {
            CaptionML = ENU = 'Version', FRA = 'Version';
        }
        addafter("Document Date")
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Your Reference field.';
            }
        }
        //BC UPGRADE PATHAA02 DIT>>
        // addafter("Responsibility Center")
        // {
        //     field("Creation Date/Time"; Rec."Creation Date/Time")
        //     {
        //         Description = 'DITW18.00.07 DIT-770 #1282';
        //         Importance = Additional;
        //     }
        //     field("Created By"; Rec."Created By")
        //     {
        //         Description = 'DITW18.00.07 DIT-770 #1282';
        //         Importance = Additional;
        //     }
        // }
        //BC UPGRADE PATHAA02 DIT<<
        addafter(Status)
        {
            field("Fixed Asset Acquisition"; Rec."Fixed Asset Acquisition FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Fixed Asset Acquisition field.';
            }
            // BC Upgrade BHARDA11 >> -- FDD STP 004
            field("Requester ID IBM"; Rec."Requester ID IBM FND")
            {
                ApplicationArea = All;
            }
            // BC Upgrade BHARDA11 << -- FDD STP 004
            // BC Upgrade SHUKLP03 >> Added in interface ext.
            //field("Maximo Status"; Rec."Maximo Status")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Maximo Status field.';
            // }
            // BC Upgrade SHUKLP03 << Added in interface ext.
            // field("Requester ID"; Rec."Requester ID")
            // {
            // } //BC UPGRADE PATHAA02-DIT
            field("Mail Sent"; PurchaseHeaderAdditional."Mail Sent")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Mail Sent field.';
            }
            field("Mail Sent Date Time"; PurchaseHeaderAdditional."Mail Sent Date Time")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Mail Sent Date Time field.';
            }
            // BC Upgrade SHUKLP03 >> Added in interface ext.
            // field("LSR Order No."; PurchaseHeaderAdditional."LSR Order No")
            // {
            // }
            // BC Upgrade SHUKLP03 >> Added in interface ext.
            field("TO Reference"; PurchaseHeaderAdditional."TO Reference")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TO Reference field.';
            }
        }
        addafter("Ship-to Code")
        {
            field("PurchaseHeaderAdditional.""Import Identifier"""; PurchaseHeaderAdditional."Import Identifier")
            {
                Caption = 'Import Identifier';
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Import Identifier field.';
            }
        }
        // BC Upgrade SHUKLP03 >> Added in interface ext.
        // addafter(Version)
        // {
        //     group(SRM)
        //     {
        //         Caption = 'SRM';
        //         field("Shopping Card No."; Rec."Shopping Card No.")
        //         {
        //             ApplicationArea = All;  // BC Upgrade SHUKLP03 <<

        //         }
        //         field("Shopping Card Creation Date"; PurchaseHeaderArchiveAdditional."Shopping Card Creation Date")
        //         {
        //             ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
        //         }
        //     }
        // }
        // BC Upgrade SHUKLP03 << Added in interface ext.
    }
    actions
    {
        modify("Ver&sion")
        {
            CaptionML = ENU = 'Ver&sion', FRA = 'Ver&sion';
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card', FRA = 'Fiche';
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
        modify(Print)
        {
            CaptionML = ENU = 'Print', FRA = 'Imprimer';
        }
        addafter(Print)
        {
            //HEI.03>>
            action("Purchase Additional")
            {
                Caption = 'Purchase Additional';
                Image = Purchase;
                RunObject = Page "Purch Order Archive Add CBN";
                RunPageLink = "Document Type" = FIELD("Document Type"),
                              "No." = FIELD("No.");
                ApplicationArea = All;
                ToolTip = 'Executes the Purchase Additional action.';
            }
            // BC Upgrade - RD03 New Action Added to open the attached attachments
            action(Attachments)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                ToolTip = 'Opens the attachments associated with the document.';
                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
            // BC Upgrade - RD03 New Action Added to open the attached attachments
            //HEI.03<<

            //HEI.01>>
            group(Documents)
            {
                CaptionML = ENU = 'Documents',
                            FRA = 'Documents';
                Image = Documents;
                action(Receipts)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Receipts',
                                FRA = 'Bons de réception';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = sorting("Order No.");
                    ToolTip = 'Executes the Receipts action.';
                }
            }
            //HEI.01<<
        }
    }

    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchaseHeaderArchiveAdditional: Record "Purchase Header Arch Addit FND";


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    trigger OnAfterGetRecord();
    begin
        //HEI.06 >>
        PurchaseHeaderAdditional.RESET();
        PurchaseHeaderAdditional.SETRANGE("No.", Rec."No.");
        if PurchaseHeaderAdditional.FINDFIRST() then;
        //HEI. 06 <<
        //>>HEI.11
        PurchaseHeaderArchiveAdditional.RESET();
        PurchaseHeaderArchiveAdditional.SETRANGE("Document Type", Rec."Document Type");
        PurchaseHeaderArchiveAdditional.SETRANGE("No.", Rec."No.");
        PurchaseHeaderArchiveAdditional.SETRANGE("Doc. No. Occurrence", Rec."Doc. No. Occurrence");
        PurchaseHeaderArchiveAdditional.SETRANGE("Version No.", Rec."Version No.");
        if PurchaseHeaderArchiveAdditional.FINDFIRST() then;
        //<<HEI.11    
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

