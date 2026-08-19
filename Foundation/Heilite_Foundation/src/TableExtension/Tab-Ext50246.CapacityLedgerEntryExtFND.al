namespace BC_DTWLocal.BC_DTWLocal;

using Microsoft.Manufacturing.Capacity;

tableextension 50246 CapacityLedgerEntryExtFND extends "Capacity Ledger Entry"
{//BC Upgrade Kamnay01  Created this table  extension to add the field . This field is required for FDD-DTW-018
    fields
    {
        field(54000; "Output quantity (HL) FND"; Decimal)
        {
            Caption = 'Output quantity (HL)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 5;
        }
        field(54001; "Unit Volume HL FND"; Decimal)
        {
            Caption = 'Unit Volume HL';
            DataClassification = ToBeClassified;
            DecimalPlaces = 5;
        }
        field(54002; "Quantity (HL) FND"; Decimal)
        {
            Caption = 'Quantity (HL)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 5;
        }

    }
}
