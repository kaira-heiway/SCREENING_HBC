namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Manufacturing.Document;

tableextension 58034 "ProductionOrderIntefExt_INT" extends "Production Order"
{
    fields
    {
        field(50003; "Prod. Order Interface INT"; Code[20])
        {
            Caption = 'Prod. Order Interface';
            Description = 'HEI.13';
            TableRelation = "Interface Setup INT";  // BC Upgrade NANDIS03 - Blocked as "Interface Setup" table moved in Interface Extension 
        }
        field(50004; "Prod. Order Output Interf INT"; Code[20])
        {
            Caption = 'Prod. Order Output Interface';
            Description = 'HEI.13';
            TableRelation = "Interface Setup INT";  // BC Upgrade NANDIS03 - Blocked as "Interface Setup" table moved in Interface Extension 
        }
        field(50005; "Parked for LogoPak INT"; Boolean)
        {
            Caption = 'Parked for LogoPak';
            Description = 'HEI.13';
        }
        field(50006; "Parked from LogoPak INT"; Boolean)
        {
            Caption = 'Parked from LogoPak';
            Description = 'HEI.13';
        }
        field(50007; "Posted from LogoPak INT"; Boolean)
        {
            Caption = 'Posted from LogoPak';
            Description = 'HEI.13';
        }

    }
}
