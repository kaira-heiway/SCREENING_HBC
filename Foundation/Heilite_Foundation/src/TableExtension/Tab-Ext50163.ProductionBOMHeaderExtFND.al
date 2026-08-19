tableextension 50163 ProductionBOMHeaderExtFND extends "Production BOM Header"
{
    // version NAVW110.0,DITW110.00.09,HEI.01

    // HEI.01 FDD-GAPID043 IBM LAZARE02 01.09.2017 # New fields: Linked Item No., Linked SKU

    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Description 2")
        {
            CaptionML = ENU = 'Description 2', FRA = 'Désignation 2';
        }
        modify("Search Name")
        {
            CaptionML = ENU = 'Search Name', FRA = 'Nom de recherche';
        }
        modify("Unit of Measure Code")
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify("Low-Level Code")
        {
            CaptionML = ENU = 'Low-Level Code', FRA = 'Code plus bas niveau';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify("Creation Date")
        {
            CaptionML = ENU = 'Creation Date', FRA = 'Date création';
        }
        modify("Last Date Modified")
        {
            CaptionML = ENU = 'Last Date Modified', FRA = 'Date dern. modification';
        }
        modify(Status)
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
            //OptionCaptionML = ENU = 'New,Certified,Under Development,Closed', FRA = 'Création en cours,Validée,Modification en cours,Clôturée';
        }
        modify("Version Nos.")
        {
            CaptionML = ENU = 'Version Nos.', FRA = 'N° version';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        field(50000; "Linked Item No. FND"; Code[20])
        {
            Caption = 'Linked Item No.';
            Description = 'HEI.01';
            TableRelation = Item;
        }
        field(50001; "Linked SKU FND"; Code[10])
        {
            Caption = 'Linked SKU';
            Description = 'HEI.01';
            TableRelation = "Stockkeeping Unit"."Location Code" where("Item No." = FIELD("Linked Item No. FND"));

            //BC UPGRADE PATHAA02 StdCost-FDD DTW 16>>
            trigger OnValidate()
            var
                item: Record Item;
            begin
                if Rec."Linked SKU FND" <> xRec."Linked SKU FND" then begin
                    if item.Get(Rec."Linked Item No. FND") then begin
                        item."Production BOM No." := Rec."No.";
                        item."New Location Code FND" := Rec."Linked SKU FND";
                        item."Replenishment System" := item."Replenishment System"::"Prod. Order";
                        item.Modify();
                    end;
                end;
            end;
            //BC UPGRADE PATHAA02 StdCost-FDD DTW 16<<
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=This Production BOM is being used on Items.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=This Production BOM is being used on Items.;FRA=Cette nomenclature est utilisée dans des articles.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=All versions attached to the BOM will be closed. Close BOM?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=All versions attached to the BOM will be closed. Close BOM?;FRA=Toutes les versions rattachées à la nomenclature vont être clôturées. Souhaitez-vous clôturer la nomenclature ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=You cannot rename the %1 when %2 is %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=You cannot rename the %1 when %2 is %3.;FRA=Vous ne pouvez pas renommer l'enregistrement %1 lorsque la valeur %2 est %3.;
    //Variable type has not been exported.
}

