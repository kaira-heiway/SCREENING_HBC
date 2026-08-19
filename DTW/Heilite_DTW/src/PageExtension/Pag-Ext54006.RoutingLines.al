pageextension 54006 RoutingLinesExt extends "Routing Lines"
{
    // version NAVW110.0,MANXL7.00.001,QXL9.00.001,DITW110.00.08,HEI.01

    //     DITW14.00.00.8 PROD: BrewIt & Quality
    // DITW15.00.00.23 PRODW14.00.00.08.02 JFE 08/09/2008: Added the new field "Quality Measure Exist"

    // MANXL7.00.001 DAT 03/03/2014 #11: Added "Line Speed"

    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.05 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // HEI.01 FDD PRDGAP027 IBM.NAIKH01
    //   # Added a new field "Lot Size" in the page
    // HEI.02 FDD CHG2041183 HT938 IBM TUDOSG01 11.02.2020 # New fields: Zone Code, Bin Code
    //HEI.03 FDD-LineSpeed BC UPGRADE PATHAA02-09.03.26 # "Show on Production Order"&"Line Speed" fields added
    //******************************************************************************************


    layout
    {
        //Bc Upgrade YADAVM09<<
        modify("Lot Size")
        {
            Visible = true;
        }
        //Bc Upgrade YADAVM09<<
        modify("Operation No.")
        {
            ToolTipML = ENU = 'Specifies the operation number for this routing line.', FRA = 'Spécifie le numéro d''opération pour cette ligne gamme.';
        }
        modify("Previous Operation No.")
        {
            ToolTipML = ENU = 'Specifies the previous operation number, which is automatically assigned.', FRA = 'Spécifie le numéro opération précédente qui est automatiquement affecté.';
        }
        modify("Next Operation No.")
        {
            ToolTipML = ENU = 'Specifies the next operation number. You use this field if you use parallel routings.', FRA = 'Spécifie le numéro de l''opération suivante. Renseignez ce champ si vous utilisez des gammes parallèles.';
        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the kind of capacity type to use for the actual operation.', FRA = 'Spécifie le genre de type capacité à utiliser pour l''opération réelle.';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies a work center or machine number depending on the type that you selected in the Type field.', FRA = 'Spécifie un numéro de centre ou de poste de charge selon le type sélectionné dans le champ Type.';
        }
        modify("Standard Task Code")
        {
            ToolTipML = ENU = 'Specifies a standard task.', FRA = 'Spécifie une tâche standard.';
        }
        modify("Routing Link Code")
        {
            ToolTipML = ENU = 'Specifies the routing link code.', FRA = 'Spécifie le code lien gamme.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the entry.', FRA = 'Spécifie une description de l''écriture.';
        }
        modify("Setup Time")
        {
            ToolTipML = ENU = 'Specifies the setup time of the operation.', FRA = 'Spécifie le délai de préparation de l''opération.';
        }
        modify("Setup Time Unit of Meas. Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code that applies to the setup time of the operation.', FRA = 'Indique le code unité qui s''applique au temps de préparation de l''opération.';
        }
        modify("Run Time")
        {
            ToolTipML = ENU = 'Specifies the run time of the operation.', FRA = 'Spécifie le délai d''exécution de l''opération.';
        }
        modify("Run Time Unit of Meas. Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code that applies to the run time of the operation.', FRA = 'Indique le code unité qui s''applique au délai d''exécution de l''opération.';
        }
        modify("Wait Time")
        {
            ToolTipML = ENU = 'Specifies the wait time according to the value in the Wait Time Unit of Measure field.', FRA = 'Spécifie le délai d''attente en fonction de la valeur du champ Unité temps d''attente.';
        }
        modify("Wait Time Unit of Meas. Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code that applies to the wait time.', FRA = 'Indique le code unité qui s''applique au délai d''attente.';
        }
        modify("Move Time")
        {
            ToolTipML = ENU = 'Specifies the move time according to the value in the Move Time Unit of Measure field.', FRA = 'Spécifie le délai de transfert en fonction de la valeur du champ Unité temps de transfert.';
        }
        modify("Move Time Unit of Meas. Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code that applies to the move time.', FRA = 'Indique le code unité qui s''applique au délai de transfert.';
        }
        modify("Fixed Scrap Quantity")
        {
            ToolTipML = ENU = 'Specifies the fixed scrap quantity.', FRA = 'Indique la quantité perte fixe.';
        }
        modify("Scrap Factor %")
        {
            ToolTipML = ENU = 'Specifies the scrap factor in percent.', FRA = 'Spécifie la valeur de rebut exprimée en pourcentage.';
        }
        modify("Minimum Process Time")
        {
            ToolTipML = ENU = 'Specifies a minimum process time.', FRA = 'Spécifie le délai de traitement minimal.';
        }
        modify("Maximum Process Time")
        {
            ToolTipML = ENU = 'Specifies a maximum process time.', FRA = 'Spécifie le délai de traitement maximal.';
        }
        modify("Concurrent Capacities")
        {
            ToolTipML = ENU = 'Specifies the number of machines or persons that are working concurrently.', FRA = 'Spécifie le nombre de machines ou de personnes travaillant simultanément.';
        }
        modify("Send-Ahead Quantity")
        {
            ToolTipML = ENU = 'Specifies the send-ahead quantity.', FRA = 'Spécifie la quantité de transfert.';
        }
        modify("Unit Cost per")
        {
            ToolTipML = ENU = 'Specifies the task-related production costs.', FRA = 'Spécifie les coûts de production liés à la tâche.';
        }
        /* Bc Upgrade YADAVM09 >>
        addafter(Description)
        {
            field("Quality Measure Exist"; "Quality Measure Exist")
            {
            }
            field("Show on Production Order"; "Show on Production Order")
            {
            }
        }
       
        addafter("Run Time")
        {
            field("Line Speed"; "Line Speed")
            {
                Description = 'MANXL7.00.001';
            }
        }
        addafter("Move Time Unit of Meas. Code")
        {
            field("Alert Time"; "Alert Time")
            {
            }
            field("Alert Time Unit of Meas. Code"; "Alert Time Unit of Meas. Code")
            {
                Visible = false;
            }
            field("Allow Alert Cancel"; "Allow Alert Cancel")
            {
            }
            field("Next Test Within (Hours)"; "Next Test Within (Hours)")
            {
            }
        }
 */ //Bc Upgrade YADAVM09<<
        addafter("Unit Cost per")
        {
            field("Batch Size"; Rec."Batch Size FND")
            {
                ApplicationArea = All;
            }
            field("Zone Code"; Rec."Zone Code FND")
            {
                ApplicationArea = All;
            }
            field("Bin Code"; Rec."Bin Code FND")
            {
                ApplicationArea = All;
            }
            //HEI.03>>
            field("Show on Production Order"; Rec."Show on Production Order FND")
            {
                ApplicationArea = All;
            }
            field("Line Speed"; Rec."Line Speed FND")
            {
                ApplicationArea = All;
            }
            //HEI.03<<
        }
    }
    actions
    {
        modify("&Operation")
        {
            CaptionML = ENU = '&Operation', FRA = '&Opération';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify("&Tools")
        {
            CaptionML = ENU = '&Tools', FRA = '&Outils';
        }
        modify("&Personnel")
        {
            CaptionML = ENU = '&Personnel', FRA = '&Qualifications';
        }
        modify("&Quality Measures")
        {
            CaptionML = ENU = '&Quality Measures', FRA = '&Contrôles qualité';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

