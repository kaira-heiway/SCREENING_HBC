tableextension 50248 DimensionCodeBufferExtFND extends "Dimension Code Buffer"
{
    // POENAB02, 19.03.2026, Gap "BPM051-Create CAPEX budget", new object

    fields
    {
        field(50000; "Volume 1 FND"; Decimal)
        {
            Caption = 'Volume 1';
            DataClassification = ToBeClassified;
        }
        field(50001; "Volume 2 FND"; Decimal)
        {
            Caption = 'Volume 2';
            DataClassification = ToBeClassified;
        }
    }
}
