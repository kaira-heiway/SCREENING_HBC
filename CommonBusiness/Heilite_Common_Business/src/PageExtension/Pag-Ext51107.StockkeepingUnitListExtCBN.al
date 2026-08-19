pageextension 51107 StockKeepingUnitListExtCBN extends "Stockkeeping Unit List"
{
    // version NAVW110.0,DITW110.00.10,HEI.05
    //     HEI.01 FDD PRDGAP038 IBM COSTES02 07.08.2017 Added new fields : Quantity Quality Hold,Quantity Unrestricted (Pass),Quantity Blocked (Fail)
    // HEI.02 FDD-BA-PRGGAP01 IBM POSTOI01 12.07.2018
    //   # new global variable SPVisible
    //   # new global variable ItemCategoryCode
    //   # new code OnAfterGetRecord, OnOpenPage
    //   # show new fields
    //     -ItemCategoryCode code 20, Visible property changed
    //     -"Plant-Specific Material Status", Visible property changed
    // HEI.04 CHG2038071 #Defect 4552 IBM.GUNERE01 12.11.2019 # "Production BOM No.","Routing No." fields added
    // HEI.05 IBM BHATTA09 CHG2123219 21.11.2021
    //  # New Field "CCC Dimension Code" added
    //BC UPGRADE PATHAA02-25Sep25-Done
    //Actions not available and commented in BC-TimeLine & <Action1900000005>

    layout
    {
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the item number to which the SKU applies.', FRA = 'Spécifie le numéro de l''article auquel s''applique le point de stock.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies a variant code for the item.', FRA = 'Spécifie un code variante pour l''article.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location code (for example, the warehouse or distribution center) to which the SKU applies.', FRA = 'Spécifie le code magasin (par exemple, l''entrepôt ou le centre de distribution) auquel s''applique le point de stock.';
        }
        modify("Replenishment System")
        {
            ToolTipML = ENU = 'Specifies the type of supply order that is created by the planning system when the SKU needs to be replenished.', FRA = 'Spécifie le type de commande approvisionnement créée par le système de planification lorsque le point de stock doit être réapprovisionné.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the description from the Item Card.', FRA = 'Spécifie la description de la fiche article.';
        }
        modify(Inventory)
        {
            ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.', FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
        }
        modify("Reorder Point")
        {
            ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.', FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
        }
        modify("Reorder Quantity")
        {
            ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.', FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
        }
        modify("Maximum Inventory")
        {
            ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.', FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
        }
        modify("Assembly Policy")
        {
            ToolTipML = ENU = 'Specifies which default order flow is used to supply this SKU by assembly.', FRA = 'Spécifie le flux de commandes par défaut utilisé pour fournir ce point de stock par assemblage.';
        }
        addfirst(Control1)
        {
            field("SKU Type"; Rec."SKU Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Subtype Code field.';
            }
        }
        addafter(Description)
        {
            field("CCC Dim. Code"; Rec."CCC Dim. Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CCC Dim. Code field.';
            }
        }
        addafter("Assembly Policy")
        {
            //BC UPGRADE GUNREM01 >> added DIT field
            field(Blocked; Rec."Blocked FND")
            {
                ApplicationArea = all;
            } //BC UPGRADE GUNREM01 << added DIT field
            field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
            }
            field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
            }
            field("Qty. on Prod. Order"; Rec."Qty. on Prod. Order")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies how many item units have been planned for production, which is how many units are on outstanding production order lines.';
            }
            field("Qty. on Component Lines"; Rec."Qty. on Component Lines")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies how many item units are needed for production, which is how many units remain on outstanding production order component lists.';
            }
            field("Qty. in Transit"; Rec."Qty. in Transit")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity of the SKUs in transit. These items have been shipped, but not yet received.';
            }
            field("Qty. on Assembly Order"; Rec."Qty. on Assembly Order")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies how many units of the SKU are allocated to assembly orders, which is how many are listed on outstanding assembly order headers.';
            }
            field("Qty. on Asm. Component"; Rec."Qty. on Asm. Component")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies how many item units are allocated as assembly components, which is how many units are on outstanding assembly order lines.';
            }
            field("Unit Cost"; Rec."Unit Cost")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the cost of one unit of the item or resource on the line.';
            }
            field("Standard Cost"; Rec."Standard Cost")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the unit cost that is used as an estimation to be adjusted with variances later. It is typically used in assembly and production where costs can vary. Warning: If the SKU is supplied through production, then this field is not used when invoicing and adjusting the actual cost of the produced item. Instead, the Standard Cost field on the underlying item card is used, and any variances are calculated against the cost shares of that item.';
            }
            // field("Qty. on Sales Blanket Order"; Rec."Qty. on Sales Blanket Order")
            // {
            // } //BC UPGRADE PATHAA02-DIT
            field("Quantity Quality Hold"; Rec."Quantity Quality Hold FND")
            {
                Description = 'HEI.01';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quantity Quality Hold (Quarantine) field.';
            }
            field("Quantity Unrestricted (Pass)"; Rec."Quantity Unrestricted Pass FND")
            {
                Description = 'HEI.01';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quantity Unrestricted (Pass) field.';
            }
            field("Quantity Blocked (Fail)"; Rec."Quantity Blocked (Fail) FND")
            {
                Description = 'HEI.01';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quantity Blocked (Fail) field.';
            }
            field("Item Type"; Rec."Item Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Type field.';
            }
            field("Production BOM No."; Rec."Production BOM No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the production BOM that is used to manufacture this item.';
            }
            field("Routing No."; Rec."Routing No.")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the production route that contains the operations needed to manufacture this item.';
            }
            field("RPM Solution"; Rec."RPM Solution FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RPM Solution field.';
            }
            field("RPM Type"; Rec."RPM Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RPM Type field.';
            }
            field("Plant-Specific Material Status"; Rec."Plant Spec.Material Status FND")
            {
                Visible = SPVisible;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Plant-Specific Material Status field.';
            }
            field(ItemCategoryCode; ItemCategoryCode)
            {
                Caption = 'Item Category Code';
                Visible = SPVisible;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Category Code field.';
            }
            field("Available Inv. (Whse)"; Rec."Available Inv. (Whse) FND")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Available Inv. (Whse) field.';
            }
        }
    }
    actions
    {
        modify("&Item")
        {
            CaptionML = ENU = '&Item', FRA = 'Arti&cle';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("&Picture")
        {
            CaptionML = ENU = '&Picture', FRA = '&Image';
        }
        modify("&Units of Measure")
        {
            CaptionML = ENU = '&Units of Measure', FRA = '&Unités';
        }
        modify("Va&riants")
        {
            CaptionML = ENU = 'Va&riants', FRA = '&Variantes';
        }
        modify(Translations)
        {
            CaptionML = ENU = 'Translations', FRA = 'Traductions';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify("E&xtended Texts")
        {
            CaptionML = ENU = 'E&xtended Texts', FRA = '&Textes étendus';
        }
        modify("&SKU")
        {
            CaptionML = ENU = '&SKU', FRA = '&Pt de stock';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        modify("Entry Statistics")
        {
            CaptionML = ENU = 'Entry Statistics', FRA = 'Statistiques écritures';
        }
        modify("T&urnover")
        {
            CaptionML = ENU = 'T&urnover', FRA = '&Rotation';
        }
        modify("&Item Availability By")
        {
            CaptionML = ENU = '&Item Availability By', FRA = '&Disponibilité article par';
        }
        modify("<Action5>")
        {
            CaptionML = ENU = 'Event', FRA = 'Événement';
        }
        modify(Period)
        {
            CaptionML = ENU = 'Period', FRA = 'Période';
        }
        modify("Bill of Material")
        {
            CaptionML = ENU = 'Bill of Material', FRA = 'Nomenclature';
        }
        // modify(Timeline)
        // {
        //     CaptionML = ENU = 'Timeline', FRA = 'Chronologie';
        // }//BC UPGRADE PATHAA02
        modify(Action1102601046)
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(Warehouse)
        {
            CaptionML = ENU = 'Warehouse', FRA = 'Entrepôt';
        }
        modify("&Bin Contents")
        {
            CaptionML = ENU = '&Bin Contents', FRA = 'C&ontenu emplacement';
        }
        modify(History)
        {
            CaptionML = ENU = 'History', FRA = 'Historique';
        }
        modify("E&ntries")
        {
            CaptionML = ENU = 'E&ntries', FRA = 'É&critures';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
        }
        modify("&Reservation Entries")
        {
            CaptionML = ENU = '&Reservation Entries', FRA = 'Écritures &réservation';
        }
        modify("&Phys. Inventory Ledger Entries")
        {
            CaptionML = ENU = '&Phys. Inventory Ledger Entries', FRA = 'Écritures comptables &inventaire';
        }
        modify("&Value Entries")
        {
            CaptionML = ENU = '&Value Entries', FRA = 'Écritures &valeur';
        }
        modify("Item &Tracking Entries")
        {
            CaptionML = ENU = 'Item &Tracking Entries', FRA = 'Écritures &traçabilité';
        }
        // modify("<Action1900000005>")
        // {
        //     CaptionML = ENU = '<Action1900000005>', FRA = '<Action1900000005>';
        // } //BC UPGRADE PATHAA02 
        modify("Inventory - List")
        {
            CaptionML = ENU = 'Inventory - List', FRA = 'Stocks : Liste des articles';
        }
        modify("Inventory Availability")
        {
            CaptionML = ENU = 'Inventory Availability', FRA = 'Disponibilité articles';
        }
        modify("Inventory - Availability Plan")
        {
            CaptionML = ENU = 'Inventory - Availability Plan', FRA = 'Stocks : Échéancier des dispo.';
        }
        modify("Item/Vendor Catalog")
        {
            CaptionML = ENU = 'Item/Vendor Catalog', FRA = 'Articles : Catalogue fourn.';
        }
        modify(New)
        {
            CaptionML = ENU = 'New', FRA = 'Nouveau';
        }
        modify("New Item")
        {
            CaptionML = ENU = 'New Item', FRA = 'Nouvel article';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("C&alculate Counting Period")
        {
            CaptionML = ENU = 'C&alculate Counting Period', FRA = 'C&alculer période d''inventaire';
        }
    }

    var
        SPVisible: Boolean;
        ItemCategoryCode: Code[20];

    trigger OnAfterGetRecord();
    var
        Item: Record Item;
    begin
        //HEI.02+
        if Item.GET(Rec."Item No.") then
            ItemCategoryCode := Item."Item Category Code";
        //HEI.02-
    end;

    trigger OnOpenPage();
    var
        GeneralOpCoSetup: Record "General OpCo Setup FND";
    begin
        //HEI.02+
        if GeneralOpCoSetup.GET() then
            SPVisible := GeneralOpCoSetup."Spare Part Consumption";
        //HEI.02-
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

