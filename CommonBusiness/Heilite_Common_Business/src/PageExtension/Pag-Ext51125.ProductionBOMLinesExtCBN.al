pageextension 51125 ProductionBOMLinesExtCBN extends "Production BOM Lines"
{
    // version NAVW110.0,FINXL8.00,DITW110.00.08,HEI.03

    //     FINXL8.00.001 BSA 02/06/2015 #178: Added field "Cross Reference No."

    // DITW14.00.00.8 PROD: BrewIt & Quality
    // DITW15.00.00.38 PRODW14.00.00.08.17 24/01/2011 issue 1270 (DIT-715 issue 4) Missing fields
    //                                       "Principal Component","Special Component"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD_CHG2003754 IBM ISYED01 03.19.2019
    //  #added new fileds Zone and Bin to the page

    // HEI.02 CHG2236885 IBM PRASAA03 10.04.2024 Add error message to production BOM to avoid redundance
    //   # New validation added to field: No.

    // HEI.03 CHG2236885 IBM PRASAA03 22.04.2024 Add error message to production BOM to avoid redundance
    //   # New validation added to field: No.
    //*******************************************************************************************************
    //HEI.04 BC UPGRADE PATHAA02 12.03.26 FDD-DTW002 # Functionality- "Production jnl. flushing" 
    //Field "Production jnl. flushing" added.


    layout
    {
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the type of production BOM line.', FRA = 'Spécifie le type de ligne nomenclature production.';
        }
        modify("No.")
        {

            ToolTipML = ENU = 'Specifies the number depending on the type selected in the Type field.', FRA = 'Spécifie le numéro associé au type sélectionné dans le champ Type.';
            trigger OnAfterValidate()
            begin

                //CheckBOMLines();//HEI.02//HEI.03
            end;
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies a variant code if the component is a specific item variant.', FRA = 'Spécifie un code variante si le composant est une variante article spécifique.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the production BOM line.', FRA = 'Spécifie une description de la ligne nomenclature production.';
        }
        modify("Calculation Formula")
        {
            ToolTipML = ENU = 'Specifies how to calculate the Quantity field.', FRA = 'Spécifie la manière de calculer la valeur du champ Quantité.';
        }
        modify(Length)
        {
            ToolTipML = ENU = 'Specifies the length of the required item.', FRA = 'Spécifie la longueur de l''article requis.';
        }
        modify(Width)
        {
            ToolTipML = ENU = 'Specifies the width of the required item.', FRA = 'Spécifie la largeur de l''article requis.';
        }
        modify(Depth)
        {
            ToolTipML = ENU = 'Specifies the height of the required item.', FRA = 'Spécifie la hauteur de l''article requis.';
        }
        modify(Weight)
        {
            ToolTipML = ENU = 'Specifies the weight of the required item.', FRA = 'Indique le poids brut de l''article requis.';
        }
        modify("Quantity per")
        {
            ToolTipML = ENU = 'Specifies the quantity required to make an assembly item.', FRA = 'Indique la quantité nécessaire à la fabrication d''un article d''assemblage.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure that the production BOM line refers to.', FRA = 'Indique l''unité à laquelle la ligne nomenclature production fait référence.';
        }
        modify("Scrap %")
        {
            ToolTipML = ENU = 'Specifies the scrap percentage of the production BOM line.', FRA = 'Spécifie le pourcentage de rebut de la ligne nomenclature de production.';
        }
        modify("Routing Link Code")
        {
            ToolTipML = ENU = 'Specifies the routing link code.', FRA = 'Spécifie le code lien gamme.';
        }
        modify(Position)
        {
            ToolTipML = ENU = 'Specifies whether the components are to appear at a certain position in the BOM to represent a specific process.', FRA = 'Indique si les composants doivent apparaître à une certaine position dans la nomenclature pour représenter un processus spécifique.';
        }
        modify("Position 2")
        {
            ToolTipML = ENU = 'Specifies more exactly whether the component is to appear at a certain position in the BOM to represent a certain production process.', FRA = 'Spécifie plus précisément si le composant doit apparaître à une certaine position dans la nomenclature pour représenter un processus de production donné.';
        }
        modify("Position 3")
        {
            ToolTipML = ENU = 'Specifies even more exactly whether the component is to appear at a certain position in the BOM.', FRA = 'Spécifie encore plus précisément si le composant doit apparaître à une certaine position dans la nomenclature.';
        }
        modify("Lead-Time Offset")
        {
            ToolTipML = ENU = 'Specifies the total number of days required to produce this item.', FRA = 'Spécifie le nombre total de jours nécessaires à l''assemblage ou à la production de cet article.';
        }
        modify("Starting Date")
        {
            ToolTipML = ENU = 'Specifies the date from which this production BOM is valid.', FRA = 'Spécifie la date de début de validité de la nomenclature production.';
        }
        modify("Ending Date")
        {
            ToolTipML = ENU = 'Specifies the date from which this production BOM is no longer valid.', FRA = 'Spécifie la date de fin de validité de la nomenclature production.';
        }

        //Unsupported feature: CodeInsertion on ""No."(Control 4)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //CheckBOMLines();//HEI.02//HEI.03
        */
        //end;
        /* //Bc Upgrade YADAVM09 Drink it field Commented>>
        addafter(Type)
        {
            field("Principal Component"; Rec."Principal Component")
            {

                trigger OnValidate();
                begin
                    PrincipalComponentC1100183000O;
                end;
            }
        }
        
        addafter("No.")
        {
            field("Cross-Reference No."; "Cross-Reference No.")
            {
            }
        }
        */ //Bc Upgrade YADAVM09 Drink it Field Commented>>
        addafter("Ending Date")
        {
            /* //Bc Upgrade YADAVM09 Drink it Action Commented>>
            field(PrincipalComponentCtrl; "Principal Component")
            {
                Editable = false;
                Visible = false;
            }
            field("Special Component"; "Special Component")
            {
                Editable = false;
                Visible = false;
            }
            field("Production jnl. flushing"; "Production jnl. flushing")
            {
            }
            */ //Bc Upgrade YADAVM09 Drink it field Commented>>
            field("Production jnl. flushing"; Rec."Production jnl. flushing FND")
            {
                ApplicationArea = All;
                Description = 'HEI.04';
            }
            field("Zone Code"; Rec."Zone Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zone Code field.';
            }
            field("Bin Code"; Rec."Bin Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bin Code field.';
            }

        }
    }
    actions
    {
        modify("&Component")
        {
            CaptionML = ENU = '&Component', FRA = '&Composant';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify("Where-Used")
        {
            CaptionML = ENU = 'Where-Used', FRA = 'Cas d''emploi';
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CheckBOMLines();//HEI.03
    end;

    trigger OnModifyRecord(): Boolean
    begin
        CheckBOMLines();//HEI.03
    end;


    //Unsupported feature: CodeInsertion on "OnInsertRecord". Please convert manually.

    //trigger OnInsertRecord(BelowxRec : Boolean) : Boolean;
    //begin
    /*
    CheckBOMLines();//HEI.03
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnModifyRecord". Please convert manually.

    //trigger OnModifyRecord() : Boolean;
    //begin
    /*
    CheckBOMLines();//HEI.03
    */
    //end;

    local procedure PrincipalComponentC1100183000O();
    begin
        CurrPage.UPDATE();  // HUIT0001.2 001
    end;

    local procedure CheckBOMLines();
    var
        ProductionBOM: Record "Production BOM Header";
        TextL001: Label 'Same item is selected in Prod BOM for which Prod BOM is created';
        TextL002: Label 'Warning !!!!! Same item %1 is selected in line no %2 for which Prod BOM is created';
    begin
        //HEI.02>>
        if (Rec."No." <> '') and (Rec."Version Code" = '') and (Rec.Type = Rec.Type::Item) then begin
            ProductionBOM.RESET();
            ProductionBOM.SETCURRENTKEY("No.", "Linked Item No. FND");
            ProductionBOM.SETRANGE("No.", Rec."Production BOM No.");
            ProductionBOM.SETRANGE("Linked Item No. FND", Rec."No.");
            if ProductionBOM.FINDFIRST() then
                MESSAGE(TextL002, Rec."No.", Rec."Line No.");//HEI.03
            //MESSAGE(TextL001);//HEI.03
        end;
        //HEI.02<<
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

