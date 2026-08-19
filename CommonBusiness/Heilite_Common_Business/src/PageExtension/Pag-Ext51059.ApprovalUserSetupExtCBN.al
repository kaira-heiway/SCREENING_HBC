pageextension 51059 ApprovalUserSetupExtCBN extends "Approval User Setup"
{

    //     DITW15.00.00.33 DDR 07/05/2009 Added columns
    //                                  "Max. Credit Limit Customer","Exceed Credit Limit Customer","Unlimited Cr. Limit Customer"
    // DITW15.00.00.34 DDR 02/06/2009 Added columns
    //                                  "Sales Amt. Delayed Disc. Limit","Unlimited Sales Delayed Disc.",
    //                                  "Sales Amt. Delayed Promo Limit","Unlimited Sales Delayed Promo",
    //                                  "Cost Amt. Delayed Promo Limit","Unlimited Cost Delayed Promo"
    //                                  "Delayed Approver ID","Delayed Substitute",
    //                     09/06/2009 Added columns
    //                                  "Purch. Amt. Delayed Disc. Lmt.","Unlimited Purch. Delayed Disc."
    //                                  "Purch. Amt. Delayed Promo Lmt.","Unlimited Purch. Delayed Promo"
    //                                  "P.Cost Amt. Delayed Promo Lmt.","Unlimited P.Cost Delayed Promo"
    // DITW15.00.00.35 DDR 19/08/2009 Added columns
    //                                  "Credit Limit Approver ID"
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0010.1
    //                             extended approval
    // DITW18.00.06 MVN 22/09/2015 DIT-770 #1524 Added Fields 2013610 Max. Deposit Limit Customer
    //                                                        2013611 Exceed Deposit Limit Customer
    //                                                        2013612 Unlimited Deposit Limit Cust.
    //                                                        2013613 Deposit Limit Approver ID
    //                                                        2013614 Deposit Substitute
    // DITW18.00.06 MVN 29/09/2015 DIT-770 #1593 Added Field 2014431 Overdue Grace Period (DateFormula)
    // DITW18.00.06A DDR 23/11/2015 DIT-770 #1714 Added fields 2014432 Overdue Approver ID
    //                                                         2014433 Overdue Substitute
    //                                                         2014434 Overdue Amount Approval Limit
    //                                                         2014435 Unlimited Overdue Approval

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.10 AKH 12/07/2017 NRQ#16506 Set Visible, Enabled & Editable properties to FALSE for field "Dimension Filter"
    //                                        (part of the old DIT purchase approval flow, not used for the moment)
    //                                        Disabled related code
    // DITW110.00.11 MSF 28/12/2017 NRQ#9570 Delete field Overdue Amount Approval Limit
    // HEI.01 FDD-IC-PRODGAP BRD HT417 IBM ISYED01 04/10/2019 # PO IC Layout
    //   # New Field created: Procurement Service Manager
    // DITW111.00.13 MSF 03/09/2018 NRQ#55906 Sales Approval Workflow for Overdue and deposit limit
    //                                        Disable Unused Fields

    // BC Upgrade MISHRS14 >>
    // HEI.02 CHG2336029 SS40 17.03.2026 # Workflow Approval Functionality for Stock Adjustments
    // # Added New Field: Unlimited Journal Approval
    // # Added New Field: Journal Amount Approval Limit
    // BC Upgrade MISHRS14 <<


    layout
    {

        modify("User ID")
        {
            ToolTipML = ENU = 'Specifies a user ID.', FRA = 'Spécifie un code utilisateur.';
        }
        modify("Salespers./Purch. Code")
        {
            ToolTipML = ENU = 'Specifies the salesperson or purchaser code that relates to the User ID field.', FRA = 'Spécifie le code vendeur ou acheteur lié au champ Code utilisateur.';
        }
        modify("Approver ID")
        {
            ToolTipML = ENU = 'Specifies the user ID of the person who must approve records that are made by the user in the User ID field before the record can be released.', FRA = 'Spécifie le code utilisateur de la personne qui doit approuver des enregistrements réalisés par l''utilisateur mentionné dans le champ Code utilisateur avant de pouvoir publier les enregistrements.';
        }
        modify("Sales Amount Approval Limit")
        {
            ToolTipML = ENU = 'Specifies the maximum amount in LCY that this user is allowed to approve for this record.', FRA = 'Spécifie le montant maximal (en DS) que cet utilisateur peut approuver pour cet enregistrement.';
        }
        modify("Unlimited Sales Approval")
        {
            ToolTipML = ENU = 'Specifies that the user on this line is allowed to approve sales records with no maximum amount. If you select this check box, then you cannot fill the Sales Amount Approval Limit field.', FRA = 'Indique que l''utilisateur sur cette ligne peut approuver des enregistrements vente sans montant maximal. Si vous activez cette case à cocher, vous ne pouvez pas renseigner le champ Montant maximal vente autorisé.';
        }
        modify("Purchase Amount Approval Limit")
        {
            ToolTipML = ENU = 'Specifies the maximum amount in LCY that this user is allowed to approve for this record.', FRA = 'Spécifie le montant maximal (en DS) que cet utilisateur peut approuver pour cet enregistrement.';
        }
        modify("Unlimited Purchase Approval")
        {
            ToolTipML = ENU = 'Specifies that the user on this line is allowed to approve purchase records with no maximum amount. If you select this check box, then you cannot fill the Purchase Amount Approval Limit field.', FRA = 'Indique que l''utilisateur sur cette ligne peut approuver des enregistrements achat sans montant maximal. Si vous activez cette case à cocher, vous ne pouvez pas renseigner le champ Montant maximal achat autorisé.';
        }
        modify("Request Amount Approval Limit")
        {
            ToolTipML = ENU = 'Specifies the maximum amount in LCY that this user is allowed to approve for this record.', FRA = 'Spécifie le montant maximal (en DS) que cet utilisateur peut approuver pour cet enregistrement.';
        }
        modify("Unlimited Request Approval")
        {
            ToolTipML = ENU = 'Specifies that the user on this line can approve all purchase quotes regardless of their amount. If you select this check box, then you cannot fill the Request Amount Approval Limit field.', FRA = 'Indique que l''utilisateur sur cette ligne peut approuver toutes les demandes de prix, quel que soit leur montant. Si vous activez cette case à cocher, vous ne pouvez pas renseigner le champ Montant maximal demande achat autorisé.';
        }
        modify(Substitute)
        {
            ToolTipML = ENU = 'Specifies the User ID of the user who acts as a substitute for the original approver.', FRA = 'Spécifie le code de l''utilisateur qui fait office de remplaçant de l''approbateur.';
        }
        modify("E-Mail")
        {
            ToolTipML = ENU = 'Specifies the email address of the approver that you can use if you want to send approval mail notifications.', FRA = 'Spécifie l''adresse e-mail de l''approbateur à utiliser si vous voulez envoyer des notifications d''approbation par e-mail.';
        }
        modify("Approval Administrator")
        {
            ToolTipML = ENU = 'Specifies the user who has rights to unblock approval workflows, for example, by delegating approval requests to new substitute approvers and deleting overdue approval requests.', FRA = 'Spécifie l''utilisateur qui dispose des droits nécessaires pour déverrouiller les flux de travail approbation, par exemple en délégant des demandes d''approbation à de nouveaux approbateurs remplaçants et en supprimant des demandes d''approbations échues.';
        }
        //---BC Upgrade KAMNAY01>> 
        // addafter("Unlimited Purchase Approval")
        // {

        // field("Product Posting Group Filter";"Product Posting Group Filter")
        // {

        //     trigger OnLookup(Text : Text) : Boolean;
        //     var
        //         Lrec_GProdGr : Record "Gen. Product Posting Group";
        //     begin
        //         //<<DITW17.00.02 TEC1 10/09/2013 DIT-770 #144
        //         Lrec_GProdGr.RESET;
        //         if PAGE.RUNMODAL(PAGE::"Gen. Product Posting Groups",Lrec_GProdGr) = ACTION::LookupOK then
        //           begin;
        //           Text := Text + Lrec_GProdGr.Code;
        //           "Product Posting Group Filter" := Text;
        //           exit(true);
        //         end;
        //         //>>DITW17.00.02 TEC1 DIT-770 #144
        //     end;
        // }

        //     field("Dimension Fiter";"Dimension Fiter")
        //     {
        //         Description = 'DITW17.00.02 DIT-770 #144 - DITW110.00.10 NRQ#16506';
        //         Editable = false;
        //         Enabled = false;
        //         Visible = false;

        //         trigger OnDrillDown();
        //         var
        //             Lrec_UserDimFilter : Record "User Dimension Filter";
        //         begin
        //             //<<DITW17.00.02 TEC1 10/09/2013 DIT-770 #144 - DITW110.00.10 AKH 12/07/2017 NRQ#16506
        //             //Lrec_UserDimFilter.RESET;
        //             //Lrec_UserDimFilter.SETRANGE("User ID","User ID");
        //             //PAGE.RUNMODAL(PAGE::"User Dimension Filter",Lrec_UserDimFilter);
        //             //CALCFIELDS("Dimension Fiter");
        //         end;
        //     }
        //     field("Location Filter";"Location Filter")
        //     {

        //         trigger OnLookup(Text : Text) : Boolean;
        //         var
        //             lrec_location : Record Location;
        //         begin
        //             //<<DITW17.00.02 TEC1 10/09/2013 DIT-770 #144
        //             if PAGE.RUNMODAL(PAGE::"Location List",lrec_location) = ACTION::LookupOK then
        //               begin
        //               Text := Text + lrec_location.Code;
        //               "Location Filter" := Text;
        //               exit(true);
        //             end;

        //             //>>DITW17.00.02 TEC1 DIT-770 #144
        //         end;
        //     }
        // }
        //---BC Upgrade KAMNAY01<<

        addafter("Approval Administrator")
        {
            //---BC Upgrade KAMNAY01>>
            // field("Credit Limit Approver ID";"Credit Limit Approver ID")
            // {
            // }
            // field("Max. Credit Limit Customer";"Max. Credit Limit Customer")
            // {
            // }
            // field("Exceed Credit Limit Customer";"Exceed Credit Limit Customer")
            // {
            // }
            // field("Unlimited Cr. Limit Customer";"Unlimited Cr. Limit Customer")
            // {
            // }
            // field("Overdue Grace Period";"Overdue Grace Period")
            // {
            // }
            // field("Overdue Approver ID";"Overdue Approver ID")
            // {
            // }
            // field("Overdue Substitute";"Overdue Substitute")
            // {
            //     Description = '<DIT-770 #1714>-NRQ#55906';
            //     Enabled = false;
            // }
            // field("Unlimited Overdue Approval";"Unlimited Overdue Approval")
            // {
            // }
            // field("Deposit Limit Approver ID";"Deposit Limit Approver ID")
            // {
            // }
            // field("Max. Deposit Limit Customer";"Max. Deposit Limit Customer")
            // {
            // }
            // field("Exceed Deposit Limit Customer";"Exceed Deposit Limit Customer")
            // {
            // }
            // field("Unlimited Deposit Limit Cust.";"Unlimited Deposit Limit Cust.")
            // {
            // }
            // field("Deposit Substitute";"Deposit Substitute")
            // {
            //     Description = '<DIT-770 #1524>-NRQ#55906';
            //     Enabled = false;
            // }
            // field("Delayed Approver ID";"Delayed Approver ID")
            // {
            //     Description = '<DITW15.00.00.26>-NRQ#55906';
            //     Enabled = false;
            // }
            // field("Delayed Substitute";"Delayed Substitute")
            // {
            //     Description = '<DITW15.00.00.29>-NRQ#55906';
            //     Enabled = false;
            // }
            // field("Sales Amt. Delayed Disc. Limit";"Sales Amt. Delayed Disc. Limit")
            // {
            //     Description = '<DITW15.00.00.26>-NRQ#55906';
            //     Enabled = false;
            // }
            // field("Unlimited Sales Delayed Disc.";"Unlimited Sales Delayed Disc.")
            // {
            //     Description = '<DITW15.00.00.26>-NRQ#55906';
            //     Enabled = false;
            // }
            // field("Sales Amt. Delayed Promo Limit";"Sales Amt. Delayed Promo Limit")
            // {
            //     Description = '<DITW15.00.00.26>-NRQ#55906';
            //     Enabled = false;
            // }
            // field("Unlimited Sales Delayed Promo";"Unlimited Sales Delayed Promo")
            // {
            // }
            // field("Cost Amt. Delayed Promo Limit";"Cost Amt. Delayed Promo Limit")
            // {
            // }
            // field("Unlimited Cost Delayed Promo";"Unlimited Cost Delayed Promo")
            // {
            //     Description = '<DITW15.00.00.26>-NRQ#55906';
            //     Editable = false;
            // }
            // field("Purch. Amt. Delayed Disc. Lmt.";"Purch. Amt. Delayed Disc. Lmt.")
            // {
            //     Description = '<DITW15.00.00.34>-NRQ#55906';
            //     Enabled = false;
            // }
            // field("Unlimited Purch. Delayed Disc.";"Unlimited Purch. Delayed Disc.")
            // {
            //     Description = '<DITW15.00.00.34>-NRQ#55906';
            //     Enabled = false;
            // }
            // field("Purch. Amt. Delayed Promo Lmt.";"Purch. Amt. Delayed Promo Lmt.")
            // {
            //     Description = '<DITW15.00.00.34>-NRQ#55906';
            //     Enabled = false;
            // }
            // field("Unlimited Purch. Delayed Promo";"Unlimited Purch. Delayed Promo")
            // {
            //     Description = '<DITW15.00.00.34>-NRQ#55906';
            //     Enabled = false;
            // }
            // field("P.Cost Amt. Delayed Promo Lmt.";"P.Cost Amt. Delayed Promo Lmt.")
            // {
            //     Description = '<DITW15.00.00.34>-NRQ#55906';
            //     Enabled = false;
            // }
            // field("Unlimited P.Cost Delayed Promo";"Unlimited P.Cost Delayed Promo")
            // {
            //     Description = '<DITW15.00.00.34>-NRQ#55906';
            //     Enabled = false;
            // }
            //---BC Upgrade KAMNAY01<<
            field("Procurement Service Manager"; Rec."Procurement Serv Manager FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Procurement Service Manager field.';
            }
            
            // BC Upgrade MISHRS14 >>
            // Added 2 fields for HEI.02 Tag
            field("Unlimited Journal Approval"; Rec."Unlimited Journ.Approval FND")
            {
                ApplicationArea = All;
                Caption = 'Unlimited Journal Approval';
            }
            field("Journal Amount Approval Limit"; Rec."Journal Amt Approval Limit FND")
            {
                ApplicationArea = All;
                caption = 'Journal Amount Approval Limit';
            }
            // BC Upgrade MISHRS14 <<
        }
    }
    actions
    {
        modify("&Approval User Setup Test")
        {
            CaptionML = ENU = '&Approval User Setup Test', FRA = 'Test paramètres utilisateur &approbation';
            ToolTipML = ENU = 'Test the approval user setup, for example, to test if approvers are set up correctly.', FRA = 'Testez la configuration utilisateur d''approbation, par exemple, pour vérifier qu''elle a été correctement réalisée.';
        }
        modify("Notification Setup")
        {
            CaptionML = ENU = 'Notification Setup', FRA = 'Paramètres de notification';
            ToolTipML = ENU = 'Specify how the user receives notifications, for example about approval workflow steps.', FRA = 'Spécifiez comment l''utilisateur reçoit des notifications concernant, par exemple, les étapes de flux de travail approbation.';

            //Unsupported feature: Change RunPageLink on ""Notification Setup"(Action 5)". Please convert manually.

        }

    }


    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

