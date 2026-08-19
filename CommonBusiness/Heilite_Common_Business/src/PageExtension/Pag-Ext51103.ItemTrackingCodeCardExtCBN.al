pageextension 51103 ItemTrackingCodeCardExtCBN extends "Item Tracking Code Card"
{
    // DITW16.00.00.38 DDR 28/02/2011 DIT-715 #1 RTC Page functionnalities
    // DITW15.00.00.38 DDR (14/10/2010) issue 1139 SSCC Functionnalities
    //                                    Added "SSCC Lot Tracking" into 'Lot No.' tab
    // DITW16.00.00.40 DDR 21/03/2012 issue 1331 Added fields "Allow FEFO Trkg Blocked Lots"
    // DITW16.00.00.42 DDR 01/03/2013 DIT-715 #563 Added 'SSCC No.' tab
    //                                             Added fields
    //                                               "SSCC Purchase Inb. Tracking","SSCC Purchase Outb. Tracking"
    //                                               "SSCC Sales Inbound Tracking","SSCC Sales Outbound Tracking"
    //                                               "SSCC Pos. Adj. Inb. Tracking","SSCC Pos. Adj. Outb. Tracking"
    //                                               "SSCC Neg. Adj. Inb. Tracking","SSCC Neg. Adj. Outb. Tracking"
    //                                               "SSCC Manuf. Inbound Tracking","SSCC Manuf. Outbound Tracking"
    //                                               "SSCC Transfer Tracking","SSCC Warehouse Tracking"
    // DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    //                                             Bugfix Caption "SSCC No. Info. Must Exist" (SSCC Tab)
    //                                             Added fields "Check SSCC/Lot Qty. Balance"
    //                 DDR 05/11/2013 DIT-715 #813 Removed field "Check SSCC/Lot Qty. Balance"
    //                 DDR 06/11/2013 DIT-715 #801 Added fields "Use SSCC Avail. Inventory"
    //                 DDR 06/11/2013 DIT-715 #801 Added fields "Use SSCC Avail. Inventory"

    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    // DITW17.00.02 DDR 05/11/2013 DIT-715 #813 Merge
    // DITW17.00.02 DDR 06/11/2013 DIT-715 #801 Merge

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL11.01 MTR 13/09/2018 NRQ#24975 : Added field "Your Reference Required"

    // HEI.01 CHG2012342 IBM GAVANM01 19/11/2019 # "Your Reference Required" field visible property set to  FALSE
    // HEI.02 CHG2119725 IBM POENAB02 15.10.2021 HT2359 - Invoices with Fixes Assets
    //   # New field added in General group - "FA Related"


    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies the code of the record.', FRA = 'Spécifie le code de l''enregistrement.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the item tracking code.', FRA = 'Indique une description du code traçabilité.';
        }
        modify("Serial No.")
        {
            CaptionML = ENU = 'Serial No.', FRA = 'N° de série';
        }
        modify(Control64)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("SN Specific Tracking")
        {
            ToolTipML = ENU = 'Specifies that when handling an outbound unit of the item in question, you must always specify which existing serial number to handle.', FRA = 'Spécifie que vous devez toujours préciser le numéro de série à gérer lorsque vous traitez une unité sortante de l''article concerné.';
        }
        modify(Inbound)
        {
            CaptionML = ENU = 'Inbound', FRA = 'Enlogement';
        }
        modify("SN Info. Inbound Must Exist")
        {
            CaptionML = ENU = 'SN No. Info. Must Exist', FRA = 'Info. obligatoire';
            ToolTipML = ENU = 'Specifies that serial numbers on inbound document lines must have an information record in the Serial No. Information Card.', FRA = 'Spécifie que les numéros de série des lignes document entrant doivent être associés à un enregistrement information sur la fiche Information n° de série.';
        }
        modify("SN Purchase Inbound Tracking")
        {
            CaptionML = ENU = 'SN Purchase Tracking', FRA = 'Traçabilité achat';
            ToolTipML = ENU = 'Specifies that inbound purchase document lines require serial numbers.', FRA = 'Indique que vous devez saisir les numéros de série dans les lignes document achat entrant.';
        }
        modify("SN Sales Inbound Tracking")
        {
            CaptionML = ENU = 'SN Sales Tracking', FRA = 'Traçabilité vente';
            ToolTipML = ENU = 'Specifies that inbound sales document lines require serial numbers.', FRA = 'Indique que vous devez saisir les numéros de série dans les lignes document vente entrant.';
        }
        modify("SN Pos. Adjmt. Inb. Tracking")
        {
            CaptionML = ENU = 'SN Positive Adjmt. Tracking', FRA = 'Traçabilité ajust. pos.';
            ToolTipML = ENU = 'Specifies that inbound item journal lines of type positive entry require serial numbers.', FRA = 'Indique que vous devez saisir les numéros de série dans les lignes feuille article entrant de type écriture positive.';
        }
        modify("SN Neg. Adjmt. Inb. Tracking")
        {
            CaptionML = ENU = 'SN Negative Adjmt. Tracking', FRA = 'Traçabilité ajust. nég.';
            ToolTipML = ENU = 'Specifies that inbound item journal lines of type negative entry require serial numbers.', FRA = 'Indique que vous devez saisir les numéros de série dans les lignes feuille article entrant de type écriture négative.';
        }
        modify("SN Assembly Inbound Tracking")
        {
            CaptionML = ENU = 'SN Assembly Tracking', FRA = 'Suivi de l''assemblage NS';
            ToolTipML = ENU = 'Indicates that serial numbers are required with inbound posting from assembly orders.', FRA = 'Indique que les numéros de série sont nécessaires avec la validation d''enlogement à partir des ordres d''assemblage.';
        }
        modify("SN Manuf. Inbound Tracking")
        {
            CaptionML = ENU = 'SN Manufacturing Tracking', FRA = 'NS - Traçabilité production';
            ToolTipML = ENU = 'Specifies that serial numbers are required with inbound posting from production - typically output.', FRA = 'Spécifie que les numéros de série nécessitent une validation d''enlogement à partir de la production (en général la quantité produite).';
        }
        modify("SN Warehouse Tracking")
        {
            CaptionML = ENU = 'SN Warehouse Tracking', FRA = 'NS - Traçabilité entrepôt';
            ToolTipML = ENU = 'Specifies that warehouse document lines require serial numbers.', FRA = 'Indique que vous devez saisir les numéros de série dans les lignes document entrepôt.';
        }
        modify("SN Transfer Tracking")
        {
            CaptionML = ENU = 'SN Transfer Tracking', FRA = 'Traçabilité transfert';
            ToolTipML = ENU = 'Specifies that transfer order lines require serial numbers.', FRA = 'Indique que vous devez saisir les numéros de série dans les lignes ordre de transfert.';
        }
        modify(Outbound)
        {
            CaptionML = ENU = 'Outbound', FRA = 'Désenlogement';
        }
        modify("SN Info. Outbound Must Exist")
        {
            CaptionML = ENU = 'SN No. Info. Must Exist', FRA = 'Info. obligatoire';
            ToolTipML = ENU = 'Specifies that serial numbers on outbound document lines must have an information record in the Serial No. Information Card.', FRA = 'Spécifie que les numéros de série des lignes document sortant doivent être associés à un enregistrement information sur la fiche Information n° de série.';
        }
        modify("SN Purchase Outbound Tracking")
        {
            CaptionML = ENU = 'SN Purchase Tracking', FRA = 'Traçabilité achat';
            ToolTipML = ENU = 'Specifies that outbound purchase document lines require serial numbers.', FRA = 'Indique que vous devez saisir les numéros de série dans les lignes document achat sortant.';
        }
        modify("SN Sales Outbound Tracking")
        {
            CaptionML = ENU = 'SN Sales Tracking', FRA = 'Traçabilité vente';
            ToolTipML = ENU = 'Specifies that outbound sales document lines require serial numbers.', FRA = 'Indique que vous devez saisir les numéros de série dans les lignes document vente sortant.';
        }
        modify("SN Pos. Adjmt. Outb. Tracking")
        {
            CaptionML = ENU = 'SN Positive Adjmt. Tracking', FRA = 'Traçabilité ajust. pos.';
            ToolTipML = ENU = 'Specifies that outbound item journal lines of type positive entry require serial numbers.', FRA = 'Indique que vous devez saisir les numéros de série dans les lignes feuille article sortant de type écriture positive.';
        }
        modify("SN Neg. Adjmt. Outb. Tracking")
        {
            CaptionML = ENU = 'SN Negative Adjmt. Tracking', FRA = 'Traçabilité ajust. nég.';
            ToolTipML = ENU = 'Specifies that outbound item journal lines of type negative entry require serial numbers.', FRA = 'Indique que vous devez saisir les numéros de série dans les lignes feuille article sortant de type écriture négative.';
        }
        modify("SN Assembly Outbound Tracking")
        {
            CaptionML = ENU = 'SN Assembly Tracking', FRA = 'Suivi de l''assemblage NS';
            ToolTipML = ENU = 'Indicates that serial numbers are required with outbound posting from assembly orders.', FRA = 'Indique que les numéros de série sont nécessaires avec la validation de désenlogement à partir des ordres d''assemblage.';
        }
        modify("SN Manuf. Outbound Tracking")
        {
            CaptionML = ENU = 'SN Manufacturing Tracking', FRA = 'NS - Traçabilité production';
            ToolTipML = ENU = 'Specifies that serial numbers are required with outbound posting from production - typically consumption.', FRA = 'Spécifie que les numéros de série nécessitent une validation de désenlogement à partir de la production (en général la consommation).';
        }
        modify("Lot No.")
        {
            CaptionML = ENU = 'Lot No.', FRA = 'N° lot';
        }
        modify(Control74)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Lot Specific Tracking")
        {
            ToolTipML = ENU = 'Specifies that when handling an outbound unit, always specify which existing lot number to handle.', FRA = 'Spécifie que vous devez toujours préciser le numéro de lot à gérer lorsque vous traitez une unité sortante.';
        }
        modify(Control47)
        {
            CaptionML = ENU = 'Inbound', FRA = 'Enlogement';
        }
        modify("Lot Info. Inbound Must Exist")
        {
            CaptionML = ENU = 'Lot No. Info. Must Exist', FRA = 'Info. obligatoire';
            ToolTipML = ENU = 'Specifies that lot numbers on inbound document lines must have an information record in the Lot No. Information Card.', FRA = 'Spécifie que les numéros de lot des lignes document entrant doivent être associés à un enregistrement information sur la fiche Information n° de lot.';
        }
        modify("Lot Purchase Inbound Tracking")
        {
            CaptionML = ENU = 'Lot Purchase Tracking', FRA = 'Traçabilité achat';
            ToolTipML = ENU = 'Specifies that inbound purchase document lines require a lot number.', FRA = 'Indique que vous devez saisir les numéros de lot dans les lignes document achat entrant.';
        }
        modify("Lot Sales Inbound Tracking")
        {
            CaptionML = ENU = 'Lot Sales Tracking', FRA = 'Traçabilité vente';
            ToolTipML = ENU = 'Specifies that inbound sales document lines require a lot number.', FRA = 'Indique que vous devez saisir les numéros de lot dans les lignes document vente entrant.';
        }
        modify("Lot Pos. Adjmt. Inb. Tracking")
        {
            CaptionML = ENU = 'Lot Positive Adjmt. Tracking', FRA = 'Traçabilité ajust. pos.';
            ToolTipML = ENU = 'Specifies that inbound item journal lines of type positive entry require a lot number.', FRA = 'Indique que vous devez saisir les numéros de lot dans les lignes feuille article entrant de type écriture positive.';
        }
        modify("Lot Neg. Adjmt. Inb. Tracking")
        {
            CaptionML = ENU = 'Lot Negative Adjmt. Tracking', FRA = 'Traçabilité ajust. nég.';
            ToolTipML = ENU = 'Specifies that inbound item journal lines of type negative entry require a lot number.', FRA = 'Indique que vous devez saisir les numéros de lot dans les lignes feuille article entrant de type écriture négative.';
        }
        modify("Lot Assembly Inbound Tracking")
        {
            CaptionML = ENU = 'Lot Assembly Tracking', FRA = 'Suivi de l''assemblage de lot';
            ToolTipML = ENU = 'Indicates that lot numbers are required with inbound posting from assembly orders.', FRA = 'Indique que les numéros de lot sont nécessaires avec la validation d''enlogement à partir des ordres d''assemblage.';
        }
        modify("Lot Manuf. Inbound Tracking")
        {
            CaptionML = ENU = 'Lot Manufacturing Tracking', FRA = 'N° lot - Traçabilité prod.';
            ToolTipML = ENU = 'Specifies that lot numbers are required with outbound posting from production - typically output.', FRA = 'Spécifie que les numéros de lot nécessitent une validation de désenlogement à partir de la production (en général la quantité produite).';
        }
        modify("Lot Warehouse Tracking")
        {
            CaptionML = ENU = 'Lot Warehouse Tracking', FRA = 'N° lot - Traçabilité entrepôt';
            ToolTipML = ENU = 'Specifies that warehouse document lines require a lot number.', FRA = 'Indique que vous devez saisir les numéros de lot dans les lignes document entrepôt.';
        }
        modify("Lot Transfer Tracking")
        {
            CaptionML = ENU = 'Lot Transfer Tracking', FRA = 'Traçabilité transfert';
            ToolTipML = ENU = 'Specifies that transfer order lines require a lot number.', FRA = 'Indique que vous devez saisir un numéro de lot dans les lignes ordre de transfert.';
        }
        modify(Control48)
        {
            CaptionML = ENU = 'Outbound', FRA = 'Désenlogement';
        }
        modify("Lot Info. Outbound Must Exist")
        {
            CaptionML = ENU = 'Lot No. Info. Must Exist', FRA = 'Info. obligatoire';
            ToolTipML = ENU = 'Specifies that lot numbers on outbound document lines must have an information record in the Lot No. Information Card.', FRA = 'Spécifie que les numéros de lot des lignes document sortant doivent être associés à un enregistrement information sur la fiche Information n° de lot.';
        }
        modify("Lot Purchase Outbound Tracking")
        {
            CaptionML = ENU = 'Lot Purchase Tracking', FRA = 'Traçabilité achat';
            ToolTipML = ENU = 'Specifies that outbound purchase document lines require a lot number.', FRA = 'Indique que vous devez saisir les numéros de lot dans les lignes document achat sortant.';
        }
        modify("Lot Sales Outbound Tracking")
        {
            CaptionML = ENU = 'Lot Sales Tracking', FRA = 'Traçabilité vente';
            ToolTipML = ENU = 'Specifies that outbound sales document lines require a lot number.', FRA = 'Indique que vous devez saisir les numéros de lot dans les lignes document vente sortant.';
        }
        modify("Lot Pos. Adjmt. Outb. Tracking")
        {
            CaptionML = ENU = 'Lot Positive Adjmt. Tracking', FRA = 'Traçabilité ajust. pos.';
            ToolTipML = ENU = 'Specifies that outbound item journal lines of type positive entry require a lot number.', FRA = 'Indique que vous devez saisir les numéros de lot dans les lignes feuille article sortant de type écriture positive.';
        }
        modify("Lot Neg. Adjmt. Outb. Tracking")
        {
            CaptionML = ENU = 'Lot Negative Adjmt. Tracking', FRA = 'Traçabilité ajust. nég.';
            ToolTipML = ENU = 'Specifies that outbound item journal lines of type negative entry require a lot number.', FRA = 'Indique que vous devez saisir les numéros de lot dans les lignes feuille article sortant de type écriture négative.';
        }
        modify("Lot Assembly Outbound Tracking")
        {
            CaptionML = ENU = 'Lot Assembly Tracking', FRA = 'Suivi de l''assemblage de lot';
            ToolTipML = ENU = 'Indicates that lot numbers are required with outbound posting from assembly orders.', FRA = 'Indique que les numéros de lot sont nécessaires avec la validation de désenlogement à partir des ordres d''assemblage.';
        }
        modify("Lot Manuf. Outbound Tracking")
        {
            CaptionML = ENU = 'Lot Manufacturing Tracking', FRA = 'N° lot - Traçabilité prod.';
            ToolTipML = ENU = 'Specifies that lot numbers are required with outbound posting from production - typically consumption.', FRA = 'Spécifie que les numéros de lot nécessitent une validation de désenlogement à partir de la production (en général la consommation).';
        }
        modify("Misc.")
        {
            CaptionML = ENU = 'Misc.', FRA = 'Divers';
        }
        modify("Warranty Date Formula")
        {
            ToolTipML = ENU = 'Specifies the formula that calculates the warranty date entered in the Warranty Date field on item tracking line.', FRA = 'Spécifie la formule qui permet de calculer la date de garantie saisie dans le champ Date de garantie sur la ligne traçabilité.';
        }
        modify("Man. Warranty Date Entry Reqd.")
        {
            ToolTipML = ENU = 'Specifies that a warranty date must be entered manually.', FRA = 'Indique qu''une date de garantie doit être saisie manuellement.';
        }
        modify("Man. Expir. Date Entry Reqd.")
        {
            ToolTipML = ENU = 'Specifies that you must manually enter an expiration date on the item tracking line.', FRA = 'Spécifie que vous devez saisir une date d''expiration dans la ligne traçabilité.';
        }
        modify("Strict Expiration Posting")
        {
            ToolTipML = ENU = 'Specifies that an expiration date assigned to the item tracking number as it entered inventory must be respected when it exits inventory.', FRA = 'Spécifie qu''une date d''expiration affectée au numéro traçabilité lors de son entrée dans le stock doit être respectée lors de sa sortie du stock.';
        }

        //Unsupported feature: PropertyDeletion on "Control1900000001(Control 1900000001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "General(Control 1)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Code(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Code(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Description(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Description(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Serial No."(Control 1907140601)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control64(Control 64)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Specific Tracking"(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Specific Tracking"(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Inbound(Control 20)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Info. Inbound Must Exist"(Control 56)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Info. Inbound Must Exist"(Control 56)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Purchase Inbound Tracking"(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Purchase Inbound Tracking"(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Sales Inbound Tracking"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Sales Inbound Tracking"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Pos. Adjmt. Inb. Tracking"(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Pos. Adjmt. Inb. Tracking"(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Neg. Adjmt. Inb. Tracking"(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Neg. Adjmt. Inb. Tracking"(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Assembly Inbound Tracking"(Control 9)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Assembly Inbound Tracking"(Control 9)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Manuf. Inbound Tracking"(Control 29)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Manuf. Inbound Tracking"(Control 29)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control82(Control 82)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Warehouse Tracking"(Control 31)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Warehouse Tracking"(Control 31)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Transfer Tracking"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Transfer Tracking"(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Outbound(Control 21)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Info. Outbound Must Exist"(Control 59)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Info. Outbound Must Exist"(Control 59)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Purchase Outbound Tracking"(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Purchase Outbound Tracking"(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Sales Outbound Tracking"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Sales Outbound Tracking"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Pos. Adjmt. Outb. Tracking"(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Pos. Adjmt. Outb. Tracking"(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Neg. Adjmt. Outb. Tracking"(Control 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Neg. Adjmt. Outb. Tracking"(Control 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Assembly Outbound Tracking"(Control 3)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Assembly Outbound Tracking"(Control 3)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Manuf. Outbound Tracking"(Control 67)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SN Manuf. Outbound Tracking"(Control 67)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot No."(Control 1903605001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control74(Control 74)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Specific Tracking"(Control 33)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Specific Tracking"(Control 33)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control47(Control 47)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Info. Inbound Must Exist"(Control 61)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Info. Inbound Must Exist"(Control 61)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Purchase Inbound Tracking"(Control 37)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Purchase Inbound Tracking"(Control 37)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Sales Inbound Tracking"(Control 39)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Sales Inbound Tracking"(Control 39)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Pos. Adjmt. Inb. Tracking"(Control 41)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Pos. Adjmt. Inb. Tracking"(Control 41)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Neg. Adjmt. Inb. Tracking"(Control 43)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Neg. Adjmt. Inb. Tracking"(Control 43)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Assembly Inbound Tracking"(Control 5)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Assembly Inbound Tracking"(Control 5)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Manuf. Inbound Tracking"(Control 69)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Manuf. Inbound Tracking"(Control 69)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control81(Control 81)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Warehouse Tracking"(Control 72)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Warehouse Tracking"(Control 72)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Transfer Tracking"(Control 45)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Transfer Tracking"(Control 45)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control48(Control 48)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Info. Outbound Must Exist"(Control 63)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Info. Outbound Must Exist"(Control 63)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Purchase Outbound Tracking"(Control 49)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Purchase Outbound Tracking"(Control 49)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Sales Outbound Tracking"(Control 51)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Sales Outbound Tracking"(Control 51)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Pos. Adjmt. Outb. Tracking"(Control 53)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Pos. Adjmt. Outb. Tracking"(Control 53)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Neg. Adjmt. Outb. Tracking"(Control 55)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Neg. Adjmt. Outb. Tracking"(Control 55)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Assembly Outbound Tracking"(Control 7)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Assembly Outbound Tracking"(Control 7)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Manuf. Outbound Tracking"(Control 70)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot Manuf. Outbound Tracking"(Control 70)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Misc."(Control 1905489801)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Warranty Date Formula"(Control 23)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Warranty Date Formula"(Control 23)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Man. Warranty Date Entry Reqd."(Control 32)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Man. Warranty Date Entry Reqd."(Control 32)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Man. Expir. Date Entry Reqd."(Control 52)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Man. Expir. Date Entry Reqd."(Control 52)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Strict Expiration Posting"(Control 65)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Strict Expiration Posting"(Control 65)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900000007(Control 1900000007)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900383207(Control 1900383207)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1905767507(Control 1905767507)". Please convert manually.

        addafter(Description)
        {
            field("FA Related"; Rec."FA Related FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the FA Related field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the FA Related field.';

            }
        }
        //BC Upgrade KAPOOV01 Drink-it>>
        // addafter("Misc.")
        // {
        // group("SSCC No.")
        // {
        //     CaptionML = ENU = 'SSCC No.',
        //                 FRA = 'N° SSCC';
        //     group(General)
        //     {
        //         CaptionML = ENU = 'General',
        //                     FRA = 'Général';
        //         field("SSCC Specific Tracking"; "SSCC Specific Tracking")
        //         {
        //         }
        //     }
        //     group(Inbound)
        //     {
        //         CaptionML = ENU = 'Inbound',
        //                     FRA = 'Enlogement';
        //         field("SSCC Info. Inbound Must Exist"; "SSCC Info. Inbound Must Exist")
        //         {
        //             CaptionML = ENU = 'SSCC No. Info. Must Exist',
        //                         FRA = 'Info N° SSCC doit exister';
        //         }
        //         field("SSCC Purchase Inb. Tracking"; "SSCC Purchase Inb. Tracking")
        //         {
        //             CaptionML = ENU = 'SSCC Purchase Tracking',
        //                         FRA = 'Traçabilité SSCC Achat';
        //         }
        //         field("SSCC Sales Inbound Tracking"; "SSCC Sales Inbound Tracking")
        //         {
        //             CaptionML = ENU = 'SSCC Sales Tracking',
        //                         FRA = 'Traçabilité SSCC Vente';
        //         }
        //         field("SSCC Pos. Adj. Inb. Tracking"; "SSCC Pos. Adj. Inb. Tracking")
        //         {
        //             CaptionML = ENU = 'SSCC Positive Adjmt. Tracking',
        //                         FRA = 'Traçabilité ajustement positif';
        //         }
        //         field("SSCC Neg. Adj. Inb. Tracking"; "SSCC Neg. Adj. Inb. Tracking")
        //         {
        //             CaptionML = ENU = 'SSCC Negative Adjmt. Tracking',
        //                         FRA = 'Traçabilité ajustement négatif';
        //         }
        //         field("SSCC Manuf. Inbound Tracking"; "SSCC Manuf. Inbound Tracking")
        //         {
        //             CaptionML = ENU = 'SSCC Manufacturing Tracking',
        //                         FRA = 'Traçabilité SSCC Production';
        //         }
        //     }
        //     group()
        //     {
        //         field("SSCC Warehouse Tracking"; "SSCC Warehouse Tracking")
        //         {
        //             CaptionML = ENU = 'SSCC Warehouse Tracking',
        //                         FRA = 'N° SSCC - Traçabilité magasin';
        //         }
        //         field("SSCC Transfer Tracking"; "SSCC Transfer Tracking")
        //         {
        //             CaptionML = ENU = 'SSCC Transfer Tracking',
        //                         FRA = 'N° SSCC - Traçabilité transfert';
        //         }
        //     }
        //     group(Outbound)
        //     {
        //         CaptionML = ENU = 'Outbound',
        //                     FRA = 'Désenlogement';
        //         field("SSCC Info. Outbound Must Exist"; "SSCC Info. Outbound Must Exist")
        //         {
        //             CaptionML = ENU = 'SSCC No. Info. Must Exist',
        //                         FRA = 'Info N° SSCC doit exister';
        //         }
        //         field("SSCC Purchase Outb. Tracking"; "SSCC Purchase Outb. Tracking")
        //         {
        //             CaptionML = ENU = 'SSCC Purchase Tracking',
        //                         FRA = 'Traçabilité SSCC Achat';
        //         }
        //         field("SSCC Sales Outbound Tracking"; "SSCC Sales Outbound Tracking")
        //         {
        //             CaptionML = ENU = 'SSCC Sales Tracking',
        //                         FRA = 'Traçabilité SSCC Vente';
        //         }
        //         field("SSCC Pos. Adj. Outb. Tracking"; "SSCC Pos. Adj. Outb. Tracking")
        //         {
        //             CaptionML = ENU = 'SSCC Positive Adjmt. Tracking',
        //                         FRA = 'Traçabilité ajustement positif';
        //         }
        //         field("SSCC Neg. Adj. Outb. Tracking"; "SSCC Neg. Adj. Outb. Tracking")
        //         {
        //             CaptionML = ENU = 'SSCC Negative Adjmt. Tracking',
        //                         FRA = 'Traçabilité ajustement négatif';
        //         }
        //         field("SSCC Manuf. Outbound Tracking"; "SSCC Manuf. Outbound Tracking")
        //         {
        //             CaptionML = ENU = 'SSCC Manufacturing Tracking',
        //                         FRA = 'Traçabilité SSCC Production';
        //         }
        //     }
        // }
        // group("Drink-It")
        // {
        //     CaptionML = ENU = 'Drink-It',
        //                 FRA = 'Drink-It';
        //     field("Allow FEFO Trkg Blocked Lots"; "Allow FEFO Trkg Blocked Lots")
        //     {
        //     }
        //     field("Use SSCC Avail. Inventory"; "Use SSCC Avail. Inventory")
        //     {
        //     }
        //     field("Your Reference Required"; "Your Reference Required")
        //     {
        //         Description = 'QXL11.01';
        //         Visible = false;
        //     }
        // }
        //}
        //BC Upgrade KAPOOV01 Drink-it<<
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

