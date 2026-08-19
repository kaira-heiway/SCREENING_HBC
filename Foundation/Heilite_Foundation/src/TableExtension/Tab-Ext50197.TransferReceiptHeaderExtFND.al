tableextension 50197 TransferReceiptHeaderExtFND extends "Transfer Receipt Header"
{
    //   DITW15.00.00.25 DDR 10/10/2008 Added fields
    //                                  2014077 Truck Code
    //                                  2014078 Driver Code
    // DITW15.00.00.36 DDR 17/12/2009 issue 594 Added AAD fields
    //                                            2013726 From Tax Registration No.
    //                                            2013730 Fiscal Representative No.
    // DITW15.00.00.37 DDR 28/05/2010 issue 480 Added fields
    //                                            2013696 Transf.-from Location Gr. Code
    //                                            2014094 Trsf-from Ph. Location Gr Code
    //                                            2013758 Transf.-to Location Gr. Code
    //                                            2014095 Trsf-to Ph. Location Gr Code
    // DITW15.00.00.38 DDR 20/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Renamed field "From Tax Registration No." -> "Tax Registration no." (means "Transfer-to Code")
    //                                  Added fields
    //                                    2014271 Tax Warehouse Reference
    //                     27/01/2011 issue 1217 (DIT711 137)
    //                                  Modified Caption field2013730 "Fiscal Representative No."
    //                                  Added fields
    //                                    2014460 Tax Office Code
    //                     11/03/2011 issue 458 Replaced caption field2013696 'Location Group' -> 'Location Tax Group'
    //                                                           field2013758
    // DITW15.00.00.39 DDR 06/07/2011 issue 1353 Added fields
    //                                   2014290 Journey Time
    //                     04/08/2011 issue 1353 Modified caption field2014290 "Journey Time"
    //                     19/08/2011 issue 1363
    //                                  Added fields
    //                                    2013733 Tax Date
    // DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields
    //                                    2014495 Delivery Sequence
    //                     22/12/2011 DIT-715 issue 187
    //                                  Added fields
    //                                    2014277 Transport Mode (flowfield)
    //                                    2014291 Transport Mode Comment (flowfield)
    // DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457
    //                                  Added fields
    //                                    2034983 Work Order No.
    // DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 New Field Flowfield "Document Shipping Costs"
    // DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field 2014421 "Document Subtype Code"
    // DITW18.00.07 AKH 20/04/2016 DIT-770 #1508 Adjusted filtering code
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 16/02/2017 NRQ#20755 Update document subtype code table relation filter
    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Fields created: 50002 - To Gate Entry No.
    //                         50003 - From Gate Entry No.
    // DITW110.00.12 AKH 30/03/2018 NRQ#16026 Order Shipment Planning: Sync Sales - Transfer
    // HEI.03 FDD-HT743 IBM BULIMC01 10.09.2019 #New field added: "No. Printed"
    // HEI.04 FDD-HT1304 IBM NASTAA02 01.07.2020 # IC Transfer Order Automation
    //   # New Field created : 50005 - IC Document
    //   # Code added on funcion: "CopyFromTransferHeader"
    // HEI.05 FDD-HB1438 CHG2065311 IBM SHANKJ03 30.07.2020
    //   # New Field created : PO Reference & Extra PO reference
    // HEI.06 CHG2093869 GAVANM01 05.03.2021 #Transfer and Stock adjustments interfaces Bahamas LS Retail
    //   # new field added: 50009 - LSR Order No
    // HEI.07 CHG2200434 IBM COSTES04 19.05.2023 Column Data Availability of WH Shipment & WH Receipt No
    //   # New fields added Posted Whse. Receipt No.
    //--------------------------------------------------------------------------------------------
    //BC Upgrade SHARMP16 ---tag HEI.04 in Nav Code added in Cu Cod53499.HeinekenBCUpgrade--OnAfterCopyFromTransferHeader
    //BC upgrade SHARMP16-- interface related fields commented and shifted to Interface Ext

    // BC Upgrade SHUKLP03 >> 50066 Document Subtype Code field added.

    // HEI.06 CHG2093869 GAVANM01 05.03.2021 #Transfer and Stock adjustments interfaces Bahamas LS Retail
    //   # new field added: 50009 - LSR Order No
    //BC upgrade SHARMP16-- interface related fields added and commented in main Ext

    // BC Upgrade MISHRS14 >>
    // Changed table name to "TransferReceiptHeaderIntExtFND" as its moved from Inteface to Foundation layer.
    // BC Upgrade MISHRS14 <<

    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Transfer-from Code")
        {
            CaptionML = ENU = 'Transfer-from Code', FRA = 'Code prov. transfert';
        }
        modify("Transfer-from Name")
        {
            CaptionML = ENU = 'Transfer-from Name', FRA = 'Nom prov. transfert';
        }
        modify("Transfer-from Name 2")
        {
            CaptionML = ENU = 'Transfer-from Name 2', FRA = 'Nom prov. transfert 2';
        }
        modify("Transfer-from Address")
        {
            CaptionML = ENU = 'Transfer-from Address', FRA = 'Adresse prov. transfert';
        }
        modify("Transfer-from Address 2")
        {
            CaptionML = ENU = 'Transfer-from Address 2', FRA = 'Adresse prov. transfert 2';
        }
        modify("Transfer-from Post Code")
        {
            CaptionML = ENU = 'Transfer-from Post Code', FRA = 'Code postal prov. transfert';
        }
        modify("Transfer-from City")
        {
            CaptionML = ENU = 'Transfer-from City', FRA = 'Ville prov. transfert';
        }
        modify("Transfer-from County")
        {
            CaptionML = ENU = 'Transfer-from County', FRA = 'Pays prov. transfert';
        }
        modify("Trsf.-from Country/Region Code")
        {
            CaptionML = ENU = 'Trsf.-from Country/Region Code', FRA = 'Code pays/région prov. transfert';
        }
        modify("Transfer-to Code")
        {
            CaptionML = ENU = 'Transfer-to Code', FRA = 'Code dest. transfert';
        }
        modify("Transfer-to Name")
        {
            CaptionML = ENU = 'Transfer-to Name', FRA = 'Nom dest. transfert';
        }
        modify("Transfer-to Name 2")
        {
            CaptionML = ENU = 'Transfer-to Name 2', FRA = 'Nom dest. transfert 2';
        }
        modify("Transfer-to Address")
        {
            CaptionML = ENU = 'Transfer-to Address', FRA = 'Adresse dest. transfert';
        }
        modify("Transfer-to Address 2")
        {
            CaptionML = ENU = 'Transfer-to Address 2', FRA = 'Adresse dest. transfert 2';
        }
        modify("Transfer-to Post Code")
        {
            CaptionML = ENU = 'Transfer-to Post Code', FRA = 'Code postal dest. transfert';
        }
        modify("Transfer-to City")
        {
            CaptionML = ENU = 'Transfer-to City', FRA = 'Ville dest. transfert';
        }
        modify("Transfer-to County")
        {
            CaptionML = ENU = 'Transfer-to County', FRA = 'Pays dest. transfert';
        }
        modify("Trsf.-to Country/Region Code")
        {
            CaptionML = ENU = 'Trsf.-to Country/Region Code', FRA = 'Code pays/région dest. transfert';
        }
        modify("Transfer Order Date")
        {
            CaptionML = ENU = 'Transfer Order Date', FRA = 'Date ordre transfert';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify("Shortcut Dimension 1 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("Transfer Order No.")
        {
            CaptionML = ENU = 'Transfer Order No.', FRA = 'N° ordre transfert';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Shipment Date")
        {
            CaptionML = ENU = 'Shipment Date', FRA = 'Date d''expédition';
        }
        modify("Receipt Date")
        {
            CaptionML = ENU = 'Receipt Date', FRA = 'Date de réception';
        }
        modify("In-Transit Code")
        {
            CaptionML = ENU = 'In-Transit Code', FRA = 'Code transit';
        }
        modify("Transfer-from Contact")
        {
            CaptionML = ENU = 'Transfer-from Contact', FRA = 'Contact prov. transfert';
        }
        modify("Transfer-to Contact")
        {
            CaptionML = ENU = 'Transfer-to Contact', FRA = 'Contact dest. transfert';
        }
        modify("External Document No.")
        {
            CaptionML = ENU = 'External Document No.', FRA = 'N° doc. externe';
        }
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Shipping Agent Code', FRA = 'Code transporteur';
        }
        modify("Shipping Agent Service Code")
        {
            CaptionML = ENU = 'Shipping Agent Service Code', FRA = 'Code prestation transporteur';
        }
        modify("Shipment Method Code")
        {
            CaptionML = ENU = 'Shipment Method Code', FRA = 'Code condition livraison';
        }
        modify("Transaction Type")
        {
            CaptionML = ENU = 'Transaction Type', FRA = 'Type de transaction';
        }
        modify("Transport Method")
        {
            CaptionML = ENU = 'Transport Method', FRA = 'Mode de transport';
        }
        modify("Entry/Exit Point")
        {
            CaptionML = ENU = 'Entry/Exit Point', FRA = 'Pays destination/provenance';
        }
        modify("Area")
        {
            CaptionML = ENU = 'Area', FRA = 'Dépt destination/provenance';
        }
        modify("Transaction Specification")
        {
            CaptionML = ENU = 'Transaction Specification', FRA = 'Régime';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        field(50002; "To Gate Entry No. FND"; Code[20])
        {
            caption = 'To Gate Entry No.';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "Gate Entry Header FND";
        }
        field(50003; "From Gate Entry No. FND"; Code[20])
        {
            Caption = 'From Gate Entry No.';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "Gate Entry Header FND";
        }
        field(50004; "No. Printed FND"; Integer)
        {
            CaptionML = ENU = 'No. Printed',
                        FRA = 'Nbre impressions';
            Description = 'HEI.03';
            Editable = false;
        }
        field(50005; "IC Document FND"; Boolean)
        {
            Caption = 'IC Document';
            Description = 'HEI.04';
            Editable = false;
        }
        field(50006; "PO Reference FND"; Code[20])
        {
            Caption = 'PO Reference';
            Description = 'HEI.05';
            TableRelation = "Purchase Header"."No." where("Location Code" = FIELD("Transfer-from Code"),
                                                           Status = CONST(Released));
        }
        field(50007; "Extra PO Reference FND"; Text[35])
        {
            Caption = 'Extra PO Reference';
            Description = 'HEI.05';
        }

        field(50009; "LSR Order No FND"; Code[20])
        {
            Caption = 'LSR Order No';
            DataClassification = ToBeClassified;
            Description = 'HEI.06';
            Editable = false;
        }
        
        // field(50009; "LSR Order No"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.06';
        //     Editable = false;
        // }//BC Upgrade SHARMP16-- Interface related field
        field(50015; "Posted Whse. Receipt No. FND"; Code[20])
        {
            Caption = 'Posted Whse. Receipt No.';
            DataClassification = CustomerContent;
            Description = 'HEI.07';
        }

        //BC Upgrade SHARMP16 Begin>> ----- Drink-IT fields
        // field(2013696; "Transf.-from Location Gr. Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Transfer-from Location Tax Group Code',
        //                 FRA = 'Transfer du Code groupe magasin taxe';
        //     Description = 'DITW15.00.00.37';
        //     TableRelation = "Location Group";
        // }
        // field(2013726; "Tax Registration No."; Text[20])
        // {
        //     CaptionML = ENU = 'Tax Registration No.',
        //                 FRA = 'N° Registration Taxe';
        //     Description = 'DITW15.00.00.36-.38';
        // }
        // field(2013730; "Fiscal Representative No."; Code[20])
        // {
        //     CaptionML = ENU = 'Fiscal Representative / Customs Agent No.',
        //                 FRA = 'N° représentant fiscal / Agent des douanes';
        //     Description = 'DITW15.00.00.36-.38 #1217';
        //     TableRelation = "Fiscal Representative";
        // }
        // field(2013733; "Tax Date"; Date)
        // {
        //     CaptionML = ENU = 'Tax Date',
        //                 FRA = 'Date taxe';
        //     Description = 'DITW15.00.00.39 #1363';
        // }
        // field(2013758; "Transf.-to Location Gr. Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Transfer-to Location Tax Group Code',
        //                 FRA = 'Transfer vers code groupe magasin taxe';
        //     Description = 'DITW15.00.00.37';
        //     TableRelation = "Location Group";
        // }
        // field(2014060; "Maximum Weight"; Decimal)
        // {
        //     BlankZero = true;
        //     Caption = 'Maximum Weight';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     MinValue = 0;
        // }
        // field(2014061; "Maximum Cubage"; Decimal)
        // {
        //     BlankZero = true;
        //     Caption = 'Maximum Volume (Cubage)';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     MinValue = 0;
        // }
        // field(2014071; "Document Shipping Costs"; Boolean)
        // {
        //     CalcFormula = Exist("Posted Document Shipping Cost" where("Source Type" = CONST(5746),
        //                                                                "Source No." = FIELD("No.")));
        //     CaptionML = ENU = 'Document Shipping Costs',
        //                 FRA = 'Document Frais livraison';
        //     Description = 'DIT-770 #1066';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014077; "Truck Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Truck Code',
        //                 FRA = 'Code camion';
        //     Description = 'DITW15.00.00.25';
        //     TableRelation = "Whse. Shipping Truck";
        // }
        // field(2014078; "Driver Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Driver Code',
        //                 FRA = 'Code chauffeur';
        //     Description = 'DITW15.00.00.25';
        //     TableRelation = "Whse. Shipping Driver";
        // }
        // field(2014080; Route; Code[20])
        // {
        //     Caption = 'Route';
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     TableRelation = Route;
        // }
        // field(2014081; "Route Planning No."; Code[20])
        // {
        //     Caption = 'Route Planning No.';
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     TableRelation = "Route Planning Worksheet";
        // }
        // field(2014082; "Truck Zone"; Option)
        // {
        //     Caption = 'Truck Zone';
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     OptionCaption = '" ,Right,Left"';
        //     OptionMembers = " ",Right,Left;
        // }
        // field(2014083; "Driver 2 Code"; Code[10])
        // {
        //     Caption = 'Driver 2 Code';
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     TableRelation = "Whse. Shipping Driver";
        // }
        // field(2014085; "Shipment Status"; Option)
        // {
        //     Caption = 'Shipping Status';
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     OptionCaption = 'Open,Picklist Printed,Assigned,Picked,Shipped,Return completed,Invoice';
        //     OptionMembers = Open,"Picklist Printed",Assigned,Picked,Shipped,"Return completed",Invoice;
        // }
        // field(2014086; "Delivery Time 1 From"; Time)
        // {
        //     Caption = 'Delivery Time 1 From';
        //     Description = 'DITW110.00.12 NRQ#16026';
        // }
        // field(2014087; "Delivery Time 1 To"; Time)
        // {
        //     Caption = 'Delivery Time 1 To';
        //     Description = 'DITW110.00.12 NRQ#16026';
        // }
        // field(2014088; "Delivery Time 2 From"; Time)
        // {
        //     Caption = 'Delivery Time 2 From';
        //     Description = 'DITW110.00.12 NRQ#16026';
        // }
        // field(2014089; "Delivery Time 2 To"; Time)
        // {
        //     Caption = 'Delivery Time 2 To';
        //     Description = 'DITW110.00.12 NRQ#16026';
        // }
        // field(2014090; Distance; Decimal)
        // {
        //     Caption = 'Distance';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     MinValue = 0;
        // }
        // field(2014091; "Delivery Time"; Time)
        // {
        //     Caption = 'Delivery Time';
        //     Description = 'DITW110.00.12 NRQ#16026';
        // }
        // field(2014092; "Total Weight"; Decimal)
        // {
        //     CalcFormula = Sum("Transfer Receipt Line".Weight where("Document No." = FIELD("No.")));
        //     Caption = 'Total Weight';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014093; "Total Cubage"; Decimal)
        // {
        //     CalcFormula = Sum("Transfer Receipt Line".Cubage where("Document No." = FIELD("No.")));
        //     Caption = 'Total Volume (Cubage)';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014094; "Trsf-from Ph. Location Gr Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Transfer-from Physical Location Group Code',
        //                 FRA = 'Transf. du Code groupe magasin réel';
        //     Description = 'DITW15.00.00.37';
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014100; "Trailer Code"; Code[10])
        // {
        //     Caption = 'Trailer Code';
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     TableRelation = "Whse. Shipping Truck".Code where("Transport Unit Type" = CONST(Trailer));
        // }
        // field(2014101; "Trsf-to Ph. Location Gr Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Transfer-to Physical Location Group Code',
        //                 FRA = 'Transfer vers code groupe magasin réel';
        //     Description = 'DITW15.00.00.37';
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014271; "Tax Warehouse Reference"; Text[20])
        // {
        //     CaptionML = ENU = 'Tax Warehouse Reference',
        //                 FRA = 'Entrepôt fiscal de référence';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014277; "Transport Mode"; Option)
        // {
        //     CalcFormula = Lookup("Transport Method"."Transport Mode" where(Code = FIELD("Transport Method")));
        //     CaptionML = ENU = 'Transport Mode (EMCS)',
        //                 FRA = 'Mode de transport (EMCS)';
        //     Description = 'DITW16.00.00.40 DIT715 #187';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     OptionCaptionML = ENU = 'Other,Sea,Rail,Road,Air,Post,N/A,Fixed,Waterway',
        //                       FRA = 'Autre,Mer,Chemin de fer,Route,Air,Poste,N/C,Installation de transport fixes,Transport par voies navigables';
        //     OptionMembers = Other,Sea,Rail,Road,Air,Post,"N/A","Fixed",Waterway;
        // }
        // field(2014290; "Journey Time"; DateFormula)
        // {
        //     CaptionML = ENU = 'Journey Time (EMCS)',
        //                 FRA = 'Temps de trajet (EMCS)';
        //     Description = 'DITW15.00.00.39 #1353';
        // }
        // field(2014291; "Transport Mode Comment"; Boolean)
        // {
        //     CalcFormula = Exist("EMCS Comment Line" where("Table ID" = CONST(5746),
        //                                                    "Document Type" = CONST(0),
        //                                                    "Document No." = FIELD("No."),
        //                                                    "Document Line No." = CONST(0),
        //                                                    "Field ID" = CONST(2014277)));
        //     CaptionML = ENU = 'Transport Mode Comment',
        //                 FRA = 'Commentaires Mode de transport';
        //     Description = 'DITW16.00.00.40 DIT715 #187';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        field(50066; "Document Subtype Code FND"; Code[10])
        {
            CaptionML = ENU = 'Document Subtype Code',
                        FRA = 'Code Sous-Type Document';
            Description = 'DITW18.00.07 DIT-770 #1508';
            TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = CONST(Inventory));
        }
        // field(2014460; "Tax Office Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Tax Office Code',
        //                 FRA = 'Code Bureau de taxe';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Tax Office";
        // }
        // field(2014495; "Delivery Sequence"; Integer)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Delivery Sequence',
        //                 FRA = 'Séquence de livraison';
        //     Description = 'DITW16.00.00.40 #1002';
        // }
        // field(2034983; "Work Order No."; Code[20])
        // {
        //     CaptionML = ENU = 'Work Order No.',
        //                 FRA = 'N° cmde. d''intervention';
        //     Description = 'DIT-715 #457';
        //     TableRelation = "Service Header"."No." where("Document Type" = CONST(Order),
        //                                                   "PM Order Status" = CONST(Released));
        // }
        //BC Upgrade SHARMP16 End<< ----- Drink-IT fields
    }


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: EmcsCommentLine)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TransRcptLine.SETRANGE("Document No.","No.");
    if TransRcptLine.FIND('-') then
      repeat
    #4..7
    InvtCommentLine.SETRANGE("No.","No.");
    InvtCommentLine.DELETEALL;

    ItemTrackingMgt.DeleteItemEntryRelation(
      DATABASE::"Transfer Receipt Line",0,"No.",'',0,0,true);

    MoveEntries.MoveDocRelatedEntries(DATABASE::"Transfer Receipt Header","No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10
    // <<DITW16.00.00.40 DDR 22/12/2011 DIT-715 #187
    EmcsCommentLine.SETRANGE("Table ID",DATABASE::"Transfer Receipt Header");
    EmcsCommentLine.SETRANGE("Document Type",0);
    EmcsCommentLine.SETRANGE("Document No.","No.");
    EmcsCommentLine.DELETEALL;
    // >>DITW16.00.00.40 DDR DIT-715 #187

    #11..14
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
    // EmcsCommentLine: Record "EMCS Comment Line";
}

