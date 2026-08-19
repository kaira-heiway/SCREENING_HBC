pageextension 51048 ServiceMgtSetupExtCBN extends "Service Mgt. Setup"
{
    // version NAVW110.0,FINXL7.00,DITW110.00.08,HEI.01
    // DITW16.00.00.42 DDR 11/02/2013 DIT-715 #523 Added field "Use Contract Close Reason" (Contracts tab)

    // FINXL7.00.001 RBE 20/03/2013 : Created new group application and added field^ "Use OGM" and "Print OGM" on group

    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-RW-GAPLOG02 IBM NASTAA02 10.09.2018 # Delivery Note
    //   # Added Fields: "CTS Technician Property Code" and "CTS Document Subtype"
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("First Warning Within (Hours)")
        {
            ToolTipML = ENU = 'Specifies the number of hours before the response time that the program sends the first warning about the response time approaching for a service order.', FRA = 'Spécifie le nombre d''heures qui précèdent l''envoi de la première alerte indiquant que le délai de réponse pour la commande service est bientôt écoulé.';
        }
        modify("Send First Warning To")
        {
            ToolTipML = ENU = 'Specifies the email address that will be used to send the first warning about the response time for a service order that is approaching.', FRA = 'Spécifie l''adresse électronique qui est utilisée pour envoyer la première alerte indiquant que le délai de réponse pour la commande service est bientôt écoulé.';
        }
        modify("Second Warning Within (Hours)")
        {
            ToolTipML = ENU = 'Specifies the number of hours before the response time that the program sends the second warning about the response time approaching for a service order.', FRA = 'Spécifie le nombre d''heures qui précèdent l''envoi de la seconde alerte indiquant que le délai de réponse pour la commande service est bientôt écoulé.';
        }
        modify("Send Second Warning To")
        {
            ToolTipML = ENU = 'Specifies the email address that will be used to send the second warning about the response time for a service order that is approaching.', FRA = 'Spécifie l''adresse électronique qui est utilisée pour envoyer la seconde alerte indiquant que le délai de réponse pour la commande service qui arrive.';
        }
        modify("Third Warning Within (Hours)")
        {
            ToolTipML = ENU = 'Specifies the number of hours before the response time that the program sends the third warning about the response time approaching for a service order.', FRA = 'Spécifie le nombre d''heures qui précèdent l''envoi de la troisième alerte indiquant que le délai de réponse pour la commande service est bientôt écoulé.';
        }
        modify("Send Third Warning To")
        {
            ToolTipML = ENU = 'Specifies the email address that will be used to send the third warning about the response time for a service order that is approaching.', FRA = 'Spécifie l''adresse électronique qui est utilisée pour envoyer la troisième alerte indiquant que le délai de réponse pour la commande service qui arrive.';
        }
        modify("Serv. Job Responsibility Code")
        {
            ToolTipML = ENU = 'Specifies the code of the job responsibility designated for the service management application area.', FRA = 'Spécifie le code de la responsabilité que vous avez désignée pour le domaine d''application Gestion des services.';
        }
        modify("Next Service Calc. Method")
        {
            ToolTipML = ENU = 'Specifies how you want the program to recalculate the next planned service date for service items in service contracts.', FRA = 'Spécifie la méthode avec laquelle le programme recalcule la date du prochain service prévu pour les articles de service dans les contrats de service.';
        }
        modify("Service Order Starting Fee")
        {
            ToolTipML = ENU = 'Specifies the code for a service order starting fee.', FRA = 'Spécifie le code pour les frais forfaitaires d''une commande service.';
        }
        modify("Shipment on Invoice")
        {
            ToolTipML = ENU = 'Specifies that if you post a manually-created invoice, this will create a posted shipment, in addition to a posted invoice.', FRA = 'Indique que si vous validez une facture créée manuellement, cela crée une expédition validée, en plus d''une facture validée.';
        }
        modify("One Service Item Line/Order")
        {
            ToolTipML = ENU = 'Specifies that you can enter only one service item line for each service order.', FRA = 'Indique que vous pouvez saisir une seule ligne article de service pour chaque commande service.';
        }
        modify("Link Service to Service Item")
        {
            ToolTipML = ENU = 'Specifies that service lines for resources and items must be linked to a service item line.', FRA = 'Indique que les lignes service des ressources et des articles doivent être liées à une ligne article de service.';
        }
        modify("Resource Skills Option")
        {
            ToolTipML = ENU = 'Specifies how to identify resource skills in your company when you allocate resources to service items.', FRA = 'Spécifie comment identifier les compétences ressource dans votre société lorsque vous affectez des ressources aux articles de service.';
        }
        modify("Service Zones Option")
        {
            ToolTipML = ENU = 'Specifies how to identify service zones in your company when you allocate resources to service items.', FRA = 'Spécifie comment identifier les zones service dans votre société lorsque vous affectez des ressources aux articles de service.';
        }
        modify("Fault Reporting Level")
        {
            ToolTipML = ENU = 'Specifies the level of fault reporting that your company uses in the Service Management application area.', FRA = 'Spécifie le niveau de reporting panne utilisé par votre société dans le domaine d''application Gestion des services.';
        }
        modify("Base Calendar Code")
        {
            ToolTipML = ENU = 'Specifies the code for the base calendar you want to assign to your service department.', FRA = 'Spécifie le code du calendrier principal que vous souhaitez affecter à votre département service.';
        }
        modify("Copy Comments Order to Invoice")
        {
            ToolTipML = ENU = 'Specifies whether to copy comments from service orders to service invoices.', FRA = 'Spécifie s''il faut copier les commentaires de commandes service vers des factures service.';
        }
        modify("Copy Comments Order to Shpt.")
        {
            ToolTipML = ENU = 'Specifies whether to copy comments from service orders to shipments.', FRA = 'Spécifie s''il faut copier les commentaires de commandes service vers des expéditions.';
        }
        modify("Logo Position on Documents")
        {
            ToolTipML = ENU = 'Specifies the position of your company logo on your business letters and documents, such as service invoices and service shipments.', FRA = 'Spécifie l''emplacement du logo de votre entreprise sur vos courriers et documents professionnels, tels que les factures service et les expéditions service.';
        }
        modify("Mandatory Fields")
        {
            CaptionML = ENU = 'Mandatory Fields', FRA = 'Champs obligatoires';
        }
        modify("Service Order Type Mandatory")
        {
            ToolTipML = ENU = 'Specifies that a service order must have a service order type assigned before the order can be posted.', FRA = 'Spécifie qu''une commande service doit être affectée à une commande service avant de pouvoir la valider.';
        }
        modify("Service Order Start Mandatory")
        {
            ToolTipML = ENU = 'Specifies that the Starting Date and Starting Time fields on a service order must be filled in before you can post the service order.', FRA = 'Spécifie que les champs Date début et Heure début d''une commande service doivent être renseignés pour pouvoir valider la commande service.';
        }
        modify("Service Order Finish Mandatory")
        {
            ToolTipML = ENU = 'Specifies that the Finishing Date and Finishing Time fields on a service order must be filled in before you can post the service order.', FRA = 'Spécifie que les champs Date fin et Heure fin d''une commande service doivent être renseignés pour pouvoir valider la commande service.';
        }
        modify("Contract Rsp. Time Mandatory")
        {
            ToolTipML = ENU = 'Specifies that the Response Time (Hours) field must be filled on service contract lines before you can convert a quote to a contract.', FRA = 'Indique que vous devez renseigner le champ Délai de réponse (heures) sur les lignes du contrat de service avant de convertir un devis contrat en contrat.';
        }
        modify("Unit of Measure Mandatory")
        {
            ToolTipML = ENU = 'Specifies that the Description field must be filled in before you can post the line.', FRA = 'Indique que le champ Description d''une ligne de service doit être renseigné avant de pouvoir valider la ligne.';
        }
        modify("Fault Reason Code Mandatory")
        {
            ToolTipML = ENU = 'Specifies that the Fault Reason Code field must be filled in before you can post the service order.', FRA = 'Indique que le champ Code motif panne d''une ligne de service doit être renseigné avant de pouvoir valider la commande service.';
        }
        modify("Work Type Code Mandatory")
        {
            ToolTipML = ENU = 'Specifies that the Work Type Code field with type Resource must be filled in before you can post the line.', FRA = 'Indique que le champ Code type travail d''une ligne service de type Ressource doit être renseigné avant de pouvoir valider la ligne.';
        }
        modify("Salesperson Mandatory")
        {
            ToolTipML = ENU = 'Specifies that you must fill in the Salesperson Code field on the headers of service orders, invoices, credit memos, and service contracts.', FRA = 'Spécifie que vous devez renseigner le champ Code vendeur dans les en-têtes des commandes, factures et avoirs service, ainsi que les contrats de service.';
        }
        modify(Defaults)
        {
            CaptionML = ENU = 'Defaults', FRA = 'Valeurs par défaut';
        }
        modify("Default Response Time (Hours)")
        {
            ToolTipML = ENU = 'Specifies the default response time, in hours, required to start service, either on a service order or on a service item line.', FRA = 'Spécifie le délai de réponse par défaut, en heures, requis pour commencer le service sur une commande service ou sur une ligne article de service.';
        }
        modify("Warranty Disc. % (Parts)")
        {
            ToolTipML = ENU = 'Specifies the default warranty discount percentage on spare parts.', FRA = 'Spécifie le taux de remise garantie par défaut appliqué aux pièces de rechange.';
        }
        modify("Warranty Disc. % (Labor)")
        {
            ToolTipML = ENU = 'Specifies the default warranty discount percentage on labor.', FRA = 'Spécifie le taux de remise garantie par défaut appliqué à la main d''ouvre.';
        }
        modify("Default Warranty Duration")
        {
            ToolTipML = ENU = 'Specifies the default duration for warranty discounts on service items.', FRA = 'Spécifie la durée par défaut des remises garantie des articles de service.';
        }
        modify(Contracts)
        {
            CaptionML = ENU = 'Contracts', FRA = 'Contrats';
        }
        modify("Contract Serv. Ord.  Max. Days")
        {
            ToolTipML = ENU = 'Specifies the maximum number of days you can use as the date range each time you run the Create Contract Service Orders batch job.', FRA = 'Spécifie le nombre maximal de jours que vous pouvez utiliser comme plage de dates à chaque exécution du traitement par lots Créer cdes contrat service.';
        }
        modify("Use Contract Cancel Reason")
        {
            ToolTipML = ENU = 'Specifies that a reason code is entered when you cancel a service contract.', FRA = 'Spécifie qu''un code motif est entré lorsque vous annulez un contrat de service.';
        }
        modify("Register Contract Changes")
        {
            ToolTipML = ENU = 'Specifies that you want the program to log changes to service contracts in the Contract Change Log table.', FRA = 'Spécifie que vous souhaitez que le programme enregistre les modifications apportées aux contrats de service dans la table Journal modification contrat.';
        }
        modify("Contract Inv. Line Text Code")
        {
            ToolTipML = ENU = 'Specifies the code for the standard text entered in the Description field on the line in a contract invoice.', FRA = 'Spécifie le code du texte standard saisi dans le champ Description de la ligne dans une facture contrat.';
        }
        modify("Contract Line Inv. Text Code")
        {
            ToolTipML = ENU = 'Specifies the code for the standard text entered in the Description field on the line in a contract invoice.', FRA = 'Spécifie le code du texte standard saisi dans le champ Description de la ligne dans une facture contrat.';
        }
        modify("Contract Inv. Period Text Code")
        {
            ToolTipML = ENU = 'Specifies the code for the standard text entered in the Description field on the line in a contract invoice.', FRA = 'Spécifie le code du texte standard saisi dans le champ Description de la ligne dans une facture contrat.';
        }
        modify("Contract Credit Line Text Code")
        {
            ToolTipML = ENU = 'Specifies the code for the standard text that entered in the Description field on the line in a contract credit memo.', FRA = 'Spécifie le code du texte standard saisi dans le champ Description de la ligne dans un avoir contrat.';
        }
        modify("Contract Value Calc. Method")
        {
            ToolTipML = ENU = 'Specifies the method to use for calculating the default contract value of service items when they are created.', FRA = 'Spécifie la méthode que le programme doit utiliser pour calculer la valeur contrat par défaut des articles de service lorsqu''ils sont créés.';
        }
        modify("Contract Value %")
        {
            ToolTipML = ENU = 'Specifies the percentage used to calculate the default contract value of a service item when it is created.', FRA = 'Spécifie le taux utilisé pour calculer la valeur contrat par défaut d''un article service lors de sa création.';
        }
        modify(Numbering)
        {
            CaptionML = ENU = 'Numbering', FRA = 'Numérotation';
        }
        modify("Service Item Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code that will be used to assign numbers to service items.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée pour affecter des numéros aux articles de service.';
        }
        modify("Service Quote Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series for the service quotes.', FRA = 'Spécifie la souche de numéros des devis service.';
        }
        modify("Service Order Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code that will be used to assign numbers to service orders.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée pour affecter des numéros aux commandes service.';
        }
        modify("Service Invoice Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code that will be used to assign numbers to invoices.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée pour affecter des numéros aux factures.';
        }
        modify("Service Credit Memo Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code used to assign numbers to service credit memos.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée pour affecter des numéros aux avoirs service.';
        }
        modify("Posted Service Shipment Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code that will be used to assign numbers to shipments when they are posted.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée pour affecter des numéros aux livraisons validées.';
        }
        modify("Loaner Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code that will be used to assign numbers to loaners.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée pour affecter des numéros aux articles de prêt.';
        }
        modify("Troubleshooting Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code that will be used to assign numbers to troubleshooting guidelines.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée pour affecter des numéros aux instructions incident.';
        }
        modify("Service Contract Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code that will be used to assign numbers to service contracts.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée pour affecter des numéros aux contrats service.';
        }
        modify("Contract Template Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code that will be used to assign numbers to contract templates.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée pour affecter des numéros aux modèles contrat.';
        }
        modify("Contract Invoice Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code that will be used to assign numbers to invoices created for service contracts.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée pour affecter des numéros aux factures créées pour les contrats service.';
        }
        modify("Contract Credit Memo Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code that will be used to assign numbers to credit memos for service contracts.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée pour affecter des numéros aux avoirs pour les contrats service.';
        }
        addafter("Copy Time Sheet to Order")
        {
            field("CTS Technician Property Code"; Rec."CTS Technician Prpty. Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CTS Technician Property Code field.';
            }
            field("CTS Document Subtype"; Rec."CTS Document Subtype FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CTS Document Subtype field.';
            }
        }
        // addafter("Use Contract Cancel Reason")
        // {
        //     field("Use Contract Close Reason"; Rec."Use Contract Close Reason")
        //     {
        //         Description = 'DIT-715 #523';
        //     }
        // }  // BC Upgrade NANDIS03
        // addafter(Numbering)
        // {
        //     group(Application)
        //     {
        //         CaptionML = ENU = 'Application',
        //                     FRA = 'Lettrage';
        //         Description = 'FINXL7.00.001';
        //         field("Use OGM"; "Use OGM")
        //         {
        //             Description = 'FINXL7.00.001';
        //         }
        //         field("Print OGM"; "Print OGM")
        //         {
        //             Description = 'FINXL7.00.001';
        //         }
        //     }
        // }  // BC Upgrade NANDIS03
    }


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RESET;
    IF NOT GET THEN BEGIN
      INIT;
      INSERT;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    RESET;
    if not GET then begin
      INIT;
      INSERT;
    end;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

