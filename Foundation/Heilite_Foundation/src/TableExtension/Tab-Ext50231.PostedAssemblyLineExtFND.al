namespace GeneralLocal.GeneralLocal;

using Microsoft.Assembly.History;

tableextension 50231 PostedAssemblyLineExtFND extends "Posted Assembly Line"
{
    //HEI.01 #FDD-Unit Volume-Assembly Orders[FDD PID-750, PID-826, PID-76, PID-801, FDD DtW 017, IBM GAP DTW 76] IBM PATHAA02 01.04.26 
    //# "Unit Volume HL" added, data will flow from T900 via Transferfields
    fields
    {
        field(50001; "Unit Volume HL FND"; Decimal)
        {
            Caption = 'Unit Volume HL';
            Description = 'HEI.01';
        }
    }
}
