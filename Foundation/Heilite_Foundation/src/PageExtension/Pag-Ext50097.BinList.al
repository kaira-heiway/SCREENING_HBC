pageextension 50097 BinListExt extends "Bin List"
{
    // version NAVW110.0,DITW110.00.08,HEI.01
    //     DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457 Added fields "Skip Auto.Create Quality Test","Work Order Mandatory"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD PRDGAP004-  AUtomatic assignment of Batch Number: IBM.NAIKH01 , 19.09.2017
    //   # Added 2 new fileds "Batch production resource" and "Batch sequential number"
    // HEI.02 FDDPRDGAP055 ISBM ISYED01 11.05.2018
    //   # NEW FUNCTION FOR Bin


    layout
    {
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location from which you opened the Bins window.', FRA = 'Spécifie le magasin à partir duquel vous avez ouvert la fenêtre Emplacements.';
        }
        modify("Zone Code")
        {
            ToolTipML = ENU = 'Specifies the code of the zone in which the bin is located.', FRA = 'Spécifie le code de la zone dans laquelle est situé l''emplacement.';
        }
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies a code that uniquely describes the bin.', FRA = 'Spécifie un code qui décrit uniquement l''emplacement.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the bin.', FRA = 'Spécifie la description de l''emplacement.';
        }
        modify(Empty)
        {
            ToolTipML = ENU = 'Specifies that the bin Specifies no items.', FRA = 'Spécifie que l''emplacement ne contient aucun article.';
        }
        modify(Default)
        {
            ToolTipML = ENU = 'Specifies if the bin is the default bin for an item.', FRA = 'Indique si l''emplacement correspond à l''emplacement par défaut d''un article.';
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
        modify(Dedicated)
        {
            ToolTipML = ENU = 'Specifies that quantities in the bin are protected from being picked for other demands.', FRA = 'Indique que les quantités de l''emplacement sont protégées des prélèvements d''autres demandes.';
        }
        //BC Upgrade Kamnay01>> DITW Fields
        // addafter("Maximum Weight")
        // {
        //     field("Skip Auto.Create Quality Test";"Skip Auto.Create Quality Test")
        //     {
        //         Visible = false;
        //     }
        //     field("Work Order Mandatory";"Work Order Mandatory")
        //     {
        //         Visible = false;
        //     }
        // }
        //BC Upgrade Kamnay01<< DITW Fields
        addafter(Dedicated)
        {
            field("Batch Production Resource"; Rec."Batch Production Resource FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Batch Production Resource field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Batch Production Resource field.';

            }
            field("Batch Sequential Number"; Rec."Batch Sequential Number FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Batch Sequential Number field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Batch Sequential Number field.';

            }
            field("Ccc Code FND"; Rec."Ccc Code FND")
            {
                ApplicationArea = All;
                //BC UPGRADE PATHAA02
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
    //BC Upgrade Kamnay01>>
    procedure GetSelectionFilter(): Text;
    var
        Bin: Record Bin;
        CU_HeinekenBCUpgrade: Codeunit "Heineken BC Upgrade";
    begin
        //HEI.02>>
        CurrPage.SETSELECTIONFILTER(Bin);
        exit(CU_HeinekenBCUpgrade.GetSelectionFilterForBin(Bin));
        //HEI.02<<
    end;
    //BC Upgrade Kamnay01<<
    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

