namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Sales.History;

tableextension 50251 SalesCrMemoLineFNDFND extends "Sales Cr.Memo Line"
{
    // HEI.05 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
    // # New Field created: 50018 - Suppress POS Interface
    // HEI.07 FDD-HT709 IBM NASTAA02 24.07.2019 # Ethiopia Fiscal No in PSIL
    // # New Field created: 50019 - Maraki Fiscal No

    // BC Upgrade PATELP08>>
    // Changed name of table from "EBM Log" to "EBM Log FND"
    // BC Upgrade PATELP08<<


    // BC Upgrade MISHRS14 >>
    // Changed table extension name to "SalesCrMemoLine_InterfaceFND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    fields
    {
        field(50018; "Suppress POS Interface FND"; Boolean)
        {
            Caption = 'Suppress POS Interface';
            Description = 'HEI.05';
            Editable = false;
        }
        field(50019; "Maraki Fiscal No. FND"; Code[30])
        {
            CalcFormula = Lookup("EBM Log FND"."Maraki Fiscal No." WHERE("Document Type" = FILTER("Credit Memo"),
                                                                      "Document No." = FIELD("Document No.")));
            Caption = 'Maraki Fiscal No.';
            Description = 'HEI.07';
            Editable = false;
            FieldClass = FlowField;
        }

    }
}
