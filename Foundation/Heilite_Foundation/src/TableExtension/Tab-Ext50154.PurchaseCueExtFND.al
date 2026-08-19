tableextension 50154 PurchaseCueExtFND extends "Purchase Cue"
{

    // DITW16.00.00.39 DDR 01/09/2011 DIT-715 #139 Added fields
    //                                               2014460 POs Pending Approval - All
    //                                               2014461 POs Approval Entries - All
    //                                               2014462 Warehouse Purch. Order - All
    //                                               2014463 Warehouse Return Order - All
    //                                               2014464 PRs Approval Entries - All
    //                                               2014465 My POs Approval Entries
    //                                               2014466 Delayed Approval Entries - All
    //                                               2014467 My Delayed Approval Entries
    //                                               2014468 Period. Approval Entries - All
    //                                               2014469 My Period. Approval Entries
    //                                               2014470 Purch. Approval Entries - Open
    //                                               2014471 My Purch. Approval Entries-Open
    //                                               2014500 User ID Filter

    // HEI.01 RFC-CHG0249183 IBM.LS 22.04.2019
    //   # Created new field: 50000 - "To Send".
    // HEI.02 CHG2087586 IBM SHANKJ03 16.12.2020
    //   # created new field : 50001 Request to Approve
    // HEI.03 CHG2114916 IBM SHIVAS05 18.06.2021
    //   # Add one filter 'Document Subtype Code=PO' on flow field "To Send"
    // HEI.04 CHG2114916 IBM SHIVAS05 04.07.2022
    //   # Add one more filter 'Document Subtype Code='' on flow field "To Send" and use FILTER in place of CONST
    fields
    {
        modify("Primary Key")
        {
            CaptionML = ENU = 'Primary Key', FRA = 'Clé primaire';
        }
        modify("To Send or Confirm")
        {
            CaptionML = ENU = 'To Send or Confirm', FRA = 'ž envoyer ou à confirmer';
        }
        modify("Upcoming Orders")
        {
            CaptionML = ENU = 'Upcoming Orders', FRA = 'Commandes à venir';
        }
        modify("Outstanding Purchase Orders")
        {
            CaptionML = ENU = 'Outstanding Purchase Orders', FRA = 'Commandes achat ouvertes';
        }
        modify("Purchase Return Orders - All")
        {
            CaptionML = ENU = 'Purchase Return Orders - All', FRA = 'Retours achat - Tous';
        }
        modify("Not Invoiced")
        {
            CaptionML = ENU = 'Not Invoiced', FRA = 'Non facturé';
        }
        modify("Partially Invoiced")
        {
            CaptionML = ENU = 'Partially Invoiced', FRA = 'Partiellement facturé';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify("Responsibility Center Filter")
        {
            CaptionML = ENU = 'Responsibility Center Filter', FRA = 'Filtre centre de gestion';
        }
        field(50000; "To Send FND"; Integer)
        {
            // BC Upgrade VAMSIU01 Drink it field Document Subtype Code" Filter added>>
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = FILTER(Order),
                                                         Status = FILTER(Released),
                                                         "No. Printed" = CONST(0),
                                                         "Responsibility Center" = FIELD("Responsibility Center Filter"),
                                                         "SRM Order No. FND" = CONST(''),
                                                         "Document Subtype Code FND" = FILTER('PO' | '')));
            CaptionML = ENU = 'To Send',
                        FRA = 'ž envoyer ou à confirmer';
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
            //BC Upgrade VAMSIU01 Drink it field Document Subtype Code" code added<<
        }
        field(50001; "Request to Approve FND"; Integer)
        {
            caption = 'Request to Approve';
            CalcFormula = Count("Approval Entry" where("Table ID" = FILTER(38),
                                                        Status = FILTER(Open),
                                                        "Approver ID" = FIELD("User ID Filter")));
            Description = 'HEI.02';
            FieldClass = FlowField;
        }
        /*//Bc Upgrade Manisha Drink it field commented>>
        field(2014460; "POs Pending Approval - All"; Integer)
        {
            CalcFormula = Count("Purchase Header" where("Document Type" = FILTER(Order),
                                                         Status = FILTER("Pending Approval")));
            CaptionML = ENU = 'Purchase Order - Pending Approval',
                        FRA = 'Commande achat - approbation suspendues';
            Description = 'DIT-715 #139';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014461; "POs Approval Entries - All"; Integer)
        {
            CalcFormula = Count("Approval Entry" where("Table ID" = CONST(38),
                                                        "Document Type" = CONST(Order)));
            CaptionML = ENU = 'Purchase Order - Approval Entries',
                        FRA = 'Commande achat - écritures approbation';
            Description = 'DIT-715 #139';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014462; "Warehouse Purch. Order - All"; Integer)
        {
            CalcFormula = Count("Warehouse Request" where("Source Document" = CONST("Purchase Order")));
            CaptionML = ENU = 'Warehouse Purchase Order - All',
                        FRA = 'Commande achat entrepot - Tous';
            Description = 'DIT-715 #139';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014463; "Warehouse Purch. Return - All"; Integer)
        {
            CalcFormula = Count("Warehouse Request" where("Source Document" = CONST("Purchase Return Order")));
            CaptionML = ENU = 'Warehouse Purchase Return - All',
                        FRA = 'Retour achat entrepot - Tous';
            Description = 'DIT-715 #139';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014464; "PRs Approval Entries - All"; Integer)
        {
            CalcFormula = Count("Approval Entry" where("Table ID" = CONST(38),
                                                        "Document Type" = CONST("Return Order")));
            CaptionML = ENU = 'Purchase Return Order - Approval Entries',
                        FRA = 'Retour commande achat - écritures approbation';
            Description = 'DIT-715 #139';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014465; "My POs Approval Entries"; Integer)
        {
            CalcFormula = Count("Approval Entry" where("Table ID" = CONST(38),
                                                        "Document Type" = CONST(Order),
                                                        "Approver ID" = FIELD("User ID Filter")));
            CaptionML = ENU = 'My Purchase Order - Approval Entries',
                        FRA = 'Mes commandes achat - écritures approbation';
            Description = 'DIT-715 #139';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014466; "Delayed Approval Entries - All"; Integer)
        {
            CalcFormula = Count("Approval Entry" where("Table ID" = CONST(0)));
            CaptionML = ENU = 'Delayed Approval Entries',
                        FRA = 'écritures approbation retardées';
            Description = 'DIT-715 #139 (not yet)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014467; "My Delayed Approval Entries"; Integer)
        {
            CalcFormula = Count("Approval Entry" where("Table ID" = CONST(0),
                                                        "Approver ID" = FIELD("User ID Filter")));
            CaptionML = ENU = 'My Delayed Approval Entries',
                        FRA = 'Mes écritures approbation retardées';
            Description = 'DIT-715 #139 (not yet)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014468; "Period. Approval Entries - All"; Integer)
        {
            CalcFormula = Count("Approval Entry" where("Table ID" = CONST(2013775)));
            CaptionML = ENU = 'Periodic Approval Entries',
                        FRA = 'Ecritures approbation périodiques';
            Description = 'DIT-715 #139';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014469; "My Period. Approval Entries"; Integer)
        {
            CalcFormula = Count("Approval Entry" where("Table ID" = CONST(2013775),
                                                        "Approver ID" = FIELD("User ID Filter")));
            CaptionML = ENU = 'My Periodic Approval Entries',
                        FRA = 'Mes écritures approbation périodiques';
            Description = 'DIT-715 #139';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014470; "Purch. Approval Entries - Open"; Integer)
        {
            CalcFormula = Count("Approval Entry" where("Table ID" = CONST(38),
                                                        Status = CONST(Open)));
            CaptionML = ENU = 'Purchase Pending Approval Entries',
                        FRA = 'Ecritures approbation achat suspendues';
            Description = 'DIT-715 #139';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014471; "My Purch. Approval Entries"; Integer)
        {
            CalcFormula = Count("Approval Entry" where("Table ID" = CONST(38),
                                                        "Approver ID" = FIELD("User ID Filter")));
            CaptionML = ENU = 'My Purchase Approval Entries',
                        FRA = 'Mes écritures approbation achat';
            Description = 'DIT-715 #139';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014500; "User ID Filter"; Code[50])
        {
            CaptionML = ENU = 'User ID Filter',
                        FRA = 'Filtre code utilisateur';
            Description = 'DIT-715 #139';
            FieldClass = FlowFilter;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        *///Bc Upgrade Manisha Drink it field commented>>
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

