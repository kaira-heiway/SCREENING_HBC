tableextension 50104 RegisterWhseActivityHdrExtFND extends "Registered Whse. Activity Hdr."
{
    // version NAVW110.0,HEI.04

    //BC Upgrade PATHAA02
    //Truck Code-->Table Relation is DIT-Whse. Shipping Truck-Commented
    //Driver Code-->Table Relation is DIT-Whse. Shipping Driver-Commented
    //HEI.04-Astro fields, check if this needs to be retained or commented

    fields
    {
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            //OptionCaptionML = ENU = ' ,Put-away,Pick,Movement', FRA = ' ,Rangement,Prélèvement,Mouvement';
        }
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Assigned User ID")
        {

            //Unsupported feature: Change TableRelation on ""Assigned User ID"(Field 4)". Please convert manually.

            CaptionML = ENU = 'Assigned User ID', FRA = 'Code utilisateur affecté';
        }
        modify("Assignment Date")
        {
            CaptionML = ENU = 'Assignment Date', FRA = 'Date affectation';
        }
        modify("Assignment Time")
        {
            CaptionML = ENU = 'Assignment Time', FRA = 'Heure affectation';
        }
        modify("Sorting Method")
        {
            CaptionML = ENU = 'Sorting Method', FRA = 'Méthode de tri';
            //OptionCaptionML = ENU = ' ,Item,Document,Shelf or Bin,Due Date,Ship-To,Bin Ranking,Action Type', FRA = ' ,Article,Document,Emplacement,Délai,Destinataire,Priorité emplacement,Type action';
        }
        modify("Registering Date")
        {
            CaptionML = ENU = 'Registering Date', FRA = 'Date enregistrement';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify(Comment)
        {

            //Unsupported feature: Change CalcFormula on "Comment(Field 10)". Please convert manually.

            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify("Whse. Activity No.")
        {
            CaptionML = ENU = 'Whse. Activity No.', FRA = 'N° activité entrepôt';
        }
        modify("No. Printed")
        {
            CaptionML = ENU = 'No. Printed', FRA = 'Nbre impressions';
        }
        field(50000; "Zone transfer FND"; Boolean)
        {
            caption = 'Zone transfer';
            Description = 'HEI.01 PRDGAP024';
            Editable = false;
        }
        field(50001; "From Zone Code FND"; Code[10])
        {
            caption = 'From Zone Code';
            Description = 'HEI.01 PRDGAP024';
            Editable = false;
            TableRelation = Zone.Code where("Location Code" = FIELD("Location Code"));
        }
        field(50002; "To Zone Code FND"; Code[10])
        {
            caption = 'To Zone Code';
            Description = 'HEI.01 PRDGAP024';
            Editable = false;
            TableRelation = Zone.Code where("Location Code" = FIELD("Location Code"));
        }
        field(50003; "In-Transit Zone FND"; Code[10])
        {
            caption = 'In-Transit Zone';
            Description = 'HEI.01 PRDGAP024';
            Editable = false;
            TableRelation = Zone.Code where("Location Code" = FIELD("Location Code"),
                                             "Use As In-Transit FND" = FILTER(true));
        }
        field(50004; "In-Transit Bin FND"; Code[20])
        {
            caption = 'In-Transit Bin';
            Description = 'HEI.01 PRDGAP024';
            Editable = false;
            TableRelation = Bin.Code where("Location Code" = FIELD("Location Code"),
                                            "Zone Code" = FIELD("In-Transit Zone FND"));
        }
        field(50005; "Transfer Type FND"; Option)
        {
            caption = 'Transfer Type';
            Description = 'HEI.01 PRDGAP024';
            Editable = false;
            OptionMembers = " ",Shipment,Receipt;
        }
        field(50010; "External Document No. FND"; Code[35])
        {
            Caption = 'External Document No.';
            Description = 'HEI.04';
        }
        field(50011; "External Document No.2 FND"; Code[35])
        {
            Caption = 'External Document No.2';
            Description = 'HEI.04';
        }
        field(50012; "Shipping Agent Code FND"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            CaptionML = ENU = 'Shipping Agent Code',
                        FRA = 'Code transporteur';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            Editable = false;
            TableRelation = "Shipping Agent";
        }
        field(50013; "Shipping Agent Service Cod FND"; Code[10])
        {
            CaptionML = ENU = 'Shipping Agent Service Code',
                        FRA = 'Code prestation transporteur';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            Editable = false;
            TableRelation = "Shipping Agent Services".Code where("Shipping Agent Code" = FIELD("Shipping Agent Code FND"));
        }
        field(50014; "Truck Code FND"; Code[10])
        {
            CaptionML = ENU = 'Truck Code',
                        FRA = 'Code camion';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            Editable = false;
            //TableRelation = "Whse. Shipping Truck"; //BC Upgrade PATHAA02-DIT

            trigger OnLookup();
            var
                TruckCodeText: Text[10];
            begin
            end;
        }
        field(50015; "Driver Code FND"; Code[10])
        {
            CaptionML = ENU = 'Driver Code',
                        FRA = 'Code chauffeur';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            Editable = false;
            //TableRelation = "Whse. Shipping Driver"; //BC Upgrade PATHAA02-DIT
        }
        field(50016; "Truck Movement FND"; Boolean)
        {
            caption = 'Truck Movement';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            Editable = false;
        }
        field(50100; "Transfer From Bin FND"; Code[20])
        {
            Caption = 'Transferred From Bin';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50101; "Transfer To Bin FND"; Code[20])
        {
            Caption = 'Transferred To Bin';
            Description = 'HEI.02';
            Editable = false;
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

