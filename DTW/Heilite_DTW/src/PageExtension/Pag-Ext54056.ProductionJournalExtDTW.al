namespace BC_DTWLocal.BC_DTWLocal;

using Microsoft.Manufacturing.Journal;
using Microsoft.Warehouse.Structure;
// BC Upgrade - RD03 added code to show Selected zone code related Bin List
// BC Upgrade - RD03 - Page level field mapping

pageextension 54056 "ProductionJournalExt_DTW" extends "Production Journal"
{//BC Upgrade Kamnay01  Created this page extension to add the field  for "Strength Value" in Production Journal page. This field is required for FDD-DTW 0011
    layout
    {
        addafter("Output Quantity")
        {
            field("Strength Value"; Rec."Strength Value FND")
            {
                ApplicationArea = All;
                Caption = 'EXt.[%w/w] Value_DTW';
                Editable = false;
                Visible = true;
            }
        }
        modify("Bin Code")
        {
            // ToolTipML = ENU = 'Specifies the bin that the produced item is posted to as output, and from where it can be taken to storage or cross-docked.', FRA = 'Spécifie l''emplacement dans lequel l''article produit est validé en tant que production et d''où il peut être prélevé ou transbordé.';
            // BC Upgrade - RD03 added code to show Selected zone code related Bin List -- >>
            trigger OnLookup(var Text: Text): Boolean
            var
                Bin: Record Bin;
            begin
                Rec.LookupBin();
            end;
            // BC Upgrade - RD03 added code to show Selected zone code related Bin List -- <<
        }
        // BC Upgrade - RD03 - Page level field mapping -- >>
        addafter("Bin Code")
        {
            field("Zone Code FND"; Rec."Zone Code FND")
            {
                ApplicationArea = all;
            }
        }
        // BC Upgrade - RD03 - Page level field mapping -- <<
    }
}
