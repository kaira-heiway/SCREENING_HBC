pageextension 51096 BinsExtCBN extends Bins
{
    // FINXL8.00.001 BSA 29/06/2015 #177: Added new Fields : "Customer No.", "Customer Name", "Ship-to Code"

    // DITW15.00.00.37 PRODW14.00.00.16 DDR 23/06/2010 issue 1151 Added field "Allow Auto.Create Quality Test"
    // DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457 Added fields "Work Order Mandatory"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // DITW110.00.10 VSC 26/05/2017 NRQ#27479 Merge back field: Barcode
    // HEI.01 FDD PRDGAP004-  AUtomatic assignment of Batch Number: IBM.NAIKH01 , 19.09.2017
    //   # Added 2 new fileds "Batch production resource" and "Batch sequential number"

    // HEI.02 FDD-PRDGAP057 - Field Gross capacity Bin , 24.04.2018 IBM.NAIKH01
    //   # Added new field 50002 - "Gross capacity" and modified the properties
    // HEI.03 FDD-LB IBM NASTAA02 15.10.2018 # Item Availability excluding Blocked Stock
    //   # New Field added: Unavailable Stock
    // HEI.04 CHG2060990 IBM BULIMC01  15.06.2020 #new field added: "Ccc Code"

    layout
    {
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location from which you opened the Bins window.', FRA = 'Spécifie le magasin à partir duquel vous avez ouvert la fenêtre Emplacements.';
        }
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies a code that uniquely describes the bin.', FRA = 'Spécifie un code qui décrit uniquement l''emplacement.';
        }
        modify("Zone Code")
        {
            ToolTipML = ENU = 'Specifies the code of the zone in which the bin is located.', FRA = 'Spécifie le code de la zone dans laquelle est situé l''emplacement.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the bin.', FRA = 'Spécifie la description de l''emplacement.';
        }
        modify("Bin Type Code")
        {
            ToolTipML = ENU = 'Specifies the code of the bin type that applies to the bin.', FRA = 'Spécifie le code du type d''emplacement applicable à l''emplacement.';
        }
        modify("Warehouse Class Code")
        {
            ToolTipML = ENU = 'Specifies the code of the warehouse class that applies to the bin.', FRA = 'Spécifie le code classe entrepôt applicable à l''emplacement.';
        }
        modify("Block Movement")
        {
            ToolTipML = ENU = 'Specifies how the movement of an item, or bin content, into or out of this bin, is blocked.', FRA = 'Spécifie la manière dont le transfert d''un article donné, ou le contenu de l''emplacement, dans ou en dehors de cet emplacement, est bloqué.';
        }
        modify("Special Equipment Code")
        {
            ToolTipML = ENU = 'Specifies the code of the equipment needed when working in the bin.', FRA = 'Spécifie le code de l''équipement requis lors des travaux réalisés à l''emplacement.';
        }
        modify("Bin Ranking")
        {
            ToolTipML = ENU = 'Specifies the ranking of the bin. Items in the highest-ranking bins (with the highest number in the field) will be picked first.', FRA = 'Spécifie le niveau de priorité de l''emplacement. Les articles figurant dans les emplacements ayant le niveau de priorité le plus élevé (emplacements dont le numéro est le plus grand dans le champ) sont par conséquent prélevés en premier.';
        }
        modify("Maximum Cubage")
        {
            ToolTipML = ENU = 'Specifies the maximum cubage (volume) that the bin can hold.', FRA = 'Spécifie le volume maximum que l''emplacement peut contenir.';
        }
        modify("Maximum Weight")
        {
            ToolTipML = ENU = 'Specifies the maximum weight that this bin can hold.', FRA = 'Spécifie le poids maximum que cet emplacement peut contenir.';
        }
        modify(Empty)
        {
            ToolTipML = ENU = 'Specifies that the bin Specifies no items.', FRA = 'Spécifie que l''emplacement ne contient aucun article.';
        }
        modify("Cross-Dock Bin")
        {
            ToolTipML = ENU = 'Specifies if the bin is considered a cross-dock bin.', FRA = 'Indique si l''emplacement est considéré comme étant un emplacement de transbordement.';
        }
        modify(Dedicated)
        {
            ToolTipML = ENU = 'Specifies that quantities in the bin are protected from being picked for other demands.', FRA = 'Indique que les quantités de l''emplacement sont protégées des prélèvements d''autres demandes.';
        }
        //BC Upgrade Kamnay01>> DITW Fields
        // addafter("Cross-Dock Bin")
        // {
        //     field("Skip Auto.Create Quality Test"; "Skip Auto.Create Quality Test")
        //     {
        //         Visible = false;
        //     }
        //     field("Work Order Mandatory"; Rec."Work Order Mandatory")
        //     {
        //         Visible = false;
        //     }
        // }
        //BC Upgrade Kamnay01<< DITW Fields
        addafter(Dedicated)
        {
            //BC Upgrade Kamnay01>> DITW Fields
            // field("Customer No."; "Customer No.")
            // {
            // }
            // field("Customer Name"; "Customer Name")
            // {
            // }
            // field("Ship-to Code"; "Ship-to Code")
            // {
            // }
            // field(Barcode; Barcode)
            // {
            //     Description = 'NRQ#27479';
            // }
            //BC Upgrade Kamnay01<< DITW Fields
            field("Batch Production Resource"; Rec."Batch Production Resource FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Batch Production Resource field.';
                // BC Upgrade SHUKLP03 <<                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ToolTip = 'Specifies the value of the Batch Production Resource field.';

            }
            field("Batch Sequential Number"; Rec."Batch Sequential Number FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Batch Sequential Number field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Batch Sequential Number field.';

            }
            field("Gross Capacity"; Rec."Gross Capacity FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Gross Capacity field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Gross Capacity field.';

            }
            field("Unavailable Stock"; Rec."Unavailable Stock FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Unavailable Stock field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Unavailable Stock field.';

            }
            field("Ccc Code"; Rec."Ccc Code FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Ccc Code field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Ccc Code field.';

            }
        }
    }
    actions
    {
        modify("&Bin")
        {
            CaptionML = ENU = '&Bin', FRA = '&Emplacement';
        }
        modify("&Contents")
        {
            CaptionML = ENU = '&Contents', FRA = '&Contenu';
        }
    }


    //Unsupported feature: PropertyModification on "Text004(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=Do you want to update the bin contents?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=Do you want to update the bin contents?;FRA=Souhaitez-vous mettre à jour le contenu emplacement ?;
    //Variable type has not been exported.

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

